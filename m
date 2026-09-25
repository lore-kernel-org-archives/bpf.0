Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBBC15350B;
	Fri, 25 Sep 2026 00:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790294536; cv=none; b=KNa/NQaHAFrY3WjMEkVCwoClAGMheJ5KIEEClQoF9LmrZrHiqa1qcAHHr8E+RQWB0KRtmvUZAW4rVtMe5Ea8PB3BXKZiY7YNSyCl+toHkjHdoGW9wss258S8kosrvD5PnXsLHez8sZ1WTwK1HdJb+YSiRY/LukZvy23z3qYAjTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790294536; c=relaxed/simple;
	bh=suc9r+DPsKoEEqweR/toMLo+8dxHcg9SYz+2uN0nFGA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uix+NEYx0Ijva+wY2dcrswPmK8VUJyD/wVxcpGSzqW8/Sd3jwNlryobCGoDKSNiIQSTbRoRyNIJbk+L7xoDuYxhMjd1xzD9MQH3N1qsd0wQ05lpa6ZWKrr1ot6URxqAdHNqxofKsRgMpI7hm2wowRs/uLpqJjU2KMqhhh0pzNqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXn/w7/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXn/w7/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E822A1F00893;
	Fri, 25 Sep 2026 00:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790294533;
	bh=Qfbu8rIc4Ps80zjqsQxZCDAJwc48mfeSFm9ZTuPt6ZY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VXn/w7/TkKCoYVrH07nlAbAf5b4CB5MQmpBzGP4A4cva23O6zLxL4j+S9JY3PhaLD
	 lY8Z8mSzlhZEEZ34ozbasXVzsNkCU1zwLzoIbvlTEuyai+VrxgFx6EyDqCnOo/Q92V
	 h+lf5jpGMQ+DB3b7//qVhPMDE5/qi40CE0WTHKsnMVhu+LrQmj6G5LnFXXoIv2/zoO
	 /JbwsvdFKBZ7/HfbP03+VmakTuChCifomEfc8h29xrK/9/e/BvJfBHOdogNuh3Lej5
	 Wj/6nrEgcDAcUbWOqQ8o7Iw6JMUdxMqEwMB/CLmikXBvSOSJv9VJZ4AqoUXarYLBBD
	 YW4oBy1fMx2lA==
Subject: Re: [PATCH net-next v4 2/2] selftests/net: Move XDP feature test to
 driver framework
From: netdev-bot+sashiko@kernel.org
To: bochaolucky@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org,
 eddyz87@gmail.com, ihor.solodrai@linux.dev, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, shuah@kernel.org,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 alexis.lothore@bootlin.com, lorenzo@kernel.org, tiozhang@didiglobal.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 25 Sep 2026 00:02:11 +0000
Message-ID: <179029453150.2160803.15993342000950211463@kernel.org>
In-Reply-To: <20260921-xdp-features-v4-send-v4-2-a0d4ec392cb7@gmail.com>
References: <20260921-xdp-features-v4-send-v4-2-a0d4ec392cb7@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 11 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 10 (1) · Low: 1 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] `TEST_GEN_PROGS += xdp_features` in
  tools/testing/selftests/drivers/net/hw/Makefile registers the…
