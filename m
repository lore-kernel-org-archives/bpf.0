Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F67933A005
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778097182; cv=none; b=Jfae6bYaCw0XKDaFz0cHkNG21V+cWj/bnlLUsWhPTV9HR4odYG7Tv9ozKN1rObuKq92kfD7RDU2HR8kkzXMXduagiUBRGC3Vr1UMtg7G/Tx9F4FM7KWgrGFo0oKykuPrHVlW6mZS/OJGwahBHAjWEo81sQ/sndgk+ENjFEiUHVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778097182; c=relaxed/simple;
	bh=BkzRE0wqB4jjVOiC3Bf83FNyu6QN/6KSNcTMra5T7QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOvU7jsV0Llzvc7AJcPRRwQLvHMCh1lmuvowc0Qtr5SdgtlDPmZmS4oKs2CVCJuFeQssrovz4gBEfslURjXUV81WDVBzP/UhyJ4oqZ1p+9KvE0j6ylRnuJEIJekyB2pRjYl3JDwWrSx18UKG86M4zo7kiyEYFOuTRrl1cKAjl90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGu8yxUf; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGu8yxUf"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65c305f381eso19554d50.3
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 12:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778097179; x=1778701979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5q+A8k1gLUw4+pvaVoKbP9qDHGlWeM1VRarCNvPpW5Q=;
        b=ZGu8yxUf+gukOhCw/77C9tI6Jvl08HnY2NqiSxBicmgfAEwGfZXtHPyv+c/b/NFxQo
         fypzHjkTfboVEh0TcYfU1reaknrTdtvy5FZ2qSni11AcMcDAWw5r3m2xX0iuT3qmNPm2
         yZrhX294Rheas7fXmFwJZalWHiWF573+NjiYSAlGd+Vmv41l0+R5XvidEj66Sna1mgup
         RpAR+RUT6nDpUjqNE2fewwfRoSb60C5XYUu2pagE3UPEk8HQFjz9C3YI66/Ng2GjL3an
         Onf5aWlHaQXa1fcdnb60bCpTp4ha7oXg9fJXXmykSKR/dy35zA5Xsql7o/M8lgqVqR51
         ilLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778097179; x=1778701979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5q+A8k1gLUw4+pvaVoKbP9qDHGlWeM1VRarCNvPpW5Q=;
        b=UKxX9X5Ax4f0Z3nIqn0TX1asMrEFEQaf+/Y4SkI5ZqYCaUY2MH1lys5Bp9k8F3aMnk
         eXPGzKEUeI4ZWklgqVpD9DH0RA3wUJ4hjapN3yi37RmoYB3nV1Ptij2WfKkeENvKvGl7
         6bn1PtHvu86Vqv45nmh14cP8vs8mV4V6qw7nWHk7myVfl7nfnmhkeHsVXxDI7lIJyyF3
         +HFIdZlYlWSpRogqDh6lnO9oxjs+KMzFvfk4oTsv97h4e1UEv5BrzKbcAVaEj4AOqRpo
         qjKjaBhvb+4M9ikWIcDiWTVwZu8N8tu6DmC9ObwXf0g6VCYhmLp7vAi+vCZHiXzlEDVy
         XsoA==
X-Forwarded-Encrypted: i=1; AFNElJ9fpTyi3rwonaLNsQ0hvy5Op6evecGuCLv8f7MZIq9SyCc2J7f2Pv417kNX2+1LE4uMzq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwylxuYSJOPgYgjgocXUNlOvHoTeRySFFV1BOwHpVY2qZp7Qrh7
	ooQC1VJO3S4YQBG5p5tqtZIIp31xSUaQ2cnJU3pZVCucJgBwDKuGNL6yOMd7/Umk
