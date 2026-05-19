Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC09E3A873D
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 23:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779235018; cv=none; b=Oco/ZsbynkMpwgOVyckUIwwHie8MPsVdKkBADv49Gfrogio14j8B8DmNvAsoqyq4kWeYtPkgSUgOzJw5UTeCKryi+FZo23hsbLylcBRpbcv3Cwhpn9MXdMHUG7eyxe4yzaG6CW+TGanRKSv2zhjTMKWIlBi6BB6eB/XlyG1tiSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779235018; c=relaxed/simple;
	bh=clhLouqYW5aBjVaVbgARr7kElklBo3818qBkVUJ96pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ni7JnR1T3c/eghwll2JSjnIv0maPZ8g9bLQOzQcktyENVptvpX8R40XwuVoIlnc/V6YW6KppwlLPFYKZp3HOIHdruNrs3hbLym2zlP2mwvcFP6hzxgc2cCx9Xo0qjJEkkX01ysorKA8fPQo11dNaNxjApaWXMXMvrosJHkEtlnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TvUowGGh; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TvUowGGh"
Date: Tue, 19 May 2026 16:56:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779235004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DPEFO7kdxsh8SS4pTtrYEyGh/V9vDuaXz5keX2/Kf6s=;
	b=TvUowGGhwT0UEM3xRszwSTPbxDZvvYWNsYS9nU/IYFew6GiGEme8L5X/IeEXCKAA12nhyh
	PmhgTmBbDNyBRGvbSIGvxCxufl+kOpA1OKAz0Ov2lijGeD+mYASLuVVsXkSqHlNOj/HETp
	ma6pGD2BR/FaQy8Hz1reTEK92Ii04CQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 09/12] bpf: Add infrastructure to support
 attaching struct_ops to cgroups
Message-ID: <2026519225454.By6y.martin.lau@linux.dev>
References: <20260519215841.2984970-10-martin.lau@linux.dev>
 <20260519225002.986EB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519225002.986EB1F00893@smtp.kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue, May 19, 2026 at 10:50:02PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] bpf_cgroup_struct_ops_foreach does not skip dummy items, leading to unintended execution of cfi_stubs.
> - [High] Using a loadable module's cfi_stubs as a dummy sentinel causes a Use-After-Free when the module is unloaded and reloaded.
> - [Medium] The macro bpf_cgroup_struct_ops_foreach uses rcu_dereference(), which is incompatible with sleepable struct_ops programs.
> - [Medium] cgroup_bpf_struct_ops_register() lacks concurrency protection and global uniqueness enforcement.
> --
> 
> commit bad29e4e0d1357905491993ee45063766d0f7705
> Author: Martin KaFai Lau <martin.lau@kernel.org>
> 
> bpf: Add infrastructure to support attaching struct_ops to cgroups
> 
> This patch adds necessary infrastructure to attach a struct_ops
> map to a cgroup. The initial need was to support migrating
> the legacy BPF_PROG_TYPE_SOCK_OPS to a struct_ops.
> 
> > diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> > index b2e79c2b41d51..8080f4a5c14b6 100644
> > --- a/include/linux/bpf-cgroup.h
> > +++ b/include/linux/bpf-cgroup.h
> 
> [ ... ]
> 
> > @@ -110,6 +112,18 @@ struct bpf_prog_list {
> >  	u32 flags;
> >  };
> >  
> > +#define bpf_cgroup_struct_ops_foreach(var, item, cgrp, atype)		\
> > +	for (item = rcu_dereference((cgrp)->bpf.effective[atype])->items;\
> > +	     ((var) = READ_ONCE(item->kdata));				\
> > +	     item++)
> 
> [Severity: High]
> Does this macro need to skip dummy sentinel items?
> 
> In cgroups with BPF_F_ALLOW_MULTI, compute_effective_progs() inserts dummy
> sentinel items at the boundaries between cgroup levels. For struct_ops, this
> dummy is the cfi_stubs pointer.
> 
> This macro appears to iterate over all non-NULL items and fails to skip the
> dummy sentinel, which could cause the subsystem to repeatedly yield the
> cfi_stubs pointer as a valid attached struct_ops instance.

The ops in the cfi_stubs is safe to be called. It intentionally skips
checking for dummy in the fast path.

