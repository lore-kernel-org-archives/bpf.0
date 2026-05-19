Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAB3409601
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196947; cv=none; b=cgU+ofjmsuSPvOo+MZPcNrfaJWpT74q6BIETJGHRQhrrwAQ4doy1Q/jEdZups/I8Y/uW4nYWV9yxJ6yj0mAr25jZUJhwNlbQh/6xBFQYwGh8xrsBBlpgDZt6EdScKz13iYWw4kKnhki9urcD3+uw7Auzk9RyH2I6Ta6JWgrnbG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196947; c=relaxed/simple;
	bh=0lSsN3yRME43BVQ064v3VVYtv/Fs88oNA3dJlAHwo6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rS6Fbsztzo/UwZ4+0AyUj1UsvaDsCMnl0sIrxskxnC07HuBytemWXgDp4qUsCmD+Z7v1j8dE9Ddwl22Cecw4KW7vQ4ITCH9PxMPsfhXNidUveJLlJUrw+syZZWmS3O+4vSM0aQ27pTHw4TladfInLP2zJA4fE5C1a+Xun31FmIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWKDN3j6; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWKDN3j6"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7bf0b1a47b1so31366077b3.0
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 06:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779196945; x=1779801745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YeqGtxSLLes8JnE41jzfEL8H+7AZq/ARhCK19HzOKNQ=;
        b=AWKDN3j6gby02lJW1P7piWQt+U0dFNF414IgSc/nTNjT547PD1myd3oDKaMcOH2OWH
         gBzB0eyazBtbnLX0ZtPKxIUUVTACVEVoUIr0Z7kl22AWGZqRTwTu5CIyQ7SsbQZme7uH
         W6d3rTpUyJ4DzEm+nQZu4yJd7mlQLrB4a/5BtfUxdxah8YcgtPIDOc+bI0pi12O606eF
         RFvbcoKOf4uX+yuQVmehijuaB/Te8QlmzCso9lUBNsGksD39k/3UT0X7ItkK0PmigAc1
         IjWwrG+Ao3Dahqsp9wD64F+S+PHaZBZVGfJ5kLLCP71iE4BhTqfrtLMO+VlkWN0MD07B
         KaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779196945; x=1779801745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeqGtxSLLes8JnE41jzfEL8H+7AZq/ARhCK19HzOKNQ=;
        b=mGQPSx4j8HHW+0bmxhgTfhcDaGb2VSx9DBO42Z5yRwim+mzKJpZ1Tp7Wpc6VP2432H
         EfCmwEizJKI28OzLl3w9NOWdxUB5JYbJNvD/kXa/ea36kZBeDCxdrb82BpQ1UsG3o30/
         hjTamyJOGKIeS3UlRXQHzmr9TmdtssbO9QJuvGacXdbh+D89+KLg5YDfs0199yehJwIW
         4FMEiSxUZYluMgixr18msbs7vY8gDw3klRD9GRU8nya7jvmARamQ62P+HO9IDJoS1QtK
         XRlbwvJlf3KkM1eYMjuQkOPirO4RX/7TcaeAmdAsQpjGTZMWdZ+DNBMZ8UtRqG0KVShP
         pwNw==
X-Forwarded-Encrypted: i=1; AFNElJ9ElZRbJaJPLA8M7KpQjWEZLt+BZLkuJOjJMd+KuGFjR7z7eEfT9BtO2PycSG4XdMo3fcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP7XzLNhBWDdo2h7GdSeVim1uxRN3aPUDeoHptl5OGewHPmxfX
	/o7v4Dpn+EScJ30tCI659LHHNrEjo7u2qKReuupPruQUvEs3H3b0s31T
