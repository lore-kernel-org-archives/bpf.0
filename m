Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BFF33374F
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 22:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860304; cv=none; b=tVjF66DoHQPuvSJJEvzsPJZEglpDhD5ND0kEV0IsOuEpaCPRG9CU26UFG9dhu8O9xZ0mYlg6utid+WT0ub77+cTevUjm93OWtWXDxuFOhtc7u5aAKi70GZ8Y4RHkQs3Z+vOViy9lBrsq70uGrj5kld2OFBm/XeIKdrWUw6n4w0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860304; c=relaxed/simple;
	bh=ryxG+1Xyfb3c7FwPeyaBFEknRzdAu2YEC+j8PXubVC4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=G8bU2IVIMmvHZEQi2ZEg1BTOPd+tIyBL3yUS4Eyx3bDyPKq0tJqI37L62mIxjvNQI9Z2GUVc5RI7vlGrik2BoJS6QIZDhlE8o3PZYDAGKeRH/pId95aee0WNLPeLr9g5+t6912VTnLKZxwOav2VdQR1hDFIqJ+VHld6huMtoOo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=UVq8C4M6; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="UVq8C4M6"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ce102afb0aso3381403eec.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 15:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775860302; x=1776465102; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6asrKm0ObX7WZkIg3C8SzyDsrjXyuaBzOBbV2qqtik=;
        b=UVq8C4M6a0ag2ooiTnT6HDelrSdhuhoEkpjPYF13w3P8NGK4o/cN7n4ZXBCuHl36aJ
         FSwNPw4Gqe6mhSVJfWcil007Yu2DCLgYnu8QE/FqrMqem49xR3OYcQZ7lcGOWzw7US6Z
         8bKFJwVXicqTaR5w1VMrvYPYePE4RBVkLIjSG5+0TT1ghVhF1DojdvVPj6sbCGB0bXXD
         hOnbAB9Cw9mViXpqC0Z1cj235nfwQuzro0jecofcKb1NLZfdpkE7gdrxnbx5Y0j9yBKy
         Z7zjIVHVAMNxrNPmCHhHxz9zUKpT1HrX4reWfPZv485jmoZ7EozZMNyRMPHa5HunPqMg
         EQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775860302; x=1776465102;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A6asrKm0ObX7WZkIg3C8SzyDsrjXyuaBzOBbV2qqtik=;
        b=TunBNVd3xayRApkBmoG50GbEjLs57OzbVgIPDlN6t65fO8sHKA1EbtUlciS73/pQWD
         oGGtb6qzDWHfRmRN1mjmZhrkt0OTJr1Kgz/ByjTolFOb/tIxwx7900WN/h7VwRKgETVZ
         rljqYt6IULnYALcHMa/za0VnssvJFM9ln+d0DDR7reiQp5Blmk1NexehSSxfFrjjJ6fe
         Lam0u27kjTg885WUsWRmBUkeQJ2dkSviiN0K0fQRX3xg2kEi7Y74HcIJd1ggkA/e4K/X
         sNGTN1Nfas1KHiWOBxavz3fkNNSt2Taou3hxowxQxDhpbRhHeu7FcLdJvbebP7F60H5O
         W6wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeSnB1kAvMWWdPv7DMCS8N3x21hbBoopr10KhCLFyglTY0GOVaBJlr4dhFrMZcOKIAJuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqPCa3i490MmeZu+6XwAa+yKsFWFS/ro2jYHVvJd2Bj9WKvFmK
	4+0tyn7sjmNe6Uj32XXFNgTxdbyYGUX236x8hS4lJ3/i5PQX9XKnuH7VOmgGFVFpppY=
X-Gm-Gg: AeBDiev+b6pq4mPRuSUyqOH7shKwCrPupC/o87rTAv5R1MAque+mbxtUk5HnSMRJxd3
	2ZJ0KVmtH1QSym2oKElHabykUCPCPv9wDmHYwHjhMxbS7g9M7t56FT4P0ncBrRCQ2Ay7KQvR2c1
	/x7bKOkIwIZeueUMCy2zBJpvrlqZLTc6UU4jtHeLLXXTYy9RBhxBr7X/qExxqolB6ErDkQcrtRq
	K1KRPl6pxJkFFf/tdaHJLvzcTYAoUIso+1kZdJpvOdT83Sm8wzYvL/8+Dpa2wDIq+N7dsV1hMnt
	LSy7xs38HRvmuCEF7b+xYypmi35ZgLU96xYQmSwM2hnLXt7uy+zv8ECepWDPYBcrKM2K0nqYgt1
	cs8At5jgA5wnj+Z0UMBt8eZ4T40TT91vZhQhNI9jWjked1+p4jHHyAkON+Dn5MCGmwm6i88NEr0
	0DdeXx
X-Received: by 2002:a05:7300:fb88:b0:2ca:9b08:e7d2 with SMTP id 5a478bee46e88-2d58945e0b8mr2780994eec.22.1775860301713;
        Fri, 10 Apr 2026 15:31:41 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::4492])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5632a2a06sm6111325eec.30.2026.04.10.15.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 15:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Apr 2026 18:31:39 -0400
