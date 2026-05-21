Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD06C19C556
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 04:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336931; cv=none; b=ZI1D85Ibp7nSgGs+7KSiXE8E6Oimjka8JmXzLi60yL8qhNOykvf52APR0EqqOPbsAjf8Gf4P1MeEiHkxoljeqHGZqy9z4bILruwsuU2NJfdLKRgW4SuNhr1KUKlHmG1qUsTu2UFqMuJLrGKOu3+U8y6kbZ9B9RR/WoTwi+tHKDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336931; c=relaxed/simple;
	bh=7pJINburNI2s6aoo69b+PuHHTBy7UiG91NoFj7AaxeM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=RnNMYG9o/t6mRw8994WrTeEqVierVBnDdiIYCoxU5yovCvwxnQ3JqUuksBxGQ3a1kKBPBGxW6k8VhxgjSYUe09ELVjrA6KAI/zp3Ti+/+QaXcT4fkcW86EOnWdBIX1KAJNqf4uf4L8g13NF1KqrZvBHw9elpwgixjEU5NT9yhn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=B2A88vOW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="B2A88vOW"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bd80b3aa13so36214645ad.0
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 21:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779336927; x=1779941727; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mx7h0My419s2P7k1BFl0yESBgvzIQJC2piNf13boJc=;
        b=B2A88vOW5GiHweAa5SCUw4eKLZTrn6SEVetyoM65ZB5PftP31vQCiFTWg4urzncQ3H
         v9VBtUJ6gWDYFQb9n1lNzSulmB4UHXy4rtUmoY7sLBXDHm516SN5+nn5HlBrLYy5+2Pv
         yl+/a7/v+dICGBcrdIXhs0NJwAp05D+B5UIKNOFSsqU5eUjYxVW8y8bNLxvcFsR1kP3B
         sAyHfAwt2Xn2A+7JEKFtDdY5Z8yB3St7LS/emdV65RvT/eHpovrwjQvd/eDIFT8iacSW
         NHQ4HYhQ+SAydnayyJ+o55EarWU1NNiysvIO2bpGzkNa5vBx2XRsPvk0NZEEBDt0Np9o
         +CNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779336927; x=1779941727;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8mx7h0My419s2P7k1BFl0yESBgvzIQJC2piNf13boJc=;
        b=aaL6NL2aXAhfR8hgrTE7P3RDUnV6WrVMckZ01sYaIlcqx6NT/NCzOaR513z0lKrxkC
         37J8OD9wdbW60ukLVeCH6Vq4LyIiflmp5ITSr0k9KEyu9Y/aMS2b3LM/UlbRgcWlTZnB
         N+Yzb7skMOvxfbfnVBdZWdCQXF/fcu98OnP2WYjlam2QLpGy8kS+BTj87PiB9Jzm+6yR
         AaWXR32IHgBK5mO0ONoNASqo1GTVVUVYkbktKkhPs00N6tSYS917rxsr2t6wSsMbQbLJ
         vi70Burt02QIxZY9960O1PGe2VC9btKS+LlIxyQCrM0AZqsejAS0htXGi/ARyx/RFlkY
         YycA==
X-Forwarded-Encrypted: i=1; AFNElJ/8oaEoeS1R/z4/ZnECqGQdrBoEPVngMN980tA1X0yQ5srhI5+vmUlLvICfSAg2eqh8QT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6FSA4N0dHtSdCIAZRHAlua8EovTqqM3ssd2SpQwCkj7f2p/lq
	bSutIN8fEFLqp5ZNY+/25IOuN2vGsD324oUt/5zITipesj6lxbLmuETqWLMMm/lvNPw=
X-Gm-Gg: Acq92OE36Gbk4F0SUQ8rV1qq2HvkEj8t6WyeNRPCyfQ9zgrTLtUxMScPQ68+/xHMpG0
	8TUKhqzwehZpc8XzzdWaTKyPUJb58qve8SfbtnAEFqlO2TYa/O8ozKX+VKcT5PBfxY2kqzXJ/Lw
	Ttbr9+YBRfchGkqxhUa4bXz75lxhADs1rGbSN+nd5FD8GM4UMB3KLkItqgXC/nK2NGPtrgkZPte
	BYtqRR+fOVgso+FuDuR0NTjnNXz0eDFyAVxeHpAW3s3iUwWX9CoGAxQb2B1widwdKCXH+WHoxlN
	py8ERD0qpKJgW1IEaPWGAK2j1Buxf8gPm8qJkUb7mJzlG6jtA0Am0BlbGCewl1aUlsSZPqOaSF1
	Z1KTkZhbS0l4nIsiA1nLmabZAYpVB04ssuH5oDAnHwqMxTjVAPjaOnsVwoaEaRVp4RTvZ9WlaD/
	Ng+RN15DhHGzL5HMW8tCz58e4q5p8o1q/70wo=
X-Received: by 2002:a17:902:c946:b0:2ae:5629:ac55 with SMTP id d9443c01a7336-2bea331d50dmr10441855ad.21.1779336927286;
        Wed, 20 May 2026 21:15:27 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d234540sm234841675ad.79.2026.05.20.21.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 21:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 May 2026 00:15:26 -0400
Message-Id: <DIO2ARBBUOJX.1OJ5RVION2UH1@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>,
 "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "David Hildenbrand"
 <david@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <sched-ext@lists.linux.dev>, <bpf@vger.kernel.org>,
 <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/8] sched_ext: Require an arena for cid-form schedulers
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260520235052.4180316-1-tj@kernel.org>
 <20260520235052.4180316-7-tj@kernel.org>
In-Reply-To: <20260520235052.4180316-7-tj@kernel.org>

