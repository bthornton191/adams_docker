from contextlib import contextmanager
import shutil
import subprocess
from pathlib import Path

import logging
from logging.handlers import WatchedFileHandler
import argparse

LOG = logging.getLogger(__name__)


def setup_logging():
    handler = WatchedFileHandler(f'{Path(__file__).stem}.log')
    formatter = logging.Formatter('%(asctime)s:%(levelname)s:%(message)s', '%Y-%m-%d %H:%M:%S')
    handler.setFormatter(formatter)
    root = logging.getLogger()
    root.setLevel('INFO')
    # Remove existing handlers for this file name, if any
    for old_handler in [h for h in root.handlers if (isinstance(h, WatchedFileHandler)
                                                     and h.baseFilename == handler.baseFilename)]:
        root.handlers.remove(old_handler)
    root.addHandler(handler)

    stream_handler = logging.StreamHandler()
    stream_handler.setFormatter(formatter)
    root.addHandler(stream_handler)


def build(docker_file: Path, install_script_dir: Path, installer_dir: Path, push: bool = False):
    for install_script in install_script_dir.glob('*.iss'):
        ver = install_script.stem
        installer = installer_dir / f'{ver}.exe'

        if not installer.exists():
            LOG.error(f'Installer not found: {ver}.exe')
            continue
        
        with temp_installer(installer, docker_file.parent) as instlr:
        
            cmd = ['docker', 'build', 
                   '--build-arg', f'ADAMS_INSTALLER={instlr.relative_to(docker_file.parent)}',
                   '--build-arg', f'ADAMS_SCRIPT={install_script.relative_to(docker_file.parent)}',
                   '--tag', f'bthornton191/adams:{ver}',
                   '.']

            LOG.info('----------------------------------------------------------------------------')        
            LOG.info(f'Building bthornton191/adams:{ver}')
            LOG.info('----------------------------------------------------------------------------')        
            LOG.info(f'Running: {" ".join(cmd)}')
            
            with subprocess.Popen(cmd, 
                                  stdout=subprocess.PIPE, 
                                  stderr=subprocess.PIPE, 
                                  cwd=docker_file.parent,
                                  text=True) as proc:
                for line in proc.stdout:
                    LOG.info(' DOCKER BUILD >>> ' + line.strip())
                
                for line in proc.stderr:
                    LOG.error(' DOCKER BUILD >>> ' + line.strip())

            if push and proc.returncode == 0:
                cmd = ['docker', 'push', f'bthornton191/adams:{ver}']
                LOG.info('----------------------------------------------------------------------------')        
                LOG.info(f'Pushing bthornton191/adams:{ver}')
                LOG.info('----------------------------------------------------------------------------')        
                LOG.info(f'Running: {" ".join(cmd)}')
                
                with subprocess.Popen(cmd, 
                                      stdout=subprocess.PIPE, 
                                      stderr=subprocess.PIPE, 
                                      text=True) as proc:
                    for line in proc.stdout:
                        LOG.info(' DOCKER PUSH >>> ' + line.strip())
                    
                    for line in proc.stderr:
                        LOG.error(' DOCKER PUSH >>> ' + line.strip())


@contextmanager
def temp_installer(installer: Path, cwd: Path):
    shutil.copyfile(installer, cwd / installer.name)

    try:
        yield cwd / installer.name

    finally:
        (cwd / installer.name).unlink()


if __name__ == '__main__':
    setup_logging()
    parser = argparse.ArgumentParser()
    parser.add_argument('docker_file', type=Path)
    parser.add_argument('install_script_dir', type=Path)
    parser.add_argument('installer_dir', type=Path)
    parser.add_argument('--push', action='store_true')
    args = parser.parse_args()
    build(args.docker_file, args.install_script_dir, args.installer_dir, args.push)
    
