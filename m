Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4713635DA63
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783975008; cv=none; b=BgafnV5g31eUKBpLzRQv9qv5U9riBifIfL+i4mJeS4eNrQbLTsB+50amnw1hE3rm6BghNEMesDScNYUi2iTXBdKz1TjG3A+Wsnc/bdokxTKNGtF7UB30iY5zWmKMfZcOA9JLpn4P01z4PNQtFkwnj2+KoHYhO+K0iAvH4l5uocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783975008; c=relaxed/simple;
	bh=5jnI160PD6NoJyLE84124ODRex2IYM8wMXi/A/p2b50=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mjEi3sl6RD5Jk4tjJwjG9fqIhy4jF2Ym5xUd44rd93BwFmypsSKtSnHslOKC/aOSGMBoWCRns4xM49gYsqCZMCUBG/NJvg0hyhC61hGxeNuLk+AJCwllIyH19Qr9eUPyC9+V1IjuzymJCmZM73aHLiPsfkSC42uh1TmyhwpL/Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=aVhe5oLf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="aVhe5oLf"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc6dd436c6so2674535ad.2
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 13:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783975006; x=1784579806; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Cli8DuotM7hy9fOe+TOwORbYCRQrrtgQLQxvRHzLU+g=;
        b=aVhe5oLfkRZyP9bAUZD1GTDcAou+wQazra1nC6w/k1DCyx0iL1Gf80A9GKJhRV30ui
         UUWiofo9E/QzPTi6pZna/h0smVAQRrWGpoPJ2mLe1fNbS4vbDkff0P7jLRQE1OdoHSLd
         VmnVRBgA+SXc7KFW4cO3hnRKTF1ntiBQkfBSDIb0FOgsVnECdG2OyA/zvpKEv5V6wxub
         yxgRt3+zDlXUUrL74S5pRKCqlmPiZaME02oteAAUza9mWJEEjB6122QDjpCxIyaa/JMc
         MtUZgi2HJC2wKuMh7fVrJz69pT39PgV71P8FD+9l2Ed5GmgOOOSdJ0vZL1zjL3a5Up0Z
         KETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783975006; x=1784579806;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cli8DuotM7hy9fOe+TOwORbYCRQrrtgQLQxvRHzLU+g=;
        b=WS+3rZQhbfAQIr+s4N7X4wNG8dgKXz/nCOKc2hdC6Dl1XipegDrQcLzRw6iGAjcSeS
         eLVdehejJ/E/5UdCQKbeIjybv9mMgcILye7xk/q/inLbCwaKdL/G4inSMsAu6LZObM/A
         WbWAsgtVsNK7BM4x7Q+0q4sE0wE2l+rnxwfb7CBE9VEfUjauwJEaInEp/3VucwrgDzMI
         m9w0JQYsWt0piJqvjE770pjrbZ4jw3aE/u771ubnUc4MBxnVFAvdJ9cj81RF7N6bTuKp
         z1d7BlS7671XJjj1lcU9j1aD5U2LAEEz/1l+aTfgUOTiAxyF/a9NBpcwFKqHKUAnIAr7
         9FBg==
X-Forwarded-Encrypted: i=1; AHgh+RpVeL89bcl9I8nvIz39y6hbXDHBq5o27++DJPkZTujl4B7X8JQIOEXW8+s3uUsBnkYJDNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrs33hG0/w9fJTOAk80GzxRAGXdD+RNoS5n49iCQcxR20wBNFI
	Mg7S61ZqP0iaDH8DEeFrTs5i9vqEpFD6oLkE4kga8XIs9IIR2bqtAtZ7zP/GrSFOwK4=
X-Gm-Gg: AfdE7cmCs5Qi10DBYoLA17W3tgiL2cZB9Q7bc59yGTyb1eQHsf6OG1KcqUYWHr7ABvK
	tV4m7tedOUXqnuCB5fMik24KCCY5MhW4wWalJjms1VtsDPF1vMl8XtQMO0zbpB4H6CVE3UsDZ8P
	b3PKL+MhidP+qkbevPSTOIArAjhiTFaG4bBlUW0r3SupV8FWmaZZPLHCmVWVMD7VHHB7Or9eJwj
	HBVNqQYpR2dthh8YNjV7QX9mZY14WilM1oSmqvU+78WPrvX5ncg+//pJeVYyyF+M64yhtyLR9Fe
	A3J4Fu8xE61AmIJ0s+60O48VnrIY/hAX322oxkMy4r45K7esQH9r1wIs/z8AWf11KDdKud0xjh6
	mFs7zaEiZVSHw4OW8WKHr9MsqN3IgJNZXLPA0wYL/IlK96Fmmk6L3ECX7GcQtVgIzw/cE+PV72a
	Tty0LYYCngtVBSJ50WBmS3Z16dazhLlmcvi9cTLYQ5mw==
X-Received: by 2002:a17:902:d552:b0:2cb:2b53:559f with SMTP id d9443c01a7336-2ce9f3a4910mr103562475ad.35.1783975006505;
        Mon, 13 Jul 2026 13:36:46 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d451sm104314865ad.65.2026.07.13.13.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 13:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 16:36:44 -0400
Message-Id: <DJXQCZA5YIMR.I9BWPXFXAMQ7@etsalapatis.com>
Cc: <netdev@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <shakeel.butt@linux.dev>,
 <roman.gushchin@linux.dev>, <kuniyu@google.com>,
 <kerneljasonxing@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 03/15] bpf: Add bpf_struct_ops accessor
 helpers
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-4-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-4-ameryhung@gmail.com>

