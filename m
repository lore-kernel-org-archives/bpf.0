Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43DE3FE34D
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556990; cv=none; b=QM50h+CgEToPK1GM5IvaKM+wwwPVpnMp6iQJp8NQf4eOkMj5hf1FI9SfQlDko8+e+Bxgr3SbH3M2z49f3NdYyrNpqLKlj4R1Ny78IIIt9JzrJQp1CLeSYjjHjBb0J6+oAZiRXHiyQMkE+cC29bV1ujc+RnfC08jRMas/bHvGReA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556990; c=relaxed/simple;
	bh=KlFEs9hTMJp5oOQb4F6v6uFKRQFs4PJPbJsE6rFMvME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixasrjZL7szDS3scyTwmr16Kklfmqk9QCaTm9XKssGR3aBWkKbXlrWCY20Kqmc74mW7rTvcgjRKvJgN1O7qGIv2eAtak5+vf5QBUQpuJOWesF2QKnAlnhsm63UaXPzwVE5zUyFt30DL5wEFivp+eIj551FLJm5R7ZWJkNTXJaaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdTgqbJz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdTgqbJz"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so78020545e9.0
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 07:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784556983; x=1785161783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lD+PhWTsoZ7u38tqy3BQ4p87PXVlUFxqanb+GZ7ay68=;
        b=RdTgqbJzlYBc5Okncnat3xtJPrjNRQESDWmBwKWlUX+k4QwLAcuM6S6IWovXYH9fwT
         YCiso9RkNzGHTgmMtQ3k3nNnWFtGpzfG6SiM6FRzX+XeHo2QoTCPa1kcBlQU48DbIPHV
         9/eGHLPDzddBJI+4IyXOxPJxN5x8BHHxKp++Qyww6uGtVIHxFtwxXlUjp+rLIg4PKvix
         d47/5sJYRh1j/lb/y5Ba3LcKTmkT679wGm2//aNL/o3gAJGfYdttUY863TMeemMBwN37
         7XHPm8o/+MoLsRxMZsKM5iZMqgQCtEOjBSmRCREVEI/Y1qjPIcj3kw44ziD9mdVxRegj
         P7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784556983; x=1785161783;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lD+PhWTsoZ7u38tqy3BQ4p87PXVlUFxqanb+GZ7ay68=;
        b=bjZ24u8DAL0LlC3MyUktGd1OcBJcW4aCkjG5yJds25QHmmXe8RJsv9dQW63XgYbt9f
         i4Cz/MXgzI4cPrwwS+8djZOxc4F2yawM0/sucBy3vjpruKVRVKMcX4oZat5XsD/tzURo
         e3LPdWUNWcYvqeFo/4UEqac/D4eKOpcQYoedrxWMK14G/gZp9dWD5CIwF1yukxJMPcQf
         DdZvDgIvh22nCJXly3yXi9+/JnEuWd/tQnYoCmmUw9CYlf98H0xStQyDCRRLNufj45zM
         ORBOvVX8aZxrpsX7AF9AXpf4F4YAWgPr0eu9F1L289Y3lRlCij1WpplxlU+2IQ1nf/f3
         /FDg==
X-Forwarded-Encrypted: i=1; AHgh+Rq5D4LDOvaLwTurr5ankh2n+XQ3pFRUoGuR1fC5jXM/UVddEvJRq0lkJ65DcEWMzCXodjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt1CpuaLjND+6n4qP57V4BTzCEzmDIH5jA7Y9HJT2QdC/6KkbW
	btDQzVack/20LJXLHkVCuhDlVXjxR5P2krw2GESmsgw5SF1lowlf/iF1
X-Gm-Gg: AfdE7cnQ4uSveRH1JZ9SCmh+Yexy0200i/z2QkmeoQ5yg98B7DQWl9K2PtxSEf1LaE6
	tkrwK/NJf4G7q0vuyDu7zPkeairRYU6sLW8wbI9R9vf35KtOEj0bBBgROM912lLsLNIc8+LCJPC
	6k8r7iwno/RsLYeAzoE6ckEL/NMo1/FhpLk9Tp2y44gxwIjep+9NzlwEUq4t43g4hoi2w27b5qQ
	HJzgaCmPIrf9hcAdlnior6PS8n9s8n4ztYS+aFnb4g9MESHeFT5D7i4I97EeAdzeglW3huTmJdI
	YWvIiNvd6iR+SaY+QIr7EQutSzcJZHu7AzcESwZnjDFbcOxirj7mUJwwBOyT3YeaICHEa9WI0Ag
	wGihmoYPvc9qxIvm2EeERBHa60ca/exUhAvMdNN/e8zCsdJHcsv4tPIdFx9TKEt3oiwK/z38LXB
	9Ur0+TzJMJBaq94rLdKuU15It59gyFfhu7VlNHCUc=
