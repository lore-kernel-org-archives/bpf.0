Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A44344031
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787055093; cv=none; b=p8hvfOfI5OjLKtKr6asxGMSguS+HLjZt6Q9fAyV7WD+NO2FRKse9WWCWdJ8bpFEHuYtgo/GWW7Na6Z0bjS+Ajsg2keS4AfcliuuLzDFfn06WZpZ5yNlmBncmHy5iJ1qzOLAHLrcJXHBCYdScT1x94arOOFuFGXCeGek0qkhtPU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787055093; c=relaxed/simple;
	bh=p7rLJWWP2W5EMa+bFpeL9JBy5nPqq9Je5f4l0FV4xmA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SzPt6BQ5yfRqPGJP17GoQR71UM2FN5N486Cw2DCD6azMGIgW12eZGr8j7Qy/aC1sibGjribKFN/FQUqKQzzepCiStQuf7aXf/ktasJIHoOuYhcupkYWE9dPsjUWawh7004+PsM/68MTNHNq4N+EojuZZSyHgh4sGOAopmWfty9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g43owLvp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g43owLvp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6740B1F000E9;
	Tue, 18 Aug 2026 12:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787055091;
	bh=J9bIBpTw2GIMF0U2KaosVuQdIm8S6jnENLrFvzPsFzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g43owLvpCZpkTpJdSgJUXf/CRLhytFymFPXDrCHcAPg5i7xha3uXzZ6uNfihbFOWX
	 VVBqTOqOdeH4SdumCaaZABRXdtDbCdZ8OOBhn+vHRAmgeSOTexIc0l6x8Mdr6LIOpw
	 jE4u+rQWfT4fWcmcshAvYo2sgVnLyw99HutQl5ke5O/5CJEQNJ/VQog1cL7WdZI1mU
	 p0eQ8fPuJ+0dn69nOZBd98j+AmhbSDTcFFfDH/T4tXxPCFIGXHipkUD3Okj5KV99tV
	 Z5zfWH8KUm9dgC2nJzLtWbS2S0mGwb8qkCW6+TjeB5aXiduqnVJwwe0L1mP8yATGoo
	 fLgrXngxxyD6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/bpf: tc_tunnel - validate decap tunnel state
 without false-pass gaps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nick Hudson" <nhudson@akamai.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260818120308.623905-1-nhudson@akamai.com>
References: <20260818120308.623905-1-nhudson@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 12:11:30 +0000
Message-Id: <20260818121131.6740B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The variable `decap_gso_validation_seen` is introduced to track =
whether GSO metadata was present during decap validation, but it is never a=
sserted in the test suite.
--

--- Patch [1]: [PATCH] selftests/bpf: tc_tunnel - validate decap tunnel sta=
te without false-pass gaps ---
commit f4a6b83a5918e8a74560dcb08d2827677bbdfe70
Author: Nick Hudson <nhudson@akamai.com>

selftests/bpf: tc_tunnel - validate decap tunnel state without false-pass g=
aps

This commit tightens the tc_tunnel selftest to guard against false passes
in GSO decap validation. It asserts that decap validation paths are executed
during large-send phases and verifies post-decap states.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c b/to=
ols/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
> --- a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c

[ ... ]

> @@ -406,7 +415,18 @@ static void run_test(struct subtest_cfg *cfg)
>  	/* Replace kernel decapsulation with BPF decapsulation, test must pass =
*/
>  	if (!ASSERT_OK(configure_ebpf_decapsulation(cfg), "configure ebpf decap=
sulation"))
>  		goto fail;
> -	ASSERT_OK(send_and_test_data(cfg), "connect with encap and decap progs"=
);
> +	if (!ASSERT_OK(send_and_test_data(cfg, skel), "connect with encap and d=
ecap progs"))
> +		goto fail;
> +	if (!ASSERT_NEQ(skel->bss->decap_validation_seen, 0,
> +			"decap validation executed"))
> +		goto fail;
> +	if (!ASSERT_EQ(skel->bss->decap_expect_large_send, 0,
> +		       "decap large-send marker reset"))
> +		goto fail;
> +	if (cfg->test_gso) {
> +		ASSERT_NEQ(skel->bss->decap_large_send_validation_seen, 0,
> +			   "decap validation executed for large send");
> +	}

[Severity: Medium]
Is decap_gso_validation_seen missing an assertion here?

The BPF program tracks this variable to verify the presence of GSO metadata,
but it appears the userspace test runner never actually checks it.=20

If a kernel bug strips the GSO metadata before reaching the BPF program,
shinfo->gso_size would be 0, bypassing the inner GSO validations. The test
might still pass because it only asserts decap_large_send_validation_seen.

> diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/t=
esting/selftests/bpf/progs/test_tc_tunnel.c
> --- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> +++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c

[ ... ]

> @@ -690,7 +695,21 @@ static int decap_internal(struct __sk_buff *skb, int=
 off, int len, char proto,
> =20
>  	kskb =3D bpf_cast_to_kern_ctx(skb);
>  	shinfo =3D bpf_core_cast(kskb->head + kskb->end, struct skb_shared_info=
);
> +
> +	if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
> +		     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
> +		decap_validation_seen++;
> +
> +	if ((flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
> +		      BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) &&
> +	    decap_expect_large_send)
> +		decap_large_send_validation_seen++;
> +
>  	if (shinfo->gso_size) {
> +		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
> +			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
> +			decap_gso_validation_seen++;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818120308.6239=
05-1-nhudson@akamai.com?part=3D1
