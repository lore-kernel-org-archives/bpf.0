Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656D23BB133
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784273433; cv=none; b=fiJe8p+C/b/XOOl4RPtyNTiruQEROqAacEH9/V/GKdtSoKjv/hmes7TPqJqCXmf7iWBF9xyCGxDwpmZbB7XxkXEnmuEY7r1hua3q50tndUHERoDlsy+2GM70t0H1YjM3xrruf0CZmQQlGRzceV9eT2T3G+FSDb0Os9y+EnoHi18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784273433; c=relaxed/simple;
	bh=xZKlkdraHl+jaaWIKZlO19Ud/PjIYM4VZGKG7EVQueU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwagMrY4l8nEflpww1XG3YvvFpFoFbkhrEo1gxzQwy0NUw4bpWWwl1jI0evoLqD/ffVR8WDL7azwQSbX+SbJV0C5D2M6ApLkhGovfKUMyYH1oxywZSxt4xhUED1wcGjAAzB7pomart0wIlptyEpl7/XZgl4zvcTFV1eKa5B4G9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bhMSLKZY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LrhSe7FT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhMSLKZY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrhSe7FT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784273416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EiTpHJiBdko2HxM97VIyiXB+2tLKUQclntf7/gSTl+s=;
	b=bhMSLKZYHl/py5zcKcL8NesfCCR7BVH4tV7jkyEaGZLJRR/x6bMPC6qxQT4KDPgqKMsCWq
	+QVPl41ftSVvod0R5Osyohdrla0LmUtDuAwhDrLl84zGkZNmukwqB/cUhS4ZImObchMAk+
	/lJahKyu157AoqU8hPnxmnJGZJE2UaI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-b3uEWtsLOty6Np5szSNRhQ-1; Fri, 17 Jul 2026 03:30:15 -0400
X-MC-Unique: b3uEWtsLOty6Np5szSNRhQ-1
X-Mimecast-MFC-AGG-ID: b3uEWtsLOty6Np5szSNRhQ_1784273414
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f64c9eb51so125654f8f.3
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 00:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784273414; x=1784878214; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EiTpHJiBdko2HxM97VIyiXB+2tLKUQclntf7/gSTl+s=;
        b=LrhSe7FTMjuJ6hKgCBAoOXvLZExvGfXlsfrxkNKxYkgkYn+Fiw6UdA1Ml8VoFT01iS
         B1a+rFM7VJjfrklCW1rylP+FSfDgryavk7z9VKI18wYnkqF00k8TxAxGnGgM6HfB9jW6
         EJV2fvdlMUvTeE3oYVT8u8mQXmiVDK89s+4+nQFhHzb/ZlxHhYw3wcUOMRKLap6aXlh2
         MznkSBk3tHvK5ZQOAyc7h39VRzxjRHv/ijYaVP03pSaU+QCgOdc8MODYl4YBh3f+FCdG
         2tXrD4KwAzSRgG48p1+TVYlRYOMWVzo6OqJZuZFPmV5o6vYNyMShqf4K2rmfuD15+MBc
         deEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784273414; x=1784878214;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EiTpHJiBdko2HxM97VIyiXB+2tLKUQclntf7/gSTl+s=;
        b=CMTs4mo1IozS+Z7AMsWS1jeNlmzUrl+nNUfGikcT8DRTID4Tv3t+13ybcD650N5Igm
         bjwewEll6WArITFTDu1pMwr5eAE6pe3H0WPzXzsOy8RNU3l3Q8dETCjxAUrerM9eCqlZ
         qrhWWnTEID1ARH6BGytLcBjn8qzH6xxDkNPYwVyOnnLh5HyO/0SMwjkKxPBUp+wP9q7Z
         K2scEN+moYdt9HMBPyCN1s33TzdnvbzXQxIi5z3l3Lu8zD0gP1pNy9kOkP+bq8uT2UiJ
         c0x/CBSMqsfQzYuivNi8S+VLObai7Dx/PHx8smRgrxnNTPBEcfrX4X5VP6L1mKptcMe9
         n3og==
