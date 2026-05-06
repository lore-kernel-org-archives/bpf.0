Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B176226D4F7
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778085836; cv=none; b=iXSXkLm+SwjrurDaDjmdRILazouodPC2wTYXks/sG3EjStqLrVsTxEs+b0dMgazFF8DkzgdZ9eoUL0TEWuh8TFIh5Va1xBI+zTvsR2UUYHKFOTKtME6uP5JhN0E6PcYobrejck0vuaLkVWRJFk1C49Kl/mHOohBG5O6o7tjoWcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778085836; c=relaxed/simple;
	bh=D5ha+ObNU/U/2rRik741HrNzWP8Cr8ECPiCKLOE7CdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udppM5vrdjIA08Ib20l5D2ND5VuGJKNxIiu7ak4PBGou540r14S4oJFLW30si8oUo3jX3xYsQx6iqQyQrhfurlLCwR8YR+61OkZBzCEn2qhXhlUFoORKRxr/2WY6biHTYm3hpiUGD4HBzrQe9Yzx0UAfefbLdpM46cus3Pu9r20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmIcQAG2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmIcQAG2"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43fe608cb92so3987197f8f.2
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 09:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778085833; x=1778690633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNS0Q02FFSOMnNRkpXuHZRAVEzlAEKvSPB2zcbyC/C8=;
        b=BmIcQAG2tvQc3sLDrfPmBKNWYE2sl9p0Lu9Un0DojoH+q60dk10aORjseijNRYShGV
         39+jnlofycMI7fXqUbQZV1XmVUWRYz30I16PJsHcIeLApmQzofs+wfIXqeokXAf7tSHm
         pGKS4vgJTbMNTC2UDmOw+Gcaf+ioKgMZ9hE286bV9aDLXweSJ9zGn+Qv3Q765Kqs8emH
         RD0HFNUzCck5IOsSiMkvRoy2rFuXUCggnyQUZ2f9SQOOjqpEG8osnytVxXRdOeGr3w1I
         hwDn5RMLgosAauCofoiI8qnOhOoxx/y2UHNRCo7xWTXLGwYj+H8NSVgz5Bot2tqqPGJf
         jnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778085833; x=1778690633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zNS0Q02FFSOMnNRkpXuHZRAVEzlAEKvSPB2zcbyC/C8=;
        b=WrnVNAJDecSMotjZCpIXPzrm68mdQOGdSIyHG/CRPsJ4Pc2y/HJrLwMpG9sjjFyUBG
         haKuVS5oTeP9WyWWRN40Eod6izbesl+n3PdZ7ZIrTcEiMnG2E5EIcyTGaDsq8XIeI2Vs
         BnnVJATWErqHrMi4MHNw50fjvAI+LpSUy7XhjbiLm+XR8sNRsywVaxRTGGmsg3Blckij
         t9HjVy9QMYnG3LKSnNmq8YV1ze4Sh9jWcDbKJ+BxCunoCFX2UZZSEFe3p8/2HQF78MD/
         io43NCurZgZuE5VGwNZe4WySpMhXyeNAY5PU1vBSkx/as8ElgYViOcTEd5YtH9h8MI2U
         Iq0w==
X-Forwarded-Encrypted: i=1; AFNElJ/CZw1/EntkO6LTn/bAB0b6xiIaXiL6AMHtohnwneL6L/apennE2kjh9VCxlCtgV/PUP4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhRfG5UxHtPhLAV98eaW4ld1zmsowCqeVRv3TCmDKgW1hkHJxg
	4Ict7r1nE/i+yT2ngTE2az/vokawzl716Ii54JyQY+UpPVL8NfwIyIz+
