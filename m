Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1594E3624A6
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010492; cv=none; b=s34fGuHiW2IFSHzAhTB+sYs+lF5GhIOY2qds5euK1SUdNEgL8vhiXDHSS1GHWfsJAOYsr0XnsJSegGkRRxtN5QJjKG6TUgzAv5Y5TVjYBy88fCT+VWm3q4E7GpodxmbSJGpdP+Yv/IAsMu8hngfODD1mEJC2IYiWxhtb27N3GF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010492; c=relaxed/simple;
	bh=4yux7UV3Ci/O+jZ2amZ5C11zk/SV9hSglDGYj75Wrys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THAV+PetxDw/YflLHX01GNsOmkCOCoLy1Lb1V84wJcTbHifyCVLUf/lnTfoX+RaLzMC1NClNCNm74oSiUE3qhXc6CywR3UVgFj7hvF72fiOp3RCF+GQTvcWRppxNNLCXWc5Uitd708Pl0XPfgjg84fEKiSk61zAsDHMqoFTmgDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dX7/lk4y; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dX7/lk4y"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7bdc947aa88so8149527b3.3
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 12:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778010490; x=1778615290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hpQlw76tJ9BlcmQArbqB7ba2pzcJwi4bnj7hqjLDmyg=;
        b=dX7/lk4yd+7NSKlQ8r5EnfQ5iPQep9s2u05Hb33qN32eSZyiGeMBwaIF6Vec4f36z/
         FAartqpEqdraPQgv9Ltiwelp6XCto+c74peF0v2+nkftH2g+fnuF22ylqL509FIwo5jp
         usjiOjPsvBmd5h+Up0XQMRRJwEBj+LRu2v3hbHYxEmreuyM2PhIYo5lOWxDEHj0wGaqO
         CvQyTj+v80z9DjzRuE7grQrTqOKxVzjyzcC3pKxqdTe4gFl94ZLtRmAiplg+Q60XxiVm
         2Xm+AvUmuByL4pP2+m7SBkyy18DTQY3EQWJhlsmUMXxhpqUcHkbZ0hWiNfORzVE5ZaMs
         +4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010490; x=1778615290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpQlw76tJ9BlcmQArbqB7ba2pzcJwi4bnj7hqjLDmyg=;
        b=tPBIsGWdDIJhRDXlTzQniPALr92oo47vV8SRPwjQl+NtQ5f/XP0WBPZcD87y+rTWwv
         u5fNzbDoqSjnWeFrDALRntPVxTkDGhyQ1KNhX+xXokoocml5yQeAjM8ZP4fY5yPlBvkD
         tOIUyPGeR0nL/SIAjZjWIwBG/0QVNRI1t1S7g3zH98ViJOanAQ4FctlU5cHwMmpm/EUW
         QsiS8OhaYzxbH4V7uegW0UPFOIMbjmHM6CZgUmFGWRA9qS3DQAzgYRfx/PAivdi+ppJ4
         Suik4hF/qpdxbf8rn5fb2pcxegQJLe7WwPcQscmuNgdTkg4IP71H8HoRtdXun8HNsmbk
         uoGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ODgjMU2JbOgRqW4JY3IXOvK9DBmvORcIfEcO8mfB37SowqA0ewUAOi9ODPZqom8VsbD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUaE/g3oszhy/GdMR4MUycic/cTsYYzBJUNLC8G/dAKiLP1lvX
	UzHVCz1ftU9ZHnYLAZJUtlgSuTE9jaSStnBbv7gD3H4uoXnca2ZXcvjxVvsxS0E0
X-Gm-Gg: AeBDieuOK5mC5GJgVCykc+8rEYh4Ton4VigTSLgoxJdZl9i7g0bZMfXSmgDApjMvMOS
	ulLewC8cXgv1LIMkrHk7gqWmxJG6i7t3qT87ObNdEUhp09XUvijcxmf6BEprlYZSleAazsauywc
	WacQnloJPi9F1nNW81jK+YMKkFl874Q8aSRM25EtgbDIvdbK/RjYuuzB8FmhprP97YlKgPQ6YbL
	9CStg297mHBpdBtDCR29QzroASOHa8c/wMGRK4GaVkWYEqoQKwPj9OC80PvMVZ4kL89Er8H8Ncy
	xj+Evr7QQarKblNTv7cqEpM+aPScBs9fWh2PQMxM1KOasjrIndRnR27QU+mUoqZacZLPMfnRVlc
	496Zc/9LR6DS0sCtfMYGqINTAb8LD/VJlnJMvmJcgMMqy+erGDrLyOCgXb0fQi27muPPBwPGX/R
	zlsX2SYOu48ZsM1zhZamqmUSy2BscnhLcvWKoSsp7bOsReFS4dW8SipE3tpyNLq7GUO/MD