X-Gm-Gg: AeBDietXnp6hT+12ml5TpWgEAgk5KS6sjRbPk5ur4SSuMMtl4D/dBA2xuoI0k+HZO+j
	hRtmUGGkiyo1+M5xaBm5VVOMN0ZMhFQOeTpDGe73RSG1nFJOIRbX/hnSX+M6YczA3LTmn6YMTxB
	xmDiM+TKKKWBp5vUY9amQ2CaMhNe3U29sqi+ttaFXspRWtIS0h2Hqom5+6Wi7iz7ehipiSbyuld
	lwGS1I90zzl8LNvptldg8ZEn9Ik1IwT9tSmv8n9NqZff49w6rCvweC+Ou8bEXTugvzlb2oHRBaX
	YDEuqAdRWyWgUht9gnCalA7N1gqsf0s5A5NroCFlnGhFdVCj96agzwbpXYkXgpIo7JvfCfkEo2z
	C9vqTl90sGZA9f9KILG8pEOw0Y8MXGnRNoIXn6+KteTIaPbtizMzqwl9hyh8wfnAJnxV982QXTI
	OTJX6teXwBk4VyHCp3+XCHsziZifVH2/i1OSxpZxVk6uEfBeIC5g5ZAd/Rbya6xpvMKi1nNPve4
	kyd9UM=
X-Received: by 2002:a53:cf0a:0:b0:65c:5e34:7343 with SMTP id 956f58d0204a3-65c799e83e1mr3780455d50.44.1778097178993;
        Wed, 06 May 2026 12:52:58 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:8c5b:e561:ee21:7f30])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c7adc2453sm1556223d50.4.2026.05.06.12.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 12:52:58 -0700 (PDT)
Date: Wed, 6 May 2026 15:52:56 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	bpf@vger.kernel.org, mic@digikod.net,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [bpf-next v2 1/2] bpf: Offload kptr destructors that run from NMI
Message-ID: <afucGBvwXMkuU8sG@zenbox>
References: <20260505150851.3090688-1-utilityemal77@gmail.com>
 <20260505150851.3090688-2-utilityemal77@gmail.com>
 <51a054a0-e57f-49dc-9527-36da0535087c@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51a054a0-e57f-49dc-9527-36da0535087c@gmail.com>

