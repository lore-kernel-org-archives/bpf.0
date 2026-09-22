Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D05285CAA
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041983; cv=none; b=o9cJo/4SnYgxl3jQzUSWOpR10LF/1/SPKHBBgXJc3j8BPtN1h3koHQEv/ieu1XwRGknb3r4kFKws4aJE4Vh8z5xjWWh9MkmUB+fE8PbVlPP+nk00Jancq/iRm+jUrYwUQiLXx0dQaF6Dx7qDVgkD3sG6eqFTajywUQWO0l1z21w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041983; c=relaxed/simple;
	bh=844BbKCjuK44YIRNTaW+OIbFc5ErzLKeSHq/FS1o2yE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=m2Wxem6gzOjZ9NByVhfMnGxPK5F9OM3A0pzg5Os5U+UvQfz/AqraMgnjQJYEm95R6pAd1N+GBnSa2OteeuZVmQ2KPdve+JzEpPU1DByikEavzrWjuRN4uJmv6/k53Isx6LumBaGwWw3zSAFI+noqeiIMhXU6ul1/mKTMh0ICN2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vu4j0ZQm; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vu4j0ZQm"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea34f01so3170267a12.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790041981; x=1790646781; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=seqMOpxiRBW7YE0oJ3UyuQPvImrdU7NqfNAkSFs7Tu0=;
        b=Vu4j0ZQm7UGCLA9BsGySLu6EHnPxXBqWRgv1MGgU2Gzo6seCTAGvV7FoJNbjDVZFF7
         vTqWvI/72FN6rr4fzZMyQZcmLtCDO7Y8bCxjvJ91eG/KhQ/Kk6qFZAdUSOp/3rfwI4C7
         q+J2/UF50IGTlPf3Y+qJlpgSL/OnNb3GxLwOvr9UVwXgfWDws0q1UE+F+larBXVg+bg4
         shk14wvWdxpZWAIcOvHjGzLEzfb793Im4PpF3LAFWVNpX/o1mOhykNZQGQ8pXh/1jaCg
         R8LOEu/wAr6leRjzAm0IJ2wJvyvvihM3NnroHMvZuggC/PIFiXt9nO+sjs6HSnrVXNUn
         TgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790041981; x=1790646781;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=seqMOpxiRBW7YE0oJ3UyuQPvImrdU7NqfNAkSFs7Tu0=;
        b=IyeBaPpNcAn4+k/kEaqXsfJMyabNlgZk6BO9d5draBx5Td52mT1KWZp644JVyG5b+3
         kdOgca8+cfV0MbwgghCp2UY7GLONmE7eUfYA4tLVNrAbeIpuIxsfNjeHthvGxVurhxr+
         7bEJw0iLtSTIvY3+qhRV1ynfMZo2LC8CWeN1Z8VOHhWwn6lE+OzSOGS/ZvVd0PD5WfvE
         moyjRdg0e4DQ1PciHNtFhj399kLLDLgcjOvMfGhlJCDFKNbkc57jNFW36UvNylgefy/B
         g92/J++g2j+tseP5/G2Ozf2NUXDVNNvfcfg5foFZxd+Ytb1HC/sY4KcNWaI7p2shVM1K
         37pg==
X-Forwarded-Encrypted: i=1; AKwUvBxp1m2HbPIoHmtZDItW7vCJtB5L+9VqgdSKqVSMWCuoGFr4SZ2FfUZ50gOaKXiS2i8dJhI=@vger.kernel.org
X-Gm-Message-State: AFuF++mU+EvPvYPcTrFUR/Q/Atr48MNXaOqsHLeQ+gedKJxN0Qg6I7wi
	nQU5HLMbzgx8E2/3GpUmvWJQrWWPZ0vNtqerad+mLlQIU2pV4N0iprVd
X-Gm-Gg: AYBFou1/zv54k2QftkGcYGGUCnyRzNwvZ4kL+qOtegumoNBjUAfhNEOrt+Y9KtwV9Pl
	Fq/veD0OtWQRp06IGOYNMm/TaNe9ZtJT5OWrpvYxjUZDcDFxP8Gn8s17mJaboNgd+GUyhgH5uQ0
	9S41onyYqvWgi8s/b0J4HMLe3x3F24wTi9Qnz67bI8pHAXdnD5Y+3/l/iNPNG1pfQrEDv7nwKiD
	bZoMV6MiqiW8f2S6b21Q9IVe5biRzO08Un6pOi3iAE8JLpKdGImOPKJl91YuTrgLoyotLHYA88a
	7+D36N7gCh0t+QW5MRvQbN6BT+/HNtUP0dSxPN4HfRVgeA0q2g7YR+TaKOQx6FxN9X4Arevz+9A
	DuDgG51yz70xLR9bIdj7vjlb/x0Tn8jlkGsyx23pJu1uiMAfsq8FCFR41gN3hHUX9OcazB5qSzQ
	cweHU/dHNftHEyu2lfEPjCr0Po153rVApLFf9bwtmLTXcZFEnRT2LgPPRiDJtH87Jdiz/Oe+jL9
	Eac4a9xLs2rw+AtDBr9J6xsnQ3XGsHxYaE/7uDmkZCj4EZgmCFsUgY7/r6L3mbwldluO4KAmREL
	hxokZ5LwEgrJqA==