X-Received: by 2002:a05:690c:110:b0:7b9:39f:62c8 with SMTP id 00721157ae682-7bdf5eb5798mr6920987b3.27.1778010489869;
        Tue, 05 May 2026 12:48:09 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:2fd9:17ad:6991:cb6c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd976fd09asm29795427b3.41.2026.05.05.12.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:48:09 -0700 (PDT)
Date: Tue, 5 May 2026 15:48:07 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	bpf@vger.kernel.org, mic@digikod.net, alexei.starovoitov@gmail.com,
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [bpf-next v2 1/2] bpf: Offload kptr destructors that run from NMI
Message-ID: <afpJdw5bpO0fxyel@zenbox>
References: <20260505150851.3090688-2-utilityemal77@gmail.com>
 <c2bc74937f3da0174c896daa2d129c9572a5c6434f8d71da26283fe7f011c4af@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2bc74937f3da0174c896daa2d129c9572a5c6434f8d71da26283fe7f011c4af@mail.kernel.org>

On Tue, May 05, 2026 at 04:06:23PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 3b1f0ba02f61..162bfd4796ea 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> 
> [ ... ]
> 
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
> 
> Does bpf_dtor_kptr_pop_idle() handle multiple concurrent consumers
> safely?
> 
> The documentation for llist_del_first() in lib/llist.c explicitly
> states:
> 
>   Only one llist_del_first user can be used simultaneously with multiple
>   llist_add users without lock. Because otherwise llist_del_first,
>   llist_add, llist_add (or llist_del_all, llist_add, llist_add)
>   sequence in another user may change @head->first->next, but keep
>   @head->first.
> 
> This is the classic ABA race that llist_del_first cannot defend against.
> 
> In this patch, bpf_dtor_kptr_pop_idle() has multiple concurrent
> consumers:
> 
>   1. bpf_dtor_kptr_offload() called from NMI context on any CPU
>      (the function installed below, called from bpf_obj_free_fields
>      when in_nmi()).
> 
>   2. bpf_dtor_kptr_trim() called from the per-CPU irq_work worker on
>      any CPU (called from bpf_dtor_kptr_worker below).
> 
> Both paths call bpf_dtor_kptr_pop_idle() which calls
> llist_del_first(&bpf_dtor_kptr_idle) on the global idle list. Two or
> more CPUs can be popping simultaneously with no external lock and no
> single-consumer guarantee.
> 
> Can the following race timeline produce list corruption or
> double-ownership?
> 
> Initial state: idle list = A -> B -> C -> NULL
> 
> CPU0 (NMI): enters bpf_dtor_kptr_pop_idle
>   entry = head->first = A
>   next  = A->next     = B
>   (stalls before cmpxchg)
> 
> CPU1 (NMI/worker): runs bpf_dtor_kptr_pop_idle
>   entry = A, next = B, cmpxchg(head->first, A, B) succeeds.
>   Now idle = B -> C -> NULL. CPU1 uses A (for offload or mem_free).
> 
> CPU1: pops again, takes B. idle = C -> NULL.
> 
> CPU1 eventually runs worker -> push_idle(A). Now idle = A -> C -> NULL.
>    A->next = C (not B anymore).
> 
> CPU0 resumes:
>   Its cached next variable is still B, cmpxchg(&head->first, A, B)
>   finds head->first is currently A, so the cmpxchg succeeds.
>   Result: head->first = B, but B has been popped and is in CPU1's
>   per-CPU bpf_dtor_kptr_jobs list already (not free).
> 
> Node B is now simultaneously:
>   (a) considered removed from idle (CPU1 popped it and is using it)
>   (b) referenced as idle->first by the head pointer
> 
> Another pop_idle() may grab B again as if it were idle, while it is
> active in a per-CPU jobs list. Then bpf_dtor_kptr_worker will execute
> job->dtor() on already-freed/reused job->obj, or the same job is pushed
> into two lists, corrupting llist_node chains.
> 
> Concurrency is not hypothetical here. A BPF tp_btf/nmi_handler program
> calling bpf_map_delete_elem can fire on multiple CPUs simultaneously.
> The irq_work worker also runs on any CPU that queued work. Thus both
> bpf_dtor_kptr_offload and bpf_dtor_kptr_trim can run concurrently on
> different CPUs, giving at least 2 concurrent llist_del_first consumers.
> 
> Typical fixes require either:
>   - using a locked list (spinlock + list_head), or
>   - using llist_del_all() with batch processing, or
>   - a cmpxchg-based stack that properly handles ABA (e.g., using a
>     tagged pointer).
>
This is indeed ABA.

