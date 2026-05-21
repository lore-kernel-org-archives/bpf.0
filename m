Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEA134EF05
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 04:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779337185; cv=none; b=ro2WZuyB86UIQWbmBiZAxLldg18jCOYdcE6lqvd/7jKNQoTblXb39uXjrDitnSPApOUYembWDsxifXT+p9orvrdBUNZuxGMsS52v91RtXGNTEDspQe3aVw2w70quY3IS9cPfRfTzoQ5hcjhfmMKi9U5Jt2mKzdHhN8FD6/iOuTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779337185; c=relaxed/simple;
	bh=iJGPAjxxIadOYSrwMzUWNw4STC1X9i/wJDX9NHr9GDU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=DxByGDbunGB20/ZIAFmK0HcZ/HEVpSx87pcSM8VLBrB0it4oWCx4aFvsAneH5RxZsmTKdaLJbOyz3fklP/M3kKXO+2gzExoFUUZMSQx0+N9lE9B0+uxODAmGPfVdI4M/YUiQDJg2ieCiykNMGqh08lYwRHDh/2FqTeXtcH8XE4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=NAaWSZ3f; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="NAaWSZ3f"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c7980c060cfso2502700a12.2
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 21:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779337172; x=1779941972; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Et0bGEjjWdmJXg1QKS6BT27sCw0OJSCkjTf2JeHVHR8=;
        b=NAaWSZ3fU5mWTDQe0srEotKTIgKdC5qu+eAAkCE2zn7ztnUwYD7O5YPdk4AuHA4ZuL
         EFM2WiFHVZf3JExKq3FsuBeAMEb4xyL2Kppv1iLQZtOXMyBdpqV6AzUtlXppfrJw5qO9
         zQIA/mxTd/D6fgLmou+zT0Tf4L+DJpT6mlfZSxNPbxCTNhOE1Qk9Gj+B7VV1gBQgjz65
         LlBekFdHTEJ1VWm/0kPiqAT0FV0UpO6FwO5xTJxQ4Oevnh9Wa7OrDb+wqxbzBC8ix6GX
         QQw9zWE+hS6ks8DHLembCBX1llyVvSQsPo1kGVvEcWc/yv2aN6tBdBg1ikbIRpU2pWKV
         xtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779337172; x=1779941972;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Et0bGEjjWdmJXg1QKS6BT27sCw0OJSCkjTf2JeHVHR8=;
        b=KIQV9/6xogbJSjoq0Pt4WklBT0Hjs2H1ujYhfpRPOzq/2kkEsLvpD3ZqDEOQYGuooX
         VVrf4CU+BxqVq1Oobm0IHkT2ZklTYfSls5oqfj/mArHCfiO3ul64iCUlJ57I0+tCronq
         r5sMYKxooB6/YVbUeF22qjH/bfL8z4egp3rR/FCsgVXJXZ2JKmnmj4fY63rmylLfVj6T
         giLk2x74h5hbbU4snRqzLdjI73LiCefLszyMc4B56ch3zy389VhwYVtvxoao4kgy9UHc
         0/58lrS4vsewQeVcTxvS0846og7YMyaE3m4sJCVH16wRL+gZeON7oT0mzvKXl4GBNSzY
         9q6w==
X-Forwarded-Encrypted: i=1; AFNElJ/WLgZ2P8tDw2tI1t5yLHjFzJ2a2YTjTsky3ufk2V5Qpc0AUjtgCsIcvmQJwcKpzbpV7xU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF6/dGs8zN0vGrqEGyXo0pZ2bVAFWu1TfaLQGimaDUt/s7lf1+
	HPP8LoYgTSNFLqEr4IEvKiyeD3uLY1vPh/vreTaM+IfSWNhXO92EPAloB3JqZX0km6k=
