Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48BF2F0680
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568843; cv=none; b=kMYJwAB0o7TYFw7oH1a5UO8ZQDcad+GXFPzMTK/YPAqx/4183X/spGITeIyY9iuze/CCHiB0f3Lkkfr2jzOyEsGbMMdYVhbrArt9mhXMu/TxRDm/tKvUUaVOOvXE2zkT+jGSBycEiJImIrVf5BBQlEFQmeqiscRzqUXnS5SkCoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568843; c=relaxed/simple;
	bh=5+1HIFGffDicEK+jtbv1grqiIBz6DgOALeu2G1thgSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLZjkVeaWctiMr6y60I3FywiRaadpFFSHoLgY0lgOBlSW0ZKvUMnKaM4mwYt3Y+84Z++h6+poVgG2xdK/aHc3SsUV53WitS/h/oXSrWYjYPAK8NrVuBRxL2OLDmUGWqxYRkhcZqA/5lqQkYfyMrh+TKiCVCiKYNoNCYt792tY9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5BAe+fz; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5BAe+fz"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so8750229a91.0
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 10:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784568832; x=1785173632; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9aCLrLf53nr1V0yxy7c+zTasVcZkTH5A7c7mDrM/Tqg=;
        b=d5BAe+fzs0Xm5dkiS+XFJ5RZm8Q4oc9Idcxp3OegzxpEoiBnLyVOoADwn5tMEf2eC6
         TK0Bv/zOVtLPjIdv8jwBxBOCO5K8duD5dikFNEToU1Mbq8Kxxqz5dvfbFMocsxHJyjTE
         57qL8+Ap3X/rslOFSZFiuCTcVZZKHpzZONj0asHKwk+lcAE4ra6sxaAmp5BZApK2rBGQ
         6kD686ou0oUU3ldD3y42yDlfx5InRU3/eOUisHCDQs29e/k9J6c38nP+mgM+vhDvI+NU
         oeN8uODOSZxNbUl8Pc5q9brTbgxjm9PUtDS0luUq52PCLgRhPbCP9yeDOoYeNbyHtrTO
         glQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784568832; x=1785173632;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9aCLrLf53nr1V0yxy7c+zTasVcZkTH5A7c7mDrM/Tqg=;
        b=l5z4p6/zPyg/8y4m9PVGoc0WNSyHIHbhSu5I333WYXmdeVY519UpxrSKGOoCBrDC5D
         t4LTWGqtrWZRVQ2wZ1Ksi+DkeSTCjask/K7Ea07e1JBdqAStz0egd1jIBSRRCUAx3MQO
         q/cgQYZwY9hDwrsl267b9FuQ/EB9nmiUxhA/FpjNAzzeeTSDhhbGmN5eVY5quQJ7zDLa
         C7DyQ/clOi7rSwfGymdYGmsSqHufWVQi3HUieYaBjGMTXnq7tMD4up7T1x/IQ2fJd9ID
         tmaiys3+7Ac32O01fS0ZZ8ma8O9HLf9xrJxCLn9SuM5LrSEibdvPh+3+87L+lLuDUZ+4
         kzwg==
X-Forwarded-Encrypted: i=1; AHgh+Rp9r7Wc4IuJPgpy4npLRjsdrLY6dtvu90sMUAizXhBuYQW4M6f/cClqwH1YHsSx/M4HTQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPHD18pNbLRiMMFVaER0qgIRbuX9nq9eTNZoUZrRHWH6JvRt0I
	36CZD+Ywgs64QrBTM2JhIKGC2J0ZC2Cdvh0gAxIoBFSwhAJtxwoSx65F
X-Gm-Gg: AR+sD13wBgxMk30osMrZeIZW5dcT2CsBhUY7jzcWcQOPscb6qzUvHNZIhhoy4GCo6uQ
	E6m912i/pvddm/fHoEgO2Y56R13iJ7wN0wtmNDxgGleXNheBlYGckvwAYm/gWGYGD1knQj9ywlC
	EWPDHy8q5+ySE1MFwyGHriBduRx4rBsSNYKzSOo2ZyMUG0tjYesjW8Lj63LQ/zvpgaVcVDg5jZW
	2p1yQuANRB+anpiqRMy0D1Q1Tv6MvAj9dTsnVyelhP0I6gLwjVxpNx6T/hhrwyASq9FccztH0jG
	yMrkHxui7upgqJEWuegXbWolPzk61x+RdE/6BcMfdoOFZ2oxihD8fSbgJYublT2juAq9pqEg9J5
	p7nVb4jKJf6I8zMquxLWq38VEdXIdoBozAWXB5MQiAit+28lzMd3y/GbszE0KmPdtlWnXjznxqx
	zHkoK6tc8JK7pEOvoU/Xc=
X-Received: by 2002:a17:90b:3b4d:b0:38e:7cb6:5c35 with SMTP id 98e67ed59e1d1-38e7cb65d63mr5164704a91.36.1784568831911;
        Mon, 20 Jul 2026 10:33:51 -0700 (PDT)
Received: from [192.168.1.77] ([50.47.108.115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e46b2a4d4sm1675799a91.0.2026.07.20.10.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 10:33:51 -0700 (PDT)
Message-ID: <4f264a16-bf79-4033-9196-603c168406e1@gmail.com>
Date: Mon, 20 Jul 2026 10:33:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4 1/4] bpf: Fix potential UAF in
 bpf_netns_link_update_prog
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
 <20260720134547.1289964-2-pulehui@huaweicloud.com>
Content-Language: en-US
From: Amery Hung <ameryhung@gmail.com>
In-Reply-To: <20260720134547.1289964-2-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/20/26 6:45 AM, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> In bpf_netns_link_update_prog, the checks for old_prog and prog type
> are currently performed locklessly before acquiring netns_bpf_mutex.
> This creates a race condition that can lead to a UAF issue.
> 
> If two threads concurrently execute BPF_LINK_UPDATE on the same netns
> link, the following execution path can trigger a UAF:
> 
> CPU0                                          CPU1
> bpf_netns_link_update_prog
>    if (old_prog && old_prog != link->prog)
>      return -EPERM;
>                                                bpf_netns_link_update_prog
>                                                  if (old_prog && old_prog != link->prog)
>                                                  ...
>                                                  old_prog = xchg(&link->prog, new_prog);
>                                                  bpf_prog_put(old_prog);
>    if (new_prog->type != link->prog->type) <-- trigger UAF
> 
> Fix this by moving the old_prog and prog->type checks inside the
> netns_bpf_mutex critical section.
> 
> Fixes: 7f045a49fee0 ("bpf: Add link-based BPF program attachment to network namespace")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> ---
>   kernel/bpf/net_namespace.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
> index 25f30f9edaef..9fc62db1441c 100644
> --- a/kernel/bpf/net_namespace.c
> +++ b/kernel/bpf/net_namespace.c
> @@ -171,13 +171,17 @@ static int bpf_netns_link_update_prog(struct bpf_link *link,
>   	struct net *net;
>   	int idx, ret;
>   
> -	if (old_prog && old_prog != link->prog)
> -		return -EPERM;
> -	if (new_prog->type != link->prog->type)
> -		return -EINVAL;
> -
>   	mutex_lock(&netns_bpf_mutex);
>   
> +	if (old_prog && old_prog != link->prog) {
> +		ret = -EPERM;
> +		goto out_unlock;
> +	}
> +	if (new_prog->type != link->prog->type) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
>   	net = net_link->net;
>   	if (!net || !check_net(net)) {
>   		/* Link auto-detached or netns dying */