Message-Id: <DHPTXQZL4ERG.3QCBWTRWKFNN@etsalapatis.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH RFC bpf-next v2 01/18] bpf: Register rhash map
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kafai@meta.com>, <kernel-team@meta.com>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <20260408-rhash-v2-1-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-1-3b3675da1f6e@meta.com>

On Wed Apr 8, 2026 at 11:10 AM EDT, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add resizable hash map into enums where it is needed.
>

These changes in isolation are difficult to reason about,
can we roll this into subsequent patches? Right now this
adds a the BPF_MAP_TYPE_RHASH without there being a way
to create one.

> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/uapi/linux/bpf.h       | 1 +
>  kernel/bpf/map_iter.c          | 3 ++-
>  kernel/bpf/syscall.c           | 3 +++
>  kernel/bpf/verifier.c          | 1 +
>  tools/include/uapi/linux/bpf.h | 1 +
>  5 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 552bc5d9afbd..822582c04f22 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1046,6 +1046,7 @@ enum bpf_map_type {
>  	BPF_MAP_TYPE_CGRP_STORAGE,
>  	BPF_MAP_TYPE_ARENA,
>  	BPF_MAP_TYPE_INSN_ARRAY,
> +	BPF_MAP_TYPE_RHASH,
>  	__MAX_BPF_MAP_TYPE
>  };
> =20
> diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
> index 261a03ea73d3..4a2aafbe28b4 100644
> --- a/kernel/bpf/map_iter.c
> +++ b/kernel/bpf/map_iter.c
> @@ -119,7 +119,8 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
>  		is_percpu =3D true;
>  	else if (map->map_type !=3D BPF_MAP_TYPE_HASH &&
>  		 map->map_type !=3D BPF_MAP_TYPE_LRU_HASH &&
> -		 map->map_type !=3D BPF_MAP_TYPE_ARRAY)
> +		 map->map_type !=3D BPF_MAP_TYPE_ARRAY &&
> +		 map->map_type !=3D BPF_MAP_TYPE_RHASH)
>  		goto put_map;
> =20
>  	key_acc_size =3D prog->aux->max_rdonly_access;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 51ade3cde8bb..0a5ec417638d 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1287,6 +1287,7 @@ static int map_check_btf(struct bpf_map *map, struc=
t bpf_token *token,
>  			case BPF_SPIN_LOCK:
>  			case BPF_RES_SPIN_LOCK:
>  				if (map->map_type !=3D BPF_MAP_TYPE_HASH &&
> +				    map->map_type !=3D BPF_MAP_TYPE_RHASH &&
>  				    map->map_type !=3D BPF_MAP_TYPE_ARRAY &&
>  				    map->map_type !=3D BPF_MAP_TYPE_CGROUP_STORAGE &&
>  				    map->map_type !=3D BPF_MAP_TYPE_SK_STORAGE &&
> @@ -1464,6 +1465,7 @@ static int map_create(union bpf_attr *attr, bpfptr_=
t uattr)
>  	case BPF_MAP_TYPE_CGROUP_ARRAY:
>  	case BPF_MAP_TYPE_ARRAY_OF_MAPS:
>  	case BPF_MAP_TYPE_HASH:
> +	case BPF_MAP_TYPE_RHASH:
>  	case BPF_MAP_TYPE_PERCPU_HASH:
>  	case BPF_MAP_TYPE_HASH_OF_MAPS:
>  	case BPF_MAP_TYPE_RINGBUF:
> @@ -2199,6 +2201,7 @@ static int map_lookup_and_delete_elem(union bpf_att=
r *attr)
>  		   map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
>  		   map->map_type =3D=3D BPF_MAP_TYPE_LRU_HASH ||
>  		   map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH ||
> +		   map->map_type =3D=3D BPF_MAP_TYPE_RHASH ||
>  		   map->map_type =3D=3D BPF_MAP_TYPE_STACK_TRACE) {
>  		if (!bpf_map_is_offloaded(map)) {
>  			bpf_disable_instrumentation();
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8c1cf2eb6cbb..53523ab953c2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21816,6 +21816,7 @@ static int check_map_prog_compatibility(struct bp=
f_verifier_env *env,
>  	if (prog->sleepable)
>  		switch (map->map_type) {
>  		case BPF_MAP_TYPE_HASH:
> +		case BPF_MAP_TYPE_RHASH:
>  		case BPF_MAP_TYPE_LRU_HASH:
>  		case BPF_MAP_TYPE_ARRAY:
>  		case BPF_MAP_TYPE_PERCPU_HASH:
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 677be9a47347..9d7df174770a 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1046,6 +1046,7 @@ enum bpf_map_type {
>  	BPF_MAP_TYPE_CGRP_STORAGE,
>  	BPF_MAP_TYPE_ARENA,
>  	BPF_MAP_TYPE_INSN_ARRAY,
> +	BPF_MAP_TYPE_RHASH,
>  	__MAX_BPF_MAP_TYPE
>  };
> =20

