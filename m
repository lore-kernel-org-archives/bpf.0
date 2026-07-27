Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205CD40D58B
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157757; cv=none; b=HabHvmjwqlJu5U6w9Sw0fU/YdNkkI8d2/yT/mE0wO4dtOnJRK6QlTQVQg8katBnhkHy17XSCi/vCzy8yUj5ZKCFPbLOp21YAX2JHdAPT9l9z+1kbXqJf9xJinkf7weudptrR0kJ/112BT0uTgIPRQa7mUvYWIv1evf5lTKDcDYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157757; c=relaxed/simple;
	bh=53fBBoP9fU3/ThO7t/yfHoDhErj1mOeWD0CuYuQXwE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ik6YiS6T74auGQJX79LhgVOGZBw0hSvHchr9VwS0Ho6s4G2YKdsci073XOsc6ZBULsKteA+BK67YMAPFobXghGpkVqycU0DCeP6O4cHtbj17gHZJ1n5T396K4GQmrKn+qHHu0RV4VCprjhOZceY9WUS5tYUyQUgIwqEE0L9whA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJOk9iVg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJOk9iVg"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493f75f7172so23258185e9.1
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 06:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785157754; x=1785762554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QUiq0u2Pnu448nBUShPNb5VIb4r8mjI4I6DVC3KHKDo=;
        b=kJOk9iVgsVxUHaBqq6o8jUeOwa1qdPyRmLxngtXWi+VfzhPMPdE7CUnDGgL8SyRgu/
         Xg/Eo5eKeYMzaj6DIIxJiS9xoYh8mA70TXhwu51JEDlGbe/8SKEN151VF+LfWBwEfB4e
         bU0l4G58kTUrCLU8l7F84kLBOGpW/r42AxwL15zS7DxOuqEIotiULTeIIxNxgwdT9HCU
         96HcbQabfk2j9inpoaCDVvEfQ2fJURzd6ycB+nFPHqdvxJDvIqdvQrKUAw6Ru3RcTsIq
         M5k7Uhv9AMovnZsb6lMPS2CZRzIKUgFkUEIh8bLTcZrwcJo83liKehG9okFbc53eGtKL
         zXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785157754; x=1785762554;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QUiq0u2Pnu448nBUShPNb5VIb4r8mjI4I6DVC3KHKDo=;
        b=XklbU2Yr0isPBqRs1blNFOuSIL1OzsMmYjf7I7TY/7uKgmtk2dY5vRBl1haUx0qbJV
         /P3TH0X7VglojS9GAvnWC9ScckQDePcfQ+aBn6lRdqT+/aXMVED4Asb8T2fz2QEcVJ76
         q3m8sk08XjTik3QfP9/Xih4i9XBmxJX6upEF1y/IbM0GyVZJ/k1BXOI/9muhxZoTrACS
         1auUCMaSleTQeKkxn9PujTd8HEJQeUe7ruKaEqKD4XoVyTijeTBEFE05iPmnfj2A/FQb
         Sf9gpqYdaZgMUn9UGdlxPo3MmAPHd1/l9WuZW+FV5wW9JWXTjBuqe/umTlyXIyvKT9rY
         Bh7Q==
X-Forwarded-Encrypted: i=1; AHgh+RqjTrlMhTEN1SXXykM5f0g0lOnoFxlWdfEQw7tfEG6AODd+QwNq1PnIYn7Zn1sqPlarO6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxzQVNBj3aVbu3+8cAqRG/jMDFZfjUmrZtqCzMbYbSYziIAOpP
	VOAwheXs475vIQ/ZdN8kDje+hwzh2gCutKyG0+WsrVHeCRe8cvUrA6wk
X-Gm-Gg: AR+sD13sRjYJAuaizbU1oe+zH2q4r8+lLeo2NNvW9xNURszF0eHzXDDpDT0R/AC58Ha
	/N7hVY0aOdfj22Sggnmp2KQJ0Y1JPUCfb8254Qwqev2/t7pMhfsvs0C5rLONt6RTteVbsuwHfja
	KJ0DxNq8vgSvPZVJSI3AIFH8EhEZPHr+K//f5hgJNvcAB7JFT4zCdsFf9J0i7/EOA9L/kgNbeug
	BKSoRouP5+aJnLTBbc3khqCdvFYgnHB12/LT1UVtGQDIQJONGZQZco6LnZvr/h6Aa8MY2DBqXcJ
	WN26FNOJtVVg0DYhzk+mN7FefyySXF13s8riA8KWMMo8Z03+P9wwQQGgkpkPSkCqAG9LCo4L0eY
	vnvvrnVMR4lzK3asVrJqd6RKAtyTmhU2qZIsaq76/rpHFe6RgDKFhgkx0uVNS3M0iGJqBmH8gDg
	bk8r+sgPKOw6hI8fhaWJbUXrtrqgjjV8txjNM1JjWd07sYKPbh
X-Received: by 2002:a05:600c:3596:b0:496:c379:b2a1 with SMTP id 5b1f17b1804b1-496c379b2a7mr11459335e9.2.1785157754172;
        Mon, 27 Jul 2026 06:09:14 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:c208:9e32:8612:3f5f? ([2620:10d:c092:500::4:a69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b5ed646sm232662345e9.0.2026.07.27.06.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 06:09:13 -0700 (PDT)
Message-ID: <c1b15a2a-88d2-4f30-a827-9a96bc35b365@gmail.com>
Date: Mon, 27 Jul 2026 14:09:12 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: Add __bpfcall attribute to
 bpf_task_work_callback()
To: Heiko Carstens <hca@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260727093834.2178900-1-hca@linux.ibm.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260727093834.2178900-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/26 10:38 AM, Heiko Carstens wrote:
> BPF kCFI support is optional for architectures which support kCFI.
> If an architecture provides bpf kCFI support it must override the
> default __bpfcall define (which translates to __nocfi).
> 
> Add the missing __bpfcall attribute to bpf_task_work_callback() which
> calls bpf programs indirectly to avoid CFI checks for such cases.
> 
> Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  kernel/bpf/helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 88b38db47de9..9bf82c9ea1da 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4447,7 +4447,7 @@ static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx)
>  		bpf_task_work_ctx_put(ctx);
>  }
>  
> -static void bpf_task_work_callback(struct callback_head *cb)
> +static __bpfcall void bpf_task_work_callback(struct callback_head *cb)

Thanks for the patch, I've already sent another fix:
https://lore.kernel.org/all/20260724-task_work_cfi-v1-1-2616691781ed@meta.com/
Is __bpfcall still needed?

>  {
>  	struct bpf_task_work_ctx *ctx = container_of(cb, struct bpf_task_work_ctx, work);
>  	enum bpf_task_work_state state;

