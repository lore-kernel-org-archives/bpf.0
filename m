Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0942DBF75
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 04:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792037763; cv=none; b=JWGKwIoYHTnDHABrLWdq2DcyxMv/z417L6Am+RF93M31CLosyrYtbL8cBkUhp1Mo7W6eOsMvAbSrQ8E43PSohPJsXub5jl++p1wq01r7D+0t9MnoRS9N5SSRQKdBNes/YbX65Aw1WzfnjBzjR58zNS9DFJ3qUFTzxYn+glTwhS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792037763; c=relaxed/simple;
	bh=o+SWFjnPKb4ZaKaJNbX+74jgeg5lDFHZAG15i3dcMdc=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=umn2NQ98fVGQm/Cp7Vvo8+2RmJLNO5tG8V/suVU0RzN1QDlCQ3lfGb5iICpe+0C91zyMYqeI+uPvDvVXlwfLkmjshuTY2y33Kl6iY+ywPepFplRu0q6FhPpupZFUMGpmxsz9mvOTCfD8nb4pQXHZnuRbAZ10jRHNMwoEFTWeA8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5+iINnq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5+iINnq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458B01F000C4;
	Thu, 15 Oct 2026 04:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792037762;
	bh=YFV0lQR+wERl7HIPNURym/a2mIAd11NlT4Bb3EeV30I=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=e5+iINnqtIzdGb3YvcNQaD1wDO7Jr8U16sZnMGwIdwWRvOvOtgHrayvxloMX4bKOg
	 rXqsZzBPRffuUkXyIIv830ibhPx74FdNYaWYND+1BODeQWlyjuo4OzP1nOhg/LWXQU
	 aPe+QYy17sdKD+Z/JpMf/yCSSB9EcxapzU+VT7bB2cr4yCmAzx2rd3QkB6TKT2S6wb
	 4JHtHaHtqeeJHz2peyXJXe7qxKfrf6Vb4HVrIO+2Uk5r2Y9FWZ75/Ka5+vorMknOGO
	 eMTy0XNWcwiZydWjODHYe7z9/dTvit5qGl9v8ovNHDWEKOsX9nrYGSykD8Y300SPyl
	 drlQeWdz1/Ksg==
Message-ID: <sashiko-outbox-172243@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v11 04/26] bpf: Keep a call site's landing pad
 in insn_aux_data, add lookups
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>, bpf@vger.kernel.org
In-Reply-To: <20261015040204.856062-1-yonghong.song@linux.dev>
References: <20261015040143.854070-1-yonghong.song@linux.dev>
 <20261015040204.856062-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 04:16:01 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: adjust_insn_aux_data misses cleanup_pad on BPF_PATCH_MOVE_TAR=
GET
--

commit 407d61973b5e3b7df47dda20c8cb86db0ad2e4ca
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Keep a call site's landing pad in insn_aux_data, add lookups

A call site's landing pad, if any, is kept in insn_aux_data as
cleanup_pad. adjust_insn_aux_data(), which every instruction patch goes
through, and verifier_remove_insns() keep it in step, and
bpf_opt_remove_nops() moves a pad off a nop to the next instruction
before removing the nop. Add lookups for it and for calls to
bpf_unwind() and bpf_unwind_resume(); their users come in later patches.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index b2fa7e8bedf3a..18c563abd988f 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
[ ... ]
> @@ -244,11 +244,18 @@ static void adjust_insn_aux_data(struct bpf_verifie=
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
> +

[Severity: High]
If bpf_convert_ctx_accesses() inserts a prologue at the start of a subprogr=
am
(offset 0) by calling __bpf_patch_insn_data() with BPF_PATCH_MOVE_TARGET,
the original instruction shifts from index 0 down to index cnt - 1.

Because of the strictly greater-than condition here (> off + 1), if a call
site's landing pad is exactly at offset 0 (cleanup_pad =3D=3D 1), the condi=
tion
evaluates to false and the index won't be shifted.

Could this cause the cleanup pad to point to the newly inserted prologue
instead of the intended instruction, potentially leading to stack or
context corruption during an exception unwind?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015040143.8540=
70-1-yonghong.song@linux.dev?part=3D4