On Wed, May 06, 2026 at 05:43:51PM +0100, Mykyta Yatsenko wrote:
> On 5/5/26 4:08 PM, Justin Suess wrote:
> > A BPF program attached to tp_btf/nmi_handler can delete map entries or
> > swap out referenced kptrs from NMI context. Today that runs the kptr
> > destructor inline. Destructors such as bpf_cpumask_release() can take
> > RCU-related locks, so running them from NMI can deadlock the system.
> > 
> > Preallocate offload jobs from the global BPF memory allocator, track the
> > number of live destructor-backed references so the pool stays ahead of
> > NMI frees, and let the worker invoke the destructor after NMI exits.
> > 
> > The algorithm for preallocation is simple: The invariant is total >=
> > refs + active, where refs = the ref kptrs installed in maps, active =
> > jobs being executed in the irq_work worker, and total is the number of
> > job structures allocated. To avoid excessive pre-allocation calls while
> > maintaining the invariant, we allocate the needed slots, plus a small
> > amount of extra, min(needed, BPF_DTOR_KPTR_RESERVE_HEADROOM), where
> > BPF_DTOR_KPTR_RESERVE_HEADROOM is 64 in this patch.
> > 
> > A small but harmless ordering subtlety: the active atomic is read before
> > refs. This can result in a small amount of over allocation, but this
> > won't be leaked and will properly be carried into the trim stage.
> > 
> > The trim stage is simple. It uses a CAS loop to free excessive leftover
> > idle job slots. It snapshots total refs and active, pops an idle job if
> > the pool is excessively large, and attempts a cmpxhg to decrement it
> > atomically. On a failure case, it will just push the job back into the
> > idle list and retry.
> > 
> > There are several best-effort mitigation methods to tackle the memory
> > pressure problem, preserving integrity under this unlikely scenario.
> > 
> > If reserving another offload slot fails while installing a new
> > destructor-backed kptr through bpf_kptr_xchg(), leave the destination
> > unchanged and return the incoming pointer so the caller keeps ownership.
> > 
> > This is superior to leaking the pointer, and should only happen if the
> > accounting is incorrect. Moreover, this is a condition the caller can
> > check for and recover from.
> > 
> > If NMI teardown still fails to grab an idle offload job despite that
> > reserve accounting, warn once and run the destructor inline rather than
> > leak the object permanently. Attempt to repair the counter safely with
> > another CAS loop in that case, preserving concurrent increments.
> > 
> > This fix does come with small performance tradeoffs for safety. xchg can
> > no longer be inlined for referenced kptrs, as inlining would break the
> > reference counting. The inlining fix is preserved for kptrs with no
> > destructor defined.
> > 
> > This keeps refcounted kptr teardown out of NMI context without slowing
> > down raw kptr exchanges that never need destructor handling.
> > 
> > Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Reported-by: Justin Suess <utilityemal77@gmail.com>
> > Closes: https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@gmail.com/
> > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > ---
> >  include/linux/bpf.h          |  16 ++++
> >  include/linux/bpf_verifier.h |   1 +
> >  kernel/bpf/fixups.c          |  33 ++++---
> >  kernel/bpf/helpers.c         |  24 ++++-
> >  kernel/bpf/syscall.c         | 181 +++++++++++++++++++++++++++++++++++
> >  kernel/bpf/verifier.c        |   2 +
> >  6 files changed, 242 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 715b6df9c403..307de5caa646 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -3454,6 +3454,22 @@ static inline struct bpf_prog *bpf_prog_get_type(u32 ufd,
> >  
> >  void __bpf_free_used_maps(struct bpf_prog_aux *aux,
> >  			  struct bpf_map **used_maps, u32 len);
> > +/* Direct-call target used by fixups for bpf_kptr_xchg() sites without dtors. */
> > +u64 bpf_kptr_xchg_nodtor(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
> > +
> > +#ifdef CONFIG_BPF_SYSCALL
> > +int bpf_kptr_offload_inc(void);
> > +void bpf_kptr_offload_dec(void);
> > +#else
> > +static inline int bpf_kptr_offload_inc(void)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline void bpf_kptr_offload_dec(void)
> > +{
> > +}
> > +#endif
> >  
> >  bool bpf_prog_get_ok(struct bpf_prog *, enum bpf_prog_type *, bool);
> >  
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 976e2b2f40e8..8e39ff92dd2c 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -672,6 +672,7 @@ struct bpf_insn_aux_data {
> >  	bool non_sleepable; /* helper/kfunc may be called from non-sleepable context */
> >  	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
> >  	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
> > +	bool kptr_has_dtor;
> >  	u8 alu_state; /* used in combination with alu_limit */
> >  	/* true if STX or LDX instruction is a part of a spill/fill
> >  	 * pattern for a bpf_fastcall call.
> > diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> > index fba9e8c00878..459e855e86a5 100644
> > --- a/kernel/bpf/fixups.c
> > +++ b/kernel/bpf/fixups.c
> > @@ -2284,23 +2284,30 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
> >  			goto next_insn;
> >  		}
> >  
> > -		/* Implement bpf_kptr_xchg inline */
> > -		if (prog->jit_requested && BITS_PER_LONG == 64 &&
> > -		    insn->imm == BPF_FUNC_kptr_xchg &&
> > -		    bpf_jit_supports_ptr_xchg()) {
> > -			insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_2);
> > -			insn_buf[1] = BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_1, BPF_REG_0, 0);
> > -			cnt = 2;
> > +		/* Implement bpf_kptr_xchg inline. */
> > +		if (insn->imm == BPF_FUNC_kptr_xchg &&
> > +		    !env->insn_aux_data[i + delta].kptr_has_dtor) {
> > +			if (prog->jit_requested && BITS_PER_LONG == 64 &&
> > +			    bpf_jit_supports_ptr_xchg()) {
> > +				insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_2);
> > +				insn_buf[1] = BPF_ATOMIC_OP(BPF_DW, BPF_XCHG,
> > +						     BPF_REG_1, BPF_REG_0, 0);
> > +				cnt = 2;
> >  
> > -			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> > -			if (!new_prog)
> > -				return -ENOMEM;
> > +				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> > +				if (!new_prog)
> > +					return -ENOMEM;
> >  
> > -			delta    += cnt - 1;
> > -			env->prog = prog = new_prog;
> > -			insn      = new_prog->insnsi + i + delta;
> > +				delta    += cnt - 1;
> > +				env->prog = prog = new_prog;
> > +				insn      = new_prog->insnsi + i + delta;
> > +				goto next_insn;
> > +			}
> > +
> > +			insn->imm = bpf_kptr_xchg_nodtor - __bpf_call_base;
> >  			goto next_insn;
> >  		}
> > +
> >  patch_call_imm:
> >  		fn = env->ops->get_func_proto(insn->imm, env->prog);
> >  		/* all functions that have prototype and verifier allowed
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index baa12b24bb64..cdc64ab83ef6 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1728,7 +1728,7 @@ void bpf_wq_cancel_and_free(void *val)
> >  	bpf_async_cancel_and_free(val);
> >  }
> >  
> > -BPF_CALL_2(bpf_kptr_xchg, void *, dst, void *, ptr)
> > +BPF_CALL_2(bpf_kptr_xchg_nodtor, void *, dst, void *, ptr)
> >  {
> >  	unsigned long *kptr = dst;
> >  
> > @@ -1736,12 +1736,32 @@ BPF_CALL_2(bpf_kptr_xchg, void *, dst, void *, ptr)
> >  	return xchg(kptr, (unsigned long)ptr);
> >  }
> >  
> > +BPF_CALL_2(bpf_ref_kptr_xchg, void *, dst, void *, ptr)
> > +{
> > +	unsigned long *kptr = dst;
> > +	void *old;
> > +
> > +	/*
> > +	 * If the incoming pointer cannot be torn down safely from NMI later on,
> > +	 * leave the destination untouched and return ptr so the caller keeps
> > +	 * ownership.
> > +	 */
> > +	if (ptr && bpf_kptr_offload_inc())
> > +		return (unsigned long)ptr;
> > +
> > +	old = (void *)xchg(kptr, (unsigned long)ptr);
> > +	if (old)
> > +		bpf_kptr_offload_dec();
> > +	return (unsigned long)old;
> > +}
> > +
> >  /* Unlike other PTR_TO_BTF_ID helpers the btf_id in bpf_kptr_xchg()
> >   * helper is determined dynamically by the verifier. Use BPF_PTR_POISON to
> >   * denote type that verifier will determine.
> > + * No-dtor callsites are redirected to bpf_kptr_xchg_nodtor() from fixups.
> >   */
> >  static const struct bpf_func_proto bpf_kptr_xchg_proto = {
> > -	.func         = bpf_kptr_xchg,
> > +	.func         = bpf_ref_kptr_xchg,
> >  	.gpl_only     = false,
> >  	.ret_type     = RET_PTR_TO_BTF_ID_OR_NULL,
> >  	.ret_btf_id   = BPF_PTR_POISON,
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 3b1f0ba02f61..162bfd4796ea 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/bpf_trace.h>
> >  #include <linux/bpf_lirc.h>
> >  #include <linux/bpf_verifier.h>
> > +#include <linux/bpf_mem_alloc.h>
> >  #include <linux/bsearch.h>
> >  #include <linux/btf.h>
> >  #include <linux/hex.h>
> > @@ -19,6 +20,8 @@
> >  #include <linux/fdtable.h>
> >  #include <linux/file.h>
> >  #include <linux/fs.h>
> > +#include <linux/irq_work.h>
> > +#include <linux/llist.h>
> >  #include <linux/license.h>
> >  #include <linux/filter.h>
> >  #include <linux/kernel.h>
> > @@ -65,6 +68,131 @@ static DEFINE_SPINLOCK(map_idr_lock);
> >  static DEFINE_IDR(link_idr);
> >  static DEFINE_SPINLOCK(link_idr_lock);
> >  
> > +struct bpf_dtor_kptr_work {
> > +	struct llist_node node;
> > +	void *obj;
> > +	btf_dtor_kfunc_t dtor;
> > +};
> > +
> > +/* Queue pending dtors per CPU; the idle pool stays global. */
> > +static DEFINE_PER_CPU(struct llist_head, bpf_dtor_kptr_jobs);
> > +static LLIST_HEAD(bpf_dtor_kptr_idle);
> > +/* Keep total >= refs + active so NMI frees never need to allocate. */
> > +static atomic_long_t bpf_dtor_kptr_refs = ATOMIC_LONG_INIT(0);
> > +static atomic_long_t bpf_dtor_kptr_active = ATOMIC_LONG_INIT(0);
> > +static atomic_long_t bpf_dtor_kptr_total = ATOMIC_LONG_INIT(0);
> > +
> > +/* Bound reserve overshoot so the pool tracks demand instead of growing on itself. */
> > +#define BPF_DTOR_KPTR_RESERVE_HEADROOM 64L
> > +
> > +static void bpf_dtor_kptr_worker(struct irq_work *work);
> > +static DEFINE_PER_CPU(struct irq_work, bpf_dtor_kptr_irq_work) =
> > +	IRQ_WORK_INIT_HARD(bpf_dtor_kptr_worker);
> > +
> 
> I think this still looks too complex:
>  * 2 lists - idle list and armed list
>  * 3 atomics, controlling demand/supply
>  * headroom/trimming management
> 
> The complexity introduced for performance reasons, but
> I'm not sure if the tradeoff is worth it.
> 
> What about the next design:
> 
> Instead of idle list, store bpf_dtor_kptr_work in the kptr map slot itself.
> Use kmalloc_nolock() to allocate bpf_dtor_kptr_work on the first 
> xchg just once per map value, then reuse it across xchg in/out.
>
Hello,

Thanks for the feedback.

I tried a different but related approach in [1], my v1, which also
stored the work in the map slot (struct bpf_kptr_dtor_aux).

> Detach: When map value is deleted, atomically set kptr map field storing 
> bpf_dtor_kptr_work to NULL (so the next xchg-in allocates new 
> bpf_dtor_kptr_work.)
> After detaching insert bpf_dtor_kptr_work to the global list and run irq_work. 
> Free bpf_dtor_kptr_work in call_rcu_tasks_trace().
This would be nice to do but there's a sequence where you can delete and
insert stimultaniously. Basically an ABBA problem that is inconvienent to
deal with, especially in NMI.

Let's say

CPU0 = Deleting value from the map. xchg w/ null.
CPU1 = Exchanging new value into the map. xchg w/ something

So I give the two orders we can do it in, zeroing the map slot first or
zeroing the work first.

1. Set obj to null, then null out work

CPU0
sets map obj field to null (dtor work is still != null)
CPU1
sets map obj field to something
CPU1 (again)
sees that dtor work is still != null, (does nothing, assumes a valid
slot was still allocated)
CPU0
sets dtor work to null and enqueues it in the irq_work.

Then a new dtor work is never allocated for the new slot.

2. And doing in the other order (nulling out work before the obj)

CPU0
sets work to null and enqueues it.
CPU1
sets work to something (allocates new work)
CPU1
sets obj to something
CPU0
sets obj to null.

Then you end up leaking the object set by CPU1.

So either order we do it in 1 or 2, this is an ABBA problem.
And would require serialization and/or some sort of lock state
for every map slot.

Not to mention the complexity of adding extra data to the map slots
requires modifications to every map type. You can see the problem this
introduced in my v1, which took a related approach adding auxiliary data
to map slots.

....

FWIW I do have a much less complex implementation for my v3
revision which brings it down to a single atomic and two
pcpu_freelists, cutting it to 215~ lines net for the whole fix.

Let me know if I missed anything or am misunderstanding something. I
really appreciate the feedback though this is a tougher problem than it
seemed and your thought was very similar to my initial approach :)
> 
> This is based on the bpf_timer and bpf_task_work
> implementations.
>
Those were some of my initial inspiration as well!

