FROM alerman/devbox
USER root
COPY ./sshd_config /etc/ssh/sshd_config
RUN useradd -d /opt/accumulo -p "accumulo" accumulo
RUN usermod -U accumulo
ADD ./accumulo.tgz /opt/accumulo
RUN ln -s /opt/accumulo/accumulo-1.9.2 /opt/accumulo/current
COPY ./conf/* /opt/accumulo/current/conf/
RUN chown -R accumulo:accumulo /opt/accumulo



RUN mkdir /srv/vfs-cache && chmod 777 /srv/vfs-cache
RUN mkdir /srv/logs && chown accumulo:accumulo /srv/logs

RUN ssh-keygen -A
USER accumulo
RUN mkdir ~/.ssh
RUN ssh-keygen -f ~/.ssh/id_rsa -q -N ""
RUN cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
RUN chmod 700 ~/.ssh
RUN chmod 644 ~/.ssh/id_rsa.pub
RUN chmod 640 ~/.ssh/authorized_keys
RUN chmod 600 ~/.ssh/id_rsa
RUN echo "* " > ~/.ssh/known_hosts

USER root
RUN cat /etc/ssh/ssh_host_ecdsa_key.pub >> /opt/accumulo/.ssh/known_hosts
COPY ./init.sh /opt/accumulo/current/bin/init.sh
RUN chown accumulo:accumulo /opt/accumulo/current/bin/init.sh
RUN chmod 755 /opt/accumulo/current/bin/init.sh
COPY ./accumulo-user.sh /opt/accumulo/current/bin/accumulo-user.sh
RUN chown accumulo:accumulo /opt/accumulo/current/bin/accumulo-user.sh
RUN chmod 755 /opt/accumulo/current/bin/accumulo-user.sh

CMD ["/etc/service/sshd/run"]