- [Medium] The new skeleton rule adds an unguarded host-tool dependency
  on bpftool (`BPFTOOL ?= bpftool`, `$(BPFTOOL) gen skeleton $< name…
- [Medium] Now that the test targets real NICs in drivers/net/hw, devices
  or drivers without native (DRV mode) XDP support make the helper…
- [Medium] The deleted shell harness explicitly configured both endpoints
  before running the helper (`ethtool -K v1 gro on`, `ethtool -K v1 tx-…
- [Medium] dut_run() signals readiness with ksft_ready()
  (xdp_features.c:430) and then immediately blocks in a single accept()…
- [Medium] The test violates the net-driver framework contract for the
  remote endpoint.
- [Medium] run_feature() passes the framework-configured addresses
  (cfg.addr_v / cfg.remote_addr_v, i.e. LOCAL_V4/V6 and REMOTE_V4/V6…
- [Medium] dut_run() reaches `end_thread: pthread_join(dut_thread, NULL)`
  (xdp_features.c:542) with dut_thread still 0 whenever the echo thread…
- [Medium] The new Python harness has no cleanup that guarantees the XDP
  programs are detached from the local (cfg.ifname) and remote…
- [Medium] A failed XDP attachment still detaches whatever native-mode
  program is installed, so the test can silently remove a program it…
- [Low] The patch folds undocumented correctness fixes for the existing
  helper into a commit described as a move: dut_run() now initializes…

Pre-existing issues:
- [Medium] The privileged DUT process exposes its control protocol on all
  addresses and accepts commands from the first unauthenticated peer:…
- [Low] The control protocol assumes each send()/recv() transfers exactly
  one complete TLV: recv_msg() performs a single recv() and rejects…
- [Low] The shared termination flag is `static volatile bool exiting;`
  (xdp_features.c:113).

--

selftests/net: Move XDP feature test to driver framework

This moves the xdp_features helper and its BPF program from selftests/bpf
into selftests/drivers/net/hw and replaces the old shell wrapper with a
NetDrvEpEnv based Python test that drives the configured local and remote
interfaces.  It also samples the detected capability before the cleanup
echo traffic and turns a detected/advertised mismatch into a test failure.

A few questions below about the new build wiring, the dropped setup steps
and the new process orchestration.

> diff --git a/tools/testing/selftests/bpf/test_xdp_features.sh b/tools/testing/selftests/bpf/test_xdp_features.sh
> deleted file mode 100755
> index a78e0fb9ed63..000000000000
> --- a/tools/testing/selftests/bpf/test_xdp_features.sh
> +++ /dev/null
> @@ -1,155 +0,0 @@

[ ... ]

> -		# Enable XDP mode and disable checksum offload
> -		ethtool -K v1 gro on
> -		ethtool -K v1 tx-checksumming off
> -		ip netns exec ${NS} ethtool -K v0 gro on
> -		ip netns exec ${NS} ethtool -K v0 tx-checksumming off
> -	} > /dev/null 2>&1
> -}

[Severity: Medium]
These four ethtool calls have no counterpart in xdp_features.py, and
neither xdp_features.c nor xdp_features.bpf.c does any checksum handling.
Is the setup no longer needed?

The DUT echo reply still goes through an ordinary UDP socket in
dut_echo_thread():

	n = recvfrom(sockfd, buf, sizeof(buf), MSG_WAITALL,
		     (struct sockaddr *)&addr, &addrlen);

With NetDrvEpEnv pointed at a veth whose peer lives in a netns
(nsim_test=False excludes netdevsim only), both ends keep their default
offload settings.  Can the echo dependent subtests (XDP_PASS, XDP_TX,
XDP_REDIRECT, XDP_NDO_XMIT) then report NOT DETECTED on a working driver,
which the new ksft_eq(detected, advertised) turns into a hard failure?

[ ... ]

> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index 8aebdc6feb17..a5dea02ee476 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile

[ ... ]

> @@ -80,6 +81,7 @@ YNL_GEN_FILES := \
>  # end of YNL_GEN_FILES
>  TEST_GEN_FILES += $(YNL_GEN_FILES)
>  TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
> +TEST_GEN_PROGS += xdp_features

[Severity: Medium]
Is TEST_GEN_PROGS the right list for this helper?  lib.mk expands
$(call RUN_TESTS, $(TEST_GEN_PROGS) ...) in the run_tests target and
emit_tests iterates $(TEST_GEN_PROGS) into kselftest-list.txt, so
./xdp_features is also executed bare, with no arguments.

Without the positional interface argument, env.ifindex keeps the -ENODEV
default installed by set_env_default() and main() returns non-zero:

	if (env.ifindex < 0) {
		fprintf(stderr, "Invalid device name %s\n", env.ifname);
		return -ENODEV;
	}

