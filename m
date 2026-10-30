Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364297;
	b=IjxXHD6S0l5R1H0FIyFaKwXSOxDukWz0THpAB7JCXg67jp4omIEERczgLwXoqu3Uq/HR
	 FXSEDiQwn4HeJTUefULJPhurdrrB4evTFUEBQEqAsKVx74P/Dl0w7cw2xhNVGFe3kyZIA
	 gSHajTWOUSZoZEv1SDubJotyLdOxh6HeGjJ2kAi2ztZtARh0Je+rDbOe4wlg+0f61EYWl
	 qwsSpdrw7O7r77ma6v/mae9hebHcJ2Fp6S78LWUlgEp4hHuzXhyBt0FQXp6j+gr42Yg0b
	 Q1t0v9oE6nUj1qZQmOkFjksNqJo7VJNncawa5nw4ALxrgrtYEqWoHatbDwrRiQM5RfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364297;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=apqrbw11QaPVj7uVWqwA/UVR0O0Dp6d3kr8ppBa52Hs=;
	b=Ijbu1sgHcm6ouzUcehvKkSFF/oewRlFS0lKNvrBTKDiDX3mLRBEUyv8PQllydwrFjNME
	 lci3oB5+1CvOOiAummI+uMScxa3Ra8GHYrP1j6z5Bv7Ua036jX8BchGgSuWQAAMRReqQu
	 IS1WiAKs6Vbaqrtr6DvNOOaXaFjfN7t66qB8uk7/kZKW+T0Sfk+FsWcfaVzBek0Msn1f/
	 t127oZXtuQhh2ekkB2b8cVaXx2UZzFJxWOEgqpnQy8gD8vWzAfJwFYrLHpgEzMaynyPYx
	 ZFSWc4zz5RHHiXjHf5vjzi4cx1b3Iq5yjkZ41bs0gsCsKywi/ombEQPOeDImmOhmtzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eV3H1Bi2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F116606A31A;
	Fri, 30 Oct 2026 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eV3H1Bi2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BED1F000C1;
	Fri, 30 Oct 2026 12:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793364296;
	bh=apqrbw11QaPVj7uVWqwA/UVR0O0Dp6d3kr8ppBa52Hs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eV3H1Bi21LSF3sbraY7DbhzeROld+GxHFLDTk3I6bLhxGQ7R3wlXC2Vs1DLm7/u6T
	 iOVD/MmPdJ88WApdoPGWZ9rkK6BZRcB9d7Tkmy5kvs2A4k+Q+UH0ol8+oC2x463GPe
	 deQ0Oea7d8Ji8W/txgUnlarCrtVN98Lq/a+5AWg2jutKMYmbSEsNeA/NFpZDLgVYz4
	 4MJlYtQAOffUWz7drAxAUU5f2uh+3jMGlrjiOBRyaMrtHK9tVORqt1L4MBkbDcmrGb
	 dmXHKghdMJJddNOuFcb7nDzzX/kAvzCchmUrzs35qQrC2EWkxOMc0Km9T54RCG3yb7
	 lOx2vM4O3UGxw==
Content-Type: multipart/mixed; boundary="===============3217382710323847077=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <55f77cb13998286fa0f959e0025d33923ca6fff066f3e9019c2830eee8f75288@mail.kernel.org>
In-Reply-To: <20261030-bpf-verifier-patch-batch-v2-12-55cd43439f7c@gmail.com>
References: <20261030-bpf-verifier-patch-batch-v2-12-55cd43439f7c@gmail.com>
Subject: Re: [PATCH bpf-next v2 12/22] bpf: Teach the patch list to insert in front of an instruction
From: bot+bpf-ci@kernel.org
To: odys.yuan@gmail.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,odys.yuan@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 30 Oct 2026 12:44:56 +0000 (UTC)

--===============3217382710323847077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Teach the patch list to insert in front of an instruction

TL;DR: Nit only: the updated header comment on bpf_patch_list_commit() says
everything follows the insn itself after an insertion, but only jumps, insn
arrays and poke descriptors do; the code and commit message differ.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index a56b743be006..bb4fd75a7062 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> @@ -533,8 +557,9 @@ static void patch_list_del_subprogs(struct bpf_verifier_env *env,
>  /*
>   * Apply all queued patches and removals in one go. Everything that names an
>   * insn of the old image follows it to the new one. A patched insn is named by
> - * the first insn of its patch, a removed insn by the next insn that stays,
> - * like with bpf_patch_insn_data().
> + * the first insn of its patch, or the insn itself if insns were inserted in
> + * front of it, a removed insn by the next insn that stays, like with
> + * bpf_patch_insn_data().
>   */
>  int bpf_patch_list_commit(struct bpf_verifier_env *env)
>  {

This isn't a bug, but is the updated header comment accurate about which
users follow the insn itself after an insertion?

It says everything that names an old insn follows it, and that an insn with
insns inserted in front of it is named by the insn itself.  In
bpf_patch_list_commit() that only holds for jumps, insn arrays and poke
descriptors, which use img.new_tgt:

    bpf_insn_array_remap(env->insn_array_maps[i], img.new_off,
                         img.new_tgt, img.cnt, img.grow);

Subprog starts, func pointers and line info still use img.new_off, which is
the first inserted insn:

    env->subprog_info[i].start = bpf_patch_image_remap(&img, img.new_off, ...)
    fp->xlated_off = bpf_patch_image_remap(&img, img.new_off, fp->xlated_off)

patch_list_adj_insn() also sends calls and ld_imm64 of subprogs to new_off.

The commit message and the comment above __bpf_patch_list_insert() describe
this split correctly, so this comment now disagrees with them.  Also,
"like with bpf_patch_insn_data()" now trails a clause that
bpf_patch_insn_data() never implements, since it always uses
BPF_PATCH_KEEP_TARGET.

Could the comment say that jumps, instruction arrays and poke descriptors go
to the insn itself, while subprogs, line info, function pointers and calls go
to the first inserted insn?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41053659762
--===============3217382710323847077==--
