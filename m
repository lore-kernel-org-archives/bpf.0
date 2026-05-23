Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6398327C08
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779527563; cv=none; b=UAvYgO7Vjcm3gHJMMcBlt+pLXnpymYD3IDzz7uWzGwljZe6Uixw4kjdPKYKCssEZBI5z7kN/4OgaDfpEqCUZTYqdfMrFCLmVBnKQtZSITcazUzZ7fFU/eCDCMSaVl4rNcFiuRrNDZQnil6L+0P57vCBobECd8LdKh3umVnmevTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779527563; c=relaxed/simple;
	bh=v/suMUgd7IxtaYi2TAF/VeTjU7nRjRVVB0g4VvdMp3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PZgeka6u5mJreIR9QMT8GysTS5Sjxx1z2wi53z+ktlkFeVxGs0z1QeH4FAZY0M5os3zHc7PgxxhxtikFmOmNpo35aTtn5EbDVUVDiWkGE38qV1IsrF7WoeyCfBykmZF1rIzzJj2TofJAIhrvzoe0ZS4NNPeCFcUeMdXKLUjt9r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYcKCJ7N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYcKCJ7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B251F000E9;
	Sat, 23 May 2026 09:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779527561;
	bh=DN1DuuFJX+lGLYyWjrzAwfgrBzUuAwM+cDQ1g/MrcDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LYcKCJ7NTV6TjUvqXQpoCxcFrS+BLHdtfz+ouj5v1om+WVarhSYzRBK9I4TCoC2HF
	 aCSroUuLhcK3sppVx88BUZfrSc8IUiwplY9lOOgAg4ossr0SrlFYa1VWm6ctxyhz6N
	 Ajv0Pg5t2A4GSPkhZOFvbJxZNWhD82pDCPXmzejhjhuyQ5msxIhpMIPqr8j42yPiWa
	 +YUnzgnBekBBKCxOciJnyrxfjRPZVf54SxCHGU3DlYm/Xj4MuTfh1aBRStbaZKALT4
	 kuKRDsIZShZbj6ktU3xb3Ouo7ZtGNTCSaMVi+q0i/cKMr1PZ86mB7yJjRk6Y8cn4QZ
	 FlwpXpOKx10Og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 bpf-next 11/11] selftest: bpf: Add test for
 BPF_SOCK_OPS_RCVQ_CB.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260523083001.2911931-12-kuniyu@google.com>
References: <20260523083001.2911931-12-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 09:12:41 +0000
Message-Id: <20260523091241.59B251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The test case incorrectly asserts that `SO_RCVLOWAT` is automati=
cally updated to `RPC_DESC_SIZE` (8) immediately after `recv()` reads the f=
irst RPC frame.
- [Low] Multi-line comments do not follow the mandatory BPF subsystem style.
- [Low] Incorrect ASSERT macros used for file descriptor validation.
--

commit ab873db7faa26eaced426077409e35dd60974a4f
Author: Kuniyuki Iwashima <kuniyu@google.com>
Subject: selftest: bpf: Add test for BPF_SOCK_OPS_RCVQ_CB.

This commit introduces a new selftest for the BPF_SOCK_OPS_RCVQ_CB hook.
It simulates an RPC frame exchange over TCP to verify that a BPF program
can dynamically adjust sk_rcvlowat and properly control epoll wakeups.

> diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c b/too=
ls/testing/selftests/bpf/prog_tests/tcp_autolowat.c
> new file mode 100644
> index 0000000000000..5e971c42a32a4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c

[ ... ]

