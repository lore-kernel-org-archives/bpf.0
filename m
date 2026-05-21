Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA03176FD
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 04:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336467; cv=none; b=E1sT7DQZB1EIZft6NQbO/dC8YmzVJzAIXu9WQGSsUlXIhfLfLM/xXxL/ryYoDVmFy2EU0xywB9+4O0ezpbHu34wwt0KKNi+EPMj2f2GJwv0L2952lYZdBPOkCF0X/4S1ATwIBBXUlrqfw8EBB+9qSwKMmpdhSSHHlyjc/0YSzMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336467; c=relaxed/simple;
	bh=fBEBu93b5jczK6qq9CsUWP0pGZF6IcTC/U317pLv/p0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XRZ8g3vpJ/CJX2Ae78P+zqmklOZPYoDZTg/U6+AXO+GrGAbAlp05UMVWL1AYdpvgqVZoW9/LivstjgMaFfrpQK/6bxTr2Lie/4TjHBTYUv+5hN770DtEPv2jM/jVN9mDDE3zk0mzY+u4nKmtSZvqSqNUQO5m8jOQ/9VzXhr1pmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=tCW6JKcf; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="tCW6JKcf"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-835386ff122so5778641b3a.3
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 21:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779336466; x=1779941266; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2hkMG41D7UumAODedFGWVazHZhYrfBwUFGTzkSTLig=;
        b=tCW6JKcfI9EGAM1193Ed+NuMH9j0D3IGgFL/aZ6Ch6M2HAc8jHcvElQv05aM0107Bl
         2cCoejLkWJpc7rgGb9/OUGfL2lXAPwMgD88JnXVcUJWMLrRexKp7zzD/TD32BDfgr3YP
         6a2PMyBa0PImLh6ZN4GqNEBEVugTWnGtYmcoR4/6AWPF9Ie57jSCmvLyxMob30RRW/6B
         z6PSkY/ouGA4H+cxjMy0uxTLZtcvt5p8vVO5fiQbNyeh0MrHyfGyBjq9i5dy0Y6G9M6W
         1zUplY9L3zW2U9N7XCAPSS4csEu0faRlnhzYOLVtZ0lPF9+WpdP5gH+mrd9l4LzgiTEQ
         QNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779336466; x=1779941266;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2hkMG41D7UumAODedFGWVazHZhYrfBwUFGTzkSTLig=;
        b=ieOwUnZ4dFLYn/ea0lTwrwozxaJKYVNYoHFKFGzzHVk/kPb6uDZ2T8+El27UWmN8UT
         dtGsW1/aFKSB3B3ExYORDuHNkys5xH6lE+i9nIVda0BrK2HiAhfjKbdFLC6tmdAujz0Y
         G/JGfVhxSoOs43vnCaHnJIlFvSxyMHdOHIupgf6XmSP6YAtVBRGOd9jak5NuYcC4X+O2
         dV+K3HDWmlL9+i7bqT+R74+VazacZ5nSd/TSOkFNEDWu6As3ya+SklnFYuduEKRPTAS3
         8zVfF7v1lrwUq2UT2GzSRbWDy7Tf12Mqb5m/wK3FUC/JRxrKduPxxLC6JFYqmRxCScx9
         651A==
X-Forwarded-Encrypted: i=1; AFNElJ8LbKulMnEctitag/QH0SURo1xeK0ylDZ5u5xMzZzyfJ79kFdw/1tsjetJzX7hYsATP3Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGRzKwZh/5MmbF4zwwXP45xOwgFWWQHzBIcXF7dtxnDkXDddeu
	eT0nhSZnw3Wq60YBLcCQl+lsoMu1G3co65GXs9ZG5obqqnqw0pRBJ6+k4GhCn+SF65M=
X-Gm-Gg: Acq92OErs2BqmJ/um0oZiMxSRAtKhQ8w3FAtBru40rD+s4P6GgDTvGMGY+0kEss4/xJ
	H8ghAJOIijAcTFBf1KSclc9qlM/lu8+q+Sb1YHY9XGP1yik6dlM79lgq9JZXgBJuFWkh0oWCpet
	c1une06/IOTd7iSPx12tZJunE+IC+9GYBTCzNL5vRKf8DJGnD5gXHSzZAFDnqbzGuetECyViyoW
	4bJ33CsQf9i+7wqihqdGM/DlZcGurdnDNRAiSlC8NbQsPXoEz0MAUQRrJese1Tdu+pHzjYVsHYa
	joGWQ5+5kY1Pj1Banrge6ZvEOG7MsTbfz74srZbpyZscoT5ULQGz0bjVhVLAex0AVP8Wy0cyi+8
	zteynYepsWcQRJwh/U3CSbY6/GHx8eqP68/HTaPYPUHOyMPa9ALOqk0qtk5FtBpc8KI6rdBN9Tf
	fEwlkGKLjEOXrVbxVVgfwGr3i+VLgy+sCiYWo=
