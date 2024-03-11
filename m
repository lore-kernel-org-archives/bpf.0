Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E705846F
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710145832; cv=none; b=omB4GguSm628zf3lYa7eLp546+bN2R9x+TqfjpCkir6cHEc0CneqBPM2OyKgZj1x/SXZ31M6Gf1OUdBqqJRQmzwh8zicxzmvAo7foZiWaOuVmYgTu/kUlHe4sLdmdXvz3KGekov2q9yaSDUpiFmOoAqh30zqh2Uwpg39iGEU6kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710145832; c=relaxed/simple;
	bh=MK0Oc6UFMTfMKyAhi8oJpCcC0Qdl9T4Dllb5f7JemEM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlAuib00bnLDwj5k8H/65ow6p4cN18q5gnimtrEMpiFxZQYyQl5/xcjDE00Mah8Bnn/P0pK4Iw1FblhJuBXrgGOx5cylj7XoqzgGQ/vYGIC93otmTMlImW7lnqKLk6mwW2udskpwHU6K6qpjtU4wOqqsHRjURd9xvzdPRpS2bAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoXa+Xmg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoXa+Xmg"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-413183f5e11so14184435e9.1
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 01:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710145829; x=1710750629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KNMuN+cY32vH0/AFuALdwd+uPngi8RxLbpPQiAydLd0=;
        b=GoXa+XmgsaPkdAEeZ4kY5Nocznms+eL3XFwQjJ/wA56ACuya5LW44vBEprnZkg3rxy
         fkqkMqGJ6mywOTc7rvucsYcjN427DH1Cy5gyCV+XHndIp6r149D47Px77PBGc3zwgt1z
         QDooOqs+FG3unjKadNRanTOtBc1bWsjUbnGvPADy8j2tYAlT+RBVXs37VLU3Bpiqna8i
         pXx62KaYu8m/otxDj5f0s4dTuwfPR623LdCmMHOgN3J2nB5Vi553CFls5n+PeIK8Jm6l
         elm2hs1yo9z+wXksXtu3oxwnD6oMQVFoiEZVzHif5LwtIVACFbPxVZLZahnOVropXnDI
         RvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710145829; x=1710750629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNMuN+cY32vH0/AFuALdwd+uPngi8RxLbpPQiAydLd0=;
        b=FpUPBeB1gl+5UARMiP9vhR5gCfuiW0zG1Lwt1KcQzbaneE9Eg/RNf2IPXSZVf7Mw4o
         GP48qz5tZjXoazMrlph3gXqG4++q4aadTKKYgn+1bJvOj5tic0pyLR3EQ5o1ay4Vjpf4
         pRE8dRkn2ctxl+JU0ny+zMnJv+nuVHYL2t57bIdTZlJ4AA+jr4KjksiJUuxg7qezy+P3
         9aBXmo4Iu1aE1v1gOcxUdV0C7G1hBuWOpN8sm2di4bdAcRZoLmG/ysC8jFJuOxQtU831
         14h5GYNeBYHI8tt79Kz3UqtfocSPzwF+QT+IzaXkaM9eQ1RoEiM39m0BQ2ScwoZE+CU7
         IsZw==
X-Gm-Message-State: AOJu0YxfqBeVE0gdkG9ZuZ+yV/ZqZtWMvxzjmSKt55+d/8JocMNt2dvI
	UMRK4rIpEPBq8xe8/35GDkWJ2KpNhmESvT4wwthVuv7nqz2Z9tvE
X-Google-Smtp-Source: AGHT+IEnml6KgOGUS4cigMAmnHRXmYpXtEUAhvLD3ETAIeX9mKmRTUkR/KmaDamUstGOyiF6ky4erw==
X-Received: by 2002:a05:600c:35ca:b0:413:1f7a:e6a2 with SMTP id r10-20020a05600c35ca00b004131f7ae6a2mr4575522wmq.13.1710145829475;
        Mon, 11 Mar 2024 01:30:29 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id hg6-20020a05600c538600b00412c8117a34sm8206744wmb.47.2024.03.11.01.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 01:30:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 11 Mar 2024 09:30:27 +0100
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [RFC PATCH bpf-next 1/5] bpf: Add link support for sk_msg prog
Message-ID: <Ze7BI241JAWya1eo@krava>
References: <20240305202155.3890667-1-yonghong.song@linux.dev>
 <20240305202201.3891042-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305202201.3891042-1-yonghong.song@linux.dev>

