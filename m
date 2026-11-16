Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827271;
	b=msH9iBQ+izEW4uE8zSwKjNmoHEGE4NM0QVCIel0iWEInHtEv79T5XANhQe+FPg+FV+cn
	 cfPaX0lmFCFYQ7OT37bCgUF6gGuYHQerbDwEhTSL6Ukq6IM92WORhCQ9YcvBmMC04F/Du
	 pQjIntERAUMZdFg3wGLmlTkqeJGMyIULtWfrr/T5Wwh++nr/Qz4yMxUP2knnTT1ztWmfb
	 qMKj8K75NAMVGRdfOtn07oXGZcibq2+K2PPiBq32Sf7Mk2fXb4iJQqcQK4C7cSfJ9jwyT
	 bKJOVHdnrrgMKI/2df4DFcncs0ItBl9S1iNPMCkir9qRbfq8RYDLqU4vpw1CND0gKDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=8X/VWMuk4kYzcSXRZvBmCXdDBR924lepSLdcXRzaC7s=;
	b=aU9yjsyTw6nXU4jaY+kdH/qfIskSJbQKflJp8yABkTbd4AP5m//XLak35cZMTA2BqeUv
	 ShniwC6F8bBRtp/41weq4daTP55v37Rt5I+7StZGVPair1c1vn8DohL6N+BU6wqgp5TF6
	 QbfdCx9fU74vSk6GlY9RU77u2kXgx+y3y9N9+QmeUtDjNxdlaX89Cz+0JqpDHibxf+nFv
	 r4xjB2OWy+XK2HYFsiRej91WKRPJB+z5vAzxnFcv3jG5R06UhsIGUWojMo9Ck11byV2wj
	 4cdQCmGqr09rRbtXg+IC8YdKTRWw6TQNl+04EaOySqVDZHr5YNoP5egDYmKukmTKXEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bobrowski.net;
	spf=pass smtp.mailfrom=bobrowski.net;
	dkim=pass header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=n4htZ6k+;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBE3606F34D
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 11:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEBE3606F34D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=n4htZ6k+
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ea7987517aso23508905ad.0
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 03:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1794827270; x=1795432070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8X/VWMuk4kYzcSXRZvBmCXdDBR924lepSLdcXRzaC7s=;
        b=n4htZ6k+rXJjqOGHlTptUNPZZfhDILvPIkp8XPYQG93vq3RAHuWPgJJn/uh9dTFAKR
         yKgw265OmWLMx8yzQX/vtUAAujLx3554sGpsRLmjgUzCihnDAX3geHh8iorI9AeTqM4Z
         zFJuOb9l8M5tky5GKGORbBi1yV2CcFo7simUIX+ipyYuO3Y6O9W6Dc8/S6kmtlI3Dz9f
         w2Lz1spo1xcT5876mDB5GZoKoHqtoQ2SdEoba1+dKpLz0VCZgg1Rxm9MKAZXEJ0rp8Pp
         DVZ2DMvSihzUSjBu1hY9mAeQANNGw9Z/Wv5N8+YzIwZgBXkRrnwntzLVts7x8BNVSkj5
         xZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794827270; x=1795432070;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8X/VWMuk4kYzcSXRZvBmCXdDBR924lepSLdcXRzaC7s=;
        b=ZBxaABPQgSJionbLm2YbBFSwBqtb3a3oA8yOBrAEmSQn0JqKs+4JCjRrbEFunDjVuV
         AtgDe5NPoKvLRYCQeiahpsQ3BnSsYgDyVFKhoe6gYiujoTmWZgtv0b6t8OaOSSaYURBY
         u65oknU6fks1qPeFq4DoDJo6xuo8azZpSIMx5hiJ0Ieh+ud4fFL9KJzpRlznAXJv2ykA
         IqTTCZlwHxoCFvYOLiFIM04C6+u+/cMYAU1A4bu1eEtTSejGFhINldsHo7Fw0Pt/FYWb
         f1LopfUfH3YGchcne3TG2sx7fGaPAoI4ZdCJm6cxuCiEoeN6surxbHUuWMsaGzKFY87m
         q18A==
X-Gm-Message-State: APuU4Z8GFf+Qq8ekH9cdexeagN0cJfjqU5UVq61O8eR39fnsDMlxQ974
	YnUlT3JDxVfhQcGMMKucFbZC7oTpbaaZfxaik3Ja1sraaTEZIQw0zPJudI+IwKX3n6bK
X-Gm-Gg: AZFdTZe08ZT89vwDSb11I76PCdwyhdWDoJkEkcZqH4vjulWvi9OCblAblE0pqEvCywf
	/ZdbcNE5p9r5N0+JYcYFc0sBjHD1NIwtQ7qv61g/QhNwKufgQN+ZCxcUTckEQIsmM50rjs6+ZvQ
	W8EyQ20sHL9cnIoFoo5TH9JIcZXcbVOzKf3SGUjR6sh8H0rrqZE1e5XMLB6pay/CDEqWiqaksar
	50LutTyUpZXT4dpNuE5DseKt5o4nEyASi1vDCnU3G0ETM0nTjp+PfPC2732uJRGBlcR+TmnzeOk
	ReuefotnuMy9nbchZ4hj1+D8Ez2EIahJnksrjtZE3TZtdcEF6CtqaN6UI7MkzP6a6q9R97vBIo4
	fUY/SBQ1WUjZZaeYnBSGq02i5f22bB97fGITCM2rIrkXT/vpdZhPH4hP5nonPodT5nix2u3HHLS
	Sw7ukOXPtLqxWVbXdwj/xJmZFfA3potDvFVQ3jcSTNkQbWh352EW5LnqHp/ohwWtCQmmpise28x
	XApv5XKHv2VvhlsYVzBm8GGHtjhuW0ZfrhBMXxO3gfifTh21/qV4w0FovlXPdY740ZuBIOv4+4N
	ag1zA0zv26Fx15Kmv3NpnLbSlVdfytq9z5Eb7N+RBesMYAS0xsIXlx5rvTwIrVNmej8Ur/W+iUZ
	oW53Sza8=