X-Gm-Gg: Acq92OGiShxHifNDW/L0ijgKbOV6ysHNLmMHn3HC0w2tnu88fwzhGWIJHKyEujjCnaS
	iP7+6SAgv8ZLkSPekoCwZBrjg2qoEKEmKySpE6++BjXYE7kzWIm+nJIYnvnZ+mCgaR5yOWqDAmu
	wfynwnbksdNp+gN3aIkNLfcJADfE1Z3PTWeYTOV01DEsRWMf0g7Jkf7oNFermAHCaIuxSPLFU80
	Gz+pnayx1qzO2ZFlAQJ609D0ShV5ADseQo4hredCt+AYrJWxt6Me6yuaWXFKNRAnNMo7KHzsUwk
	sgyH9t+QXCkb//V2IfP/y4iN71+vmPxKJUV9KZZk3hRWxcvARVvzsiCobvAb6D5h30VsO1NRtaI
	PfliErzp0HQIWrn6K9Sj83qOY9rrSWvf54PFUvpzCSrylvOBdo8QTEe6ei42AMZCK2xxe3ygvtH
	0jObN8WN5vXXbJsQsOODCFyjPi+Yqd+8135bwPxzTpfFlzwhi7WKYZROnzXQ==
X-Received: by 2002:a05:690c:a087:20b0:7bf:1433:8f52 with SMTP id 00721157ae682-7c95a86f8a4mr175888137b3.14.1779196944989;
        Tue, 19 May 2026 06:22:24 -0700 (PDT)
Received: from suesslenovo ([98.97.172.65])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cfbc6b97e9sm5440847b3.45.2026.05.19.06.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:22:24 -0700 (PDT)
Date: Tue, 19 May 2026 09:22:23 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org, mic@digikod.net, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: fix deadlock in special field
 destruction in NMI
Message-ID: <agxZBPjq7ee3hnoJ@suesslenovo>
References: <20260519011450.1144935-1-utilityemal77@gmail.com>
 <20260519011450.1144935-2-utilityemal77@gmail.com>
 <0fb7b7a8-9ff7-482d-a34a-694d31148941@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fb7b7a8-9ff7-482d-a34a-694d31148941@gmail.com>

On Tue, May 19, 2026 at 01:31:58PM +0100, Mykyta Yatsenko wrote:
> 
> 
> On 5/19/26 2:14 AM, Justin Suess wrote:
> > Relax bpf_obj_free_fields to only cancel/free async work in irq_disabled
> > contexts and defer unsafe free operations such as kptr dtors, list head
> > and rb root destruction to a later non-irq_disabled call driven by the
> > allocator or map free.
> > 
> > Detect fields that are unsafe to free under irqs_disabled at htab
> > creation time. When creating a hashtab with these fields, forcibly set
> > BPF_F_NO_PREALLOC and use the bpf memory allocator instead.
> > 
> > This must happen after the fields are checked, so convert the map to a
> > non-prealloc one if the special fields are present, but before the map
> > has been fully initialized.
> > 
> > Enable this fix for regular, percpu, and lru hashtabs.
> > 
> > This fixes a deadlock caused by updating/deleting map elements in an
> > NMI context by shifting the responsibility of freeing fields that are
> > unsafe to free in contexts like NMI to the memory allocators existing
> > mechanism for handling this.
> > 
> > Fixes: 14a324f6a67e ("bpf: Wire up freeing of referenced kptr")
> > Reported-by: Justin Suess <utilityemal77@gmail.com>
> > Closes: https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@gmail.com/
> > Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
> > Link: https://lore.kernel.org/bpf/DIG0ONMVOP0L.3QFYUPWFSKWI4@gmail.com/
> > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > ---
> 
> This is a v3 of the patch, it would be nice to include it in the subject
> (see how other people do that).
>
I did mention this in the cover letter and link to the patch.

I was debating whether to make this a v4 of the last series (I already did a v3 [1]),
but decided against it since this approach really doesn't share a single common line
of code with the previous series.

But I'm not familiar with the norms on this.

[1] https://lore.kernel.org/bpf/20260507175453.1140400-1-utilityemal77@gmail.com/


