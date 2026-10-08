Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE534189DD
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446507; cv=none; b=lKIsZUOxTdz3xyz9Cr5jjLLrLnhK2qyZoOZ1+sSEzRTj9lUhmwxv7/F8KNHirrCwUHBgBORrHZp3KOMAW6NI4qFWTWfsJZS76w4TehHT/K48px32phzOSNHJ6tC2hegjKPOx0aEtw5e43qN+wlbTzX6Dgd4HzSWpU17nZwzEz3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446507; c=relaxed/simple;
	bh=YFU5ymifKk56aOFQ+vBuLblglgnWUIV14A03Tl0OHW4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=VRGAq1b1Nkt6WcSqMhskixr4XFM0Qai/qoL/uJjDovWpeMq1HyWfyslB2EROxk5YoEQJxW3w32IFyE5Kl3w4mt1/5ghvWQs1FP4WN6WNxaQwNOUsn1/Vays09kO3LN1mk8ofAzfKSj2XXeXB1xlNMwvPts65OUPC6z577+4XUpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ggs+MBOH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ggs+MBOH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB26E1F000FF;
	Thu,  8 Oct 2026 08:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791446505;
	bh=TB1qF1yXXbYL/KwYM/C6rc3n0ObrQiFz85RQgWc42gQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ggs+MBOHEgwas+nYsDtuXuTEp5dtXJfwW2DLmGZPp30A3+HPGPrl7ANdnLMttXG+K
	 xLNfpwKUrfr9BHLPISToaDtGvEKZBYd51n4YxZCHJJHvtYzU824kSoMy+HGiesBSLH
	 DIZrW9Iy+E0MiJo+Hq5NTmsiS2d6IoxXyjs6lkEZ8xEltc8AOPCSlwIQXisQdFYmsf
	 cuig32REqId+NKy3fn0Qvlf91lUnIlyxIWCvamizpDHoD7igZQbB0wnMZndTisTCzW
	 79ofbTXIsFxn0ongcvd+t/Io6+79Dxn+74EwEEqttkUuWp7448IiTfQg4P3eV4t69p
	 zet6RslKSYeOw==
Message-ID: <sashiko-outbox-163795@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 04/23] bpf: Keep a call site's landing pad
 in insn_aux_data, add lookups
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261008075020.2996443-1-yonghong.song@linux.dev>
References: <20261008074959.2993751-1-yonghong.song@linux.dev>
 <20261008075020.2996443-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 08:01:45 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: adjust_insn_aux_data() fails to shift cleanup_pad for BPF_P=
ATCH_MOVE_TARGET
--

commit 1bdc64eca7dc9ba53a20b6b6c4d0e4448bdd4aa8
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Keep a call site's landing pad in insn_aux_data, add lookups

A call site's landing pad, if any, is kept in insn_aux_data as
cleanup_pad, so the three places that move instructions --
bpf_patch_insn_data(), verifier_remove_insns() and bpf_opt_remove_nops()
-- keep it in step. Add lookups for it and for calls to bpf_unwind() and
bpf_unwind_resume(); their users come in later patches.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 206cc9a614a95..64baee1a37e60 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
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

[Severity: Medium]
Does this logic fail to adjust the landing pad when mode is
BPF_PATCH_MOVE_TARGET?

By unconditionally using off + 1, this appears to assume
BPF_PATCH_KEEP_TARGET semantics.

If bpf_patch_insn_data() is called with BPF_PATCH_MOVE_TARGET and the landi=
ng
pad is located exactly at the patched instruction, data[i].cleanup_pad would
be equal to off + 1 (the 1-based index). The condition
data[i].cleanup_pad > off + 1 evaluates to false, meaning the landing pad
index is not shifted.

As a result, the landing pad remains pointing at the newly inserted
instructions instead of following the original instruction shifted to
off + cnt - 1.

Could this cause the unwinder to jump to the wrong instruction offset,
potentially leading to state corruption during an exception unwind?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008074959.2993=
751-1-yonghong.song@linux.dev?part=3D4
