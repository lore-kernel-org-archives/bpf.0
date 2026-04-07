Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62AF3AE6F7
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561414; cv=none; b=HI7acVf1AfWkPNmsdkRBR5vK+uVIimXgyExw/I7el6Ct3L0cYsXxSRrNGnYmKdmk+wGiJw++i8QogzmmIKPCjXB6JcjtbvkFBhxAtLBvTewgbOCgKo/P5k+LoIIxD7paXMVrZV6lNLkgOSbMQm6cSRHR2GjWr8Rx0zkqCfLF7uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561414; c=relaxed/simple;
	bh=gJmeGJ4YN8tSj2UwwdnqaAqNbb191sdvW00bw/KMDMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImmV/zHFw+j5ooBfFPvLN71mGYsS91hwgwS5dK1VHTUG2rXmbiK+sD3w7o6V6lNhmdZaMBqeQUBwtqT9V+ALu7KPacqGaLCfLQM5aDBWL0iBXTbFQDxj7+3/7W6/E+pdKNtDodFwNq7kb1M0jcK715n12AK1nVRtbRHzJ50pK84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LlgejsTs; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LlgejsTs"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so2670726f8f.3
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 04:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775561410; x=1776166210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X0AK+dItOezHrfutn/S86jIfwBt1tYlgVzWPhG3Rkg4=;
        b=LlgejsTsH9VJsNm/3X0MBF7h9YHfSL4diYMLtPfjqUh+JpV3M/Y0wPgN7Y1ctIcwv2
         im0KDa4nk/17sDatAoJzu6p6lyobo6xkj48+5xoDwElSUvwwMoKONYjukr2NLxduW5Wb
         +iltYLAfBzgwtTrOGZKBSMJHqcRVW6TDVpQShQTV27EfvapSBIluxWltwNuz9cqcpQ3i
         SsOi/aySKC0/5Xv+pPdLYyf0yh7JNmJdDTJVWMZ2EZoYF4pMyV5IbO02ahzOPrPKqezQ
         2hS3oEhzVOs69yrWQvLr8Ah6apAMl7QV/heiiKU1KlTUYP1v5y6KfAlpDab3lqldAZxd
         ompA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775561410; x=1776166210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0AK+dItOezHrfutn/S86jIfwBt1tYlgVzWPhG3Rkg4=;
        b=n8YC97k1Ge3ndzdNKZuoTnY7RkHaCwC+hAdxcRX0GtfGBg/pbWsPeUUj54Bpdj3gEY
         rqoFbNTk9JMxgj6LYP0quH4q/KyuuVyYV4IO7Aa0hOodXqgiGXX5tDbtV0EQfzVFi6/X
         /7FmY3AWC6mLRyDwi6jZl9b6QnpPplWpjnfWOcyoq+ARYvUj2dBlRL7naqyrjO8hqhCe
         cBhlC6x8WH9J8ULxtHLsB13wwrEkkTDOCNEZRYEELQPNCIbLEbk+PpPoWdhTSmxbiTRM
         rK+3fcBC4mjsof7e0aD8Sa9VDDx1LbIEJWVlloywl0H/FUJYzmWYym1Fu+temsyjaMqy
         7iVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTE5fMZHEe0aN7GzDqcVZWVl5ddzNRVdhT1SKr2uZnOCz+HM/vwkiRaTnzlbnJUoFF2X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyndHelw4o5jZMw0AIGkPXqcbopJAO0V6XgEWMLmmJcnR6LDtP3
	hskUbOAJ0UD7s/B4Q3uoXH+WKVzp+2OtuYaohXzO1C92YBibcWs4bUMXwJJE9eT2jSE=
X-Gm-Gg: AeBDiesmyo20hbWMEX/VdY0XM+q2mRWeq94Ikqwhm5DGUfWCn5ucKV0byqnkMKE8qTR
	n9rhwARJrhOD2FIRZtsKcNd0Gt409NuXaa4Khy19gzqiMsEZC7JNqL9anIMUJc+iBJhHzXVyKlh
	TUxEe1L0zdlhhk6to/rU1kzlQ8aPzPZxDun/1rgbRIDUWttHSBQwQogju+5V5UJ8u+UGQ7zQnQT
	Jjr6MAX9DBG2nirjAGA7v0NwJ+yRW6V6fUrNpm250O/ZUj67y71dcP4b5CTu69eZ9aFFlTqZ5Ty
	NDMe8xdRtYiZzbCFbEHsHdEmJ2WIiR3ZZ/NE28qbAwh46KYjPT28vcr/Z3IEW0Dal7qSCZ3vRVO
	oMyv9xKyJ0rNGu1QFYiEBU81DdazOHDNGWYWcIRKToqwHUUhddb+RZTYxNm1OMCbmEpkimx9COJ
	hh13G6R4K+7kup8e58RJunNASmoUVJQxhLjvQJ3V3H/5Zg
X-Received: by 2002:a5d:5d0f:0:b0:43d:184:8a9b with SMTP id ffacd0b85a97d-43d2929d8fcmr23481469f8f.16.1775561409975;
        Tue, 07 Apr 2026 04:30:09 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a720dsm49743604f8f.4.2026.04.07.04.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 04:30:09 -0700 (PDT)
Message-ID: <dc3db54f-f95d-46aa-ad84-6258abd13fab@suse.com>
Date: Tue, 7 Apr 2026 13:30:08 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kbuild/btf: Avoid relinking modules when only vmlinux
 changes
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org,
 bpf@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260402141911.1577711-1-petr.pavlu@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260402141911.1577711-1-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/26 4:17 PM, Petr Pavlu wrote:
> Commit 5f9ae91f7c0d ("kbuild: Build kernel module BTFs if BTF is enabled
> and pahole supports it") in 2020 introduced CONFIG_DEBUG_INFO_BTF_MODULES
> to enable generation of split BTF for kernel modules. This change required
> the %.ko Makefile rule to additionally depend on vmlinux, which is used as
> a base for deduplication. The regular ld_ko_o command executed by the rule
> was then modified to be skipped if only vmlinux changes. This was done by
> introducing a new if_changed_except command and updating the original call
> to '+$(call if_changed_except,ld_ko_o,vmlinux)'.
> 
> Later, commit 214c0eea43b2 ("kbuild: add $(objtree)/ prefix to some
> in-kernel build artifacts") in 2024 updated the rule's reference to vmlinux
> from 'vmlinux' to '$(objtree)/vmlinux'. This accidentally broke the
> previous logic to skip relinking modules if only vmlinux changes. The issue
> is that '$(objtree)' is typically '.' and GNU Make normalizes the resulting
> prerequisite './vmlinux' to just 'vmlinux', while the exclusion logic
> retains the raw './vmlinux'. As a result, if_changed_except doesn't
> correctly filter out vmlinux. Consequently, with
> CONFIG_DEBUG_INFO_BTF_MODULES=y, modules are relinked even if only vmlinux
> changes.
> 
> Additionally, commit 522397d05e7d ("resolve_btfids: Change in-place update
> with raw binary output") in 2025 reworked the method for patching BTF data
> into the resulting modules by using 'objcopy --add-section'. This command
> fails if a section already exists.
> 
> Fix the unnecessary relinking issue by also excluding the normalized form
> 'vmlinux' when invoking ld_ko_o. Adjust embed_btf_data() to first use the
> --remove-section option to remove the patched BTF section if it is already
> present.

I noticed that sorting id+flags in BTF_SET8 by resolve_btfids doesn't
seem to be idempotent, so this requires additional work.

-- Petr