X-Forwarded-Encrypted: i=1; AHgh+Rqgsa6eFfLOanl6dZoTnuukgergiye7UwRPr2hoOaJCFUuzod3xBy4OK04m5QTt4y33nZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj0PoFUQIt/2rJ/4RPlbFS7cdPuNE9y1ekFz7RcjnUm6/Adt9Z
	bA0RlDFDLrxp5Y1iZzmnY9TFDGXFJ6ScdCoh3bKZDWbFcgBG5aTbTT+DIVROUUmURoS8qap8X7/
	DKVhdFXxX8X0YmLs72BdqxHxYDGXi2Sdn+0baoCTlsIO+ghzAGsba
X-Gm-Gg: AfdE7cn/C0IYmt7GuYB61ynBFgA9iYjPs6M3N6fGQ/Dd46wTrfG6Y9YHVb186ycSPsV
	erLIImW0qBf6iZrOsZCF/lYB2bmQvNzI8a5DwcqqwEsWKqOymEllm4y9caY1yyX3vF1xLWJD4Ek
	JOY6sUL3m9HfXQrLALicRmrNeZmfOg1fcjlo8k4boRQW9jEUrhz1mI5c0Od36Ne60BhtkNG3Dlz
	wyeJ7ZSfvW14XTragyaeM4CrGWj3/jr2PHIDee8IuJ8hRBq3tgVm8b6ar7tEQwXxzC5ylzq8jOa
	w0JkezaLMlpN5ZodsKMOP56f7U7BxEmzG51yOcBK1MJkNUwcLiiXF/MJztFlUg89lhPkDwv722t
	3qyn6uBFst9prH3xAHR/gBljQEWdIm2IqtEI=
X-Received: by 2002:a05:6000:2885:b0:46f:5d62:d914 with SMTP id ffacd0b85a97d-47f6230651bmr2134408f8f.12.1784273413866;
        Fri, 17 Jul 2026 00:30:13 -0700 (PDT)
X-Received: by 2002:a05:6000:2885:b0:46f:5d62:d914 with SMTP id ffacd0b85a97d-47f6230651bmr2134346f8f.12.1784273413318;
        Fri, 17 Jul 2026 00:30:13 -0700 (PDT)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63edda9bsm1476282f8f.31.2026.07.17.00.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 00:30:12 -0700 (PDT)
Message-ID: <3e73aeb2-afce-4ae9-9163-51e4dc1ded01@redhat.com>
Date: Fri, 17 Jul 2026 09:30:11 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_strcat,bpf_strncat kfunc
To: Rong Tao <rtoax@foxmail.com>, andrii@kernel.org, ast@kernel.org
Cc: Rong Tao <rongtao@cestc.cn>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <cover.1784194024.git.rtoax@foxmail.com>
 <tencent_7B0E22F21BB4086D66815C86AA5CBC5E8E0A@qq.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <tencent_7B0E22F21BB4086D66815C86AA5CBC5E8E0A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/26 11:34, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Add string concatenation kfuncs, prototype:
> 
>   int bpf_strcat(char *dst, u32 dst__sz, const char *src__ign);
>   int bpf_strncat(char *dst, u32 dst__sz, const char *src__ign, u32 len);

Hi,

while I'm still not 100% sure that we need these since the same can be
achieved with bpf_probe_read_kernel_str, I do see some value in
ergonomics.

I have quite a few comments, though. See below.

