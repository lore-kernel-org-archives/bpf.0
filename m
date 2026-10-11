Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB7739E9AC;
	Sun, 11 Oct 2026 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791717437; cv=none; b=CZ1NheSA2+VCVYBkqFYTUnZshUsiluO8bWEcLoQ+NB0Pv5bZjOw6laQ3Uxn+kmjcFMBi9AQ2nhstIeGzmFxGCK/cbBgFCrMOoc7s/tSWv/cCdn5vq9d0B+s5sTDmOOW4NVaaYtQH6bhHKvSFROjU8p3sFsP7ojaXb6UXDKWn3iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791717437; c=relaxed/simple;
	bh=T+0d/zU2WbT37szWyCbLiQqT/T1SypUEH46yJWzEdfw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gd991/m68DS6LgsptmsZ2Mq1fAm1+pPvcua/5cZYOgsEZpRPu4O3qXIbfvUYdOaB4kh5GW7cF/itroNxkFmzDEa/8DMEvFhtyIfaM2e25nmsLvpj4kAGXYydfvI9mnlbgSnNjO8SYxKcChi1hj5WyrdGKGm8v0pLWa1PbA13bAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7AksWax; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7AksWax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797DE1F0089B;
	Sun, 11 Oct 2026 11:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791717429;
	bh=9CDgjG5z5ctIA1MRteKwLiFkxIN9XNtYzoNZuQFFZ1s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B7AksWaxSRhdsBDnhTb0+8t6RRrM6V0GRb6t7F7yUo5pSe/+1wIit+v37Exw8/ldc
	 AKHxMo8uC3R2j9tViGAIsVW4xsl7OXidDjPX+GC505hT5lwPvEmavFKwDSf52Dt1E0
	 ckLSBfhBx/DS7/ezea6Gt2Y9pGJdhgd8pZOhsLcoqGFGvfAwMeoeys5wmiXm9vLPoM
	 34DHhBG0q6gmOyouF4Dc79UcUMUiy0psk77vcUtU6+A4JpXK+YLcHxRQOjxm7KgLVE
	 qBjfMNtf4TboQ2Wq7aBqO+1StWpr22TASkJ0RfrOD+dmFDRC+YpsZh6DXUtfesnXtf
	 Uo7G2Ow/U6Njw==
Subject: Re: [PATCH net-next v5 3/5] selftests/bpf: Send XDP feature probes
 with AF_PACKET
From: netdev-bot+sashiko@kernel.org
To: bochaolucky@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 andrew+netdev@lunn.ch, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 alexis.lothore@bootlin.com, lorenzo@kernel.org, tiozhang@didiglobal.com,
 willemdebruijn.kernel@gmail.com, petrm@nvidia.com
Date: Sun, 11 Oct 2026 11:17:07 +0000
Message-ID: <179171742705.434549.15098071092482149347@kernel.org>
In-Reply-To: <20261010-xdp-v5-send-20261008-v5-3-de687cb67c40@gmail.com>
References: <20261010-xdp-v5-send-20261008-v5-3-de687cb67c40@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch makes the documented separate control-channel
  address unusable.