Thanks again,
Justin

[1] https://lore.kernel.org/bpf/20260428201422.1518903-1-utilityemal77@gmail.com/
> > +static void bpf_dtor_kptr_push_idle(struct bpf_dtor_kptr_work *job)
> > +{
> > +	llist_add(&job->node, &bpf_dtor_kptr_idle);
> > +}
> > +
> > +static struct bpf_dtor_kptr_work *bpf_dtor_kptr_pop_idle(void)
> > +{
> > +	struct llist_node *node;
> > +
> > +	node = llist_del_first(&bpf_dtor_kptr_idle);
> > +	if (!node)
> > +		return NULL;
> > +
> > +	return llist_entry(node, struct bpf_dtor_kptr_work, node);
> > +}
> > +
> > +static void bpf_dtor_kptr_trim(void)
> > +{
> > +	struct bpf_dtor_kptr_work *job;
> > +	long total;
> > +	long needed;
> > +
> > +	for (;;) {
> > +		total = atomic_long_read(&bpf_dtor_kptr_total);
> > +		needed = atomic_long_read(&bpf_dtor_kptr_refs) +
> > +			 atomic_long_read(&bpf_dtor_kptr_active);
> > +		if (total <= needed)
> > +			return;
> > +
> > +		job = bpf_dtor_kptr_pop_idle();
> > +		if (!job)
> > +			return;
> > +
> > +		if (!atomic_long_try_cmpxchg(&bpf_dtor_kptr_total, &total, total - 1)) {
> > +			bpf_dtor_kptr_push_idle(job);
> > +			continue;
> > +		}
> > +
> > +		bpf_mem_free(&bpf_global_ma, job);
> > +	}
> > +}
> > +
> > +static int bpf_dtor_kptr_reserve(long needed)
> > +{
> > +	struct bpf_dtor_kptr_work *job;
> > +	long headroom;
> > +	long target;
> > +
> > +	headroom = min_t(long, needed, BPF_DTOR_KPTR_RESERVE_HEADROOM);
> > +	if (check_add_overflow(needed, headroom, &target))
> > +		target = needed;
> > +
> > +	while (atomic_long_read(&bpf_dtor_kptr_total) < target) {
> > +		job = bpf_mem_alloc(&bpf_global_ma, sizeof(*job));
> > +		if (!job)
> > +			return -ENOMEM;
> > +		atomic_long_inc(&bpf_dtor_kptr_total);
> > +		bpf_dtor_kptr_push_idle(job);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +int bpf_kptr_offload_inc(void)
> > +{
> > +	long needed;
> > +	int err;
> > +
> > +	if (unlikely(!bpf_global_ma_set))
> > +		return -ENOMEM;
> > +
> > +	/*
> > +	 * Read active before incrementing refs so a free path moving one slot from
> > +	 * refs to active cannot shrink the reservation snapshot below the steady
> > +	 * state we need to cover. Racing results worst case in a larger reservation.
> > +	 */
> > +	needed = atomic_long_read(&bpf_dtor_kptr_active);
> > +	needed += atomic_long_inc_return(&bpf_dtor_kptr_refs);
> > +	err = bpf_dtor_kptr_reserve(needed);
> > +	if (err)
> > +		atomic_long_dec(&bpf_dtor_kptr_refs);
> > +
> > +	return err;
> > +}
> > +
> > +void bpf_kptr_offload_dec(void)
> > +{
> > +	long val;
> > +
> > +	val = atomic_long_dec_return(&bpf_dtor_kptr_refs);
> > +	if (!WARN_ON_ONCE(val < 0))
> > +		return;
> > +
> > +	/*
> > +	 * Clamp a mismatched decrement back to zero without overwriting a
> > +	 * concurrent increment that already repaired the counter.
> > +	 */
> > +	do {
> > +		val = atomic_long_read(&bpf_dtor_kptr_refs);
> > +		if (val >= 0)
> > +			break;
> > +	} while (!atomic_long_try_cmpxchg(&bpf_dtor_kptr_refs, &val, 0));
> > +}
> > +
> >  int sysctl_unprivileged_bpf_disabled __read_mostly =
> >  	IS_BUILTIN(CONFIG_BPF_UNPRIV_DEFAULT_OFF) ? 2 : 0;
> >  
> > @@ -807,6 +935,46 @@ void bpf_obj_free_task_work(const struct btf_record *rec, void *obj)
> >  	bpf_task_work_cancel_and_free(obj + rec->task_work_off);
> >  }
> >  
> > +static void bpf_dtor_kptr_worker(struct irq_work *work)
> > +{
> > +	struct llist_node *jobs, *node, *next;
> > +
> > +	jobs = llist_del_all(this_cpu_ptr(&bpf_dtor_kptr_jobs));
> > +	llist_for_each_safe(node, next, jobs) {
> > +		struct bpf_dtor_kptr_work *job;
> > +
> > +		job = llist_entry(node, struct bpf_dtor_kptr_work, node);
> > +		job->dtor(job->obj);
> > +		atomic_long_dec(&bpf_dtor_kptr_active);
> > +		bpf_dtor_kptr_push_idle(job);
> > +	}
> > +
> > +	bpf_dtor_kptr_trim();
> > +}
> > +
> > +static void bpf_dtor_kptr_offload(void *obj, btf_dtor_kfunc_t dtor)
> > +{
> > +	struct bpf_dtor_kptr_work *job;
> > +
> > +	atomic_long_inc(&bpf_dtor_kptr_active);
> > +	job = bpf_dtor_kptr_pop_idle();
> > +	if (WARN_ON_ONCE(!job)) {
> > +		atomic_long_dec(&bpf_dtor_kptr_active);
> > +		/*
> > +		 * This should stay unreachable if reserve accounting is correct. If it
> > +		 * ever breaks, running the destructor unsafely is still better than
> > +		 * leaking the object permanently.
> > +		 */
> > +		dtor(obj);
> > +		return;
> > +	}
> > +
> > +	job->obj = obj;
> > +	job->dtor = dtor;
> > +	if (llist_add(&job->node, this_cpu_ptr(&bpf_dtor_kptr_jobs)))
> > +		irq_work_queue(this_cpu_ptr(&bpf_dtor_kptr_irq_work));
> > +}
> > +
> >  void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
> >  {
> >  	const struct btf_field *fields;
> > @@ -842,6 +1010,19 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
> >  			xchgd_field = (void *)xchg((unsigned long *)field_ptr, 0);
> >  			if (!xchgd_field)
> >  				break;
> > +			if (in_nmi() && field->kptr.dtor) {
> > +				bpf_dtor_kptr_offload(xchgd_field, field->kptr.dtor);
> > +				bpf_kptr_offload_dec();
> > +				break;
> > +			}
> > +			if (field->kptr.dtor)
> > +				/*
> > +				 * Dtor kptrs reach storage through bpf_ref_kptr_xchg(), which
> > +				 * pairs installation with bpf_kptr_offload_inc(). Drop that
> > +				 * reservation on non-NMI teardown once no active transition is
> > +				 * needed.
> > +				 */
> > +				bpf_kptr_offload_dec();
> >  
> >  			if (!btf_is_kernel(field->kptr.btf)) {
> >  				pointee_struct_meta = btf_find_struct_meta(field->kptr.btf,
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 11054ad89c14..2c7b21bda666 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -9950,6 +9950,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >  		if (err)
> >  			return err;
> >  	}
> > +	env->insn_aux_data[insn_idx].kptr_has_dtor =
> > +		func_id == BPF_FUNC_kptr_xchg && !!meta.kptr_field->kptr.dtor;
> >  
> >  	err = record_func_map(env, &meta, func_id, insn_idx);
> >  	if (err)
> 
