Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9303128CC
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782419678; cv=none; b=n4PfR1knAAaOuxit3X3gUrFtM48lzqSQIy86Pert9yAYXSNJfENzGbUdRDt1Yn3O8juYfdg4B06KB45VarzvnRvKESPyZvFNeTm9LtVAupydfAEsIo5Uj9M4ci87cjCZ9sV1G8qH3WvAUSISyPAvYBZG9s4EPrB/u1KpdNP89LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782419678; c=relaxed/simple;
	bh=jvefDCupa63B7z6ewc8630KRIlgmUwgjGlbSSSzOvhw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HoxXhchXpuPnM/SeKRihkgRpaOslrpSm2AjnOh0IfrZep7J0WTASmByIgqZlE0l1a3UGudebBeh5aXZncp6Gn2ESMozdhGxVo7w7M0laSyuShgeE1bOnW0S7YsB8Ly2HO6eGqe3iI7C6jt0sZr6+VOCYP2JM/HdZmLva5ZDqKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2ZBfBby; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2ZBfBby"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-845bd3fcfa3so143174b3a.3
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 13:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782419676; x=1783024476; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j4cziRsnOXU8udnzmTxz4VvnRIsHkxiDHnSiCu2+4Iw=;
        b=Q2ZBfBbyP1DHdbTQM2KQsipfzQ3jCbx1FckHKtvFCFs57R0u3DHVOIj5rlKswpUKmE
         EmQLfUQL9VmzKwe/zpd54DG2jlkBz2bUkLzaRxLuqGPYx6ebHNmcKrvKL0PdDIh+TIMG
         5tfDyX76CJj8BUrvt6EX/+aLIjukAity0jpM1XCrN8fq1wdVlKW0+LYaCiwrliHyPJTc
         kP+yXMUNB6RlHPfTjGK0c0hnPKk21QWyxKwTdG47jKFw3BLkdejTmo16QG5c0bd/flFa
         xKW42k5cUxaPU2YzQE1kPGg3J/srKpHeQNU3zcZjhV7xyDynnGcn0hC9YiI/Hr1zSF2q
         TXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782419676; x=1783024476;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4cziRsnOXU8udnzmTxz4VvnRIsHkxiDHnSiCu2+4Iw=;
        b=ZeXo9iCrfJgU6jp07fL3vlazeBFFqJ3yQFjBi5F1l24WGg9L2zg1KTPzIc1MaeXzsS
         zPUF6gBHElAjJVSUIWQRvj8drWxTVB8DAVZWrYyegbNou7vzTjG9GsHhh4qjxJwdh0mP
         JFqIx4s0Om3ytfAYpY9Ge/zSwIGnk8DQfZL3Yw4NeBuQ44M8flCxbRqOMBbw1XmGjack
         WP8GCgCXBmDj491erjx4DM/4GgeKGzBYuvpocfoiG4RRgwJolfKfwY+fI8PRHxZV4ho4
         rA3x6xFX4YNSaz43XZuuFFyzhiPbNgf1810PHU6WECqgjEt2u4VLRpyFNhw2isL+/j03
         kC8A==
X-Forwarded-Encrypted: i=1; AHgh+RofjelOR3G4F/Rf7uNNhbN/RAZV1RnFZze25cq13REm8cDKl/xhuLCmkLaImgMkCl+LBgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG2NXuPIUPlR8ssdkuxqYLpTIqGnFqLMESGWFn7fD3gpiTj3NE
	OS5rOhQmdYpBcCo7HiLwyP3yixM1i1qG397rZ5f6iRagQ7f4tCqjoV+I
X-Gm-Gg: AfdE7cnolsO2EppS8TIE2rsCvR+YRRxDh5hvuTdZv96HD0LKfaE9+vgmpN/mDjgPVPS
	H2DNIjXeHlGD1AL4HaYtHI6i9wTwIMIU2RxCYuAB4GUyndA8KPdTAP0NYD3BT28opZLyW+T2piu
	jdm3NspK4p+MLVvYbg6X9/jXXo9nzcDs99rAyndH0J3x71tl0kl+t4jktmSFTbmqRF061/PHTN4
	zDwbMkRQMmrjl7zj25t50IEB2peQIC/VI41X15kLBjg8K90buHZdDjI4khB4NKZsgIkNF5cIPQf
	WT7yYUU5CoqOJuBGGf/GmzZ9k6WM8rJkFSgJRxbLepf2VH/pOSa9fFZ8g0g287MoWBsGspUS8qL
	D8gVEww9+9QQIxObcHw1ePfQXvZfwB8wUDtZcvl4MONdOfnc+ZbpYZ4cGl9Zmuykg+wDsvLauEA
	tcVhliAt51VrXbC+PqtN7Nn0c+QlJ276q/iAqMG2d16A==
X-Received: by 2002:a05:6a00:b81:b0:842:7f81:8085 with SMTP id d2e1a72fcca58-845b39969a1mr5178575b3a.8.1782419676054;
        Thu, 25 Jun 2026 13:34:36 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845ba19f72bsm1607019b3a.20.2026.06.25.13.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 13:34:35 -0700 (PDT)
Message-ID: <f1f1c8875b8ee2122aea8febafdc15d79898e6d2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject MEM_ALLOC BTF accesses past
 object bounds
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>, Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	 <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 25 Jun 2026 13:34:24 -0700
In-Reply-To: <703a2cbfeb17ae707fa4a003b795c5326cc0abb8.1782197377.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1782197377.git.chenyy23@mails.tsinghua.edu.cn>
	 <703a2cbfeb17ae707fa4a003b795c5326cc0abb8.1782197377.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-23 at 17:34 +0000, Yiyang Chen wrote:
> BTF struct walks relax the struct-size check for accesses through a
> trailing flexible array. That is valid for ordinary BTF type walking, but
> PTR_TO_BTF_ID | MEM_ALLOC values point to objects allocated with the stat=
ic
> BTF type size.
>=20
> When walking a MEM_ALLOC object, reject the access before applying the
> flexible-array relaxation if the access range extends past the struct siz=
e.
> This keeps verifier-approved BTF accesses within the bytes provided by th=
e
> allocation kfunc.
>=20
> Fixes: 958cf2e273f0 ("bpf: Introduce bpf_obj_new")
> Fixes: 36d8bdf75a93 ("bpf: Add alloc/xchg/direct_access support for local=
 percpu kptr")
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/btf.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 15ae7c43f..3e68af9c1 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7069,7 +7069,7 @@ enum bpf_struct_walk_result {
>  static int btf_struct_walk(struct bpf_verifier_log *log, const struct bt=
f *btf,
>  			   const struct btf_type *t, int off, int size,
>  			   u32 *next_btf_id, enum bpf_type_flag *flag,
> -			   const char **field_name)
> +			   const char **field_name, bool is_alloc)

Nit: 'walk_flex_arrays' would be a better name.

>  {
>  	u32 i, moff, mtrue_end, msize =3D 0, total_nelems =3D 0;
>  	const struct btf_type *mtype, *elem_type =3D NULL;

[...]
