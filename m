Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ED04207A
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780859024; cv=none; b=SI66UKnqHd9k2nhFrVlHXUHz6aIExhuIjTTTjZNPRHXMyWzh5kGAKWMER7rR0C3q9h+JO/tNmTrjIiq5HgV/TjUZh2CyNlvmdP7bEVcuJCZODL2OJIRXMKrdQGTgPqLkR+OdpsFBGbZs3jf7aOhmiB8bXo2gFH5Jzf3g7yVe0iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780859024; c=relaxed/simple;
	bh=vg5WapMXqtf0m6QisUCqA7KWGADZHTq1oXlNHWTygBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFw731xLly59Gsp41nTdqc9XB7U8qncDXxE0W+cuSjwPjfnDloNnN5Ghjle1jCwp4Agvlps9mVqzECHW0kmRaTK95O5O1AvBBuhyZlKUyHkGZFqK1wsxMFgHX8MNn9vM4DZL37CX+U2PPwJYz+iyGaja+M3IrSXYJX8pn0xkJuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1Jgp73L; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1Jgp73L"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68cec9f4c6cso5038833a12.0
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 12:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780859021; x=1781463821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MxaSwiN5zBcY9/Wcqq/wZGHwqvyHPk5v6RDFmOoUT64=;
        b=C1Jgp73L+WywEY7VLcRmUwIlvMeh54yVB9pysFuovm9ErKGkdMll1+NpznEMHX86OA
         oenudYRbQpoD+bMCv6UcfMLYYIdwK9KDNk6OvGXKg4o1FtIcdmyOtcr8BtrnXwgrNEz+
         J+SA7pGfTOtxKfc7LP9fKZ10vCcFp0VKDgH+mlq1xRX6XDvpuuvCgS3k0D+cU9KUxErI
         a1HCWoIGWTqoHSLcL8kXZQqJ7DVW76IorTnSXNmyu1J7YCzEpwxjMgrj0z8YX3QHUElQ
         Xh4nsey58elI/QY6bLVYevrMX23iEZysfIbEp3+QAdDln3VRPdDyyUy+EnuVMecTOSqS
         BWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780859021; x=1781463821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxaSwiN5zBcY9/Wcqq/wZGHwqvyHPk5v6RDFmOoUT64=;
        b=ANOKA/9bwgKtIVKevEVgrfi5azvxfdO4llQXVuW6WLXAOpbsW/FdOI6c5frMDHI2nc
         JKwzU2M18JZeBoQvuFJ6klt5w3BVyZeE0w7KEIoXR8fStIkZX9NI6xro3e39rpz9iS0H
         PHbOUzH19SW+iuYwDvgKITqU5tTRbkopk/bVHhpFHRLDmksdQcUrL2TyMWof4LAJdCCx
         nipVijnDWk22PiBGq5K1zcJPk+NKaU1Jbs9MKM6dWLShPZnU/diGd/lAlzYlERd7WtBD
         bobFtxZGQYOTusIgqW6uiRt84jYdNZKpw0xgprtgkHqBI5iV0ZLeRCA7tAAYFq2KPeFl
         N5YA==
X-Forwarded-Encrypted: i=1; AFNElJ8v5xdd4q7FpaGZUdm8HeK9gBFzaVWK4CSXiWvogmo/wrRIOkwHABkWb3VpXTE4+O0hHKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLerR9H5SnnGbxi9Fpu6HAVfFZ++XWtxDELgjZGHTzKuhWV8Lp
	sn6cdWuIeo6ibwbN55lAJnLGkx3E3dTrXBz3C79YRpxogcVJqEHi5ACG
X-Gm-Gg: Acq92OESy3jcydG9SMEtuFaHtqEU1dD2PV25wOqbb3Y0tK2GZcvZKg/pEfjSHd31AaS
	HuU3Xp4leIGnnbyRw3fwMU0mY6b1VaTfiJITgrh/M1gl2r4GwDRMf91a0I098nYDiKxSkeY/wqF
	pZb7Pc1Au1jeCx2KdIEIgtm/IKZFOJqLejR/lQgQHZhX9vNslOf8cxmxTrqfYagzbgESlbxPjme
	YTR8KQVRv5vuHJp65qAUVQMJa2mPTY5yMG5IzrDitxpZKNeiTH7Go8xK7NxfMkSejImBvAPEU+g
	ofIYrm6YL/Oep5JNqWXJS8Zw5vD7mjIRGFifmrbPjdvjT5NWqps93vtQvrmFX0R3pny3DkqlHst
	4uKu60EnB3i0rvBp71wel0FB32lFC/BlRKXnfQGYphgaDh0wT4w60dOo2D8F6gr2F2JDo1ETMLC
	ADN2J3zLHmwCKmazkHtvuKkv45fJlm2bM5/AiymmCmr3mK6vRTw+mMcA/8VbKpBdy6pTH68XiyP
	7eoqgL1gjKhWZmRH4kJIQ==
