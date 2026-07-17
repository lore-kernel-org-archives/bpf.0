Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0193A7F73
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 21:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784325170; cv=none; b=YFim9xju2EYdR6oOXViGX0+JE+9kDXllTYBh1SLcFyal7HLRbVWbbjBnl1ACV0Sp/L5MJ+FfBLfWP5Zj8jpl6jpqRPEZoUCbMjAN0kswAjnSYUVJj78p1p11+CCyx3fgCY3HC6xG29V98nibe7NXgBqL/oQeyJAgB2vReJj3/io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784325170; c=relaxed/simple;
	bh=zc7D/9EwQRgTjJcnICDGen34BP8M4e+uP9KTBbq2Gmg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=gl2YOo89mIvhY4vGQT7MozldJIYSEHQk6/rHVWWrRcYhGicSgrnSPnXxWTQMfDYoh7sBpWjhK13ZgDBbrUWVj//uDX4ull2lFx+HHKjcSJotuHNcQYxDwbseJEauWSo/m5CUejCoBPcywPFbky8f4nIWV5Wyv6ER7QcqbfwCUxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=WFJfe5tv; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="WFJfe5tv"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38df94d4dd8so3565618a91.2
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 14:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784325158; x=1784929958; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZRpkQ2cyJn8DEz8vKvVjafNoUUwgLSz9vl4mrpr70F0=;
        b=WFJfe5tv5GXpTFQB+Nl+/juMQ9Rm6EB/gSsoE0uimt30/V+dV5cWOcr0Rl4EjvnNgl
         8KS1Y1DvFb9Jh6GV0Tu2wQdI/U/TI4EdAqRmX7HorCoout3o70Vfl1uT08Mw7fnCn+rb
         aF5FGJF/TpYSSuoON8bpvH475u/ozdQrCByJ3WHy8kCwCcuHv767jbaPxwN1rZU+/syH
         JdUoMOUKXR7G+e38oMZ+nSNom22ayZMbOUm4rEYvXWP0oWQT7R1dwHnw6B2AHhX4/JSd
         i4cgIuCfeMp+RsX3XpegPdEIJfEGfXIk6GCwEn4csBPOZUCdjMgK3Brz+0x02SwITUw4
         M33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784325158; x=1784929958;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZRpkQ2cyJn8DEz8vKvVjafNoUUwgLSz9vl4mrpr70F0=;
        b=LJjTv43yhVjT+0rhyCSMFJF2GpDKjJNbuNFQ1iKDy2uwb6R0zR9IizhVo8tYmykd1R
         lTbGcmExbUD1u6yWRqLfzkDiRZXZnKw95qS8k3lE6JIWX8MgKe0lbgHzTuVXYUd1RAHG
         IH7c744I7cfHtLWLyc1OrLvb10uXnzgkZXmTm4IncOUeyo7I5Aza5WhyKMBFKuohv30f
         HKMPD9vcMwBjmXCUy+9T6NkHiEVUNhhXUqtWqpJQV/k93o4zoTsDTx8ZmP+TzW0lq4u6
         uClQ3z+tkAaaKxER1unb/vDy2HV2leaIYznHaQCyzWIOF3XC7917f6Gpm4QnNWBdG6oG
         wCuA==
X-Forwarded-Encrypted: i=1; AHgh+Rrnwzir4vPmoObBncnw6rJThX29dRMrYmLQB3XYUKL2V9jyYEvV+o7SvzG8gtRCQFakspo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd0m1QMM/iDxwOx42BJ80P0567EDG+w2zgr6wtmkUnG72MrJh9
	xlwOsIA+wrv1XN4Yesv9Om+Zl8o7ZgOE50LwZniKX+nAb6WM9NjniqsQk9OZccEb5jU=
