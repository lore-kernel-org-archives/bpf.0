Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1484E3794
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201771; cv=none; b=JQ32zEer04hZAq54H2xXZjJlCWNxnkS8XZgP+3PyBzT6YH6FRV2njUHMhvKMo1wVWDeh+BOSQlf4ogXdulZcEW7Vksut37PZB1f/Z9FKPonAtomgete80+WuzEtmJ7C7vhNYL0PR45CJi2r9gwvAOYGKW9e9kLgrwe/hyC7OMPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201771; c=relaxed/simple;
	bh=YWXRV+NQFDhT7ERt4QhzrnIt+wYuh2w0flQKS9YlgtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNbZX+8pUr5N7AU+Yz+GhuXoT6HJ8H+/g0stvWMyCrb+zJhPsOa/xvoQ3YV73QDjJnYuHXSn8zjjd/N8ZNiRHXxDlFaaHMRdgYqEhZhCwPFHyhX7G7W5tJC9HfhxjDGWwy00NQYxDCIx6IoK5jQ81sM1ug25exNBnZ86QZV+bM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbE5lVIi; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbE5lVIi"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7bd65714dcaso31152987b3.3
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 07:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779201765; x=1779806565; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SMJK+Q1KPAmdYgADquxXV0jIfAYvH6d0diFJCZ4DWlw=;
        b=cbE5lVIiaMecRQyYhY+xN9jv+6q/9F66IkHmbuVqshtOlV11EQ8TXcFTn11mVBVSB5
         uUTWhGMXhJd8tUYuHUShbhFqFA0ntNARVxPEA/1dLsFKXUB9eWZapygSHcf5dao9vwHG
         8jnjmY0sjZYrcK/bjovwKmmGA+d8Yzv7AAATGwxadOM9N90rfrY1SkVK60cqp1+IkMHA
         yK/EuG9CMN57BQ/S71H8OzqmTNkU4w+Si/c8HwdEVsKlLgHoOqPPy3arc5Od1CiNIQUV
         kdxJIv6Kbaejq7xI8NNSb4dqlIQPoOue/17gidkUWTm/+mdaky6ZfkleLoCjya7qJuar
         vxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201765; x=1779806565;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMJK+Q1KPAmdYgADquxXV0jIfAYvH6d0diFJCZ4DWlw=;
        b=lkAaq1I9csHZjcXke7eC4yRe0SWzXtMifPIZAqXFBCVKeswAFWL3oOT4qTatJzesCR
         vJFHM6JZquCQ2AdX5BuOfw7NuAju1bWTTL43gVGBA4QH/p2t0pKuRLTbwX6KlKo9aVIC
         PRpFPeMZCKPPFx7GDW8ciMh3/EMV8aONTCII0Sj8GVdu7/Fct9Cdh9qkGoKxXjMnaymv
         40BzTKG3MZzy/ES3WECX6LJPT7LWmsvgfffrjyXdtntNG5wRfMiLbToBdDt17vIOfFfa
         D4sO5v0f8PELhtg5uSXvbBhNv02qBbaLv7AlMKsMhma1Dcnh5NaQlr/VjJrsQywBmT8g
         6i1A==
X-Gm-Message-State: AOJu0Yxm+d8jYcqUXR73JUUfPOC90JG0ofIFBafjvA9hUoy5RDfLdvh2
	+uoY4FI57JlKWhziVvv3m8k/A/lVMcM8kq3VA7sBM7Q+4uOKRLeCogCVHK2Z6Q==
X-Gm-Gg: Acq92OHrkHsVdTnjoeSA2SIwmImYjfWum8rh1+YgoDSWQFUSr/CVIixJhABlNXXUhuU
	OpHMiGeqRp61at9P115kUVTiVJU/4q8+F3nKCc05UPuNDJDeozLZQ0Jv1wZ97qxX9adbRehiQWh
	v1xID75jC/JaMxzPLgXqMyn2ygYQ4/yOITuG8c04fVFMiWYEJQAdOcEX3NQI/nTLYjm1rhEHq97
	EiqEHrpLblCN+yHWuLEApWjDF3DosFQPb/zrTZoBq1I5sAIU2qqBfivpUTp5Ja6Dfn8e8yhjnc+
	tOa350b8TsfHMrBf2Q0repXoSDhVY/gJU21MrFK7wS00RkNW2IBPsJGDhXl3aoiCoMFU6yUw2uY
	Vl7aNJc0ZLFM4O43UvxE8M9xpND6jtaokmSqMSpXeJl4bQuKgpSi2wKhMTJScCxY7Yky67Pm3bW
	0xHGk8iVqunknbHcYM+W3YNYVKv1z9wWZVhuzYbwm7ts7MKJRIg7sQ8hVJqA==