Switching the idle list to use percpu freelist instead should
fix this issue. That's better for this model anyway where we don't care
about anything other than pop and push.

(The bpf_dtor_kptr_jobs llist is fine since we're not using
llist_del_first)

Something like:

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 162bfd4796ea..f1e7dc9ef4fe 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -45,6 +45,8 @@
 #include <linux/cookie.h>
 #include <linux/verification.h>
 
+#include "percpu_freelist.h"
+
 #include <net/netfilter/nf_bpf_link.h>
 #include <net/netkit.h>
 #include <net/tcx.h>
@@ -69,14 +71,17 @@ static DEFINE_IDR(link_idr);
 static DEFINE_SPINLOCK(link_idr_lock);
 
 struct bpf_dtor_kptr_work {
-	struct llist_node node;
+	union {
+		struct llist_node node;
+		struct pcpu_freelist_node fnode;
+	};
 	void *obj;
 	btf_dtor_kfunc_t dtor;
 };
 
-/* Queue pending dtors per CPU; the idle pool stays global. */
+/* Queue pending dtors per CPU; the idle pool uses a global pcpu_freelist. */
 static DEFINE_PER_CPU(struct llist_head, bpf_dtor_kptr_jobs);
-static LLIST_HEAD(bpf_dtor_kptr_idle);
+static struct pcpu_freelist bpf_dtor_kptr_idle;
 /* Keep total >= refs + active so NMI frees never need to allocate. */
 static atomic_long_t bpf_dtor_kptr_refs = ATOMIC_LONG_INIT(0);
 static atomic_long_t bpf_dtor_kptr_active = ATOMIC_LONG_INIT(0);
@@ -91,18 +96,18 @@ static DEFINE_PER_CPU(struct irq_work, bpf_dtor_kptr_irq_work) =
 
 static void bpf_dtor_kptr_push_idle(struct bpf_dtor_kptr_work *job)
 {
-	llist_add(&job->node, &bpf_dtor_kptr_idle);
+	pcpu_freelist_push(&bpf_dtor_kptr_idle, &job->fnode);
 }
 
 static struct bpf_dtor_kptr_work *bpf_dtor_kptr_pop_idle(void)
 {
-	struct llist_node *node;
+	struct pcpu_freelist_node *node;
 
-	node = llist_del_first(&bpf_dtor_kptr_idle);
+	node = pcpu_freelist_pop(&bpf_dtor_kptr_idle);
 	if (!node)
 		return NULL;
 
-	return llist_entry(node, struct bpf_dtor_kptr_work, node);
+	return container_of(node, struct bpf_dtor_kptr_work, fnode);
 }
 
 static void bpf_dtor_kptr_trim(void)
@@ -157,7 +162,7 @@ int bpf_kptr_offload_inc(void)
 	long needed;
 	int err;
 
-	if (unlikely(!bpf_global_ma_set))
+	if (unlikely(!bpf_global_ma_set || !READ_ONCE(bpf_dtor_kptr_idle.freelist)))
 		return -ENOMEM;
 
 	/*
@@ -193,6 +198,18 @@ void bpf_kptr_offload_dec(void)
 	} while (!atomic_long_try_cmpxchg(&bpf_dtor_kptr_refs, &val, 0));
 }
 
+static int __init bpf_dtor_kptr_init(void)
+{
+	int err;
+
+	err = pcpu_freelist_init(&bpf_dtor_kptr_idle);
+	if (err)
+		return err;
+
+	return 0;
+}
+late_initcall(bpf_dtor_kptr_init);
+
 int sysctl_unprivileged_bpf_disabled __read_mostly =
 	IS_BUILTIN(CONFIG_BPF_UNPRIV_DEFAULT_OFF) ? 2 : 0;
 
> [...]
