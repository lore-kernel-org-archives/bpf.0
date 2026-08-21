Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AB92D8762
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351960; cv=none; b=oj6EGfVuNRNedZgndb3UMzh6WgyyOl/IKI418MqVH6YcgxAX7jF04k0Lc1om9AMjfNQZ2X2I6EM+RJpFu59oTNE6TpBIjoNTCxxzu7sL2IeiT283lUJ4BWg0lT4sP0Po63WjZVStaMf064LfaCz4bLPOeDDkllXAgMtKnsO6y6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351960; c=relaxed/simple;
	bh=W6/xEExPO3WyNSEZc7AgOLqxSDqPqhHQKEIyK9eJcQ0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Jvc9hL02WFAAqhSKl4/rkoGnWIx7p7oNyomTYvP2rZmaljAEehVjTRktfv+J/zVOwTgmdk4FoJFwAAVWph0b/RmMx4S7G/i/xgXWVOmLAvXtZ7y78KL+a9gnkHaOqQtLw39PQ552L/KaLtBYCZvYBlW3ImyNhelEFqdhXTek93M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmlXlLTs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmlXlLTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44961F000E9;
	Fri, 21 Aug 2026 22:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787351959;
	bh=6YigBvwSZCoAyDh1dzBrZf/wtvINyt6zeSYHIFaiorc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cmlXlLTsRNygDVBTwZAxIjxZxNjYCXrkjJT4h3UQIGkBg4gDt0I16E5jtFz8/qtTD
	 RB2mHfYGuPVKB97i+T55C7JR7GJYB1YkBhssXyGKqti94jeYD2mUpGD6XjAcXDwgg/
	 pyKVih2GjhYmREhYx1IkO6yeIHLN2ShZZ4zuPamVa5Ny6a917Wz+zqqpHp8AsF3GCm
	 zrv7nhrtKZZ9cgEG8nemVaHBf9tXFAaXcgJl71jJaESbMPmJexteyF/zvGb4eQATJV
	 YfYG6iSYVl7FeglWCJJe3Nv/w9HGNfBGd3h9DDGKzTtqCfI0pBWUeQ+HpwqgxphrNy
	 VwR2Xk4x8NLzA==
Content-Type: multipart/mixed; boundary="===============2331214485665079719=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <342776326a4910ee5fd393fbd1446c975a55c218e0b6ffa9dbe42b191626469d@mail.kernel.org>
In-Reply-To: <20260821214111.1120748-4-daniel@iogearbox.net>
References: <20260821214111.1120748-4-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 03/11] bpf: Raise the bound on a program's signature size
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: brauner@kernel.org,kpsingh@kernel.org,ast@kernel.org,john.fastabend@gmail.com,a.s.protopopov@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 21 Aug 2026 22:39:18 +0000 (UTC)

--===============2331214485665079719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a93a8dc427d8c..575c4e5e44432 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20972,6 +20972,13 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	return 0;
>  }
>
> +/*
> + * Upper bound on the PKCS#7 signature blob passed with a program. Comfortably
> + * above the largest signature the kernel can verify, and far below anything
> + * that would make rejecting a load expensive.
> + */
> +#define BPF_PROG_MAX_SIGNATURE_SIZE	(64 * 1024)
> +
>  static enum bpf_sig_keyring bpf_classify_keyring(s32 keyring_id)
>  {
>  	switch (keyring_id) {
> @@ -21011,13 +21018,10 @@ static int bpf_prog_verify_signature(struct bpf_verifier_env *env,
>  	u64 data_sz;
>  	int err = 0;
>
> -	/*
> -	 * Don't attempt to use kmalloc_large or vmalloc for signatures.
> -	 * Practical signature for BPF program should be below this limit.
> -	 */
>  	if (!attr->signature_size ||
> -	    attr->signature_size > KMALLOC_MAX_CACHE_SIZE)
> +	    attr->signature_size > BPF_PROG_MAX_SIGNATURE_SIZE)
>  		return -EINVAL;
> +

Does this replacement actually lower the accepted signature size on
kernels with PAGE_SIZE >= 64 KiB?

The old bound was page-size dependent (include/linux/slab.h):

  #define KMALLOC_SHIFT_HIGH    (PAGE_SHIFT + 1)
  #define KMALLOC_MAX_CACHE_SIZE        (1UL << KMALLOC_SHIFT_HIGH)

so the previously accepted maximum was:

  PAGE_SIZE 4 KiB  -> 8 KiB    (new 64 KiB: raised)
  PAGE_SIZE 16 KiB -> 32 KiB   (new 64 KiB: raised)
  PAGE_SIZE 64 KiB -> 128 KiB  (new 64 KiB: HALVED)

On CONFIG_ARM64_64K_PAGES or ppc64 64K-page kernels, a BPF_PROG_LOAD
carrying a signature blob between 64 KiB and 128 KiB was accepted by the
pre-patch kernel and now returns -EINVAL. There is no other place that
validates attr->signature_size, so nothing softens the new rejection.

The changelog only describes the 4 KiB-page case ("signature_size is
bounded by KMALLOC_MAX_CACHE_SIZE, which is 8 KiB on a 4 KiB page system")
and frames the change purely as "Raise the bound"; the reduction on
64 KiB-page configurations is not mentioned.

Is the intent to make the ABI page-size independent? If so, should the
changelog say that explicitly? Or if the intent is only to raise, should
the constant be >= 128 KiB (or max(64 KiB, KMALLOC_MAX_CACHE_SIZE))?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32530917987
--===============2331214485665079719==--
