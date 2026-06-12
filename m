Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01D9383C9F
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 01:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781227690; cv=none; b=bhSn2cHUSee+wjyLwWwpJHTOZdlTlHRJFBXQiGNUUnnN+/YJN10L6F6haZ5qSma3iio1KF22HShvJwUehkOSiOstF9Ro8UyvWOATuqdbWWMuhHt5+X+hvyHfXAXjE2ycR7MYtGGY+k7hJ1U7PIGlGscdCzyV+qboFMWRm7Yt+sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781227690; c=relaxed/simple;
	bh=PJgTskbzYhyGPmm/uFm/WomVZ0ja4iYbgWD/hlnmOm4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pfphXxXBnCNN3Ib2XWnFh9JZz9RrvrxdOpNET2FYnLouHYh9dYlLdFVlTCiSDdBSD8GT1VDy961ZZkdLky6mp7NSmFv4sbEthbSLYhx96Rh0TEvLC3hac70KMY0nxX0usWP0HkrlVVL700oJ58pFdD+BlgTfYK1oTQySBQQvWeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAFyVCrK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAFyVCrK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291E31F000E9;
	Fri, 12 Jun 2026 01:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781227687;
	bh=kCfHrCDdfawxxf3uV9/d20Cit2ZiAsK3XF3ggvhLe5Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EAFyVCrKNnXZOOPiGTouH5N3RsmJ76GFygt1NljhHl4EIpXU9UFH1n/s1YUYQ1PAB
	 WOAVBQqYM227iTThB1sSEse1MQ/jZSh2hwo4T09wi7zpQKIDNopPfFeIXp0CKhFssf
	 p5NCHU3ccRlerbELFKuCY+5aQmndMt3y7iUxBy3BeDdj4sidYh4cmX5Of2hbHe93vn
	 vJBewspnPRUFyDzIFTIyRy7+8b9Wdjjl++JEEE6azadYsJAS05wxP/jn18CfEvM+eA
	 +G0+GpCyQkiXqjAglntVinRi29qepTTHhmIWy0eSoOXn/1eCDOfeaxwCOqnZAOQCCP
	 stOIl9wLcdD/w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 3/5] selftests/bpf: add tcp_splice basic
 round-trip test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cong Wang" <xiyou.wangcong@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260612011452.134466-4-xiyou.wangcong@gmail.com>
References: <20260612011452.134466-4-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 01:28:06 +0000
Message-Id: <20260612012807.291E31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] If the second `pthread_create()` fails in `run_bidir_write`, the=
 function returns early without joining the first thread, leading to a leak=
ed thread and a Use-After-Free on the stack.
- [Low] Multi-line comments violate the required BPF subsystem comment styl=
e.
--

commit 2de2ff2207c8434507b69004f912f22fbc96a325
Author: Cong Wang <xiyou.wangcong@gmail.com>

selftests/bpf: add tcp_splice basic round-trip test

Adds a test for the tcp_splice BPF functionality using a sock_ops program to
pair local TCP sockets via bpf_sock_splice_pair. The test includes basic
round-trip and bidirectional-write subtests.

> diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_splice.c b/tools/=
testing/selftests/bpf/prog_tests/tcp_splice.c
> new file mode 100644
> index 0000000000000..b80a1129c6aa8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/tcp_splice.c
[ ... ]
> +	/* Drive the splice fast path: receiver enters recv() and publishes
> +	 * its bvec, sender then writes directly into it.
> +	 */

[Severity: Low]
This isn't a bug, but does this comment style violate the BPF subsystem
guidelines? Multi-line comments should have the opening /* on its own line.

[ ... ]
> +/* Bidirectional-write deadlock-avoidance test.
> + *
> + * Both sides issue send() before either calls recv(), the classic

[Severity: Low]
This isn't a bug, but shouldn't the opening /* be on its own line
for multi-line comments in the BPF subsystem?

> + * pattern that used to deadlock under synchronous rendezvous (and
> + * the actual cause of "kex_exchange_identification: write: Broken
> + * pipe" with SSH on loopback). The bounded-wait fallback in
> + * tcp_bpf_splice_sendmsg() must let both writes complete via the
> + * normal TCP path within ~1 ms, and the banners must arrive intact
> + * on the other side when recv() is called next.
> + */
> +static int run_bidir_write(int cgroup_fd, struct test_tcp_splice *skel)
> +{
[ ... ]
> +	/* Both sides write first, neither reads yet. Both must return
> +	 * within bounded time (no deadlock).
> +	 */
> +	cs.fd =3D cfd;
> +	ss.fd =3D sfd;
> +	if (!ASSERT_OK(pthread_create(&client_send_tid, NULL, send_thread, &cs),
> +		       "client send thread"))
> +		goto out;
> +	if (!ASSERT_OK(pthread_create(&server_send_tid, NULL, send_thread, &ss),
> +		       "server send thread"))
> +		goto out;

[Severity: Medium]
If the second pthread_create() fails, will this jump to out and return, lea=
ving
client_send_tid running in the background?=20

Since cs is allocated on the stack, could the background thread's execution=
 of
send_thread() write to cs.n and cs.err after the stack frame is destroyed,
causing a use-after-free memory corruption in the test runner?

> +
> +	pthread_join(client_send_tid, NULL);
> +	pthread_join(server_send_tid, NULL);
[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/test_tcp_splice.c b/tools/=
testing/selftests/bpf/progs/test_tcp_splice.c
> new file mode 100644
> index 0000000000000..09c7f0f9e3110
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_tcp_splice.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Sock_ops BPF program that pairs locally-connected TCP sockets via the
> + * bpf_sock_splice_pair kfunc. Each side of an established loopback

[Severity: Low]
This isn't a bug, but shouldn't the opening /* be on its own line
for multi-line comments in the BPF subsystem?

> + * connection inserts itself into a sockhash keyed by its 4-tuple and
> + * looks up the peer using the swapped tuple. Whichever side finds the
> + * peer attempts to splice; the race loser sees -EEXIST.
> + */
[ ... ]
> +static __always_inline void mk_key(struct bpf_sock_ops *s,
> +				   struct flow_key *k, int swap)
> +{
> +	/* skops->local_port is already in host byte order. skops->remote_port
> +	 * is laid out as the network-order 16-bit port in the upper half of

[Severity: Low]
This isn't a bug, but shouldn't the opening /* be on its own line
for multi-line comments in the BPF subsystem?

> +	 * a u32 (see sock_ops_convert_ctx_access); bpf_ntohl produces the
> +	 * host-order port directly - no further shift.
> +	 */
> +	__u16 lport =3D (__u16)s->local_port;
> +	__u16 rport =3D bpf_ntohl(s->remote_port);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612011452.1344=
66-1-xiyou.wangcong@gmail.com?part=3D3
