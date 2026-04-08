Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373CF3C9EEE
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775660168; cv=none; b=m0kS2TgTAIM2Ym+Oswb/9BMme5xDJQ7BajxPI8lSYD9APi3XqljMgCGYyoNMS/RJyL0D2rMlr8vuNhXjUlsrOfXVqs/zQV+gigGVz7NoYa0+D2C5ZcHR8tmentU5W3wCjDlLZFzavq37ovS7hWgJCTXU/j7SvuLPO1hl/Yu6M1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775660168; c=relaxed/simple;
	bh=fkfW4orQ4MA/MKJ/vf3ktE9aaTkleQC2L0DgUFB2MXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSCPA1zX5pfZqGo3YEVe+4XDXNN4NKajNKMH5aLTds9+KFNrHU+TJ1bFanD/tlExxyPMH2ytWmhhAGQFOHYnMj0OteiiBZV/jJzbMmfPrjEBfgfjajz5xVQmJ/5N9M53OqowBn6lGWBilmUZVLTLGu4aWmmBm0InWjWlw5MOx4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUBbQKVM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUBbQKVM"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b258576d8cso40009695ad.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 07:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775660166; x=1776264966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i5pgdWb++A07YMaxx9u2GAkovXV8Z1Q8Kgrp+5EGTlQ=;
        b=jUBbQKVMZ3sQRYNxOl4RWZMFhZpNQaCgLdECfRhx4bnman6O0DztdWLNgDr2TdUrN1
         yLqTpFLlOvU1K+KJlNPpMSoV1lYdWTBsRI6DDNAVONIfzoiV3JmmXh7mAGNWAYxxPm0t
         XjWyFKLKwEEHHkp13GVPCl0YkLE5dPcYfW/wLSn/o/Pc8Nv6NXTzyGcQo99zDETfwQO9
         KEiMvVqe6IWF1MfS2AGQ2hzyrgWnOgQM7zfd42jiSkFUJ17oNZ7PPi7CPcfeepKDRyGn
         fW3/Q+XmSVpd3D6B8UrVQriAtr+x6o764RnU18g61dAQeNT40lYKfj+giNIZnv1t+Fju
         x3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775660166; x=1776264966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i5pgdWb++A07YMaxx9u2GAkovXV8Z1Q8Kgrp+5EGTlQ=;
        b=JFQlEC3bcgxj9N1+nvf4ZU4JoohYPnF8e/7b8aPkgyFRhcMKbwDqedM2k+JgAgrQqb
         hQ4fEak42SPMxakkxO7xKIFGQlzeMUbZaku0e/z4pTO4ixnFOl2kUWbme5IiSu7IbauO
         ErF3kLKlpTLjEevbhTnUa4pGEmhyKq7tL9ZyVHvSQRKaoCIkMBsRhav5gyne35bDphmM
         WU5SfOOn5vcLrkMdlvROmqfyqBGvjHzqtW+1mz7VrmAB6RhLyO7FeutyEEeCVEL7N9Q7
         uLjnwoQxTA9/3fZGhoXxJgPvubz4niehgtGnVpPx8jOlpFRfiaDatcgSXl+Yi152rNAh
         QQEA==
X-Forwarded-Encrypted: i=1; AJvYcCX47K6CCr0VP3kG7iHgfryHQJ9+Sy/+2bEDYwYNxv+ucISoAjdwiJEZ0zswi59XfLoflyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqwxjtDHhQ2rs8NnfLUrjDxt2mLU+PJf6HOLcE8792YaEhER+K
	RK4d5EdpsSfVb49e1WxvKUykJAPVHjjOdI6fikFtJM+62p4pT+FhrdA4