On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> Add the helper functions bpf_struct_ops_map_kdata() and
> bpf_struct_ops_map_cfi_stubs() in bpf_struct_ops.c. They will be called
> from cgroup.c in the upcoming patch to create a struct_ops to cgroup
> attachment link.
>
> bpf_struct_ops_valid_to_reg() is also exposed for the upcoming caller
> in cgroup.c.
>
> The link update validation is also refactored into a new function
> bpf_struct_ops_link_update_check() such that it can be reused by the
> caller in cgroup.c in the upcoming patch.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  include/linux/bpf.h         | 28 ++++++++++++++++++++
>  kernel/bpf/bpf_struct_ops.c | 53 +++++++++++++++++++++++++++----------
>  2 files changed, 67 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7ac8873839f4..047ffc029666 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2252,6 +2252,12 @@ u32 bpf_struct_ops_id(const void *kdata);
>  int bpf_struct_ops_for_each_prog(const void *kdata,
>  				 int (*cb)(struct bpf_prog *prog, void *data),
>  				 void *data);
> +void *bpf_struct_ops_map_kdata(struct bpf_map *map);
> +u32 bpf_struct_ops_kdata_map_id(void *kdata);
> +void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map);
> +bool bpf_struct_ops_valid_to_reg(struct bpf_map *map);
> +int bpf_struct_ops_link_update_check(struct bpf_map *new_map, struct bpf=
_map *old_map,
> +				     struct bpf_map *expected_old_map);
> =20
>  #ifdef CONFIG_NET
>  /* Define it here to avoid the use of forward declaration */
> @@ -2316,6 +2322,28 @@ static inline void bpf_map_struct_ops_info_fill(st=
ruct bpf_map_info *info, struc
>  static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_des=
c *st_ops_desc)
>  {
>  }
> +static inline void *bpf_struct_ops_map_kdata(struct bpf_map *map)
> +{
> +	return NULL;
> +}
> +static inline u32 bpf_struct_ops_kdata_map_id(void *kdata)
> +{
> +	return 0;
> +}
> +static inline void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map)
> +{
> +	return NULL;
> +}
> +static inline bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
> +{
> +	return false;
> +}
> +static inline int bpf_struct_ops_link_update_check(struct bpf_map *new_m=
ap,
> +						   struct bpf_map *old_map,
> +						   struct bpf_map *expected_old_map)
> +{
> +	return -EOPNOTSUPP;
> +}
> =20
>  #endif
> =20
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index c422ce41873e..3d650a7e9f68 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -1236,7 +1236,23 @@ int bpf_struct_ops_for_each_prog(const void *kdata=
,
>  }
>  EXPORT_SYMBOL_GPL(bpf_struct_ops_for_each_prog);
> =20
> -static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
> +void *bpf_struct_ops_map_kdata(struct bpf_map *map)
> +{
> +	struct bpf_struct_ops_map *st_map;
> +
> +	st_map =3D container_of(map, struct bpf_struct_ops_map, map);
> +	return st_map->kvalue.data;
> +}
> +
> +void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map)
> +{
> +	struct bpf_struct_ops_map *st_map;
> +
> +	st_map =3D container_of(map, struct bpf_struct_ops_map, map);
> +	return st_map->st_ops_desc->st_ops->cfi_stubs;
> +}
> +
> +bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
>  {
>  	struct bpf_struct_ops_map *st_map =3D (struct bpf_struct_ops_map *)map;
> =20
> @@ -1289,6 +1305,26 @@ static int bpf_struct_ops_map_link_fill_link_info(=
const struct bpf_link *link,
>  	return 0;
>  }
> =20
> +int bpf_struct_ops_link_update_check(struct bpf_map *new_map,
> +				     struct bpf_map *old_map,
> +				     struct bpf_map *expected_old_map)
> +{
> +	struct bpf_struct_ops_map *st_map, *old_st_map;
> +
> +	if (!old_map)
> +		return -ENOLINK;
> +	if (expected_old_map && old_map !=3D expected_old_map)
> +		return -EPERM;
> +
> +	st_map =3D container_of(new_map, struct bpf_struct_ops_map, map);
> +	old_st_map =3D container_of(old_map, struct bpf_struct_ops_map, map);
> +	/* The new and old struct_ops must be the same type. */
> +	if (st_map->st_ops_desc !=3D old_st_map->st_ops_desc)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct =
bpf_map *new_map,
>  					  struct bpf_map *expected_old_map)
>  {
> @@ -1307,23 +1343,12 @@ static int bpf_struct_ops_map_link_update(struct =
bpf_link *link, struct bpf_map
>  		return -EOPNOTSUPP;
> =20
>  	mutex_lock(&update_mutex);
> -
>  	old_map =3D st_link->map;
> -	if (!old_map) {
> -		err =3D -ENOLINK;
> -		goto err_out;
> -	}
> -	if (expected_old_map && old_map !=3D expected_old_map) {
> -		err =3D -EPERM;
> +	err =3D bpf_struct_ops_link_update_check(new_map, old_map, expected_old=
_map);
> +	if (err)
>  		goto err_out;
> -	}
> =20
>  	old_st_map =3D container_of(old_map, struct bpf_struct_ops_map, map);
> -	/* The new and old struct_ops must be the same type. */
> -	if (st_map->st_ops_desc !=3D old_st_map->st_ops_desc) {
> -		err =3D -EINVAL;
> -		goto err_out;
> -	}
> =20
>  	err =3D st_map->st_ops_desc->st_ops->update(st_map->kvalue.data, old_st=
_map->kvalue.data, link);
>  	if (err)

