Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EAE2D6E6C;
	Wed, 19 Aug 2026 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787147367; cv=none; b=eHJzk95NjtAX5BNFEEJzQ209oiMoapLKFxiznqLIujcFFYTrQzB2AUlzwGVUA+YMC4wGk30EpiELeI311ZxcnXvG20HqWsZq6gLXvaAyHcU0y0ciTRyE5i6xkxuEQ+BzAzZfwBkK7IcY/LkY5PG+QNDBTq8pqWE5tFdGRpItOck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787147367; c=relaxed/simple;
	bh=76BV944DpjMrV2cm6y0p2iL6hov1/xND6aq7l9zyaQM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XABEFoFPheyDg0t75biK1uZW1y3TZgiJ61O8GdzPG3tVAmT2InZObJddIUo61pEVjBR+1aAEtNQV0EgBwGlr3d+k3u/3TmEjE59mSyJR+yFPGBRnrbSVVpr5Q8xeUj3NzK3i1lWiVqpc3dJossMuwGHTq2WyN+R3CM7C0399hcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMqwjWY2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMqwjWY2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12511F000E9;
	Wed, 19 Aug 2026 13:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787147366;
	bh=VPA81AHa7U28kBdDorMiNhbrDcZ/6QGeu80LYazQYQ8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nMqwjWY2WAIIvSxljEL/rmYL87Q3XOGCLHG2mayKBDlCIk+ZNj/nMSDQ1Yb0QT4VB
	 nohxnrYndrx4QGdMdP6vj34wfnq8D+35ScPag7sODXpTRzsRCrRZL1LIF0SkKg8kgH
	 jjC8yaOl+cuFrGsidFvRZY6SAQK1ZqohJtVgjfHZfFGDW2v9MmeXDUsB0hnBdU8jSi
	 Z6zlvW3hiMTrukWV2z030YzSF1y9M7ebUtdF5l2aq3GQXojy3aNki/Er7/xDg4CuyD
	 kEhKuXisY2RQOhXXUqh4lEwRM5oZzHUC+1GyvRLOx5HLCjZ3Sg9rT/xQ8fWEbMO0Wg
	 4z2T/fMYCc+cA==
Content-Type: multipart/mixed; boundary="===============6076552742003848626=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6f1ad36389faad6328320aa25b4e8b0ff7bac66913d11273ee1f6ce43dbbbfbf@mail.kernel.org>
In-Reply-To: <20260819125840.286434-2-jiayuan.chen@linux.dev>
References: <20260819125840.286434-2-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add reg-invariants test for speculative pointer arithmetic
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,paul.chaignon@gmail.com,ameryhung@gmail.com,shung-hsi.yu@suse.com,danjwade95@gmail.com,kafai.wan@linux.dev,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 19 Aug 2026 13:49:25 +0000 (UTC)

--===============6076552742003848626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> index bc038ac2df98..91d4600aa677 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -2267,6 +2267,47 @@ __naked void deduce64_from_32_wrapping_32bit(void)
>  	: __clobber_all);
>  }
>
> +/*
> + * Unprivileged variable pointer arithmetic on a PTR_TO_MAP_VALUE whose
> + * offset collapses to a constant. The Spectre-v1 speculative path snapshots
> + * the pointer while its r32 has just been blanked but its offset not yet
> + * synced; the following register move used to trip reg_bounds_sanity_check()
> + * ("const subreg tnum out of sync with range bounds"). With
> + * BPF_F_TEST_REG_INVARIANTS that violation turns into a load failure, so the
> + * unprivileged program must still load.
> + */

This isn't a bug, but would it read more clearly to say the base
PTR_TO_MAP_VALUE has a constant offset that the speculative snapshot
captures, rather than that the offset "collapses to a constant"? The
addend itself has to stay variable for sanitize_ptr_alu() to simulate the
path at all.

> +SEC("socket")
> +__success __success_unpriv
> +__flag(BPF_F_TEST_REG_INVARIANTS)
> +__naked void spec_ptr_alu_const_offset(void)
> +{
> +	asm volatile ("							\
> +	call %[bpf_ktime_get_ns];					\
> +	*(u64*)(r10 - 16) = r0;						\
> +	r1 = 0;								\
> +	*(u64*)(r10 - 8) = r1;						\
> +	r2 = r10;							\
> +	r2 += -8;							\
> +	r1 = %[map_hash_8b] ll;						\
> +	call %[bpf_map_lookup_elem];					\
> +	if r0 == 0 goto l0_%=;						\
> +	r1 = *(u64*)(r10 - 16);						\
> +	r2 = 0x40000000;						\
> +	if r1 > r2 goto l0_%=;						\
> +	if r1 s> 1 goto l0_%=;		/* r1 in [0, 1] */		\
> +	r0 += r1;			/* ptr += bounded scalar */	\
> +	r9 = r0;			/* used to trip the warning */	\
> +	*(u8*)(r0 + 0) = r1;						\
> +l0_%=:	r0 = 0;								\
> +	exit;								\
> +	"
> +	:
> +	: __imm(bpf_ktime_get_ns),
> +	  __imm(bpf_map_lookup_elem),
> +	  __imm_addr(map_hash_8b)
> +	: __clobber_all);
> +}
> +
>  /* Check that range_within() compares cnum ranges, not min/max projections. */
>  SEC("socket")
>  __failure __msg("div by zero")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32257333410
--===============6076552742003848626==--
