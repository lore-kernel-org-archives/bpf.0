Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795830085;
	b=A96wJZlemSmDVDn2/s8FookmNdKoi9+6ew5nDJjPC5M3XTn3odasmKnz/kjCkLHWl8SY
	 /kpBHnXN1TGpEIJcs3Y4CchR4dPOOBG89S1uhbHuSOV7GVAV11rtO7aAJhkyWDNOL1A6e
	 8s6dbLO/Nu29iNPDpYkmZ70wtq/jMoLgpGCJgW6jCMbfCJYufjASeC1b9Ml7mEjspCAXF
	 XgmuUJppNpWEBgmoVoamuYGRsZXyXs3yfm1Jpo7FKHRPwo+NQquguaJQCc94xK7fBAkyA
	 Ps6vNSSSRTHpBQ4/SFfWRqqL9e5ZrSrKIKypEKyyy2JI78lWIozJatmAFOtjQ2anvkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795830085;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Rypc6+am/xaFxTFknjGuuOfY8ss6VbIJG57negI0WPE=;
	b=ohobIXSIppKD4ZZioyo0eQ8UznYbhDe1tAwbh4PCk8hDjh29DflSclizcEFTU1PGKi5j
	 sns8/yMwZ3jMlC3FmvcjIMnBKBRuFp1+6y2miHWvUDtVzUglUorNdHmq6uIrFsj/UKvee
	 JFqqWh7pbewp3CpIOjJOnxf3jK6JPnewlCGK5awWTMvSrt/GL/ldXFbT+nVPW1oj5/kL/
	 bP9SQoyCXebDZvTklezbS3o9PtY3+vEmn5tcXfZBUq7IG2r89bqxkZZmL0NE36tCHJ2dw
	 t9l2Ferez7q91RaMwiTqm0QK5N0P+52WJ0AnNY5UfH23kEpVoGTg5cEEHb8JduMQ6fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BTdJM5kL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43495606A31C
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 01:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BTdJM5kL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8D91F000C1;
	Sat, 28 Nov 2026 01:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795830084;
	bh=Rypc6+am/xaFxTFknjGuuOfY8ss6VbIJG57negI0WPE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BTdJM5kLHN+6InAucTAxXM+oUT4TYO6feWaXBKI2RBhnTrDq6p58ngmFej6NfMNoP
	 SvQm9Pu6qGGEVz4ks3vU1olkHgHbR34mT3J9w/w1L0vYPFhPYJa5KroL19WTnHv7Kc
	 9OFrzjSbgIoEa9J+qJpm4GogVdIlph35dq27r2KI7d6Qw9UntMPakfUpn/eqFFVjr1
	 BVYblyH79pPMk4pvvLZt/FgO84t+atYkriRfhqbG99g/iv6yWfjtOkVizxbPd3F2nd
	 22vyi6QWhJO8JLkwfE8eip4EUTa7iXyV4g3/OR52LBTWpK9VbUt634L1KlgszfsXg+
	 TxfVON+7TzH3A==
Message-ID: <sashiko-outbox-238410@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/3] bpf, x86: Skip the PROBE_MEM address
 range check under SMAP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <f2beca95aa1eb81f00c6baf408c681063e13ce83.1795829324.git.memxor@gmail.com>
References: <cover.1795829324.git.memxor@gmail.com>
 <f2beca95aa1eb81f00c6baf408c681063e13ce83.1795829324.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 01:41:24 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] bpf, x86: skipping PROBE_MEM range check breaks
  flex_array_far_join() test
--

commit 519a06c0e9f33f01690a25837946e3048111ee57
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf, x86: Skip the PROBE_MEM address range check under SMAP

This commit omits the x86-64 JIT runtime address range check before
BPF_PROBE_MEM and BPF_PROBE_MEMSX loads when SMAP is enabled and the
program was loaded with CAP_BPF, relying on SMAP and the page fault
handler's exception table lookup instead.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index d51ae52fef719..019e5da72136d 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
[ ... ]
> @@ -4862,6 +4870,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ve=
rifier_env *env, struct bpf_pr
>  		addrs[i] =3D proglen;
>  	}
>  	ctx.cleanup_addr =3D proglen;
> +	/*
> +	 * With SMAP enabled, a PROBE_MEM load of a user address faults (#PF, or
> +	 * #GP with LASS) and the fault handler resolves the exception table
> +	 * entry of the program, as for an unmapped kernel address. That lookup
> +	 * only finds programs in the BPF ksym tree, so programs loaded without
> +	 * CAP_BPF keep the address range check, as do kernels without SMAP.
> +	 */
> +	ctx.probe_mem_check =3D !cpu_feature_enabled(X86_FEATURE_SMAP) ||
> +			      !bpf_prog_kallsyms_allowed(prog);
>  skip_init_addrs:

[Severity: Medium]
Does skipping the range check break the flex_array_far_join() BPF selftest
on x86-64 systems with SMAP enabled?

tools/testing/selftests/bpf/progs/verifier_btf_array_access.c:flex_array_fa=
r_join() {
	SEC("tp_btf/exit_mmap")
	__success __arch_x86_64
	__jited("	leaq	0xa00000(%rbx), %r11")
	__naked void flex_array_far_join(void)
}

That test is loaded with CAP_BPF and matches the "leaq 0xa00000(%rbx), %r11"
instruction from the PROBE_MEM range check to verify that the load was
converted to BPF_PROBE_MEM, so its __jited() check fails when
ctx.probe_mem_check is false.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795829324.gi=
t.memxor@gmail.com?part=3D2
