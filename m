Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5283EEAC4
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522425; cv=none; b=AQjKKA+/8IhwdIGyRHLPtTBEI6fM0TlSS27oy3pMnOILFz1VbHe4fDQ8OExUgaXeLCqRsYH62xeFulaN4I0NVs3PKV7+ooV2femBfAHEW3sfqfbzJIywbtG9qES3esKRZCnUNQ5ICtlEb2blrzxUBkBO+ztYozyU7C0tRKFgABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522425; c=relaxed/simple;
	bh=dNvcqoUCcYTyHg/km8VjdElkHnkfn5ohQaEyuIRQY5w=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XLOeGsVmJ3vvb5XfYS6TuMBReiSogcsf3yJwKlH5U/fFab8fFkaESeBR27/f3BKfw4lngeE+83NlNeXK8TBkCPP1XpxNjK68WBcZr5tRCRL2jz8Y3WQnxcWqVLlGgGM/F43iboOnDOpjtMPhsVvFpdeklgpTUlV934jV/Z00Sqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhwLP5b2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhwLP5b2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418A81F00A3D;
	Fri,  4 Sep 2026 11:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788522423;
	bh=mL8KxEc/yCiVy52YW/rk1Oi334vn+K8Rm9LHknC94IQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fhwLP5b2oChfV2L6ZcVm/vpVRYknn1AgaoADobCT/f2NhJ2QFIIBaI7zzjGPCXEbj
	 hhj1jc7eiQfS+7WF8BvxIA77ZSOXg7enAGFZI42ZT8pIFms8bglStbpM+K3JjiCu/G
	 Tjjci7alX+nBz6jHo04NQ4V2c8Ec7JchedX7HxSyIPZBfpamiae17I0D19e/jjJR9E
	 pHUv+HuHGwMbww/Szzgz21KmfdxM9NBDHno1LvF6mbySHfaFVWWH8W7s/cKVzxVMBP
	 tcMKjFh5MzfQ/ZB6aqeaTRvWxtS11pXcTFFyA1tt3KzlVYVJpR99juDh7P0QrSuMon
	 0UUj+tD7M8bVQ==
Content-Type: multipart/mixed; boundary="===============1571753818090733522=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <374c89f0b9813168ab25d96a3751bef113d1e731c1199d6ccc62aa4935c9d82f@mail.kernel.org>
In-Reply-To: <20260904104203.345917-7-memxor@gmail.com>
References: <20260904104203.345917-7-memxor@gmail.com>
Subject: Re: [PATCH bpf v1 6/8] selftests/bpf: Test imprecise scalar kptr stores
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 11:47:03 +0000 (UTC)

--===============1571753818090733522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test imprecise scalar kptr stores

This isn't a bug, but should this read "Add a verifier regression test"?
As written the first sentence of the commit message says the patch adds a
regression.

> diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> index 5e25ca806060c..eee35d203b66f 100644
> --- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> @@ -409,4 +409,41 @@ int reject_scalar_store_to_kptr(struct __sk_buff *ctx)
>  	return 0;
>  }
>
> +SEC("?tc")
> +__description("reject imprecise scalar store to kptr after state pruning")
> +__failure __msg("invalid kptr access, R7 type=scalar")
> +__naked void reject_imprecise_scalar_store_to_kptr(void)
> +{
> +	asm volatile (
> +		"r0 = 0;"
> +		"*(u32 *)(r10 - 4) = r0;"
> +		"r2 = r10;"
> +		"r2 += -4;"
> +		"r1 = %[array_map] ll;"
> +		"call %[bpf_map_lookup_elem];"
> +		"if r0 == 0 goto l2_%=;"
> +		"r6 = r0;"
> +		"r9 = *(u64 *)(r6 + 0);"
> +		"if r9 != 0 goto l0_%=;"
> +		"r7 = 0;"
> +		".rept 10;"
> +		"r5 = 1;"
> +		".endr;"

This isn't a bug, but would a one-line comment above the padding help -
something noting that the ten filler insns are there to get a state
checkpoint recorded at l1_%= (the >=8 insns / >=2 jumps heuristic), so a
future reader knows the test silently loses coverage if that block shrinks?

> +		"goto l1_%=;"
> +	"l0_%=:"
> +		"r7 = 0x4141414141414141 ll;"
> +		".rept 10;"
> +		"r5 = 1;"
> +		".endr;"
> +	"l1_%=:"
> +		"*(u64 *)(r6 + 8) = r7;"
> +	"l2_%=:"
> +		"r0 = 0;"
> +		"exit;"
> +		:
> +		: __imm(bpf_map_lookup_elem),
> +		  __imm_addr(array_map)
> +		: __clobber_all);
> +}
> +
>  char _license[] SEC("license") = "GPL";

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33865340224
--===============1571753818090733522==--