X-Received: by 2002:a05:690c:dd3:b0:7b8:926e:3f0d with SMTP id 00721157ae682-7c95c6f6efbmr208816987b3.26.1779201765187;
        Tue, 19 May 2026 07:42:45 -0700 (PDT)
Received: from suesslenovo ([98.97.172.65])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9cda1a38sm37276747b3.43.2026.05.19.07.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:42:44 -0700 (PDT)
Date: Tue, 19 May 2026 10:42:44 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/1] bpf: fix deadlock in special field
 destruction in NMI
Message-ID: <agxkV-hsdwhvMliI@suesslenovo>
References: <20260519011450.1144935-2-utilityemal77@gmail.com>
 <20260519015123.36096C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519015123.36096C2BCB7@smtp.kernel.org>

On Tue, May 19, 2026 at 01:51:22AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Critical] LRU maps containing NMI-unsafe fields (like BPF_KPTR_REF or BPF_LIST_HEAD) will permanently leak these fields and corrupt map state when updated or deleted in an IRQ-disabled context.
> - [High] Modifying the generic `bpf_obj_free_fields()` to silently skip destruction in IRQ-disabled contexts causes permanent memory leaks for callers lacking deferred destructors (like `bpf_obj_drop` and Array maps).
> - [Medium] Forcibly mutating the user-requested `map_flags` to include `BPF_F_NO_PREALLOC` silently breaks performance expectations and UAPI transparency.
> --
> 
> commit 3fbec1aa4107fa1f73249893a4ed21fd7d2213fa
> Author: Justin Suess <utilityemal77@gmail.com>
> 
> bpf: fix deadlock in special field destruction in NMI
> 
> This commit relaxes bpf_obj_free_fields() to skip async work cancellation
> and unsafe free operations in IRQ-disabled contexts. It converts hash maps
> with NMI-unsafe fields to non-preallocated maps using bpf_mem_alloc to
> defer the cleanup. LRU maps and preallocated hash maps are adjusted to
> support this mechanism.
> 
> Closes: https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@gmail.com/
> Link: https://lore.kernel.org/bpf/DIG0ONMVOP0L.3QFYUPWFSKWI4@gmail.com/
> 
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 3dd9b4924ae4f..0db1dc8ae0bec 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> [ ... ]
> > @@ -522,13 +532,53 @@ static int htab_set_dtor(struct bpf_htab *htab, void (*dtor)(void *, void *))
> >  	return 0;
> >  }
> >  
> > +static int htab_convert_to_non_prealloc(struct bpf_htab *htab)
> > +{
> > +	bool percpu = htab_is_percpu(htab);
> > +	int err;
> > +
> > +	htab_free_prealloced_fields(htab);
> > +	free_percpu(htab->extra_elems);
> > +	htab->extra_elems = NULL;
> > +	prealloc_destroy(htab);
> > +	htab->map.map_flags |= BPF_F_NO_PREALLOC;
> 
> Does mutating the map flags post-creation to include BPF_F_NO_PREALLOC alter
> the memory model and user-visible flags without warning? If userspace queries
> the map info via bpf_map_get_info_by_fd(), will it see flags it never
> requested?
Changing the userspace visible flag was done to provide visibility into
the change.
> 
> Would it be better to explicitly reject this configuration and return -EINVAL
> rather than secretly altering the underlying memory model?
>
That would break existing progs unacceptably, including the common case
of a normal hashtab with ref kptrs and no BPF_F_NO_PREALLOC flag.
> [ ... ]
> >  static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
> >  			      const struct btf_type *key_type, const struct btf_type *value_type)
> >  {
> >  	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> > +	int err;
> > +
> > +	if (!htab_has_nmi_special_fields(htab)) {
> > +		if (htab_is_prealloc(htab))
> > +			return 0;
> > +	} else {
> > +		if (htab_is_lru(htab))
> > +			return 0;
> 
> Since LRU maps are exempted from conversion to non-preallocated mode here,
> they do not use bpf_mem_alloc and completely lack the deferred destructor
> mechanism relied upon by this patch.
> 
> When an LRU element is replaced or deleted, htab_lru_push_free() is called
> and synchronously invokes check_and_free_fields() which eventually calls
> bpf_obj_free_fields().
> 
> If this executes in an IRQ-disabled context, will the new if
> (irqs_disabled()) checks in bpf_obj_free_fields() silently skip freeing
> the special fields?
> 
> Does this cause a permanent memory leak since the element is then
> immediately pushed back to the LRU free list? When the element is
> subsequently popped and reused, could it inherit stale pointers and
> corrupt map state?
> 
It doesn't cause a memory leak.

It does have the potential to reuse slots with existing pointers, but they
aren't "stale" they are valid pointers that are recycled until bpf_obj_free_fields
gets called on them in a non-irqs_disabled context which can happen on
another delete / LRU trim / an xchg out and release / map
destruction.

> [ ... ]
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 6600e126fbfb4..1f52453d5a2f1 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -839,6 +839,8 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
> >  			break;
> >  		case BPF_KPTR_REF:
> >  		case BPF_KPTR_PERCPU:
> > +			if (irqs_disabled())
> > +				break;
> >  			xchgd_field = (void *)xchg((unsigned long *)field_ptr, 0);
> >  			if (!xchgd_field)
> >  				break;
> 
> Because bpf_obj_free_fields() is a generic helper used throughout the BPF
> subsystem, does silently skipping destruction in IRQ-disabled contexts
> cause leaks for callers that lack deferred destructors?
> 
> For example, if a BPF program running in an NMI or kprobe drops an object
> containing nested kptrs via __bpf_obj_drop_impl(), will the nested fields
> be skipped and permanently leaked when the outer object is queued for
> freeing via bpf_global_ma?
>
Looks like this kfunc also tries to eagerly free fields and is callable
from tp_btf/nmi_handler with no recovery mechanism.

I don't see a good way to handle this at all... it also is effectively
already bugged in the existing code unless I'm missing something

Since you can use it to call abritrary dtors in NMI.

1. 

In some context where task_acquire is valid:

struct blah {
  struct task_struct __kptr* task;
}

b = bpf_task_acquire(...)
a = bpf_obj_new(typeof(*blah_ptr));
bpf_kptr_xchg(a->task, b);

2. 

Then xchg a into map
bpf_kptr_xchg([map slot], a);
...

3. 

In tp_btf/nmi_handler we exchange the obj out of the map
and then drop it.

c = bpf_kptr_xchg([slot where a is stored], NULL);
bpf_obj_drop(c); 

And because this can be called on an object not in a map, we don't have
a good recovery mechanism.

Because tp_btf/nmi_handler is always in_nmi and hence irqs_disabled, in
the code before this patch the task_struct dtor will be invoked and
cause a deadlock.

This patch will not fix the issue and just free a struct blah holding the
reference without actually dropping it.

Unless I'm missing something then this whole approach taken by this
patch can't handle this case since the bpf_obj is detached from the map
entirely and has no allocator recovery mechanism at all.

Then we are back to square 1 needing to defer the freeing with irq work.

Kumar / Alexei do you have anything on this?


> Does this similarly affect in-place updates to Array maps which rely on
> bpf_obj_free_fields() to clear old special fields?
> 
Basically existing behavior (undocumented) is that bpf_map_update_elem
won't copy kptr fields timers or spinlocks. (see copy_map_value, and
bpf_obj_memcpy).

So those fields can never be overwritten from bpf_map_update_elem on an
array.

The only thing that really changes is that now instead of trying to free
the existing map slot value on update we just leave it alone if
irqs_disabled().

It's definitely a behavioral change either way. And it may be worth
extending the bpf_obj_memcpy/copy_map_value exceptions to the other
types covered in this patch.

This was discussed here. [1]

[1] https://lore.kernel.org/bpf/CAP01T75942V+wKJD0yhs8yb7U5vj+y9s6efJ+UdpTMfzP31CWg@mail.gmail.com/
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260519011450.1144935-2-utilityemal77@gmail.com?part=1
