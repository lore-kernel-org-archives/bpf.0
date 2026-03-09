Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE476238C23
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074204; cv=none; b=fDTknjBJT/ytJ5dtxcO66vc17SYTN0Kz4HfmALDbRE21qgXN5B/ODeVbC+dLgsFa+3Tk70brJwc/IbOHdUCm0KIS3hFggKu606ijdaV8CtDaw2adoWpFW48OWOpBeYdfbI7uDKPIljmoOOVQEtdxv2qenD9vPSQFGyT59/wFd3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074204; c=relaxed/simple;
	bh=/UKuZLPM9R8s9H5F0r9xIwsuvuUJXtRALCla8IQDVvQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=lxoBPxDmfOaHOJJ/9b9u1eN0pn+xHCN05JLjGUyF/YAdQ240eKPe6Z+Yj23UNwJ6KLtWvprb19bl/kFNMOVGeIOkPrSjJJrf1Cbt2Y3A/dIpX7I89ua5U+lRegh3V6jHhn5ATc1qOsTKz/kvd6SvoRzJZEAODtn1PN3gEPxs/bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=dArwFW7E; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="dArwFW7E"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50902b1006cso18565821cf.3
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 09:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773074202; x=1773679002; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXt2YirIQL3+wm3ogVH+SsSHj0oOD4TC2QgB43xa3+U=;
        b=dArwFW7EdCtpT0VtSe+1DYVBOjgJuMeHG3/7D0A1IdyWjSX7Gfs9WBW21aUA1cwzXu
         Fh1Vgrgdw+hXNvVFfrPkOQPW1DIQPTW5fre+FxAe0gyEA7qk8s5VW+r7bSARnh3Oos7Q
         Uv0e4Sj1SUZXJh+weBPmCoooSASaC++CvcDCkPQ/ZyEqvP9+OvTBMb4t3/Who5Wb/eC4
         oAgzDv3lKNzpcdMjEbmqj3Se3UXH1nJCSaeNBsx91aozQtFWxLXvvjM5fJYv7vNF3Ey5
         K7n0E1tYqwpYqtxyplYantv+kGhQO8MkpAZtt2Mgdpi3+15hPjBFQTF1if3B5jFwE6YS
         vsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773074202; x=1773679002;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IXt2YirIQL3+wm3ogVH+SsSHj0oOD4TC2QgB43xa3+U=;
        b=cPWC3Azu6iMTVVDfF/zTmRjKzhjMv90dn6ijsF6So0pHMd0yILnWyGp3+7a2tqk4k+
         GGIHmrAmwfiEf+uTjRyL0oydBhcEINLalj9sybvskQi9tBKR/uqxiHleLstWFZLFc/S9
         Aj+rYHwUWNskvWc5eEfBHmcqfFTUzl4jPpWbpETogSGc4n+kSkwr4FYt7yUKFouuZ8uW
         xoO9U64sKoJreO5jXCW3r2IloZyCzSmL5zSBRoRILXUE16s36JRj6fqopkR4gBVj2AXk
         z5G2e1P7vPIHzIRds3Gd/94kldZR9Ur8jXtSwH6HIebVj5bHP81XK7t6Nbp9qY2qvaN0
         lu+w==
X-Forwarded-Encrypted: i=1; AJvYcCU0oo9GBPg/CcFxEzeGz8LEYNHleJ/rgfkO0vYTMNWUlj9r5L6XJm9Tb7drZ9W0W9+wJ58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Ex2cvuEuKgehnViTgurQn+rH02TfoZLJsulWRWMvydWb6LDy
	PS8E8gyBuC5NX4x43EK4d15GKzyRIt48Xv3Dszcgc3osQ8CyfQCXDoarOE7fsjLNUBU=
