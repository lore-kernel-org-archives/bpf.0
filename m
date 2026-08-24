Received: from mail-ej2-f10.google.com (mail-ej2-f10.google.com [74.125.228.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642C841D226
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576891; cv=none; b=qKaPz8UbWAobGnX/ZuNo+XpoIk71Ni7v/7I6nfrssDz3BjFRUifEhQgXyd85PUDAh00/wdvTFuSqf7rRdWQVFUM56YPwHLhuPrKqAq/DecnNv/7GEAfiLdQeUuEz0PVMG4Hpgc/ufj4yfzyGXPOTYvpx4B6DkySUqhT4lL2eVBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576891; c=relaxed/simple;
	bh=9pE7VibI+LRgd3qmkeN99DFY67r9KmGEbI/RLWt8S7c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=lEKtIpOtW1QOrJOqxgUX/UvO1T1TKyaup5/7cyZmJuuFhV6pxJgOEmWbLd/DfE9ek4u+GIG/N5EoABrad13Y/MEbkkbJFIY9H9Fj7Gei9CDeEzt0RF6pdtO05dAwYMxYqOPItYZughuDu7mqMpXFnltZJ6DWnvZpuDbt3O1wAK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yvxfobi1; arc=none smtp.client-ip=74.125.228.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yvxfobi1"
Received: by mail-ej2-f10.google.com with SMTP id a640c23a62f3a-c2193fc3dabso220339366b.1
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 06:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787576889; x=1788181689; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GzX3Jpoh2AUuavTdT66Gmv5ikLJdO2iPsNTVIieKaPI=;
        b=Yvxfobi1pvi6Bg2fg19hazzw5kSj9sxsdhyX7ADntLm7e34ZCm3yxU1LiYAXp4g0Aq
         JBwz/pX+6QyeqgAmLAwaiiZcFMFv96Ztr8/lVjxFC2soGeUoH/isBzwQ/yluj42GYavt
         5ie39FUqMn+pZYOkCN1RngJEfLzYLzeM9BXmr9XM1J409g/RuAF/0B9jw8tW5trTxskR
         H1tdd4KMgnVB59KILSqjaPX3+GezrCeZvMcVDMwt4NzGm0w2P9C6gOGV6AuoyMG6tuyl
         AvSe0QcwwBlg0AL+UpR6hXO/6+5iBhqJcEHzvdjg9yPY4yuvU3FkbAZwfjRk9p2ugy/e
         AdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576889; x=1788181689;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GzX3Jpoh2AUuavTdT66Gmv5ikLJdO2iPsNTVIieKaPI=;
        b=FCSEgKiBPF4EDlvL8TX7xkIDSwAs3FPR4qhGEVjGeh2wUqyJUveASUZ0dLFhDOP6TL
         FdMO8n3MGGCJMWwge78UwnYcjFPI1bImGmifFdcvNatzUKkQfHBRUHkn+h2XqWB4FTJf
         whAp7MmviY8yakAbcjo93zSiONVyLQ/nDGrYnERHXXNfDpvPG4+d5+eJxIC6owjYJS5b
         nwsyt1oCQmYLqUJGg41vzm3Dl1w0tpwvvstuXuKoQdlDRobgjn2qZnhMktvphqkoMGUc
         NQb6Uzp8ou2N1tFaV0UISLvTrR1tIDnZnOfY770kB+nN7kTmGr1XqwqCkVp/+vAtDdBh
         58mw==
X-Forwarded-Encrypted: i=1; AHgh+Rqns93gAErt3hVMcnDLLL7lbTNhVjkHlnm4sj2JqyReArCpG00AEkxFafzuTe9i2HdIaXY=@vger.kernel.org
X-Gm-Message-State: AFuF++nGM+0P5VUGJ3lHlHsgm5wDtjMFZvShpIiRhtQTnG4F8i0UFgIp
	17cXq5CPg8X5dg9Z17h0k9fZf4RSL2R87qPYnbPZ/YxXf7WrV1FvnYcXLOcPlbGt
X-Gm-Gg: AR+sD11Jgs5uiep9d7wlAy6Jbx4/XmoE44Zb1A8sE7aSZf4eSPXBwED2czTX5cE4pvi
	bBptqnuNNsj+cCKy503wNH4oznyM0SeLP2WPofefPZz0GjCpVtq/XsA69uyYOpQYSQGbZI6ugfj
	a4TaXs2AoXBDlmpUVJprf34ZP6mRonwwvHaMN61wFtuaWDYXqLfTj4PdtrRy+POxppiqYRxNUqz
	/4v4sTZ5cTixQf8C8UPyomz74pts48GiZ8jBLX0mds6XnCdDkY6Pu6lzxQTAAlm3gzZ28fD3+J9
	UsJfWfJhuiNPg8kuF4mrz3BzpLuCpQdijkEr4yjl0imy4y90IdXHfEVbXWXbR7kFgLxrR1aNNya
	jAmCgVNiEm3dhvR7SSxz1Nz7GKSWHjxnwIrr0FzxMi0BK0rH6UVs0jXcD8OiY755CbnNlfSFMoK
	sSsHpOXTGBTlTki9+t2HiYElRioigkKdMNF5iv6PFmYiUatKMKyjVL4sHB9y0Lkxt5aYHWAXDEw
	EizyVlY8ztQhrZq5DCz07T+1AnDdJ5Y2OuQ1pQGR6EMOR9nnPJb/PBc8GECUc2dN7zcyXnwB3aj
	31G3rNb9tWDPE/cyxAzv/8isM6s=
X-Received: by 2002:a17:906:a349:20b0:c21:8191:12cc with SMTP id a640c23a62f3a-c246ac03db1mr2320301966b.22.1787576888268;
        Mon, 24 Aug 2026 06:08:08 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496296a46sm1381383766b.21.2026.08.24.06.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 06:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 15:08:07 +0200
Message-Id: <DKX74D69UDFU.3ICXMZO2VWVDG@gmail.com>
Subject: Re: [PATCH v2] libbpf: Ignore exception frame section
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Tw" <tw19881113@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260824130245.580545-1-tw19881113@gmail.com>
In-Reply-To: <20260824130245.580545-1-tw19881113@gmail.com>

On Mon Aug 24, 2026 at 3:01 PM CEST, Tw wrote:
> Exception handling in BPF program is not supported right now, let's skip =
it.
> BTW, I found this when building BPF with Zig compiler[1].
>
> [1]: https://github.com/tw4452852/bb
>
> Signed-off-by: Tw <tw19881113@gmail.com>

You need to have your full real name in the SoB tag. Patches cannot be acce=
pted
otherwise.

pw-bot: cr

> ---
> v2:
>  Revise the commit message.
>
>  tools/lib/bpf/libbpf.c | 3 ++-
>  tools/lib/bpf/linker.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b749c0174..05727c418 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3867,7 +3867,8 @@ static Elf64_Rel *elf_rel_by_idx(Elf_Data *data, si=
ze_t idx)
>  static bool is_sec_name_dwarf(const char *name)
>  {
>  	/* approximation, but the actual list is too long */
> -	return str_has_pfx(name, ".debug_");
> +	return str_has_pfx(name, ".debug_") ||
> +		   strcmp(name, ".eh_frame") =3D=3D 0;
>  }
>
>  static bool ignore_elf_section(Elf64_Shdr *hdr, const char *name)
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 78f92c392..1fb0efdbf 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -599,7 +599,8 @@ int bpf_linker__add_buf(struct bpf_linker *linker, vo=
id *buf, size_t buf_sz,
>  static bool is_dwarf_sec_name(const char *name)
>  {
>  	/* approximation, but the actual list is too long */
> -	return strncmp(name, ".debug_", sizeof(".debug_") - 1) =3D=3D 0;
> +	return strncmp(name, ".debug_", sizeof(".debug_") - 1) =3D=3D 0 ||
> +		   strcmp(name, ".eh_frame") =3D=3D 0;
>  }
>
>  static bool is_ignored_sec(struct src_sec *sec)

