Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8472C08C8
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599540; cv=none; b=c/c4ePM8THYfy4mrBpsfOEO1RFq3ZhQLqhOhWDjI6pbLqN2s3TfRfO7a5g2W5/WzBwcI1ii58cPmeniwJnRb21ZksEG12M3EupoQO2OaqtCKz8+adwxgYnmfEmjgNKAsjaIHa2c+3snyGHNLxxQooAyvU9ItoZi5gOTPqkZ/OfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599540; c=relaxed/simple;
	bh=iRhuW2D0MJkjPvq03XOi2nouuhYE1DV4CBYM3nGI1sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VG22AWMXIz8fxLw3wX/TkOR7LS3lP1I32e/BoG7dznosCuVquMupLCsnnOwg2jX4WO2MAgT1JeGVuK7tiS0/SsqBscifsk93b5wSth5Fi21w7jSK/O8n1N8PLzLO8+kjGZok2XcIyCg/tH6kegum0/3480Am9jZpUZ03vSDKctE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FsFV92uo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FsFV92uo"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b885d8f4092so942046866b.2
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 03:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769599536; x=1770204336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cB4a/XPi6BJnstGaPUtwWX/2DGaqsFO6UK5snRzHDRQ=;
        b=FsFV92uoeqB9Ygo571DEwkbipjqJidQ7X0AJ0ZkznyPpri/571y5FdDxJ8nPCA0S5t
         r6gJywzs0q4gMa+9HKpHg3wvCF70p7x8CYgsyDNFcO6Sohx+7fFakn3He38o3U4ee5Yn
         NlqlBmVxm1Dva2Ow3ZARG5Th1A+li6Chs7NMAUmAemDsTWuOFyMtha1n2GJlZlAiXt58
         /YQmdh8+q2yeyqUikwJJt9+ExvE9sOVUtM2wOGz0hQnPkdr0KGx5/uoehdDTpKKgUlTC
         2fUPIq2COORp92avCEJkGCzYCy7zscFxLNgxZsC5mrMsPjJl77EngR15e6HQYceZKAYU
         vlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769599536; x=1770204336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cB4a/XPi6BJnstGaPUtwWX/2DGaqsFO6UK5snRzHDRQ=;
        b=Gh75hRvnv43/YD4T1L5Ip905yuDZgaykpQzQjEZgFnynCSypIDVdkkH8EZlFf/Sai/
         3o5jmWIIzhKwU60uHqhXq+EOwFmL3RIRY6uw5Sa3pfQTrsVn2umi+7UNMmgRE4ii7ur6
         kgx4W4TRWz/ilhhXohFpCLEhrJJl8+7CgOE1z6CT4Z/1Ce7pf4xuyXIwl82M78SgKfGD
         HnZ26pVW3bXuvjdQP+j6ismjxP2h9FbRyUfoBqUI2lx3pKjHagn0cHj8mmsQzPzVFW9e
         ljwERb42GH90DgePnNkTsAbKujVYSH3x5nkUjlpmAxfEHW2Prt9Y7pfxF3BtwUkOV1IE
         BbDw==
X-Gm-Message-State: AOJu0YxABAMXqHWBhyXAhdbt67q62bMaCVLWRhlNyc2DAYXpxCCd48Ut
	0gZbOhjWKOA/uGkaI8K6QXW4SIgs1Vavd59Vlu2OUOkc/LD6CX31w01pHwnvCLXOaQ==
X-Gm-Gg: AZuq6aKj82EeESVinUN6VZx019ZMXOErIlagDLQMjlBxwudwhz4PtebmrJVtKCFlDmx
	1TcjdqofntnW9ggyYKqXHJhiFD0vWTuAI9tXMThKRBSWpnFXybOjWgaYOTp2afgvkK7cjQEyjo4
	aXtLsiKeXS8DQDfcANvPE37Bzm75EMrgmm1q+x7eQtKpCcb/faowONrYfmwlA8GcEYGAPp52JxB
	VeuiMMzMXH5KcHE4XO+T5LeQaKWXUUnU3/iqB9aD/MeMk4+RH5s9quQx7PGQA0g7TcukMaLCh6D
	VV4ye6+Wfyy+cBxoqT1GdDOjI6Jof3tAkLDlwnpB7jChLqOL4bdyuGu3so+ssfnAvPv6nY+mTT8
	1Sq45K+cFxPRA8PO83n96raYT20KURnmT0ByRChXNi6LsDG8NfgxlNgoizhrLj4V1Yv52089Fxx
	kOjP4L0uMFwx8kdhgrdYzL+8WvCyHO3S93JbMrFAlISXRotbrirL0=
