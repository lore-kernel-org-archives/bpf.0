Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1F6560ADD
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098574; cv=none; b=s1ElCe2fMWY0n+SALswPC9ETcbhuYgglamBWnOyFwOKe5aJNvddSjNUgPeyCs3iTEMTRRQWC8ZozvdbqA8vn1mmRE1gdWu2ZKhB+d4MEyPxTgYrPg/HQQFBWIBTYZDz+YXfwMBHeqMvFg5WhyG7oSLz6y27/1KLJ2IihlO5/njk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098574; c=relaxed/simple;
	bh=BIo49olaJXjci1u8m6ub24+GV4jAZ6qFvc5+WgEAi08=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RvriJVjAVg4X2c5CioqxUO6DS8PumcHhhsZlAKhX3PCNzv3OjAdqWXFiC5ApE94tLcxzZ+FrV7h3s2xDQrtgD2SceGUXujey1NEk1O3SLUQc3IUWhorAYCk0uQHPpNUpwwin9/AIJCH9QaiMwUSmwoUMjYj0D06+mjJklDAejt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6X4cExV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6X4cExV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7191F000FF;
	Tue, 22 Sep 2026 17:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790098572;
	bh=vYaV9DSxGmxh044gSHeRCZ1929sB6fdnXdVSCtlKNkw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D6X4cExVQ4qCTM5bgHD2E1KXHPs1uOuQNnTeiwlCmnj7Ngd0ci1yJqdLZ1cwLEJzl
	 +1YJVf8LdALPIAg/rij/SPmHYyv91cQC5AipBvOv09YNTujjeawOubC6jLYHuD+Od8
	 +dO+pgu/xcsCHolnUF6cxPu1uCyy/545FCRsZao6Y2Vue1wl3N8XUHS8pdFte9o3v+
	 qBgYoQOyGr6RIgkd5K0Gm/eAqkDaxqTYbnOHa/3NlhIpolvKjMxJE+1r2RXhZhnefN
	 L24YioI4kRGWb+WYlfoYCjglqaj1ttM9E9fp5ii51dEqB1tT0Z7SbFm/1rnwpwq6iF
	 EOMsetun2dajQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 04/11] selftests/bpf: Add selftests for
 rx_queue_mapping context access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922172028.6269-5-emil@etsalapatis.com>
References: <20260922172028.6269-1-emil@etsalapatis.com>
 <20260922172028.6269-5-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:36:11 +0000
Message-Id: <20260922173612.4B7191F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: selftests fail to verify bounds tracking of rx_queue_mapping
--

commit 90d4583595dcbfcce26a9758d799968a757439e5
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: Add selftests for rx_queue_mapping context access

This commit adds selftests for the rx_queue_mapping field read from
struct sock to ensure the verifier properly tracks its 0 bit state and
width.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/te=
sting/selftests/bpf/progs/verifier_sock.c
> index 2a136c917680f..565c4d8bc3fa3 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_sock.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_sock.c

[ ... ]

> +SEC("socket")
> +__description("skb->sk: sk->rx_queue_mapping [no sign extension]")
> +__success __success_unpriv __retval(0)
> +__naked void sk_rx_queue_mapping_no_sign_ext(void)
> +{
> +	asm volatile ("					\
> +	r1 =3D *(u64*)(r1 + %[__sk_buff_sk]);		\
> +	if r1 !=3D 0 goto l0_%=3D;				\
> +	r0 =3D 0xdead;					\
> +	exit;						\
> +l0_%=3D:	r0 =3D *(u32*)(r1 + %[bpf_sock_rx_queue_mapping]);	\
> +	r0 >>=3D 32;					\
> +	exit;						\

[Severity: Medium]
Does this sequence actually verify the verifier's 0-bit state tracking
of rx_queue_mapping?

The program shifts the loaded value right by 32 and exits. The verifier
always accepts returning an unknown initialized scalar in this context. At
runtime, the CPU zero-extends the value, so it always evaluates to 0 and
passes the __retval(0) check, regardless of what the verifier's static
analysis concluded about the bounds.

> +"	:
> +	: __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
> +	  __imm_const(bpf_sock_rx_queue_mapping, offsetof(struct bpf_sock, rx_q=
ueue_mapping))
> +	: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("skb->sk: sk->rx_queue_mapping [narrow load mask]")
> +__success __success_unpriv __retval(0)
> +__naked void sk_rx_queue_mapping_narrow_load_mask(void)
> +{
> +	asm volatile ("					\
> +	r1 =3D *(u64*)(r1 + %[__sk_buff_sk]);		\
> +	if r1 !=3D 0 goto l0_%=3D;				\
> +	r0 =3D 0xdead;					\
> +	exit;						\
> +l0_%=3D:	r0 =3D *(u16*)(r1 + %[bpf_sock_rx_queue_mapping]);	\
> +	r0 >>=3D 16;					\
> +	exit;						\

[Severity: Medium]
Similarly, does this narrow load test pass at runtime without strictly
asserting the verifier's internal bounds tracking?

Like the previous function, this shifts the 16-bit load right by 16 and
exits. It seems this will also implicitly pass at runtime rather than
causing a verification failure if bounds tracking regressions occur.

> +"	:
> +	: __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
> +	  __imm_const(bpf_sock_rx_queue_mapping, offsetof(struct bpf_sock, rx_q=
ueue_mapping))
> +	: __clobber_all);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922172028.6269=
-1-emil@etsalapatis.com?part=3D4