On Tue, Mar 05, 2024 at 12:22:00PM -0800, Yonghong Song wrote:

SNIP

> +
> +int bpf_skmsg_link_create(const union bpf_attr *attr, struct bpf_prog *prog)
> +{
> +	struct bpf_link_primer link_primer;
> +	struct bpf_skmsg_link *skmsg_link;
> +	enum bpf_attach_type attach_type;
> +	struct bpf_map *map;
> +	int ret;
> +
> +	if (attr->link_create.flags)
> +		return -EINVAL;
> +
> +	map = bpf_map_get_with_uref(attr->link_create.target_fd);
> +	if (IS_ERR(map))
> +		return PTR_ERR(map);
> +
> +	skmsg_link = kzalloc(sizeof(*skmsg_link), GFP_USER);
> +	if (!skmsg_link) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	attach_type = attr->link_create.attach_type;
> +	bpf_link_init(&skmsg_link->link, BPF_LINK_TYPE_SK_MSG, &bpf_skmsg_link_ops, prog);
> +	skmsg_link->map = map;
> +	skmsg_link->attach_type = attach_type;
> +
> +	ret = bpf_link_prime(&skmsg_link->link, &link_primer);
> +	if (ret) {
> +		kfree(skmsg_link);
> +		goto out;
> +	}
> +
> +	ret = sock_map_prog_update(map, prog, NULL, attach_type);
> +	if (ret) {
> +		bpf_link_cleanup(&link_primer);
> +		goto out;
> +	}
> +
> +	bpf_prog_inc(prog);

there's already prog ref taken in link_create, is this needed?
also I might be missing some skmsg logic, but I can't see thi
being released

jirka

> +
> +	return bpf_link_settle(&link_primer);
> +
> +out:
> +	bpf_map_put_with_uref(map);
> +	return ret;
> +}
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 27d733c0f65e..63372bc368f1 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -24,8 +24,6 @@ struct bpf_stab {
>  #define SOCK_CREATE_FLAG_MASK				\
>  	(BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY)
>  
> -static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
> -				struct bpf_prog *old, u32 which);
>  static struct sk_psock_progs *sock_map_progs(struct bpf_map *map);
>  
>  static struct bpf_map *sock_map_alloc(union bpf_attr *attr)
> @@ -1488,8 +1486,8 @@ static int sock_map_prog_lookup(struct bpf_map *map, struct bpf_prog ***pprog,
>  	return 0;
>  }
>  
> -static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
> -				struct bpf_prog *old, u32 which)
> +int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
> +			 struct bpf_prog *old, u32 which)
>  {
>  	struct bpf_prog **pprog;
>  	int ret;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index a241f407c234..c7d2a5fcf37a 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1129,6 +1129,7 @@ enum bpf_link_type {
>  	BPF_LINK_TYPE_TCX = 11,
>  	BPF_LINK_TYPE_UPROBE_MULTI = 12,
>  	BPF_LINK_TYPE_NETKIT = 13,
> +	BPF_LINK_TYPE_SK_MSG = 14,
>  	__MAX_BPF_LINK_TYPE,
>  };
>  
> @@ -6699,6 +6700,10 @@ struct bpf_link_info {
>  			__u32 ifindex;
>  			__u32 attach_type;
>  		} netkit;
> +		struct {
> +			__u32 map_id;
> +			__u32 attach_type;
> +		} skmsg;
>  	};
>  } __attribute__((aligned(8)));
>  
> -- 
> 2.43.0
> 
> 