X-Gm-Gg: AeBDiet78hTjdZvV2a8oSj/FB7hZu1mpxIXPNPJeTQ9TXc4W6IUB/UcmshxkCnsK2+O
	/XO7Hio9RGAmtWYg0dxzRpOTuU7Ure6wyngCLGZ+Z/8bwF7MRVfud/RIYuEJiTd4MoAPpWTQ9X8
	dNo1AlZ72ldlKdOMXC4b6+y9Mf1zJWQHHkbiPX4Xa8MecU3uWFJ8qy9V23Z7ba6nGDGDbc4ZCqL
	SdOr0MlPox/2Mqt47fkKtPVrOYxWXWR2zGCPmeN6SwBHKpxkM/u+PFjKLvmfPqbcjH7QYcbvxTt
	IizT91ftPYjhfm7MWllpoo6QRu4nT03VIH9EtlDF9KDc56Cp+CjMO2C9vQblBrWxZPK9+O0eMlI
	jeg28lqO1oyIqQWIyiLzMqnMM/qO5aT25HF0+cGJO+eoQtPyw+lldbcRb0QGxrqlHunngeCnu40
	2Qcm6WMwqUSgulqX/yhveEikEGPJP3VVgbAukOMEscJSXDAC2P3DOjjg88TsammCwvrNTGJgpsR
	Kv9ULPh94u9iJPKIJmsdS3L3zOs9wUh
X-Received: by 2002:a5d:5d89:0:b0:449:4079:4c39 with SMTP id ffacd0b85a97d-4515d5c5750mr7016791f8f.29.1778085832677;
        Wed, 06 May 2026 09:43:52 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960aa2sm13215661f8f.29.2026.05.06.09.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 09:43:52 -0700 (PDT)
Message-ID: <51a054a0-e57f-49dc-9527-36da0535087c@gmail.com>
Date: Wed, 6 May 2026 17:43:51 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf-next v2 1/2] bpf: Offload kptr destructors that run from NMI
To: Justin Suess <utilityemal77@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, bpf@vger.kernel.org, mic@digikod.net,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20260505150851.3090688-1-utilityemal77@gmail.com>
 <20260505150851.3090688-2-utilityemal77@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260505150851.3090688-2-utilityemal77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/5/26 4:08 PM, Justin Suess wrote:
