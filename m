Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0383637BE7D
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570071; cv=none; b=afmJr3K2s6nHs/ZNh4AeQa+Em4QT2vWUG6A53XN7nxaTmnrO1kHeyWgyG8sABdO70+4AfGQ47nnCne9JNmeLsAEaQigLqQ0lRwq7/E2mLvNbYMqwl/Ff4C230qYYsfrnGOFRdtmyxs5jLJJC0/Ax1S3vOP9OLneJf3vG0rTqzj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570071; c=relaxed/simple;
	bh=hKJbxc8NsHsFUvDDH6xySveIIcdPNbn0KUG3fWPXg+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewtottwwpkIoB+lAfMwUaMLpgt0Qdl0Jf7l1HwhqSHtjAdV8oVAqGCxgYbq4TYvBOPzSq/TAhH/w+vx1d0NuJQ9hRLu8p1jdtuwaBlvz2+QHhnfv6c1uNCr9jznkMzlEPGXyZJtRSuvjh+dhry3SnFUs+qpm0YJZvL7lAXf9w2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7K23d4t; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7K23d4t"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68bac6e24fdso760248a12.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 03:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780570068; x=1781174868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jwJB9cBfnfHdEwA/fwRLYD3Mdm/VM1ICLl5KQOk5Qu0=;
        b=s7K23d4tZvUdj8REaaKKMf0cycohR56cuaf2+iS05GqZvPkAD58BYrzvC+t/ykoIGE
         YRPk1a/HXk7AaczjaLbealrCU2XtYpHVynK13KO9b48X3nxmr9C9dewo/MchZVgwVXAO
         +/Y9z+dEZlFIAAhyye3qPsIrYJKBiqw/HCskRE7xJLVnSTL5k7kboe2sOgoc/PzMBE5d
         fnFk5qyAPlatRHsnM38tArB0x3eQW/GrYbVmtaCkdwll3SvzRMetwCD3ze1lmro4IeA3
         rkZyHzdRWXFhlN15qYKTAoh3e0TvOqGQ/wwH9rmVRg8Lz+jlG5hawIPOWyzVHxGFfHFV
         B83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780570068; x=1781174868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwJB9cBfnfHdEwA/fwRLYD3Mdm/VM1ICLl5KQOk5Qu0=;
        b=Ye9ElIkC3zvamnCH4EMGqN/1bqCYhHl+i3220NEuvrfPLs5d68jOdbpgX8Sr7hDw62
         h8AwgQbiPryLc2i1+67adH08ey/mSCx2eWorD2ZjaUrQzU7SkTSXRcCru/jM9/ymZvBY
         7LJpUKLsGMMrGIYaeaMvgED4UDQDOGMmNX6SKZMJ5umMaOvcI5PWqFiT2Q1pnA//ISGV
         ooW2rrDHDqCbcMNSKAxNFMHNbfYbv50JFFAJyF9wCHbYY7AE962yHyedW93BpRDO3ssx
         +zUkBiometlRVAZYMeuT3akN2PC/jWjwqhFqlU4df3uDRUtdpqOW7+3WrhoyHEzPyUSX
         SRow==
X-Forwarded-Encrypted: i=1; AFNElJ9OD6hAeq4n4iz44Mw21PPjFxGpILaKdN25z2T8yc3caKB8GSc7+OizVtjThaFQRwFZWBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcnPB+98xegvTlfhW4/Ffg37jJ2n0YnHuQnHvelJvDGU+zVZSX
	jo27EMM/Q6ypVEoLUAtHjrKzbdjfDuNnLOIbCHhGk8asUBt/g+uUFWFx
X-Gm-Gg: Acq92OHvHmATSPIkwbtTtYs5BPhYT0JBCAY/cRrHP5lW95ojUQpKFAvFFBERDaBvIP+
	DWCeA7+I3EvAce9uMbGrcqyuEvYlnpFH8vrqo8TO/yshrauEnw9qMwt4oq00Bko1rPKsBQzBqcC
	sTP8wvMMOvmSoFsZWtfNc8PhmIzoIh+q0hpKJjL1yiYVhJtS3wpPjWRKDhqJdWYjKc1gZLDVNbf
	EmB9csOwA9skUM9AfydRXe1tvRf1VCtnpIzfBQgwzcjY+FA3Zu/uSmH3Y2NJD/gUDl2CV8N1G6j
	pMgppj+NqPqsvLW840J5sEkNWpJ7nl+av0cpZieAtpd0Pqrxfyp1ONhJ7sWbhX9IH+LGAYf/9Ch
	zbfvCQr4OPtiw7RmDIP12ZeDG2+ih2qD9tgNt82lyFAHJ7uOZha2mbrFFZRGzkc51jFt6MunbeO
	MoYc4UzQDOKVZHuziW1VXClcK9SThE5wnl49OZTWegjFqFK7CNQhpHIy/3TCCkW6qxbjytMYU/p
	Htvlh8MjROpLcoLRL3kHA==
X-Received: by 2002:a17:907:3c8e:b0:bec:157:a63a with SMTP id a640c23a62f3a-bf0ac20eb8emr362199666b.1.1780570067915;
        Thu, 04 Jun 2026 03:47:47 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f? ([2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055307aacsm289054766b.47.2026.06.04.03.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 03:47:47 -0700 (PDT)
Message-ID: <a56c9f94-e694-44cf-85ac-c4bcc8d18f70@gmail.com>
Date: Thu, 4 Jun 2026 11:47:44 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rhashtable: Use irq work for shrinking
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com,
 yatsenko@meta.com, martin.lau@kernel.org, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev, Tejun Heo <tj@kernel.org>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
References: <20260602-rhash-v6-3-1bfd35a4184f@meta.com>
 <4d811506109736528d816b6a1f613becd9460079ee7bfc67c509e67e7d2f44af@mail.kernel.org>
 <3960ffc3-78f3-46da-baaf-ce72b6495698@gmail.com>
 <aiDgUPXZUi-jnTdo@gondor.apana.org.au>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <aiDgUPXZUi-jnTdo@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/4/26 3:17 AM, Herbert Xu wrote:
> On Wed, Jun 03, 2026 at 02:08:25PM +0100, Mykyta Yatsenko wrote:
>>
>> For v7 I'm dropping automatic_shrinking, because it adds a risk of
>> calling schedule_work() on element deletion path (__rhashtable_remove_fast_one())
>> when hashtable size drops below 30% of the capacity.
> 
> Now that expansion uses irq work I think shrinking should switch
> to that as well.
> 

Makes sense, thanks, I'll include your patch below in this series then.

> ---8<---
> Use irq work for automatic shrinking so that this may be called
> in NMI context.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
> index ef5230cece36..0693bce6f890 100644
> --- a/include/linux/rhashtable.h
> +++ b/include/linux/rhashtable.h
> @@ -1117,7 +1117,7 @@ static __always_inline int __rhashtable_remove_fast_one(
>  		atomic_dec(&ht->nelems);
>  		if (unlikely(ht->p.automatic_shrinking &&
>  			     rht_shrink_below_30(ht, tbl)))
> -			schedule_work(&ht->run_work);
> +			irq_work_queue(&ht->run_irq_work);
>  		err = 0;
>  	}
>  
> Cheers,

