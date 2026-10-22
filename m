Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674326;
	b=Ug9qoDHHXyERtF1KxC7RsTzQokcRl72Y4eeu1PvmHivI8iUVOiUHCsJbNu3PK7uw+/kY
	 jU+Zf7rYjS35E4vKREynVKJy52SDrkgHcroQvLXTiQ72yncjV6H8auw11qTQnmPoUZLP1
	 48hWrKfWBS/CDAhcXevrCCVGN4ixpApIleKhwHABS2U12rVYpzN9M2/CwovNa6jcA/eKT
	 NK1lWNar0agjwR6UoBpqErEO8FtcIdRLMOSwBrTGOzq3WXrqHUbmhbyAAndW+2KBNxEG7
	 CRQgu+W3UD8j7SzHP4FgIl2gv6C6DyLeS+RR7r6LimQq0WaGITaiGXCWeDje7doob+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=icFNT5ZLs9kOkqCAigqmx2IVCcUIeokw1bAR3h5f560=;
	b=uch3K+QCLK+gRjVqNRcV3QHEKJeeSfXLaLu9CL/l2Qz3T4c/FR8mrB4zvLwDVeKTV9Um
	 hiVbsoTifOeUV0FdW9xHHVDwM+TLRmvdH+pdk44WOAu/w+3zlqZKhMMzYTOjXwpnqGg1u
	 KTMj9SAtjho0H4VwVpw0JJp6MHApmzlsXIOv+TYm5dp4IK30vY10ASQyFEaX2i8hxJFT4
	 oFB5vPv9u80PFnRgNF3TNtckwgfNuVKGXYdDCYWQveFptnNmvxwtd7FQPg1KJYXw1OZLV
	 JlL+99ItNLuno2DR74Z6AlrKz9zhvRBJuHvAkiZY1v1cEnYjF0ydECObL2khvqMPSpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aG6BRZaD;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736EE606A319
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 13:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 736EE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aG6BRZaD
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c43373ae89aso272265066b.3
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 06:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792674325; x=1793279125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=icFNT5ZLs9kOkqCAigqmx2IVCcUIeokw1bAR3h5f560=;
        b=aG6BRZaDcD/gyJ9pdCFc3HQg1ClvBDAS49gzv2iEjEP2pptIyzSqK9oNRK0d6kC8eZ
         3Dk+69llrQnaThq9kCbysj5Oby5lKmx9lrSBUi/ydb5T/Ym9Fj5RW2etCW9QMh5vP4bn
         /XcdZGgubhbJn24j7oaq9smwlcBWCWvOaV2RSj0CzTQVMhpzxrxKF6HUaYBfi7vChEhT
         TzbvpcRWHCv6sRfwSiImBu8cpHMxboxKOzFx6o5ro7aIWBk6HhFjo5U8v2wzKgBxvp3d
         ZOZolMuS4W54I2WgAwz9DJUhGgN8iCK3sy60bdw9SAsjZVUsCJxYjXCvMuXz2vQ4XVe/
         aXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792674325; x=1793279125;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=icFNT5ZLs9kOkqCAigqmx2IVCcUIeokw1bAR3h5f560=;
        b=gXLVM71Mp7VlO7S+nIY+xnmg6DxM5kJHRmUoPPrGITP0YNA+BMsz+f8m9jOA/tPasN
         ifS2Yr2SPEOpMv5qhHKrmP+sqecoZ3xwFNfZP9QIutpfDjf/UmOvFiB2Wjbu8hjBDZAP
         9kcrvkArc0E9o8Q1hhFfqgcRC9Lnr881qFqCwk5ooPKNKCtTGUHiFMbq6swcaN2MqbuO
         QkPhPnfNdgsRuA+JxRYJu6juHvsZCL1AftluyQG06slGW5nWr9sY8wwTDQ+XrS3RrElj
         a+wGi70TaKGOd5HfNsyuUD44EzoJpA8Tq61y04rB2VL7jkgcTYOUPbrhD7l/rqzPd2/T
         zmeA==
X-Forwarded-Encrypted: i=1; AKwUvBzxzbIvrAedjqRfLPTfw/Ac+JQhKZIJMxLJD6AopLtn4r4t5jMEBUY6i3ito1Xtwv9ZM/I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyFONcFbWr46uAEoAyIwdU7Yj67NyPb7S9y0pBgCkAAQ2STAt8
	oFr+1SsQy5IXIBuYqsu7ZB9VteyF7Mk3XzZ+zmiqnpv5fmX1eTH1GwhY
