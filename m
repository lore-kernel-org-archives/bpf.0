Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BF1250BF2
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778172113; cv=none; b=Hru11ax33rXQ4emUBDlZv9RgjAclULoaI1JVnt2PNd23Mj8c0Q8iEV2IDiE5rUXWaA7WgUMgdRoUkydzFhRSrNPRm4RT2QSfp75X9AmbD1jsSZbCYtPARWfqSH/YRQUXJwxdR+URbdIporJBlDfL6Ks9MjtA6fdbCbipRrvBqws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778172113; c=relaxed/simple;
	bh=ihbnNXtPEOMFsUkK7ssSI28wYTK1LF/PdIA+JAFRA40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5HvO7yZixyzsYQ88OUGKEzQjw6CkEwOV6WIuM2NTFSgDh3Qm8E/hpdFHgkZaUCk0hYyZzwDR6iOkcx2gwUb4POyD6yMGxPKJgoHFuOlrhiz5zArLcOUSt//SsSoqWgd+0vBz4l8erNV43yh6tjdcp3Esu1WNGnI5gr5Lr2vtLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oh8wowrn; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oh8wowrn"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65c364b893aso1164495d50.0
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 09:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778172110; x=1778776910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6YWqb7Rd0/UWP3v2bD4ENhG4iVM6+exNcA1g+A5bGOw=;
        b=oh8wowrnSFjBAFJzaTzngQHFOGgnalGYt7R0vwIU6MkWOxgwKlwLwXlr2/rt4IB5t3
         fguu4dtQ7BjHxnG1aBQ0V74bR5o9deDKYtB/LiUoWBAyK8CFdPzB2VxwsjRY2YXHsD/J
         QSMLeMu0jJdIVVq4/ar1em5KvxsU+0ZMH4GytZL19UWXoyqluiSOxRQCWXuFtUcrEjYB
         FGD4dIlcr00TQ4e0kUNLvBu7XCKur+T2wqDxB3W6129wCINazilgD+udpJ8R0xpOCAwJ
         86nq/Vhj+Igowlz4tSB/DU0UU99R3/bJSGa4KwAP9Wyv8J95wGIYHwm85SUJHE/bVYj+
         LGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778172110; x=1778776910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YWqb7Rd0/UWP3v2bD4ENhG4iVM6+exNcA1g+A5bGOw=;
        b=QlvybkNaj6i6tJ6sggwyr1oQmwwcV1kpXop2hgADCCaWKbf1hcLHphNYjcXxrlTLoq
         z9/45YJmhpb8BS1cADrs3GX1K4LuHO2t7TtiSkDBi2HBL5dyl2XvZ5Ze5b70sue2sao8
         JwTyrLJsdEcBIIrwwAgQPGzOdted9kbLxzEk7I9dSnQqzjzqdWB0TYq5qhCrfHC6dGUc
         Ji8jE7HvfiUeA5YH88ry7otqlsgGc52WPpNaCl0cE4AjHf/O5jLnzaDhrD4oAHKG/DiK
         8k/udIsoP6fzdF4akqc6GVsxVwKl2ZEJxcVNrwEvB3JBQg7RX+86e9/FcG9kfrqgYBgB
         /LaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+oLQDo+A6Buo1GJ4J25jU5PPYq3Q6hrsCjEzR3c8veWgKSvD1aeu6YLk/wOGtkLMLvjrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6NAm7NtsJnNNMWnUDtsa0EPa2IBJnyGpa32boP8LK7TXef9m9
	EW0ZGcsoxVNebPyX92srrnvd6gnvKD4z6JN7s8rCeQii4FoKe2+8st2W
X-Gm-Gg: Acq92OEQeuW+9TpItDALmrLIFS/YSFF5J6N3Ab6RqKlZV3B3yOFbngCn+z8ybIQljsZ
	zVYz8bJkzThtKe2qT8b2v0Df3hgZzTxX4N0Q9oblBACwDE5ZCEVv5bMsa9keRwUOQVVkQKnNeZh
	zxP+aYz1lfby3Tr0mYcuSp+ImySL07NFj+UF8dof/hFGsgIWmk5LVZbSMVQq67aWZGlqrdOdTX7
	Pfhm7CHKxkJGNbqkszpA3iiZMcijnJo7vtFPIkUT8HCpXR7eecw+252ACCySrT9ixe6LA4oz0Lh
	pTsk1vpLwdmMlC7Ov0ntRLEM+P8YVe78JcI1T612WTmFgAC6H3dnyGCrciG25wXYmxSVgR3o7H5
	d29DO74+2176c8JMWkG733R2Z4Qz96TQoKSyxFaOlIfI6PdR+FVfqzsE9quo9XtCHWF8IEwIlEQ
	cMdCxRbdP3YCw2VqWynYs++UVA+sTEHaCDd28A6hlg7A0cl9H9t0M4NxTuYGOsCatDAkBZOw==
