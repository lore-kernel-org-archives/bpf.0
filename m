Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4B636A37F
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979862; cv=none; b=nDi9RprDY9SyHACKcdAKkEv1SSFORHasxMzRhRCpp9l3hnOvoH8W6tosYDI3B1Dz2oTmwZSyqTU92icxiIBWjLDVq4T0C/4L5HZq08hc5L1fBU+buLpW5+mi82CjS4moiN32G+HK3TOQbDhedw3PJUZRxI/bqRbqScfKbayhYGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979862; c=relaxed/simple;
	bh=l2HeouvYQiBlOik9N5RDS+J9OXY/j0FBrbam0gPdL6s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=IDYbEJbgyuNrvsFh7WHM6zXKupn6OBWKOrg2AqOKe5VlnjvXS8TIHqkxNc4RSR+KTOgWHK4E1CDxCBbidbhTqZ6r9DiGh8xOstloQnF/FAGWttVAKudeLkWM60LYZGfl0ClKarLPdLF2KU1joWH0W6VaxU14BV3sXFO514Kt5kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=E84QfuNT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="E84QfuNT"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cae1a3a744so25159055ad.3
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 14:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783979860; x=1784584660; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=At8KsE6lJsmXZegcPrwsTNDpPIz3pgQ9ysWfzm54lJA=;
        b=E84QfuNTkz6WdVH1avsdSoTlQ9lmJWGb0uu7prs72OZs3M7CnlA1ZD6mkuh6R3YKeE
         TLSNe7Ky9y6vRiBs3sDjTM4c6iv7kEI1brlHmE69ohfGCv/hod7QUEwXQOIYIorrO4tI
         Jmv8VhdNnc/wTYOoWXfUa567CMNerMw84kq6BJRatrhJVC3KplWSYCTz8Sfkl5zW1bWG
         v87gfLmavbi0HOp99tDxSlUKXlN0wd2vE5dmuehLeHbf3nerwVGzOaqP7yfZZU7WPkT2
         41vz33kzG5vWfWIJrs+wqlQ6ikS8d7VCNQBHlY33f8dKEdgrbSnGOPa0zTW/2pIpwfGb
         ex3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783979860; x=1784584660;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=At8KsE6lJsmXZegcPrwsTNDpPIz3pgQ9ysWfzm54lJA=;
        b=s61lBi6SrGf4QmeHPLO0I0YOK4cn/+OSP9xFDYH8NlgMEsWoHsPfVggVwIKxXPvH48
         xeEWdSvYJV9B/3M32/vhi2UTLC+wAKsPiNOnnZkD9hXiyOKVJgebFVi1QjwlTJ88ovzx
         xCX4ZgM1Vvy4X0jR55SzlfLx5l07KlnURz2AsFaGFtLyTpW+wVzp8nUHRA6Sdhfkf7vG
         KL5EXPpp9EmzCKQa19aClU/nZgavjpk6aO+MCGyrV/WXtGESR4UBSmIYZ/p4gdGJvR/t
         dJ6fGLJPtmbk4705vTANu/QiWHgYaMiccel38WTUZnQxWyiTHiq4zRBatwQ8rrRdWKTk
         bH4Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq78R1+deSOtw686LHxq0jAIXn/nt/NG5X+o31sUlAbuscfzDgCGARmjKwPdE7G/a3Ml5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAlzgGqc1ERX7VOX1v0lcQMkot/OUnAnTKIwlaVTz7trsfHMcm
	zrFU7FEeyE1gc4YA27o1n4w1w3odjpadfldCPKojpdwrQ6CHL4KladZwuNJmSlLeu0Q=
X-Gm-Gg: AfdE7cnqU8o8eWxbPgHganAxlHlJMp3ZRqmcsd6tRAwjRhAGKhPKFjf0Xea+dYFPsGh
	HhwX7tVmfciZui7O7Kub7ZJBxfJl83H415ZJgHJWiktr4PfqogXXxzCumPomVwd0zsG2JJBOYpL
	udmEcVkwtxJl4Lv2tMGlXr31DrBrsd8ir1IprmEp7opuOBYiLGndrgox0Zh2If1k2dz/CtwY/Q1
	2tVeXOLvOCqPRB0qDkU4pet4Kp53EH1bw9fIkm8S6F5hQFEKvq98BkmcThrgnPmpy02lj116DVi
	a42x78c4BaITGlt/5nuG1x5J+46cL5pudYjqfEjvzL9usxkiak3IbqXE+K1lUFheaKz2G/DaY9a
	NYx6ONrco8BWHH+4WrudtNeybTPQziaO2pY9/Tmwiv4dPObazPyDHCnSW7L/vHDC43W4HDhH5KO
	PW9PHn/QvF/KynRHfgqeCU6Cn3w80Jx+k/MtBWFlxFkw==
X-Received: by 2002:a17:903:3205:b0:2c7:f4bd:91b5 with SMTP id d9443c01a7336-2cee98446f9mr9888315ad.0.1783979859553;
        Mon, 13 Jul 2026 14:57:39 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d57bsm104668175ad.59.2026.07.13.14.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 14:57:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 17:57:38 -0400
Message-Id: <DJXS2WYYPTBK.F3KORRKBRAGY@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 07/15] bpf: Move LSM trampoline unlink into
 bpf_cgroup_link_auto_detach()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
Cc: <netdev@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <shakeel.butt@linux.dev>,
 <roman.gushchin@linux.dev>, <kuniyu@google.com>,
 <kerneljasonxing@gmail.com>, <kernel-team@meta.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-8-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-8-ameryhung@gmail.com>

On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> Move the LSM trampoline unlink into bpf_cgroup_link_auto_detach().
> The purpose is to consolidate the auto_detach cleanup logic.
>
> It prepares for the upcoming struct_ops cgroup attachment patch where
> bpf_cgroup_link_auto_detach() will need to handle the struct_ops case
> (link->map !=3D NULL).
>
> This is a no-op change.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/cgroup.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index b43f0bff184c..7abbe12e108f 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -313,6 +313,8 @@ static void bpf_cgroup_storages_link(struct bpf_cgrou=
p_storage *storages[],
>   */
>  static void bpf_cgroup_link_auto_detach(struct bpf_cgroup_link *link)
>  {
> +	if (link->link.prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
> +		bpf_trampoline_unlink_cgroup_shim(link->link.prog);
>  	cgroup_put(link->cgroup);
>  	link->cgroup =3D NULL;
>  }
> @@ -346,11 +348,8 @@ static void cgroup_bpf_release(struct work_struct *w=
ork)
>  					bpf_trampoline_unlink_cgroup_shim(pl->prog);
>  				bpf_prog_put(pl->prog);
>  			}
> -			if (pl->link) {
> -				if (pl->link->link.prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
> -					bpf_trampoline_unlink_cgroup_shim(pl->link->link.prog);
> +			if (pl->link)
>  				bpf_cgroup_link_auto_detach(pl->link);
> -			}
>  			kfree(pl);
>  			static_branch_dec(&cgroup_bpf_enabled_key[atype]);
>  		}