On Wed May 20, 2026 at 7:50 PM EDT, Tejun Heo wrote:
> Upcoming patches will let the kernel place arena-resident scratch shared
> with the BPF program (e.g. per-CPU set_cmask cmask) so the BPF side can
> dereference it directly via __arena pointers, replacing the current
> cmask_copy_from_kernel() probe-read loop. That requires each cid-form
> scheduler to expose its arena to the kernel. Kernel- side accesses are
> recovered by the per-arena scratch-page mechanism.
>
> bpf_scx_reg_cid() walks the struct_ops member progs via
> bpf_struct_ops_for_each_prog() and reads each prog's arena via
> bpf_prog_arena(). The verifier enforces one arena per program, so each
> member prog contributes at most one arena. All non-NULL contributions mus=
t
> match and at least one member prog must use an arena. The map ref is held=
 on
> scx_sched and dropped on sched destroy. cpu-form schedulers (bpf_scx_reg)
> are unchanged - no arena requirement.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c          | 56 ++++++++++++++++++++++++++++++++++++-
>  kernel/sched/ext_internal.h |  8 ++++++
>  2 files changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 9c458552d14f..56f94ac32ba0 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5003,6 +5003,8 @@ static void scx_sched_free_rcu_work(struct work_str=
uct *work)
> =20
>  	rhashtable_free_and_destroy(&sch->dsq_hash, NULL, NULL);
>  	free_exit_info(sch->exit_info);
> +	if (sch->arena_map)
> +		bpf_map_put(sch->arena_map);
>  	kfree(sch);
>  }
> =20
> @@ -6746,6 +6748,7 @@ struct scx_enable_cmd {
>  		struct sched_ext_ops_cid	*ops_cid;
>  	};
>  	bool			is_cid_type;
> +	struct bpf_map		*arena_map;	/* arena ref to transfer to sch */
>  	int			ret;
>  };
> =20
> @@ -6913,6 +6916,15 @@ static struct scx_sched *scx_alloc_and_add_sched(s=
truct scx_enable_cmd *cmd,
>  		return ERR_PTR(ret);
>  	}
>  #endif	/* CONFIG_EXT_SUB_SCHED */
> +
> +	/*
> +	 * Consume the arena_map ref bpf_scx_reg_cid() took. Defer to here so
> +	 * earlier failure paths leave cmd->arena_map set and bpf_scx_reg_cid
> +	 * drops the ref. After this point, sch owns the ref and any cleanup
> +	 * runs through scx_sched_free_rcu_work() which puts it.
> +	 */
> +	sch->arena_map =3D cmd->arena_map;
> +	cmd->arena_map =3D NULL;
>  	return sch;
> =20
>  #ifdef CONFIG_EXT_SUB_SCHED
> @@ -7898,11 +7910,53 @@ static int bpf_scx_reg(void *kdata, struct bpf_li=
nk *link)
>  	return scx_enable(&cmd, link);
>  }
> =20
> +struct scx_arena_scan {
> +	struct bpf_map	*arena;
> +	int		err;

Can we skip the int err here...

> +};
> +
> +/*
> + * The verifier enforces one arena per BPF program, so each struct_ops
> + * member prog contributes at most one arena via bpf_prog_arena().
> + * Require all non-NULL contributions to match.
> + */
> +static int scx_arena_scan_prog(struct bpf_prog *prog, void *data)
> +{
> +	struct scx_arena_scan *s =3D data;
> +	struct bpf_map *arena =3D bpf_prog_arena(prog);
> +
> +	if (!arena)
> +		return 0;
> +	if (s->arena && s->arena !=3D arena) {
> +		s->err =3D -EINVAL;

...and just directly return -EINVAL here? bpf_struct_ops_for_each_prog
breaks when we return non-zero so do we need the extra scx_arena_scan
struct?

> +		return 1;
> +	}
> +	s->arena =3D arena;
> +	return 0;
> +}
> +
>  static int bpf_scx_reg_cid(void *kdata, struct bpf_link *link)
>  {
>  	struct scx_enable_cmd cmd =3D { .ops_cid =3D kdata, .is_cid_type =3D tr=
ue };
> +	struct scx_arena_scan scan =3D {};
> +	int ret;
> =20
> -	return scx_enable(&cmd, link);
> +	bpf_struct_ops_for_each_prog(kdata, scx_arena_scan_prog, &scan);
> +	if (scan.err) {
> +		pr_err("sched_ext: cid-form scheduler uses multiple arena maps\n");
> +		return scan.err;
> +	}
> +	if (!scan.arena) {
> +		pr_err("sched_ext: cid-form scheduler must use a BPF arena map\n");
> +		return -EINVAL;
> +	}
> +
> +	bpf_map_inc(scan.arena);
> +	cmd.arena_map =3D scan.arena;
> +	ret =3D scx_enable(&cmd, link);
> +	if (cmd.arena_map)		/* not consumed by scx_alloc_and_add_sched() */
> +		bpf_map_put(cmd.arena_map);
> +	return ret;
>  }
> =20
>  static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index 7258aea94b9f..d40cfd29ddaa 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -1111,6 +1111,14 @@ struct scx_sched {
>  		struct sched_ext_ops_cid	ops_cid;
>  	};
>  	bool			is_cid_type;	/* true if registered via bpf_sched_ext_ops_cid */
> +
> +	/*
> +	 * Arena map auto-discovered from member progs at struct_ops attach.
> +	 * cid-form schedulers must use exactly one arena across all member
> +	 * progs. NULL on cpu-form.
> +	 */
> +	struct bpf_map		*arena_map;
> +
>  	DECLARE_BITMAP(has_op, SCX_OPI_END);
> =20
>  	/*

