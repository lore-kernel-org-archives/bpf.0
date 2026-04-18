Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC0A2857EA
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776543901; cv=none; b=dYeYVrjhSzP3zYzf/aQ66OQYbK20MVd3CY4g9vFcgyxZqxkxCfZ823AwoEi/6jlnGFnURY5iPc1pCKiHzYZQBX45oC0vSL1mVSR8HZA+NP3bWMqUI0ql4Ezy7ezPNe39DOMkdoXYHcit2FIzgjdTFF7T6tT0AJ3vnD4hjYI5Tc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776543901; c=relaxed/simple;
	bh=1TlQLg1hmyRIP5xa792cH1aj6284vPZu7SIqkmxkdqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6wCKlEhDRpiPDqlR4iYd51JW4dxgy6+OkWkyl5EWkLmhPzk1XesClPC7qdVdr3PIKAsq8Dcplekb4js+sMZNfPbn6m9gBWL/t5wGDpxXEQu241akxLdpc6QxEgOkB5rlJ8UBYdX0HW6go6AIkKyD7UkNid4mWPlQCEFB1dg1Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgx4mwQ0; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgx4mwQ0"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso23075745e9.3
        for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 13:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776543898; x=1777148698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=shrpPgBn1ciDVC0UZRKGswrL54fyNSPIH9KuoX6GYKI=;
        b=lgx4mwQ0qgJV1nTkjvQVBxTwzV1yDOXdYIZv+H7ybaQ7hAZP/nx0nFeWzjAHyi6Ign
         cZ5vuoC0Gnt2+ZjzJouCI1fKphLFTE3jQ70g0MsiHPHIbuNh+VbcddRGlWiDV6UhJTLL
         n5n54/tpNdCbTZ6h610K+lEXgXbH0+Yz6c6AjU3rLMysgaVs7jOhFi8DzgfBkR3uUjxa
         tsUyOsdJD+SjuXlPOjiGoFZBm31VmnjFIT1HO37EdTNqicIVat1o2CVwrIVRgqoGMm5y
         IdPUVycm8Ofgg5S7QTLyVaqW71qTvLtj06cXKNqbL6q+p9Eu1Im1kBrG4cp8FFoW+NRV
         brYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776543898; x=1777148698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=shrpPgBn1ciDVC0UZRKGswrL54fyNSPIH9KuoX6GYKI=;
        b=kK2qFL5ifZLCEDN4DbHjTwNr7yP7wPdghBR/dD5Rynw/ZKOD6H1lv0gNLUwVqEMY00
         dTz+ZfJqlXrCZQ33TmnqNp+5bRiuP1XquwjoXSAEoOC7d9PFmt3fDVl/ZtEpM0SlQG7q
         Q+hSImB5u1ugqJUdKPQxQ7WvI9grTLCP0ANskdmaVCKVeUUT0N6olJwVQUcix4IJfnxb
         B1PCkPffyxoFcj/kbtJgARkMXNbXhERg3TtUOORmjBNHxaHJIN4Hzb/FrigD/4xUWJJ+
         JGpnT2IAgns4lhpBB9CBMvGeswaKDItpr+3iCrdxsc/M/WMczVg5nkNXF8E0HQXh7zf1
         vR9A==
X-Forwarded-Encrypted: i=1; AFNElJ9S47bPmcEdHVugrMVjDbEeF+DqVHo3mHZJKsJME6cnTFmg3ORbvd6KlMpDX9+0vjV/f6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw551I58OxJXY2LzJyTBMdhKt4cvAvfI9sU9kNBYgC+N6L7l2LC
	EPO0JjpGI0B3y+Finm3FzS/lgnCNIGn/IlHHjRg3Fj7sLQpH/qbON0E7
X-Gm-Gg: AeBDietaARkqSmAiUyLuP0LZJRt113Sa18WnB+QkXaK1wSUNoyNVo+Onqo6TvYUR3QL
	xeCEVGTjXLp3qnkTqhNnqtIKUGkxb9QdL+7nhcY4fxSOnHZH9+K7Aok6TANOdTLXLv00Sx2JW9f
	DiS5GM+P2hHyPlY8kMxgVvMkRMzpGLuRuw3jowBTitMuCmhb6+TkEV5580WiDOF1MY30gNcN3cg
	dYRy9gy6kAkU+dqZoAdNhN2BR3dggcrd9musOeXgYDIT4KggAy8x1gGn48WEca+MQgWO2GKfF4f
	DI8pcWW/B3OuPGDv1MAY4lWNb4Y1BqAbY0Ox5ARm5Zb910Nj+fQ5hdOPBZvMEDKKa13b51GVDl8
	imdfs/tj0a2u6L7UNElet5VacXIZZDzMHUftIxGDwrprnZnctGso2DJ6gFDJmBegcX7xi6cJVkU
	3HQWbXHoXw9eBLXm/gcx5AShM+Imh97Awr1Dvr6i7vWr7rApIi1FayEJcgOtDOe1wES+7Mndfte
	bFD2rDjWmNrfpf7DaPpIg==
X-Received: by 2002:a05:6000:2511:b0:43c:f3ef:ee36 with SMTP id ffacd0b85a97d-43fe3e0a460mr11869724f8f.33.1776543897650;
        Sat, 18 Apr 2026 13:24:57 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a7b4sm14602328f8f.22.2026.04.18.13.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 13:24:57 -0700 (PDT)
Message-ID: <0a8afc43-dfd8-4aa0-ae94-a82f8c307599@gmail.com>
Date: Sat, 18 Apr 2026 21:24:56 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libbpf: Report error when a negative kprobe offset is
 specified
To: Aaron Tomlin <atomlin@atomlin.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260417195816.1265179-1-atomlin@atomlin.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260417195816.1265179-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/26 8:58 PM, Aaron Tomlin wrote:
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

you should have used prefix bpf-next and v2 (this is the second version 
of the patch), you can see how other patches format subjects.
The change itself looks correct, the bug is introduced by e3f9bc35ea7e9 
("libbpf: Allow decimal offset for kprobes").

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>


>   tools/lib/bpf/libbpf.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 42bdba4..cd250fe 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
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

