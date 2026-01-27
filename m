Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE89F35D603
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769540736; cv=none; b=FYv9h6Hr2yHJXYsvbvC7YNUbNEdab6W1utTCQfqTowmL3V2Fqx6W75mezw3APDjBccYw1MkISSep4MOcAUbuabAwOfnBV/m1jwt21T+Clq4KFOXIMM1k9nToBjBK2QH5A10ofv3fbvS6eTrXjmuIarXY4vu6dQ3CiUMoxBJ7UwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769540736; c=relaxed/simple;
	bh=dyoiYlwiKh6Oq+csguON2OA08paYrtbwwvWsc5VCNqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDA5gr9iKldZ5uUzLrMW6RCiamEc016onEQtb1qhQjJFccR4T9buSDS1HrQ9mmnNmwuRUdezOJXZWsWy2fEvjeHpp5cdqa4xjwM/EbNkPvGGIlgNHIHQ1Jr2RADP8N9MargVD29kwJeGAK/cFfTS2cp+qL9aAtndTI4dXrbbIzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjogrxwB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjogrxwB"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-435903c4040so3733477f8f.3
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 11:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769540732; x=1770145532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QrUU/ICJyLkGqH8GYzQ9Okzx4VLNgaUCILpUTLrLqtA=;
        b=XjogrxwBIP9oqV1DN1143yuwwdi8FayxykJtxZiYkeTd0CIgRrbmDg7nv2qHDacghJ
         xty10HM27d3WcS0wORfvtk7m06gqxM8QGw/QldJUFj2L/Far3wSuS1/69wc0KDw4XkYf
         pF73urFwEuMlkI88ME8CF/dLXPMDNtfntGylnlPJDWJ5JNTMS4kkXgkE3HPChGFTGyNx
         R/u2ssnFxhHRC4YJcrtpqmhF6grdWCexavk5DYG63mRfcIILV2L2nlx6FoDoKh3udiJz
         Hh4TROCRFA0/0BlS740mld6VxoHBDoxBtmVdq3C7Xoo7TsEkLbz6/IEGCeJ6hn95DVwk
         9S6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769540732; x=1770145532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QrUU/ICJyLkGqH8GYzQ9Okzx4VLNgaUCILpUTLrLqtA=;
        b=LR7eS062zXTX3IS/LdQ3stv2kiKg6ciERCrNmRQic2s1C2DtO/s3pRyzXjtUn+VymC
         8paakwysDUVstewE1a94YmUE0y+WvrZi4G9ed9XsscOmsTy1ANXE3Supsdfn8OD18bzY
         PYgeCv0+264Dhw6oywu5ao2y11+M4MY/TVdEw2QH7Z/U7eRRuULYFKrn0eNQ+QKoe0bY
         GCf7QVr/fAQjtlIwe5J5ivK8iK+jnnqcAXfzJ9sfpnV9Y7iLfwPcF8+RLkYVCx2s5Dm6
         3JbBQEflWemVr1SiPFcNAGrnrMOdv24m4EcQEAenjnsMEjpkINnFxuDBUVP96zGDCe8w
         AzhQ==
X-Gm-Message-State: AOJu0Yybg+OJGzU42eh91zjb3ds/xLHxvCRBZ4avYMODAwOJfWHSXLxK
	0uh2gtkuJ9OWRMwkJqH9ex6lMpMhfFR/G0J8rI/mz3G90KqrJ6qKgxld
X-Gm-Gg: AZuq6aK35mhQJvNNmxAY5P3WXyvJoU+mf9/lvhGYjjhHmAvfjZKm25n1RZMEonW8l4N
	ni2wbhR0cHSg4Hd6Q8jkvRW0WBUdTTKcEcI1rMt5ylMpCqHqJdyAtvyQ0vWA3uszqLuXP4WorLg
	ydtm5iEjPwa7lnTZuiHL2sEQJUcCjUN+tI6QyouwmYBt48rTKwBehF28cni0xLn+6K01KM+titL
	gK8U8SxijBDemMnBbrHen8hUBnkPeopcjGg81dbZescG2NP6ndjOY5eosrmzgNxIaLszBRVwmgu
	kPTNjkG74qLnzYr306FlmHcTYppMUM4J5f5G3AO15JLGR2ai4xZel+oYpVbUMdxTERY26otcyzP
	N3i6ySb0jeyN5M8RVX7rRDsU87Grf5UPimsM7WL2x0fUbR1LWufkNu5ooiVbmwozsyEg0xmjnw+
	YM0C4lw1kIIHLbRA6o4FfEiRWuSm61XY++EI3NmpAHYJv9Ck8=