> A BPF program attached to tp_btf/nmi_handler can delete map entries or
> swap out referenced kptrs from NMI context. Today that runs the kptr
> destructor inline. Destructors such as bpf_cpumask_release() can take
> RCU-related locks, so running them from NMI can deadlock the system.
> 
> Preallocate offload jobs from the global BPF memory allocator, track the
> number of live destructor-backed references so the pool stays ahead of
> NMI frees, and let the worker invoke the destructor after NMI exits.
> 
> The algorithm for preallocation is simple: The invariant is total >=
> refs + active, where refs = the ref kptrs installed in maps, active =
> jobs being executed in the irq_work worker, and total is the number of
> job structures allocated. To avoid excessive pre-allocation calls while
> maintaining the invariant, we allocate the needed slots, plus a small
> amount of extra, min(needed, BPF_DTOR_KPTR_RESERVE_HEADROOM), where
> BPF_DTOR_KPTR_RESERVE_HEADROOM is 64 in this patch.
> 
> A small but harmless ordering subtlety: the active atomic is read before
> refs. This can result in a small amount of over allocation, but this
> won't be leaked and will properly be carried into the trim stage.
> 
> The trim stage is simple. It uses a CAS loop to free excessive leftover
> idle job slots. It snapshots total refs and active, pops an idle job if
> the pool is excessively large, and attempts a cmpxhg to decrement it
> atomically. On a failure case, it will just push the job back into the
> idle list and retry.
> 
> There are several best-effort mitigation methods to tackle the memory
> pressure problem, preserving integrity under this unlikely scenario.
> 
> If reserving another offload slot fails while installing a new
> destructor-backed kptr through bpf_kptr_xchg(), leave the destination
> unchanged and return the incoming pointer so the caller keeps ownership.
> 
> This is superior to leaking the pointer, and should only happen if the
> accounting is incorrect. Moreover, this is a condition the caller can
> check for and recover from.
> 
> If NMI teardown still fails to grab an idle offload job despite that
> reserve accounting, warn once and run the destructor inline rather than
> leak the object permanently. Attempt to repair the counter safely with
> another CAS loop in that case, preserving concurrent increments.
> 
> This fix does come with small performance tradeoffs for safety. xchg can
> no longer be inlined for referenced kptrs, as inlining would break the
> reference counting. The inlining fix is preserved for kptrs with no
> destructor defined.
> 
> This keeps refcounted kptr teardown out of NMI context without slowing
> down raw kptr exchanges that never need destructor handling.
> 
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Reported-by: Justin Suess <utilityemal77@gmail.com>
> Closes: https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@gmail.com/
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>  include/linux/bpf.h          |  16 ++++
>  include/linux/bpf_verifier.h |   1 +
>  kernel/bpf/fixups.c          |  33 ++++---
>  kernel/bpf/helpers.c         |  24 ++++-
>  kernel/bpf/syscall.c         | 181 +++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c        |   2 +
>  6 files changed, 242 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 715b6df9c403..307de5caa646 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3454,6 +3454,22 @@ static inline struct bpf_prog *bpf_prog_get_type(u32 ufd,
>  
>  void __bpf_free_used_maps(struct bpf_prog_aux *aux,
>  			  struct bpf_map **used_maps, u32 len);
> +/* Direct-call target used by fixups for bpf_kptr_xchg() sites without dtors. */
> +u64 bpf_kptr_xchg_nodtor(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +int bpf_kptr_offload_inc(void);
> +void bpf_kptr_offload_dec(void);
> +#else
> +static inline int bpf_kptr_offload_inc(void)
> +{
> +	return 0;
> +}
> +
> +static inline void bpf_kptr_offload_dec(void)
> +{
> +}
> +#endif
>  
>  bool bpf_prog_get_ok(struct bpf_prog *, enum bpf_prog_type *, bool);
>  
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 976e2b2f40e8..8e39ff92dd2c 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -672,6 +672,7 @@ struct bpf_insn_aux_data {
>  	bool non_sleepable; /* helper/kfunc may be called from non-sleepable context */
>  	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
>  	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
> +	bool kptr_has_dtor;
>  	u8 alu_state; /* used in combination with alu_limit */
>  	/* true if STX or LDX instruction is a part of a spill/fill
>  	 * pattern for a bpf_fastcall call.
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index fba9e8c00878..459e855e86a5 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -2284,23 +2284,30 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
>  			goto next_insn;
>  		}
>  
> -		/* Implement bpf_kptr_xchg inline */
> -		if (prog->jit_requested && BITS_PER_LONG == 64 &&
> -		    insn->imm == BPF_FUNC_kptr_xchg &&
> -		    bpf_jit_supports_ptr_xchg()) {
> -			insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_2);
> -			insn_buf[1] = BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_1, BPF_REG_0, 0);
> -			cnt = 2;
> +		/* Implement bpf_kptr_xchg inline. */
> +		if (insn->imm == BPF_FUNC_kptr_xchg &&
> +		    !env->insn_aux_data[i + delta].kptr_has_dtor) {
> +			if (prog->jit_requested && BITS_PER_LONG == 64 &&
> +			    bpf_jit_supports_ptr_xchg()) {
> +				insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_2);
> +				insn_buf[1] = BPF_ATOMIC_OP(BPF_DW, BPF_XCHG,
> +						     BPF_REG_1, BPF_REG_0, 0);
> +				cnt = 2;
>  
> -			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> -			if (!new_prog)
> -				return -ENOMEM;
> +				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> +				if (!new_prog)
> +					return -ENOMEM;
>  
> -			delta    += cnt - 1;
> -			env->prog = prog = new_prog;
> -			insn      = new_prog->insnsi + i + delta;
> +				delta    += cnt - 1;
> +				env->prog = prog = new_prog;
> +				insn      = new_prog->insnsi + i + delta;
> +				goto next_insn;
> +			}
> +
> +			insn->imm = bpf_kptr_xchg_nodtor - __bpf_call_base;
>  			goto next_insn;
>  		}
> +
>  patch_call_imm:
>  		fn = env->ops->get_func_proto(insn->imm, env->prog);
>  		/* all functions that have prototype and verifier allowed
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index baa12b24bb64..cdc64ab83ef6 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1728,7 +1728,7 @@ void bpf_wq_cancel_and_free(void *val)
>  	bpf_async_cancel_and_free(val);
>  }
>  
> -BPF_CALL_2(bpf_kptr_xchg, void *, dst, void *, ptr)
> +BPF_CALL_2(bpf_kptr_xchg_nodtor, void *, dst, void *, ptr)
>  {
>  	unsigned long *kptr = dst;
>  
> @@ -1736,12 +1736,32 @@ BPF_CALL_2(bpf_kptr_xchg, void *, dst, void *, ptr)
>  	return xchg(kptr, (unsigned long)ptr);
>  }
>  
> +BPF_CALL_2(bpf_ref_kptr_xchg, void *, dst, void *, ptr)
> +{
> +	unsigned long *kptr = dst;
> +	void *old;
> +
> +	/*
> +	 * If the incoming pointer cannot be torn down safely from NMI later on,
> +	 * leave the destination untouched and return ptr so the caller keeps
> +	 * ownership.
> +	 */
> +	if (ptr && bpf_kptr_offload_inc())
> +		return (unsigned long)ptr;
> +
> +	old = (void *)xchg(kptr, (unsigned long)ptr);
> +	if (old)
> +		bpf_kptr_offload_dec();
> +	return (unsigned long)old;
> +}
> +
>  /* Unlike other PTR_TO_BTF_ID helpers the btf_id in bpf_kptr_xchg()
>   * helper is determined dynamically by the verifier. Use BPF_PTR_POISON to
>   * denote type that verifier will determine.
> + * No-dtor callsites are redirected to bpf_kptr_xchg_nodtor() from fixups.
>   */
>  static const struct bpf_func_proto bpf_kptr_xchg_proto = {
> -	.func         = bpf_kptr_xchg,
> +	.func         = bpf_ref_kptr_xchg,
>  	.gpl_only     = false,
>  	.ret_type     = RET_PTR_TO_BTF_ID_OR_NULL,
>  	.ret_btf_id   = BPF_PTR_POISON,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 3b1f0ba02f61..162bfd4796ea 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -7,6 +7,7 @@
>  #include <linux/bpf_trace.h>
>  #include <linux/bpf_lirc.h>
>  #include <linux/bpf_verifier.h>
> +#include <linux/bpf_mem_alloc.h>
>  #include <linux/bsearch.h>
>  #include <linux/btf.h>
>  #include <linux/hex.h>
> @@ -19,6 +20,8 @@
>  #include <linux/fdtable.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
> +#include <linux/irq_work.h>
> +#include <linux/llist.h>
>  #include <linux/license.h>
>  #include <linux/filter.h>
>  #include <linux/kernel.h>
> @@ -65,6 +68,131 @@ static DEFINE_SPINLOCK(map_idr_lock);
>  static DEFINE_IDR(link_idr);
>  static DEFINE_SPINLOCK(link_idr_lock);
>  
> +struct bpf_dtor_kptr_work {
> +	struct llist_node node;
> +	void *obj;
> +	btf_dtor_kfunc_t dtor;
> +};
> +
> +/* Queue pending dtors per CPU; the idle pool stays global. */
> +static DEFINE_PER_CPU(struct llist_head, bpf_dtor_kptr_jobs);
> +static LLIST_HEAD(bpf_dtor_kptr_idle);
> +/* Keep total >= refs + active so NMI frees never need to allocate. */
> +static atomic_long_t bpf_dtor_kptr_refs = ATOMIC_LONG_INIT(0);
> +static atomic_long_t bpf_dtor_kptr_active = ATOMIC_LONG_INIT(0);
> +static atomic_long_t bpf_dtor_kptr_total = ATOMIC_LONG_INIT(0);
> +
> +/* Bound reserve overshoot so the pool tracks demand instead of growing on itself. */
> +#define BPF_DTOR_KPTR_RESERVE_HEADROOM 64L
> +
> +static void bpf_dtor_kptr_worker(struct irq_work *work);
> +static DEFINE_PER_CPU(struct irq_work, bpf_dtor_kptr_irq_work) =
> +	IRQ_WORK_INIT_HARD(bpf_dtor_kptr_worker);
> +

I think this still looks too complex:
 * 2 lists - idle list and armed list
 * 3 atomics, controlling demand/supply
 * headroom/trimming management

The complexity introduced for performance reasons, but
I'm not sure if the tradeoff is worth it.

What about the next design:

Instead of idle list, store bpf_dtor_kptr_work in the kptr map slot itself.
Use kmalloc_nolock() to allocate bpf_dtor_kptr_work on the first 
xchg just once per map value, then reuse it across xchg in/out.

Detach: When map value is deleted, atomically set kptr map field storing 
bpf_dtor_kptr_work to NULL (so the next xchg-in allocates new 
bpf_dtor_kptr_work.)
After detaching insert bpf_dtor_kptr_work to the global list and run irq_work. 
Free bpf_dtor_kptr_work in call_rcu_tasks_trace().

This is based on the bpf_timer and bpf_task_work
implementations.

> +static void bpf_dtor_kptr_push_idle(struct bpf_dtor_kptr_work *job)
> +{
> +	llist_add(&job->node, &bpf_dtor_kptr_idle);
> +}
> +
> +static struct bpf_dtor_kptr_work *bpf_dtor_kptr_pop_idle(void)
> +{
> +	struct llist_node *node;
> +
> +	node = llist_del_first(&bpf_dtor_kptr_idle);
> +	if (!node)
> +		return NULL;
> +
> +	return llist_entry(node, struct bpf_dtor_kptr_work, node);
> +}
> +
> +static void bpf_dtor_kptr_trim(void)
> +{
> +	struct bpf_dtor_kptr_work *job;
> +	long total;
> +	long needed;
> +
> +	for (;;) {
> +		total = atomic_long_read(&bpf_dtor_kptr_total);
> +		needed = atomic_long_read(&bpf_dtor_kptr_refs) +
> +			 atomic_long_read(&bpf_dtor_kptr_active);
> +		if (total <= needed)
> +			return;
> +
> +		job = bpf_dtor_kptr_pop_idle();
> +		if (!job)
> +			return;
> +
> +		if (!atomic_long_try_cmpxchg(&bpf_dtor_kptr_total, &total, total - 1)) {
> +			bpf_dtor_kptr_push_idle(job);
> +			continue;
> +		}
> +
> +		bpf_mem_free(&bpf_global_ma, job);
> +	}
> +}
> +
> +static int bpf_dtor_kptr_reserve(long needed)
> +{
> +	struct bpf_dtor_kptr_work *job;
> +	long headroom;
> +	long target;
> +
> +	headroom = min_t(long, needed, BPF_DTOR_KPTR_RESERVE_HEADROOM);
> +	if (check_add_overflow(needed, headroom, &target))
> +		target = needed;
> +
> +	while (atomic_long_read(&bpf_dtor_kptr_total) < target) {
> +		job = bpf_mem_alloc(&bpf_global_ma, sizeof(*job));
> +		if (!job)
> +			return -ENOMEM;
> +		atomic_long_inc(&bpf_dtor_kptr_total);
> +		bpf_dtor_kptr_push_idle(job);
> +	}
> +
> +	return 0;
> +}
> +
> +int bpf_kptr_offload_inc(void)
> +{
> +	long needed;
> +	int err;
> +
> +	if (unlikely(!bpf_global_ma_set))
> +		return -ENOMEM;
> +
> +	/*
> +	 * Read active before incrementing refs so a free path moving one slot from
> +	 * refs to active cannot shrink the reservation snapshot below the steady
> +	 * state we need to cover. Racing results worst case in a larger reservation.
> +	 */
> +	needed = atomic_long_read(&bpf_dtor_kptr_active);
> +	needed += atomic_long_inc_return(&bpf_dtor_kptr_refs);
> +	err = bpf_dtor_kptr_reserve(needed);
> +	if (err)
> +		atomic_long_dec(&bpf_dtor_kptr_refs);
> +
> +	return err;
> +}
> +
> +void bpf_kptr_offload_dec(void)
> +{
> +	long val;
> +
> +	val = atomic_long_dec_return(&bpf_dtor_kptr_refs);
> +	if (!WARN_ON_ONCE(val < 0))
> +		return;
> +
> +	/*
> +	 * Clamp a mismatched decrement back to zero without overwriting a
> +	 * concurrent increment that already repaired the counter.
> +	 */
> +	do {
> +		val = atomic_long_read(&bpf_dtor_kptr_refs);
> +		if (val >= 0)
> +			break;
> +	} while (!atomic_long_try_cmpxchg(&bpf_dtor_kptr_refs, &val, 0));
> +}
> +
>  int sysctl_unprivileged_bpf_disabled __read_mostly =
>  	IS_BUILTIN(CONFIG_BPF_UNPRIV_DEFAULT_OFF) ? 2 : 0;
>  
> @@ -807,6 +935,46 @@ void bpf_obj_free_task_work(const struct btf_record *rec, void *obj)
>  	bpf_task_work_cancel_and_free(obj + rec->task_work_off);
>  }
>  
> +static void bpf_dtor_kptr_worker(struct irq_work *work)
> +{
> +	struct llist_node *jobs, *node, *next;
> +
> +	jobs = llist_del_all(this_cpu_ptr(&bpf_dtor_kptr_jobs));
> +	llist_for_each_safe(node, next, jobs) {
> +		struct bpf_dtor_kptr_work *job;
> +
> +		job = llist_entry(node, struct bpf_dtor_kptr_work, node);
> +		job->dtor(job->obj);
> +		atomic_long_dec(&bpf_dtor_kptr_active);
> +		bpf_dtor_kptr_push_idle(job);
> +	}
> +
> +	bpf_dtor_kptr_trim();
> +}
> +
> +static void bpf_dtor_kptr_offload(void *obj, btf_dtor_kfunc_t dtor)
> +{
> +	struct bpf_dtor_kptr_work *job;
> +
> +	atomic_long_inc(&bpf_dtor_kptr_active);
> +	job = bpf_dtor_kptr_pop_idle();
> +	if (WARN_ON_ONCE(!job)) {
> +		atomic_long_dec(&bpf_dtor_kptr_active);
> +		/*
> +		 * This should stay unreachable if reserve accounting is correct. If it
> +		 * ever breaks, running the destructor unsafely is still better than
> +		 * leaking the object permanently.
> +		 */
> +		dtor(obj);
> +		return;
> +	}
> +
> +	job->obj = obj;
> +	job->dtor = dtor;
> +	if (llist_add(&job->node, this_cpu_ptr(&bpf_dtor_kptr_jobs)))
> +		irq_work_queue(this_cpu_ptr(&bpf_dtor_kptr_irq_work));
> +}
> +
>  void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>  {
>  	const struct btf_field *fields;
> @@ -842,6 +1010,19 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>  			xchgd_field = (void *)xchg((unsigned long *)field_ptr, 0);
>  			if (!xchgd_field)
>  				break;
> +			if (in_nmi() && field->kptr.dtor) {
> +				bpf_dtor_kptr_offload(xchgd_field, field->kptr.dtor);
> +				bpf_kptr_offload_dec();
> +				break;
> +			}
> +			if (field->kptr.dtor)
> +				/*
> +				 * Dtor kptrs reach storage through bpf_ref_kptr_xchg(), which
> +				 * pairs installation with bpf_kptr_offload_inc(). Drop that
> +				 * reservation on non-NMI teardown once no active transition is
> +				 * needed.
> +				 */
> +				bpf_kptr_offload_dec();
>  
>  			if (!btf_is_kernel(field->kptr.btf)) {
>  				pointee_struct_meta = btf_find_struct_meta(field->kptr.btf,
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 11054ad89c14..2c7b21bda666 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9950,6 +9950,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  		if (err)
>  			return err;
>  	}
> +	env->insn_aux_data[insn_idx].kptr_has_dtor =
> +		func_id == BPF_FUNC_kptr_xchg && !!meta.kptr_field->kptr.dtor;
>  
>  	err = record_func_map(env, &meta, func_id, insn_idx);
>  	if (err)

