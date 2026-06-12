Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637AA1FB1
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 00:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224300; cv=none; b=Dp1r2BtfWu5nwmOJzHZ4uhGJ20VhVMYjuotQcZ0MeYRWeohshX+63vuqLXqx73owV4xuPIYMjjrDuB+vxPBjGNG/oJSHMrlyPX33/1GfhxEO8Vw15oDJcrZ3Yep8RGgR72/eeriCkrvFhaDO28p5JnOO3FNwCXGaP7RnwUkPxXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224300; c=relaxed/simple;
	bh=B9qI7S+xf6q5GUgmk7NgsKzVDUncdcwBofFCSY7rOFA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mqD2Q6fljjzzqJgsdLb3MNrURtURq7GKO3lA8kbfUhsPG/fKQi9YcMe4znXF16NGcmJIvS3ugLjduDL4QO8bYuvWCoHc7uVx/LrVjnVIo8IPKdxUz+1bTKkKcdtTRUn/WYq9hUkOZmWEqW5R0BBU+1WAD59M+kxld1j7iqNQij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8RW8tY5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8RW8tY5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67A01F00A3A;
	Fri, 12 Jun 2026 00:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781224299;
	bh=nd1fZHu/wSSEuAovAsqBAP/7CfbDzVIHwkXwtPf2Tyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i8RW8tY5LQP72T6GscUeuxR4wJn9EdGNd57P1z3UXL1faZ6TUYbzTd3SvWCT/2kKh
	 DLm44rB/qkNKc6VDhm2fRtY8iGE7ArPMzllqIyTvFos4dQjUc1jSbdkKl0abhSz1QA
	 mD9YS0x+qsjY8ziixhgMHkQfbnIZ7PerpO44sGVQ5mDGhoyTldiUh6/ocBXrLg7F0r
	 RZbMt+i/tI37s8MJgcK4xXbko3uITMCXgXcKmtfx7WGn7smrI2Tl/sG3jCSyvdWdNT
	 SrVozHMtYV/zbZjhFIy/XbOn+pH+fPkJPtBUjCrgjjpdqAjEHkcBqixEi/jkP6Kbqk
	 N8ITiqIzMwFgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 bpf-next/net 5/5] selftest: bpf: Add test for
 hwtstamp proxy.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260612001803.23341-6-kuniyu@google.com>
References: <20260612001803.23341-6-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 00:31:38 +0000
Message-Id: <20260612003138.E67A01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Comparing a potentially negative return value to `sizeof()` causes=
 failure handling to be skipped, erroneously dropping packets.
- [Medium] Incorrect struct cast for SO_TIMESTAMPING_NEW cmsg data causes t=
est failures on 32-bit systems.
- [Medium] Typo in the test assertion prevents verification of TX timestamp=
 keys.
- [Low] Multi-line comments violate the BPF subsystem comment style.
- [Low] The `buf_cmsg` array is not fully initialized before being passed t=
o `sendmsg()`, passing uninitialized stack data to the kernel.
--

commit e747f30190af013f6f5cc858f0dacb86e902e2d2
Author: Kuniyuki Iwashima <kuniyu@google.com>

selftest: bpf: Add test for hwtstamp proxy.

This selftest simulates the hardware timestamp proxy scenario using two
UDP sockets, simulating a userspace proxy via a GENEVE device.

