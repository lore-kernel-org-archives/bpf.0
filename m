Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41C71E32A2
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777732393; cv=none; b=ktAPRdvavSMc23fzbe3+g5qwgdnKVZqWjkmRG/80sT73qTnzmjGkK4OEWTBGHnjC9Pi8G5wJz8AwLBDyROd4dEdgFmfanLxJQEoPXQFd/QOMcZ53tq7lAwgDbKX7T6gJ2lM+R0cfUOPpBWEmojf6C8gt1TNJ3AcovbYjCS57okU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777732393; c=relaxed/simple;
	bh=Ycjij2m1+GD0Ju/n/0L9EnDuSHQzCGmE7f8De0YVGqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8ZlunoWASaCLpshcZqTSqbcSew4J4MeVrEvgvG1EjV/Zwv0MtxYl6i8sRxsGY/HM8Cb7AXnFh3+XUez5F2UV4Qyq2oKyeetwwTGrmXXVb7egfQytOIITt0K2AIdHf+Kl4/zjioZJcTRRbCA1ZV0EJ6ryMKd6d0CL1CtQ8TF36M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0Xbv1nl; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0Xbv1nl"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79a7109f568so32135227b3.1
        for <bpf@vger.kernel.org>; Sat, 02 May 2026 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777732391; x=1778337191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TE1Rjk0dGKZ73zaZgeBhUwwLM6y4VeuhT6IqZg9eHks=;
        b=a0Xbv1nlrUjbFcI1TypHjWh2zBPtV4KlQCbYgyP6aAbC4txGZdOqIZEmzzEUX03dtg
         BkiMnZy+AMdvba23TYe6BsluHkHCnj7L8jptziboGfXkObrsjvdbSsAp4/Z//ib/GJx4
         D8x3cQ0+dk3H1+ZxxJPlyd2unxS4mEODHC0TAzQqMSbg7cxiqb9P06q+QaVZPdUh9nuB
         mPlPkeGCbkwZqmtHAu4YEtf6wqH703KPOil9I8KoUSIsfy72rrPfoOM7X4H05n8JsE2t
         Yw4wSjoRyP3axtDfudILsN/ypVucHyvF/ZYlkhebebQLt+0M2ZJp4DXcrxqlPH72M6rc
         er1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777732391; x=1778337191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TE1Rjk0dGKZ73zaZgeBhUwwLM6y4VeuhT6IqZg9eHks=;
        b=DADXpyDbAeBvkJixoDYcRUrmsRcT/CXVCn6sJhNXwuPz3WGJi/dIJtFa6t631oExz3
         uk/FWmnQkojlCJatCFZPxGI8xQSaNSJ/RF3i3Wi88ALzfbhc/gI/KH9zjvMFnJXvrAt1
         rZyhi1A+ECOiVgIBoIit3TGwItgeFaVHwAhiLoTXlkDA5ca2IzFVgE2Q9E8waySzDs2g
         C2sd43GXLqQMYBDA8IC3er3ew0s2mUZdyLt45ksAgeXYILuUbI6WlftMRuztD11Hsw+v
         R+57W3WmrW+FlgwSx/lxtIMbrSlWvc2mNOz8cjU8SqtuA0IUMI2tSXeR42cGTm8h0Zeq
         HHnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+NDDsZhfgSYll5Pz934MQOJfCV7vyIY7HfWZ341EfNXBoUMYfqXKG+aqVuc+82S3sqvX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtKq0v4aKQxwEzA2S9WmhsKiI2iegeMIzbAOXCb94urwaITKGG
	0H375OnpoMP7Ysd0LZyPtdSl+vUyjMGwJFMlqZVg4RGOD1Pg2+zXMINTODRJ3dYy
X-Gm-Gg: AeBDiet0SlF1lb5ld7Lu1Xbe0XCTdPpYAquNMjwRHa9NkEiANGmgy8BrT1WiClcKWMq
	JAHm8Lzww8WfeFV2lQ4/loH3RwUEu2DbCXG5JWPiu5nlsy3AVg9TU2ENcuAb3a4fjKGqavQWzX2
	rc20oIhNNDr7dFOXTLhpW41xj+12QHPhLNXzGYSJbrJu852RWTUqPSk+yRNgSz/lkNN1B9XZy3X
	RIJuiS7jgvTxMuQi1X2rdTVTxZfXQuqM7o410IwGqBDRfpOBylzzdOpu3LlDLHFDJsG687Ef4ry
	DjFMLuyIJP0mgELlWanM5NRO41LNalzyYKyr52VtUMfXDZjCDWQ/sLIel4vDrdQ4a49dV384uIW
	NlN9jVGpl+oyVneIfPo2bm8vC1wz3ZqT0qVmEXXXNxXIBLTUml5TtAPwvDrkcQW4fyfFO+8RI7c
	k6fdVfD8b3UmdklOnCh0nAOB9M24JkYFLEvOYNOA4yifA+kTSB/h//LO4TU1JAKEdfIMRFAVXtT
	jDkcvU=