> >  kernel/bpf/hashtab.c | 93 +++++++++++++++++++++++++++++++++++++++-----
> >  kernel/bpf/syscall.c |  8 +++-
> >  2 files changed, 89 insertions(+), 12 deletions(-)
> > 
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 3dd9b4924ae4..0db1dc8ae0be 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -130,6 +130,16 @@ struct htab_btf_record {
> >  	u32 key_size;
> >  };
> >  
> > +static inline bool htab_has_nmi_special_fields(const struct bpf_htab *htab)
> > +{
> > +	const struct btf_record *rec = htab->map.record;
> > +
> > +	if (IS_ERR_OR_NULL(rec))
> > +		return false;
> > +	return rec->field_mask & (BPF_KPTR_REF | BPF_KPTR_PERCPU | BPF_UPTR |
> > +				  BPF_LIST_HEAD | BPF_RB_ROOT);
> > +}
> > +
> >  static inline bool htab_is_prealloc(const struct bpf_htab *htab)
> >  {
> >  	return !(htab->map.map_flags & BPF_F_NO_PREALLOC);
> > @@ -522,13 +532,53 @@ static int htab_set_dtor(struct bpf_htab *htab, void (*dtor)(void *, void *))
> >  	return 0;
> >  }
> >  
> > +static int htab_convert_to_non_prealloc(struct bpf_htab *htab)
> 
> This conversion is not ideal: deallocating/deinitializeing then
> constructing new map again is something we should try to avoid.
> 
> Is it possible to restructure map_create to parse btf and patch map_flags
> before allocation/initialization?
Agreed it's annoying.

The problem is map_check_bpf expects a bpf_map pointer.

So we must allocate the map before then with the existing map ops
definition as far as I can tell.

So we could do it but it would need to have a special case in the
__create_map function itself. Doable enough.
> 
> Or what sashiko suggests: explicitly reject this configuration 
> and return -EINVAL.
>
Yeah but that would just break userspace progs that use referenced kptrs
without the BPF_F_NO_PREALLOC flag.

