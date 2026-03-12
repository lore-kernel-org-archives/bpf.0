Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAA13FEB17
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 18:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773339446; cv=none; b=CO4RMcwAI9deuGaJ51uSU3UIRVJoKR9pA4k4FDresFAb09Qkg5uqaAFooNdRFmgtV8xL2NIvTwWerMwlevEtufg0UPQQjBnuz7BX/TD5IeHnIr6+OXwgqndJZp5oPg0nfcDMY8Hjp2bkh5SaAVFl6A5cqAUFOOxNvfMqnubSPR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773339446; c=relaxed/simple;
	bh=ftY4Kska22hc0OpR3Lxv9KoUhwPVWB7+zCF+2NJh82A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2SxFIlrAQEyrrhcCb7fzN597rJUkOA7EI+QQyoB7mtk/jThZg1sYVK9hKpbq3yqEPOBkz0kvGor0Nw5uxPQEB5PZLBw8ftK+4EQEDU5R+36YLoD5ncVyKNe1AHzmVi/kShHXhbhKXUgdDasNeHNiGQoSDFwmr6NLXNVwt7SwBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tYYkr0JZ; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tYYkr0JZ"
Message-ID: <27124ede-293e-448e-b4db-a0fe82e4e745@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773339436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ROZojsV/iin1ds8Rm1qcgNpIIbL3Kv077va9eUGg+sk=;
	b=tYYkr0JZEcJsarqAYwGCDBtL8wSn0fiKEo9RwO+EiSLFvKHIkuM5C54fEVSNHw12bUqP+f
	FM1YKieSogs4jOYjhIq1gj3zX8xLzKp8EAN1qY02CjNqpsvS8+47omRPYqG/av2gnNOZyZ
	2oGTwm4NaPGdOqyeTigjGSCbaJnhryM=
Date: Thu, 12 Mar 2026 11:17:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2] bpf: Release module BTF IDR before module unload
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@kernel.org>, Gregory Bell
 <grbell@redhat.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kkd@meta.com, kernel-team@meta.com
References: <20260312180643.3806586-1-memxor@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260312180643.3806586-1-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/12/26 11:06 AM, Kumar Kartikeya Dwivedi wrote:
> Gregory reported in [0] that the global_map_resize test when run in
> repeatedly ends up failing during program load. This stems from the fact
> that BTF reference has not dropped to zero after the previous run's
> module is unloaded, and the older module's BTF is still discoverable and
> visible. Later, in libbpf, load_module_btfs() will find the ID for this
> stale BTF, open its fd, and then it will be used during program load
> where later steps taking module reference using btf_try_get_module()
> fail since the underlying module for the BTF is gone.
> 
> Logically, once a module is unloaded, it's associated BTF artifacts
> should become hidden. The BTF object inside the kernel may still remain
> alive as long its reference counts are alive, but it should no longer be
> discoverable.
> 
> To fix this, let us call btf_free_id() from the MODULE_STATE_GOING case
> for the module unload to free the BTF associated IDR entry, and disable
> its discovery once module unload returns to user space. If a race
> happens during unload, the outcome is non-deterministic anyway. However,
> user space should be able to rely on the guarantee that once it has
> synchronously established a successful module unload, no more stale
> artifacts associated with this module can be obtained subsequently.
> 
> Note that we must be careful to not invoke btf_free_id() in btf_put()
> when btf_is_module() is true now. There could be a window where the
> module unload drops a non-terminal reference, frees the IDR, but the
> same ID gets reused and the second unconditional btf_free_id() ends up
> releasing an unrelated entry.
> 
> To avoid a special case for btf_is_module() case, set btf->id to zero to
> make btf_free_id() idempotent, such that we can unconditionally invoke it
> from btf_put(), and also from the MODULE_STATE_GOING case. Since zero is
> an invalid IDR, the idr_remove() should be a noop.
> 
> Note that we can be sure that by the time we reach final btf_put() for
> btf_is_module() case, the btf_free_id() is already done, since the
> module itself holds the BTF reference, and it will call this function
> for the BTF before dropping its own reference.
> 
>    [0]: https://lore.kernel.org/bpf/cover.1773170190.git.grbell@redhat.com
> 
> Fixes: 36e68442d1af ("bpf: Load and verify kernel module BTFs")
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Reported-by: Gregory Bell <grbell@redhat.com>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
> Changelog:
> v1 -> v2
> v1: https://lore.kernel.org/bpf/20260312002025.2495953-1-memxor@gmail.com
> 
>   * Remove special case from btf_free_id(), and call it unconditionally. (Alexei)
> ---
>   kernel/bpf/btf.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 4872d2a6c42d..d08ae973df69 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1788,6 +1788,13 @@ static void btf_free_id(struct btf *btf)
>   	 */
>   	spin_lock_irqsave(&btf_idr_lock, flags);
>   	idr_remove(&btf_idr, btf->id);
> +	/*
> +	 * Clear the id here to make this function idempotent, since it will get
> +	 * called a couple of times for module BTFs: on module unload, and then
> +	 * the final btf_put(). btf_alloc_id() starts IDs with 1, so we can use
> +	 * 0 as sentinel value.
> +	 */
> +	btf->id = 0;


Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

A minor nit. Theoretically, it probably needs WRITE/READ_ONCE().

>   	spin_unlock_irqrestore(&btf_idr_lock, flags);
>   }
> 
> @@ -8382,6 +8389,13 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
>   			if (btf_mod->module != module)
>   				continue;
> 
> +			/*
> +			 * For modules, we do the freeing of BTF IDR as soon as
> +			 * module goes away to disable BTF discovery, since the
> +			 * btf_try_get_module() on such BTFs will fail. This may
> +			 * be called again on btf_put(), but it's ok to do so.
> +			 */
> +			btf_free_id(btf_mod->btf);
>   			list_del(&btf_mod->list);
>   			if (btf_mod->sysfs_attr)
>   				sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
> --
> 2.52.0
> 

