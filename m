Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDDA3F9F48
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360042; cv=none; b=sKlaE4B8K9xKilhWYdyExCcrwO5FgaXaBMnhFG1VzgwehHISHW8Vp6xWoAniT70nZARbC0HqmRZNoqqChMh/qJY3IWm4OL5uNtE6KPRSkgEt/WCuHTpuoEvsv+ov9I1hMW3h2PTwPl7ZUUNj3CgT1K6e+D6TGArpPqWLUVWtZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360042; c=relaxed/simple;
	bh=plHDj5olU5m2+LJbsn98tEbRPd24gkYxsshHwGw/KkQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kveEqV/uiGhGjyiFibTuFdWM+6a6MTl34cA7vtLmPut2mQS9VlKkjq+Bz/U2fkqWXpuqVzifDroTLOdpxWToSmMPigTl/tdjYJMJSYRneDlyI/5tA69Lquwqzx80TYLnivV+1wY7H21+cEccK3EH1AhdG9vVOp7a7xXwzH8En2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyO2PG7/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyO2PG7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CE21F000E9;
	Mon,  6 Jul 2026 17:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783360041;
	bh=YyKmcFquD6xktHpZBLPKxEqhgha9JkEwblru1Dd4KPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UyO2PG7/JrIYw6LNloHpd973Vsny8F8o4JE0LZ1q4GQiG+SZqV97TLCrHim1UXHLR
	 nova8c8v/p2tIL2yEpp352nSFST31d7cpHB3pbl5ysYULUvT11FgiBLogd0lkUG6KD
	 1NROFUbzd9J7Q2XVIzCPhTXdqGz87dg9S6U6fk5ZQeAK9wKoHIvqVdayzQ1xIkS8ZS
	 Dut4t57sKc5rzdnbEhFFJ3Whmut27xbYePR+u6LoB4+MenJ1Jx+U10nQCQxgCrwccf
	 13S2J0AnProVVdxmbWFYPuRJQgB6FGv7va8fgjx8jpoGjooHlhAKeZkSANPgdDdmc4
	 p3OwUMBmFg9fA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 15/15] selftests/bpf: Add test for
 bpf_tcp_ops header option hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260706171918.317102-16-ameryhung@gmail.com>
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-16-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 17:47:20 +0000
Message-Id: <20260706174721.14CE21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comments in the new BPF selftest program do not follow t=
he mandatory BPF subsystem comment style.
--

commit 0974a803b9e5fed2b4e8c0c5360735a19cae9901
Author: Amery Hung <ameryhung@gmail.com>

selftests/bpf: Add test for bpf_tcp_ops header option hooks

This commit adds a test for the bpf_tcp_ops header option hooks. It uses a
struct_ops program to reserve, store, and load an experimental TCP header
option to ensure the parse_hdr, hdr_opt_len, and write_hdr_opt callbacks
work together correctly.

> diff --git a/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c b/tools/=
testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c
> new file mode 100644
> index 0000000000000..46618a604d965
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c

[ ... ]

> +SEC("struct_ops")
> +void BPF_PROG(test_hdr_opt_len, struct sock *sk, struct sk_buff *skb,
> +	      struct request_sock *req, struct sk_buff *syn_skb,
> +	      enum tcp_synack_type synack_type, unsigned int *remaining)
> +{
> +	hdr_opt_len_cnt++;
> +
> +	/* Reserve TEST_OPT_LEN bytes; the helper decrements *remaining. Stacks
> +	 * with other progs in the cgroup hierarchy.
> +	 */

[Severity: Low]
This isn't a bug, but does this follow the BPF subsystem comment style?

Multi-line comments under BPF-related paths should have the opening /* on
its own line.

> +	bpf_reserve_hdr_opt(ctx, TEST_OPT_LEN, 0);
> +}
> +
> +SEC("struct_ops")
> +void BPF_PROG(test_write_hdr_opt, struct sock *sk, struct sk_buff *skb,
> +	      struct request_sock *req, struct sk_buff *syn_skb,
> +	      enum tcp_synack_type synack_type, __u32 opt_off)
> +{
> +	__u8 opt[TEST_OPT_LEN] =3D {
> +		TEST_OPT_KIND, TEST_OPT_LEN, TEST_OPT_D0, TEST_OPT_D1,
> +	};
> +
> +	/* bpf_store_hdr_opt() takes the program ctx (the kernel reads the
> +	 * outgoing skb from it); it appends after any options already written
> +	 * in the reserved window, rejects duplicates, and confines the write to
> +	 * the header option scratch. Stacks across progs in the cgroup hierarc=
hy.
> +	 */

[Severity: Low]
This is a similar style issue. Should the opening /* be placed on its own l=
ine
to match the required multi-line comment format?

> +	if (bpf_store_hdr_opt(ctx, opt, sizeof(opt), 0))
> +		return;
> +
> +	write_cnt++;
> +}
> +
> +SEC("struct_ops")
> +void BPF_PROG(test_parse_hdr, struct sock *sk, struct sk_buff *skb)
> +{
> +	__u8 opt[TEST_OPT_LEN] =3D {
> +		TEST_OPT_KIND, TEST_OPT_LEN, TEST_OPT_D0, TEST_OPT_D1,
> +	};
> +
> +	parse_cnt++;
> +
> +	/* Look up the experimental option written by test_write_hdr_opt() in
> +	 * the incoming skb. For an experimental kind the search matches on the
> +	 * 2-byte magic in opt[2..3]; on a match the found option is copied back
> +	 * into opt[].
> +	 */

[Severity: Low]
Here is another multi-line comment that starts on the same line as the open=
ing
/*. Could this be reformatted to align with the modern BPF comment guidelin=
es?

> +	if (bpf_load_hdr_opt(ctx, opt, sizeof(opt), 0) < 0)
> +		return;
> +
> +	found_d0 =3D opt[2];
> +	found_d1 =3D opt[3];
> +	found_cnt++;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706171918.3171=
02-1-ameryhung@gmail.com?part=3D15