X-Received: by 2002:a05:690c:e730:b0:7bd:7039:f30a with SMTP id 00721157ae682-7bd7716b559mr28237237b3.48.1777732390597;
        Sat, 02 May 2026 07:33:10 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:5f64:60cd:95b2:822d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66837e34sm24546977b3.28.2026.05.02.07.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 07:33:10 -0700 (PDT)
Date: Sat, 2 May 2026 10:33:08 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/4] bpf: Fix deadlock in kptr dtor in nmi
Message-ID: <afYLJAT9brXkWxz2@zenbox>
References: <20260428201422.1518903-1-utilityemal77@gmail.com>
 <20260428201422.1518903-4-utilityemal77@gmail.com>
 <DI5JDE24ICIE.1PAT8HWYK9ENS@gmail.com>
 <afIlTiyoJUqf2YBN@suesslenovo>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afIlTiyoJUqf2YBN@suesslenovo>

On Wed, Apr 29, 2026 at 12:21:17PM -0400, Justin Suess wrote:
> On Wed, Apr 29, 2026 at 02:37:32AM -0700, Alexei Starovoitov wrote:
> > On Tue Apr 28, 2026 at 1:14 PM PDT, Justin Suess wrote:
> > > Defer freeing of referenced kptrs using irq_work queue.
> > >
> > > This fixes a deadlock in BPF tracing programs running under NMI.
> > >
> > > Each kptr is tagged with an auxiliary data field storing an llist_node
> > > and a pointer to the object to be freed. These are assembled together
> > > to form a queue for deletion outside NMI.
> > >
> > > Add a field to each data structure capable of holding referenced kptrs
> > > to store the llist_head, as well as an irq_work struct to the btf kptr
> > > field to store the task callback.
> > >
> > > The llist_nodes are linked in the queue safely, allowing them to be torn
> > > down once NMI is over.
> > >
> > > This irq_work struct is foribly synchronized on btf teardown, enabled by
> > > the change in btf cleanup code introduced in the previous commit, adding
> > > the rcu_work teardown.
> > >
> > > At dtor time, if the execution is in an nmi context, enqueue the
> > > referenced kptr nodes in the llist_head and enqueue a job to drain the
> > > list, calling the respective dtor callback from a safe context.
> > >
> > > If running outside nmi, use synchronous dtor path.
> > >
> > > This touches arraymap, hashtab, and bpf local storage. It's important to
> > > note however, that the bpf_local_storage code rejects nmi updates
> > > already, the code changes in that case are just to accommodate the changes
> > > to the record extending the kptr.
> > >
> > > Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > > Reported-by: Justin Suess <utilityemal77@gmail.com>
> > > Closes: https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@gmail.com/
> > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > ---
> > >  include/linux/bpf.h            |  69 ++++++++++++
> > >  kernel/bpf/arraymap.c          |  36 ++++++-
> > >  kernel/bpf/bpf_local_storage.c |  13 ++-
> > >  kernel/bpf/btf.c               |   6 +-
> > >  kernel/bpf/hashtab.c           | 181 +++++++++++++++++++++++++++----
> > >  kernel/bpf/syscall.c           | 190 +++++++++++++++++++++++++++++++--
> > >  6 files changed, 456 insertions(+), 39 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 715b6df9c403..037bdadbed96 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -9,6 +9,8 @@
> > >  
> > >  #include <crypto/sha2.h>
> > >  #include <linux/workqueue.h>
> > > +#include <linux/irq_work.h>
> > > +#include <linux/llist.h>
> > >  #include <linux/file.h>
> > >  #include <linux/percpu.h>
> > >  #include <linux/err.h>
> > > @@ -234,6 +236,10 @@ struct btf_field_kptr {
> > >  	 * program-allocated, dtor is NULL,  and __bpf_obj_drop_impl is used
> > >  	 */
> > >  	btf_dtor_kfunc_t dtor;
> > > +	struct irq_work irq_work;
> > > +	struct llist_head irq_work_items;
> > > +	struct llist_head free_list;
> > > +	u32 aux_off;
> > >  	u32 btf_id;
> > >  };
> > 
> > This is extreme per-field overhead
> > 500 extra lines to fix a corner case?
> > That's not what I suggested. Can the whole thing will be
> > done with _single_ global llist and irq_work? I bet yes.
> > Think it through and send us prompt for review instead of code.
> >
Alexei,