X-Received: by 2002:a05:690e:1487:b0:651:b214:cb69 with SMTP id 956f58d0204a3-65c79a38456mr8753450d50.65.1778172110058;
        Thu, 07 May 2026 09:41:50 -0700 (PDT)
Received: from suesslenovo ([74.244.55.209])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d9021fa48sm150070d50.15.2026.05.07.09.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:41:49 -0700 (PDT)
Date: Thu, 7 May 2026 12:41:48 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org, mic@digikod.net, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [bpf-next v2 1/2] bpf: Offload kptr destructors that run from NMI
Message-ID: <afy8yl1bleXmO78H@suesslenovo>
References: <20260505150851.3090688-1-utilityemal77@gmail.com>
 <20260505150851.3090688-2-utilityemal77@gmail.com>
 <51a054a0-e57f-49dc-9527-36da0535087c@gmail.com>
 <afucGBvwXMkuU8sG@zenbox>
 <6954a05d-15e0-4e16-8391-78115101547a@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6954a05d-15e0-4e16-8391-78115101547a@gmail.com>

On Thu, May 07, 2026 at 03:59:04PM +0100, Mykyta Yatsenko wrote:
> 
> 
> On 5/6/26 8:52 PM, Justin Suess wrote:
> > On Wed, May 06, 2026 at 05:43:51PM +0100, Mykyta Yatsenko wrote:
> >> On 5/5/26 4:08 PM, Justin Suess wrote:
> >>> A BPF program attached to tp_btf/nmi_handler can delete map entries or
> >>> swap out referenced kptrs from NMI context. Today that runs the kptr
> >>> destructor inline. Destructors such as bpf_cpumask_release() can take
> >>> RCU-related locks, so running them from NMI can deadlock the system.
> >>>
> >>> Preallocate offload jobs from the global BPF memory allocator, track the
> >>> number of live destructor-backed references so the pool stays ahead of
> >>> NMI frees, and let the worker invoke the destructor after NMI exits.
> >>>
> >>> The algorithm for preallocation is simple: The invariant is total >=
> >>> refs + active, where refs = the ref kptrs installed in maps, active =
> >>> jobs being executed in the irq_work worker, and total is the number of
> >>> job structures allocated. To avoid excessive pre-allocation calls while
> >>> maintaining the invariant, we allocate the needed slots, plus a small
> >>> amount of extra, min(needed, BPF_DTOR_KPTR_RESERVE_HEADROOM), where
> >>> BPF_DTOR_KPTR_RESERVE_HEADROOM is 64 in this patch.
> >>>
> >>> A small but harmless ordering subtlety: the active atomic is read before
> >>> refs. This can result in a small amount of over allocation, but this
> >>> won't be leaked and will properly be carried into the trim stage.
> >>>
> >>> The trim stage is simple. It uses a CAS loop to free excessive leftover
> >>> idle job slots. It snapshots total refs and active, pops an idle job if
> >>> the pool is excessively large, and attempts a cmpxhg to decrement it
> >>> atomically. On a failure case, it will just push the job back into the
> >>> idle list and retry.
> >>>
> >>> There are several best-effort mitigation methods to tackle the memory
> >>> pressure problem, preserving integrity under this unlikely scenario.
> >>>
> >>> If reserving another offload slot fails while installing a new
> >>> destructor-backed kptr through bpf_kptr_xchg(), leave the destination
> >>> unchanged and return the incoming pointer so the caller keeps ownership.
> >>>
> >>> This is superior to leaking the pointer, and should only happen if the
> >>> accounting is incorrect. Moreover, this is a condition the caller can
> >>> check for and recover from.
> >>>
> >>> If NMI teardown still fails to grab an idle offload job despite that
> >>> reserve accounting, warn once and run the destructor inline rather than
> >>> leak the object permanently. Attempt to repair the counter safely with
> >>> another CAS loop in that case, preserving concurrent increments.
> >>>
> >>> This fix does come with small performance tradeoffs for safety. xchg can
> >>> no longer be inlined for referenced kptrs, as inlining would break the
> >>> reference counting. The inlining fix is preserved for kptrs with no
> >>> destructor defined.
> >>>
> >>> This keeps refcounted kptr teardown out of NMI context without slowing
> >>> down raw kptr exchanges that never need destructor handling.
> >>>
> >>> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> >>> Reported-by: Justin Suess <utilityemal77@gmail.com>
> >>> Closes: https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@gmail.com/
> >>> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> >>> ---
> >>>  include/linux/bpf.h          |  16 ++++
> >>>  include/linux/bpf_verifier.h |   1 +
> >>>  kernel/bpf/fixups.c          |  33 ++++---
> >>>  kernel/bpf/helpers.c         |  24 ++++-
> >>>  kernel/bpf/syscall.c         | 181 +++++++++++++++++++++++++++++++++++
> >>>  kernel/bpf/verifier.c        |   2 +
> >>>  6 files changed, 242 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >>> index 715b6df9c403..307de5caa646 100644
> >>> --- a/include/linux/bpf.h
> >>> +++ b/include/linux/bpf.h
> >>> @@ -3454,6 +3454,22 @@ static inline struct bpf_prog *bpf_prog_get_type(u32 ufd,
> >>>  
> >>>  void __bpf_free_used_maps(struct bpf_prog_aux *aux,
> >>>  			  struct bpf_map **used_maps, u32 len);
> >>> +/* Direct-call target used by fixups for bpf_kptr_xchg() sites without dtors. */
> >>> +u64 bpf_kptr_xchg_nodtor(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
> >>> +
> >>> +#ifdef CONFIG_BPF_SYSCALL
> >>> +int bpf_kptr_offload_inc(void);
> >>> +void bpf_kptr_offload_dec(void);
> >>> +#else
> >>> +static inline int bpf_kptr_offload_inc(void)
> >>> +{
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static inline void bpf_kptr_offload_dec(void)
> >>> +{
> >>> +}
> >>> +#endif
> >>>  
> >>>  bool bpf_prog_get_ok(struct bpf_prog *, enum bpf_prog_type *, bool);
> >>>  
> >>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> >>> index 976e2b2f40e8..8e39ff92dd2c 100644
> >>> --- a/include/linux/bpf_verifier.h
> >>> +++ b/include/linux/bpf_verifier.h
> >>> @@ -672,6 +672,7 @@ struct bpf_insn_aux_data {
> >>>  	bool non_sleepable; /* helper/kfunc may be called from non-sleepable context */
> >>>  	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
> >>>  	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
> >>> +	bool kptr_has_dtor;
> >>>  	u8 alu_state; /* used in combination with alu_limit */
> >>>  	/* true if STX or LDX instruction is a part of a spill/fill
> >>>  	 * pattern for a bpf_fastcall call.
> >>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> >>> index fba9e8c00878..459e855e86a5 100644
> >>> --- a/kernel/bpf/fixups.c
> >>> +++ b/kernel/bpf/fixups.c
> >>> @@ -2284,23 +2284,30 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
> >>>  			goto next_insn;
> >>>  		}
> >>>  
> >>> -		/* Implement bpf_kptr_xchg inline */
> >>> -		if (prog->jit_requested && BITS_PER_LONG == 64 &&
> >>> -		    insn->imm == BPF_FUNC_kptr_xchg &&
> >>> -		    bpf_jit_supports_ptr_xchg()) {
> >>> -			insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_2);
> >>> -			insn_buf[1] = BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_1, BPF_REG_0, 0);
> >>> -			cnt = 2;
> >>> +		/* Implement bpf_kptr_xchg inline. */
> >>> +		if (insn->imm == BPF_FUNC_kptr_xchg &&
> >>> +		    !env->insn_aux_data[i + delta].kptr_has_dtor) {
> >>> +			if (prog->jit_requested && BITS_PER_LONG == 64 &&
> >>> +			    bpf_jit_supports_ptr_xchg()) {
> >>> +				insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_2);
> >>> +				insn_buf[1] = BPF_ATOMIC_OP(BPF_DW, BPF_XCHG,
> >>> +						     BPF_REG_1, BPF_REG_0, 0);
> >>> +				cnt = 2;
> >>>  
> >>> -			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> >>> -			if (!new_prog)
> >>> -				return -ENOMEM;
> >>> +				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> >>> +				if (!new_prog)
> >>> +					return -ENOMEM;
> >>>  
> >>> -			delta    += cnt - 1;
> >>> -			env->prog = prog = new_prog;
> >>> -			insn      = new_prog->insnsi + i + delta;
> >>> +				delta    += cnt - 1;
> >>> +				env->prog = prog = new_prog;
> >>> +				insn      = new_prog->insnsi + i + delta;
> >>> +				goto next_insn;
> >>> +			}
> >>> +
> >>> +			insn->imm = bpf_kptr_xchg_nodtor - __bpf_call_base;
> >>>  			goto next_insn;
> >>>  		}
> >>> +
> >>>  patch_call_imm:
> >>>  		fn = env->ops->get_func_proto(insn->imm, env->prog);
> >>>  		/* all functions that have prototype and verifier allowed
> >>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >>> index baa12b24bb64..cdc64ab83ef6 100644
> >>> --- a/kernel/bpf/helpers.c
> >>> +++ b/kernel/bpf/helpers.c
> >>> @@ -1728,7 +1728,7 @@ void bpf_wq_cancel_and_free(void *val)
> >>>  	bpf_async_cancel_and_free(val);
> >>>  }
> >>>  
> >>> -BPF_CALL_2(bpf_kptr_xchg, void *, dst, void *, ptr)
> >>> +BPF_CALL_2(bpf_kptr_xchg_nodtor, void *, dst, void *, ptr)
> >>>  {
> >>>  	unsigned long *kptr = dst;
> >>>  
> >>> @@ -1736,12 +1736,32 @@ BPF_CALL_2(bpf_kptr_xchg, void *, dst, void *, ptr)
> >>>  	return xchg(kptr, (unsigned long)ptr);
> >>>  }
> >>>  
> >>> +BPF_CALL_2(bpf_ref_kptr_xchg, void *, dst, void *, ptr)
> >>> +{
> >>> +	unsigned long *kptr = dst;
> >>> +	void *old;
> >>> +
> >>> +	/*
> >>> +	 * If the incoming pointer cannot be torn down safely from NMI later on,
> >>> +	 * leave the destination untouched and return ptr so the caller keeps
> >>> +	 * ownership.
> >>> +	 */
> >>> +	if (ptr && bpf_kptr_offload_inc())
> >>> +		return (unsigned long)ptr;
> >>> +
> >>> +	old = (void *)xchg(kptr, (unsigned long)ptr);
> >>> +	if (old)
> >>> +		bpf_kptr_offload_dec();
> >>> +	return (unsigned long)old;
> >>> +}
> >>> +
> >>>  /* Unlike other PTR_TO_BTF_ID helpers the btf_id in bpf_kptr_xchg()
> >>>   * helper is determined dynamically by the verifier. Use BPF_PTR_POISON to
> >>>   * denote type that verifier will determine.
> >>> + * No-dtor callsites are redirected to bpf_kptr_xchg_nodtor() from fixups.
> >>>   */
> >>>  static const struct bpf_func_proto bpf_kptr_xchg_proto = {
> >>> -	.func         = bpf_kptr_xchg,
> >>> +	.func         = bpf_ref_kptr_xchg,
> >>>  	.gpl_only     = false,
> >>>  	.ret_type     = RET_PTR_TO_BTF_ID_OR_NULL,
> >>>  	.ret_btf_id   = BPF_PTR_POISON,
> >>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >>> index 3b1f0ba02f61..162bfd4796ea 100644
> >>> --- a/kernel/bpf/syscall.c
> >>> +++ b/kernel/bpf/syscall.c
> >>> @@ -7,6 +7,7 @@
> >>>  #include <linux/bpf_trace.h>
> >>>  #include <linux/bpf_lirc.h>
> >>>  #include <linux/bpf_verifier.h>
> >>> +#include <linux/bpf_mem_alloc.h>
> >>>  #include <linux/bsearch.h>
> >>>  #include <linux/btf.h>
> >>>  #include <linux/hex.h>
> >>> @@ -19,6 +20,8 @@
> >>>  #include <linux/fdtable.h>
> >>>  #include <linux/file.h>
> >>>  #include <linux/fs.h>
> >>> +#include <linux/irq_work.h>
> >>> +#include <linux/llist.h>
> >>>  #include <linux/license.h>
> >>>  #include <linux/filter.h>
> >>>  #include <linux/kernel.h>
> >>> @@ -65,6 +68,131 @@ static DEFINE_SPINLOCK(map_idr_lock);
> >>>  static DEFINE_IDR(link_idr);
> >>>  static DEFINE_SPINLOCK(link_idr_lock);
> >>>  
> >>> +struct bpf_dtor_kptr_work {
> >>> +	struct llist_node node;
> >>> +	void *obj;
> >>> +	btf_dtor_kfunc_t dtor;
> >>> +};
> >>> +
> >>> +/* Queue pending dtors per CPU; the idle pool stays global. */
> >>> +static DEFINE_PER_CPU(struct llist_head, bpf_dtor_kptr_jobs);
> >>> +static LLIST_HEAD(bpf_dtor_kptr_idle);
> >>> +/* Keep total >= refs + active so NMI frees never need to allocate. */
> >>> +static atomic_long_t bpf_dtor_kptr_refs = ATOMIC_LONG_INIT(0);
> >>> +static atomic_long_t bpf_dtor_kptr_active = ATOMIC_LONG_INIT(0);
> >>> +static atomic_long_t bpf_dtor_kptr_total = ATOMIC_LONG_INIT(0);
> >>> +
> >>> +/* Bound reserve overshoot so the pool tracks demand instead of growing on itself. */
> >>> +#define BPF_DTOR_KPTR_RESERVE_HEADROOM 64L
> >>> +
> >>> +static void bpf_dtor_kptr_worker(struct irq_work *work);
> >>> +static DEFINE_PER_CPU(struct irq_work, bpf_dtor_kptr_irq_work) =
> >>> +	IRQ_WORK_INIT_HARD(bpf_dtor_kptr_worker);
> >>> +
> >>
> >> I think this still looks too complex:
> >>  * 2 lists - idle list and armed list
> >>  * 3 atomics, controlling demand/supply
> >>  * headroom/trimming management
> >>
> >> The complexity introduced for performance reasons, but
> >> I'm not sure if the tradeoff is worth it.
> >>
> >> What about the next design:
> >>
> >> Instead of idle list, store bpf_dtor_kptr_work in the kptr map slot itself.
> >> Use kmalloc_nolock() to allocate bpf_dtor_kptr_work on the first 
> >> xchg just once per map value, then reuse it across xchg in/out.
> >>
> > Hello,
> > 
> > Thanks for the feedback.
> > 
> > I tried a different but related approach in [1], my v1, which also
> > stored the work in the map slot (struct bpf_kptr_dtor_aux).
> > 
> >> Detach: When map value is deleted, atomically set kptr map field storing 
> >> bpf_dtor_kptr_work to NULL (so the next xchg-in allocates new 
> >> bpf_dtor_kptr_work.)
> >> After detaching insert bpf_dtor_kptr_work to the global list and run irq_work. 
> >> Free bpf_dtor_kptr_work in call_rcu_tasks_trace().
> > This would be nice to do but there's a sequence where you can delete and
> > insert stimultaniously. Basically an ABBA problem that is inconvienent to
> > deal with, especially in NMI.
> > 
> > Let's say
> > 
> > CPU0 = Deleting value from the map. xchg w/ null.
> > CPU1 = Exchanging new value into the map. xchg w/ something
> > 
> > So I give the two orders we can do it in, zeroing the map slot first or
> > zeroing the work first.
> > 
> > 1. Set obj to null, then null out work
> > 
> > CPU0
> > sets map obj field to null (dtor work is still != null)
> > CPU1
> > sets map obj field to something
> > CPU1 (again)
> > sees that dtor work is still != null, (does nothing, assumes a valid
> > slot was still allocated)
> > CPU0
> > sets dtor work to null and enqueues it in the irq_work.
> > 
> > Then a new dtor work is never allocated for the new slot.
> > 
> > 2. And doing in the other order (nulling out work before the obj)
> > 
> > CPU0
> > sets work to null and enqueues it.
> > CPU1
> > sets work to something (allocates new work)
> > CPU1
> > sets obj to something
> > CPU0
> > sets obj to null.
> > 
> > Then you end up leaking the object set by CPU1.
> 
> I'm not sure I'm following,
> the idea I suggest is next: you place kptr and work struct in the
> same structure:
> 
>   struct bpf_kptr_box {
>         void *kptr;
>         struct bpf_dtor_kptr_work work;
>         struct rcu_head rcu;
>   };
>
Ah I see. Sorry for misinterpreting that. This is less similar to my
initial approach then, and doesn't have this race condition.

There's a seprate problem though:

This essentially makes it so the map stores a pointer to the
bpf_kptr_box object instead of the kptr directly. Map values in BPF
BPF_KPTR_REF fields can be accessed directly, and when you do that,
you're now going to be grabbing our box instead of the object.

In bpf.h 731:

	/* PTR is not trusted. This is only used with PTR_TO_BTF_ID, to mark
	 * unreferenced and referenced kptr loaded from map value using a load
	 * instruction, so that they can only be dereferenced but not escape the
	 * BPF program into the kernel (i.e. cannot be passed as arguments to
	 * kfunc or bpf helpers).
	 */

So while putting a referenced kptr field into a map requires xchg, the
inverse isn't true, you can directly access values in maps as a
PTR_UNTRUSTED.

This box struct would make it so whenever we do a BPF_LDX directly
on a BPF_KPTR_REF field, we're accessing our box struct rather than
the actual kptr. So this would break dereferencing and require every
dereference be made into two dereferences slot-> our box -> our kptr obj.
It would also break the case where we want to compare kptrs directly,
since even though the kptrs might be identical addresses, our box
structs will have seperate ones. So the consequences of changing that
ripple very far.

(Also this would break KF_RCU kfuncs, which can accept directly loaded
kptrs in read side CS / for RCU safe kptrs and require indirection
there).

> Then you can atomically detach/attach it.
> Very schematic implementation:
> 
> unsigned long bpf_ref_kptr_xchg(void *dst, void *ptr)
> {
>         struct bpf_kptr_box **slot = dst;
>         struct bpf_kptr_box *box;
> 
>         box = READ_ONCE(*slot);
> 	if (box)
> 	/* Box can be detached already, but its lifetime and kptr destructor are
> 	 * RCU protected, so it's safe to access it here.
> 	 */
> 		return xchg(&box->kptr, ptr);
> 
>         if (!ptr)
>                 return 0; /* xchg-out from empty: nothing to do */
> 
> 	/* slow path, when map value is not initialized */
>         box = kmalloc_nolock();
>         if (!box)
>                 return (unsigned long)ptr;
> 
>         box->kptr = ptr;
>         if (cmpxchg(slot, NULL, box) != NULL) {
>                 kfree(new_box);
>                 /* someone installed first, retry or error out */
>         }
> 
>         return NULL;
>   }
> 
> Run destructor in rcu tt callback, to make sure no concurrent BPF program 
> is installing kptr in the meantime:
> 
> void box_rcu_free()
> {
> 	dtor();
> 	kfree(box);
> }
> 
> static void box_kill_irq_work(struct irq_work* irq_work)
> {
> 	/* guarantee no BPF program sees the box */
>         call_rcu_tasks_trace(&box->rcu, box_rcu_free);
> }
> 
> Detach path is simply: box = xchg(slot, NULL).
> 
> You can still use a single list where you link detached boxes and
> irq_work similarly as you have now, just make sure dtor and free
> are called after RCU GP.
> 
> I may have missed some race conditions, though, does the idea
> make sense?
>
It does make sense. That does solve the race condition issue, but
basically existing code assumes that the kptr in the map points to a
real live kernel object, so pointing it to a box breaks a lot of
assumptions.

Thanks for the feedback again and appreciate the follow up! This is
interesting to dig into.

I have v3 about ready, and will send in a little bit.

Thanks,
Justin
> > 
> > So either order we do it in 1 or 2, this is an ABBA problem.
> > And would require serialization and/or some sort of lock state
> > for every map slot.
> > 
> > Not to mention the complexity of adding extra data to the map slots
> > requires modifications to every map type. You can see the problem this
> > introduced in my v1, which took a related approach adding auxiliary data
> > to map slots.
> > 
> > ....
> > 
> > FWIW I do have a much less complex implementation for my v3
> > revision which brings it down to a single atomic and two
> > pcpu_freelists, cutting it to 215~ lines net for the whole fix.
> > 
> > Let me know if I missed anything or am misunderstanding something. I
> > really appreciate the feedback though this is a tougher problem than it
> > seemed and your thought was very similar to my initial approach :)
> >>
> >> This is based on the bpf_timer and bpf_task_work
> >> implementations.
> >>
> > Those were some of my initial inspiration as well!
> > 
> > Thanks again,
> > Justin
> > 
> > [1] https://lore.kernel.org/bpf/20260428201422.1518903-1-utilityemal77@gmail.com/
> >>> +static void bpf_dtor_kptr_push_idle(struct bpf_dtor_kptr_work *job)
> >>> +{
> >>> +	llist_add(&job->node, &bpf_dtor_kptr_idle);
> >>> +}
> >>> +
> >>> +static struct bpf_dtor_kptr_work *bpf_dtor_kptr_pop_idle(void)
> >>> +{
> >>> +	struct llist_node *node;
> >>> +
> >>> +	node = llist_del_first(&bpf_dtor_kptr_idle);
> >>> +	if (!node)
> >>> +		return NULL;
> >>> +
> >>> +	return llist_entry(node, struct bpf_dtor_kptr_work, node);
> >>> +}
> >>> +
> >>> +static void bpf_dtor_kptr_trim(void)
> >>> +{
> >>> +	struct bpf_dtor_kptr_work *job;
> >>> +	long total;
> >>> +	long needed;
> >>> +
> >>> +	for (;;) {
> >>> +		total = atomic_long_read(&bpf_dtor_kptr_total);
> >>> +		needed = atomic_long_read(&bpf_dtor_kptr_refs) +
> >>> +			 atomic_long_read(&bpf_dtor_kptr_active);
> >>> +		if (total <= needed)
> >>> +			return;
> >>> +
> >>> +		job = bpf_dtor_kptr_pop_idle();
> >>> +		if (!job)
> >>> +			return;
> >>> +
> >>> +		if (!atomic_long_try_cmpxchg(&bpf_dtor_kptr_total, &total, total - 1)) {
> >>> +			bpf_dtor_kptr_push_idle(job);
> >>> +			continue;
> >>> +		}
> >>> +
> >>> +		bpf_mem_free(&bpf_global_ma, job);
> >>> +	}
> >>> +}
> >>> +
> >>> +static int bpf_dtor_kptr_reserve(long needed)
> >>> +{
> >>> +	struct bpf_dtor_kptr_work *job;
> >>> +	long headroom;
> >>> +	long target;
> >>> +
> >>> +	headroom = min_t(long, needed, BPF_DTOR_KPTR_RESERVE_HEADROOM);
> >>> +	if (check_add_overflow(needed, headroom, &target))
> >>> +		target = needed;
> >>> +
> >>> +	while (atomic_long_read(&bpf_dtor_kptr_total) < target) {
> >>> +		job = bpf_mem_alloc(&bpf_global_ma, sizeof(*job));
> >>> +		if (!job)
> >>> +			return -ENOMEM;
> >>> +		atomic_long_inc(&bpf_dtor_kptr_total);
> >>> +		bpf_dtor_kptr_push_idle(job);
> >>> +	}
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +int bpf_kptr_offload_inc(void)
> >>> +{
> >>> +	long needed;
> >>> +	int err;
> >>> +
> >>> +	if (unlikely(!bpf_global_ma_set))
> >>> +		return -ENOMEM;
> >>> +
> >>> +	/*
> >>> +	 * Read active before incrementing refs so a free path moving one slot from
> >>> +	 * refs to active cannot shrink the reservation snapshot below the steady
> >>> +	 * state we need to cover. Racing results worst case in a larger reservation.
> >>> +	 */
> >>> +	needed = atomic_long_read(&bpf_dtor_kptr_active);
> >>> +	needed += atomic_long_inc_return(&bpf_dtor_kptr_refs);
> >>> +	err = bpf_dtor_kptr_reserve(needed);
> >>> +	if (err)
> >>> +		atomic_long_dec(&bpf_dtor_kptr_refs);
> >>> +
> >>> +	return err;
> >>> +}
> >>> +
> >>> +void bpf_kptr_offload_dec(void)
> >>> +{
> >>> +	long val;
> >>> +
> >>> +	val = atomic_long_dec_return(&bpf_dtor_kptr_refs);
> >>> +	if (!WARN_ON_ONCE(val < 0))
> >>> +		return;
> >>> +
> >>> +	/*
> >>> +	 * Clamp a mismatched decrement back to zero without overwriting a
> >>> +	 * concurrent increment that already repaired the counter.
> >>> +	 */
> >>> +	do {
> >>> +		val = atomic_long_read(&bpf_dtor_kptr_refs);
> >>> +		if (val >= 0)
> >>> +			break;
> >>> +	} while (!atomic_long_try_cmpxchg(&bpf_dtor_kptr_refs, &val, 0));
> >>> +}
> >>> +
> >>>  int sysctl_unprivileged_bpf_disabled __read_mostly =
> >>>  	IS_BUILTIN(CONFIG_BPF_UNPRIV_DEFAULT_OFF) ? 2 : 0;
> >>>  
> >>> @@ -807,6 +935,46 @@ void bpf_obj_free_task_work(const struct btf_record *rec, void *obj)
> >>>  	bpf_task_work_cancel_and_free(obj + rec->task_work_off);
> >>>  }
> >>>  
> >>> +static void bpf_dtor_kptr_worker(struct irq_work *work)
> >>> +{
> >>> +	struct llist_node *jobs, *node, *next;
> >>> +
> >>> +	jobs = llist_del_all(this_cpu_ptr(&bpf_dtor_kptr_jobs));
> >>> +	llist_for_each_safe(node, next, jobs) {
> >>> +		struct bpf_dtor_kptr_work *job;
> >>> +
> >>> +		job = llist_entry(node, struct bpf_dtor_kptr_work, node);
> >>> +		job->dtor(job->obj);
> >>> +		atomic_long_dec(&bpf_dtor_kptr_active);
> >>> +		bpf_dtor_kptr_push_idle(job);
> >>> +	}
> >>> +
> >>> +	bpf_dtor_kptr_trim();
> >>> +}
> >>> +
> >>> +static void bpf_dtor_kptr_offload(void *obj, btf_dtor_kfunc_t dtor)
> >>> +{
> >>> +	struct bpf_dtor_kptr_work *job;
> >>> +
> >>> +	atomic_long_inc(&bpf_dtor_kptr_active);
> >>> +	job = bpf_dtor_kptr_pop_idle();
> >>> +	if (WARN_ON_ONCE(!job)) {
> >>> +		atomic_long_dec(&bpf_dtor_kptr_active);
> >>> +		/*
> >>> +		 * This should stay unreachable if reserve accounting is correct. If it
> >>> +		 * ever breaks, running the destructor unsafely is still better than
> >>> +		 * leaking the object permanently.
> >>> +		 */
> >>> +		dtor(obj);
> >>> +		return;
> >>> +	}
> >>> +
> >>> +	job->obj = obj;
> >>> +	job->dtor = dtor;
> >>> +	if (llist_add(&job->node, this_cpu_ptr(&bpf_dtor_kptr_jobs)))
> >>> +		irq_work_queue(this_cpu_ptr(&bpf_dtor_kptr_irq_work));
> >>> +}
> >>> +
> >>>  void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
> >>>  {
> >>>  	const struct btf_field *fields;
> >>> @@ -842,6 +1010,19 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
> >>>  			xchgd_field = (void *)xchg((unsigned long *)field_ptr, 0);
> >>>  			if (!xchgd_field)
> >>>  				break;
> >>> +			if (in_nmi() && field->kptr.dtor) {
> >>> +				bpf_dtor_kptr_offload(xchgd_field, field->kptr.dtor);
> >>> +				bpf_kptr_offload_dec();
> >>> +				break;
> >>> +			}
> >>> +			if (field->kptr.dtor)
> >>> +				/*
> >>> +				 * Dtor kptrs reach storage through bpf_ref_kptr_xchg(), which
> >>> +				 * pairs installation with bpf_kptr_offload_inc(). Drop that
> >>> +				 * reservation on non-NMI teardown once no active transition is
> >>> +				 * needed.
> >>> +				 */
> >>> +				bpf_kptr_offload_dec();
> >>>  
> >>>  			if (!btf_is_kernel(field->kptr.btf)) {
> >>>  				pointee_struct_meta = btf_find_struct_meta(field->kptr.btf,
> >>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >>> index 11054ad89c14..2c7b21bda666 100644
> >>> --- a/kernel/bpf/verifier.c
> >>> +++ b/kernel/bpf/verifier.c
> >>> @@ -9950,6 +9950,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >>>  		if (err)
> >>>  			return err;
> >>>  	}
> >>> +	env->insn_aux_data[insn_idx].kptr_has_dtor =
> >>> +		func_id == BPF_FUNC_kptr_xchg && !!meta.kptr_field->kptr.dtor;
> >>>  
> >>>  	err = record_func_map(env, &meta, func_id, insn_idx);
> >>>  	if (err)
> >>
> 
