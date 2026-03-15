Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8676F225403
	for <bpf@vger.kernel.org>; Sun, 15 Mar 2026 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773612842; cv=none; b=uBEVSv80eCmb5JA5NRWD+Q9aEFWAq816QTxe7pS8B0jhjXNdypmuewJcHHtpTgHON8pxrCl2h5kCwbb5a+sNeT3qJv8527BJXyDhxijFA7W8k3VLxsQ4pgC+oLS+FR1Wri3VFJBC3DZxmMmwNtIe3NnAQ8OaKFvB3X2eF2mxpU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773612842; c=relaxed/simple;
	bh=rbqw4j7YKaoChzOaACXzS9R/DJO/UPR0389tookg8RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKZrrT8er/wQPfbfyomKLaeebm6w1eYDV25LnCXNi1Gi6kknKIvs6WF4dUYm++S41aUKw20w0cbTjFKziIobP5Q39J/IRSX6ywlKvA24a4cTnnwGWFYt/68zconzUpaNBtj3i1Lzv4dUGJcOjYkEqz6oW1XJn9eeV2rqiaaGIV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnRjtZzu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnRjtZzu"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso34313355e9.1
        for <bpf@vger.kernel.org>; Sun, 15 Mar 2026 15:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773612840; x=1774217640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tcdSDWWl8Yxbno+lQtwlGlIW4vxAda9wkrHkc3R5BdQ=;
        b=nnRjtZzuReNn3qIUAIOsrKRenjVbpxnlxtsgWVrOrhdlA/LXrdsQSV1YB5a8zDbpcb
         UB4bLP0nWt7OnYmqx12HT8cQGkQ8DUMJSuQthebhFxtwAHI8Cqh5+7pkomY7R2+UjXGm
         6a8p4H9MNBFMqKDs63RtZd5KuW4kgWw6zXhQMRAlmUvAyseT1JwmvdmcfHvAd32gtMwQ
         Z2OwP26/toK18vZSal2YpXSMaK2LAdLtgzdLowb/mknytw4xlz2xs528eJ+BaU0wbI93
         J0T/q/hCv6y9ypR4CGQTYMq2BB4f3yk/5JwrZ73+gbCAo4Fruaozy7spbAPkFDgg3ehY
         KMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773612840; x=1774217640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcdSDWWl8Yxbno+lQtwlGlIW4vxAda9wkrHkc3R5BdQ=;
        b=dTiJ/DQIy2jTFkCFEW8ugV2OpcqcVGVd8CRBJAG6a1jjMv2/YUSgmSPFNt47x2/H+q
         kgI4XGZ5fblxCj7cKc1uOaUaPdzzZZTfqJc0M5xz+DMhpFs1gc9JGdUq53e4mpTZ3utB
         /6Lns/2cij0nq14/7SGJho7BDUyp7LLW9e3wyXj0mf1K6Tjc4vPGozzwLJUlfDysLKmE
         nao9G2AQhRbW1cV/54JaO3EyZbcmNJZF0iDZqOq4+Sqq6KpNjF3w4hA605cA6iYuS94K
         TtBcQbTajPuunVdbL71dhtU6wDoLHmD3r9ZowxGMB9DdGmfFiNzS6bpyOooZ1vrjTNV1
         bHQw==
X-Forwarded-Encrypted: i=1; AJvYcCVRQqxZRuoUKsRpIR47GY4h0a4XNgd+XtuEC1+8VXR/mtuqiFYErIEbvC1OqHqMuwDc7sY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCOMmESDhirhZF2APvTOgzD6Hx6igGUmzsMdne1TiLMm+aLGqc
	no/C+ukLsrZRRdSmHNUiMrTNeJzvLeCUo8w4Si2649ac3WiG3V9Zrzqz
