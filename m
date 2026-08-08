Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C732D7D3A
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786217346; cv=none; b=F/gM57Z0LYqpTAo5YBWMtDPoB6ReDuOPQyZKaeoynDRDPkCzE7jJ1084kWPpF2jaQGng9YM0dhT66Zj9Hwag9oj0mHJH6npWb7YapaPNxTpNfNqhrcyQ9f91k/gMn19Tufmw4EV8LgtUe+KA0VOdGF88g6COmIxMKMEevbcWz08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786217346; c=relaxed/simple;
	bh=r6bNJlea3anXNtj+yOz/wisgcMCM03+IuzqcM40XMcw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iyjtmCmNTCTPrnMByD7/zmHk8bpBVR/kRzycgE/DmQK+Lo0Z6Cf7yJJx2DSAfGH85fJHIej5JB8sPrhtxzp7C7lrfTeElfLyYDRuwAf19Etg1t8qTo4Cxw6oBdUXyWWXICqjbnL1jpwOyLn7AiKs5SqHRWx0nYmOHFq7LAKp+cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/ufa4tn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/ufa4tn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963E81F000E9;
	Sat,  8 Aug 2026 19:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786217344;
	bh=Ku1irFc3mpocXtZtoER7OyoahBZaOaNdVthf0CuQGmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e/ufa4tndw+j/b0XHe0kjZJjEEUPfwSPJ2xUjo7CLzJva3MBM8RAYL6+gXMhD27Kd
	 XPk2kYyiqxfsff6ZmlK17nO6cW9MZENF3Fb7La3o+vnBn5ZdGwluRlEh5r0KXwJcJ4
	 QkM4vU/16LYw+klEADsMqQiEOJ07rCInoVi799O5n5NQTE1Q25yibnANYkUqSoB7aW
	 ajac7XGbPbdvUFFL7lB6n+ThedSRvEo6xksLmSOk2Z0r06kQLBDYBt1HbSb2tcDLN8
	 JLP7WAQLkQYPD97Rch9EQhWFE6BsGLEL6Qqo4Mmp7Yh+8C7EEY8z/zNu14SPTfCITz
	 fdykMLGHIhxjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 04/13] bpf: Track R2 of register-pair
 returns in precision backtracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260808190342.1898844-1-yonghong.song@linux.dev>
References: <20260808190322.1896580-1-yonghong.song@linux.dev>
 <20260808190342.1898844-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 19:29:04 +0000
Message-Id: <20260808192904.963E81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comments do not follow the required BPF subsystem commen=
t style.
--

--- Patch [4]: [PATCH bpf-next v3 04/13] bpf: Track R2 of register-pair ret=
urns in precision backtracking ---
commit 031a41deb76f72f449ddf5239bbf769a2cbe7e5c
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Track R2 of register-pair returns in precision backtracking

This commit updates the BPF verifier's precision backtracking to correctly
handle R2 for functions returning values larger than 8 bytes. It ensures
R2 is cleared from or added to the register mask across function call
boundaries to prevent unexpected register mask verification failures.

> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
> index 40bd04421a991..9b112bf427a57 100644
> --- a/kernel/bpf/backtrack.c
> +++ b/kernel/bpf/backtrack.c
[ ... ]
> @@ -425,6 +425,14 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
>  				 */
>  				verifier_bug_if(idx + 1 !=3D subseq_idx, env,
>  						"extra insn from subprog");
> +				/* a global subprog returning more than 8 bytes
> +				 * sets R2 as well. R2 is part of the args mask
> +				 * checked just below, so it has to be cleared
> +				 * here rather than next to R0.
> +				 */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred
BPF subsystem style? The guidelines specify that the opening /* should be
on its own line rather than sharing a line with the text.

> +				if (bt_is_reg_set(bt, BPF_REG_2) &&
> +				    bpf_ret_reg_pair(env, subprog))
> +					bt_clear_reg(bt, BPF_REG_2);
[ ... ]
> @@ -522,7 +543,29 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
>  					return -EFAULT;
>  			}
>  		} else if (opcode =3D=3D BPF_EXIT) {
> -			bool r0_precise;
> +			bool from_subprog_call, r0_precise, r2_precise =3D false;
> +
> +			/* BPF_EXIT in subprog or callback always returns
> +			 * right after the call instruction, so by checking
> +			 * whether the instruction at subseq_idx-1 is subprog
> +			 * call or not we can distinguish actual exit from
> +			 * *subprog* from exit from *callback*. In the former

[Severity: Low]
This is also not a bug, but since this comment is being heavily modified,
could it be updated to place the opening /* on a separate line to match
the modern BPF comment style?

> +			 * case, we need to propagate the precision of the
> +			 * return registers, if necessary. In the latter we
> +			 * never do that.
> +			 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808190322.1896=
580-1-yonghong.song@linux.dev?part=3D4
