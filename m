Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ADE1F30BB
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 03:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792207635; cv=none; b=FKb1MdR68wL1weITKhNo3pfFyJsc316483LuVtggztt3qwp3XlH5SLaMuKKJSncaJVP2t7JUksrACkIGTpOe6MKsLryp3eyHaIq+KfH7XEsp1/KIHGsZPbZA6n5oxA143ViMLath8BUgb7Q8X/0zaFkReBGhqKSakyt2slxd1zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792207635; c=relaxed/simple;
	bh=bE7kqAZ3H8VF4M0guYKlcua6c4aVqMBbqGctmr0woVM=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=Jak3L+diUNdvNGHor6RCT4FLOjsJg0DNUTbjS+v3KMxfehI0wfvyV2OLV7e/Zcf3SElaNIKYPYcXlLeUVIGWGF77yOvAWM3PEmRpyGFJ+TBrdU2rksiYoMsoIxTv4hOAx9E3eiW+Jbw7L7rUDJCDn4KWqpvISBuPxWacEJGKMo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdMlHIbS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdMlHIbS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EB41F000C4;
	Sat, 17 Oct 2026 03:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792207634;
	bh=A/9ADCZhjRJStxAslK6Mw4jUK+JvScYvQREHjOELtQ4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CdMlHIbSyV3Gop5v+Al23kLyLlSw8RbeEUfyFo+nP0j37oqNtt51GKsAl6FBEXQ0i
	 +2RNx8gvP/TYah8PiG1tCESeLgVlsHSaY2piPa/sokmm2g8jYhS1e8SGFiwkYv7Ci9
	 56OF+epZhW6DWCXfYwNEFZxCmvep4RKkeHMEcCxvZR+VtAziLzQ7X3CfEgG1SU9n1u
	 8+DCPt3XK4J8p13LXw5zV0beQXvYk4lzUvZlo/mc7orT6F8kd3cgGlJqS6/vWjEn7b
	 FSLvVNK/1/264/bzw4kDghs06/QTkoDeCH92BBdrVupCJFOYsftmJPApddqSlkDq/4
	 bJaJXBjKCMJsA==
Message-ID: <sashiko-outbox-175243@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v12 06/25] bpf: Verify an unwind through
 landing pads and epilogues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>, bpf@vger.kernel.org
In-Reply-To: <20261017025201.1919939-1-yonghong.song@linux.dev>
References: <20261017025129.1914859-1-yonghong.song@linux.dev>
 <20261017025201.1919939-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 03:27:13 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: missing might_unwind propagation in mark_callx_might_unwind()
--

commit c4002615f0bb137c4f685915b07888fb1dc5bbea
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Verify an unwind through landing pads and epilogues

This commit teaches the BPF verifier to follow stack unwinds from
bpf_unwind(), bpf_unwind_resume(), and unwinding global subprograms
through caller landing pads and epilogues, including CFG effect
propagation and precision backtracking.

> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index ad7ea08f3b15e..9608293bdc069 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c

[ ... ]