> 
> This differs from the glibc library functions strcat and strncat, which,
> for safety reasons, require the size of the target string's memory space
> as a parameter.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  kernel/bpf/helpers.c | 93 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index c18f1e16edee..e4708a4f3470 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4195,6 +4195,97 @@ __bpf_kfunc int bpf_strncasestr(const char *s1__ign, const char *s2__ign,
>  	return __bpf_strnstr(s1__ign, s2__ign, len, true);
>  }
>  
> +static int __bpf_strncat(char *dst, u32 dsz, const char *src, u32 sz)
> +{
> +	int dlen, slen, space, copied;
> +	char cs;
> +
> +	if (!copy_from_kernel_nofault_allowed(dst, 1) ||

We're not copying anything from dst, this check is not necessary.

> +	    !copy_from_kernel_nofault_allowed(src, 1)) {

This is checked by strncpy_from_kernel_nofault already, no need for a
duplicate check IMHO.

> +		return -ERANGE;
> +	}
> +
> +	dlen = bpf_strnlen(dst, dsz);

Since dst is not a pointer to unsafe kernel memory, the verifier should
make sure that the memory is acessible. No need for bpf_strlen here, we
can just search for the null byte directly.

> +	if (dlen < 0)
> +		return dlen;
> +	slen = bpf_strnlen(src, sz);

I don't think we need to know the size of src at all here.
strncpy_from_kernel_nofault will handle it.

> +	if (slen < 0)
> +		return slen;
> +
> +	if (dlen >= dsz || sz == 0 || dsz == 0)
> +		return -EINVAL;
> +
> +	space = dsz - dlen;
> +	if (space <= 1 || space < min(slen, sz) + 1)
> +		return -E2BIG;
> +
> +	guard(pagefault)();

strncpy_from_kernel_nofault already protects from pagefaults.

> +
> +	copied = strncpy_from_kernel_nofault(dst + dlen, src,
> +				      min(space, sz + 1));

Sashiko made some good points about the `sz + 1` here. Could we just use
`sz` and add the null terminator manually afterwards?

> +	if (copied < 0)
> +		return copied;
> +	else if (copied == 0 || copied == 1)
> +		return dlen;
> +
> +	/* The copied character count includes '\0'. */
> +	copied--;
> +
> +	if (copied < sz) {
> +		__get_kernel_nofault(&cs, src + copied, char, err_out);
> +		if (cs != '\0' && sz > copied)

`sz > copied` is trivially true here since we're in the `copied < sz`
branch.

> +			return -E2BIG;

I don't think this is correct behavior. If this is called via
bpf_strncat, then the last copied byte of src may not be '\0' but we
don't want to return -E2BIG.

In fact, I don't think we need the explicit bounding of bpf_strcat to
XATTR_SIZE_MAX (as we do with other string kfuncs) because we are
implicitly bounded by the size of dst.

Viktor

> +	}
> +
> +	return dlen + copied;
> +err_out:
> +	return -EFAULT;
> +}
> +
> +/**
> + * bpf_strcat - Append non-null bytes from a source string, and null-terminate
> + *              the result
> + * @dst: Destination string.
> + * @dst__sz: Maximum bytes of @dst__ign, includes the trailing NUL.
> + * @src__ign: Source string.
> + *
> + * Return:
> + * * >=0      - Length of the concatenated string.
> + *
> + * * %-EINVAL - String @dst__ign is invalid.
> + * * %-EFAULT - Cannot read or write one of the strings.
> + * * %-E2BIG  - String @src__ign is too large or the remaining space in
> + *              @dst__ign is too small.
> + * * %-ERANGE - One of the strings is outside of kernel address space
> + */
> +__bpf_kfunc int bpf_strcat(char *dst, u32 dst__sz, const char *src__ign)
> +{
> +	return __bpf_strncat(dst, dst__sz, src__ign, XATTR_SIZE_MAX);
> +}
> +
> +/**
> + * bpf_strncat - Append non-null bytes from a source string, and null-terminate
> + *               the result
> + * @dst: Destination string.
> + * @dst__sz: Maximum bytes of @dst__ign, includes the trailing NUL.
> + * @src__ign: Source string.
> + * @len: the maximum number of characters to concatenate
> + *
> + * Return:
> + * * >=0      - Length of the concatenated string.
> + *
> + * * %-EINVAL - String @dst__ign is invalid.
> + * * %-EFAULT - Cannot read or write one of the strings.
> + * * %-E2BIG  - String @src__ign is too large or the remaining space in
> + *              @dst__ign is too small.
> + * * %-ERANGE - One of the strings is outside of kernel address space
> + */
> +__bpf_kfunc int bpf_strncat(char *dst, u32 dst__sz, const char *src__ign,
> +			    u32 len)
> +{
> +	return __bpf_strncat(dst, dst__sz, src__ign, len);
> +}
> +
>  #ifdef CONFIG_KEYS
>  /**
>   * bpf_lookup_user_key - lookup a key by its serial
> @@ -4958,6 +5049,8 @@ BTF_ID_FLAGS(func, bpf_strstr);
>  BTF_ID_FLAGS(func, bpf_strcasestr);
>  BTF_ID_FLAGS(func, bpf_strnstr);
>  BTF_ID_FLAGS(func, bpf_strncasestr);
> +BTF_ID_FLAGS(func, bpf_strcat);
> +BTF_ID_FLAGS(func, bpf_strncat);
>  #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
>  BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
>  #endif