> diff --git a/tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c b/to=
ols/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c
> new file mode 100644
> index 0000000000000..d0f90f22bea22
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c
[ ... ]
> +char *ipv4_commands[] =3D {
> +	"ip link set dev lo up",
> +	"ip link add geneve0 type geneve local " APP_SRC_IPV4 " external",
> +	"ip addr add " APP_SRC_IPV4 "/24 dev geneve0",
> +	"ip link set dev geneve0 address aa:bb:cc:dd:ee:ff",
> +	"ip link set dev geneve0 up",
> +	"ip route add " APP_DST_IPV4 "/32 dev geneve0",
> +	/* We do not forward ARP to the wire in this test,
> +	 * so a static neighbour entry is needed for APP_DST_IPV4.
> +	 */

[Severity: Low]
Does this multi-line comment format violate the BPF subsystem comment style?
It seems the subsystem guidelines prefer the opening /* on its own line for
multi-line comments.

> +	"ip neigh add " APP_DST_IPV4 " lladdr ab:bc:cd:de:ef:fa dev geneve0",
> +};
[ ... ]
> +static int check_tstamp(struct proxy_hwtstamp_test_case *test_case, bool=
 tx)
> +{
[ ... ]
> +	for (cmsg =3D CMSG_FIRSTHDR(&msg); cmsg; cmsg =3D CMSG_NXTHDR(&msg, cms=
g)) {
> +		if (cmsg->cmsg_level =3D=3D SOL_SOCKET && cmsg->cmsg_type =3D=3D SO_TI=
MESTAMPING_NEW) {
> +			struct scm_timestamping *ts;
> +
> +			ts =3D (struct scm_timestamping *)CMSG_DATA(cmsg);
> +			ASSERT_EQ(ts->ts[2].tv_sec, 0, "tv_sec");
> +			ASSERT_EQ(ts->ts[2].tv_nsec, HWTSTAMP, "tv_nsec");

[Severity: Medium]
Since the test requests SO_TIMESTAMPING_NEW, the kernel will return timesta=
mps
using the 64-bit time architecture (via struct scm_timestamping64). Could
casting CMSG_DATA(cmsg) to struct scm_timestamping * cause issues on 32-bit
architectures where time_t is 32-bit?

It looks like this might misalign the array access, reading the zeroed
software timestamp ts[1] instead of the hardware timestamp, potentially
causing the test to fail.

> +
> +			saw_tstamp =3D true;
> +		} else if ((cmsg->cmsg_level =3D=3D SOL_IP && cmsg->cmsg_type =3D=3D I=
P_RECVERR) ||
> +			   (cmsg->cmsg_level =3D=3D SOL_IPV6 && cmsg->cmsg_type =3D=3D IPV6_R=
ECVERR)) {
> +			struct sock_extended_err *ee;
> +
> +			ee =3D (struct sock_extended_err *)CMSG_DATA(cmsg);
> +
> +			if (ee->ee_origin =3D=3D SO_EE_ORIGIN_TIMESTAMPING) {
> +				ASSERT_EQ(ee->ee_data, TSKEY, "tskey");
> +				saw_tskey =3D true;
> +			}
> +		}
> +	}
> +
> +	ASSERT_TRUE(saw_tstamp && (!tx || saw_tstamp), "no timestamp");

[Severity: Medium]
Should this check validate saw_tskey instead of checking saw_tstamp twice?
It looks like if the kernel fails to deliver the timestamp key, this check
will silently pass, potentially hiding regressions.

> +
> +	return ret;
> +}
> +
> +static int test_proxy_hwtstamp_tx(struct proxy_hwtstamp_test_case *test_=
case)
> +{
> +	char h_source_dummy[ETH_HLEN] =3D {0xFF, 0xEE, 0xDD, 0xCC, 0xBB, 0xAA};
> +	char buf_cmsg[CMSG_SPACE(sizeof(u32))];
> +	struct proxy_header *phdr;
> +	struct msghdr msg =3D {};
> +	struct iovec iov =3D {};
> +	struct cmsghdr *cmsg;
> +	int ret;
> +
> +	memset(test_case->app_payload, 0xAB, sizeof(test_case->app_payload));
> +	iov.iov_base =3D test_case->app_payload;
> +	iov.iov_len =3D sizeof(test_case->app_payload);
> +
> +	msg.msg_iov =3D &iov;
> +	msg.msg_iovlen =3D 1;
> +	msg.msg_control =3D buf_cmsg;
> +	msg.msg_controllen =3D sizeof(buf_cmsg);
> +
> +	cmsg =3D CMSG_FIRSTHDR(&msg);
> +	cmsg->cmsg_level =3D SOL_SOCKET;
> +	cmsg->cmsg_type =3D SCM_TS_OPT_ID;
> +	cmsg->cmsg_len =3D CMSG_LEN(sizeof(u32));
> +	*(u32 *)CMSG_DATA(cmsg) =3D TSKEY;
> +
> +	ret =3D sendmsg(test_case->app_fd, &msg, 0);

[Severity: Low]
Is it possible that uninitialized stack memory from buf_cmsg is being passed
to the kernel here?

Only the first CMSG_LEN bytes are initialized, but msg_controllen is set to
the full CMSG_SPACE size which includes uninitialized alignment padding.
Could this trigger MemorySanitizer warnings?

> +	if (!ASSERT_EQ(ret, sizeof(test_case->app_payload), "send"))
> +		return -1;
[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/proxy_hwtstamp.c b/tools/t=
esting/selftests/bpf/progs/proxy_hwtstamp.c
> new file mode 100644
> index 0000000000000..c15428e4c20f6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/proxy_hwtstamp.c
[ ... ]
> +SEC("tcx/egress")
> +int proxy_hwtstamp_egress(struct __sk_buff *skb)
> +{
[ ... ]
> +	kskb =3D bpf_cast_to_kern_ctx(skb);
> +	shared_info =3D bpf_core_cast(kskb->head + kskb->end, struct skb_shared=
_info);
> +	if (!shared_info->tx_flags) {
> +		/* If TX tstamp is not needed, don't insert the GENEVE option.
> +		 * The proxy socket will see genevehdr.opt_len =3D=3D 0.
> +		 */

[Severity: Low]
Does this multi-line comment format violate the BPF subsystem comment style?
It seems the subsystem guidelines prefer the opening /* on its own line for
multi-line comments.

> +		goto pass;
> +	}
[ ... ]
> +SEC("tcx/ingress")
> +int proxy_hwtstamp_ingress(struct __sk_buff *skb)
> +{
> +	struct proxy_hwtstamp_opt opt;
> +	struct bpf_tunnel_key key;
> +	int ret;
> +
> +	/* Get the GENEVE header. */
> +	ret =3D bpf_skb_get_tunnel_key(skb, &key, sizeof(key), tunnel_rx_flags);
> +	if (ret < 0)
> +		goto drop;
> +
> +	if (key.tunnel_id !=3D GENEVE_VNI)
> +		goto drop;
> +
> +	/* Get the GENEVE option. */
> +	ret =3D bpf_skb_get_tunnel_opt(skb, &opt, sizeof(opt));
> +	if (ret < sizeof(opt)) {

[Severity: High]
Can this check drop packets without a GENEVE option?

bpf_skb_get_tunnel_opt() returns a signed integer, but sizeof(opt) is
unsigned. If the return value is negative (e.g., -ENOENT), it will be
promoted to a large unsigned integer during the comparison.

Would this cause ret < sizeof(opt) to evaluate to false and skip the failure
handling, inadvertently dropping legitimate traffic?

> +		 /* If TX/RX tstamp is not needed, the proxy socket
> +		  * does not insert the GENEVE option.
> +		  */
> +		goto pass;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612001803.2334=
1-1-kuniyu@google.com?part=3D5