X-Gm-Gg: AfdE7clyRAIJEbZeeEOK/pcIuySx5ayzjhqe6HTX5OTZOw4LD59fu2ksOz+LuhYDlVY
	oxbY6k7Cncp1LuPvqnohjNFZWJzUngJwcLQK5qd7Cs2QmZ8xEVBlPXtEtKbGPtb4GhlBBTANunI
	I5Hu3R1tmRVy4J4Opy+p7Ec5d+bW11XsgXK2fzL1o5RCoeyZ2wIjOuPcDw3qyLrrqbusYP0KMFt
	RqWyTEH4SeZWRk0s5CJ77aL8eQuu1Im9bJZJOooWZ7u98jSAYFR8Lu+xkPQFpffp3WlvKVCIeQF
	XyTgvoI8iuuzbGxJC9+ZBBR5xiWZXdWnlCfPuDtSy0EHcb0SkDGA8Hia0DXtczYLSYAbdECOBDD
	uRHmzDr0NGvT4Am3LBqtBIoqLNnc+jhs1n75lHE6rrYfF8sOTwe8DeGY3DPldM1wx8Unt20Uqr9
	5pmQ==
X-Received: by 2002:a17:90a:e7c1:b0:37f:9ce1:735f with SMTP id 98e67ed59e1d1-38e4b537cf4mr3919621a91.32.1784325157799;
        Fri, 17 Jul 2026 14:52:37 -0700 (PDT)
Received: from localhost ([163.114.132.129])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bb8a4sm11278963eec.14.2026.07.17.14.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 14:52:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 17:52:34 -0400
Message-Id: <DK16H7ZKMSYD.2K0J4O6YBMWF1@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Quentin Monnet"
 <qmo@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v10 3/9] libbpf: Probe percpu data feature
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260715153254.92010-1-leon.hwang@linux.dev>
 <20260715153254.92010-4-leon.hwang@linux.dev>
In-Reply-To: <20260715153254.92010-4-leon.hwang@linux.dev>

On Wed Jul 15, 2026 at 11:32 AM EDT, Leon Hwang wrote:
> libbpf needs a reliable way to distinguish kernels that can support
> global percpu data from those that cannot.
>
> Add a dedicated feature probe, so libbpf can make capability decisions
> early and fail predictably when global percpu data is unavailable.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/lib/bpf/features.c        | 35 +++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf_internal.h |  2 ++
>  2 files changed, 37 insertions(+)
>
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b7e388f99d0b..ef9581c11303 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -620,6 +620,38 @@ static int probe_bpf_syscall_common_attrs(int token_=
fd)
>  	return probe_sys_bpf_ext();
>  }
> =20
> +static int probe_kern_percpu_data(int token_fd)
> +{
> +	struct bpf_insn insns[] =3D {
> +		BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0),
> +		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
> +		.token_fd =3D token_fd,
> +		.map_flags =3D token_fd ? BPF_F_TOKEN_FD : 0,
> +	);
> +	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts,
> +		.token_fd =3D token_fd,
> +		.prog_flags =3D token_fd ? BPF_F_TOKEN_FD : 0,
> +	);
> +	int ret, map, insn_cnt =3D ARRAY_SIZE(insns);
> +
> +	map =3D bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, "libbpf_percpu", size=
of(int), 8, 1,
> +			     &map_opts);
> +	if (map < 0) {
> +		pr_warn("Error in %s(): %s. Couldn't create simple percpu_array map.\n=
",
> +			__func__, errstr(map));
> +		return map;
> +	}
> +
> +	insns[0].imm =3D map;
> +
> +	ret =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, =
insn_cnt, &prog_opts);
> +	close(map);
> +	return probe_fd(ret);
> +}
> +
>  typedef int (*feature_probe_fn)(int /* token_fd */);
> =20
>  static struct kern_feature_cache feature_cache;
> @@ -707,6 +739,9 @@ static struct kern_feature_desc {
>  	[FEAT_BPF_SYSCALL_COMMON_ATTRS] =3D {
>  		"BPF syscall common attributes support", probe_bpf_syscall_common_attr=
s,
>  	},
> +	[FEAT_PERCPU_DATA] =3D {
> +		"kernel supports percpu data", probe_kern_percpu_data,
> +	},
>  };
> =20
>  bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_=
id feat_id)
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index d5b7db703b3f..b786f1a35567 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -401,6 +401,8 @@ enum kern_feature_id {
>  	FEAT_BTF_LAYOUT,
>  	/* Kernel supports BPF syscall common attributes */
>  	FEAT_BPF_SYSCALL_COMMON_ATTRS,
> +	/* Kernel supports percpu data */
> +	FEAT_PERCPU_DATA,
>  	__FEAT_CNT,
>  };
> =20