X-Received: by 2002:a05:6300:68ca:20b0:3dd:a197:edfa with SMTP id adf61e73a8af0-3dda197f7e9mr8111865637.73.1790041981393;
        Mon, 21 Sep 2026 18:53:01 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc756a30002sm67370a12.13.2026.09.21.18.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 18:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 01:53:00 +0000
Message-Id: <DLLGX9F9UG4Q.2YJWNSO4FXT1P@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: Add bpf_call_rcu() kfunc
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>,
 <rcu@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Harry Yoo (Oracle)"
 <harry@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260921191407.1742386-1-puranjay@kernel.org>
 <20260921191407.1742386-2-puranjay@kernel.org>
In-Reply-To: <20260921191407.1742386-2-puranjay@kernel.org>

On Mon Sep 21, 2026 at 7:14 PM UTC, Puranjay Mohan wrote:
> BPF programs that manage their own objects have no way to run their own
> logic once an RCU grace period has elapsed.  bpf_obj_drop() defers a
> free, but returning an index to an allocator or unpinning a resource
> once readers are done has no equivalent.  sched_ext's BPF library works
> around this today by pushing freed nodes onto a list and having a
> userspace thread call membarrier(MEMBARRIER_CMD_GLOBAL) and then run a
> BPF program to reclaim them.
>
> Add:
>
> 	int bpf_call_rcu(struct bpf_rcu_head *rh, void *map,
> 			 int (*callback)(struct bpf_map *map, void *key,
> 					 void *value));
>
> @rh is a struct bpf_rcu_head embedded in a value of @map, so the
> callback runs as callback(map, key, value) for the element it lives in
> and needs no cookie.  A head can only be armed once, which bounds
> outstanding work by the number of elements.
>
> struct bpf_rcu_head holds the callback state inline rather than a
> pointer to it, as bpf_timer, bpf_wq and bpf_task_work do, because there
> is nothing to cancel and so nothing that has to outlive the map value.
> That avoids an allocation and a state machine on the arming path at the
> cost of 64 bytes per element, 48 of which are used today.  Embedding
> struct rcu_head ties part of a uapi struct to a definition outside of
> BPF, which is acceptable here only because it is two pointers, a
> callback and its argument, with no room to grow.
>
> An RCU callback cannot be cancelled, so everything it touches has to
> stay alive until it runs:
>
>   - The callback is the program's text, so arming takes a program
>     reference as bpf_timer, bpf_wq and bpf_task_work do, dropped once
>     the callback returns.  bpf_prog_inc_not_zero() also fails the arm
>     with -EBADF once the program is dying.
>
>   - The map is held by that reference through used_maps.  An inner map
>     is not, so bpf_rcu_head is rejected in one.
>
>   - The field is only accepted in BPF_MAP_TYPE_ARRAY, whose elements
>     are never freed individually.  A hash element can be deleted and
>     recycled while a callback is queued on it.
>
>   - The head is disarmed before the callback runs so it can be armed
>     again from there, which takes a new program reference before the
>     running callback drops its own.  Arming therefore fails with -EPERM
>     once the map is held by neither a process nor bpffs, which is what
>     bpf_timer and bpf_wq do at init time; bpf_task_work uses -EBUSY and
>     additionally cancels, which is not possible here.
>
> bpf_iter hands a program a writable pointer to the live element, which
> would let it overwrite a queued head, so bpf_iter_attach_map() rejects
> maps carrying one.
>
> The callback is verified non-sleepable even when the caller is
> sleepable, and RCU invokes it with BH disabled.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  include/linux/bpf.h            | 10 +++++
>  include/uapi/linux/bpf.h       |  4 ++
>  kernel/bpf/btf.c               |  7 +++
>  kernel/bpf/helpers.c           | 75 +++++++++++++++++++++++++++++++
>  kernel/bpf/map_in_map.c        |  4 ++
>  kernel/bpf/map_iter.c          |  6 +++
>  kernel/bpf/syscall.c           | 11 ++++-
>  kernel/bpf/verifier.c          | 81 +++++++++++++++++++++++++++++++++-
>  tools/include/uapi/linux/bpf.h |  4 ++
>  9 files changed, 199 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index fd22db8bc6c50..e7c5e203edddb 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -215,6 +215,7 @@ enum btf_field_type {
>  	BPF_UPTR       =3D (1 << 11),
>  	BPF_RES_SPIN_LOCK =3D (1 << 12),
>  	BPF_TASK_WORK  =3D (1 << 13),
> +	BPF_RCU_HEAD   =3D (1 << 14),
>  };
> =20
>  enum bpf_cgroup_storage_type {
> @@ -269,6 +270,7 @@ struct btf_record {
>  	int wq_off;
>  	int refcount_off;
>  	int task_work_off;
> +	int rcu_head_off;
>  	struct btf_field fields[];
>  };
> =20
> @@ -374,6 +376,8 @@ static inline const char *btf_field_type_name(enum bt=
f_field_type type)
>  		return "bpf_refcount";
>  	case BPF_TASK_WORK:
>  		return "bpf_task_work";
> +	case BPF_RCU_HEAD:
> +		return "bpf_rcu_head";
>  	default:
>  		WARN_ON_ONCE(1);
>  		return "unknown";
> @@ -414,6 +418,8 @@ static inline u32 btf_field_type_size(enum btf_field_=
type type)
>  		return sizeof(struct bpf_refcount);
>  	case BPF_TASK_WORK:
>  		return sizeof(struct bpf_task_work);
> +	case BPF_RCU_HEAD:
> +		return sizeof(struct bpf_rcu_head);
>  	default:
>  		WARN_ON_ONCE(1);
>  		return 0;
> @@ -448,6 +454,8 @@ static inline u32 btf_field_type_align(enum btf_field=
_type type)
>  		return __alignof__(struct bpf_refcount);
>  	case BPF_TASK_WORK:
>  		return __alignof__(struct bpf_task_work);
> +	case BPF_RCU_HEAD:
> +		return __alignof__(struct bpf_rcu_head);
>  	default:
>  		WARN_ON_ONCE(1);
>  		return 0;
> @@ -480,6 +488,7 @@ static inline void bpf_obj_init_field(const struct bt=
f_field *field, void *addr)
>  	case BPF_KPTR_PERCPU:
>  	case BPF_UPTR:
>  	case BPF_TASK_WORK:
> +	case BPF_RCU_HEAD:
>  		break;
>  	default:
>  		WARN_ON_ONCE(1);
> @@ -925,6 +934,7 @@ enum bpf_arg_type {
>  	ARG_PTR_TO_RB_NODE,	/* pointer to bpf_rb_node */
>  	ARG_PTR_TO_WORKQUEUE,	/* pointer to bpf_wq */
>  	ARG_PTR_TO_TASK_WORK,	/* pointer to bpf_task_work */
> +	ARG_PTR_TO_RCU_HEAD,	/* pointer to bpf_rcu_head */
>  	ARG_PTR_TO_IRQ_FLAG,	/* pointer to saved IRQ flags on the stack */
>  	ARG_PTR_TO_RES_SPIN_LOCK,	/* pointer to bpf_res_spin_lock */
>  	ARG_PTR_TO_CTX_OUT,	/* hook output argument passed through from ctx */
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 6330b7d745c57..eafeba23f5da7 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7611,6 +7611,10 @@ struct bpf_task_work {
>  	__u64 __opaque;
>  } __attribute__((aligned(8)));
> =20
> +struct bpf_rcu_head {
> +	__u64 __opaque[8];
> +} __attribute__((aligned(8)));
> +
>  struct bpf_wq {
>  	__u64 __opaque[2];
>  } __attribute__((aligned(8)));
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 314ecb0e593b0..4a1fa4fbdf4e8 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3696,6 +3696,7 @@ static int btf_get_field_type(const struct btf *btf=
, const struct btf_type *var_
>  		{ BPF_TIMER, "bpf_timer", true },
>  		{ BPF_WORKQUEUE, "bpf_wq", true },
>  		{ BPF_TASK_WORK, "bpf_task_work", true },
> +		{ BPF_RCU_HEAD, "bpf_rcu_head", true },
>  		{ BPF_LIST_HEAD, "bpf_list_head", false },
>  		{ BPF_LIST_NODE, "bpf_list_node", false },
>  		{ BPF_RB_ROOT, "bpf_rb_root", false },
> @@ -3881,6 +3882,7 @@ static int btf_find_field_one(const struct btf *btf=
,
>  	case BPF_RB_NODE:
>  	case BPF_REFCOUNT:
>  	case BPF_TASK_WORK:
> +	case BPF_RCU_HEAD:
>  		ret =3D btf_find_struct(btf, var_type, off, sz, field_type,
>  				      info_cnt ? &info[0] : &tmp);
>  		if (ret < 0)
> @@ -4176,6 +4178,7 @@ struct btf_record *btf_parse_fields(const struct bt=
f *btf, const struct btf_type
>  	rec->wq_off =3D -EINVAL;
>  	rec->refcount_off =3D -EINVAL;
>  	rec->task_work_off =3D -EINVAL;
> +	rec->rcu_head_off =3D -EINVAL;
>  	for (i =3D 0; i < cnt; i++) {
>  		field_type_size =3D btf_field_type_size(info_arr[i].type);
>  		if (info_arr[i].off + field_type_size > value_size) {
> @@ -4219,6 +4222,10 @@ struct btf_record *btf_parse_fields(const struct b=
tf *btf, const struct btf_type
>  			WARN_ON_ONCE(rec->task_work_off >=3D 0);
>  			rec->task_work_off =3D rec->fields[i].offset;
>  			break;
> +		case BPF_RCU_HEAD:
> +			WARN_ON_ONCE(rec->rcu_head_off >=3D 0);
> +			rec->rcu_head_off =3D rec->fields[i].offset;
> +			break;
>  		case BPF_REFCOUNT:
>  			WARN_ON_ONCE(rec->refcount_off >=3D 0);
>  			/* Cache offset for faster lookup at runtime */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 501c7ce35cba9..8a01dd4058a03 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4805,6 +4805,80 @@ __bpf_kfunc int bpf_task_work_schedule_resume(stru=
ct task_struct *task, struct b
>  	return bpf_task_work_schedule(task, tw, map__const_map, callback, aux, =
TWA_RESUME);
>  }
> =20
> +typedef int (*bpf_rcu_callback_t)(struct bpf_map *map, void *key, void *=
value);
> +
> +/* Actual type for struct bpf_rcu_head */
> +struct bpf_rcu_head_kern {
> +	struct rcu_head rcu;
> +	bpf_callback_t callback_fn;
> +	struct bpf_map *map;
> +	struct bpf_prog *prog;
> +	u32 armed;
> +} __aligned(8);
> +
> +static void bpf_rcu_run_callback(struct rcu_head *rcu)
> +{
> +	struct bpf_rcu_head_kern *rh =3D container_of(rcu, struct bpf_rcu_head_=
kern, rcu);
> +	bpf_callback_t callback_fn =3D rh->callback_fn;
> +	struct bpf_prog *prog =3D rh->prog;
> +	struct bpf_map *map =3D rh->map;
> +	void *value, *key;
> +	u32 idx;
> +
> +	value =3D (void *)rh - map->record->rcu_head_off;
> +	key =3D map_key_from_value(map, value, &idx);
> +
> +	/* Pairs with the arming cmpxchg(): rh may be re-armed as soon as this =
store lands. */
> +	smp_store_release(&rh->armed, 0);
> +
> +	rcu_read_lock_dont_migrate();
> +	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
> +	rcu_read_unlock_migrate();
> +
> +	bpf_prog_put(prog);
> +}
> +
> +/**
> + * bpf_call_rcu - Invoke a BPF callback after an RCU grace period
> + * @rh: struct bpf_rcu_head in a BPF map value
> + * @map__const_map: bpf_map that embeds struct bpf_rcu_head in the value=
s
> + * @callback: BPF subprogram, invoked as callback(map, key, value) for t=
he value holding @rh
> + * @aux: bpf_prog_aux of the caller, implicitly set by the verifier
> + *
> + * Return: 0, -EBUSY if @rh is already queued, -EPERM if @map is held by=
 neither a process
> + * nor bpffs, or -EBADF if the calling program is going away.
> + */
> +__bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__const_m=
ap,
> +			     bpf_rcu_callback_t callback, struct bpf_prog_aux *aux)
> +{
> +	struct bpf_rcu_head_kern *rhk =3D (void *)rh;
> +	struct bpf_map *map =3D map__const_map;
> +	struct bpf_prog *prog;
> +
> +	BUILD_BUG_ON(sizeof(struct bpf_rcu_head_kern) > sizeof(struct bpf_rcu_h=
ead));
> +	BUILD_BUG_ON(__alignof__(struct bpf_rcu_head_kern) !=3D __alignof__(str=
uct bpf_rcu_head));
> +	BTF_TYPE_EMIT(struct bpf_rcu_head);
> +
> +	/* A queued callback cannot be cancelled, so a self-rearming one would =
pin prog and map. */
> +	if (!atomic64_read(&map->usercnt))
> +		return -EPERM;
> +
> +	if (cmpxchg(&rhk->armed, 0, 1))
> +		return -EBUSY;
> +
> +	prog =3D bpf_prog_inc_not_zero(aux->prog);
> +	if (IS_ERR(prog)) {
> +		WRITE_ONCE(rhk->armed, 0);
> +		return -EBADF;
> +	}

can we drop prog_inc and remove prog pointer from rhk ?
with something like if (prog->has_call_rcu) rcu_barrier() during prog unloa=
d?