X-Gm-Gg: Acq92OEyw6t/DJ9DyyadPaR+QGtplCNFuf/84Ul2XI24v95MvEkDLE/4Z5zefOM29FG
	/SmcSSw4GYRbqD6pJz7waaV5NLmv0QjkAbxFzkb2+qSL/eS7gRPjw3TXE2CqOK4rcVyjGiR/J6x
	UVGszuvRox2rxjPmQfTur3sT7m05o86T6JLmdeZ5DaQhNWm5S7/sGa6aUm39mcDvS/APfVLZmt3
	SZVtFtRItCe3LsSU6WdUB3O+t4EJc2bbOmVsZNtMGxgeihWwVMOqFKvP2lvLjVESNqhcQTMtQAQ
	RdM9t9Bbv4oQRdz0OXTXfLMNmxy1Hy0IApXqCqjMkgY2Etgbx2rYZFXczy2Dbm/sJkQ2Ml5r826
	Lv1eDgBvujx+TMwbiKTmhyqg44LReLsHoAQrWXBDo8qzpWwj8ckWiWut3GtYlPaxtWaz+zVe2GA
	TpGEd13pcwVU175HvQz7cbhHHq
X-Received: by 2002:a17:903:1b06:b0:2ba:5e44:ce8f with SMTP id d9443c01a7336-2bea2f89c83mr11555725ad.0.1779337171498;
        Wed, 20 May 2026 21:19:31 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05fcb3sm243627525ad.26.2026.05.20.21.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 21:19:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 May 2026 00:19:30 -0400
Message-Id: <DIO2DVGYRBUN.1QPC47NPPWTZ9@etsalapatis.com>
Subject: Re: [PATCH 8/8] sched_ext: Convert ops.set_cmask() to
 arena-resident cmask
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
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260520235052.4180316-1-tj@kernel.org>
 <20260520235052.4180316-9-tj@kernel.org>
In-Reply-To: <20260520235052.4180316-9-tj@kernel.org>

