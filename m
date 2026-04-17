Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1871F4C8E
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776452826; cv=none; b=HH8G9zGU8+oX70RXbOMvTymmI6YndxwKkz6ePo2X2SnM5zaPID9ru7K8ChmnXobzoh2mg+9B7GJB3aoGcR8yeqp2wG1It2d448CBY28NDEiYuahissCtoZxGxlMl1LoDyo0ZcKH37Jf8CXwLYhciux0J9M9ulohrvrkdxHrexeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776452826; c=relaxed/simple;
	bh=jMBLTjZNyanJQQreyL8AFCxHjR/7NEKt38E90pmxJcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hV0Gp/V1P7rH+jPIsmGTLblXBwmawRYnOtfL6g9xfwJd7et+Yn2HNpLjytELhbE372qi74dwnWqcIlHy7EbdPYkc3Oia5WJDatPf2ZqwxfyRHTThWD1wAlqjjAmPXhK3r0VCDsTEmtc7+UdH7u/uAQAt15zc6zYGTj/d+ert2L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPF05JRW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPF05JRW"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-482f454be5bso21009215e9.0
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 12:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776452824; x=1777057624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i8m8i2CSSTDgz7OxHKWAmCmB9mufHegjAtDX5Rksy0w=;
        b=WPF05JRWV7wMpXShoAr+XAW9R3NnuKLz+HDT1r2nVR0LTLgbNebuW+/6DkQlHyDBy4
         Lmehu8yMtXQwAy2tipVl3jvCutneJwJzju34JYFigJBSM+SkHOLkKVXv3QtCswE33iwo
         T9arG/960zQAl5lGTQfCBvxeR27JTdYuftKqrYFsvhpxLhVhOxSWB7MSps9kedbvfrlO
         +atSzEKL9KRASOjZyeoCbM2mXYGLuRNnM8o41EVtSu8lNwI8ReW19qwVVnPw6R+WcvNh
         0nOA9LS8GyYtmQQi6KpWFls0v3WBas04oKIa1KevZinoXDtyA3LK9gKI23iCN52P3GX6
         3O7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776452824; x=1777057624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8m8i2CSSTDgz7OxHKWAmCmB9mufHegjAtDX5Rksy0w=;
        b=AC2y+iMa/4CGlLbKaE/h4PJnAKhkYMdHZ2x3wqd6IZ3z3oHqpR7FIZLJVgNLFDlJIN
         61H6buZv/A+mBziLg/8fsNj4lwdRJpY+h8y5h7MA9DDIrgDvVbxAHKZzGyUu2pQumBop
         ES1xlg44cnrv/cOIgPAwbwjoOg5OjElBHmIqftN+OdoQANTyr06M/44dc4u7hULqVos3
         ixw5nOD8yy24QySW8bL7NXt/GedDEJo+EH7aB9WPLUcyeLc4tKQgUe+FKWTARmslBlwr
         gFkNQoYuwH6fJO0qCep7Yq238fJLsUX+VgDA05+kKrJwRVL1pw+bnWDX+zBthdKV3RVF
         x2Sg==
X-Forwarded-Encrypted: i=1; AFNElJ8SDp0U/3esJ5DVyLl1fE51fYT5LtNJdq0fiJbVUL0HNrZYGCmL7gQWwDf+EZ0lYncL654=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUmHJ8d2W0ozl21FxfApsZO0XVp4wMHYluatH5aUpJY0y/vGQ7
	qIOREd1n6D8M/Jeb90qaCeZnxH76McG7U5bmpVUGfSWT53/Xqhq+/rXC
X-Gm-Gg: AeBDiesOzpbZqBnJ0b11YIFC1BBa0iUXyu9qEyglgOjF1jZcNBKBOKW4r1lQOI3DOCa
	CF33Kvn5gwfYq10Gyh0D4xCP3UP+P+MHw7uITbw075C5K3Fik5Av1uCTbnEipg39MDqYtZMbhzX
	FnGBNuG3XhZ4KcWY8Ozc56Tz5BieYmkNkUD6QWQLwANPJVZBLt530u6g7mQ2MVbZkvaxxLLV73C
	9nhrxQJ+hHH912Wqb1Y3bgAT9erW/0zCxa6cTLMgC4lfdmPk9GZJayGX+jMk5bPoocNi+jwiiGo
	nbIDThBruq12R4brQhsAhQRRmTAaoqjcgPEBnrT2/V6LUTMFfb7mogLZudg55cL4CIfPAUbTyqn
	fNSjUUUOmQ1OcAdyhgYDSJHgjlpWr1tP45cWdqjuxkXuH4qP1z9h+l0aJ2yI47WcEBmqtQzwN2u
	r/nS3sQtt/JnDGDNX7TcnmBlWFKH5GCIooy/KX//PpWKdooDZreb3FFY+QptqjXTIDYbfEodi/J
	lCpJ4GzSL4daLX8QMHyVw==
X-Received: by 2002:a05:600c:c112:b0:486:fe83:861c with SMTP id 5b1f17b1804b1-488fb896910mr49135085e9.7.1776452823613;
        Fri, 17 Apr 2026 12:07:03 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb735d3dsm53160535e9.2.2026.04.17.12.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 12:07:02 -0700 (PDT)
Message-ID: <243f07c8-f315-46c6-9936-aa11d66aa423@gmail.com>
Date: Fri, 17 Apr 2026 20:07:01 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 4/6] selftests/bpf: Fix up btf/invalid test
 for extended kind
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
 bpf@vger.kernel.org
References: <20260417143023.1551481-1-alan.maguire@oracle.com>
 <20260417143023.1551481-5-alan.maguire@oracle.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260417143023.1551481-5-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/26 3:30 PM, Alan Maguire wrote:
> With extended kinds, 32 becomes a valid (but not used)
> BTF info kind value; fix up the test to check for the
> "Invalid kind" rather than "Invalid btf_info" message.
> Since all bits are used in BTF info, it is no longer
> possible to craft an invalid BTF info value.  Use
> 127 (new maximum possible kind value).
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

>   tools/testing/selftests/bpf/prog_tests/btf.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
> index 054ecb6b1e9f..0cc347e32db3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -1924,11 +1924,11 @@ static struct btf_raw_test raw_tests[] = {
>   },
>   
>   {
> -	.descr = "invalid BTF_INFO",
> +	.descr = "invalid BTF kind",
>   	.raw_types = {
>   		/* int */				/* [1] */
>   		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),
> -		BTF_TYPE_ENC(0, 0x20000000, 4),
> +		BTF_TYPE_ENC(0, 0x7f000000, 4),
>   		BTF_END_RAW,
>   	},
>   	.str_sec = "",
> @@ -1941,7 +1941,7 @@ static struct btf_raw_test raw_tests[] = {
>   	.value_type_id = 1,
>   	.max_entries = 4,
>   	.btf_load_err = true,
> -	.err_str = "Invalid btf_info",
> +	.err_str = "Invalid kind",
>   },
>   
>   {