X-Received: by 2002:a17:903:3843:b0:2d9:4358:73ab with SMTP id d9443c01a7336-2ee0daa351bmr102383795ad.19.1794827269844;
        Mon, 16 Nov 2026 03:07:49 -0800 (PST)
Received: from lima-development (163-53-146-70.ip4.superloop.au. [163.53.146.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f8d9966sm36823895ad.61.2026.11.16.03.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 03:07:49 -0800 (PST)
Date: Mon, 16 Nov 2026 22:07:40 +1100
From: Matt Bobrowski <matt@bobrowski.net>
To: Sergei Nizovtsev <snizovtsev@cloudlinux.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	stable@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Serge Hallyn <serge@hallyn.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf, lsm: Mark backing_file_alloc/free LSM hooks as
 untrusted
Message-ID: <avrj_GrUbKNjDXz6@lima-development>
References: <20261111203614.1221188-1-snizovtsev@cloudlinux.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111203614.1221188-1-snizovtsev@cloudlinux.com>

On Wed, Nov 11, 2026 at 09:35:52PM +0100, Sergei Nizovtsev wrote:
> The backing_file_alloc and backing_file_free LSM hooks get the backing
> file as "struct file *backing_file", but its f_path is not populated
> while they run:
> 
>  - security_backing_file_alloc() is called from init_backing_file() in
>    alloc_empty_backing_file(), before vfs_open() sets f_path, so
>    backing_file->f_path.dentry is NULL;
>  - security_backing_file_free() can run for a backing file whose open
>    failed and whose f_path was already cleared.
> 
> Neither hook is listed in untrusted_lsm_hooks, so bpf_lsm_is_trusted()
> lets BPF LSM programs use the argument as a trusted pointer.  A program
> attached to lsm/backing_file_alloc can pass &backing_file->f_path to the
> trusted-args kfunc bpf_path_d_path(), and d_path() dereferences the NULL
> dentry on the first open of a file on overlayfs:
> 
>   extern int bpf_path_d_path(const struct path *path, char *buf,
>                              size_t sz) __ksym;
>   char buf[256];
> 
>   SEC("lsm/backing_file_alloc")
>   int BPF_PROG(poc, struct file *backing_file,
>                const struct file *user_file)
>   {
>           bpf_path_d_path(&backing_file->f_path, buf, sizeof(buf));
>           return 0;
>   }
> 
>   # bpftool prog load poc.bpf.o /sys/fs/bpf/poc autoattach
>   # cat <any file on an overlayfs mount>
> 
>   Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] SMP KASAN NOPTI
>   KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
>   RIP: 0010:d_path+0xb4/0x810
>   Call Trace:
>    bpf_path_d_path+0x26/0x70
>    bpf_prog_f8f2e241d4ff7217_poc+0x33/0x37
>    bpf_trampoline_6442521065+0x61/0xf9
>    security_backing_file_alloc+0x78/0xe0
>    alloc_empty_backing_file+0xf0/0x170
>    backing_file_open+0xfd/0x290
>    ovl_open_realfile+0x1ed/0x270
>    ovl_open+0x1a9/0x2f0
>    do_dentry_open+0x404/0x1280
>    vfs_open_consume+0xba/0x4b0
>    path_openat+0xc4f/0x1f60
> 
> Add both hooks to untrusted_lsm_hooks, next to file_alloc_security and
> file_free_security, which are listed there for the same reason.  The
> program above is then rejected at load time with "R1 must be referenced
> or trusted".

I literally had a patch queued up and was just about to send it out for
review. Thank you for this.

> Fixes: 6af36aeb147a ("lsm: add backing_file LSM hooks")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5-2
> Signed-off-by: Sergei Nizovtsev <snizovtsev@cloudlinux.com>
> ---
> Tested on bpf.git master (475a0cfd02f1) under virtme-ng with KASAN: the
> reproducer oopses without the patch and fails to load with it. Only the
> backing_file_alloc case was reproduced; backing_file_free is from code
> reading.
> 
>  kernel/bpf/bpf_lsm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index f58dce888ff4a..f39a3766f2245 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -411,6 +411,8 @@ BTF_ID(func, bpf_lsm_bpf_map_free)
>  BTF_ID(func, bpf_lsm_bpf_prog_free)
>  BTF_ID(func, bpf_lsm_file_alloc_security)
>  BTF_ID(func, bpf_lsm_file_free_security)
> +BTF_ID(func, bpf_lsm_backing_file_alloc)
> +BTF_ID(func, bpf_lsm_backing_file_free)
>  #ifdef CONFIG_SECURITY_NETWORK
>  BTF_ID(func, bpf_lsm_sk_alloc_security)
>  BTF_ID(func, bpf_lsm_sk_free_security)
> -- 
> 2.56.0
> 