> 
> [Severity: Medium]
> Will this rcu_dereference() trigger Lockdep warnings for sleepable struct_ops
> programs?
> 
> The commit message mentions adding free_after_mult_rcu_gp to support a mix of
> sleepable and non-sleepable struct_ops, but plain rcu_dereference() enforces
> rcu_read_lock_held().
> 
> If a subsystem iterates the array while holding rcu_read_lock_trace()
> (required for sleepable execution), this might trigger a 'suspicious
> rcu_dereference_check() usage' warning. Conversely, if it holds
> rcu_read_lock(), the struct_ops program cannot sleep without causing a panic.

The proposed bpf_tcp_ops only has non-sleepable programs.

The future sleepable callsite will need another version of foreach or
rcu_dereference_check can be used here also. I think rcu_dereference_check
is better.

> 
> > +
> > +static inline bool cgroup_bpf_is_struct_ops_atype(enum cgroup_bpf_attach_type atype)
> > +{
> 
> [ ... ]
> 
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index a033aa479ab6e..d496db48d2b86 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> > @@ -24,6 +24,29 @@
> >  DEFINE_STATIC_KEY_ARRAY_FALSE(cgroup_bpf_enabled_key, MAX_CGROUP_BPF_ATTACH_TYPE);
> >  EXPORT_SYMBOL(cgroup_bpf_enabled_key);
> >  
> > +static u32 struct_ops_type_id[MAX_CGROUP_BPF_ATTACH_TYPE];
> > +static void *struct_ops_cfi_stubs[MAX_CGROUP_BPF_ATTACH_TYPE];
> > +static bool struct_ops_mult_rcu[MAX_CGROUP_BPF_ATTACH_TYPE];
> > +
> > +void cgroup_bpf_struct_ops_register(int atype, u32 type_id, void *cfi_stubs, bool mult_rcu)
> > +{
> > +	struct_ops_type_id[atype] = type_id;
> > +	struct_ops_cfi_stubs[atype] = cfi_stubs;
> > +	struct_ops_mult_rcu[atype] = mult_rcu;
> > +}
> 
> [Severity: Medium]
> Does this registration function need concurrency protection to prevent global
> array corruption?
> 
> If two modules are loaded concurrently and declare the same cgroup_atype, it
> seems this could cause a data race or silently overwrite the registered type_id
> and cfi_stubs of a legitimate module.

This will be a bug in the subsystems having the same cgroup_atype

but (the next one)...

> 
> > +
> > +static enum cgroup_bpf_attach_type find_atype_by_struct_ops_id(u32 type_id)
> 
> [ ... ]
> 
> >  static void *bpf_cgroup_array_dummy(enum cgroup_bpf_attach_type atype)
> >  {
> > +	if (cgroup_bpf_is_struct_ops_atype(atype))
> > +		return struct_ops_cfi_stubs[atype];
> >  	return bpf_prog_dummy();
> >  }
> 
> [Severity: High]
> Can using a loadable module's cfi_stubs as a dummy sentinel cause a
> use-after-free when the module is unloaded and reloaded?
> 
> If all maps are detached, the module providing the struct_ops can be unloaded,
> and its cfi_stubs memory freed. However, the cgroup's effective array might
> still retain the dangling pointer to the freed cfi_stubs if BPF_F_ALLOW_MULTI
> was set.
> 
> If the module is reloaded, cgroup_bpf_struct_ops_register() updates
> struct_ops_cfi_stubs[atype] with a new pointer. If a user then queries the
> cgroup via BPF_PROG_QUERY, the loop checks
> item->prog == bpf_cgroup_array_dummy(atype) to skip the dummy. Since the
> array contains the old freed pointer, it won't match the new cfi_stubs
> pointer, and the query loop might mistakenly treat the old dummy as a valid
> map, causing a use-after-free when calling bpf_struct_ops_kdata_map_id().

Agree. This will be an issue on BPF_PROG_QUERY when the module reload.
I did think about the module reload case but I have only considered the
rcu-reader in bpf_cgroup_struct_ops_foreach.
BPF_PROG_QUERY does not use rcu_read_lock and depends on cgroup_lock.
This will need to be addressed.
