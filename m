Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AAA3E49E9;
	Thu, 13 Aug 2026 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786659995; cv=none; b=ePwcKhN661sMm4tsLcUs3T9tuSx25vlwAT5esoesMGXzcme/W/CB9pa3pxcBQghUcpZEYcUTY050DiksXbE2KaLrKTTVZQzgfIa6ID8KoChqEPkeQgqYDF1jLTICQP6uC4rCEAUaaWt9/4AVZ5tldtig2HUribFLZ3A8mBFD7eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786659995; c=relaxed/simple;
	bh=QFLILJ92O9Jk03EdkeYn65Rf9hINbjkcdVdBz9extu8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VPJXV8W4vh3ypv3pHGPk8KDwo2vUyewuzSD765nNLZbUVEoRKb6BcP1r3ckJ7To01JhuGIGeoSyxWDlWD6R+AXhyKlpuZUcMmz5oSrW3euq4ftRm0oZ1YJzyaClwKt84rk0opbsPffsedCoZFoQDwMg4kJswvp4vXW0p1UyTX/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4FkaD5b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4FkaD5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35301F000E9;
	Thu, 13 Aug 2026 22:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786659993;
	bh=Z/D0rg60LMFeyP9qcVnIUmPl6RkPQ11JrEuFY5qjZgg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=R4FkaD5bzStLXsAgx8sNy964wEySHrRBd1ONn+y5X49QjTl9/ks/JnYoL6oqI03yA
	 VhOFp1fypJPIyRk3MySmMutqRjZUb4YQbsPEyIB/L5Blm59NVFlhNkOesFqAbhR1zQ
	 er39+pL8q9mzTIFpAD9DVlnUlDdvHCHvDXp/8D8sbMcg9dvo55FHdqqCzMUD39C9Ot
	 FF1gZq9gE/FbC+yKezY9l1Hx5PDgVb9i0w1msaKNN6pswaeryK6dLWRrEpkTSaQb4U
	 LRl6LCS4l9TXqmPeAIufUL2AW2+6cSrY5+ZA5pK/cOihF9mDKnekF9mLCgpeuosNoV
	 IN6IpYGsVJu5w==
Content-Type: multipart/mixed; boundary="===============4836991261189950019=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <678eb16ccbeeb3d38fba26d20f6a7f3f2bb99f7bc9d7f5bc6bf2fb1d5b9ee87f@mail.kernel.org>
In-Reply-To: <20260813211533.290256-4-dingning04@gmail.com>
References: <20260813211533.290256-4-dingning04@gmail.com>
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Reject untrusted allocated-object pointers
From: bot+bpf-ci@kernel.org
To: dingning04@gmail.com,bpf@vger.kernel.org
Cc: memxor@gmail.com,greg@kroah.com,dingning04@gmail.com,sashiko-bot@kernel.org,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,davemarchevsky@fb.com,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 22:26:32 +0000 (UTC)

--===============4836991261189950019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 27b43fda9b178..22fcd01c3cceb 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1341,7 +1341,16 @@ static inline bool bpf_type_has_unsafe_modifiers(u32 type)
>
>  static inline bool type_is_ptr_alloc_obj(u32 type)
>  {
> -	return base_type(type) == PTR_TO_BTF_ID && type_flag(type) & MEM_ALLOC;
> +	return base_type(type) == PTR_TO_BTF_ID &&
> +	       type_flag(type) & MEM_ALLOC &&
> +	       !(type_flag(type) & PTR_UNTRUSTED);
> +}
> +
> +static inline bool type_is_untrusted_ptr_alloc_obj(u32 type)
> +{
> +	return base_type(type) == PTR_TO_BTF_ID &&
> +	       type_flag(type) & MEM_ALLOC &&
> +	       type_flag(type) & PTR_UNTRUSTED;
>  }
>
>  static inline bool type_is_non_owning_ref(u32 type)

