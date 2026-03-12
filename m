Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860783290C4
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 01:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773280414; cv=none; b=tUcjWwmh1Vgu0R7LAZQ4NscuQJxP3IiJqD/8cTpEhg9uZbydh3zKhnFQ3w34pGe7zwSEslvsk4k7kXpHw3z5Z77OOe88XD5lpEkvTm5kzlQgAygVp1P9uUTTynYltw/ANqAhsLVS1D0Ejz6JKrfw1w9bvIbwZDSjpIXoH5LzBdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773280414; c=relaxed/simple;
	bh=D8+eaz5ktKvHSazmQpAy1j3D7q4PMBEC+ajux56jJS4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=cFNgN9Z5rBrPXe+5pBLEm20mv1/IZc7X2G6tZ91NB6QfzwgkwrNyM9PLUOHvlpIIgJ78+pt2EQ8GrmGrflihgBKFEYkvrv5daJuYMWCailQ2HKhUOE1musouJqT40Sk1wycFZoTTi63gi50hWG2gFcum0eMdcgbFhTpUPQfx2Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=o3MtdkB3; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="o3MtdkB3"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5090c48de85so5975291cf.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 18:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773280411; x=1773885211; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHdSeh+QONbk0DEqGOEoXwna7H/OT7Km2im2ppaRhuE=;
        b=o3MtdkB36Clvcd6Ti+ingpdX1ICKVVeO/PUoUHyAsgmKU7ToPn0WHBFF/TqerzKPLD
         uDRgRZqr/oaQjOT4flRmJNthmWC7ER9wXIWvjnlNCP8rW3ieCllfpA83ROVCD9nHfwsq
         DBgTobc40qPurdME7d6FBYBwQYphTDzTmxJAI95iHaabjI0lU/v3PBfDfVsk5I1lvO3Q
         B71aUer/XyGz5SPBieTRUtGc1pm1Xp9rMEEaM10MZf6nLByzNi6NKrif98R68/K79a8L
         edxj5R7r1jAj5slKMJsbDAY2ZFLf7xkY3abbzEQknMN/jOkQOZ9wAw/rn6ANU2yUjnmR
         TC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773280411; x=1773885211;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aHdSeh+QONbk0DEqGOEoXwna7H/OT7Km2im2ppaRhuE=;
        b=boPTWqVRrVG+XIOzU0BxQSWu/UI/Fg6FLWfWC17mMgmWw5mEIU7ht6tLLXcsGUfo0X
         HPliLddbbcFhJj86hCCKOp150KUZ/szWVocPXjOmmKGCNMNlNg35s8flzUE0ieIIchj1
         n1tQ9QjsTwjEJ5ftZc937NlJ/cG2sH816DmCyKtKJ+P5ExGBusOBFBpwxbtUsKtiEEIs
         5NDKmZ89gyX8yVzuMOn8cmaYupRZJM6zlXQVQIf5PSxxLgpum1qskANtdnv2sVvwBYSk
         lF0zdApJ/AB7mxAyhhMIO3szU52UNMVgcZFPzidA6QmkCLtan5rYKxCRcDGpa0el6IrV
         WSPw==
X-Forwarded-Encrypted: i=1; AJvYcCUW4zL3vtgEGU1GfWfd8gy60s1mclMK+jpPJPna1aIRWnexcEDFWUHdepBdxjUKCJwNkvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWaT3xdqy0vgKskC+M6a7kq7GY7Gimq2wQpFeViguPFokUQ2hC
	8riVMe0WA96zKMwS9XxMe2JoPkaA8+ZD1ZctsQyFhXzOBuU41H/zF/v6F/+MCoJeTIucdsZ9DqO
	TmgT2
