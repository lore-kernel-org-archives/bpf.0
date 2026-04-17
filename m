Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239BE394499
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 19:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776453381; cv=none; b=LLbHXqJdPn7IRSr4SSAbZuH9cN3ylD8Jk8bxI6vUIwEeVrnN96iI4JQdwA1/I22J2ZMzdgyCTcAFB9+xiMn9mWxbgjFJu27GEUe7HvZA2FtSSuh2wFb5y5JAVZjrPb8iCEk0CZJavrO0IDlHvAYGp8BiaJ6snF1vMWcyCulypiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776453381; c=relaxed/simple;
	bh=6lNwomoMH95ZwDKuPcGI9KhFdJlDZzsZgMK39xKu/Gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KSxglxOuRgmGqz1SoAOXeYDaKO0Rh6RF3VYyHrTc6afn/R51mJCsP9LcxLEltCHSBJ4nNHSxBeSxbgqaF3NBtlH0Ur9ARM5OTFbmX9BVIxghgbDVHXFNObtypzp1X+Tm/4V4+oPWwX4R+CLmE3mrRWIEBlehb3ngmOmZbyOMPaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePf7wp46; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePf7wp46"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so15424305e9.2
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 12:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776453377; x=1777058177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jurXrci8whaaLuN/Uf4qLRtjZxrLgVjTLMZVKIbvuXo=;
        b=ePf7wp46dNeKM1ORHX6SOAFrvYI2Cldn6Nyweial912FLtbgctD/lSEJOhgApx1+gl
         sg0HE3yeKBaoeyCcEdPV3Xy+KIN29hmg5jPCK9qkTwBx6B4ANJPY+cefnxBrfx6Q4ofy
         nrLIm1qji8HO+K32bQh81rNfxVOmI5R7WaDtVDsk5fwPQ1RVqSiKmVft6TK3Nq+pyUA7
         69VuKlJmpJm78Ot2WXFHSrm3dWVWLdf60LoqPjEnO8HToiKgN7REAXotuoVzwn/68LGR
         kt/gdAFKbx0nYi4bUNBQvm5nj+VBKnBFaaLgY7RBxrZQFsV7mzQKgbLIBVgFQCiWvou0
         Khkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776453377; x=1777058177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jurXrci8whaaLuN/Uf4qLRtjZxrLgVjTLMZVKIbvuXo=;
        b=NxLU7ueghJuh+FLyrl1enVMcaDk8BTWXxdeZHIPaD6xuLMVBU7PjxrtR3tW93u4ha7
         f3GPmlTN9rQoI9vq2bvaaLebzjoIMXGYd3ZdLhuabNwTp+ZwR0dkNTxni+effmstvpFd
         zlXIlPbGH8x+0CKd/HZ7JgX8DsmxOhSGJxuwMHXq5GGM8Rb1y3E7IMN5TOz9Yq3+HT/4
         gN+BRHPLUM7Y/UJlLpsrjEh59l3pLTAXwj8IeHu3k4xk010sjFCsex7j4OCW52sl4qD/
         IoJ3mnp0qYSMcW4Fl7WDaBW8AnA6wC732Ue8xUU5h1fwckc6q0SwOUzRfi1KTJNzjnnd
         Y+Cg==
X-Forwarded-Encrypted: i=1; AFNElJ+RAaPRwrOIrTfGsJJWl67VeDqMsMzuTdQEBCV9NcpsPbfEmeoAhEkRLdz7vlOcr6lanKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFIkTMCQL0VuS/aD4q/ABMXoVEoWrAfYbOpUg4lJJS+mWD92tK
	bzHVrTM6mu3n4yZlFo0tQ7oETuZLqJUpCP/TYfm5qTMDjTvbqWC8Tr1k
X-Gm-Gg: AeBDietm12NNLKql5JgORUT9deDO7RVe/V7uoWweXO8PZOFLx8zXFUKfXuyPmLUDytr
	Umu5EaMwVltl8QgrOHE1ROUrAkx45FP8h6NTUdU11lMLX9UvNkBkMcfVIwKfN/Dy5n9bLCn3xst
	sGD52jQKEi7FAyitej3zPsP0BU1XuqtVKiS1EU0FqWyu3AIapLZHQxShEEaOW/H49pTd23XkAdB
	p4pdMgN47ayGh8GIteCsVVRFV9qdpPsdHqpxyFmDVES9uyq6kHrkEXozV4XyUOCtf2q969usu4R
	cXYJepreXWHJD7epimiqhnW/gz24HqaWRv43+vgDbcbkIeMFe+Ls0psN69qOy1p3dtR+cIqJxLE
	aUxgvAMwGP+XI0niJ0TtEUtk3+K3QpomeXZm5m6Pn0s5hASRvcejSKPVqILewN36LA0GCFi41TV
	6EYOUmNSSweMXRlC59N56EbBPKmbxcqCesF4wzrsgO0x+zK0lg0etYdNrugvgz3kRIny4oh5O1w
	msmkhqg7o3agZS2wCEcbg==
X-Received: by 2002:a05:600c:888b:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-488fb74bccbmr48106525e9.12.1776453377331;
        Fri, 17 Apr 2026 12:16:17 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1393f5sm60893885e9.9.2026.04.17.12.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 12:16:16 -0700 (PDT)
Message-ID: <4426b0f7-589a-44b9-9bc9-4522f6a23d52@gmail.com>
Date: Fri, 17 Apr 2026 20:16:16 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libbpf: Report error when a negative kprobe offset is
 specified
To: Aaron Tomlin <atomlin@atomlin.com>, bpf@vger.kernel.org
References: <20260417184627.1259158-1-atomlin@atomlin.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260417184627.1259158-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/26 7:46 PM, Aaron Tomlin wrote:
> In attach_kprobe(), the parsing logic uses sscanf() to extract the
> target function name and offset from the section definition. Currently,
> if a user specifies a negative offset (e.g., SEC("kprobe/func+-100")),
> the input is not explicitly caught and reported as an error.
> 
> This commit updates the logic to explicitly notify the user when a
> negative integer is provided. To facilitate this check, the offset
> variable is changed from unsigned long to long so that sscanf()
> can accurately capture a negative input for evaluation.
> 
> If a negative offset is detected, the loader will now print an
> informative warning stating that the offset must be non-negative,
> and return -EINVAL.
> 
> Additionally, free(func) is called in this new error path to prevent
> a memory leak, as the function name string is dynamically allocated
> by sscanf().
> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>   src/libbpf.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/src/libbpf.c b/src/libbpf.c
> index 42bdba4..cd250fe 100644
> --- a/src/libbpf.c

The upstream of the libbpf is linux kernel repository (tools/lib/bpf). 
Is this patch for libbpf github repo? Please resend for linux kernel.

pw-bot: cr

> +++ b/src/libbpf.c
> @@ -12271,7 +12271,7 @@ error:
>   static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link)
>   {
>   	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
> -	unsigned long offset = 0;
> +	long offset = 0;
>   	const char *func_name;
>   	char *func;
>   	int n;
> @@ -12293,6 +12293,13 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
>   		pr_warn("kprobe name is invalid: %s\n", func_name);
>   		return -EINVAL;
>   	}
> +
> +	if (offset < 0) {
> +		free(func);
> +		pr_warn("kprobe offset must be a non-negative integer: %li\n", offset);
> +		return -EINVAL;
> +	}
> +
>   	if (opts.retprobe && offset != 0) {
>   		free(func);
>   		pr_warn("kretprobes do not support offset specification\n");

