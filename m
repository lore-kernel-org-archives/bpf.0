Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630624;
	b=xZugnkp6cQVKGGOJSQahSVgRirXqh3pOKN2LvwRzrjsK0QnDC1FpFWWbfZjmUBMn9KBm
	 jKRMoYRu01n+LIRmXLByndTiFdUNYR0bC8xWYKw/HBJ0ZA9tw3CK2H0FsZXJ1+estmt+l
	 dSbSoGD8AX+8qnlkJTHLwr4TXM/ECKSUyDGFqzFmGCcMUwFu2XdhYfAMOfH1vwcgWLN4+
	 NPF/ABMKPX99yepRCzeDYcsAHu//kqeOtyZ3Veu/b5EOeJYbFcYauo2wib0BCvi7omhcK
	 Rga08/5WsqaGu3wzGzAKr8Vz1Gcy5gSJUpZFDw163s7fAMIk/zBYOZZYYWMLinbsnOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630624;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=mTsqFSGLdAWfwv54zrQi/545UUUUuU7Wx+SQgSYz5fw=;
	b=vti6Pz1UC8jqbsBE9aMOGxgfPOchy0fc5KECEt4VuRg7P2Eu4VOhmbyKRB3Xk/n43i/J
	 BStcDvO59PH4eKybQCCA5Vv0cGbrJGAYoMHEL6SpTjPsPiicXltEcSlu22axjvsYamrvd
	 3CkSzK1pLeGQZjgWiFV/oe8vaYilMmb0n5JxeWmvo7VvaPWOBB3ZzO1hGgQ1OrcZjq1Yk
	 lMYUXtQll1r1y0m6Zy6tcCj2MXafc4q1FEDop/hkwcWZ55J9zpoa6yrLwQOR7iQSlqmWa
	 66KSoEMkXVjwEiCDXP7ZfZbUb9iHfp6H+xQf7K4DwGDVI6xA/JQ/jFRIv3A3UE9b+EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HoVIYyKz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895B9606A33C;
	Wed, 25 Nov 2026 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HoVIYyKz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D15A1F000E6;
	Wed, 25 Nov 2026 18:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795630623;
	bh=mTsqFSGLdAWfwv54zrQi/545UUUUuU7Wx+SQgSYz5fw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HoVIYyKzTS11Unjs1aTeWEitLOr17EfNhp68Q5kWyIyM2UNFrtKz/vbIOOots/Mc+
	 GtmXjFVMGrcROpF5NMWq19cSwF6opcwCmLairvfSX6qT4Ef1zl5/wPNuD7JBsMt+CU
	 Lj7gLDWIEhXmZdTVV6NB3AzJMDWvBYGHmaVKFkHUFaYpKweqQDFbRqhTuiGRRg5Y/v
	 2Znm0KzT4yhZ9+wvjkGtxhyNArbIDDAHhucneKQNsZacxh4MMNesIypu67NKZZV34e
	 zDrk2QZDkWhNh2LUtdWrVb0aw5r5xGyNthGUWD9QgxdqjaURnDYax+yt1A/3oW+Low
	 xBZTezXj8VHQg==
Content-Type: multipart/mixed; boundary="===============1669574170248031553=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <3bcb924ab6a0ac9a9f67a396f8027a4c75357bf9742a56d034e7f9ff7ecb7991@mail.kernel.org>
In-Reply-To: <45c622fb6bba40629594679c01eed836d58acd89.1795625597.git.luis.gerhorst@fau.de>
References: <45c622fb6bba40629594679c01eed836d58acd89.1795625597.git.luis.gerhorst@fau.de>
Subject: Re: [PATCH bpf 1/4] bpf: Add bpf_insert_insns() to insert insns next to an insn
From: bot+bpf-ci@kernel.org
To: luis.gerhorst@fau.de,ast@kernel.org,bpf@vger.kernel.org
Cc: luis.gerhorst@fau.de,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,shuah@kernel.org,henriette.herzog@rub.de,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 25 Nov 2026 18:17:01 +0000 (UTC)

--===============1669574170248031553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add bpf_insert_insns() to insert insns next to an insn

TL;DR:
- Comments and commit message misdescribe aux data handling:
  BPF_PATCH_NO_ORIG, "keeps its aux data", and zext_dst still being recomputed
