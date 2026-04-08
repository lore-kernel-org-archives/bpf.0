Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553A324B28
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662249; cv=none; b=Hiyd9LLUXWzqGJawRg0VGiN0A0Q52CapV9ZOh6XcLaa8s7iwNXw3on5IaH8GDDipk+S1Kq3+5C9+s8PO977GnmoaKL3SDLZ2FI1GWqxT1AfASGcTg/4a2jMvm+Z4vfXdkSHPXHYXz2VMKxj/IEB/CDKAOZNjShfirvoU5SEGaSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662249; c=relaxed/simple;
	bh=FVkH83tV7QxjhyNA2n/NjEBraJeFhhYY+WmVB5YdQbE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=e5guKmXSrMWvT75RPjCOi0PSpGiYCFiNSh0PqQshY9zf1Ph4KfROyctsKkhYn4VYY4p+TFGYssF5WLg3SoM0gs5o7nKhb7yhN5OpTOQ7hBLw2tM0jGivOkUy0CnEZpH6Gt6ll5EpEKpVH3zvkqu7IwsaOTtOx+xG+Bb8xNs7HLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N00gfXWH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N00gfXWH"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso29925285ad.1
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775662248; x=1776267048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CYJWvKlxezt4Ulmo0itRQe6A5FJ1PDskMHDYOSL/E1A=;
        b=N00gfXWHEr/bxd+2W3/fXrPf8BlpH2Z/ZvNiOnBvSwZKLs46xVJP+ubbgyB/EBBwVA
         zn3+w7Gi+5lAKOUSGORF6mGx5oYHl0aHOcONpCFHBx+uR0ZjqW0Gg4Rb1QrkGorvSa4F
         rdJJxaiNM9Zvp3mDFpVYECxzTK+rbeYX6+5BzSxaNd5b76RgbRksziRtg+LKFC3iMYSe
         an55QBKfT9AsXNMixnORqQS5ha+aWjXAVI7OFpRQfBDKjWeDezs6uxp/cZl2Pa+gaWrA
         GKJnqhq9mz9An0xWEUG2sXy5Jpe74zoUEmUoMhaKx6vPhw/9ouPd8c4chaXC4ndT85cE
         9KyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775662248; x=1776267048;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYJWvKlxezt4Ulmo0itRQe6A5FJ1PDskMHDYOSL/E1A=;
        b=OzGqV7J1cOP+XVJD0YD8iTmdGr/AJKobj9GmCAeMoisLNYM/76LFivKEIVftfqAske
         Bw2VAbpWXZ6YvCv6wOIu92YVAtMx6BzWMh5m52oj+PRqJmwKWu52zOyw6rVvDKICRd9y
         kdYtt++l5WXDkYeii3nLQqb4TueykG8fhkYQIQCceLxDXUz1THT0HXmp3Hn37UQ8/5Xo
         H2TjM8M7Z9EOyMvfIiiUEoXzYyWCZnX1hmEsLa4Tod/3QhErH3SucF3ddwB3Fke8oI8b
         ZYHMo60JukZyae9EY2Nrr/seml6EtNqlMWjIMH13WHo4VUTbHLVQ4TJ1KKoyQHDVzw5W
         Iuqw==
X-Forwarded-Encrypted: i=1; AJvYcCWBiTVALUgoAKhfhFBWZtkKOE8Of/OsBXkWOC7N6y0zM2Fv35il/gD4hK3VdC71NbhAGGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUhBapYFufKUZsVaMI2n66G4+Y91QQnxURzrL0thkZQ3TF23Hn
	AWZf7ZzVO69YFJyztMSNu5UVs0P+UMUpeY31SdQgD4w+baQHm521nctx
X-Gm-Gg: AeBDievjRVzqu+H4mDpuDzvXHNqj6VcoMES3mUGc0Z6QCCWyNJmu7ACWZgkHkZdSZ6c
	isarSDRnT0E5+hnMX0KrgQTXRmlPZe97o+kqwEpOApnIPLgJLliIMUQOzMJ3sD/3I4HYOJj3LTk
	9GPIH9UlMWwRw0e06yyJI0QT8w0jyrJ3dmRxpYr7RTc3avGtgpT4j7S1DfAxCpYCjhJ/HytyYvL
	pPMZ9eAntmnSUaTbKIM/uK8yph9w7VmQyZcCW7gfTzLlpJkdjNywc4VR1PVgff28YlVx99J9meh
	jMwxuRER/TAWO5IBsptm2b6CKqMIgWnFvXyiV3VT6V3ZbRCNlHfKPlhEvPoGC0r0inxWeVCWPDC
	vCmKZ5OzA0SQKY7rnAeeosNiTc+hjcpUkJGbsEvK971fJfoePc+KuVVPRpwI2IlrmdpOaO6paZx
	J7NpEFT6WenXYAWJTgU6nGKQAIxRG9SVZW/Uc=
