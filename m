Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F41279792
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 17:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251199; cv=pass; b=UVHOZ/92PgLrq3K8nHFMNXFV3qNYpcw31LR3xQJxlHsPr0WgOkiBe6BUqHkd3pyjJfoHSxF0l8rgFOxUGkHD3EZqOvSxnAARcLD4Tog0gBjsULzcb/Zziw0OlxPMCS9PFoiuVmfvk5eYHE0dVRrEnp4WgyKh92W76NtxSmlUcGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251199; c=relaxed/simple;
	bh=U55dxhPwWjTbDNblaC6CYNPA3GkL6VWrivlJzvge+D0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXD0tdgmYTJJcjs/BLJNLSEGJ9zGwRaG37MaLrZyFCGrrfO3K4f5+3r+5oD85Y+0YAWXsG6TvElRwgL0Ix6ztdt/irMifJBjm18N5fKGLAtfR4RSyJRJwDOFzhilEuxmw9bzKjra4AZRnBDtVI6gDhp2sKZB63R0nt6lrEAI2Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YavksS/Z; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YavksS/Z"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-829a9c03780so156750b3a.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 10:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773251198; cv=none;
        d=google.com; s=arc-20240605;
        b=G1HbgFVmUNWfL7NceqErEy/fUlZy3v/2o54LLIEQa6m984/y1vXvA/nvXqeIbHU1kZ
         GhJj4UKq/MOEGDzdMU65mQ/Tqv54BVhMeg3L/Zz6Acjfa2x4tQJWHuzLIbdOOV4p7ujS
         D2WJbLa4BKnLVpJARooj031WlfDqtT6G57ZwfOv/g6KSTEy/GFypdWNLBplJAcjWVDCM
         iLgZwYZOWUI22wvFkpolj9yclkFTgulerNh0gI7aZqXumN80Sev/xgeUZpnNZ+HdvO7F
         z9aPe4y1lB51xAgf57lvPTLQ4u9YJimC4F8J0S4m+J3ZDsV45MMUkAElzfWQOWib392y
         pDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v/OQNd9y+UayBiD2BW4UV3/sUJiK1ToC4qs87k338Zk=;
        fh=WG6c8s10GzEdqPasYfOZVFSOcoMqWFBGjMGptORn5BM=;
        b=Y8OUv1bna09RluqFunsk7HCdkKkyUWw5CYvheyhVcPmWIYJJM3hm9zkTD6bLcqnAAm
         L4/0sDvyETVihOSjigf/JVbXH5HrzBq7Ksy437+4684j6CH+6HmK6YLsPtiPQuvGLqaT
         ut+QNolQr1PJD4fQ60EdLTViO4BnkLd5/9G4A9IQ4CP22rfKlAhHb03WZjwwiUGjZrh0
         mjywIv7hTSTcl8yJ2mazcBUjQCBpCumJ+J70T2H0toEXePE9k3IfwVfLOAS+gWyRlGKx
         NZNLA7BCBJGXCd6pnE9WbfZZG9HDKufoz5VRNpvTy/MfDLn+6M34x5hK+5UX8A3hrDjH
         re5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773251198; x=1773855998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/OQNd9y+UayBiD2BW4UV3/sUJiK1ToC4qs87k338Zk=;
        b=YavksS/ZEFftR4ZyzPeGYlwRS875StLnGqgkKbkdJQzPDwTa3cvKWbHK3RjOh+3ZTq
         O034hrvOi+3GaAB3GNy56l1nAfy+VXBr+E5dzCNHVHpSba34nd+UIsPFVH9rkcAU6ujh
         1aHcAidpCBEEsVHGWACqCb1pj4X8Tih40LZhgjXsuMoGErkVVeP6X3MMUH0GZZfznUGk
         TjStfWocWkqpWyEzp8zVFmCqlDa77X84hkZwRmtq+zwF85zbFpUayLfPNw6w58GE75er
         VPObx+yF8maGFZIwTIHqhLWMRyTQL3R7RX3t9EfEdn1hBfCVYxKRq9ME9bkOO3Qy5i0C
         qWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773251198; x=1773855998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/OQNd9y+UayBiD2BW4UV3/sUJiK1ToC4qs87k338Zk=;
        b=I2ErA+sHk1yO92mB1iOhUpy6KwRB0lu8JklNNGU12RAryfMPbDit/5/ReOpxGz1nIT
         rshREmWZggGV8tDEtFroTCQbq7hGoXwnlLV1tjbLrxBAKWBueesvXqVs8xDiB6G+DptH
         hxq71tRipeRNHW/EO/LYlGuG4wJ/Ui02VmYxNV5B8mY2AQSichOnlEoC0N9C/jceLRmi
         qZ7RugZcbAQxVIGnVLQhp78Uk3i7WcdXRIjkT9Xq7qs6mKM4UU9MKknY7s6CBxt8ZcJD
         fvLlYRnHUICTtfdXA8FHUKD//fyott68VblvPGqbngGMr1XAXV705zFK/rT641KvWqUD
         j3lA==