Does that add a permanently failing drivers/net/hw:xdp_features entry
alongside the real xdp_features.py results?  The sibling helpers in this
same Makefile (ncdevmem, toeplitz, iou-zcrx) use TEST_GEN_FILES, and the
old selftests/bpf location used TEST_GEN_PROGS_EXTENDED.

>  
>  include ../../../lib.mk
>  
> @@ -93,6 +95,26 @@ include ../../../net/ynl.mk
>  
>  include ../../../net/bpf.mk
>  
> +BPFTOOL ?= bpftool
> +
> +CFLAGS += -I$(OUTPUT) -I$(SCRATCH_DIR)/include
> +CFLAGS += -I$(top_srcdir)/tools/include
> +CFLAGS += -I$(top_srcdir)/tools/arch/$(SRCARCH)/include
> +CFLAGS += -I$(top_srcdir)/tools/include/uapi
> +CFLAGS += -I../../../net/lib
> +
> +$(OUTPUT)/xdp_features.skel.h: $(OUTPUT)/xdp_features.bpf.o
> +	$(call msg,GEN-SKEL,,$@)
> +	$(Q)$(BPFTOOL) gen skeleton $< name xdp_features > $@

[Severity: Medium]
Should bpftool be built or at least probed here?  ../../../net/bpf.mk
provides only the clang rules for *.bpf.c plus libbpf.a; it defines no
BPFTOOL and no in-tree bpftool build.  On a host that has clang but no
bpftool installed, does the whole drivers/net/hw selftest build now fail
on this rule?

selftests/bpf, selftests/hid and selftests/sched_ext build bpftool from
tools/bpf/bpftool, and selftests/exec probes it with command -v via
HAVE_BPF_TOOLCHAIN.  Was adding a new unconditional host tool requirement
for this directory intended?  It is not mentioned in the changelog.

> +
> +$(OUTPUT)/xdp_features: xdp_features.c xdp_features.h \
> +			   $(OUTPUT)/xdp_features.skel.h $(BPFOBJ)
> +	$(call msg,BINARY,,$@)
> +	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) \
> +		$(LDLIBS) -lelf -lz -lpthread -o $@

[ ... ]

> diff --git a/tools/testing/selftests/bpf/xdp_features.c b/tools/testing/selftests/drivers/net/hw/xdp_features.c
> similarity index 86%
> rename from tools/testing/selftests/bpf/xdp_features.c
> rename to tools/testing/selftests/drivers/net/hw/xdp_features.c
> index a27ed663967c..ccc0630bb6cf 100644
> --- a/tools/testing/selftests/bpf/xdp_features.c
> +++ b/tools/testing/selftests/drivers/net/hw/xdp_features.c

[ ... ]

