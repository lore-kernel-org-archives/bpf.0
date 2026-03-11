Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2C535A3B5
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256229; cv=none; b=dmaVfrAdCzywpEilkIXNIOeqhuX1XRd+QTaF7IywdksJxWjVzs8bd+I/AQ+REMsMbyWxttp0kYXwq435Om3BCFD1psCe1eaNT0OuGfhOHfD60umybKJ7jmhLALcbs7O1X65tdVm4tWDeiv3aQgCCuO8xJwGGfxz1SQrHdCs2/yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256229; c=relaxed/simple;
	bh=giIAp9apaZYfh28eyd6k4FzehXO0KDonm+5hX4pqNPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYAyn2qNuUwMroPYejaMq+bzuDtvnAIoJV3fB/1vKHhAyLIrXY7GbVgAw39SdECm0a+bkky3kYH3R7iket26BN9HavHIRm1i1toX+PntC27UIyZF8i209cWpghAgaxxdvMF8UUI/mAjiKQCZ4gadKA5PO+7nwORMxYjZbXHfpnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FLPzJf5r; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FLPzJf5r"
Message-ID: <65de5cff-4675-4f56-8e2e-fae68ece4865@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773256226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEpaGJ1IKhUCByjppZt38wGkqyJ+SFJ9VDTDECj5ptU=;
	b=FLPzJf5rvWOTM0A9OBHAAQA41NO5NhhnbIea6uXcr/B8s5L9lCQbv4z/iYy9LwTGKdr8rE
	dC4JnydMV93yZQO6bf05eyokkz8GY0SeXZmITCGaj3B8WdiJYeNrOaH+eLnQufg0E0Q7uj
	FBBO7oSaC1oaZxnhm1IJmJNlmfErX+U=
Date: Wed, 11 Mar 2026 12:10:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Release module BTF IDR before module unload
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: ameryhung@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 grbell@redhat.com, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, sdf@fomichev.me, song@kernel.org,
 yonghong.song@linux.dev
References: <aed1731e-986e-484e-bc16-682b025d26cf@linux.dev>
 <20260311130321.1055808-1-memxor@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260311130321.1055808-1-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/11/26 6:03 AM, Kumar Kartikeya Dwivedi wrote:
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   kernel/bpf/btf.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 09fcbb125155..d18e218049ed 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1883,10 +1883,17 @@ void btf_get(struct btf *btf)
>   	refcount_inc(&btf->refcnt);
>   }
>   
> +static bool btf_is_module(const struct btf *btf);
> +
>   void btf_put(struct btf *btf)
>   {
>   	if (btf && refcount_dec_and_test(&btf->refcnt)) {
> -		btf_free_id(btf);
> +		/*
> +		 * IDR for module BTFs is freed when module's BTF reference is
> +		 * dropped, which may happen before the final put.
> +		 */
> +		if (!btf_is_module(btf))
> +			btf_free_id(btf);
>   		call_rcu(&btf->rcu, btf_free_rcu);
>   	}
>   }
> @@ -8383,6 +8390,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
>   			if (btf_mod->module != module)
>   				continue;
>   
> +			/*
> +			 * For modules, we do the freeing of BTF IDR as soon as
> +			 * module goes away to disable BTF discovery, since the
> +			 * btf_try_get_module() on such BTFs will fail.
> +			 */
> +			btf_free_id(btf_mod->btf);
>   			list_del(&btf_mod->list);

The change makes sense.

I looked up a bit because I am interested in who will use the module's 
btf->id without holding the module's refcount. fwiw, here is what I read.

For non struct_ops prog, the module refcount is held in prog->aux->mod 
after commit 31bf1dbccfb0, so should be fine on the 
bpf_trampoline_compute_key() and bpf_prog_get_info_by_fd().

For struct_ops prog, the module refcount is not held in prog->aux->mod. 
I don't think it has to since it is not directly attached to the module. 
The only downside is the bpf_prog_get_info_by_fd() may report an 
out-dated info.attach_btf_obj_id. If it is an issue, maybe just hold the 
module refcount also.

For struct_ops map, it attaches the struct_ops prog to the module, so 
the module refcount is held. It should be fine.