X-Received: by 2002:a05:6402:354f:b0:691:a699:da5c with SMTP id 4fb4d7f45d1cf-691a699ddd6mr1461844a12.17.1780859021011;
        Sun, 07 Jun 2026 12:03:41 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f? ([2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e650287d9sm6344094a12.12.2026.06.07.12.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 12:03:39 -0700 (PDT)
Message-ID: <ba77f59c-f932-4792-9d57-69ebe8806857@gmail.com>
Date: Sun, 7 Jun 2026 20:03:38 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: defer freeing htab internal structs to workqueue to
 fix sleep-in-atomic
To: Luo Gengkun <luogengkun2@huawei.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260606022827.3553277-1-luogengkun2@huawei.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260606022827.3553277-1-luogengkun2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/6/26 3:28 AM, Luo Gengkun wrote:
> This fix resolves a conflict between two patches:
> 1. commit 1da6c4d9140c ("bpf: fix use after free in bpf_evict_inode")
> 2. commit 4f375ade6aa9 ("bpf: Avoid RCU context warning when unpinning
> htab with internal structs")
> 
> The problem is that commit 4f375ade6aa9 breaks commit 1da6c4d9140c 's UAF
> fix, because we need the RCU grace period to keep symlink lookups safe. But
> keeping the RCU delay means `htab_map_free_internal_structs` runs inside
> RCU_SOFTIRQ, where calling `cond_resched()` and triggers the "sleeping
> function called from invalid context" BUG.
> 
> To solve both issues, we keep the VFS RCU protection intact (by reverting
> commit 4f375ade6aa9), and defer the actual freeing to workqueue to avoid
> sleep-in-atomic.
> 
> Fixes: 1da6c4d9140c ("bpf: fix use after free in bpf_evict_inode")
> Fixes: 4f375ade6aa9 ("bpf: Avoid RCU context warning when unpinning htab with internal structs")
> Signed-off-by: Luo Gengkun <luogengkun2@huawei.com>
> ---

It looks like the problem has been fixed by:
b93c55b4932d ("bpf: fix UAF by restoring RCU-delayed inode freeing in bpffs")

>  kernel/bpf/hashtab.c | 23 ++++++++++++++++++-----
>  kernel/bpf/inode.c   |  4 ++--
>  2 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 3dd9b4924ae4..6d6f1faeec67 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -102,6 +102,7 @@ struct bpf_htab {
>  	u32 n_buckets;	/* number of hash buckets */
>  	u32 elem_size;	/* size of each element in bytes */
>  	u32 hashrnd;
> +	struct work_struct work;
>  };
>  
>  /* each htab element is struct htab_elem + key + value */
> @@ -539,6 +540,8 @@ static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
>  		return htab_set_dtor(htab, htab_mem_dtor);
>  }
>  
> +static void htab_map_free_internal_structs_deferred(struct work_struct *work);
> +
>  static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>  {
>  	bool percpu = (attr->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
> @@ -557,6 +560,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>  	if (!htab)
>  		return ERR_PTR(-ENOMEM);
>  
> +	INIT_WORK(&htab->work, htab_map_free_internal_structs_deferred);
>  	bpf_map_init_from_attr(&htab->map, attr);
>  
>  	if (percpu_lru) {
> @@ -1606,18 +1610,27 @@ static void htab_free_malloced_internal_structs(struct bpf_htab *htab)
>  	rcu_read_unlock();
>  }
>  
> -static void htab_map_free_internal_structs(struct bpf_map *map)
> +static void htab_map_free_internal_structs_deferred(struct work_struct *work)
>  {
> +	struct bpf_map *map = container_of(work, struct bpf_map, work);
>  	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>  
> -	/* We only free internal structs on uref dropping to zero */
> -	if (!bpf_map_has_internal_structs(map))
> -		return;
> -
>  	if (htab_is_prealloc(htab))
>  		htab_free_prealloced_internal_structs(htab);
>  	else
>  		htab_free_malloced_internal_structs(htab);
> +	bpf_map_put(map);
> +}
> +
> +static void htab_map_free_internal_structs(struct bpf_map *map)
> +{
> +	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> +	/* We only free internal structs on uref dropping to zero */
> +	if (!bpf_map_has_internal_structs(map))
> +		return;
> +
> +	bpf_map_inc(map);
> +	schedule_work(&htab->work);
>  }
>  
>  /* Called when map->refcnt goes to zero, either from workqueue or from syscall */
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 25c06a011825..b6f295732f6f 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -762,7 +762,7 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
>  	return 0;
>  }
>  
> -static void bpf_destroy_inode(struct inode *inode)
> +static void bpf_free_inode(struct inode *inode)
>  {
>  	enum bpf_type type;
>  
> @@ -777,7 +777,7 @@ const struct super_operations bpf_super_ops = {
>  	.statfs		= simple_statfs,
>  	.drop_inode	= inode_just_drop,
>  	.show_options	= bpf_show_options,
> -	.destroy_inode	= bpf_destroy_inode,
> +	.free_inode	= bpf_free_inode,
>  };
>  
>  enum {