X-Gm-Gg: ATEYQzwiLsu9r6X5aTo3Yx7gc8dAGp6Pq+jDyMNZKi5h5wnBAYalE3+4rbO5yk4y0Kp
	W2pWsSeugkMuBmfSKfieVDiBozDn/jo/u11NeQKxmwtUx+WDDKceYJxdmfA4drk7TlccqYYFZyy
	iFGYVCmZPwz6qBxK3Mhkf3jKP993vp129gW1mIXe4HcMnZy6idGwBLz3km6gWJ9WzKhXzPEVAON
	MBvnqeUwlSMZHLT5e8xatgZjbd9t2wjmmyiIS2KmNIyTOff8IbqlgYhWBQwWke6XwcAo/LTs+Fg
	SBjR7ZWZPhNF81H9+o5M8RJ0ZvL3UYaaIIUOuJYbTrAkR6VjVEKjnVneA9nKqysaX2sTcDYxJxF
	/zJxmtqidVwV08HtfXGwXwPM4pXNgzSqbqcGVilnszh+RfhEULpPfPVaTpfwVx+MRwT/7aCYIGj
	8zTlrSLvJ3XBMKxUaB9tu6f98=
X-Received: by 2002:a05:622a:1915:b0:509:cbc:1277 with SMTP id d75a77b69052e-5090cbc141fmr88146831cf.41.1773074201737;
        Mon, 09 Mar 2026 09:36:41 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57a3a9a2sm1396576d6.15.2026.03.09.09.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 09:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Mar 2026 12:36:40 -0400
Message-Id: <DGYECIPVC266.25320R7256YJT@etsalapatis.com>
Subject: Re: [PATCH v2 2/2] tools/sched_ext: scx_sdt: Fix BPF verifier
 rejection on older LLVMs
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Zhao Mengmeng" <zhaomzhao@126.com>, <tj@kernel.org>,
 <void@manifault.com>, <arighi@nvidia.com>, <changwoo@igalia.com>,
 <nathan@kernel.org>, <nick.desaulniers+lkml@gmail.com>, <morbo@google.com>,
 <justinstitt@google.com>
Cc: <sched-ext@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <llvm@lists.linux.dev>, <zhaomengmeng@kylinos.cn>
X-Mailer: aerc 0.20.1
References: <20260309022847.106150-1-zhaomzhao@126.com>
 <20260309022847.106150-3-zhaomzhao@126.com>
In-Reply-To: <20260309022847.106150-3-zhaomzhao@126.com>