X-Received: by 2002:a17:903:1b24:b0:2ae:8253:1452 with SMTP id d9443c01a7336-2b2816789efmr236259455ad.11.1775662247430;
        Wed, 08 Apr 2026 08:30:47 -0700 (PDT)
Received: from [172.20.10.5] ([117.20.154.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d54bsm200711525ad.1.2026.04.08.08.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 08:30:46 -0700 (PDT)
Message-ID: <66a977bb-cfe4-4bac-990e-2b91512c354a@gmail.com>
Date: Wed, 8 Apr 2026 23:30:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/6] Add support to emit verifier warnings
From: Leon Hwang <hffilwlqm@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
References: <20260408021359.3786905-1-memxor@gmail.com>
 <1a7aea41-cc64-4277-a08d-1cee1ad6024b@gmail.com>
Content-Language: en-US
In-Reply-To: <1a7aea41-cc64-4277-a08d-1cee1ad6024b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/4/8 22:55, Leon Hwang wrote:
> 
> 
> On 2026/4/8 10:13, Kumar Kartikeya Dwivedi wrote:
>> Currently, there are only two ways of communicating information to the user
>> when a program is verified, success or failure with a verbose verifier log.
>> Some information is meant to be more discretionary, e.g. warning about use of
>> kfuncs that are deprecated, and may be removed in future kernel releases.
>>
>> An example is shown below.
>>
>> $ ./test_progs -t kfunc_implicit_args/test_kfunc_implicit_arg_legacy_impl -v
>> ...
>> 2: (b7) r3 = 0                        ; R3=0
>> 3: (85) call bpf_kfunc_implicit_arg_legacy_impl#114683
>> kfunc_implicit_args.c:40 (insn #3) uses deprecated kfunc bpf_kfunc_implicit_arg_legacy_impl(), which will be removed.
>> Switch to kfunc bpf_kfunc_implicit_arg_legacy() instead.
>> For older kernels, choose the correct kfunc using bpf_ksym_exists().
>> 4: R0=scalar()
>> 4: (95) exit
>> ...
>>
>> With verbose logging, the deprecation warnings are printed inline in the
>> verifier log. When no log level is chosen, the warning is printed in a
>> block, as follows:
>>
>> libbpf: prog 'test_kfunc_implicit_arg_legacy_impl': -- BEGIN PROG LOAD WARNINGS --
>> kfunc_implicit_args.c:40 (insn #3) uses deprecated kfunc bpf_kfunc_implicit_arg_legacy_impl(), which will be removed.
>> Switch to kfunc bpf_kfunc_implicit_arg_legacy() instead.
>> For older kernels, choose the correct kfunc using bpf_ksym_exists().
>> -- END PROG LOAD WARNINGS --
>>
>> The set was tested with and without kernel changes applied, so that we
>> could conclude that libbpf feature detection works correctly and
>> backwards compatibility is not violated on older kernels. Still, it
>> would be helpful if other reviewers could recheck all assumptions and
>> make sure I didn't miss any corner case.
>>
>> One case I need more opinions on: log_buf.c passes log_buf with
>> log_level=0 and expects it to be empty, with newer libbpf that won't be
>> true on older kernels anymore. I don't think this is something that
>> needs to be addressed, but explicitly noting it here since I saw that
>> test fail when testing new libbpf on older kernels. The kernel will now
>> populate such log_buf will "processed N insns ..." log since on failure
>> libbpf will retry with log_level=1, so unless applications are relying
>> on log_buf to be empty for correctness it should be ok.
>>
> 
> Since I'm going to add common attributes [1] support for BPF syscall,
> how about reporting the warnings via the common attributes? Even though,
> the original intent of common attributes support for BPF_LOAD was 
BPF_LOAD -> BPF_PROG_LOAD

Also, common attributes support for BPF_BTF_LOAD was to report logs,
similar to btf_log_* in union bpf_attr.

If to report the warnings via common attributes for BPF_PROG_LOAD, we
should rethink the purpose of common attributes support for BPF_BTF_LOAD.

> report the verifier log too.
>
> [1]
https://lore.kernel.org/bpf/20260216150445.68278-1-leon.hwang@linux.dev/
>
> Thanks,
> Leon
>


