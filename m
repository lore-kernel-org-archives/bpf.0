Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4F9208D0
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 04:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778299552; cv=none; b=NutzS17+tDw/aV5tZ8/I6SFPrTRgcGE1rNTOhtZ0JDfkJQu6vMH/ZQ4mxx/57pw9UBvTkI/xFCr/iNExOs5HP85S8ZBNkxvUjvXU3Ua+avDykoeyh8tfh/bapA/aLMHTPxYklkJE4pmDDOiQMeKYNFTrIKV/6WpF3oG2j5NXHOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778299552; c=relaxed/simple;
	bh=U66bIIgiYJn90jv7Y+fK8aMhlgh7JDjRgjU7A3/x6s4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sy+QuYqB0FD/S/QyefpG4kP5NMTUklGS5yuiXVyj+zGZ/cB01oXrnp7Ljxf4/2xYL6cfLdP9rIOcc+Zbjw0y/CfFR+fXMb7xyq/UiA3KK+7OXjrkNuJNlYlQjElwGiBmd37E/Sbq6COLuBXw6F8Dxenc918WfQOuWsbH3bPA6aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usKXXXfT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usKXXXfT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E2AC2BCB2;
	Sat,  9 May 2026 04:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778299551;
	bh=U66bIIgiYJn90jv7Y+fK8aMhlgh7JDjRgjU7A3/x6s4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=usKXXXfTaFYjLiknf+Ukm9LhOscqnHWbPEYR/KiyASdM6GKs8EHRR3GgOyIbS/TaA
	 Cfm3uUuRyqSb8DAa1dL7+0mU+jbfI46UjFSCqvL4T6xsZAj1VDje5OSXieRzoXwVcK
	 nISkKWLXY3TRB6P/+meRc3itsl0pZAjlSqgYKoDfjckl3CvxWEzZxcvxEX2cpv8XJb
	 NxwAgV6Qvl/WbOQYq6ETxo1D50871z95+Zwa/3TNE4oBVs9T793EWf9NOS6Zu1F2S3
	 OvFcGlNN3EsmC6EGESrHDM2fheVrEeX5GL8Ks9t4N/n7mZFhxoACbL71XaK9O9Q3x7
	 1LUwH3zTqq7jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 07/23] bpf: Add precision marking and
 backtracking for stack argument slots
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260507213018.1128602-1-yonghong.song@linux.dev>
References: <20260507213018.1128602-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 04:05:51 +0000
Message-Id: <20260509040551.C9E2AC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect tracking and propagation of stack argument precision at =
subprogram boundaries in `backtrack_insn()`.
--

commit 82222fc9756a9a239fae1b810efc4aa155d2973f
Author: Yonghong Song <yonghong.song@linux.dev>

    bpf: Add precision marking and backtracking for stack argument slots

This commit extends the precision marking and backtracking infrastructure to
support stack argument slots (r11-based accesses). It ensures precision
demands for scalar values passed through stack arguments are properly
tracked.

> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
> index 93738a076c888..17f254a02831f 100644
> --- a/kernel/bpf/backtrack.c
> +++ b/kernel/bpf/backtrack.c
[ ... ]
> @@ -336,6 +351,19 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
>  			return 0;
>  		bt_clear_reg(bt, load_reg);
> =20
> +		if (hist && hist->flags & INSN_F_STACK_ARG_ACCESS) {
> +			spi =3D hist->spi;
> +			/*
> +			 * Stack arg read: callee reads from r11+off, but
> +			 * the data lives in the caller's stack_arg_regs.
> +			 * Set the mask in the caller frame so precision
> +			 * is marked in the caller's slot at the callee
> +			 * entry checkpoint.
> +			 */
> +			bt_set_frame_stack_arg_slot(bt, bt->frame - 1, spi);
> +			return 0;
> +		}
> +

When backtracking a callee's read of an incoming stack argument via BPF_LDX,
the logic correctly sets the mask in the caller frame (bt->frame - 1).

[ ... ]
> @@ -426,6 +465,18 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
>  						bpf_bt_set_frame_reg(bt, bt->frame - 1, i);
>  					}
>  				}
> +				/*
> +				 * propagate callee's incoming stack arg precision
> +				 * to caller's outgoing stack arg slots
> +				 */
> +				if (bt_stack_arg_mask(bt)) {
> +					for (i =3D 0; i < MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS; i++) {
> +						if (!bt_is_frame_stack_arg_slot_set(bt, bt->frame, i))
> +							continue;
> +						bt_clear_frame_stack_arg_slot(bt, bt->frame, i);
> +						bt_set_frame_stack_arg_slot(bt, bt->frame - 1, i);
> +					}
> +				}

Does this propagation logic operate on the correct mask?

Since the callee's BPF_LDX instructions already marked the incoming stack
arguments directly in the caller's frame (bt->frame - 1),=20
bt_stack_arg_mask(bt) for the current frame (bt->frame) shouldn't contain
any incoming stack arguments here.

If bt_stack_arg_mask(bt) is non-zero at this point, wouldn't that indicate
leftover uninitialized outgoing stack arguments from the callee that were
never matched by a BPF_STX?

Instead of propagating these leftovers to the caller frame, should this
condition be treated as a verifier_bug(), similar to how leftover stack
slots are handled just above this code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507212942.1122=
000-1-yonghong.song@linux.dev?part=3D7
