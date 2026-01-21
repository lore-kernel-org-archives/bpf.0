Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8551D481AB2
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999451; cv=none; b=G+w2X7jvU7DKT8jlMw4dX47ggpMR+yFBZVRhvk93nznpNNHK08KtKLQhzbigkHhszHAMSXd3Sv3+qY4maCIee6EieLHRxScIVOzllSpvNhLKuZoXrQXj0bLGJPn27dkIkfIunhwZODJm1dsdHGL+YZnaezykUJ6PU9CiciFglKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999451; c=relaxed/simple;
	bh=+F+kem/W5A6y2hHrIhgBUgfJeY84fC9Mmrp+h+GYx6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJPI+I080UTbdnFtHRGZX2+iUKn8ZxNgdy6KtnELhEfUVcJrv2IsNlpvDCaeismiEYEkt2KDf5/fCbU0XiILfRmF8l2TAM86I8ZQiug/WrKSjV9xtIrpJxSwJ7RVlGC/gMTXGVOQiGU2rmGqyQ5EW4DZQUurqgwuHXQIrPhPpew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aj5AHp/Y; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aj5AHp/Y"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee2715254so31762855e9.3
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 04:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768999446; x=1769604246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DaBQVPM2KlPxziZjUjyOxGDbVdYF9mjbZVUfxn6eSSE=;
        b=aj5AHp/YFQVnDR6ed7DJdzT0otAoiONqInvOOu8CtehCaxrV+uELQQXwgpLB44qpU1
         Gb19ygWT3cWUyiIGPN4jsKkdsl6+OaS9siAiexGeeCbpYU95bGYqfZsCt1mJwYzprUO/
         xoTehgKd0PQdLEoi8kobf2dyNMnw8SUbsRwQPsOqm+kKydV4oxYn4XV0JbBPDxHWztyS
         O8xK4Lg1U7o8XfTJsr6YZwi7tIXpQ3uEnPyPVlGdc4HMenLCBe4M6eUAsjMMEsOwPaNR
         tpOEfGqKxg/E/es2N0b+AFn6SpT/Yg8GlEdGE0E9lCneBzBWZUGIEMpGngOdzt8RWL/2
         86Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768999446; x=1769604246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DaBQVPM2KlPxziZjUjyOxGDbVdYF9mjbZVUfxn6eSSE=;
        b=GJ9tXfyzXnHVZEs64fXV7vkZV3KLk9EIX6jLH8L/Q2FuhAmTiXFNm8EEdYkUsTLXyg
         HN1ahOu6mj8V1ZjHj4Jdx48X2EIxckOEQwi8SwMgGM+psUo72E7fdzY/u3msPCCmj+kq
         Fp4yUSdgppFcfgt8kblOx/owOqslYSbnyQNSVuL95hId+6kdIbUGo10CIIrz5tJFI0Fi
         YrhPO0OuxRiTPs1lj6qi5ma76H/bV5uJmCOrBGJoEBbUp5wqbNhXsp29YHJTf+u6TeZm
         WVXA2DEf5O5BeTk6Szl3O61w00n1alAEB+bIsIDHIjCUxeliGabA1dvDraxZdD79iOqP
         AZsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmVFxV637bmn47fylaVgCqM8E695pmtwoeN7DjY6QZNspAu+nq+8oH79llAXVH9FAqPjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7tR404zyqqnX8pV5nPruFkhB5aWLuM7gwDDFk83NZTW2VopDi
	02xCxmKNuJ//fXAVMWWU45q0b4bBEQbxdcXf7vVbvBWJwg8g/tPc49fa
X-Gm-Gg: AZuq6aK1d7wmnQz/rUDDK5lbjlW7bYC6WAEQupZhhZoJCpIDQylbrJKnsPnZJTLgJu1
	250Ftan8tK2+1aG0/OR8xefT3K1z1Xr7xtyL4xCndxoCalz/COA9yOWukj6H7KOocudZ23MqQ5e
	04k6Y5sMzBlaeCM+rGBRSAnUQc0A3dT2ytoP9H07sGAx6q6RRUcavWDTa7Su1DodpA7q5KLzKC6
	6Io4jX06zDU/9vO2HBdRudpfWtKlkHYzaG6Mqt6GL3DYF6I0M9anJkOdS0h30/8xcEkr4bwG39I
	wuI9GDLsA6iIOeKRbPMJyF7A0AxyXUx9T9n4QTLtKrUhh55EarUYIeSK5+y5NEkTD9uJS+QK15r
	w+v1N+bsV4b4yn8JWx1xdJruyteGtRYogs0vn4nktI4EdbC410gOJiX3N4Q+uh7M//usC7J9mAV
	Q3LMez9sWtLmCq2mXKJELdeBXdprY9aqgOSA+sKwBh5J0alf/ZjUUv2rIwFk8cVp9VF+Hc0wtSD
	h8=