> @@ -40,7 +44,63 @@ static struct env {
>  
>  #define BUFSIZE		128
>  
> -void test__fail(void) { /* for network_helpers.c */ }

[ ... ]

> +static int settimeo(int fd, int timeout_ms)
> +{
> +	struct timeval timeout = { .tv_sec = 3 };
> +
> +	if (timeout_ms > 0) {
> +		timeout.tv_sec = timeout_ms / 1000;
> +		timeout.tv_usec = (timeout_ms % 1000) * 1000;
> +	}
> +
> +	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeout,
> +		       sizeof(timeout)) ||
> +	    setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &timeout,
> +		       sizeof(timeout)))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static int start_server(int type, __u16 port)
> +{
> +	struct sockaddr_storage addr;
> +	int fd, on = 1;
> +
> +	fd = socket(AF_INET6, type, 0);
> +	if (fd < 0)
> +		return -1;
> +
> +	if (settimeo(fd, 0) ||
> +	    setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &on, sizeof(on)) ||
> +	    (type == SOCK_STREAM &&
> +	     setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on))) ||
> +	    make_sockaddr(NULL, port, &addr) ||
> +	    bind(fd, (struct sockaddr *)&addr, sizeof(struct sockaddr_in6)) ||
> +	    (type == SOCK_STREAM && listen(fd, 1))) {

[Severity: Medium]
This isn't a bug introduced by this patch, but it is worth noting since
the exposure changes.  make_sockaddr(NULL, port, &addr) memsets the
address and therefore binds in6addr_any, and dut_run() accepts the first
connection without checking ctrl_addr, exactly as the old
start_reuseport_server(..., NULL, DUT_CTRL_PORT, ...) did.

With the control channel now living on a configured real interface rather
than a private veth, any host that can reach DUT_CTRL_PORT can connect
first and send CMD_START, making the root-privileged process attach the
XDP program, or simply occupy the single accepted connection.

If that peer then closes the connection, recv() returns 0, recv_msg()
maps it to -EINVAL through the len < sizeof(*tlv) test, and the CTRL loop
does:

		err = recv_msg(ctrl_sockfd, buf, BUFSIZE, NULL, 0);
		if (err)
			continue;

Would that spin at 100% CPU until the process is signalled?  Should the
DUT bind to the configured local address and validate the accepted peer?

[ ... ]

> @@ -229,7 +286,7 @@ static void *dut_echo_thread(void *arg)
>  	while (!exiting) {
>  		struct tlv_hdr *tlv = (struct tlv_hdr *)buf;
>  		struct sockaddr_storage addr;
> -		socklen_t addrlen;
> +		socklen_t addrlen = sizeof(addr);
>  		size_t n;

[Severity: Low]
This is a pre-existing issue and not introduced by this patch, but the
loop condition here reads the shared flag declared as:

	static volatile bool exiting;

which is written both from sig_handler() and from the DUT control thread
on CMD_STOP while this worker reads it.  volatile constrains compiler
access only; it is neither a valid asynchronous signal object
(volatile sig_atomic_t or a lock-free atomic) nor an inter-thread
synchronisation primitive.  Would sig_atomic_t or an atomic be the right
type here?

>  
>  		n = recvfrom(sockfd, buf, sizeof(buf), MSG_WAITALL,
> @@ -244,7 +301,6 @@ static void *dut_echo_thread(void *arg)
>  		       (struct sockaddr *)&addr, addrlen);
>  	}
>  
> -	pthread_exit((void *)0);
>  	close(sockfd);
>  
>  	return NULL;
> @@ -254,9 +310,8 @@ static int dut_run_echo_thread(pthread_t *t, int *sockfd)
>  {
>  	int err;
>  
> -	sockfd = start_reuseport_server(AF_INET6, SOCK_DGRAM, NULL,
> -					DUT_ECHO_PORT, 0, 1);
> -	if (!sockfd) {
> +	*sockfd = start_server(SOCK_DGRAM, DUT_ECHO_PORT);
> +	if (*sockfd < 0) {
>  		fprintf(stderr,
>  			"Failed creating data UDP socket on device %s\n",
>  			env.ifname);

[ ... ]

> @@ -361,25 +416,25 @@ static int recv_msg(int sockfd, void *buf, size_t bufsize, void *val,
>  static int dut_run(struct xdp_features *skel)
>  {
>  	int flags = XDP_FLAGS_UPDATE_IF_NOEXIST | XDP_FLAGS_DRV_MODE;
> -	int state, err = 0, *sockfd, ctrl_sockfd, echo_sockfd;
> +	int state = CMD_STOP, err = 0, sockfd, ctrl_sockfd, echo_sockfd;
>  	struct sockaddr_storage ctrl_addr;
>  	pthread_t dut_thread = 0;
> -	socklen_t addrlen;
> +	socklen_t addrlen = sizeof(ctrl_addr);

[Severity: Low]
The changelog describes a move plus the result sampling reorder, but this
hunk and the preceding ones also carry behavioural fixes for the existing
helper:

  - state is now initialised to CMD_STOP instead of being used
    uninitialised in the CTRL loop
  - addrlen is now initialised before accept() here, and before
    recvfrom() in dut_echo_thread()
  - dut_run_echo_thread() now assigns *sockfd instead of overwriting its
    local parameter, which previously left echo_sockfd uninitialised in
    the caller and leaked the listening fd
  - the dead pthread_exit((void *)0) that made the following
    close(sockfd) unreachable is removed

Could these be split into separate preceding patches with a Fixes tag
for 4dba3e7852b7 ("selftests/bpf: introduce XDP compliance test tool"),
so they are visible to maintainers and to stable backports?

The new ksft_eq(detected, advertised) assertion in xdp_features.py is
also a behaviour change in the same commit: disagreements that were
previously only printed now fail the test.

[Severity: Medium]
dut_thread stays 0 until a CMD_START is processed, and the end_thread
label is reached unconditionally:

end_thread:
	pthread_join(dut_thread, NULL);
out:
	bpf_xdp_detach(env.ifindex, flags, NULL);
	close(ctrl_sockfd);
	close(sockfd);

Can dut_run() reach that join with dut_thread still 0, for instance when
the SIGTERM handler sets exiting before any CMD_START arrives?  glibc's
pthread_join() casts the handle to struct pthread * and dereferences it
with no validity check, so joining 0 faults and the bpf_xdp_detach() and
close() cleanup under out: is skipped.

The new harness makes this path routine: bkg(exit_wait=True) sends
SIGTERM to the DUT whenever the tester command raises, and because
terminate is set, bkg defaults fail to False and the resulting crash is
swallowed.  Should the join be conditional on dut_thread having been
created?

>  
> -	sockfd = start_reuseport_server(AF_INET6, SOCK_STREAM, NULL,
> -					DUT_CTRL_PORT, 0, 1);
> -	if (!sockfd) {
> +	sockfd = start_server(SOCK_STREAM, DUT_CTRL_PORT);
> +	if (sockfd < 0) {
>  		fprintf(stderr,
>  			"Failed creating control socket on device %s\n", env.ifname);
>  		return -errno;
>  	}
> +	ksft_ready();
>  
> -	ctrl_sockfd = accept(*sockfd, (struct sockaddr *)&ctrl_addr, &addrlen);
> +	ctrl_sockfd = accept(sockfd, (struct sockaddr *)&ctrl_addr, &addrlen);
>  	if (ctrl_sockfd < 0) {
>  		fprintf(stderr,
>  			"Failed accepting connections on device %s control socket\n",
>  			env.ifname);
> -		free_fds(sockfd, 1);
> +		close(sockfd);
>  		return -errno;
>  	}

[Severity: Medium]
Is three seconds enough for this accept()?  The listening socket carries
the SO_RCVTIMEO installed by start_server() through settimeo(fd, 0):

	struct timeval timeout = { .tv_sec = 3 };

Linux applies SO_RCVTIMEO to accept() (inet_csk_accept() ->
inet_csk_wait_for_connect() returns -EAGAIN), and there is no
EAGAIN/EINTR retry here, so the DUT prints "Failed accepting
connections" and returns.

The countdown starts at ksft_ready(), and only then does the harness
proceed:

    with bkg(dut_cmd, exit_wait=True, ksft_ready=True):
        result = cmd(tester_cmd, host=cfg.remote)

So spawning ssh to the remote plus the tester's own skeleton open/load
and XDP attach all have to fit in that window.  On a loaded machine can
this time out and abort the DUT?

[Severity: Low]
This isn't a bug introduced by this patch either, since recv_msg() and
send_and_recv_msg() are moved verbatim, but the control protocol assumes
one complete TLV per send()/recv().  recv_msg() does a single recv() and
discards anything short without keeping the prefix:

	if (len != ntohs(tlv->len) || len < sizeof(*tlv))
		return -EINVAL;

and send_and_recv_msg() treats any positive send() return as a complete
write.  For 4 to 16 byte messages on an idle connected socket a short
transfer looks unreachable in practice, so this is noted only as
context.

[ ... ]

> @@ -488,7 +543,7 @@ static int dut_run(struct xdp_features *skel)
>  out:
>  	bpf_xdp_detach(env.ifindex, flags, NULL);
>  	close(ctrl_sockfd);
> -	free_fds(sockfd, 1);
> +	close(sockfd);
>  
>  	return err;
>  }

[Severity: Medium]
Can this cleanup detach an XDP program the test does not own?  Both
dut_attach_xdp_prog() and tester_run() attach with
XDP_FLAGS_UPDATE_IF_NOEXIST, so if the interface already has a native
program the attach fails with -EBUSY and both error paths fall through to
this unconditional bpf_xdp_detach(env.ifindex, flags, NULL).

libbpf implements detach as an attach with prog_fd -1, and the
UPDATE_IF_NOEXIST guard in dev_xdp_attach() only applies when new_prog is
non-NULL:

	if (new_prog) {
		if ((flags & XDP_FLAGS_UPDATE_IF_NOEXIST) && cur_prog) {
			NL_SET_ERR_MSG(extack, "XDP program already attached");
			return -EBUSY;
		}
	}

So with new_prog == NULL the pre-existing foreign program is removed.
On the shared remote endpoint that would also break a concurrent user.
Should the cleanup remember whether its own attach succeeded, or pass
old_prog_fd?

> @@ -636,13 +691,14 @@ static int tester_run(struct xdp_features *skel)
>  	if (err)
>  		goto out;
>  
> +	/* Collect results before cleanup traffic can reach the tester. */
> +	detected_cap = tester_collect_detected_cap(skel, ntohl(stats));
> +
>  	/* stop the test */
>  	err = send_and_recv_msg(sockfd, CMD_STOP, NULL, 0);
>  	/* send a new echo message to wake echo thread of the dut */
>  	send_echo_msg();
>  
> -	detected_cap = tester_collect_detected_cap(skel, ntohl(stats));
> -
>  	fprintf(stdout, "Feature %s: [%s][%s]\n", get_xdp_feature_str(),
>  		detected_cap ? GREEN("DETECTED") : RED("NOT DETECTED"),
>  		env.feature.drv_feature & advertised_feature ? GREEN("ADVERTISED")

[ ... ]

> diff --git a/tools/testing/selftests/drivers/net/hw/xdp_features.py b/tools/testing/selftests/drivers/net/hw/xdp_features.py
> new file mode 100755
> index 000000000000..5eeadf8033d8
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/xdp_features.py
> @@ -0,0 +1,109 @@

[ ... ]

> +def run_feature(cfg, feature, ipver):
> +    if not cfg.addr_v[ipver]:
> +        ipver = "4" if ipver == "6" else "6"
> +    cfg.require_ipver(ipver)
> +    dut_addr = mapped_address(cfg.addr_v[ipver])
> +    tester_addr = mapped_address(cfg.remote_addr_v[ipver])

[Severity: Medium]
These addresses come from net.config (LOCAL_V4/V6, REMOTE_V4/V6) and are
handed to the helper as the exact addresses expected on the wire, but
send_echo_msg() creates an unbound UDP socket:

	sockfd = socket(AF_INET6, SOCK_DGRAM, 0);
	...
	n = sendto(sockfd, buf, sizeof(*tlv), MSG_NOSIGNAL | MSG_CONFIRM,
		   (struct sockaddr *)&env.dut_addr, sizeof(env.dut_addr));

NetDrvEpEnv does not require the configured address to be the interface's
preferred source address.  If REMOTE_V4/REMOTE_V6 is a secondary address,
the kernel picks a different source and the DUT filter rejects the probe:

		if (saddr != ih->saddr)
			return -EINVAL;

dut_stats then stays 0, detected is false while advertised is true, and
ksft_eq() fails on a working driver.  Should the probe socket bind to
env.tester_addr first?

> +
> +    dut_cmd = feature_command(cfg.xdp_features, feature, dut_addr,
> +                              tester_addr, cfg.ifname)
> +    tester_cmd = feature_command(cfg.remote_xdp_features, feature, dut_addr,
> +                                 tester_addr, cfg.remote_ifname, tester=True)

[Severity: Medium]
Does running the helper on cfg.remote with cfg.remote_ifname fit the
framework contract?  drivers/net/README.rst says "Local host is the DUT
... remote is just for traffic generation" and "Avoid making
configuration changes to the remote system as much as possible.  Remote
system may be used concurrently by multiple DUTs."

tester_run() attaches an XDP program to the remote interface with
XDP_FLAGS_DRV_MODE | XDP_FLAGS_UPDATE_IF_NOEXIST, so a perfectly good
local DUT result now depends on the remote NIC supporting native XDP and
having no program attached, and two concurrent runs from different DUTs
would collide.  With the old script the peer was a private veth, so this
dependency did not exist.

> +
> +    with bkg(dut_cmd, exit_wait=True, ksft_ready=True):
> +        result = cmd(tester_cmd, host=cfg.remote)

[Severity: Medium]
Should a device without native (DRV mode) XDP support be skipped rather
than failed?  Both ends attach with XDP_FLAGS_DRV_MODE, so on such a NIC
the tester fails in tester_run():

	err = bpf_xdp_attach(env.ifindex, bpf_program__fd(prog), flags, NULL);
	if (err) {
		fprintf(stderr, "Failed attaching XDP program to device %s\n",
			env.ifname);
		goto out;

and the DUT fails the same way in dut_attach_xdp_prog() on CMD_START,
which makes the tester's send_and_recv_msg(sockfd, CMD_START, ...) fail.
cmd() here uses the default fail=True, so a non-zero exit raises
CmdExitFailure, and the "Unable to parse xdp_features output" path raises
a bare Exception in the same situation.

The changelog says tests fail "when detected and advertised features
disagree", but with no capability pre-check (say, querying
NETDEV_XDP_ACT_BASIC on both interfaces and skipping) don't NICs that
simply lack the feature produce errors instead?

> +
> +    output = ANSI_ESCAPE.sub("", result.stdout)
> +    match = RESULT.search(output)
> +    if not match:
> +        raise Exception(f"Unable to parse xdp_features output: {output}")
> +
> +    detected = match.group(1) is None
> +    advertised = match.group(2) is None
> +    ksft_eq(detected, advertised,
> +            comment=f"{feature}: detected and advertised support")

[ ... ]

> +def main():
> +    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
> +        cfg.xdp_features = (Path(__file__).parent / "xdp_features").resolve()
> +        cfg.remote_xdp_features = cfg.remote.deploy(
> +            cfg.xdp_features.as_posix()
> +        )

[Severity: Medium]
Is there anything here that guarantees the XDP programs are detached from
cfg.ifname and cfg.remote_ifname if a helper survives the test?  The
remote tester runs with the default cmd() timeout of 20 seconds while
tester_run() itself sleeps ten times one second on top of BPF load and
attach, and on timeout cmd._process_terminate() does:

    def _process_terminate(self, terminate, timeout):
        if terminate:
            self.proc.terminate()
        stdout, stderr = self.proc.communicate(timeout=timeout)

With terminate False, communicate() raises TimeoutExpired without ever
killing the child, so the ssh session and the remote xdp_features keep
running with the program still attached.  Since the helper attaches with
XDP_FLAGS_UPDATE_IF_NOEXIST, would every following subtest then fail with
-EBUSY?

The old harness was immune because everything lived in a netns that
cleanup() deleted.  Could a defer() forcing xdp off on both hosts (and a
kill of the remote helper) be registered here?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921-xdp-features-v4-send-v4-0-a0d4ec392cb7%40gmail.com