X-Forwarded-Encrypted: i=1; AJvYcCVDo32Vv3XBKkS2QeD7LnkbA+OSWOvFikcGFT404/KEq+ntLKJcgRrw23oO6JEAVJQnG6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg0GDTWeR4gfBeLdqjnBayg2mTWqYvhvtoSApMh5XoaCGpJV0E
	KGnK6LflkV2RtQ2JRkQNRHyjAtWCUNA1JOdy3QdiN+05Nwf9Jn+JqI8kBo57NnR6o3ojH+0rsSM
	gheNacWaKH21tfk6EYaRqc2V3u6xsxUA=
X-Gm-Gg: ATEYQzz5ArftfN92jJX54hY6JJoe7Jso8GlDyDyrk58ryhYLDWRnd6iUbJ6qJwVdTBh
	vZNFQ3o5iEzuEt+QKEc1NUm6XcTsHwqZO3q7co/7orAoT18A52LL3ozCDPpYcDRWUp+RvyvqwNG
	NA8hmd6B4VZ6LsdHbuXcWOVJAdsQ6RknOyfQvpqLa9IHqaRdTo4qRysszsQ3jYTuoqgLooFFndD
	3DB95qVlgC0TzHodAaykZfWINSyC9SAhuiqgbm4BnuJBo72+1awI72ni6Wb+UOqM7nt3pWmG1Bo
	UEtynJU=
X-Received: by 2002:a05:6a21:70cb:b0:398:9e99:e190 with SMTP id
 adf61e73a8af0-398c60e4115mr3096099637.33.1773251197610; Wed, 11 Mar 2026
 10:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306113630.1281527-1-alan.maguire@oracle.com> <20260306113630.1281527-4-alan.maguire@oracle.com>
In-Reply-To: <20260306113630.1281527-4-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 10:46:24 -0700
X-Gm-Features: AaiRm50l3hjalPVXWnb3ojFmIUdLirJnF_KaJFQRejzIbEFIc3nbVQT0oD-dDKQ
Message-ID: <CAEf4BzYQGh1=EJkewD9wSyTawvwxTFJ9ODy-PFVHeuP59ATBQA@mail.gmail.com>
Subject: Re: [PATCH v13 bpf-next 3/8] libbpf: use layout to compute an unknown
 kind size
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 3:37=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> This allows BTF parsing to proceed even if we do not know the
> kind.  Fall back to base BTF layout if layout information is
> not in split BTF.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 42 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 9 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index ae13f9f4df08..9f4d1bd73b4d 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -356,7 +356,32 @@ static int btf_parse_layout_sec(struct btf *btf)
>         return 0;
>  }
>
> -static int btf_type_size(const struct btf_type *t)
> +/* for unknown kinds, consult kind layout. */
> +static int btf_type_size_unknown(const struct btf *btf, const struct btf=
_type *t)
> +{
> +       __u32 layout_kinds =3D btf->hdr.layout_len / sizeof(struct btf_la=
yout);

(give you are going to resubmit anyways)

nit: l_cnt or something? layout_kinds sounds like it actually contains a co=
ntent

> +       struct btf_layout *l =3D btf->layout;
> +       __u16 vlen =3D btf_vlen(t);
> +       __u32 kind =3D btf_kind(t);
> +

[...]
