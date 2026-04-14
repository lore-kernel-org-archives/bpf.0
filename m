Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B872DEA6E
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188783; cv=none; b=Au6pIINJFelbl/wCMyBHxBbYVRVqIIVbu4yWC1Hr4QhwneT/cGXr3/Z81ZIAJ9q9O7/ghqFfEeomKSTyPqXQHgqpQ6loZHNa4nJUVaOQyT+zNjym7I6XqCgmTEi8Sfsl7p+8wziPY6OlyiTY+yZO1dm00tXFoFIkfpDTG/ovNeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188783; c=relaxed/simple;
	bh=uNmh5GwRUS7H5s5/4a0S42VIQz+76GdCAMVMpc0ashU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ePr/SKG/kEDKfwT9NxbwS+vsg/RWA6mDPqKT8YKObvDS2a0i470PA2fAX7pRsrwXHK2G38tw+bANRvv5KVK04NWjA1KQ3KQghAx6dgQMRT4DAgW1VvqXPgZk1xrVmfZKYJniPmQSXA57tmq8GjACzJzQ21m941UUj/Vromr5QtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Hzuhntmf; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Hzuhntmf"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1273349c56bso8063670c88.0
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776188781; x=1776793581; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jhogzkt+ToHFbDOLRYWGhZKULinaXeF/7S6zFLWOnQU=;
        b=HzuhntmfTZsXGbw4XXSCtjGgX6Grr7Ht4yxLQsW41946e0rLRtnQ6+QqxutEC71Yoh
         Mf0Py5C8ANXeh5U8DwCU8aMaYhJ3xlvunOCaIuV8R32yTZNuFmTAXfRVRp92Xzf3nl6u
         waKT3wPaMtj7eU+EPmanRMLcW+FwdlVeKicNj9Kpz0/OML0B3MXCSQyP1mgBiOVGN6C9
         6+/jpJxcMYjhejgyWZfYLcsqtxRitMYk4w8pOJo8FJwfRKg8KLDgkBF+v6Q2UdO7Uzui
         y05RyDn4sPxMRGMDV81q+lzKlRtcPz6vZ0RaV64amIzzxeB1DTYiiYvvw8A3cOKdqawg
         PKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776188781; x=1776793581;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jhogzkt+ToHFbDOLRYWGhZKULinaXeF/7S6zFLWOnQU=;
        b=oSMBJ4CwnCI6RRCBFziSZf94DVxUee62twFlTaeLa9JpbsaQVTSjGmCxUmVPxG9ysg
         hCBTWmcMUJ9ehgWUcHh+g1zUtVwBb/S5b6Gn69Rx4DyF03LWpHhFi0kT7q0CmMjVf9zZ
         vj/w4+4cdjFLM3PhPgRcY5XtbhLUt3vNzP8ZTwJRI+yI23IC9UhaCtsONGoy18U7g0vH
         AIHq2wwUtDhtHQsGG3C3vVpHJRuVVWpKbEM6Evd8P5Javv9s19vS3n7QCmp/FXybtnAh
         An+aIeCX0cI3hrLHauV075Oj8OX+4DVNeBxd1q+uwdBKAIZO1PCxtj5cQ7UwRvUMPTQo
         MOnw==
X-Forwarded-Encrypted: i=1; AFNElJ/SQHjiaWnCK8rQe5fK3hssSr5Te2ZbdOLa0JnlI4b07Xb6RMmCN8d7lOxIrlrUY8iwtA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWGSq8a1lUoLBT+m1OY2CaaozNORpXnfMe0FYl405ACzhSQGzI
	16EIACiHLUyXuN5CXQxeXf3mwPgjIfm3fDt2aLvQR61yiC+sodtN1AAvQAtGPPwgumY=
X-Gm-Gg: AeBDieuJbO4KCEB1bWedSaK6+PqPs474Ctj+26zOxexUqRhSaLdd5mpOPSyMsywPp2C
	kgmux+gqn6pSk31MuIqQCS88yHTBApKCdcsoo2U4ONMUqbpd3oz66rxnPsfaoyWxm31/W/EWhu3
	sE+JSGYIxJqLnoP8bOrD2BQhANgJ7X1IArUZPXOzyssmf4jscNP1QKWLsBgUfz9Y2c3TuhLJVcz
	lL8B3HHMh8PcMcaLFKLM6FeH9cjNLdurHKLlxBR7RyGwnHypWRk2cO874VQct0QMgbUQk/hSNIx
	h32oooL3PjEVrbqe8fgLgIBkdrtpDpquxZBNf7Lyu6QvslHLV1qQOVUHGBecMyl4FjKrkddV+me
	oE0aT39yEmSw1ebD1/NrfokAID1yT2emG/giDMesUVLQ/ig4+Ae8ZCu/9vxBeEHL9aI+6hK+Y+b
	XGhyzM1xyUJtQ/9yJbSz35qlrrkA==
X-Received: by 2002:a05:7023:b0f:b0:128:d5bd:357f with SMTP id a92af1059eb24-12c34f09283mr9977428c88.30.1776188780512;
        Tue, 14 Apr 2026 10:46:20 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::cfa6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c346fb031sm18426033c88.13.2026.04.14.10.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 10:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 13:46:18 -0400
Message-Id: <DHT2DG579UVO.349TWXB1RYHYY@etsalapatis.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH RFC bpf-next v2 11/18] libbpf: Support resizable
 hashtable
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kafai@meta.com>, <kernel-team@meta.com>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <20260408-rhash-v2-11-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-11-3b3675da1f6e@meta.com>

On Wed Apr 8, 2026 at 11:10 AM EDT, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add BPF_MAP_TYPE_RHASH to libbpf's map type name table and feature
> probing so that libbpf-based tools can create and identify resizable
> hash maps.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/lib/bpf/libbpf.c        | 1 +
>  tools/lib/bpf/libbpf_probes.c | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 9ea41f40dc82..a0324e5b6085 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -192,6 +192,7 @@ static const char * const map_type_name[] =3D {
>  	[BPF_MAP_TYPE_CGRP_STORAGE]		=3D "cgrp_storage",
>  	[BPF_MAP_TYPE_ARENA]			=3D "arena",
>  	[BPF_MAP_TYPE_INSN_ARRAY]		=3D "insn_array",
> +	[BPF_MAP_TYPE_RHASH]			=3D "rhash",
>  };
> =20
>  static const char * const prog_type_name[] =3D {
> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.=
c
> index b70d9637ecf5..e40819465ddc 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -309,6 +309,9 @@ static int probe_map_create(enum bpf_map_type map_typ=
e)
>  		value_size	=3D sizeof(__u64);
>  		opts.map_flags	=3D BPF_F_NO_PREALLOC;
>  		break;
> +	case BPF_MAP_TYPE_RHASH:
> +		opts.map_flags	=3D BPF_F_NO_PREALLOC;
> +		break;
>  	case BPF_MAP_TYPE_CGROUP_STORAGE:
>  	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
>  		key_size	=3D sizeof(struct bpf_cgroup_storage_key);