- arena_member_fixup() sites may still use bpf_patch_insn_data() despite the
  commit message

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -170,82 +170,60 @@ enum bpf_patch_mode {
>  	BPF_PATCH_MOVE_TARGET,	/* targets of 'off' follow the original insn to 'off + len - 1' */
>  };
>  
> +/* The patch does not contain the insn that it replaces. */
> +#define BPF_PATCH_NO_ORIG	-1
> +
>  /* single env->prog->insni[off] instruction was replaced with the range
>   * insni[off, off + cnt).  Adjust corresponding insn_aux_data by copying
>   * [0, off) and [off, end) to new locations, so the patched range stays zero
> + *
> + * The aux data of the original insn stays with the insn if the range still
> + * contains it, at index 'orig'. Otherwise 'orig' is BPF_PATCH_NO_ORIG and the
> + * aux data moves to the last insn of the range.
>   */

This isn't a bug, but the comment on BPF_PATCH_NO_ORIG says the patch does not
contain the insn that it replaces.  bpf_patch_insn_data() passes
BPF_PATCH_NO_ORIG for every patch:

    return __bpf_patch_insn_data(env, off, patch, len, BPF_PATCH_NO_ORIG,
                                 BPF_PATCH_KEEP_TARGET);

Many of those patches still contain the insn, for example arena_member_fixup()
(buf[cnt++] = *insn;), add_hidden_subprog() and the insn_buf[N] = *insn
patches for tail calls, kfuncs and percpu alloc.  For these, keep is the last
insn, so the original insn's aux data (ptr_type, arena_member, ...) moves to
the trailing insn and the original is left with zeroed aux data.

The commit message describes this correctly ("Where such a patch still
contains the insn, the insn now counts as new"), but the two comments read the
opposite way.  Would something like "no insn of the patch inherits the aux data
of the original insn in place" be more accurate?

Also, in adjust_insn_aux_data() zext_dst is still recomputed for every slot,
including i == keep:

    data[i].zext_dst = bpf_insn_def32(new_prog, insn + i) >= 0;

[ ... ]

> @@ -431,6 +408,62 @@ static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
>  	return 0;
>  }
>  
> +/* Where bpf_insert_insns() puts the new insns relative to the insn at 'off'. */
> +enum bpf_insert_pos {
> +	BPF_INSERT_BEFORE,	/* in front of the insn, a jump to the insn runs them too */
> +	BPF_INSERT_ENTRY,	/* in front of the insn, a jump to the insn skips them */
> +	BPF_INSERT_AFTER,	/* behind the insn */
> +};
> +
> +/*
> + * Insert 'cnt' insns next to env->prog->insnsi[off]. Unlike with
> + * bpf_patch_insn_data(), the insn is not replaced: it keeps its aux data,
> + * wherever it ends up. Returns the new prog or an ERR_PTR().
> + */

Is "it keeps its aux data" accurate for zext_dst?  adjust_insn_aux_data()
overwrites zext_dst for the kept insn with bpf_insn_def32() >= 0, which drops
what bpf_compute_live_registers() computed:

    zext_dst = def32 >= 0 && (mask_hi(out) & BIT(def32))

and what the verifier sets for arena ALU64 insns together with needs_zext.

A 32-bit def whose upper half is dead goes from false to true, and an ALU64
arena insn with needs_zext goes from true to false if bpf_insert_insns() runs
on it before bpf_do_misc_fixups() converts it to ALU32 (the nospec
BPF_INSERT_BEFORE in bpf_convert_ctx_accesses()).

The old code also recomputed zext_dst for that slot, so behavior doesn't
change in this commit.  Could zext_dst be kept for i == keep, or the comment
and the commit message ("The insn keeps all of its aux data.") say that it is
recomputed?

[ ... ]

In bpf_convert_ctx_accesses(), arena_member_fixup() builds a patch that only
inserts behind the unchanged insn:

    buf[cnt++] = *insn;
    if (aux->arena_member_nullable || BPF_MODE(insn->code) == BPF_PROBE_MEM)
        buf[cnt++] = BPF_JMP_IMM(BPF_JEQ, insn->dst_reg, 0, 1);
    buf[cnt++] = BPF_ALU32_IMM(BPF_SUB, insn->dst_reg, (s32)base);

Both callers still use bpf_patch_insn_data():

    cnt = arena_member_fixup(env, i + delta, insn, insn_buf);
    if (cnt < 0)
            return cnt;
    new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);

The commit message says bpf_insert_insns() is used "where a patch only
inserts" and bpf_patch_insn_data() "is left for the patches that replace the
insn".  For these loads the aux data still moves to the trailing BPF_SUB, and
non_stack_access is now recomputed.

Should these two sites use bpf_insert_insns(env, i + delta, insn_buf + 1,
cnt - 1, BPF_INSERT_AFTER), or should the commit message be narrowed?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45667123547
--===============1669574170248031553==--