X-Received: by 2002:a05:600c:4504:b0:493:c194:4e7a with SMTP id 5b1f17b1804b1-4954a3d09c8mr155757535e9.3.1784556982227;
        Mon, 20 Jul 2026 07:16:22 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:356a:bbd5:2aeb:97cd? ([2620:10d:c092:500::6:7242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495516c68fasm207736295e9.1.2026.07.20.07.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 07:16:21 -0700 (PDT)
Message-ID: <1289e62e-e956-40c9-a93b-22feefb9110f@gmail.com>
Date: Mon, 20 Jul 2026 15:16:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4 3/4] bpf: Fix potential UAF when reading bpf link
 info
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20260720134547.1289964-1-pulehui@huaweicloud.com>
 <20260720134547.1289964-4-pulehui@huaweicloud.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260720134547.1289964-4-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/20/26 2:45 PM, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> In bpf_link_show_fdinfo and bpf_link_get_info_by_fd, link->prog is
> accessed without holding any locks. If the prog is concurrently replaced
> via bpf_link_update, the old prog can be freed, leading to a potential
> UAF issue.
> 
> Fix this by holding both normal RCU and tasks trace RCU read locks
> before dereferencing the prog, as BPF_LINK_TYPE_ITER support both
> non-sleepable and sleepable progs.
> 
> Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  kernel/bpf/syscall.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6db306d23b47..2458c68146b9 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3471,9 +3471,10 @@ static const char *bpf_link_type_strs[] = {
>  static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
>  {
>  	const struct bpf_link *link = filp->private_data;
> -	const struct bpf_prog *prog = link->prog;
> +	const struct bpf_prog *prog;
>  	enum bpf_link_type type = link->type;
>  	char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
> +	u32 prog_id;
>  
>  	if (type < ARRAY_SIZE(bpf_link_type_strs) && bpf_link_type_strs[type]) {
>  		if (link->type == BPF_LINK_TYPE_KPROBE_MULTI)
> @@ -3490,13 +3491,23 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
>  	}
>  	seq_printf(m, "link_id:\t%u\n", link->id);
>  
> +	/* prog can be sleepable */
> +	rcu_read_lock_trace();
> +	rcu_read_lock();

Only rcu_read_lock() should be enough, see 57b23c0f612d ("bpf: Retire rcu_trace_implies_rcu_gp()")
Did you manage to reproduce the UAF?

> +	prog = READ_ONCE(link->prog);
>  	if (prog) {
>  		bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
> +		prog_id = prog->aux->id;
> +	}
> +	rcu_read_unlock();
> +	rcu_read_unlock_trace();
> +
> +	if (prog) {
>  		seq_printf(m,
>  			   "prog_tag:\t%s\n"
>  			   "prog_id:\t%u\n",
>  			   prog_tag,
> -			   prog->aux->id);
> +			   prog_id);
>  	}
>  	if (link->ops->show_fdinfo)
>  		link->ops->show_fdinfo(link, m);
> @@ -5535,6 +5546,7 @@ static int bpf_link_get_info_by_fd(struct file *file,
>  {
>  	struct bpf_link_info __user *uinfo = u64_to_user_ptr(attr->info.info);
>  	struct bpf_link_info info;
> +	const struct bpf_prog *prog;
>  	u32 info_len = attr->info.info_len;
>  	int err;
>  
> @@ -5549,8 +5561,15 @@ static int bpf_link_get_info_by_fd(struct file *file,
>  
>  	info.type = link->type;
>  	info.id = link->id;
> -	if (link->prog)
> -		info.prog_id = link->prog->aux->id;
> +
> +	/* prog can be sleepable */
> +	rcu_read_lock_trace();
> +	rcu_read_lock();
> +	prog = READ_ONCE(link->prog);
> +	if (prog)
> +		info.prog_id = prog->aux->id;
> +	rcu_read_unlock();
> +	rcu_read_unlock_trace();
>  
>  	if (link->ops->fill_link_info) {
>  		err = link->ops->fill_link_info(link, &info);

