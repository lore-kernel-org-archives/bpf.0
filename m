Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0018E3FFAC1
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479691; cv=none; b=OyzZR047Jo3IgNg7T6JcYSXtzEEdPMmSPswhTXPG/dtuOCSwXSJdpApyiuuP9jr/E9wpUG88kcvUePKihw6UvyDpCe9NRzp1BzvaPIhazLNdnAFlMBJ1431YUFOzSHXhKeJZFxMJ8vzXD2xtGytAmi0MlSyZJi5vYhxQk1yn3dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479691; c=relaxed/simple;
	bh=WCAnlcxwdOIlOyAdaiuxv9FGr8p+Wyh3PPCfrmczmqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=By2xIQrDGPebbfB95y8vGq7u4c5KQsqJk4vLG/TRrswvrivLqr/oHWt1m/RARUrWxw029XNxXuq/L34QlGrYh5DcBz1jOXZPkrGbERmJ/kVcpdIJ+iyOsoHMto3QyHi/mlG6cxb9rWS9YQFQ6ca7unrtVuchms1bINly4gTakKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFyyzOcX; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFyyzOcX"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79ab5fd969aso145386977b3.0
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 09:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777479679; x=1778084479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=06R3T1Y3aEp10oLrnZ8YEpzCtemkOPFhtMCKYGC+Hwg=;
        b=RFyyzOcXArey2zgeECrr6t+8X/O7mk1pn7tDgOIZH0DtCDt80MICPKl45TVNsK3JfV
         IDKzZINlbLBtr/GxCUk7364GCNNDjW2N1I9Y0W9DRBGQZ+HgVjC0h6zUlTbG/9ElYZbP
         P7XdfF9yxvse/ug1JmtbzJeNzVGZ34VkMa+WuRo7BhBxdzB/8VDLDs9eaJeNc2KlTg91
         HUp7wRBwbZ5bQXiKyBO+SV4AhTebM3Q6Kah0c6EJM9WXv5Gwu10hnfjW9sNT4IQnZt/p
         Bq0o3nLJmP4Bx85kS1Y24tQakkTksVLcfv4NB7i8DI+p2TQXpGTr+GJLz2eQ+E40HssH
         f/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479679; x=1778084479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06R3T1Y3aEp10oLrnZ8YEpzCtemkOPFhtMCKYGC+Hwg=;
        b=HUpYae7YauBhbpPsXor2Ev2cdOVEuA2tGfcD9O/mViq/soCOBp6xHvXumlI7eHooKI
         Z9OdtPBYSPRViAj0hijdgFb9Ld+GRT9SQhILoDL5j10r0moibRa+ORZOxyERnYI+aXB6
         ISxDxfL4EPPzj0P2xcBNIAQr2zAqORQg1QnIONpgJNfmr79c7EpKKyYCKOiX4OBw4adQ
         tvoPWBLTuxAOBI21grWzxF7FJ4YOIVw+ztHjnuibpOZfY3bpxYxqU3urK/48LH6q/G3T
         6G+T4DZalXe3u4cMRQrawo81rhxMjLS1gC6vDU1U+zDBjiRdkjHehQwKl5I5dvcD7k4J
         Uq3g==
X-Forwarded-Encrypted: i=1; AFNElJ8dDuWMmofaXYF1ycppW8vrkVEyUEZpEgzQ/2sTqDaxGLYknKV9zSIzc8icnEcnG/KxbEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF0obbY9WreSfV1pgHkoRc7XlHYBzRkNhL00g9PRuJtabkBVNF
	Xwcil/BhVlSHWm7bNBus0JmIGIjt3OP0B1gOzmt1WnKflwU+23mMl3Tn
X-Gm-Gg: AeBDieuLVVRVJKcF7NI7cJ79DKlSrQbSgF0/PmczmkA+EvOlnxg9fM6J5u3tpk3hfS+
	Wd5yFjVspVQr+zwCNeE996TE+RmoHqgNBemhwbF7qr8rszb6DOiU/2oUIPeEDmlR/zDYXKdf8zn
	8rnGpglsfzaPl9IF2Qz4sMhW60PRfof7rcdOgYaoXbDp+dXc5kYD2Mpkbo4aAV9mK1lGQd35biR
	PPHqu11VwHYw9mUXmkwNmRjygC62GxqjERRFIojsJlQVYvKOTcyCPqyDKPI+kTbFuav/yQARDwP
	9G3lvkzuCKSpsZ+EOn1WyCIBDP0y07+25ehoBIFFGDvM4+iX5ywZKumCQ22KXFkwFB+5NOzWdn5
	X7M2BkQ/oPWO3Daw5Pa4jmAOYXJfBhSm4i/Lv1bjB/11IRK4KtMkaWrRInCidcKPK8EyhvwKCIo
	DMJTWoMom/jBgLIYh9z02AspD04FSxYaesFg6YFQeyet4bfOhEFUMTi5EioHqEtIW0O+A6IvA=
X-Received: by 2002:a05:690c:610f:b0:79e:62cf:8254 with SMTP id 00721157ae682-7bcf4fc8df9mr81254387b3.8.1777479678885;
        Wed, 29 Apr 2026 09:21:18 -0700 (PDT)