I did some more thinking and came up with a possible solution.

There is some pseudo-C code to make the idea easier to understand.

This approach involves hijacking the slab freepointer, and thus would
only work for slab allocated objects. (I'm not aware of any vmalloc
allocated referenced kptrs or if that's something needing to be
supported).

    When bpf_obj_free_fields is called, for each referenced kptr field
    that:

    a) is called from an nmi context, and;

    b) that kptr has a dtor field defined

    We take the following steps after the map slot has
    been zeroed but before the dtor runs:
    
    1. Hijack the slab freepointer slot for the object. This is only safe
       because we still have not run the dtor yet, and thus still hold a
       valid reference to the underlying kernel object, even though the
       pointer no longer exists in the map. We use the freepointer as an
       llist_node for our defered free list, storing the head in a percpu queue
       for later usage. The kasan_reset_tag is to avoid warnings from
       kasan.

       We do this like:
        struct kmem_cache *s;
        slab = virt_to_slab(obj);
        s = slab->slab_cache
        struct llist_node *node = (struct llist_node*)kasan_reset_tag(obj) + s->offset;
      
    2. We queue the irq_work to execute our dtor in
       hardirq context:

        llist_add(node, &our_dtor_work_llist)
        irq_work_queue(&our_workqueue)

    3. Once our work executes, we move all the items from our llist,
       allowing concurrent jobs to start pending again. We know that this
       is safe since we hold a valid reference still, because again, the
       dtor has not executed.

        llnode = llist_del_all(&our_dtor_work_llist);
        llist_for_each_safe(pos, tmp, llnode) {
		      // step 4
          void *obj = btf_kptr_llist_to_obj(pos);
          // step 5
		      if (obj)
			      our_dtor_metadata->dtor(obj);
        }
    4. We iterate through our llist. For every one of our pointers, we
       replace our hijacked entry's freepointer with the pointer to the
       current freelist head, un-hijacking it

        // returns the object for the hijacked free pointer and
        // un-hijacks it by relinking it into the freelist.
        static void *btf_kptr_llist_to_obj(struct llist_node *node)
        {
        	struct kmem_cache *s;
        	struct slab *slab;
        	void *object;
        
        	object = kasan_reset_tag(node);
        	slab = virt_to_slab(object);
        	if (WARN_ON_ONCE(!slab))
        		return NULL;
        
        	s = slab->slab_cache;
        	object -= s->offset;
        	btf_kptr_relink_freepointer(s, slab, object); // reset our freeepointer
        	return object;
        }

        static inline void btf_kptr_relink_freepointer(struct kmem_cache *s,
				       struct slab *slab, void *object)
        {
          /* atomics may be needed here instead */
        	void *fp = READ_ONCE(slab->freelist);
        
        	if (WARN_ON_ONCE(fp == object))
        		fp = NULL;
        
        	btf_kptr_set_freepointer(s, object, fp);
        }

    5. Finally, we call our destructor. The destructor is free to
       decide if it wants to free or not, since the freepointer is still
       valid because of step 4.

        if (obj)
			    our_dtor_metadata->dtor(obj);

Benefits of this:

1. We don't allocate any new memory. We basically abuse the freepointer
as space for nodes in our dtor queue

2. No changes to maps at all.

3. Doesn't require any new data structures on the BPF side.

4. Whole thing is about 215~ LOC, mostly for slab address helpers and
   the freelist pointer / relinking logic.

This approach requires including  "../../mm/slab.h", which is already
included by kernel/bpf/kmem_cache_iter.c.

This would definitely need a look at by mm, not sure
if freelist manipulation (abuse?) like this is OK.

I have a working POC, but going to hold off on this until I figure out if
this idea is the right way to do it.

Thanks for your time with this and I appreciate you pushing me to get
the right solution :) I'm learning a lot from this.

Justin Suess