X-Gm-Gg: AeBDiesBRDtk+yp40Uk8rikomearqrVhAeS6NSZQYfCCYdAMCjjy3dww0OskeCdX9D1
	HwmSPvXo09dDaND4qce9wkpIaTCIz+hLeCo6dyLveEuOkAor988taZ7pull0c0JWc4iQir2Hgjc
	KmpWBAS43AgM/nXCSWtH+O1aK00ZV0b0xBDqDaoD6g1rdwzEAGTXwO35+PRqBQODPEjXSvnpvDX
	YKL+tdlnberZUS30ob2uEuoKdW/CTIExqmPpn9//Pm78indbWbFABxahh+W9g9Gxv7Rc809ifr5
	zT43h5Afm1cmc8onVGEe3kZPqGmyu1vSyhZofnc6pvTE6SA40x2dQ98cJHDXnIb4mo20wYQX9R+
	xEvHGhT2FUBfGi696Ob58Iq2EiCjE9SvoAEmvAXiDD/D0ZJI3d8/MPNyzaAl5B7i8M71d2DX4e3
	02f2atqElrVjKOgJZWXQnDa8un+IHSLkh21vQ=
X-Received: by 2002:a17:903:185:b0:2b0:5be9:f423 with SMTP id d9443c01a7336-2b2819180c5mr212800745ad.43.1775660166355;
        Wed, 08 Apr 2026 07:56:06 -0700 (PDT)
Received: from [172.20.10.5] ([117.20.154.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478945asm273734155ad.28.2026.04.08.07.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 07:56:05 -0700 (PDT)
Message-ID: <1a7aea41-cc64-4277-a08d-1cee1ad6024b@gmail.com>
Date: Wed, 8 Apr 2026 22:55:59 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/6] Add support to emit verifier warnings
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
References: <20260408021359.3786905-1-memxor@gmail.com>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20260408021359.3786905-1-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2026/4/8 10:13, Kumar Kartikeya Dwivedi wrote:
> Currently, there are only two ways of communicating information to the user
> when a program is verified, success or failure with a verbose verifier log.
> Some information is meant to be more discretionary, e.g. warning about use of
> kfuncs that are deprecated, and may be removed in future kernel releases.
> 
> An example is shown below.
> 
> $ ./test_progs -t kfunc_implicit_args/test_kfunc_implicit_arg_legacy_impl -v
> ...
> 2: (b7) r3 = 0                        ; R3=0
> 3: (85) call bpf_kfunc_implicit_arg_legacy_impl#114683
> kfunc_implicit_args.c:40 (insn #3) uses deprecated kfunc bpf_kfunc_implicit_arg_legacy_impl(), which will be removed.
> Switch to kfunc bpf_kfunc_implicit_arg_legacy() instead.
> For older kernels, choose the correct kfunc using bpf_ksym_exists().
> 4: R0=scalar()
> 4: (95) exit
> ...
> 
> With verbose logging, the deprecation warnings are printed inline in the
> verifier log. When no log level is chosen, the warning is printed in a
> block, as follows:
> 
> libbpf: prog 'test_kfunc_implicit_arg_legacy_impl': -- BEGIN PROG LOAD WARNINGS --
> kfunc_implicit_args.c:40 (insn #3) uses deprecated kfunc bpf_kfunc_implicit_arg_legacy_impl(), which will be removed.
> Switch to kfunc bpf_kfunc_implicit_arg_legacy() instead.
> For older kernels, choose the correct kfunc using bpf_ksym_exists().
> -- END PROG LOAD WARNINGS --
> 
> The set was tested with and without kernel changes applied, so that we
> could conclude that libbpf feature detection works correctly and
> backwards compatibility is not violated on older kernels. Still, it
> would be helpful if other reviewers could recheck all assumptions and
> make sure I didn't miss any corner case.
> 
> One case I need more opinions on: log_buf.c passes log_buf with
> log_level=0 and expects it to be empty, with newer libbpf that won't be
> true on older kernels anymore. I don't think this is something that
> needs to be addressed, but explicitly noting it here since I saw that
> test fail when testing new libbpf on older kernels. The kernel will now
> populate such log_buf will "processed N insns ..." log since on failure
> libbpf will retry with log_level=1, so unless applications are relying
> on log_buf to be empty for correctness it should be ok.
> 

Since I'm going to add common attributes [1] support for BPF syscall,
how about reporting the warnings via the common attributes? Even though,
the original intent of common attributes support for BPF_LOAD was to
report the verifier log too.

[1] https://lore.kernel.org/bpf/20260216150445.68278-1-leon.hwang@linux.dev/

Thanks,
Leon

