Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9BB3CF66C
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161262; cv=none; b=NQ/zx5ZFJABMKH37w5m51Tnjdx3MyblE1s+/4AjsjFKdTruO5sDRo2RlucDWcN/5fEPXMkxD/GwcUS1P8ROmb2PueN5Pp4dOAPtIP6IfAt9I5xJHH+ezpWK4MCcmu2NnMG4WCBsbdOSXeBYZTH/pEtFIsikUUF4WY/7LUWG8tyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161262; c=relaxed/simple;
	bh=vqj7Rdzl7XHBqHQqV1Fi+9eLrK9m42h55PxBtNPD4RQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=BIgNJ7My6dnDOg3z0CuYDOfz9COelqD5yfx7v05Yxd25/WAWaSn4X57ctzJMtA5FdnBSoVkh8DyTRCB3fQN3Ju2mgNh+qKVl/NoDVbdias5+3ewZdplYAyozRjxwIYP6zMAHHX3OqCQ5DB9Ovb9gk90ZeKeOjLDccqydO9BDM4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZ3cHDYa; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZ3cHDYa"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4887fd35e60so38050265e9.2
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 03:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776161259; x=1776766059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycRbzjZ6LMxBlIqEjKpGaWiS4W3Vdag2Ny70HAE1xVQ=;
        b=NZ3cHDYaTDiMbpxvbaFz2KqMeiyfZSLtlOK/LsrU7CmJ+3JetKd4nvC7sfj7gfNytV
         DzxlL7FH3yUK2qACVRqK/OdsCmYIbSX1mGPQcvi2H9er9sMj9AdqxK++ou4GuUDAUwVc
         +Ww393LNoeXxsiiv3zgZ5IoeZ5FCD2YNeC+iQwIsrtPYtFDOC2i7lSBFlqPA7fef9IRs
         V6Yd0lGF8SMLM9ooFreJ1rndaC/7SJ8Iyu44icJsnC6yvrry62CxOfeaNnolOHmhmrb+
         xn0jPpxnHpzbInH00Q8FApjEtXHRYcFLM9sa/o6L+H38r26ZaL+elNCC1vnXqDnfzYEo
         qvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776161259; x=1776766059;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycRbzjZ6LMxBlIqEjKpGaWiS4W3Vdag2Ny70HAE1xVQ=;
        b=Crgwb3lWxVt4zlLdbV3UIxGLlhvCLnV7r8xyXgWxva3DYaYkkYz6G86LKaptKPpLht
         1iBsVkUU0XX1kT5z1bsWoKV9LPuHW1WrIlWFIVtirMySfI+gvy0eUq8UT/5+6CMHnHnv
         IudVviADqDFVSOl+tj4bJ/ki9C2DvKrg1od+1tUznLyw1CBCircoZsmaMajuB4vvfSSh
         4JQOrvzLuX8R3ocnahpXJxyS05/JNY3zPU3LiyKq96Lzsb3s5xGmFf+Je4oXE1sl6Umo
         +Kqw1prkWsykfj1pUAg7X2mO6/cLBhcQxdjv8RnutjV+Vw+RummAmLoeWiXPAWzuqLp8
         rBXg==
X-Forwarded-Encrypted: i=1; AFNElJ/hAx0406BqPns8Fq8/YdDSHvuCFbFrlzJH0QuiJaQiL7ODM3GEd3pqNJ5fGCcp3VbC3Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0qeOgWvcmoFiSab5uaxlJ7t9MPKDGAIzJuZzJ3tQN+t1EOrLk
	+w6erY03CRbDCzZeWBS8NXltwkNKx7tZcdlbHI2cwNw2b1XBkx7R9D3GvAO+bayv