X-Gm-Gg: ATEYQzzrHnec3lbvbHoJ+N4K3QAlJO9AlaIHcAT1rFpWS9tHLPYWBmbLJZP2sNbg3xF
	Y8ivpXLaQXwj06yAHQu9xW5tDTSEdlvF/soERfG2qyd9BqnuVyMJe5b/pICyGBuDyNfJVY2Egx8
	D8pdTb6V73Bm7A2M7xXvdRhUK9/4t1sEwatsq2Wi1O45n2Hd5MjR7fDutRMTdguu4ihPsujbbAZ
	ci7mDU3eNZhKLMV/pAcf2U1V8+OUgoFFCSMxT7Pbl0H1EHq8W4fDqlyubhafShlDKPRu4k2rVcK
	kWlz6PyRBmJsl3nNEMNp526Kpgk+ioNofRrzOqKURyUbm9o6akh0tZJLANGvoitNhCWbcWjc9zE
	oi8PJ7udOeG3CRWHl7Zxci3lIcvjLnOUUOS8KanmZi1xrGD1z9vyqPTN968a73/J95+tsjzE8VM
	52lkOs2U3pN5VnXJQYslR+JMsYXp+LGsSeWXCW/42AoqSfCIx6RvSly80BBzEVKvk1sy/OimC3P
	NKYVspVlIhK0KYmA21OWV9xe0D0n0aMMTbTH1BZZhkh/Qmgcw20Zeb3LcfCUOynBFFIC0YFD7Dd
	Bg1/bcdYQD0=
X-Received: by 2002:a05:600c:4f54:b0:480:690e:f14a with SMTP id 5b1f17b1804b1-485566f9258mr184228105e9.14.1773612839629;
        Sun, 15 Mar 2026 15:13:59 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d7c89d4a4d184346.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d7c8:9d4a:4d18:4346])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73dasm1127007425e9.2.2026.03.15.15.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 15:13:58 -0700 (PDT)
Date: Sun, 15 Mar 2026 23:13:56 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3] bpf: Remove inclusions of crypto/sha1.h
Message-ID: <abcvJKiknhTKjQkU@mail.gmail.com>
References: <20260314214555.112386-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314214555.112386-1-ebiggers@kernel.org>

On Sat, Mar 14, 2026 at 02:45:55PM -0700, Eric Biggers wrote:
> Since commit 603b44162325 ("bpf: Update the bpf_prog_calc_tag to use
> SHA256") made BPF program tags use SHA-256 instead of SHA-1, the header
> <crypto/sha1.h> no longer needs to be included.  Remove the relevant
> inclusions so that they no longer unnecessarily come up in searches for
> which kernel code is still using the obsolete SHA-1 algorithm.
> 
> Since net/ipv6/addrconf.c was relying on the transitive inclusion of
> <crypto/sha1.h> (for an unrelated purpose) via <linux/filter.h>, make it
> include <crypto/sha1.h> explicitly in order to keep that file building.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

> 
> v3: update net/ipv6/addrconf.c to fix transitive inclusion
> v2: update include/linux/filter.h too
> 
>  include/linux/filter.h | 1 -
>  kernel/bpf/core.c      | 1 -
>  net/ipv6/addrconf.c    | 1 +
>  3 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 44d7ae95ddbcc..e40d4071a3455 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -19,11 +19,10 @@
>  #include <linux/set_memory.h>
>  #include <linux/kallsyms.h>
>  #include <linux/if_vlan.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sockptr.h>
> -#include <crypto/sha1.h>
>  #include <linux/u64_stats_sync.h>
>  
>  #include <net/sch_generic.h>
>  
>  #include <asm/byteorder.h>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 3ece2da55625c..f11ab6f354e2e 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -16,11 +16,10 @@
>   * Andi Kleen - Fix a few bad bugs and races.
>   * Kris Katterjohn - Added many additional checks in bpf_check_classic()
>   */
>  
>  #include <uapi/linux/btf.h>
> -#include <crypto/sha1.h>
>  #include <linux/filter.h>
>  #include <linux/skbuff.h>
>  #include <linux/vmalloc.h>
>  #include <linux/prandom.h>
>  #include <linux/bpf.h>
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 0e55f139e05d5..04c1e856bf7fc 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -34,10 +34,11 @@
>   *						status etc.
>   */
>  
>  #define pr_fmt(fmt) "IPv6: " fmt
>  
> +#include <crypto/sha1.h>
>  #include <linux/errno.h>
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/sched/signal.h>
>  #include <linux/socket.h>
> 
> base-commit: 1c9982b4961334c1edb0745a04cabd34bc2de675
> -- 
> 2.53.0
> 
> 
