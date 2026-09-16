Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194DD3033CB
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 05:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535996; cv=none; b=OEk8DeSsh/+STVBA3RKJvC6ov+yMHkG6GemvfEbLxbWmaKRsS3x1c53iIN3I/Fy1HxGq7Ht2a7pmP1K0fatWdmQuhw2R3yNKs6xXi4RP0AqRaM/vkFVb5lC0t6X02BdCrqkxOvqnxsFdgEzcLLU7ZgLdTAbqrf0M1mcXOvYznoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535996; c=relaxed/simple;
	bh=SmYSDOLRRM74eWc6pYLVc84iyeauKM76LDjdOD56qZ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J9jtbFCtvSw2ckvo7LudPktMkyI2zTGUYqgi1rXTpZvQs/h8GWRw6o3M18TiwNzegfcaI1Tnn8S1pHJ4obRulouIcDHtilPZKfiKhBb/F3YkSSFdyhQBW8oweMIyberLh5dGhu23gNtq6llIGk7QzuIVMws+jz6/7uP7bVHr5Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAo4VynM; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAo4VynM"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8693af0d7c4so509832b3a.3
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 22:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789535994; x=1790140794; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hF+U/V8dKYE44pfniEETsoxX5ZqXzvRK/zjViF75UmY=;
        b=GAo4VynMVek3afyVNpoSET1Dpkfc5GBLiZgII320tnxWq0nNNOP0uFTTX44npExKTl
         LM1cvxK7fUNZM/FR2vjo742GFR0mpIyuzzc3BgFdWh3Ns92FlTZyoGjGUrWxdZljDZ3K
         xlvy7KOyH6TuqhDSWT4iLEJebChii+RBb0g2Y9C9a4Zdth9p4aVHkfaEOms3CYAWOBOg
         EXtLRedCCLIdIVxtWPQDv+LjNJbjJbwdNqfxVOlCmLdtS6T1OH0mYRjcIRZzSUAcobcu
         paoYCdDi1nXCN5JujqscUgGIOoDOfeMeKkvWVesitPJbFFGZCE8H/cuo745aZSUYfhU9
         mylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535994; x=1790140794;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hF+U/V8dKYE44pfniEETsoxX5ZqXzvRK/zjViF75UmY=;
        b=Pi+PGoo+uukJaKA7AKwUFQHrKV1RZk6dH9W6CRjvCgk7Wz8fEmZ14pFLmUL2bPLPQn
         lFiFTjPcQgN16nzUD31uM3u0LjZ3eobuEee7sTt4Bvp7DPb6+hKvXYvqdQDoIi9NuLs7
         Y2eazvW6o1orjkvbp9A4jc56b0KemmEkeOKQ1X49dMn1M1rtThxkZU2IGiphZylh43Ct
         GOyq83371RQ4kZLhp8UECPqY+fupbl2KLjTIK45HZEL6v0rdACrjL3k9Gg0gDtWNPOe0
         g0McW9zGJ+n/hQMArcj8UjdnRjW6QkTRk1RCoXD1ePJOffvG9grKWoLwe+V+aqGSfrYv
         x0oA==
X-Forwarded-Encrypted: i=1; AKwUvBwdJYL0+gxmlH+M8utoq+X+9LP5xuYAsk2g9GsClXQs+Fuus+es/rFV2HrzwRTLxozyuPw=@vger.kernel.org
X-Gm-Message-State: AFuF++mapBiwCLFi1E29emRYZB8DlEUKSTynstk1yMiTZTMGZ+LeUFuA
	A9yKNNJq5FcVzSXwABdm3KzNpyu8+TRQgBtM2x1tmMflSPgllCifx2Fk