X-Gm-Gg: AeBDiev0SFmFk4FYImnonmPlHWiOjN50YbLFoYrag+XHWGXYVhB9zxLP/TARTDJJAho
	FB9hIsegIPDVhH4d+F6tYRM4TDZuoO595lHCnlTqCCQBP483DJBcc6Zk7Z5xEJTEsNclTnWA/2M
	h2A9eo3D+gzlEUGhMiQtJnyHJ8z1DqHioKTVA2XAuTNkiI8yLhTcJ6f07DI+G8leAFip4kKbQPl
	n8mHQdLdgvdT+ncziqfdRMAMqmgXkaS/lbomg9NVvmblTh+6bqeDyCtUSRnpjSpGEm+WWsAw0fb
	Sp3RU/SJY1DxoRZvaS/j8ublNcULtP4vvQCDcBJGZdGkcJyYkLz0uZ9Nhwlc0F9QTpsKJGYAbPq
	DiHRVnNTTpkNjU8NPe4pBmrlASbbJkjuzfuLjWNPFb+eKXqgV0bW5bQCY/yXOOccwV/4jyt3+5h
	XIq5p01JLm0PrPtaRzWsHoxGWzrkEEY3Pj/xveBLfmdvDopwdAYcIqTb+KqM3WdLUsw5vq43Y96
	9c2GSu2
X-Received: by 2002:a05:600c:630d:b0:488:79a3:f04c with SMTP id 5b1f17b1804b1-488d687cfd0mr225352645e9.27.1776161258803;
        Tue, 14 Apr 2026 03:07:38 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:2caa:994a:1164:dca? ([2a02:8109:a307:d900:2caa:994a:1164:dca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede15cfbsm43555275e9.1.2026.04.14.03.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 03:07:38 -0700 (PDT)
Message-ID: <35767bc3-07a7-49f8-8937-7cb56099dee5@gmail.com>
Date: Tue, 14 Apr 2026 11:07:37 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next 1/4] selftests/bpf: Only define
 ENABLE_ATOMICS_TESTS for cpuv4 runner
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, bpf@vger.kernel.org
References: <20260414071507.29804-1-yangtiezhu@loongson.cn>
 <20260414071507.29804-2-yangtiezhu@loongson.cn>
 <7ff9b6b6-7f4f-413d-8495-6500c666d6e2@gmail.com>
Content-Language: en-US
In-Reply-To: <7ff9b6b6-7f4f-413d-8495-6500c666d6e2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/14/26 10:54 AM, Mykyta Yatsenko wrote:
> 
> 
> On 4/14/26 8:15 AM, Tiezhu Yang wrote:
>> Currently, ENABLE_ATOMICS_TESTS is added to the global 
>> TRUNNER_BPF_CFLAGS.
>> This causes build failures when the default test_progs runner (typically
>> uses -mcpu=v3) attempts to compile atomic operations on 8-bit and 16-bit
>> variables. The BPF backend for Clang only supports BPF_B and BPF_H atomic
>> instructions when -mcpu=v4 is explicitly specified.
>>
>> Refactor the Makefile to only define ENABLE_ATOMICS_TESTS for the cpuv4
>> test runner. This ensures that:
>>
>> 1. The default build (make) passes by skipping 8/16-bit atomic code paths
>>     when using older instruction sets.
>> 2. Comprehensive atomic testing is enabled for the cpuv4 runner where the
>>     proper compiler flags are guaranteed.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   tools/testing/selftests/bpf/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/ 
>> selftests/bpf/Makefile
>> index f75c4f52c028..c38a149932e3 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -775,7 +775,7 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/ 
>> urandom_read                \
>>                  $(wildcard progs/btf_dump_test_case_*.c)        \
>>                  $(wildcard progs/*.bpf.o)
>>   TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
>> -TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) - 
>> DENABLE_ATOMICS_TESTS
>> +TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
> 
> Does this change disables 32/64-bit atomic tests for the ./test_progs? 
> This does not look right. If the goal is to make sure that 8/16 bit 
> atomic tests run only on cpuv4 test runner, we should probably introduce 
> another guard or runtime check for that specifically.
> 

I see runtime check won't work, because compiler would fail to generate 
code for 8/16 bit atomics where they are not supported.

>>   $(eval $(call DEFINE_TEST_RUNNER,test_progs))
>>   # Define test_progs-no_alu32 test runner.
> 