X-Received: by 2002:a05:600c:1c17:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-4803e7f18famr80265205e9.28.1768999445547;
        Wed, 21 Jan 2026 04:44:05 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e8d77besm314004695e9.14.2026.01.21.04.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 04:44:05 -0800 (PST)
Message-ID: <fbfee7e7-a6e7-4595-b444-325a5cb35dcf@gmail.com>
Date: Wed, 21 Jan 2026 12:44:04 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 1/2] bpf: add bpf_strncasecmp kfunc
To: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>, bpf@vger.kernel.org
Cc: vmalik@redhat.com, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev
References: <20260121033328.1850010-1-ishiyama@hpc.is.uec.ac.jp>
 <20260121033328.1850010-2-ishiyama@hpc.is.uec.ac.jp>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260121033328.1850010-2-ishiyama@hpc.is.uec.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/21/26 03:33, Yuzuki Ishiyama wrote:
> bpf_strncasecmp() function performs same like bpf_strcasecmp() except
> limiting the comparison to a specific length.
>
> Signed-off-by: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
> Acked-by: Viktor Malik <vmalik@redhat.com>
> ---
>   kernel/bpf/helpers.c | 30 +++++++++++++++++++++++++-----
>   1 file changed, 25 insertions(+), 5 deletions(-)
Acked-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9eaa4185e0a7..6c36f0fb5da7 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3406,7 +3406,7 @@ __bpf_kfunc void __bpf_trap(void)
>    * __get_kernel_nofault instead of plain dereference to make them safe.
>    */
>   
> -static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
> +static int __bpf_strncasecmp(const char *s1, const char *s2, bool ignore_case, size_t len)
>   {
>   	char c1, c2;
>   	int i;
> @@ -3417,7 +3417,7 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>   	}
>   
>   	guard(pagefault)();
> -	for (i = 0; i < XATTR_SIZE_MAX; i++) {
> +	for (i = 0; i < len && i < XATTR_SIZE_MAX; i++) {
>   		__get_kernel_nofault(&c1, s1, char, err_out);
>   		__get_kernel_nofault(&c2, s2, char, err_out);
>   		if (ignore_case) {
> @@ -3431,7 +3431,7 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>   		s1++;
>   		s2++;
>   	}
> -	return -E2BIG;
> +	return i == XATTR_SIZE_MAX ? -E2BIG : 0;
>   err_out:
>   	return -EFAULT;
>   }
> @@ -3451,7 +3451,7 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>    */
>   __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
>   {
> -	return __bpf_strcasecmp(s1__ign, s2__ign, false);
> +	return __bpf_strncasecmp(s1__ign, s2__ign, false, XATTR_SIZE_MAX);
>   }
>   
>   /**
> @@ -3469,7 +3469,26 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
>    */
>   __bpf_kfunc int bpf_strcasecmp(const char *s1__ign, const char *s2__ign)
>   {
> -	return __bpf_strcasecmp(s1__ign, s2__ign, true);
> +	return __bpf_strncasecmp(s1__ign, s2__ign, true, XATTR_SIZE_MAX);
> +}
> +
> +/*
> + * bpf_strncasecmp - Compare two length-limited strings, ignoring case
> + * @s1__ign: One string
> + * @s2__ign: Another string
> + * @len: The maximum number of characters to compare
> + *
> + * Return:
> + * * %0       - Strings are equal
> + * * %-1      - @s1__ign is smaller
> + * * %1       - @s2__ign is smaller
> + * * %-EFAULT - Cannot read one of the strings
> + * * %-E2BIG  - One of strings is too large
> + * * %-ERANGE - One of strings is outside of kernel address space
> + */
> +__bpf_kfunc int bpf_strncasecmp(const char *s1__ign, const char *s2__ign, size_t len)
> +{
> +	return __bpf_strncasecmp(s1__ign, s2__ign, true, len);
>   }
>   
>   /**
> @@ -4521,6 +4540,7 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>   BTF_ID_FLAGS(func, __bpf_trap)
>   BTF_ID_FLAGS(func, bpf_strcmp);
>   BTF_ID_FLAGS(func, bpf_strcasecmp);
> +BTF_ID_FLAGS(func, bpf_strncasecmp);
>   BTF_ID_FLAGS(func, bpf_strchr);
>   BTF_ID_FLAGS(func, bpf_strchrnul);
>   BTF_ID_FLAGS(func, bpf_strnchr);