- [Low] At this commit, main() returns EINTR (4) whenever stop_signal is
  set, including when the new alarm(90) watchdog fires (lines 939-940,…
- [Low] xdp_features.h line 11 annotates the new CMD_GET_MAC as `/* CMD +
  data */`, but the request carries no payload.
- [Low] stop_signal is a `volatile sig_atomic_t` (line 121) that
  sig_handler() writes (line 131) and should_exit() reads from both the…

Pre-existing issues:
- [Low] tester_run() computes detected_cap (line 907) and only prints
  DETECTED/ADVERTISED.

--

selftests/bpf: Send XDP feature probes with AF_PACKET

This commit reworks the xdp_features tester to send echo probes and count
replies through an AF_PACKET socket, so the tester side needs no XDP
support. The DUT now attaches its program through an XDP link, returns its
MAC address over the control connection, and checks control peers and
message lengths. A native-XDP query mode is added and the network_helpers
dependency is dropped.

> diff --git a/tools/testing/selftests/bpf/xdp_features.c b/tools/testing/selftests/bpf/xdp_features.c
> index 5b802b14d8589..521c0e24a27ca 100644
> --- a/tools/testing/selftests/bpf/xdp_features.c
> +++ b/tools/testing/selftests/bpf/xdp_features.c

[ ... ]

> @@ -50,11 +118,17 @@ static int libbpf_print_fn(enum libbpf_print_level level,
>  	return vfprintf(stderr, format, args);
>  }
>  
> -static volatile bool exiting;
> +static volatile sig_atomic_t stop_signal;
> +static atomic_bool exiting;
> +
> +static bool should_exit(void)
> +{
> +	return stop_signal || atomic_load(&exiting);
> +}
>  
>  static void sig_handler(int sig)
>  {
> -	exiting = true;
> +	stop_signal = sig;
>  }

[Severity: Low]
This isn't a bug, but stop_signal is a volatile sig_atomic_t. sig_handler()
writes it, and should_exit() reads it from both the dut_run() control loop
and dut_echo_thread().

If the signal is handled on the other thread, that is formally a data race
under C11. In practice it is a single word that is re-read on every
iteration and orders no other data. Both loops also recheck at least every
3 seconds because of SO_RCVTIMEO, and the old volatile bool had the same
property.

Since exiting is already an atomic_bool, would it be cleaner to use an
atomic for both?

[ ... ]

> @@ -362,38 +466,61 @@ static int recv_msg(int sockfd, void *buf, size_t bufsize, void *val,
>  
>  static int dut_run(struct xdp_features *skel)
>  {

[ ... ]

> -	sockfd = start_reuseport_server(AF_INET6, SOCK_STREAM, NULL,
> -					DUT_CTRL_PORT, 0, 1);
> -	if (!sockfd) {
> +	sockfd = start_server(SOCK_STREAM, DUT_CTRL_PORT);
> +	if (sockfd < 0) {

[ ... ]

> +	if (memcmp(&((struct sockaddr_in6 *)&ctrl_addr)->sin6_addr,
> +		   &((struct sockaddr_in6 *)&env.tester_addr)->sin6_addr,
> +		   sizeof(struct in6_addr))) {
> +		err = -EPERM;
> +		goto out;
> +	}

[Severity: Medium]
Does this make the -C option unusable when it differs from -D?

The new start_server() takes its bind address from the -D data address:

    static int start_server(int type, __u16 port)
    {
        struct sockaddr_storage addr = env.dut_addr;

As a result, the TCP control listener in dut_run() binds only to
<-D>:12345, and env.dut_ctrl_addr is never read on the DUT. The old
start_reuseport_server(..., NULL, DUT_CTRL_PORT, 0, 1) call bound the
listener to the wildcard address.

On the other side, tester_run() binds its control socket to the -T data
address before it connects to -C:

    if (settimeo(sockfd, 30000) ||
        bind(sockfd, (struct sockaddr *)&local, sizeof(local)) ||
        connect(sockfd, (struct sockaddr *)&env.dut_ctrl_addr,
                sizeof(struct sockaddr_in6))) {

If -C is not the same as -D, the tester's connect() goes to an address
where nothing is listening. The DUT then eventually gives up in its
accept() retry loop.

A setup with a separate management network also can't work, because
the memcmp() above requires control traffic to come from the -T data
address. That -EPERM path also exits without printing anything.

The -C option is still documented as "DUT IP control channel", and the
commit message only says "Check control peers". Should the control socket
bind to env.dut_ctrl_addr or to the wildcard address? Alternatively, should
the usage text say that -C must match -D?

The later commit "selftests/net: Move the XDP feature test to
drivers/net/hw" only adds ksft_ready() to this code. Its Python runner
passes the DUT data address as -C, so the in-tree runners hide this.

[ ... ]

> @@ -553,112 +663,267 @@ static int send_and_recv_msg(int sockfd, enum test_commands cmd, void *val,

[ ... ]

> +	detected_cap = ntohl(stats) &&
> +		       ((env.feature.action == XDP_DROP ||
> +			 env.feature.action == XDP_ABORTED) ? !received : received);
> +	if (env.verbosity)
> +		fprintf(stderr, "dut=%u received=%u advertised=%llx\n",
> +			ntohl(stats), received, advertised_feature);
>  	err = send_and_recv_msg(sockfd, CMD_STOP, NULL, 0);
> -	/* send a new echo message to wake echo thread of the dut */
> -	send_echo_msg();
> -
> -
> +	if (err)
> +		goto out;
>  	fprintf(stdout, "Feature %s: [%s][%s]\n", get_xdp_feature_str(),
>  		detected_cap ? GREEN("DETECTED") : RED("NOT DETECTED"),
>  		env.feature.drv_feature & advertised_feature ? GREEN("ADVERTISED")
>  							     : RED("NOT ADVERTISED"));
>  out:

[ ... ]

> -	return err < 0 ? err : 0;
> +	return err;
>  }

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch, but
detected_cap is only used for the printed DETECTED/ADVERTISED line.

The return value of tester_run() doesn't depend on whether the detected
capability matches the advertised one. Because of that,
test_xdp_features.sh passes even when a feature is broken or misadvertised.

This is addressed by the end of the series. In the later commit
"selftests/net: Move the XDP feature test to drivers/net/hw",
xdp_features.py parses the result line and checks
ksft_eq(detected, advertised).

> @@ -671,6 +936,8 @@ int main(int argc, char **argv)
>  
>  	signal(SIGINT, sig_handler);
>  	signal(SIGTERM, sig_handler);
> +	signal(SIGALRM, sig_handler);
> +	alarm(90);
>  
>  	set_env_default();

[ ... ]

> +	if (env.is_tester) {
> +		err = tester_run();
> +		return stop_signal ? EINTR : (err < 0 ? -err : 0);
> +	}

[Severity: Low]
EINTR is 4, which is the same value as KSFT_SKIP. The DUT path does the
same thing with:

    if (stop_signal)
        return EINTR;

If the alarm(90) watchdog fires during a stalled run, main() returns 4.
test_xdp_features.sh runs under set -e and passes that status through.
Would a hung run then be reported as skipped instead of failed?

At the end of the series this only affects this intermediate commit. The
later commit "selftests/net: Move the XDP feature test to drivers/net/hw"
deletes test_xdp_features.sh. Its Python runner treats any non-zero exit
from the tester (cmd()) and from the DUT (bkg(..., exit_wait=True)) as a
failure, and only the explicit -q probe maps 4 to a skip.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/xdp_features.h b/tools/testing/selftests/bpf/xdp_features.h
> index 2670c541713b6..ba776e5ce7ebb 100644
> --- a/tools/testing/selftests/bpf/xdp_features.h
> +++ b/tools/testing/selftests/bpf/xdp_features.h
> @@ -8,6 +8,7 @@ enum test_commands {
>  	CMD_ACK,		/* CMD + data */
>  	CMD_GET_XDP_CAP,	/* CMD */
>  	CMD_GET_STATS,		/* CMD */
> +	CMD_GET_MAC,		/* CMD + data */
>  };

[Severity: Low]
This isn't a bug, but should CMD_GET_MAC be annotated /* CMD */, like
CMD_GET_XDP_CAP and CMD_GET_STATS?

tester_run() sends the request as a header-only TLV through
send_and_recv_msg(), and dut_run() reads it with recv_msg(..., NULL, 0).
The MAC address comes back in the CMD_ACK.

Later in the series this header moves unchanged to
drivers/net/hw/xdp_features.h, so the comment stays wrong there.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010-xdp-v5-send-20261008-v5-0-de687cb67c40%40gmail.com
