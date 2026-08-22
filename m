Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861AE1A6813
	for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 01:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787361758; cv=none; b=KPeLWne5FJ4cLsOeMklAn/KzCQ2tS7+WFQU+H+lJ6M1juTzMz/n7y4I3WsR9/TOaSjOLVzYofWN2xPFkhDt0fy7gAtG3I6tDUc8ltjhJ3GkXMQFAa5BIkRLYwLY6PWCrcNxkvtE9hKXH8bGeRN/VDFYwfRXSbQcJA9MVjXr3m8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787361758; c=relaxed/simple;
	bh=CGqNMl93WocQq632S6S4iCQUB+ixLR+p3Otcg60Xlp8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jNymZJto1/0Wfrc0SXSkgQwJnkDySR/jOVl1deOO3TZk+hou6IXO8NLDsDiBb1/Ux++VjEbcwLblavOrX8fbDDWY7/8H4PeMCHsHcBc56bKZV+aHO31tjM/4FKC9Dj5PGB6xeJEk3VxIFpVVs7EbjETm1maI0LIpTuY1oqta/zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SovgpdHS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SovgpdHS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3981F000E9;
	Sat, 22 Aug 2026 01:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787361757;
	bh=BhfSO1AVkgFlGWC10LBtsEcY0mGJ7pTMBRhJow8XHP8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SovgpdHSkJ7c0VTo8QvpW9kNRqc2e5vEIKMbNGG1+RzgTDAU3GQtet/ZiIpZtobUs
	 A66gg1G0pBfo7xBdjZxk4sbujWp8W6nIgsf6lIgu9uWMgQLPl5Xf7+T1DEGC6SHFSI
	 vW9mMSuK567Fa30terqh02HPfvrdAjwEHN/DdmL11xkDStlRPzFs6Z63IgYuwugkbV
	 1dn1d/CDJONYAoFPXQa7GuNeEAGbKUrUNhyughNVfB1GXkIRehP46rOVCFGenzY7Kx
	 ZTru/izIfT85v+fvt7x9J9zl8tsTTHyrgNAj5YAPnTTFXTMsrIjpk28LL31SPawyfc
	 Pn2PM5k9bqt6Q==
Content-Type: multipart/mixed; boundary="===============8088032177413696453=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9d3a149ae41ce8c65598ac618b313b156c8f258ca3c64d3f29a7a263c0d1a195@mail.kernel.org>
In-Reply-To: <20260821-bug-029-bad-non-null-inference-v1-2-45ddc0f7c308@gmail.com>
References: <20260821-bug-029-bad-non-null-inference-v1-2-45ddc0f7c308@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: a demo for check_cond_jmp_op() non-null inference bug
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,npc@anthropic.com,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 22 Aug 2026 01:22:36 +0000 (UTC)

--===============8088032177413696453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 3cabd995b5a9b860b97954a62b1fbe2ddce7fccf
> Author: Eduard Zingerman <eddyz87@gmail.com>
> Date:   Fri Aug 21 17:32:37 2026 -0700
>
>     selftests/bpf: a demo for check_cond_jmp_op() non-null inference bug
>
>     A comparison between PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED and
>     PTR_TO_MAP_VALUE_OR_NULL should not infer that map pointer is not null.
>     A bug in check_cond_jmp_op() made such inference possible.

The changelog states this demonstrates a comparison against
PTR_TO_MAP_VALUE_OR_NULL, but the test actually uses an XSKMAP lookup.
Looking at the test code, map_xskmap is declared as BPF_MAP_TYPE_XSKMAP
(lines 10-15), and refine_map_lookup_value() in the verifier rewrites the
result to PTR_TO_XDP_SOCK | PTR_MAYBE_NULL, not PTR_TO_MAP_VALUE_OR_NULL.
The expected error message confirms this: "xdp_sock_or_null" rather than
"a nullable map value pointer".

Should the changelog say PTR_TO_XDP_SOCK | PTR_MAYBE_NULL instead? The
parent commit af2e3ac1ddc7's prose reproducer uses a hash map lookup,
which would give the described type, but this test uses a different map
type.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
> index 3d1e8de4390c..085d1146896c 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c

[ ... ]

> @@ -264,4 +266,46 @@ __naked void jne_reg_reg_null_check(void)
>          : __clobber_all);
>  }
>
> +/*
> + * A comparison between PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED and
> + * PTR_TO_MAP_VALUE_OR_NULL should not infer that map pointer is not null.
> + * A bug in check_cond_jmp_op() made such inference possible.
> + */
> +SEC("raw_tp")
> +__failure
> +__msg("error: invalid dereference of R0 (xdp_sock_or_null)")
> +__msg(">>> 10 | (61) r0 = *(u32 *)(r0 +0)")
> +__naked void untrusted_mem_does_not_infer_map_value_non_null(void)
> +{
> +	asm volatile ("					\
> +	/* r8 = bpf_rdonly_cast(0, 0); */		\
> +	r2 = 0;						\
> +	call %[bpf_rdonly_cast];			\
> +	r6 = r0;					\

The comment says r8 but the result goes into r6. Also, is it worth noting
that r1 holds the raw_tp context rather than 0, even though the first
parameter is obj__ign and check_kfunc_args() skips it?

> +	/* r0 = bpf_map_lookup_elem(map_hash, &key); */	\
> +	*(u64 *)(r10 - 8) = 0;				\
> +	r1 = %[map_xskmap] ll;				\

The comment references map_hash, but the instruction loads map_xskmap
(BPF_MAP_TYPE_XSKMAP). Since the map type determines what register type
the lookup produces, this seems like a detail that could mislead someone
cross-checking the test against the fix. Should it say map_xskmap?

> +	r2 = r10;					\
> +	r2 += -8;					\
> +	call %[bpf_map_lookup_elem];			\
> +	/*						\
> +	 * buggy verifier assumed that r6 can't be null	\
> +	 * and marked r0 non-null as well.		\
> +	 */						\
> +	if r6 != r0 goto 1f;				\
> +	r0 = *(u32 *)(r0 + 0);				\
> +1:	r0 = 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_rdonly_cast),
> +	  __imm(bpf_map_lookup_elem),
> +	  __imm_addr(map_xskmap)
> +	: __clobber_all);
> +}

The block comment, function name, and commit message all claim this
demonstrates comparing PTR_TO_MEM against PTR_TO_MAP_VALUE_OR_NULL, but
the test produces PTR_TO_XDP_SOCK | PTR_MAYBE_NULL instead.

The map lookup (above) is against map_xskmap (BPF_MAP_TYPE_XSKMAP), so
refine_map_lookup_value() rewrites the result to PTR_TO_XDP_SOCK |
PTR_MAYBE_NULL. The test's expected message confirms this:
"xdp_sock_or_null".

The exact scenario from the parent commit's prose reproducer (hash map
lookup giving PTR_TO_MAP_VALUE | PTR_MAYBE_NULL) is left uncovered. Should
the test either use a hash map so the code matches the documentation, or
rename to untrusted_mem_does_not_infer_xdp_sock_non_null to match what it
actually exercises?

The test itself is valid: on a pre-fix kernel, the old logic marks R0
non-null and the program loads; with the fix it fails as expected. Only
the naming and documentation are inconsistent with the implementation.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32541598508
--===============8088032177413696453==--
