Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD854C226E;
	Thu,  1 Oct 2026 10:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850457; cv=none; b=Edz6++TfVizCt0T3P9b4sLCr79a8YlgMMCUPz/fXFvHMvOjdjRQqebnNW3/QQcTu7N8cRFsymasvb2M61hqDpqUYOCzzx/IDyZosdxRXuOWXqwhDgEWFd2MAjyXC1BBTUsxEf3GYQtf9zDDSZCkPDu5sCOJTJVT5MOu5FhrEy4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850457; c=relaxed/simple;
	bh=DPegEgRtgn9R1g/93uNCJlOctv8SOOdSe+HrHtQDT8E=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PLkie9EkrBeK7vlsMGnuht/9+GsylnytZmBSIRke6CYpolNJ0gVvbsnj+dvMZQ76hjK9pBnMi5RriQiiylTzha+2z/XnilDdDl0gxUyiLcQKlq/uCCmCnz13VdwxiA0l5INhJ1u6Q8THJYAnVRi2rYjY7b4WOalF80MGhgmWOh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFYTBpL5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFYTBpL5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140101F000FF;
	Thu,  1 Oct 2026 10:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790850456;
	bh=lI22nm/uLj7943zA8qY0lw6CqIm8cd1MMQKYe3UqZQo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KFYTBpL5mmXHgdSIDp2RxMI/io9mpZAh2HiSkWpR7y++2pcM5kwts+rU6SNsUyOF8
	 Oo02rmzfI/rObFQf/UTfuJ6r2eaAr6eVKG3QyscE3BdJQpqZh+amfCe+HpolR/Z4jo
	 cjOMPRe4OacD1FLYYra3zODaUxqhSrX8i7/15xNI04w2Nh2dVMIDlGhNN9tBrIrpv9
	 lIfZtNp74snNJ9ecAuG2C15n/G52nM/W8kEke3aDKcSMlePRLofy+dxieuXMV+2Mml
	 9GdBo0CAFanlAvJMDnXQ84ZQUDD18nQ7ijKzvZU81nON7oXvF2td+m7kXU6uj4kqXo
	 zKs/QGrx+KaWA==
Content-Type: multipart/mixed; boundary="===============6201432976462108920=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4b74d8c73be2889b1c85c0b9819dbb7c83c535c46342b7ed11412763abda70b9@mail.kernel.org>
In-Reply-To: <20261001-bpf-verifier-patch-batch-v1-2-a12df8a09160@gmail.com>
References: <20261001-bpf-verifier-patch-batch-v1-2-a12df8a09160@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Queue the rewrites of bpf_do_misc_fixups() and apply them at once
From: bot+bpf-ci@kernel.org
To: odys.yuan@gmail.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,odys.yuan@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  1 Oct 2026 10:27:35 +0000 (UTC)

--===============6201432976462108920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Queue the rewrites of bpf_do_misc_fixups() and apply them at once

TL;DR: Possible regression in bpf_do_misc_fixups(): may_goto_expand() now sees
unpatched offsets, so a backward may_goto at exactly -32768 may get a 16-bit
JEQ instead of gotol, and a previously loading program may fail with -ERANGE.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 39566f382510..4b96f4ee9b3d 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> @@ -2336,13 +2316,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
>  			cnt = may_goto_expand(insn_buf, insn->off, stack_off_cnt,
>  					      tail, ARRAY_SIZE(tail));
>
> -			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> -			if (!new_prog)
> -				return -ENOMEM;
> -
> -			delta += cnt - 1;
> -			env->prog = prog = new_prog;
> -			insn = new_prog->insnsi + i + delta;
> +			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
> +			if (IS_ERR(insn))
> +				return PTR_ERR(insn);
>  			goto next_insn;
>  		} else if (bpf_is_may_goto_insn(insn)) {
>  			int stack_off = -stack_depth - 8;
> @@ -2355,13 +2331,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
>  			cnt = may_goto_expand(insn_buf, insn->off, stack_off,
>  					      tail, ARRAY_SIZE(tail));
>
> -			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> -			if (!new_prog)
> -				return -ENOMEM;
> -
> -			delta += cnt - 1;
> -			env->prog = prog = new_prog;
> -			insn = new_prog->insnsi + i + delta;
> +			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
> +			if (IS_ERR(insn))
> +				return PTR_ERR(insn);
>  			goto next_insn;
>  		}
>

Can this change make a program that loaded before get rejected at commit
time?

may_goto_expand() picks between a 16-bit JEQ and JNE + gotol based on the
offset it is given:

    off = off >= 0 ? off + tail_cnt : off - 1;
    ...
    if (off == (s16)off) {
        insn_buf[cnt++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, off);
    } else {
        insn_buf[cnt++] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 1);
        insn_buf[cnt++] = BPF_JMP32_A(off >= 0 ? off : off - 1);
    }

Before this change every earlier rewrite was applied right away through
bpf_patch_insn_data(), and bpf_adj_branches() updated the jumps after each
one.  So when the loop reached a backward may_goto, insn->off already
included all the growth between the jump target and the may_goto.  That is
the final backward distance, and the JEQ-or-gotol choice was made on it.

Now the loop walks the unpatched program, so insn->off is the original,
unpatched offset.  The real distance is only computed later, in
patch_list_adj_insn() called from bpf_patch_list_commit():

    rel = (s64)new_off[tgt] - pos - 1;
    ...
    if (rel < S16_MIN || rel > S16_MAX)
        return -ERANGE;

Take a backward may_goto whose grown offset is exactly -32768 (S16_MIN).
The old code saw off = -32768, computed off - 1 = -32769, which does not
fit in s16, and emitted JNE + gotol, so the program loaded.  The new code
sees the smaller original offset, so off - 1 fits in s16 and it emits JEQ.
At commit the JEQ's displacement is -32769, patch_list_adj_insn() returns
-ERANGE, and the program is rejected with "insn %d cannot be patched due to
16-bit range".

The non-timed path under bpf_is_may_goto_insn(), which also calls
may_goto_expand(), has the same problem.  Forward may_goto behaves as
before, since the old code also chose JEQ from the unpatched forward
offset.  The trigger is narrow, a single exact displacement.

The selftest added later in the series (f8ef7933910d) does not appear to
cover this gotol boundary, and no later commit in the series changes it.
Should the JEQ-or-gotol decision be deferred until the final offsets are
known?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36845462631
--===============6201432976462108920==--