Does adding the PTR_UNTRUSTED check to type_is_ptr_alloc_obj() also
change type_is_non_owning_ref()?

Looking at the definition in include/linux/bpf_verifier.h:

    static inline bool type_is_non_owning_ref(u32 type)
    {
            return type_is_ptr_alloc_obj(type) && type_flag(type) & NON_OWN_REF;
    }

It calls type_is_ptr_alloc_obj(), so after this patch it will also
reject PTR_UNTRUSTED registers. The commit message describes tightening
bpf_refcount_acquire() but doesn't mention this transitive effect.

Can this affect invalidate_non_owning_refs() in sleepable programs?

Consider a sleepable program using bpf_spin_lock() around graph
operations (which is a supported pattern, as seen in
tools/testing/selftests/bpf/progs/refcounted_kptr.c tests like
rbtree_sleepable_rcu).

When the program calls bpf_spin_unlock(), process_spin_lock() runs:

    if (!in_rcu_cs(env))
            invalidate_rcu_protected_refs(env);
    invalidate_non_owning_refs(env);

For sleepable programs, in_rcu_cs() returns false, so
invalidate_rcu_protected_refs() runs first. That function does:

    reg->type &= ~(MEM_RCU | PTR_MAYBE_NULL);
    reg->type |= PTR_UNTRUSTED;

A register holding a non-owning ref to a stashed graph node starts as
PTR_TO_BTF_ID|MEM_ALLOC|NON_OWN_REF|MEM_RCU (set by
btf_ld_kptr_type()/ref_set_non_owning() when loading from the graph).
After invalidate_rcu_protected_refs() it becomes
PTR_TO_BTF_ID|MEM_ALLOC|NON_OWN_REF|PTR_UNTRUSTED.

The immediately following invalidate_non_owning_refs() only acts on
registers where type_is_non_owning_ref() returns true. But after this
patch, type_is_non_owning_ref() returns false for registers with
PTR_UNTRUSTED.

So these registers that should be invalidated instead survive
bpf_spin_unlock() as live, readable pointers. Is this intended?

Pre-patch they would have been invalidated by mark_reg_invalid() in
invalidate_non_owning_refs(). Post-patch they escape invalidation.

The commit message states untrusted pointers "are still allowed for
BPF_PROBE_MEM reads," but does the BPF_PROBE_MEM conversion actually
work for the NON_OWN_REF variant?

Looking at kernel/bpf/fixups.c, the probe conversion logic has:

    case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
            /* probe mem access */
            ...
    default:
            continue;

It has a case for the plain MEM_ALLOC|PTR_UNTRUSTED type, but no case
for PTR_TO_BTF_ID|MEM_ALLOC|NON_OWN_REF|PTR_UNTRUSTED. So a load
through the surviving register is emitted as a plain load with no
exception-table entry, which would fault in the kernel instead of
returning zero.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bc021c8c8fbf7..c3a11c98cd451 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5820,7 +5820,13 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>  			return -EACCES;
>  		}
>
> -		if (type_is_alloc(reg->type) && !type_is_non_owning_ref(reg->type) &&
> +		/*
> +		 * Skip this referenced-ID sanity check for untrusted allocated objects;
> +		 * the access check above already rejects writes through them.
> +		 */
> +		if (type_is_alloc(reg->type) &&
> +		    !type_is_untrusted_ptr_alloc_obj(reg->type) &&
> +		    !type_is_non_owning_ref(reg->type) &&
>  		    !(reg->type & MEM_RCU) && !reg_is_referenced(env, reg)) {
>  			verifier_bug(env, "allocated object must have a referenced id");
>  			return -EFAULT;

This change allows the demoted PTR_UNTRUSTED|NON_OWN_REF registers to
reach mark_btf_ld_reg() instead of hitting the sanity assertion, which
opens the path for the read-through described above.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31745514567
--===============4836991261189950019==--