Received: from suesslenovo ([129.222.252.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd49fec67csm3833587b3.9.2026.04.29.09.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 09:21:18 -0700 (PDT)
Date: Wed, 29 Apr 2026 12:21:17 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/4] bpf: Fix deadlock in kptr dtor in nmi
Message-ID: <afIlTiyoJUqf2YBN@suesslenovo>
References: <20260428201422.1518903-1-utilityemal77@gmail.com>
 <20260428201422.1518903-4-utilityemal77@gmail.com>
 <DI5JDE24ICIE.1PAT8HWYK9ENS@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI5JDE24ICIE.1PAT8HWYK9ENS@gmail.com>

On Wed, Apr 29, 2026 at 02:37:32AM -0700, Alexei Starovoitov wrote:
> On Tue Apr 28, 2026 at 1:14 PM PDT, Justin Suess wrote:
> > Defer freeing of referenced kptrs using irq_work queue.
> >
> > This fixes a deadlock in BPF tracing programs running under NMI.
> >
> > Each kptr is tagged with an auxiliary data field storing an llist_node
> > and a pointer to the object to be freed. These are assembled together
> > to form a queue for deletion outside NMI.
> >
> > Add a field to each data structure capable of holding referenced kptrs
> > to store the llist_head, as well as an irq_work struct to the btf kptr
> > field to store the task callback.
> >
> > The llist_nodes are linked in the queue safely, allowing them to be torn
> > down once NMI is over.
> >
> > This irq_work struct is foribly synchronized on btf teardown, enabled by
> > the change in btf cleanup code introduced in the previous commit, adding
> > the rcu_work teardown.
> >
> > At dtor time, if the execution is in an nmi context, enqueue the
> > referenced kptr nodes in the llist_head and enqueue a job to drain the
> > list, calling the respective dtor callback from a safe context.
> >
> > If running outside nmi, use synchronous dtor path.
> >
> > This touches arraymap, hashtab, and bpf local storage. It's important to
> > note however, that the bpf_local_storage code rejects nmi updates
> > already, the code changes in that case are just to accommodate the changes
> > to the record extending the kptr.
> >
> > Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Reported-by: Justin Suess <utilityemal77@gmail.com>
> > Closes: https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@gmail.com/
> > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > ---
> >  include/linux/bpf.h            |  69 ++++++++++++
> >  kernel/bpf/arraymap.c          |  36 ++++++-
> >  kernel/bpf/bpf_local_storage.c |  13 ++-
> >  kernel/bpf/btf.c               |   6 +-
> >  kernel/bpf/hashtab.c           | 181 +++++++++++++++++++++++++++----
> >  kernel/bpf/syscall.c           | 190 +++++++++++++++++++++++++++++++--
> >  6 files changed, 456 insertions(+), 39 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 715b6df9c403..037bdadbed96 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -9,6 +9,8 @@
> >  
> >  #include <crypto/sha2.h>
> >  #include <linux/workqueue.h>
> > +#include <linux/irq_work.h>
> > +#include <linux/llist.h>
> >  #include <linux/file.h>
> >  #include <linux/percpu.h>
> >  #include <linux/err.h>
> > @@ -234,6 +236,10 @@ struct btf_field_kptr {
> >  	 * program-allocated, dtor is NULL,  and __bpf_obj_drop_impl is used
> >  	 */
> >  	btf_dtor_kfunc_t dtor;
> > +	struct irq_work irq_work;
> > +	struct llist_head irq_work_items;
> > +	struct llist_head free_list;
> > +	u32 aux_off;
> >  	u32 btf_id;
> >  };
> 
> This is extreme per-field overhead
> 500 extra lines to fix a corner case?
> That's not what I suggested. Can the whole thing will be
> done with _single_ global llist and irq_work? I bet yes.
> Think it through and send us prompt for review instead of code.
>
This is definitely over-engineered, I agree. I'm not the most
experienced at this so I appreciate the patience.

The main issue I'm running into is (avoiding) memory allocation in the
dtor path. My solution does *technically* avoid that, but causes a bunch
of other problems.

So we work in these constraints:

1. Even though BPF provides nmi safe allocation methods, it's not
acceptable in my understanding to allocate because memory exhaustion
will cause a failure to free.

2. We obviously can't do anything unsafe like spinlock, lock, block,
rcu, etc under nmi.

3. We need to defer dtor work from nmi for refcounted kptrs in nmi with
irq_work.

It's just the placement of the llist_node that I'm struggling with.
kptrs are just stored as memory addresses, there's no clean location
I can just stick a llist_node, (hence the auxiliary data hack I did),
and I can't just allocate it dynamically either.

---

What do you think of this general approach / prompt?

We make a global llist_head and irq_work queue for dtor work.

Whenever a slot in a map with a record containing refcounted kptr fields
is allocated, we allocate a struct per kptr field like

  struct bpf_kptr_free_slot {
    struct llist_node free_node;
    void *obj;
    void *elem;
    btf_dtor_kfunc_t dtor;
  };

Allocating it using the nmi safe bpf allocator in kernel/bpf/memalloc.c

(Allocating it at slot allocation time seems like the only reasonable way to
do it, since we can safely fail allocating new map items with -ENOMEM)

These structs would ideally be stored in some way that gives efficient
elem* to bpf_kptr_free_slot lookup. (and be nmi safe).

They would need to live outside the map itself.

Then at dtor time we look up the bpf_kptr_free_list for the elem, set
the obj to our pointer to be freed, set the dtor, and
link it into the global free llist_head.

Then we trigger the global irq_work.

Our irq work jobs will execute all the queued dtors and then free the
bpf_kptr_free_slot struct.

---

This still would add overhead, but it wouldn't require any changes to
the map structure itself.

Let me know what you think or if there is some obvious thing I'm
missing.

Justin
> pw-bot: cr
> 
