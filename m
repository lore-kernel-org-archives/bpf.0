Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4775A31E831
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641984; cv=none; b=gUi/C0EE5fE2dG/kJiMhIuyIvPG6aO8PCDRbWENW5we+fMeBLTpKpV+bn32t3gM03BLQ05rnkBY8ZZHabMBFLQMAVYyY+Z8K95f5fRnQol3JFvxvz6PtVvyrFTgyQapyTHRGUkaYesHcfLV9NjEapZaKVTJZLEgtAPjbz1yP4Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641984; c=relaxed/simple;
	bh=rJvPorskBlJFYiOGIlcORy5mi1GGwPH0tzBqicQQQlA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=THceP3PaeCzCNVGxlvr2qLGPEh4D9YpeM5VbE4MHTXddKrfF7AWdCnsFn/BrgN83QqoZ1WWN20B44We2mLoXe+BHwonlrFrhL0P0nLKToKEHyIYNEgKIWYD2lnpfZl6WjETA1EipogMzVi6Wg8efFFWbRq5xngSzh4fPwUDIFVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OloToLsr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OloToLsr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9D71F000FF;
	Tue, 29 Sep 2026 00:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790641982;
	bh=WKugapZXaQHU8ZENVnZob8moKjEVzINMwvjBINrfx7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OloToLsrnMeQqq7E2WQ0ZdsH4pxWHzImqZMbK+PIcAzWJxMIBufhN11SrXiDIiBVk
	 o4GNfUHL98ATyglYxy+kU9DygshEK1KssvfF4p3fjKYHW/JyvOljhQfLSEZsrBvzmg
	 GMbeR4mtVqWI/cb2j6ux+Mv+WtlGl/ck0eGAZPQ8SENXLQfYEbo3RbIYiDu9PtGYhF
	 beKmoQ1VRHzCdJgvDTfC5CbjC/AgWA8Ue5XAINPrNeoRUuUeWp68LkvttUzwA5px45
	 y0u4LNgcXWMjBqpXHkYyHA/fnFo/Y6UNVilLdgdrj9MmHi9KtaabHllLQEsETQX8zq
	 2e3+EF/TJlxFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 04/22] bpf: Add lookups for exception
 cleanup resumes and landing pads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260929001623.3247375-1-yonghong.song@linux.dev>
References: <20260929001601.3242665-1-yonghong.song@linux.dev>
 <20260929001623.3247375-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 00:33:02 +0000
Message-Id: <20260929003302.BA9D71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: missing cleanup_pad adjustment in BPF_PATCH_MOVE_TARGET
--

commit ddeb49ab1c3e86d5fea9b3b127432b6e34db617b
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Add lookups for exception cleanup resumes and landing pads

This commit introduces helpers to recognize exception cleanup resumes and
landing pads. It also adds logic to maintain cleanup_pad data in
insn_aux_data when instructions are patched or removed.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 37cf130ebb57b..5b7fe4ba610b3 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
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

[Severity: Medium]
When mode is BPF_PATCH_MOVE_TARGET and the landing pad is located exactly
at the patched instruction, does this condition fail to adjust it?

Since cleanup_pad is 1-based, a value of off + 1 means the landing pad is
exactly at off. Because this strictly checks > off + 1, it skips adjusting
data[i].cleanup_pad when it equals off + 1.=20

If BPF_PATCH_MOVE_TARGET is used (for example, with gen_prologue or may_goto
initialization), the original instruction is moved to the end of the patch
sequence. This means the landing pad should follow it and move to the end
as well, but it will be left pointing to the start of the inserted sequence.

Could this result in the unwinder jumping to the newly inserted prologue or
loop initialization instead of the actual exception landing pad?

> +
>  	/*
>  	 * Last slot instruction could be a newly generated
>  	 * BPF_ST/BPF_LDX/BPF_STX, systematically mark it for non-stack access

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929001601.3242=
665-1-yonghong.song@linux.dev?part=3D4