On Wed May 20, 2026 at 7:50 PM EDT, Tejun Heo wrote:
> ops_cid.set_cmask() expects a cmask. The kernel couldn't write into the
> arena, so it translated cpumask -> cmask in kernel memory and passed the
> result as a trusted pointer. The BPF cmask helpers all operate on arena
> cmasks though, so the BPF side had to word-by-word probe-read the kernel
> cmask into an arena cmask via cmask_copy_from_kernel() before any helper
> could touch it. It works, but is clumsy.
>
> With direct kernel-side arena access now in place, build the cmask in the
> arena. The kernel writes to it through the kern_va side of the dual mappi=
ng;
> BPF directly dereferences it via an __arena pointer like any other arena
> struct.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/sched/ext.c                    | 68 +++++++++++++++++++++++++--
>  kernel/sched/ext_cid.c                | 20 +-------
>  kernel/sched/ext_internal.h           | 10 +++-
>  tools/sched_ext/include/scx/cid.bpf.h | 52 --------------------
>  tools/sched_ext/scx_qmap.bpf.c        |  5 +-
>  5 files changed, 75 insertions(+), 80 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index fb91079c1244..94562e3350c6 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -621,11 +621,16 @@ static inline void scx_call_op_set_cpumask(struct s=
cx_sched *sch, struct rq *rq,
>  		update_locked_rq(rq);
> =20
>  	if (scx_is_cid_type()) {
> -		struct scx_cmask *cmask =3D this_cpu_ptr(scx_set_cmask_scratch);
> -
> -		lockdep_assert_irqs_disabled();
> -		scx_cpumask_to_cmask(cpumask, cmask);
> -		sch->ops_cid.set_cmask(task, cmask);
> +		struct scx_cmask *kern_va =3D *this_cpu_ptr(sch->set_cmask_scratch);
> +		unsigned long uaddr =3D (unsigned long)kern_va -
> +			bpf_arena_map_kern_vm_start(sch->arena_map);
> +		/*
> +		 * Build the per-CPU arena cmask and hand BPF the uaddr. Caller
> +		 * holds the rq lock with IRQs disabled, which makes us the sole
> +		 * user of the scratch area.
> +		 */
> +		scx_cpumask_to_cmask(cpumask, kern_va);
> +		sch->ops_cid.set_cmask(task, (struct scx_cmask *)uaddr);
>  	} else {
>  		sch->ops.set_cpumask(task, cpumask);
>  	}
> @@ -4949,6 +4954,48 @@ static const struct attribute_group scx_global_att=
r_group =3D {
>  static void free_pnode(struct scx_sched_pnode *pnode);
>  static void free_exit_info(struct scx_exit_info *ei);
> =20
> +static s32 scx_set_cmask_scratch_alloc(struct scx_sched *sch)
> +{
> +	size_t size =3D struct_size_t(struct scx_cmask, bits,
> +				    SCX_CMASK_NR_WORDS(num_possible_cpus()));
> +	int cpu;
> +
> +	if (!sch->is_cid_type || !sch->arena_pool)
> +		return 0;
> +
> +	sch->set_cmask_scratch =3D alloc_percpu(struct scx_cmask *);
> +	if (!sch->set_cmask_scratch)
> +		return -ENOMEM;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct scx_cmask **slot =3D per_cpu_ptr(sch->set_cmask_scratch, cpu);
> +
> +		*slot =3D scx_arena_alloc(sch, size);
> +		if (!*slot)
> +			return -ENOMEM;
> +		scx_cmask_init(*slot, 0, num_possible_cpus());
> +	}
> +	return 0;
> +}
> +
> +static void scx_set_cmask_scratch_free(struct scx_sched *sch)
> +{
> +	size_t size =3D struct_size_t(struct scx_cmask, bits,
> +				    SCX_CMASK_NR_WORDS(num_possible_cpus()));
> +	int cpu;
> +
> +	if (!sch->set_cmask_scratch)
> +		return;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct scx_cmask **slot =3D per_cpu_ptr(sch->set_cmask_scratch, cpu);
> +
> +		scx_arena_free(sch, *slot, size);
> +	}
> +	free_percpu(sch->set_cmask_scratch);
> +	sch->set_cmask_scratch =3D NULL;
> +}
> +
>  static void scx_sched_free_rcu_work(struct work_struct *work)
>  {
>  	struct rcu_work *rcu_work =3D to_rcu_work(work);
> @@ -5003,6 +5050,7 @@ static void scx_sched_free_rcu_work(struct work_str=
uct *work)
> =20
>  	rhashtable_free_and_destroy(&sch->dsq_hash, NULL, NULL);
>  	free_exit_info(sch->exit_info);
> +	scx_set_cmask_scratch_free(sch);
>  	scx_arena_pool_destroy(sch);
>  	if (sch->arena_map)
>  		bpf_map_put(sch->arena_map);
> @@ -7162,6 +7210,12 @@ static void scx_root_enable_workfn(struct kthread_=
work *work)
>  		goto err_disable;
>  	}
> =20
> +	ret =3D scx_set_cmask_scratch_alloc(sch);
> +	if (ret) {
> +		cpus_read_unlock();
> +		goto err_disable;
> +	}
> +
>  	for (i =3D SCX_OPI_CPU_HOTPLUG_BEGIN; i < SCX_OPI_CPU_HOTPLUG_END; i++)
>  		if (((void (**)(void))ops)[i])
>  			set_bit(i, sch->has_op);
> @@ -7484,6 +7538,10 @@ static void scx_sub_enable_workfn(struct kthread_w=
ork *work)
>  	if (ret)
>  		goto err_disable;
> =20
> +	ret =3D scx_set_cmask_scratch_alloc(sch);
> +	if (ret)
> +		goto err_disable;
> +
>  	if (validate_ops(sch, ops))
>  		goto err_disable;
> =20
> diff --git a/kernel/sched/ext_cid.c b/kernel/sched/ext_cid.c
> index 0c91b951fd33..808c6390da5a 100644
> --- a/kernel/sched/ext_cid.c
> +++ b/kernel/sched/ext_cid.c
> @@ -7,14 +7,6 @@
>   */
>  #include <linux/cacheinfo.h>
> =20
> -/*
> - * Per-cpu scratch cmask used by scx_call_op_set_cpumask() to synthesize=
 a
> - * cmask from a cpumask. Allocated alongside the cid arrays on first ena=
ble
> - * and never freed. Sized to the full cid space. Caller holds rq lock so
> - * this_cpu_ptr is safe.
> - */
> -struct scx_cmask __percpu *scx_set_cmask_scratch;
> -
>  /*
>   * cid tables.
>   *
> @@ -54,8 +46,6 @@ static s32 scx_cid_arrays_alloc(void)
>  	u32 npossible =3D num_possible_cpus();
>  	s16 *cid_to_cpu, *cpu_to_cid;
>  	struct scx_cid_topo *cid_topo;
> -	struct scx_cmask __percpu *set_cmask_scratch;
> -	s32 cpu;
> =20
>  	if (scx_cid_to_cpu_tbl)
>  		return 0;
> @@ -63,25 +53,17 @@ static s32 scx_cid_arrays_alloc(void)
>  	cid_to_cpu =3D kzalloc_objs(*scx_cid_to_cpu_tbl, npossible, GFP_KERNEL)=
;
>  	cpu_to_cid =3D kzalloc_objs(*scx_cpu_to_cid_tbl, nr_cpu_ids, GFP_KERNEL=
);
>  	cid_topo =3D kmalloc_objs(*scx_cid_topo, npossible, GFP_KERNEL);
> -	set_cmask_scratch =3D __alloc_percpu(struct_size(set_cmask_scratch, bit=
s,
> -						       SCX_CMASK_NR_WORDS(npossible)),
> -					   sizeof(u64));
> =20
> -	if (!cid_to_cpu || !cpu_to_cid || !cid_topo || !set_cmask_scratch) {
> +	if (!cid_to_cpu || !cpu_to_cid || !cid_topo) {
>  		kfree(cid_to_cpu);
>  		kfree(cpu_to_cid);
>  		kfree(cid_topo);
> -		free_percpu(set_cmask_scratch);
>  		return -ENOMEM;
>  	}
> =20
>  	WRITE_ONCE(scx_cid_to_cpu_tbl, cid_to_cpu);
>  	WRITE_ONCE(scx_cpu_to_cid_tbl, cpu_to_cid);
>  	WRITE_ONCE(scx_cid_topo, cid_topo);
> -	for_each_possible_cpu(cpu)
> -		scx_cmask_init(per_cpu_ptr(set_cmask_scratch, cpu),
> -			       0, npossible);
> -	WRITE_ONCE(scx_set_cmask_scratch, set_cmask_scratch);
>  	return 0;
>  }
> =20
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index ff7e882bd67a..9bb65367f510 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -1124,6 +1124,14 @@ struct scx_sched {
>  	struct bpf_map		*arena_map;
>  	struct gen_pool		*arena_pool;
> =20
> +	/*
> +	 * Per-CPU arena cmask used by scx_call_op_set_cpumask() to hand a cmas=
k
> +	 * to ops_cid.set_cmask(). The kernel writes through the stored kern_va=
;
> +	 * the BPF-arena uaddr handed to BPF is recovered by subtracting the
> +	 * arena's kern_vm_start.
> +	 */
> +	struct scx_cmask * __percpu *set_cmask_scratch;
> +
>  	DECLARE_BITMAP(has_op, SCX_OPI_END);
> =20
>  	/*
> @@ -1480,8 +1488,6 @@ enum scx_ops_state {
>  extern struct scx_sched __rcu *scx_root;
>  DECLARE_PER_CPU(struct rq *, scx_locked_rq_state);
> =20
> -extern struct scx_cmask __percpu *scx_set_cmask_scratch;
> -
>  /*
>   * True when the currently loaded scheduler hierarchy is cid-form. All s=
cheds
>   * in a hierarchy share one form, so this single key tells callsites whi=
ch
> diff --git a/tools/sched_ext/include/scx/cid.bpf.h b/tools/sched_ext/incl=
ude/scx/cid.bpf.h
> index e281c88fa824..70f2a3829af4 100644
> --- a/tools/sched_ext/include/scx/cid.bpf.h
> +++ b/tools/sched_ext/include/scx/cid.bpf.h
> @@ -675,56 +675,4 @@ static __always_inline void cmask_from_cpumask(struc=
t scx_cmask __arena *m,
>  	}
>  }
> =20
> -/**
> - * cmask_copy_from_kernel - probe-read a kernel cmask into an arena cmas=
k
> - * @dst: arena cmask to fill; must have @dst->base =3D=3D 0 and be sized=
 for @src.
> - * @src: kernel-memory cmask (e.g. ops.set_cmask() arg); @src->base must=
 be 0.
> - *
> - * Word-for-word copy; @src and @dst must share base 0 alignment. Trigge=
rs
> - * scx_bpf_error() on probe failure or precondition violation.
> - */
> -static __always_inline void cmask_copy_from_kernel(struct scx_cmask __ar=
ena *dst,
> -						   const struct scx_cmask *src)
> -{
> -	u32 base =3D 0, nr_cids =3D 0, nr_words, wi;
> -
> -	if (dst->base !=3D 0) {
> -		scx_bpf_error("cmask_copy_from_kernel requires dst->base =3D=3D 0");
> -		return;
> -	}
> -
> -	if (bpf_probe_read_kernel(&base, sizeof(base), &src->base)) {
> -		scx_bpf_error("probe-read cmask->base failed");
> -		return;
> -	}
> -	if (base !=3D 0) {
> -		scx_bpf_error("cmask_copy_from_kernel requires src->base =3D=3D 0");
> -		return;
> -	}
> -
> -	if (bpf_probe_read_kernel(&nr_cids, sizeof(nr_cids), &src->nr_cids)) {
> -		scx_bpf_error("probe-read cmask->nr_cids failed");
> -		return;
> -	}
> -
> -	if (nr_cids > dst->nr_cids) {
> -		scx_bpf_error("src cmask nr_cids=3D%u exceeds dst nr_cids=3D%u",
> -			      nr_cids, dst->nr_cids);
> -		return;
> -	}
> -
> -	nr_words =3D CMASK_NR_WORDS(nr_cids);
> -	cmask_zero(dst);
> -	bpf_for(wi, 0, CMASK_MAX_WORDS) {
> -		u64 word =3D 0;
> -		if (wi >=3D nr_words)
> -			break;
> -		if (bpf_probe_read_kernel(&word, sizeof(u64), &src->bits[wi])) {
> -			scx_bpf_error("probe-read cmask->bits[%u] failed", wi);
> -			return;
> -		}
> -		dst->bits[wi] =3D word;
> -	}
> -}
> -
>  #endif /* __SCX_CID_BPF_H */
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index 7e77f22674ea..8a2d6a8ebd8e 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -919,14 +919,15 @@ void BPF_STRUCT_OPS(qmap_update_idle, s32 cid, bool=
 idle)
>  }
> =20
>  void BPF_STRUCT_OPS(qmap_set_cmask, struct task_struct *p,
> -		    const struct scx_cmask *cmask)
> +		    const struct scx_cmask *cmask_in)
>  {
> +	struct scx_cmask __arena *cmask =3D (struct scx_cmask __arena *)(long)c=
mask_in;
>  	task_ctx_t *taskc;
> =20
>  	taskc =3D lookup_task_ctx(p);
>  	if (!taskc)
>  		return;
> -	cmask_copy_from_kernel(&taskc->cpus_allowed, cmask);
> +	cmask_copy(&taskc->cpus_allowed, cmask);
>  }
> =20
>  struct monitor_timer {

