Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAEA51616F
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862488; cv=none; b=tzlswV5K02u0a6GAyLwxmJHQuxsWtRrGEhpu2+Vgss2QXT0vWINw3SPnuWb+Qt+//gYK9Q4JCJv/FapwrJjJkclQddqd/v8Sob5i+okwXcjA913nN5mqmoX7ElFDbSWK4g59tiLr4hlF5Rycr8chTY6G/RwdNiqc0NdsKdHETIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862488; c=relaxed/simple;
	bh=b9cB6bOrG5NoLkEr0VxgDoVW1VCpEdfGNVo8FlAv5YM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FKq2C6f2oCMaDjlg52KN1Z3MtdqM44Rxir4ijmp1RxsOGdYkhgpOLUaUm3f/ck8DbtLRGx2wMJVDKYRLpo3K1GzdkogVNtoCWUp4kvNryB8JFVnyyu6AYZF1+PMM9TNtrBOWoMYkDduXVskp99I3x3Oa6wksNodCXxGOuExjmq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Op34lPpy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Op34lPpy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA74F1F000FF;
	Thu,  1 Oct 2026 13:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862486;
	bh=1vCdNlfmGAGD2CbI4aIH0UhYd9vV9iR5PjUWuwmyghc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Op34lPpyb5PNIlPLagg7BSpFwYHmh2NZfL4rtQrwxBKdVqn5JuZSMdGZcppO2dJh+
	 4AEiV2zzIIojEMWJVMaM37CFVlaglp9oeIER3xO5I8M7cd4rmFHZheLph2MZae+G1L
	 WqDuNmqPSthVsgkscnV5cLquGqEBsgFHwSy27XDxZSSpITOVjDFjckVJmpdR2821wP
	 VauXJy0ALJa0c+I3P4r+ffcIITq7dGiFO7ZRD8z2XtwB9cXgr2IWv0zdGShVvgIl/q
	 aRBmN0tmdjnmtBuQnXa3X/tRunJeBiQlYJgsEuCZxHHZ5vNzHLOldLW47ecBtRZ/O9
	 DyTBAfaek1z/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 04/22] bpf: Add lookups for exception
 cleanup resumes and landing pads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261001133027.1338227-1-yonghong.song@linux.dev>
References: <20261001133006.1335369-1-yonghong.song@linux.dev>
 <20261001133027.1338227-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 13:48:05 +0000
Message-Id: <20261001134805.EA74F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: failure to adjust cleanup_pad for BPF_PATCH_MOVE_TARGET allow=
s arbitrary read/crash
--

commit 1a4d7ce9c87bb54c2feec4648d42fa1046ccb8b1
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Add lookups for exception cleanup resumes and landing pads

This commit adds lookups to exception.c to recognize calls to bpf_unwind()
and bpf_unwind_resume(). It also updates bpf_patch_insn_data(),
verifier_remove_insns(), and bpf_opt_remove_nops() to keep the landing pads
of call sites properly synchronized.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 37cf130ebb57b..5b7fe4ba610b3 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
[ ... ]
> @@ -268,11 +268,18 @@ static void adjust_insn_aux_data(struct bpf_verifie=
r_env *env,
>  			data[i].non_stack_access =3D
>  				data[off + cnt - 1].non_stack_access;
>  			data[off + cnt - 1].non_stack_access =3D false;
> +			data[i].cleanup_pad =3D data[off + cnt - 1].cleanup_pad;
> +			data[off + cnt - 1].cleanup_pad =3D 0;
>  		} else if (bpf_is_mem_insn(insn + i)) {
>  			data[i].non_stack_access =3D true;
>  		}
>  	}
> =20
> +	if (env->cleanup_info_cnt)
> +		for (i =3D 0; i < prog_len; i++)
> +			if (data[i].cleanup_pad > off + 1)
> +				data[i].cleanup_pad +=3D cnt - 1;

[Severity: High]
Could this fail to adjust the cleanup_pad correctly when the mode is
BPF_PATCH_MOVE_TARGET in adjust_insn_aux_data()?

The condition checks data[i].cleanup_pad > off + 1, which works well for
BPF_PATCH_KEEP_TARGET, but it appears to miss BPF_PATCH_MOVE_TARGET where
the target should follow the original instruction to the end of the patched
sequence.

When a prologue is inserted at offset 0 (for example, during
bpf_convert_ctx_accesses), exception landing pads pointing to offset 0 are
not shifted. If a user sets an exception landing pad at offset 0, unwinding
would cause execution to jump to the newly inserted prologue instead of the
original instruction.

Since the prologue for program types like TC expects R1 to contain the CTX
pointer, and R1 is a caller-saved register containing whatever was placed
there before calling bpf_unwind(), could dereferencing this
attacker-controlled R1 during an exception unwind lead to an arbitrary memo=
ry
read or a kernel panic?

Should this check be dependent on the mode, such as:
data[i].cleanup_pad > (mode =3D=3D BPF_PATCH_MOVE_TARGET ? off : off + 1)
to properly account for both modes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001133006.1335=
369-1-yonghong.song@linux.dev?part=3D4