X-Received: by 2002:a05:6000:2689:b0:431:488:b9bc with SMTP id ffacd0b85a97d-435dd029a22mr4241591f8f.10.1769540731698;
        Tue, 27 Jan 2026 11:05:31 -0800 (PST)
Received: from [172.16.1.11] (i68975BB5.versanet.de. [104.151.91.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ed952sm909060f8f.10.2026.01.27.11.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 11:05:31 -0800 (PST)
Message-ID: <58e46dfe-b17a-4683-a7cf-a0b20236ad62@gmail.com>
Date: Tue, 27 Jan 2026 19:05:24 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Add hexdump fallback when xxd
 is unavailable
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 kpsingh@kernel.org, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260127163408.1991583-1-mykyta.yatsenko5@gmail.com>
 <CAEf4BzY48PKYcUU9sQ+g9CXd69Xuf1Js6Ow0TtTSt8m9SC353Q@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzY48PKYcUU9sQ+g9CXd69Xuf1Js6Ow0TtTSt8m9SC353Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/27/26 18:53, Andrii Nakryiko wrote:
> On Tue, Jan 27, 2026 at 8:34 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> The verification signature header generation requires converting a
>> binary certificate to a C array. Previously this only worked with
>> xxd (part of vim-common package). Add a fallback using
>> hexdump (available on most Unix systems) to generate equivalent C array
>> output when xxd is not found. The XXD variable is auto-detected at
>> Makefile parse time.
> why not always use hexdump then?
I thought about that, not sure, it looks like xxd creates dump in a 
certain format,
I did my best to replicate it with the hexdump, but not sure how 
reliable this is.
I think most of the users going to have xxd anyways, so I'm trying to 
make this less
risky.
>
>> Fixes: b720903e2b14d ("selftests/bpf: Enable signature verification for some lskel tests")
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   tools/testing/selftests/bpf/Makefile | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index 9488d076c740..820816257590 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -31,6 +31,7 @@ SAN_CFLAGS    ?=
>>   SAN_LDFLAGS    ?= $(SAN_CFLAGS)
>>   RELEASE                ?=
>>   OPT_FLAGS      ?= $(if $(RELEASE),-O2,-O0)
>> +XXD            ?= $(shell command -v xxd;)
>>
>>   LIBELF_CFLAGS  := $(shell $(PKG_CONFIG) libelf --cflags 2>/dev/null)
>>   LIBELF_LIBS    := $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>> @@ -722,9 +723,19 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
>>          $(Q)mkdir -p $(BUILD_DIR)
>>          $(Q)$(VERIFY_SIG_SETUP) genkey $(BUILD_DIR)
>>
>> +ifneq ($(XXD),)
>>   $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
>>          $(Q)ln -fs $< test_progs_verification_cert && \
>> -       xxd -i test_progs_verification_cert > $@
>> +       $(XXD) -i test_progs_verification_cert > $@
>> +else
>> +# Fallback when xxd is not available: use hexdump to generate C array
>> +$(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
>> +       $(Q)ln -fs $< test_progs_verification_cert && \
>> +       (echo "unsigned char test_progs_verification_cert[] = {"; \
>> +        hexdump -v -e '12/1 "  0x%02x," "\n"' test_progs_verification_cert | sed 's/0x  ,//g; $$s/,$$//'; \
>> +        echo "};"; \
>> +        echo "unsigned int test_progs_verification_cert_len = $$(wc -c < test_progs_verification_cert);") > $@
>> +endif
>>
>>   # Define test_progs test runner.
>>   TRUNNER_TESTS_DIR := prog_tests
>> --
>> 2.52.0
>>