On Sun Mar 8, 2026 at 10:28 PM EDT, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
>
> Under Clang 17/18, when running scx_sdt scheduler, it fails with:
>
> libbpf: prog 'sdt_init_task': BPF program load failed: -EACCES
> libbpf: prog 'sdt_init_task': -- BEGIN PROG LOAD LOG --
> ...
> ; desc =3D desc_find_empty(alloc->root, &idx); @ scx_sdt.bpf.c:479
> 43: (79) r8 =3D *(u64 *)(r6 +32)        ; frame1: R6=3Dmap_value(map=3Dsc=
x_sdt.bss,ks=3D4,vs=3D200,off=3D120) R8=3Dscalar()
> ; for (level =3D zero; level < SDT_TASK_LEVELS && can_loop; level++) { @ =
scx_sdt.bpf.c:407
> 44: (e5) may_goto pc+51
> ; idx |=3D pos; @ scx_sdt.bpf.c:418
> 96: (bf) r7 =3D r2                      ; frame1: R2=3D0 R7=3D0
> 97: (bf) r1 =3D r10                     ; frame1: R1=3Dfp0 R10=3Dfp0
> ;  @ scx_sdt.bpf.c:0
> 98: (07) r1 +=3D -56                    ; frame1: R1=3Dfp-56
> ; bpf_for(u, 0, SDT_TASK_LEVELS) { @ scx_sdt.bpf.c:447
> 99: (b4) w2 =3D 0                       ; frame1: R2=3D0
> 100: (b4) w3 =3D 3                      ; frame1: R3=3D3
> 101: (85) call bpf_iter_num_new#82234         ; frame1: R0=3Dscalar() fp-=
56=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D0)
> 102: (18) r9 =3D 0x1ffffffffffffff8     ; frame1: R9=3D0x1ffffffffffffff8
> 104: (bf) r1 =3D r10                    ; frame1: R1=3Dfp0 R10=3Dfp0
> ;  @ scx_sdt.bpf.c:0
> 105: (07) r1 +=3D -56                   ; frame1: R1=3Dfp-56
> ; bpf_for(u, 0, SDT_TASK_LEVELS) { @ scx_sdt.bpf.c:447
> 106: (85) call bpf_iter_num_next#82235        ; frame1: R0=3D0 fp-56=3Dit=
er_num(ref_id=3D2,state=3Ddrained,depth=3D0)
> 107: (15) if r0 =3D=3D 0x0 goto pc+29     ; frame1: R0=3D0
> ; if (tmp->nr_free > 0) @ scx_sdt.bpf.c:456
> 137: (bf) r1 =3D r10                    ; frame1: R1=3Dfp0 R10=3Dfp0
> ; bpf_for(u, 0, SDT_TASK_LEVELS) { @ scx_sdt.bpf.c:447
> 138: (07) r1 +=3D -56                   ; frame1: R1=3Dfp-56
> 139: (85) call bpf_iter_num_destroy#82232     ; frame1:
> 140: (b7) r9 =3D 0                      ; frame1: R9=3D0
> ; if (unlikely(desc =3D=3D NULL)) { @ scx_sdt.bpf.c:480
> 141: (15) if r8 =3D=3D 0x0 goto pc+15     ; frame1: R8=3Dscalar(umin=3D1)
> ; chunk =3D desc->chunk; @ scx_sdt.bpf.c:485
> 142: (79) r4 =3D *(u64 *)(r8 +72)
> R8 invalid mem access 'scalar'
>
> The reason is these older compilers lacks native support for
> __BPF_FEATURE_ADDR_SPACE_CAST, __arena macro is defined as empty.
>
> Fix it by adding cast_kern when dereferencing variables with __arena tag.
>

I am not sure if we want to support older Clang versions at this point.
This issue is fixed for Clang 19, and adding the macros back in makes it=20
confusing for those who use the code as a starting point. And while
it would be nice to support older Clang versions, we already don't
handle Clang 15/16 that don't have arena support. So it's not
unreasonable if we say Clang 17/18 are also incompatible with this
example.

On the other hand, maybe the extra compatibility is worth re-adding=20
cast_kern/cast_user to the code. I am slightly in favor of keeping it
as-is to avoid churn, but can easily see why we'd go the other way.

@htejun WDYT?

> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> ---
>  tools/sched_ext/scx_sdt.bpf.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/tools/sched_ext/scx_sdt.bpf.c b/tools/sched_ext/scx_sdt.bpf.=
c
> index 31b09958e8d5..caacc55bd7a5 100644
> --- a/tools/sched_ext/scx_sdt.bpf.c
> +++ b/tools/sched_ext/scx_sdt.bpf.c
> @@ -148,6 +148,7 @@ static sdt_desc_t *scx_alloc_chunk(void)
> =20
>  	out =3D desc;
> =20
> +	cast_kern(desc);
>  	desc->nr_free =3D SDT_TASK_ENTS_PER_CHUNK;
>  	desc->chunk =3D chunk;
> =20
> @@ -244,6 +245,7 @@ int mark_nodes_avail(sdt_desc_t *lv_desc[SDT_TASK_LEV=
ELS], __u64 lv_pos[SDT_TASK
>  		/* Only propagate upwards if we are the parent's only free chunk. */
>  		desc =3D lv_desc[level];
> =20
> +		cast_kern(desc);
>  		ret =3D set_idx_state(desc, lv_pos[level], false);
>  		if (unlikely(ret !=3D 0))
>  			return ret;
> @@ -298,20 +300,26 @@ int scx_alloc_free_idx(struct scx_allocator *alloc,=
 __u64 idx)
>  		if (level =3D=3D SDT_TASK_LEVELS - 1)
>  			break;
> =20
> +		cast_kern(desc);
>  		chunk =3D desc->chunk;
> =20
> +		cast_kern(chunk);
>  		desc_children =3D (sdt_desc_t * __arena *)chunk->descs;
> +		cast_kern(desc_children);
>  		desc =3D desc_children[pos];
> =20
>  		if (unlikely(!desc))
>  			return -EINVAL;
>  	}
> =20
> +	cast_kern(desc);
>  	chunk =3D desc->chunk;
> =20
>  	pos =3D idx & mask;
> +	cast_kern(chunk);
>  	data =3D chunk->data[pos];
>  	if (likely(data)) {
> +		cast_kern(data);
>  		*data =3D (struct sdt_data) {
>  			.tid.genn =3D data->tid.genn + 1,
>  		};
> @@ -378,6 +386,7 @@ __u64 chunk_find_empty(sdt_desc_t __arg_arena *desc)
>  	__u64 freeslots;
>  	__u64 i;
> =20
> +	cast_kern(desc);
>  	for (i =3D 0; i < SDT_TASK_CHUNK_BITMAP_U64S; i++) {
>  		freeslots =3D ~desc->allocated[i];
>  		if (freeslots =3D=3D (__u64)0)
> @@ -426,9 +435,12 @@ static sdt_desc_t * desc_find_empty(sdt_desc_t *desc=
, __u64 *idxp)
>  			break;
> =20
>  		/* Allocate an internal node if necessary. */
> +		cast_kern(desc);
>  		chunk =3D desc->chunk;
> +		cast_kern(chunk);
>  		desc_children =3D (sdt_desc_t * __arena *)chunk->descs;
> =20
> +		cast_kern(desc_children);
>  		desc =3D desc_children[pos];
>  		if (!desc) {
>  			desc =3D scx_alloc_chunk();
> @@ -448,6 +460,7 @@ static sdt_desc_t * desc_find_empty(sdt_desc_t *desc,=
 __u64 *idxp)
>  		level =3D SDT_TASK_LEVELS - 1 - u;
>  		tmp =3D lv_desc[level];
> =20
> +		cast_kern(tmp);
>  		ret =3D set_idx_state(tmp, lv_pos[level], true);
>  		if (ret !=3D 0)
>  			break;
> @@ -482,10 +495,12 @@ void __arena *scx_alloc(struct scx_allocator *alloc=
)
>  		return NULL;
>  	}
> =20
> +	cast_kern(desc);
>  	chunk =3D desc->chunk;
> =20
>  	/* Populate the leaf node if necessary. */
>  	pos =3D idx & (SDT_TASK_ENTS_PER_CHUNK - 1);
> +	cast_kern(chunk);
>  	data =3D chunk->data[pos];
>  	if (!data) {
>  		data =3D scx_alloc_from_pool(&alloc->pool);
> @@ -503,10 +518,12 @@ void __arena *scx_alloc(struct scx_allocator *alloc=
)
>  	alloc_stats.alloc_ops +=3D 1;
>  	alloc_stats.active_allocs +=3D 1;
> =20
> +	cast_kern(data);
>  	data->tid.idx =3D idx;
> =20
>  	bpf_spin_unlock(&alloc_lock);
> =20
> +	cast_user(data);
>  	return data;
>  }
> =20
> @@ -544,9 +561,10 @@ void __arena *scx_task_alloc(struct task_struct *p)
>  	if (unlikely(!data))
>  		return NULL;
> =20
> +	mval->data =3D data;
> +	cast_kern(data);
>  	mval->tid =3D data->tid;
>  	mval->tptr =3D (__u64) p;
> -	mval->data =3D data;
> =20
>  	return (void __arena *)data->payload;
>  }