X-Gm-Gg: AYBFou0vAF/DC4UAPsuH5d8NUtst5SwunXjJLxr1vsuCbr+M/RlZqF4OVUICPHlbBI+
	d3NBNOYfZBZQAkTIwMP1BKoqcRqNPVcKBjGN4yTf4PR7Y9yWOauErQZl7O5Fksdsrn8frcM4cnv
	Rsigchis7rjVv+jJ5BTfTrt1pnEwTR5aaxPdfnrJduf0REtFeaqNm63MPXInaE6C9A10rD+hmU2
	zea/5N144w9oyuc1H6YoFoBGdMH8CDRPZ4hxzKkDe1HSNMxwgk7TY4ZG02PllrIjW213s3uHrti
	422wpwcXZPfxa5672P8fpIZzVd4ofQ0ZZtoY1ZeLmDXf+Z2SBdgW6a1Me2KGENHqsIm2GRBrwXn
	8XPIAOG1/FWgSyz4Kk523Bi/FSNNptaCv+WkgDDMP0VJn2IQhTlvi3M+55LNzMBa7YUpvwlrsb3
	pStoq+DMwoVBtjWZ33vJ7pY8sD0Vk2nupJL4woTJ7OH+xT2C0G9Q/nb5xPx/EfGAA0rkQ1UxELQ
	Ftd5DcSU0/3goceR5+rkLmU6vp2MwhJrO6s337l8i4/dEvbALKiL1ZGhgi0mYK7b2SeWpWv5JGz
	LsbBhawXlQ91GHHNfKypz6+3hTMygMVkckzRQVI=
X-Received: by 2002:a17:906:9fd1:b0:c3e:e677:5608 with SMTP id a640c23a62f3a-c46795ee0c7mr532331966b.12.1792674324624;
        Thu, 22 Oct 2026 06:05:24 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:215d:2010:17d7:cab8? ([2a02:8109:a307:d900:215d:2010:17d7:cab8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a1ef356sm104192266b.9.2026.10.22.06.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 06:05:24 -0700 (PDT)
Message-ID: <2de8122f-45de-42b1-b070-acf60ffe7c96@gmail.com>
Date: Thu, 22 Oct 2026 14:05:22 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test JIT jumps which
 change at a repeated image length
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com
Cc: yatsenko@meta.com, martin.lau@kernel.org, yonghong.song@linux.dev,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20261022-jit_size_fix-v2-2-4bee6921b218@meta.com>
 <6896375813cf93e6e3c7ae7a8f329d9fa73568dadcb55b7ab364e5c18ce817c3@mail.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <6896375813cf93e6e3c7ae7a8f329d9fa73568dadcb55b7ab364e5c18ce817c3@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/22/26 1:44 PM, bot+bpf-ci@kernel.org wrote:
>> selftests/bpf: Test JIT jumps which change at a repeated image length
> 
> TL;DR: Test issue: the new jit_insns subtest asserts the program was JITed, so
> it may fail instead of skipping when no JIT is available (JIT disabled or
> unsupported architecture); suggests gating on is_jit_enabled().
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/jit_insns.c b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
>> --- a/tools/testing/selftests/bpf/prog_tests/jit_insns.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
> 
> [ ... ]
> 
>> @@ -2881,6 +2881,63 @@ static void test_convergence(void)
>>  	}
>>  }
>>
>> +/*
>> + * On x86-64 a backward jump sized from its own previous-pass address grew
>> + * here while others shrank, so two passes gave the same image length with
>> + * jumps still changing. The fillers are 7 and 2 bytes of native code, the
>> + * conditional jumps are never taken.
>> + */
>> +static void test_same_len_not_converged(void)
>> +{
> 
> [ ... ]
> 
>> +	int fd;
>> +
>> +	fd = load_prog(insns, ARRAY_SIZE(insns), "same len not converged");
>> +	if (fd < 0)
>> +		return;
>> +	ASSERT_GT(jited_len(fd), 0, "same len not converged jited");
> 
> This isn't a bug, but should this assertion be skipped when no JIT is
> available?
> 

We should probably skip this entire test file if JIT is off. Out of scope
of this change though.

> jited_len() returns 0 when the program was not JITed, and test_jit_insns()
> itself is not gated on is_jit_enabled(); only serial_test_jit_insns_blinded()
> is, and it calls test__skip() when there is no JIT.
> 
> On a kernel without CONFIG_BPF_JIT_ALWAYS_ON and with
> net.core.bpf_jit_enable=0, or on an architecture without an eBPF JIT,
> __bpf_prog_select_runtime() falls back to the interpreter.  The load
> succeeds, jited_prog_len is 0, the program still runs correctly, and this
> subtest fails on ASSERT_GT(jited_len(fd), 0, ...).
> 
> Other selftests treat a missing JIT as a condition to skip or ignore, for
> example bpf_obj_id.c:
> 
> 	env.jit_enabled && !prog_infos[i].jited_prog_len
> 
> and btf_rust.c, which calls test__skip() when !info.jited_prog_len.
> 
> Would something like this keep the check for JIT-enabled setups, where it
> catches a silent fallback to the interpreter, without failing when no JIT is
> configured?
> 
> 	if (is_jit_enabled())
> 		ASSERT_GT(jited_len(fd), 0, "same len not converged jited");
> 
>> +	prog_run(fd, 1, 2, 11, "same len not converged");
>> +	close(fd);
>> +}
>> +
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39777661721

