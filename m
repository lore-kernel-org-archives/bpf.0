Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A67B38330E
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088532; cv=none; b=OGwh8FHQwHu2dLS+toZKJZkBs6ryj62dxAHurd10VMQoisQFJZcKS//BHuFWHVnKiS8XujWcR6EJuuPu7SHOv/sYN39HHIEqU6P4bazxS/ltnNJsUIVp50pBekCP/TsSPCC/Vtyuw/s/ScJyC4thQKbgmEB036ixHl+n3wfCHSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088532; c=relaxed/simple;
	bh=FtokXmfdkztz0xbosmaFjROXLJa1sTBxuBqsiXBvCIY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=axHXApd/0gDCjxns5tqEg89KP7kjLFf3tkjT6C/6dx1uOSk4gLh3BxZYtN9kcq4jNNSyZdLpBysBxKBaIfbD4Bc47AauGJUbwBcGLuk5YIL5IJkrGLkL6+akLrkCgOTPjOdqxTLwrIr7nJJAfZ83pS2ALCi34Kl+PjMrqlr14gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmnjodIO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmnjodIO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D534C1F000E9;
	Fri,  7 Aug 2026 07:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786088531;
	bh=RQArX7PGhQ+LViffrtkmmGUW/K9LMkxws/TFDd4tUq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UmnjodIOguanflQxdsOD9hjjXQ2H2WxHe7hVKX+14ziba0+8TVqkdxTdUaqH2h7gh
	 NNYOaWhsq5YeMRS9SiHT8YInHBBqvHMOgFcAsuk+fK5pk8cZE0Fjw1oF9tfVHZLCip
	 v7vTG+j5BMB3h9eWPRYd3w2+aOK7vE5vCkdE+2+dzRSgCl88RSbm8tu94I6yMQUK3v
	 uc30LNpQFozz9lSQwQ3ejJmV1xfl42hKHs5ozL5o67iqTpDDe89l2thgUEHs/YRZGh
	 oCqW/SljGQI5eQFeNdxLxOVZR/BYr4T2RKg29Pex0zZyOvHisSfuIrYOVhmaDi0pjY
	 SeZb5F174z7vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/4] bpf: add bpf_thread_wq kthread-backed
 workqueue with cgroup placement
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org, hannes@cmpxchg.org, tj@kernel.org, mkoutny@suse.com
In-Reply-To: <cfb06f2626062fa60efbbd9d34089819b1a34522.1786086076.git.zhuhui@kylinos.cn>
References: <cover.1786086076.git.zhuhui@kylinos.cn>
 <cfb06f2626062fa60efbbd9d34089819b1a34522.1786086076.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 07:42:10 +0000
Message-Id: <20260807074210.D534C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] The verifier fails to validate KF_ARG_PTR_TO_THREAD_WQ pointer=
s for type correctness and exact struct offset.
- [High] bpf_thread_wq_cancel_and_free() calls sleepable functions but is i=
nvoked synchronously from atomic contexts during map element updates.
- [High] bpf_thread_wq_start() acquires a raw spinlock but is exposed to NM=
I context tracing programs, leading to hard deadlocks.
--

--- Patch [2]: [PATCH bpf-next 2/4] bpf: add bpf_thread_wq kthread-backed w=
orkqueue with cgroup placement ---
commit 287b8c7d2c6aff4fceb91479e0723ac87382505d
Author: Hui Zhu <zhuhui@kylinos.cn>

bpf: add bpf_thread_wq kthread-backed workqueue with cgroup placement

Introduce bpf_thread_wq, a new BPF embedded map field similar to
bpf_wq but backed by a dedicated kthread_worker instead of a system
workqueue. The worker kthread can be attached to a specific cgroup at
init time so BPF-deferred callbacks run under the resource limits of
the target cgroup.

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
[ ... ]
> @@ -502,6 +511,7 @@ static inline bool btf_field_is_nmi_safe(enum btf_fie=
ld_type type)
>  	case BPF_TASK_WORK:
>  	case BPF_KPTR_UNREF:
>  	case BPF_REFCOUNT:
> +	case BPF_THREAD_WQ:
>  		return true;
>  	default:
>  		return false;

[Severity: High]
Will this allow NMI tracing programs to deadlock the system?

By returning true here, the verifier permits bpf_thread_wq in NMI contexts.
However, bpf_thread_wq_start() invokes kthread_queue_work(), which acquires=
 a
raw spinlock. If an NMI interrupts a CPU that already holds this lock, the
NMI handler will spin forever waiting for it.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
[ ... ]
> @@ -839,6 +848,9 @@ void bpf_obj_free_fields(const struct btf_record *rec=
, void *obj)
>  		case BPF_TASK_WORK:
>  			bpf_task_work_cancel_and_free(field_ptr);
>  			break;
> +		case BPF_THREAD_WQ:
> +			bpf_thread_wq_cancel_and_free(field_ptr);
> +			break;
>  		case BPF_KPTR_UNREF:
>  			WRITE_ONCE(*(u64 *)field_ptr, 0);
>  			break;

[Severity: High]
Can this trigger a scheduling while atomic regression?

When a BPF program updates an existing map element, the BPF subsystem invok=
es
bpf_obj_free_fields() to tear down old special fields in-place. This update
path can run in atomic contexts, such as under rcu_read_lock() or with
preemption disabled.

Since bpf_thread_wq_cancel_and_free() explicitly calls might_sleep() and the
blocking kthread_cancel_work_sync(), calling it from this atomic context se=
ems
like it would result in a scheduling bug or deadlock.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -12192,6 +12219,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_call_arg_me
>  		case KF_ARG_PTR_TO_WORKQUEUE:
>  		case KF_ARG_PTR_TO_TIMER:
>  		case KF_ARG_PTR_TO_TASK_WORK:
> +		case KF_ARG_PTR_TO_THREAD_WQ:
>  		case KF_ARG_PTR_TO_IRQ_FLAG:
>  		case KF_ARG_PTR_TO_RES_SPIN_LOCK:
>  			break;

[Severity: Critical]
Does this code leave the thread workqueue pointer unvalidated?

This adds the argument type to the initial bypass switch statement in
check_kfunc_args(), but there does not appear to be a corresponding addition
in the subsequent switch statement that validates the pointer's map origin
and offset.

For example, KF_ARG_PTR_TO_TASK_WORK handles this via:

check_kfunc_args() {
    ...
    case KF_ARG_PTR_TO_TASK_WORK:
        if (reg->type !=3D PTR_TO_MAP_VALUE) { ... }
        ret =3D check_map_field_pointer(env, reg, argno, BPF_TASK_WORK, ...=
);
    ...
}

Without a similar check for KF_ARG_PTR_TO_THREAD_WQ, it looks like a crafted
pointer could bypass offset validation, allowing the kfuncs to cast and
dereference invalid memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786086076.gi=
t.zhuhui@kylinos.cn?part=3D2