That would be nice but it's too late to reject such a broad
configuration like that with an error.
> > +{
> > +	bool percpu = htab_is_percpu(htab);
> > +	int err;
> > +
> > +	htab_free_prealloced_fields(htab);
> > +	free_percpu(htab->extra_elems);
> > +	htab->extra_elems = NULL;
> > +	prealloc_destroy(htab);
> > +	htab->map.map_flags |= BPF_F_NO_PREALLOC;
> > +
> > +	err = bpf_mem_alloc_init(&htab->ma, htab->elem_size, false);
> > +	if (err)
> > +		return err;
> > +	if (percpu) {
> > +		err = bpf_mem_alloc_init(&htab->pcpu_ma,
> > +					 round_up(htab->map.value_size, 8),
> > +					 true);
> > +		if (err) {
> > +			bpf_mem_alloc_destroy(&htab->ma);
> > +			return err;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
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
> > +
> > +		if (htab_is_prealloc(htab)) {
> > +			err = htab_convert_to_non_prealloc(htab);
> > +			if (err)
> > +				return err;
> > +		}
> > +	}
> >  
> > -	if (htab_is_prealloc(htab))
> > -		return 0;
> >  	/*
> >  	 * We must set the dtor using this callback, as map's BTF record is not
> >  	 * populated in htab_map_alloc(), so it will always appear as NULL.
> > @@ -1355,7 +1405,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
> >  					  bool percpu, bool onallcpus)
> >  {
> >  	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> > -	struct htab_elem *l_new, *l_old;
> > +	struct htab_elem *l_new = NULL, *l_old;
> >  	struct hlist_nulls_head *head;
> >  	void *old_map_ptr = NULL;
> >  	unsigned long flags;
> > @@ -1387,8 +1437,17 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
> >  		goto err;
> >  
> >  	if (l_old) {
> > -		/* Update value in-place */
> > -		if (percpu) {
> > +		if (htab_has_nmi_special_fields(htab)) {
> > +			l_new = alloc_htab_elem(htab, key, value, key_size,
> > +						hash, percpu, onallcpus,
> > +						l_old, map_flags);
> > +			if (IS_ERR(l_new)) {
> > +				ret = PTR_ERR(l_new);
> > +				goto err;
> > +			}
> > +			hlist_nulls_add_head_rcu(&l_new->hash_node, head);
> > +			hlist_nulls_del_rcu(&l_old->hash_node);
> > +		} else if (percpu) {
> >  			pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
> >  					value, onallcpus, map_flags);
> >  		} else {
> > @@ -1408,6 +1467,8 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
> >  	}
> >  err:
> >  	htab_unlock_bucket(b, flags);
> > +	if (l_old && htab_has_nmi_special_fields(htab) && !ret)
> > +		free_htab_elem(htab, l_old);
> >  	if (old_map_ptr)
> >  		map->ops->map_fd_put_ptr(map, old_map_ptr, true);
> >  	return ret;
> > @@ -1443,7 +1504,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
> >  	 * to remove older elem from htab and this removal
> >  	 * operation will need a bucket lock.
> >  	 */
> > -	if (map_flags != BPF_EXIST) {
> > +	if (map_flags != BPF_EXIST || htab_has_nmi_special_fields(htab)) {
> >  		l_new = prealloc_lru_pop(htab, key, hash);
> >  		if (!l_new)
> >  			return -ENOMEM;
> > @@ -1460,11 +1521,21 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
> >  		goto err;
> >  
> >  	if (l_old) {
> > -		bpf_lru_node_set_ref(&l_old->lru_node);
> > +		if (htab_has_nmi_special_fields(htab)) {
> > +			pcpu_init_value(htab,
> > +					htab_elem_get_ptr(l_new, key_size),
> > +					value, onallcpus, map_flags);
> > +			hlist_nulls_add_head_rcu(&l_new->hash_node, head);
> > +			hlist_nulls_del_rcu(&l_old->hash_node);
> > +			bpf_lru_node_set_ref(&l_new->lru_node);
> > +			l_new = NULL;
> > +		} else {
> > +			bpf_lru_node_set_ref(&l_old->lru_node);
> >  
> > -		/* per-cpu hash map can update value in-place */
> > -		pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
> > -				value, onallcpus, map_flags);
> > +			/* per-cpu hash map can update value in-place */
> > +			pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
> > +					value, onallcpus, map_flags);
> > +		}
> >  	} else {
> >  		pcpu_init_value(htab, htab_elem_get_ptr(l_new, key_size),
> >  				value, onallcpus, map_flags);
> > @@ -1479,6 +1550,8 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
> >  		bpf_map_dec_elem_count(&htab->map);
> >  		bpf_lru_push_free(&htab->lru, &l_new->lru_node);
> >  	}
> > +	if (l_old && !ret && htab_has_nmi_special_fields(htab))
> > +		htab_lru_push_free(htab, l_old);
> >  	return ret;
> >  }
> >  
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 6600e126fbfb..1f52453d5a2f 100644
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
> > @@ -854,16 +856,18 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
> >  			}
> >  			break;
> >  		case BPF_UPTR:
> > +			if (irqs_disabled())
> > +				break;
> >  			/* The caller ensured that no one is using the uptr */
> >  			unpin_uptr_kaddr(*(void **)field_ptr);
> >  			break;
> >  		case BPF_LIST_HEAD:
> > -			if (WARN_ON_ONCE(rec->spin_lock_off < 0))
> > +			if (irqs_disabled() || WARN_ON_ONCE(rec->spin_lock_off < 0))
> >  				continue;
> >  			bpf_list_head_free(field, field_ptr, obj + rec->spin_lock_off);
> >  			break;
> >  		case BPF_RB_ROOT:
> > -			if (WARN_ON_ONCE(rec->spin_lock_off < 0))
> > +			if (irqs_disabled() || WARN_ON_ONCE(rec->spin_lock_off < 0))
> >  				continue;
> >  			bpf_rb_root_free(field, field_ptr, obj + rec->spin_lock_off);
> >  			break;
> 