X-Received: by 2002:a17:907:1c27:b0:b88:6542:86a0 with SMTP id a640c23a62f3a-b8dab39a855mr385588666b.54.1769599535959;
        Wed, 28 Jan 2026 03:25:35 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbefc667asm116547566b.22.2026.01.28.03.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:25:35 -0800 (PST)
Date: Wed, 28 Jan 2026 11:25:31 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 02/17] bpf: allow attaching struct_ops to
 cgroups
Message-ID: <aXnyKw5sRt_MB-8A@google.com>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <20260127024421.494929-3-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127024421.494929-3-roman.gushchin@linux.dev>

On Mon, Jan 26, 2026 at 06:44:05PM -0800, Roman Gushchin wrote:
> Introduce an ability to attach bpf struct_ops'es to cgroups.
> 
> From user's standpoint it works in the following way:
> a user passes a BPF_F_CGROUP_FD flag and specifies the target cgroup
> fd while creating a struct_ops link. As the result, the bpf struct_ops
> link will be created and attached to a cgroup.
> 
> The cgroup.bpf structure maintains a list of attached struct ops links.
> If the cgroup is getting deleted, attached struct ops'es are getting
> auto-detached and the userspace program gets a notification.
> 
> This change doesn't answer the question how bpf programs belonging
> to these struct ops'es will be executed. It will be done individually
> for every bpf struct ops which supports this.
> 
> Please, note that unlike "normal" bpf programs, struct ops'es
> are not propagated to cgroup sub-trees.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  include/linux/bpf-cgroup-defs.h |  3 ++
>  include/linux/bpf-cgroup.h      | 16 +++++++++
>  include/linux/bpf.h             |  3 ++
>  include/uapi/linux/bpf.h        |  3 ++
>  kernel/bpf/bpf_struct_ops.c     | 59 ++++++++++++++++++++++++++++++---
>  kernel/bpf/cgroup.c             | 46 +++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h  |  1 +
>  7 files changed, 127 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
> index c9e6b26abab6..6c5e37190dad 100644
> --- a/include/linux/bpf-cgroup-defs.h
> +++ b/include/linux/bpf-cgroup-defs.h
> @@ -71,6 +71,9 @@ struct cgroup_bpf {
>  	/* temp storage for effective prog array used by prog_attach/detach */
>  	struct bpf_prog_array *inactive;
>  
> +	/* list of bpf struct ops links */
> +	struct list_head struct_ops_links;
> +
>  	/* reference counter used to detach bpf programs after cgroup removal */
>  	struct percpu_ref refcnt;
>  
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 2f535331f926..a6c327257006 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -423,6 +423,11 @@ int cgroup_bpf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
>  int cgroup_bpf_prog_query(const union bpf_attr *attr,
>  			  union bpf_attr __user *uattr);
>  
> +int cgroup_bpf_attach_struct_ops(struct cgroup *cgrp,
> +				 struct bpf_struct_ops_link *link);
> +void cgroup_bpf_detach_struct_ops(struct cgroup *cgrp,
> +				  struct bpf_struct_ops_link *link);
> +
>  const struct bpf_func_proto *
>  cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
>  #else
> @@ -451,6 +456,17 @@ static inline int cgroup_bpf_link_attach(const union bpf_attr *attr,
>  	return -EINVAL;
>  }
>  
> +static inline int cgroup_bpf_attach_struct_ops(struct cgroup *cgrp,
> +					       struct bpf_struct_ops_link *link)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline void cgroup_bpf_detach_struct_ops(struct cgroup *cgrp,
> +						struct bpf_struct_ops_link *link)
> +{
> +}
> +
>  static inline int cgroup_bpf_prog_query(const union bpf_attr *attr,
>  					union bpf_attr __user *uattr)
>  {
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 899dd911dc82..391888eb257c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1894,6 +1894,9 @@ struct bpf_raw_tp_link {
>  struct bpf_struct_ops_link {
>  	struct bpf_link link;
>  	struct bpf_map __rcu *map;
> +	struct cgroup *cgroup;
> +	bool cgroup_removed;
> +	struct list_head list;
>  	wait_queue_head_t wait_hup;
>  };
>  
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 44e7dbc278e3..28544e8af1cd 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1237,6 +1237,7 @@ enum bpf_perf_event_type {
>  #define BPF_F_AFTER		(1U << 4)
>  #define BPF_F_ID		(1U << 5)
>  #define BPF_F_PREORDER		(1U << 6)
> +#define BPF_F_CGROUP_FD		(1U << 7)
>  #define BPF_F_LINK		BPF_F_LINK /* 1 << 13 */
>  
>  /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
> @@ -6775,6 +6776,8 @@ struct bpf_link_info {
>  		} xdp;
>  		struct {
>  			__u32 map_id;
> +			__u32 :32;
> +			__u64 cgroup_id;
>  		} struct_ops;
>  		struct {
>  			__u32 pf;
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index de01cf3025b3..2e361e22cfa0 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -13,6 +13,8 @@
>  #include <linux/btf_ids.h>
>  #include <linux/rcupdate_wait.h>
>  #include <linux/poll.h>
> +#include <linux/bpf-cgroup.h>
> +#include <linux/cgroup.h>
>  
>  struct bpf_struct_ops_value {
>  	struct bpf_struct_ops_common_value common;
> @@ -1220,6 +1222,10 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
>  		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
>  		bpf_map_put(&st_map->map);
>  	}
> +
> +	if (st_link->cgroup)
> +		cgroup_bpf_detach_struct_ops(st_link->cgroup, st_link);
> +
>  	kfree(st_link);
>  }
>  
> @@ -1228,6 +1234,7 @@ static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *link,
>  {
>  	struct bpf_struct_ops_link *st_link;
>  	struct bpf_map *map;
> +	u64 cgrp_id = 0;

Assigning 0 to cgrp_id would technically be incorrect, right? Like,
cgroup_id() for !CONFIG_CGROUPS default to returning 1, and for
CONFIG_CGROUPS the ID allocation is done via the idr_alloc_cyclic()
API using a range between 1 and INT_MAX. Perhaps here it serves as a
valid sentinel value? Is that the rationale?

In general, shouldn't all the cgroup related logic within this source
file be protected by a CONFIG_CGROUPS ifdef? For example, both
cgroup_get_from_fd() and cgroup_put() lack stubs when building with
!CONFIG_CGROUPS.

>  	st_link = container_of(link, struct bpf_struct_ops_link, link);
>  	rcu_read_lock();
> @@ -1235,6 +1242,14 @@ static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *link,
>  	if (map)
>  		seq_printf(seq, "map_id:\t%d\n", map->id);
>  	rcu_read_unlock();
> +
> +	cgroup_lock();
> +	if (st_link->cgroup)
> +		cgrp_id = cgroup_id(st_link->cgroup);
> +	cgroup_unlock();
> +
> +	if (cgrp_id)
> +		seq_printf(seq, "cgroup_id:\t%llu\n", cgrp_id);

Probably could introduce a simple inline helper for the
cgroup_lock()/cgroup_id()/cgroup_unlock() dance that's going on in
here and bpf_struct_ops_map_link_fill_link_info() below.

>  }
>  
>  static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
> @@ -1242,6 +1257,7 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
>  {
>  	struct bpf_struct_ops_link *st_link;
>  	struct bpf_map *map;
> +	u64 cgrp_id = 0;
>  
>  	st_link = container_of(link, struct bpf_struct_ops_link, link);
>  	rcu_read_lock();
> @@ -1249,6 +1265,13 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
>  	if (map)
>  		info->struct_ops.map_id = map->id;
>  	rcu_read_unlock();
> +
> +	cgroup_lock();
> +	if (st_link->cgroup)
> +		cgrp_id = cgroup_id(st_link->cgroup);
> +	cgroup_unlock();
> +
> +	info->struct_ops.cgroup_id = cgrp_id;

As mentioned above a simple inline helper could simply yield the
following here:

...
	  info->struct_ops.cgroup_id = bpf_struct_ops_lin_cgroup_id();
...

>  	return 0;
>  }
>  
> @@ -1327,6 +1350,9 @@ static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
>  
>  	mutex_unlock(&update_mutex);
>  
> +	if (st_link->cgroup)
> +		cgroup_bpf_detach_struct_ops(st_link->cgroup, st_link);
> +
>  	wake_up_interruptible_poll(&st_link->wait_hup, EPOLLHUP);
>  
>  	return 0;
> @@ -1339,6 +1365,9 @@ static __poll_t bpf_struct_ops_map_link_poll(struct file *file,
>  
>  	poll_wait(file, &st_link->wait_hup, pts);
>  
> +	if (st_link->cgroup_removed)
> +		return EPOLLHUP;
> +
>  	return rcu_access_pointer(st_link->map) ? 0 : EPOLLHUP;
>  }
>  
> @@ -1357,8 +1386,12 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>  	struct bpf_link_primer link_primer;
>  	struct bpf_struct_ops_map *st_map;
>  	struct bpf_map *map;
> +	struct cgroup *cgrp;
>  	int err;
>  
> +	if (attr->link_create.flags & ~BPF_F_CGROUP_FD)
> +		return -EINVAL;
> +

BPF_F_CGROUP_FD is dependent on the cgroup subsystem, therefore it
probably makes some sense to only accept BPF_F_CGROUP_FD when
CONFIG_BPF_CGROUP is enabled, otherwise -EOPNOTSUPP?

I'd also probably rewrite this such that we do:

...
	struct cgroup *cgrp = NULL;
	...
	if (attr->link_create.flags & ~BPF_F_CGROUP_FD) {
#if IS_ENABLED(CONFIG_CGROUP_BPF)
	cgrp = cgroup_get_from_fd(attr->link_create.target_fd);
	if (IS_ERR(cgrp))
		return PTR_ERR(cgrp);
#else
	return -EOPNOTSUPP;
#endif
	}
...
	if (cgrp) {
		link->cgroup = cgrp;
		if (cgroup_bpf_attach_struct_ops(cgrp, link)) {
		   cgroup_put(cgrp);
		   goto err_out;
		}
	}

IMO the code is cleaner and reads better too.

>  	map = bpf_map_get(attr->link_create.map_fd);
>  	if (IS_ERR(map))
>  		return PTR_ERR(map);
> @@ -1378,11 +1411,26 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>  	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map_lops, NULL,
>  		      attr->link_create.attach_type);
>  
> +	init_waitqueue_head(&link->wait_hup);
> +
> +	if (attr->link_create.flags & BPF_F_CGROUP_FD) {
> +		cgrp = cgroup_get_from_fd(attr->link_create.target_fd);
> +		if (IS_ERR(cgrp)) {
> +			err = PTR_ERR(cgrp);
> +			goto err_out;
> +		}
> +		link->cgroup = cgrp;
> +		err = cgroup_bpf_attach_struct_ops(cgrp, link);
> +		if (err) {
> +			cgroup_put(cgrp);
> +			link->cgroup = NULL;
> +			goto err_out;
> +		}
> +	}
> +
>  	err = bpf_link_prime(&link->link, &link_primer);
>  	if (err)
> -		goto err_out;
> -
> -	init_waitqueue_head(&link->wait_hup);
> +		goto err_put_cgroup;
>  
>  	/* Hold the update_mutex such that the subsystem cannot
>  	 * do link->ops->detach() before the link is fully initialized.
> @@ -1393,13 +1441,16 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>  		mutex_unlock(&update_mutex);
>  		bpf_link_cleanup(&link_primer);
>  		link = NULL;
> -		goto err_out;
> +		goto err_put_cgroup;
>  	}
>  	RCU_INIT_POINTER(link->map, map);
>  	mutex_unlock(&update_mutex);
>  
>  	return bpf_link_settle(&link_primer);
>  
> +err_put_cgroup:
> +	if (link && link->cgroup)
> +		cgroup_bpf_detach_struct_ops(link->cgroup, link);
>  err_out:
>  	bpf_map_put(map);
>  	kfree(link);
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 69988af44b37..7b1903be6f69 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -16,6 +16,7 @@
>  #include <linux/bpf-cgroup.h>
>  #include <linux/bpf_lsm.h>
>  #include <linux/bpf_verifier.h>
> +#include <linux/poll.h>
>  #include <net/sock.h>
>  #include <net/bpf_sk_storage.h>
>  
> @@ -307,12 +308,23 @@ static void cgroup_bpf_release(struct work_struct *work)
>  					       bpf.release_work);
>  	struct bpf_prog_array *old_array;
>  	struct list_head *storages = &cgrp->bpf.storages;
> +	struct bpf_struct_ops_link *st_link, *st_tmp;
>  	struct bpf_cgroup_storage *storage, *stmp;
> +	LIST_HEAD(st_links);
>  
>  	unsigned int atype;
>  
>  	cgroup_lock();
>  
> +	list_splice_init(&cgrp->bpf.struct_ops_links, &st_links);
> +	list_for_each_entry_safe(st_link, st_tmp, &st_links, list) {
> +		st_link->cgroup = NULL;
> +		st_link->cgroup_removed = true;
> +		cgroup_put(cgrp);
> +		if (IS_ERR(bpf_link_inc_not_zero(&st_link->link)))
> +			list_del(&st_link->list);
> +	}
> +
>  	for (atype = 0; atype < ARRAY_SIZE(cgrp->bpf.progs); atype++) {
>  		struct hlist_head *progs = &cgrp->bpf.progs[atype];
>  		struct bpf_prog_list *pl;
> @@ -346,6 +358,11 @@ static void cgroup_bpf_release(struct work_struct *work)
>  
>  	cgroup_unlock();
>  
> +	list_for_each_entry_safe(st_link, st_tmp, &st_links, list) {
> +		st_link->link.ops->detach(&st_link->link);
> +		bpf_link_put(&st_link->link);
> +	}
> +
>  	for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
>  		cgroup_bpf_put(p);
>  
> @@ -525,6 +542,7 @@ static int cgroup_bpf_inherit(struct cgroup *cgrp)
>  		INIT_HLIST_HEAD(&cgrp->bpf.progs[i]);
>  
>  	INIT_LIST_HEAD(&cgrp->bpf.storages);
> +	INIT_LIST_HEAD(&cgrp->bpf.struct_ops_links);
>  
>  	for (i = 0; i < NR; i++)
>  		if (compute_effective_progs(cgrp, i, &arrays[i]))
> @@ -2759,3 +2777,31 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return NULL;
>  	}
>  }
> +
> +int cgroup_bpf_attach_struct_ops(struct cgroup *cgrp,
> +				 struct bpf_struct_ops_link *link)
> +{
> +	int ret = 0;
> +
> +	cgroup_lock();
> +	if (percpu_ref_is_zero(&cgrp->bpf.refcnt)) {
> +		ret = -EBUSY;

If the cgroup is dying, then perhaps -EINVAL would be more appropriate
here, no? I'd argue that -EBUSY implies a temporary or transient
state.

> +		goto out;
> +	}
> +	list_add_tail(&link->list, &cgrp->bpf.struct_ops_links);
> +out:
> +	cgroup_unlock();
> +	return ret;
> +}
> +
> +void cgroup_bpf_detach_struct_ops(struct cgroup *cgrp,
> +				  struct bpf_struct_ops_link *link)
> +{
> +	cgroup_lock();
> +	if (link->cgroup == cgrp) {
> +		list_del(&link->list);
> +		link->cgroup = NULL;
> +		cgroup_put(cgrp);
> +	}
> +	cgroup_unlock();
> +}

Within cgroup_bpf_attach_struct_ops() and
cgroup_bpf_detach_struct_ops() the cgrp pointer appears to be
superfluous? Both should probably only operate on link->cgroup
instead? A !link->cgroup when calling either should be considered as
-EINVAL.

> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 3ca7d76e05f0..d5492e60744a 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1237,6 +1237,7 @@ enum bpf_perf_event_type {
>  #define BPF_F_AFTER		(1U << 4)
>  #define BPF_F_ID		(1U << 5)
>  #define BPF_F_PREORDER		(1U << 6)
> +#define BPF_F_CGROUP_FD		(1U << 7)
>  #define BPF_F_LINK		BPF_F_LINK /* 1 << 13 */
>  
>  /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
> -- 
> 2.52.0
> 
