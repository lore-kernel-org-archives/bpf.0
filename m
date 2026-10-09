Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F9E3CA486
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 04:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791520112; cv=none; b=SIOmG1JQmgcV02R5B+xdoK78ZHO/LNBuUG0VdooE3WutjOruRAYT/q0Kub2d0Y3Ei25OmBqsKz+Pd6XDwEfbA3pSzkF4aoKARMz0jczZRJ2Sjchg+uZUpBiqw0m8iiZjPlzVKgY/lqWLHYWvkyDSuki3ESnBqIl2e2056Bcsq6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791520112; c=relaxed/simple;
	bh=KklEAwJGvScbxxrE+H+KY/i/KvG6v2Q9CMC/GdHGAAs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dJweyX87mdRsKkKjKcHtmVxx8OR/QeJfYqPEU0TtniBRVvaxx4Wg9ni4ssflnNLC080W/y6ess5Y8tWeDEahVW7E+zRVV5xELMB5jlyi5tsweUCOSuZ7sil/FRD+viy8XFv8XyrlXJc56/hiA2j4W3vY2RaHYhCreg4jz2yaAX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7wvYTj7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7wvYTj7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6C11F000FF;
	Fri,  9 Oct 2026 04:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791520102;
	bh=5P90u1fJMIRxYEzO1YGn0/khQ1x+6akRIWTn9Kr1tvM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E7wvYTj7BlgFfpVeacZcFnP713I0qC9EIZNCYzQZ78OAcCYwP652ARRn3KFZkSfdf
	 GaJWq3xrs3GwpAY/2PFd1uipX3AyAc+OVgq/zrPGnv7i14EkKNXvtKYx/EVCLSbwUv
	 1tvo5J5JsHaqQnyKbKwKWTgwfnum6/6N1SGRWzonREfOZ9An3De+cjWxYvfZhpmv0e
	 oOLyce+YHuaqx9iWkB4XqnDq8IFCljk1mCO1YBNVJ5At+BUJ9NZWJcAP6ZO5sV+bfg
	 Dx7k792VTZyu2KaM2H5SZsSigozGZHPPGZgW67IKbc5M+sZG/59Js9vAjoK/yUCM05
	 DxuAVKG68Uoig==
Message-ID: <sashiko-outbox-164829@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v10 04/24] bpf: Keep a call site's landing pad
 in insn_aux_data, add lookups
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009041508.23246-1-yonghong.song@linux.dev>
References: <20261009041447.17092-1-yonghong.song@linux.dev>
 <20261009041508.23246-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 04:28:22 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: adjust_insn_aux_data fails to shift cleanup_pad for BPF_PATCH=
_MOVE_TARGET
--

commit 8654da066c194611f7e2de5fef00da7ac62a0070
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Keep a call site's landing pad in insn_aux_data, add lookups

This commit tracks a call site's landing pad in insn_aux_data as cleanup_pa=
d.
It updates adjust_insn_aux_data(), verifier_remove_insns(), and
bpf_opt_remove_nops() to keep this data in sync when instructions are patch=
ed
or removed.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 206cc9a614a95..64baee1a37e60 100644
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

[Severity: High]
Does this check properly account for the BPF_PATCH_MOVE_TARGET patch mode?

When bpf_patch_insn_data() is called with BPF_PATCH_MOVE_TARGET (for exampl=
e,
when inserting a prologue), the original instruction is shifted to the end =
of
the newly inserted sequence. If a landing pad points exactly to the patched
instruction:

    data[i].cleanup_pad =3D=3D off + 1

This condition would evaluate to false, leaving the cleanup_pad unadjusted.

As a result, if a subprogram with a landing pad at its first instruction
receives a prologue, wouldn't the unwinder incorrectly jump to the prologue
instead of the original instruction?

Could this lead to stack or frame pointer corruption by re-executing prolog=
ue
stack setups during unwinding? Other locations handling jumps typically use=
 a
ternary to handle this, such as checking if it is greater than:

    (mode =3D=3D BPF_PATCH_MOVE_TARGET) ? off : off + 1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009041447.1709=
2-1-yonghong.song@linux.dev?part=3D4