X-Gm-Gg: AYBFou1C8vGDt0B4gXzGeRBFsEzCrOP3exNmmMA7ydwb6+yWEMTX2jNc7eVhwHX55in
	RU8vrOOBCRgX27LjZpr7OgM1xdNkxOtAtv2MPGfdOQWGsOjGkzFmYfg9WFgAmL1Tb2f8XCAATjg
	yt/kbk5WTWReWgQdHokbJAKgroeWJeWT+TB0VlkGwAvQidET7NeIMlsm38iZAjlv++Ujm+fAOxg
	zVEFYq2S+mvAaOJCPS7+h4CzuHybYapl+dA3qP30GoON8F6OPAub0geeQlAmU7GTniWGRydeS+B
	z7VpTNJFcjxzPGNLOonWLHpgd8okbq4qB4AehTaftlOD48dysokWpvJpc9tW62SkbRoe1l/+Rzv
	fIMUpXP3WgqP4lgkFoukBtGlHwVN73ytTGXLOIZjEcaoOb6LftaZtxYLoIkbuSBOxyZ88iHlX/+
	1YojrPIk1G6t79Vr7F+exQWFdKad+8nWJ9241urY4FpTs90ELCEh6QPcc1Ft3yvQgD7LvSGf3gC
	+hBUu9+hcnouRAZluHifkin71U=
X-Received: by 2002:a05:6a00:348e:b0:857:72ba:ff0a with SMTP id d2e1a72fcca58-8723919d1aemr2782793b3a.18.1789535994283;
        Tue, 15 Sep 2026 22:19:54 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-872011498f6sm579480b3a.21.2026.09.15.22.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:19:54 -0700 (PDT)
Message-ID: <309af9b05e49a62f0a721cbe04673468f11e64f4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Fix generic __uninit kfunc output
 buffers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis	 <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 15 Sep 2026 22:19:51 -0700
In-Reply-To: <20260915141004.1196460-2-memxor@gmail.com>
References: <20260915141004.1196460-1-memxor@gmail.com>
	 <20260915141004.1196460-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-15 at 16:10 +0200, Kumar Kartikeya Dwivedi wrote:

...

> =C2=A02.3.4 __nullable Annotation
> =C2=A0---------------------------
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index cf85141ea167..9ddbb20ec1e9 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1547,12 +1547,13 @@ struct ref_obj_desc {
> =C2=A0};
> =C2=A0
> =C2=A0/*
> - * A memory argument a call fills in. The verifier allows the stack to b=
e uninitialized if
> - * the range is a known constant. Stack slots are marked as STACK_MISC b=
y check_mem_access().
> + * Memory arguments a call fills in, indexed by argument slot. The verif=
ier allows the
> + * stack to be uninitialized if the range is a known constant. Stack slo=
ts are marked as
> + * STACK_MISC by check_mem_access() after all arguments have been checke=
d.
> =C2=A0 */
> =C2=A0struct arg_raw_mem_desc {
> -	u8 regno;
> -	int size;
> +	u16 mask;

Do we plan to add kfuncs with multiple __uninit parameters?
If we do plan this, let's separate __uninit fix from the mask conversion.
Otherwise let's keep regno.

> +	int size[MAX_BPF_FUNC_ARGS];
> =C2=A0};
> =C2=A0
> =C2=A0/* Size of PTR_TO_MEM returned, taken from a constant allocation-si=
ze argument */

...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6c6b8d8520cd..070ec5daeec3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6981,7 +6981,9 @@ static int check_stack_range_initialized(
> =C2=A0	 */
> =C2=A0	bool allow_poison =3D access_size < 0 || clobber;
> =C2=A0	/* The call will initialize the memory; uninitialized stack allowe=
d */
> -	bool raw_mode =3D meta && meta->arg_raw_mem.regno =3D=3D reg_from_argno=
(argno);
> +	u32 arg_slot =3D abs(argno.argno) - 1;
> +	bool raw_mode =3D meta && arg_slot < MAX_BPF_FUNC_ARGS &&
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (meta->arg_raw_mem.mask & BIT(arg=
_slot));

Thit BIT(abs(...)) trick is repeated several times, can it be abstracted?

...