> +	{
> +		.desc =3D {
> +			{.header_len =3D 100, .payload_len =3D 150},
> +			{.header_len =3D 200, .payload_len =3D 500},
> +		},
> +		.event =3D {
> +			{ .type =3D RPC_EVENT_AUTOLOWAT,	.val =3D 1},

[ ... ]

> +			/* skb has the first payload and 1 byte of the next descriptor. */
> +			{.type =3D RPC_EVENT_SEND,	.len =3D 150 + 1},
> +			{.type =3D RPC_EVENT_EPOLL,	.nfds =3D 1},
> +			{.type =3D RPC_EVENT_RCVLOWAT,	.rcvlowat =3D RPC_DESC_SIZE + 150 + 10=
0},
> +			/* After reading the first RPC message, SO_RCVLOWAT should be RPC_DES=
C_SIZE. */
> +			{.type =3D RPC_EVENT_RECV,	.len =3D RPC_DESC_SIZE + 150 + 100},
> +			{.type =3D RPC_EVENT_EPOLL,	.nfds =3D 0},
> +			{.type =3D RPC_EVENT_RCVLOWAT,	.rcvlowat =3D RPC_DESC_SIZE},

[Severity: Medium]
Does this assertion accurately reflect the kernel's behavior?

The test calls recv() here, which executes in process context. However,
tcp_recvmsg() does not trigger the BPF_SOCK_OPS_RCVQ_CB hook, as that hook
only runs when new SKBs are enqueued from the network stack.

Since no new network packet has arrived yet, the BPF program hasn't run to
update sk->sk_rcvlowat. Could this cause sk->sk_rcvlowat to remain at 258
instead of dropping to 8 (RPC_DESC_SIZE), resulting in a test failure here?

> +			/* The second descriptor is available. */
> +			{.type =3D RPC_EVENT_SEND,	.len =3D RPC_DESC_SIZE - 1},
> +			{.type =3D RPC_EVENT_EPOLL,	.nfds =3D 0},
> +			{.type =3D RPC_EVENT_RCVLOWAT,	.rcvlowat =3D RPC_DESC_SIZE + 200 + 50=
0},
> +		},
> +	},
> +};

[ ... ]

> +static int tcp_autolowat_setup_cb(struct tcp_autolowat_test_cb *cb, int =
family)
> +{
> +	struct epoll_event ev =3D {};
> +	int err;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(cb->fd); i++)
> +		cb->fd[i] =3D -1;
> +
> +	cb->saved_netns =3D open("/proc/self/ns/net", O_RDONLY);
> +	if (!ASSERT_NEQ(cb->saved_netns, -1, "save netns"))

[Severity: Low]
Is it preferred to use the ASSERT_OK_FD() macro here instead of ASSERT_NEQ()
for file descriptor validation, to better align with modern BPF selftest
patterns?

> +		goto err;
> +
> +	err =3D unshare(CLONE_NEWNET);
> +	if (!ASSERT_OK(err, "unshare"))
> +		goto err;
> +
> +	err =3D system("ip link set dev lo up");
> +	if (!ASSERT_OK(err, "set up lo"))
> +		goto err;
> +
> +	cb->server =3D start_server(family, SOCK_STREAM, NULL, 0, 0);
> +	if (!ASSERT_NEQ(cb->server, -1, "start_server"))

[Severity: Low]
Similarly, could this use ASSERT_OK_FD() as well? This pattern is repeated
for connect_to_fd(), accept(), and epoll_create1() below.

> +		goto err;
> +

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/tcp_autolowat.c b/tools/te=
sting/selftests/bpf/progs/tcp_autolowat.c
> new file mode 100644
> index 0000000000000..41eacfdb34aa1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tcp_autolowat.c

[ ... ]

> +	/* Since LLVM commit 324e27e8bad83ca23a3cd276d7e2e729b1b0b8c7,
> +	 * clang omits the "copy_len =3D=3D 0" check below, which is necessary
> +	 * to satisfy the BPF verifier's range check for bpf_skb_load_bytes().
> +	 */

[Severity: Low]
This isn't a bug, but could we update these multi-line comments to follow
the preferred BPF subsystem style, where the opening /* is placed on its
own line?

> +	barrier_var(copy_len);
> +
> +	/* Do not swap the order of the two copy_len checks below.
> +	 * The BPF verifier somehow does not properly track the minimum
> +	 * value for 'copy_len =3D=3D 0'.

[Severity: Low]
This isn't a bug, but this comment also starts the text on the same line as
the opening /*.

> +	 *
> +	 * 91: (15) if r7 =3D=3D 0x0 goto pc+40      ; R7=3Dscalar(smin=3Dsmin3=
2=3D-247,smax=3Dsmax32=3D8)
> +	 * 92: (25) if r7 > 0x8 goto pc+39       ; R7=3Dscalar(smin=3Dsmin32=3D=
0,smax=3Dumax=3Dsmax32=3Dumax32=3D8,var_off=3D(0x0; 0xf))
> +	 *
> +	 * This does not occur if copy_len is u32.
> +	 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523083001.2911=
931-1-kuniyu@google.com?part=3D11
