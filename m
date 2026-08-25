Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692EC3CEB9A
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695989; cv=none; b=lKtGk1lAZGUpMQGD+5+1HqXJzTfh5MzYi/oZnl3V47hFLyoptrSpr3Jr5HasA2rggg/MXkE9kSxB/NcP/AZ8PYgO0mUz1MD8xZDHruKe5L1vElxxHi9VN0k/PyIBq2xXGbbssssESUbt/05AMkiBdd/XwwYaYfnL4QTKRo0QeoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695989; c=relaxed/simple;
	bh=zslmj36LojsuVAUzwFz2BMoFWqrDv3BspKueMNrcspk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HTkFgUbYYmCxwzYlZMwA0WgZfQjygK/CzgRoo6P4ajbUabrNV2io/ZPN7Q81fQxVPwl7rrQew35iJgLLWELcFagrunBdzBtiIGmTYlnUspotXeg7+rF387pS+CrtrLRPKdkpRwUaQlAzZEf80xTcpkDFYSem5uqHCe75avZkxPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsJqa2TD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsJqa2TD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB731F000E9;
	Tue, 25 Aug 2026 22:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787695988;
	bh=mSKlnDjXCyH7pBLDVp3AyS26P+2hxKykhFZ5gNXE3is=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZsJqa2TDfb0WIhxQ10Qr8khs5qQ4zQF8R6pyD2z/Z70RaBEuAUCjYYYYW1zYzRlKY
	 kCwVQ4m2cJ3Jg5+vS2ZBnbW6L+YMqHQzJVKUvQW4jXLShi6qpNMQeG2k8JRIhZsoME
	 xD32MxkvaNLjsFUzU/6l1gX2NiBPh0P+xRHHqoiUXp10PeOZGvIyIT9g9qx0lQyVF+
	 +c4wkuTr1tAe1JikzVex57M9UnUQ9zaKWvopihon0MnsiPG2N/u7F1oQKHI+L/lAPr
	 gL1bop8lDLgydbRB2WHM4XKGFEIeyUHQqgiNb0FjcEXkpRAdjWK5/LfaNyk80ydxZH
	 gY3yJQKv95NTw==
Content-Type: multipart/mixed; boundary="===============0570795302399554349=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <78325e93a25b9a6cb4ed57afdafd0db5560e504e0a1e56eceac1c5bba029c0a2@mail.kernel.org>
In-Reply-To: <20260825205448.1324569-1-yonghong.song@linux.dev>
References: <20260825205448.1324569-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 07/10] bpf: Allow arena pointers in a by-value kfunc return
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 25 Aug 2026 22:13:07 +0000 (UTC)

--===============0570795302399554349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index edbc48a1fdc8f..0c2181d587489 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14090,12 +14090,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		const char *member_note = "";
>
>  		/*
> -		 * The returned struct comes back as raw register bits modeled
> -		 * as an unknown scalar, so it must contain only scalars:
> -		 * otherwise a pointer field would be laundered into a scalar
> -		 * and escape provenance and reference tracking.
> +		 * The returned struct may only contain scalars and arena pointers
> +		 * as its members. Otherwise, any other pointer would be laundered
> +		 * into a scalar and escape provenance and reference tracking.
>  		 */
> -		if (!btf_struct_member_walk(env, desc_btf, t, BTF_MEMBER_SCALAR, 0, &path)) {
> +		if (!btf_struct_member_walk(env, desc_btf, t,
> +					    BTF_MEMBER_SCALAR | BTF_MEMBER_ARENA_PTR, 0, &path)) {

The rewritten comment drops the mechanism that justified the rule and, as
written, gives a rationale that contradicts the new behaviour. The
previous comment was:

  /* The returned struct comes back as raw register bits modeled as an
   * unknown scalar, so it must contain only scalars: otherwise a pointer
   * field would be laundered into a scalar and escape provenance and
   * reference tracking.
   */

The new text keeps the 'laundered into a scalar' conclusion but deletes
the 'comes back as raw register bits modeled as an unknown scalar' premise,
and then asserts arena pointers are fine. A reader is left with an
inconsistency, because an arena pointer member is laundered into a scalar
in exactly the same way -- mark_kfunc_ret_regs() marks both R0 and R2 as
unknown scalars regardless of member kinds.

The actual reason arena pointers are safe is not stated anywhere in the
change: a laundered arena address is only usable after
addr_space_cast/cast_kern, check_alu_op() already lets a program
cast_kern() any scalar, and cast_kern is lowered to a 32-bit ALU mov so
the result is confined to the arena window at r12. One clause noting that
arena pointers need no provenance because they are re-derived by
cast_kern would restore the invariant explanation.

Also, 'Otherwise, any other pointer' is redundant ('otherwise' plus
'any other').

> @@ -14106,7 +14106,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  				const struct btf_type *bad_type;
>
>  				verbose(env,
> -					"kernel function %s returns %s %s that is not composed of scalars\n",
> +					"kernel function %s returns %s %s that is not composed of scalars or arena pointers\n",
>  					func_name, btf_type_str(t),
>  					btf_name_by_offset(desc_btf, t->name_off));
>  				btf_member_path_str(desc_btf, &path, bad_name, sizeof(bad_name));
> @@ -14114,15 +14114,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  				verbose(env, "member '%s' has type %s\n", bad_name,
>  					btf_type_str(bad_type));
>  				member_note = bpf_diag_fmt(
> -					env, " Its member '%s' is %s, not a scalar.", bad_name,
> -					btf_type_str(bad_type));
> +					env,
> +					" Its member '%s' is %s, not a scalar or an arena pointer.",
> +					bad_name, btf_type_str(bad_type));
>  			}
>  			bpf_diag_program_structure(
>  				env, insn_idx, "unsupported kernel function return type",
> -				"Call a kernel function that returns only scalars by value.",
> +				"Call a kernel function that returns only scalars or arena pointers by value.",
>  				"%s() returns %s %s by value.%s "
> -				"Only kfuncs returning scalar values, or "
> -				"structures composed of scalar values are "
> +				"Only kfuncs returning scalar values or arena pointers, or "
> +				"structures composed of scalar values and arena pointers are "
>  				"supported.",
>  				func_name, btf_type_str(t),
>  				btf_name_by_offset(desc_btf, t->name_off), member_note);