X-Gm-Gg: ATEYQzyvwi8vXJhaHljA693Egvfm49LlvwQkfZhxJLMubA8t41VOwOCZ/JQ0fN3T1LT
	CnbNTMVrvZ5IxbJ6UtjyjCW8wwyhwO74vpXdm6ZJmvT/rBbJM9NzdeRbXr+Q0lOAdUSDSfEul/+
	vZSl+GHqm693v9SJhyQZKYlDn36kfxkuTBuG8HxtrmAjtXPxKW3HAXzJk2wO8eWNoCA+ZlljTS3
	2hVS7j3xAGHcXQ31t8rxHiMfUoJK3VqIQRQxRwh/hniGw0WmJo7BCLfOVx21m1ibxaIMqE0Qbwz
	8U0+1pQV7xYWaCtzs8JSdnFeAAHiULi6Hueh8n/mjQXWh846bD/jMwKjfsLDv78I9cJPDxNWZ06
	Jn7B3SHGEwQE+DAIEarEEOpMlDFNwHIpepUm4XC7f2zwx15mvOzkjCtAv1Megh9LUTaXJbtXAU5
	UqUAIytPBGtVsEz6GVqnQ415k=
X-Received: by 2002:ac8:5d91:0:b0:509:cdf:d394 with SMTP id d75a77b69052e-5093a212058mr57938301cf.70.1773280411166;
        Wed, 11 Mar 2026 18:53:31 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50939ec5017sm22907291cf.8.2026.03.11.18.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 18:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 21:53:25 -0400
Message-Id: <DH0FFVXK13E9.BVMOUIPQVH93@etsalapatis.com>
Subject: Re: [PATCH bpf v1] bpf: Release module BTF IDR before module unload
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
Cc: "Martin KaFai Lau" <martin.lau@kernel.org>, "Gregory Bell"
 <grbell@redhat.com>, "Alexei Starovoitov" <ast@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Eduard Zingerman" <eddyz87@gmail.com>, <kkd@meta.com>,
 <kernel-team@meta.com>
X-Mailer: aerc 0.20.1
References: <20260312002025.2495953-1-memxor@gmail.com>
In-Reply-To: <20260312002025.2495953-1-memxor@gmail.com>

On Wed Mar 11, 2026 at 8:20 PM EDT, Kumar Kartikeya Dwivedi wrote:
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
> We can be sure that by the time we reach final btf_put() for
> btf_is_module() case, the btf_free_id() is already done, since the
> module itself holds the BTF reference, and it will call this function
> for the BTF before dropping its own reference.
>
>   [0]: https://lore.kernel.org/bpf/cover.1773170190.git.grbell@redhat.com
>
> Fixes: 36e68442d1af ("bpf: Load and verify kernel module BTFs")
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Reported-by: Gregory Bell <grbell@redhat.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  kernel/bpf/btf.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 4872d2a6c42d..c44fb9c9386f 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1883,10 +1883,17 @@ void btf_get(struct btf *btf)
>  	refcount_inc(&btf->refcnt);
>  }
>
> +bool btf_is_module(const struct btf *btf);

Nit: Maybe just move the entire btf_is_module function to here? It's a one-=
liner anyway.

> +
>  void btf_put(struct btf *btf)
>  {
>  	if (btf && refcount_dec_and_test(&btf->refcnt)) {
> -		btf_free_id(btf);
> +		/*
> +		 * IDR for module BTFs is freed when module's BTF reference is
> +		 * dropped, which _will_ happen before the final put.
> +		 */
> +		if (!btf_is_module(btf))
> +			btf_free_id(btf);
>  		call_rcu(&btf->rcu, btf_free_rcu);
>  	}
>  }
> @@ -8382,6 +8389,12 @@ static int btf_module_notify(struct notifier_block=
 *nb, unsigned long op,
>  			if (btf_mod->module !=3D module)
>  				continue;
>
> +			/*
> +			 * For modules, we do the freeing of BTF IDR as soon as
> +			 * module goes away to disable BTF discovery, since the
> +			 * btf_try_get_module() on such BTFs will fail.
> +			 */
> +			btf_free_id(btf_mod->btf);
>  			list_del(&btf_mod->list);
>  			if (btf_mod->sysfs_attr)
>  				sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
> --
> 2.52.0