X-Received: by 2002:a05:6a00:4c8c:b0:83f:250d:59c with SMTP id d2e1a72fcca58-8414ae6e912mr1347583b3a.39.1779336465527;
        Wed, 20 May 2026 21:07:45 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19f7cd19sm22757564b3a.54.2026.05.20.21.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 21:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 May 2026 00:07:44 -0400
Message-Id: <DIO24V5XSTSW.2PW1QDEHN0T3M@etsalapatis.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "David Hildenbrand"
 <david@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <sched-ext@lists.linux.dev>, <bpf@vger.kernel.org>,
 <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] bpf: Add bpf_struct_ops_for_each_prog()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>,
 "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260520235052.4180316-1-tj@kernel.org>
 <20260520235052.4180316-5-tj@kernel.org>
In-Reply-To: <20260520235052.4180316-5-tj@kernel.org>

On Wed May 20, 2026 at 7:50 PM EDT, Tejun Heo wrote:
> Add a helper that walks the member progs of the struct_ops map
> containing a given @kdata vmtable. struct_ops ->reg() callbacks (and
> similar) sometimes need to inspect the loaded BPF programs, e.g. to
> discover maps they reference via prog->aux->used_maps.
>
> The implementation mirrors bpf_struct_ops_id(): container_of @kdata
> to recover the bpf_struct_ops_map, then iterate st_map->links[i]->prog
> for i in [0, funcs_cnt). Same access pattern, no new locking - by the
> time ->reg() fires st_map is fully populated and stable.
>
> A sched_ext follow-up walks the member progs of a cid-form scheduler's
> struct_ops map, reads prog->aux->arena directly, and requires all member
> progs to reference exactly one arena, without requiring the BPF program
> to call a registration kfunc.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  include/linux/bpf.h         |  3 +++
>  kernel/bpf/bpf_struct_ops.c | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 64968ca6db51..5b99d786e98c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2129,6 +2129,9 @@ int bpf_prog_assoc_struct_ops(struct bpf_prog *prog=
, struct bpf_map *map);
>  void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog);
>  void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux);
>  u32 bpf_struct_ops_id(const void *kdata);
> +int bpf_struct_ops_for_each_prog(const void *kdata,
> +				 int (*cb)(struct bpf_prog *prog, void *data),
> +				 void *data);
> =20
>  #ifdef CONFIG_NET
>  /* Define it here to avoid the use of forward declaration */
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 05b366b821c3..16aec18ed31b 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -1203,6 +1203,42 @@ u32 bpf_struct_ops_id(const void *kdata)
>  }
>  EXPORT_SYMBOL_GPL(bpf_struct_ops_id);
> =20
> +/**
> + * bpf_struct_ops_for_each_prog - Invoke @cb for each member prog
> + * @kdata: kernel-side struct_ops vmtable (the @kdata arg to ->reg/->upd=
ate/->unreg)
> + * @cb: callback invoked once per member prog; non-zero return stops ite=
ration
> + * @data: opaque argument passed to @cb
> + *
> + * Walks the struct_ops member progs registered on the map containing @k=
data.
> + * Intended for use from struct_ops ->reg() callbacks (and similar) that=
 need to
> + * inspect the loaded BPF programs (for example to discover maps they re=
ference
> + * via @prog->aux->used_maps).
> + *
> + * Return 0 if iteration completed, otherwise the first non-zero @cb ret=
urn.
> + */
> +int bpf_struct_ops_for_each_prog(const void *kdata,
> +				 int (*cb)(struct bpf_prog *prog, void *data),
> +				 void *data)
> +{
> +	struct bpf_struct_ops_value *kvalue;
> +	struct bpf_struct_ops_map *st_map;
> +	u32 i;
> +	int ret;
> +
> +	kvalue =3D container_of(kdata, struct bpf_struct_ops_value, data);
> +	st_map =3D container_of(kvalue, struct bpf_struct_ops_map, kvalue);
> +
> +	for (i =3D 0; i < st_map->funcs_cnt; i++) {
> +		if (!st_map->links[i])
> +			continue;
> +		ret =3D cb(st_map->links[i]->prog, data);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(bpf_struct_ops_for_each_prog);
> +
>  static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
>  {
>  	struct bpf_struct_ops_map *st_map =3D (struct bpf_struct_ops_map *)map;