> @@ -91,6 +99,7 @@ static void merge_callee_effects(struct bpf_verifier_en=
v *env, int t, int w)
>  	caller->changes_pkt_data |=3D callee->changes_pkt_data;
>  	caller->might_sleep |=3D callee->might_sleep;
>  	caller->might_throw |=3D callee->might_throw;
> +	caller->might_unwind |=3D callee->might_unwind;
>  }
> =20
>  enum {

[ ... ]

> @@ -705,6 +716,82 @@ static int visit_insn(int t, struct bpf_verifier_env=
 *env)
>  	}
>  }
> =20
> +static bool addr_taken_subprog_might_unwind(struct bpf_verifier_env *env)
> +{
> +	struct bpf_insn *insns =3D env->prog->insnsi;
> +	struct bpf_subprog_info *callee;
> +	struct bpf_func_ptr *ptrs;
> +	u32 cnt, j;
> +	int i;
> +
> +	for (i =3D 0; i < env->prog->len; i++) {
> +		if (bpf_pseudo_func(&insns[i])) {
> +			callee =3D bpf_find_containing_subprog(env, i + insns[i].imm + 1);
> +			if (callee->might_unwind)
> +				return true;
> +			continue;
> +		}
> +		ptrs =3D insn_func_ptrs(env, i, &cnt);
> +		for (j =3D 0; j < cnt; j++) {
> +			callee =3D bpf_find_containing_subprog(env, ptrs[j].xlated_off);
> +			if (callee->might_unwind)
> +				return true;
> +		}
> +	}
> +	return false;
> +}
> +
> +/*
> + * merge_callee_effects() does not carry might_unwind to a subprog that =
calls
> + * through a pointer it was handed. So if any subprog a callx can reach =
may
> + * unwind, mark every subprog with a callx, and its callers.
> + *
> + * This is conservative: a subprog with a callx is marked even when noth=
ing it
> + * calls unwinds. The main walk knows each callx's target and could tell=
 those
> + * apart.
> + */
> +static void mark_callx_might_unwind(struct bpf_verifier_env *env)
> +{
> +	struct bpf_insn *insns =3D env->prog->insnsi;
> +	struct bpf_subprog_info *caller, *callee;
> +	int i, j, len =3D env->prog->len;
> +	struct bpf_func_ptr *ptrs;
> +	bool changed;
> +	u32 cnt;
> +
> +	if (!addr_taken_subprog_might_unwind(env))
> +		return;

[Severity: High]
Can addr_taken_subprog_might_unwind() return false prematurely here when an
address-taken subprogram calls back into an unwinding subprogram whose
entry instruction is still in the DISCOVERED state during the CFG walk?

In bpf_check_cfg(), visit_insn() traverses insn_func_ptrs() (for example,
an ld_imm64 referencing a read-only map such as .rodata that holds function
pointers) and bpf_pseudo_func() as CFG edges. Because neither
sort_subprogs_topo() nor check_max_stack_depth_subprog() rejects cycles
through insn_func_ptrs() or async callback bpf_pseudo_func() edges, a
subprogram cb whose address is in .rodata or taken via bpf_pseudo_func()
can call a subprogram G via BPF_PSEUDO_CALL while G references .rodata or
&cb on one branch and calls bpf_unwind() on a second branch.

If bpf_check_cfg() explores G before cb:

1. G's entry instruction is marked DISCOVERED and pushes branch 1 onto
   insn_stack while G->might_unwind is still false.
2. Branch 1's insn_func_ptrs() or bpf_pseudo_func() edge pushes cb onto
   insn_stack.
3. cb's BPF_PSEUDO_CALL to G runs merge_callee_effects() while
   G->might_unwind is still false, and push_insn() sees G's entry is
   already DISCOVERED and returns DONE_EXPLORING, so cb finishes exploration
   with cb->might_unwind =3D=3D false.
4. bpf_check_cfg() later explores branch 2 of G and sets
   G->might_unwind =3D true.

When mark_callx_might_unwind() then runs, addr_taken_subprog_might_unwind()
sees cb->might_unwind =3D=3D false and returns early before the fixed-point=
 loop
below can propagate G->might_unwind to cb and its callers.

As a result, a global subprogram calling cb (via callx or BPF_PSEUDO_CALL)
will have might_unwind =3D=3D false, causing process_global_call_unwind() to
skip verifying the unwind path at the caller and allowing acquired
references or locks to leak on unwind.

> +
> +	for (i =3D 0; i < len; i++)
> +		if (bpf_is_callx(&insns[i]))
> +			bpf_find_containing_subprog(env, i)->might_unwind =3D true;
> +
> +	do {
> +		changed =3D false;
> +		for (i =3D 0; i < len; i++) {
> +			caller =3D bpf_find_containing_subprog(env, i);
> +			if (caller->might_unwind)
> +				continue;
> +			if (bpf_pseudo_call(&insns[i]) || bpf_pseudo_func(&insns[i])) {
> +				callee =3D bpf_find_containing_subprog(env, i + insns[i].imm + 1);
> +				if (!callee->might_unwind)
> +					continue;
> +				caller->might_unwind =3D true;
> +				changed =3D true;
> +				continue;
> +			}
> +			ptrs =3D insn_func_ptrs(env, i, &cnt);
> +			for (j =3D 0; j < cnt; j++) {
> +				callee =3D bpf_find_containing_subprog(env, ptrs[j].xlated_off);
> +				if (!callee->might_unwind)
> +					continue;
> +				caller->might_unwind =3D true;
> +				changed =3D true;
> +			}
> +		}
> +	} while (changed);
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017025129.1914=
859-1-yonghong.song@linux.dev?part=3D6