In the bpf_diag_program_structure() reason text, 'structures composed of
scalar values and arena pointers' reads as a conjunction, i.e. that a
supported struct must contain both scalars and arena pointers. The
accepted set is a disjunction: BTF_MEMBER_SCALAR | BTF_MEMBER_ARENA_PTR
accepts any mix, including all-scalar and all-arena-pointer structs. The
other three strings in the same diagnostic use 'or' consistently, so this
line is the odd one out. Would 'structures composed of scalar values or
arena pointers' match?

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
> index d6b422ae9784b..f10e5cf6fd890 100644
> --- a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
> @@ -71,7 +71,7 @@ __naked int aggregate_ret_kfunc_fastcall_fail(void)
>
>  SEC("tc")
>  __arch_x86_64 __arch_arm64
> -__failure __msg("is not composed of scalars")
> +__failure __msg("is not composed of scalars or arena pointers")
>  __naked int aggregate_ret_kfunc_ptr_fail(void)

[ ... ]

This commit relaxes the by-value kfunc struct return rule from
BTF_MEMBER_SCALAR to BTF_MEMBER_SCALAR | BTF_MEMBER_ARENA_PTR and updates
all four user-visible verifier strings accordingly, but
Documentation/bpf/kfuncs.rst section 2.9 still documents the old contract
and is now factually wrong in three places:

  - 'A struct or union returned by value must be composed only of scalars
    (recursively), where a scalar is an integer or an enum'
  - 'A struct or union with a pointer member is therefore rejected at load
    time' -- a struct with a 'void __arena *' (btf_type_tag("arena"))
    member is now accepted
  - 'A kfunc may also return a value larger than 8 bytes and up to 16
    bytes -- a scalar-only struct or union, or an __int128'
  - 'A global subprogram is verified in isolation, so its by-value struct
    or union return is restricted to scalars just like a kfunc's' -- also
    invalidated by patch 4 of the same series (ba9c98e6fb9db, 'bpf: Allow
    a global function to return arena pointers by value')

This paragraph is not boilerplate: it was written specifically to explain
this restriction (it even paraphrases the code comment that this commit
deletes), so it is the authoritative reference for the rule being changed.
Looking at the range 37ffe60f491e..6ab11e51f5443, no commit in the series
updates Documentation/, so the documentation stays contradictory after the
whole series is applied.

Could the paragraph be extended to say members may be scalars or arena
pointers, and explain that an arena pointer member is likewise handed back
as a scalar which the program must cast_kern() before use?

The new acceptance path is reachable only through an annotation mechanism
the kfunc ABI does not currently offer. btf_type_is_arena_ptr() matches
only a kflag=0 BTF_KIND_TYPE_TAG named 'arena' and explicitly skips
kflag'd tags. The established way a kfunc declares arena pointers is
KF_ARENA_RET / KF_ARENA_ARG1/2 plus the '__arena' parameter-name suffix,
which tools/bpf/resolve_btfids emits as a kflag=1 type attribute
'address_space(1)' -- deliberately not matched here. resolve_btfids'
arena_tag_ptr() also only tags a func proto's return pointer and its
parameters, and errors out with 'arena type is not a pointer' for a struct
return, so KF_ARENA_RET cannot express 'this returned struct's members are
arena pointers'.

So a kfunc can only hit this new path if its declaration carries a raw
__attribute__((btf_type_tag("arena"))) on the member, and no kernel-side
macro exists for that. The follow-up selftest commit 6ab11e51f5443 has to
invent its own '#define __arena_tag
__attribute__((btf_type_tag("arena")))' in
tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h, guarded by
__has_attribute(btf_type_tag), plus a runtime BTF probe
(testmod_has_arena_tagged_member()) that test__skip()s when the build
toolchain did not emit the tag. That is evidence the code is live but also
that no supported kernel-side spelling exists.

Would an in-kernel __arena macro (or teaching resolve_btfids to tag struct
members under KF_ARENA_RET) make the feature usable by real kfuncs and
testable without a skip?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32899532405
--===============0570795302399554349==--
