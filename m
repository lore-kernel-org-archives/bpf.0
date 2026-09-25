Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E874FC8E9
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790371590; cv=none; b=O1N5mDn2BCEHd5da2uLkpy7zYBKGU2MldLlrvdCE9Qya2+r6xOntKdHAmLdRKs9nIpS0ZlC+xuZto7QDIzcNbFlQyqvF9BTLzXfqe7KlnW2KCtZR+ftrsNJuIqZzTWcmBFPDRsI5K2h9r+JMlPib+As5YGYHSXZh1qMeX46W9QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790371590; c=relaxed/simple;
	bh=uz3lUFp7kYniE/rWMaF91uYbFNGNa36W1sXktApW/O4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XRmIGNpkUBIEzYHJlyETODSEhiCtGWmNLyMfjvFkW1ZrQmGNYzOgPOFH5+dDvwE9RVBrP9Aw+XBa5o6VY3zv34xjNupisLNY/7jnP756vDlA2vYqDr4OaUgneOUiFyR4+f4ot1mjtXk0zzxTBXySj/IGYzU2Mfhav1dEaILjnmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iy2G7HOX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy2G7HOX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3451F000FF;
	Fri, 25 Sep 2026 21:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790371586;
	bh=RMCE+1/nRYgMOi9pRuQGzSFdjb5UWMkfItnIwtl5wbU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iy2G7HOX/s35wanVynR6C0lX+dAGdALpW0BWlj8AyIFHrSm3AekSH5I35udFYcHSz
	 o3nPueCDRpxyskzEb35PvwVaUwwQOEbWQ2rJjRAWXlGEGsym8rcSqh8SOFCIE9++fr
	 ujZBT8jXvAUBiTcoW1msGBF6gxLyd6qlrX+yS9c5HQR+nb7iylJTUNN+zKoBi0G4Fa
	 yK/HA3ctsY7GrwnpuE447OnMaeHRGCvxoirGpaWw8egggMDSfXO86UnMLkxKG9Y3cV
	 Q9ZVs/iTvtcT3L5W+/kzQr2yOZZyOgIe/HjNCgBnN9AEGn+ZfReZIBvU6gd9f/imoc
	 EU9Nwaes62Rxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 08/12] bpf: Check subprog dynptr arguments
 in the common path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260925211256.1834061-9-ameryhung@gmail.com>
References: <20260925211256.1834061-1-ameryhung@gmail.com>
 <20260925211256.1834061-9-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 21:26:25 +0000
Message-Id: <20260925212625.DF3451F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comment violates BPF subsystem formatting style
--

commit 45344ee9671457679fb9b5565dcee5c8036d67b0
Author: Amery Hung <ameryhung@gmail.com>

bpf: Check subprog dynptr arguments in the common path

This commit updates the verifier to check subprog and helper/kfunc
dynptr arguments through the common check_func_arg() path. It also modifies
a selftest to ensure both Clang and GCC exercise the intended register-type
mismatch correctly.

> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/test=
ing/selftests/bpf/progs/dynptr_fail.c
> index 9418dfe4d7b7f..148cf44173221 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c

[ ... ]

>  SEC("?raw_tp")
> -__failure __msg("R1 expected pointer to stack or const struct bpf_dynptr=
")
> +__failure __msg("R1 type=3Dtrusted_ptr_ expected=3Dfp, dynptr_ptr")
>  int test_dynptr_reg_type(void *ctx)
>  {
> -	struct task_struct *current =3D NULL;
> -	/* R1 should be holding a PTR_TO_BTF_ID, so this shouldn't be a
> -	 * reg->type that can be passed to a function accepting a
> -	 * ARG_PTR_TO_DYNPTR | MEM_RDONLY. process_dynptr_func() should catch
> -	 * this.
> +	struct task_struct *current =3D bpf_get_current_task_btf();
> +	/* R1 holds a PTR_TO_BTF_ID, which cannot be passed to a function
> +	 * accepting ARG_PTR_TO_DYNPTR | MEM_RDONLY.

[Severity: Low]
This isn't a bug, but the BPF subsystem follows the modern kernel
multi-line comment style where the opening /* must be on its own line.
Should this comment block be updated to match the required formatting?

>  	 */
>  	global_call_bpf_dynptr((const struct bpf_dynptr *)current);
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925211256.1834=
061-1-ameryhung@gmail.com?part=3D8
