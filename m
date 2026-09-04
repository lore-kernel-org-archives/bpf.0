Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4F03955EE
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522436; cv=none; b=U8uGeXC9bq2AYgZeC2L/9QwkICG3mfwZuF/DeyoD5XK9XKvaUTUjS5jXWP4hrVj++6RLW+cg9x+Rt7QpXOvztJaXkUhjzvEm4kWr0Alfd3W5NHh6Nxlz8isP9rX2/K9P9obDfB7N2goaJPT4gDNwJCN388oOBPccoVBuoOdA8wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522436; c=relaxed/simple;
	bh=p/6coh/Nzx/9NxCUXUdiQ9rHLB0OE3Egl4Ql3ooPO8Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=isuow4vldzzorV4M/ZKP/COcJ9zKlA4AaJf+VqQYmTpPs2TQlKwJMpY76AyPTefJBpqdPOh5C37aFPxZZZlqG02u1pfI7iQnaCRaCb/4KT+lNhhEW2w8XPCXKi3vnEma0DJN2HwSJcebo/Nl7m4HA9QTyHLamZyLxjOWxJ/xNkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXeCN8MX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXeCN8MX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540DC1F00A3E;
	Fri,  4 Sep 2026 11:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788522435;
	bh=43pNV3PqSbzJSTLN3uHp6a6xFSTnwx2+OvRRbJ/f1H0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LXeCN8MXYRc5JMfg/iolc88KkFr/RLgWjvOEmTvOTViOFjeT0R/vPFTbWYN+IIl32
	 h7pzGqsbhN3cGYzEjCUUmZeXvCbuY2dFqsOQLVNZdik9LGcx9tNZjYiiYLiP3LVfxP
	 SoBV43AAJtLBdGBeg3VVpy67x/yn9/iaGVijDdwPqjUhZoFm3aMJMYOtkswgjoXI6v
	 hoRq2UNJAcGAxbSsuMQcehWgFP11xr8lGpfeVKB+WCEYfJWhMQoCZxM6UNIN5bP1Cb
	 vMl8npDIjQUOcbLmpPI1sMG8PyAenrzdLRxzuRQkUjupKEBsc7agEF/InTWggXPmdD
	 ra01cSSvoTEGw==
Content-Type: multipart/mixed; boundary="===============0703258521652121406=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <715a1a17b284104bd37351ee018a8ff3e211247cb8644fac1b4c45a3d89fa16a@mail.kernel.org>
In-Reply-To: <20260904104203.345917-4-memxor@gmail.com>
References: <20260904104203.345917-4-memxor@gmail.com>
Subject: Re: [PATCH bpf v1 3/8] bpf: Cancel special fields when recycling rhtab elements
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: gnq25@mails.tsinghua.edu.cn,yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 11:47:14 +0000 (UTC)

--===============0703258521652121406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 527cc5716ee8c..cc60e99ffbe92 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -2967,8 +2957,8 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
>  		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
>  		check_and_init_map_value(&rhtab->map, copy);
>  	}
> -	/* Release internal structs: kptr, bpf_timer, task_work, wq */
> -	rhtab_check_and_free_fields(rhtab, elem);
> +	bpf_obj_cancel_fields(&rhtab->map,
> +			      rhtab_elem_value(elem, rhtab->map.key_size));
>  	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
>  	return 0;
>  }

[ ... ]

> @@ -3009,7 +2999,6 @@ static int rhtab_map_lookup_and_delete_elem(struct bpf_map *map, void *key, void
>  static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *elem, void *value,
>  				      u64 map_flags)
>  {
> -	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>  	void *old_val = rhtab_elem_value(elem, map->key_size);
>
>  	if (map_flags & BPF_NOEXIST)
> @@ -3029,7 +3018,7 @@ static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *el
>  	 * kptrs/etc. still sit in the slot. Cancel them after the copy
>  	 * to match arraymap's update semantics.
>  	 */
> -	rhtab_check_and_free_fields(rhtab, elem);
> +	bpf_obj_cancel_fields(map, old_val);
>  	return 0;
>  }

A subsystem pattern flags this as potentially concerning: the BPF field
semantics guide states that map operations on field-capable map types that
copy values with copy_map_value() should use the corresponding
bpf_obj_free_fields() on updates. Should this update path still call
bpf_obj_free_fields() to handle kptr references?

rhtab_map_update_existing() overwrites a live map value in place with
copy_map_value_locked() at kernel/bpf/hashtab.c:3008-3010 and then calls
bpf_obj_cancel_fields(). Looking at kernel/bpf/helpers.c:5033,
bpf_obj_cancel_fields() resolves to bpf_map_free_internal_structs() which
only handles BPF_TIMER, BPF_WORKQUEUE and BPF_TASK_WORK:

void bpf_map_free_internal_structs(struct bpf_map *map, void *val)
{
        if (btf_record_has_field(map->record, BPF_TIMER))
                bpf_obj_free_timer(map->record, val);
        if (btf_record_has_field(map->record, BPF_WORKQUEUE))
                bpf_obj_free_workqueue(map->record, val);
        if (btf_record_has_field(map->record, BPF_TASK_WORK))
                bpf_obj_free_task_work(map->record, val);
}

BPF_MAP_TYPE_RHASH appears in the map_check_btf() allowlists for
BPF_KPTR_UNREF, BPF_KPTR_REF, BPF_KPTR_PERCPU and BPF_REFCOUNT in
kernel/bpf/syscall.c:1322-1338. After this change a BPF_EXIST or BPF_ANY
update of an existing rhtab element no longer immediately drops the
referenced kptr held by the value being replaced, and no longer zeroes an
unref kptr - the previous value's kptr stays visible through the new value
until the allocation is reclaimed by rhtab_mem_dtor().

Is this semantic change intentional? Looking at the current tree,
array_map_update_elem() also calls bpf_obj_cancel_fields() in
kernel/bpf/arraymap.c:419 and :427, and the non-prealloc htab free path uses
check_and_cancel_fields() via kernel/bpf/hashtab.c:843, so the
bpf_obj_free_fields()-on-update pattern in the guide may be stale relative
to these implementations. The allocator itself appears safe: bpf_ma_set_dtor()
installs rhtab_mem_dtor() as the bpf_mem_alloc destructor, and every
allocator exit path funnels through free_all() at
kernel/bpf/memalloc.c:265-277 which invokes the destructor, so kptr
references should be released when the allocation is finally destroyed. Is
the intent that rhtab now matches arraymap's deferred-release behaviour, and
if so, should the subsystem documentation be updated to reflect this?

Does the comment at kernel/bpf/hashtab.c:3017-3019 still accurately describe
what the code does? It states:

	/*
	 * copy_map_value() skips special-field offsets, so old timers/
	 * kptrs/etc. still sit in the slot. Cancel them after the copy
	 * to match arraymap's update semantics.
	 */

The comment says old "timers/kptrs/etc." are cancelled after the copy, but
bpf_obj_cancel_fields() only cancels BPF_TIMER, BPF_WORKQUEUE and
BPF_TASK_WORK. Referenced kptrs are deliberately left in the slot - that is
the whole point of this commit ("allowing rhtab_mem_dtor() to release
referenced kptrs when the allocation is eventually destroyed") and is
asserted by the follow-up selftest e5013fee53d7. A reader of this function
is told the opposite of what the code does. Should the comment be updated to
say that only the asynchronous fields are cancelled here and that referenced
kptrs stay attached to the allocation until rhtab_mem_dtor() runs?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33865340224
--===============0703258521652121406==--
