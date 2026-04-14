Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DDF318B9D
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 09:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160497; cv=none; b=lEzEocII0RAVyyG2nndfFbmdzAu8kw4J4MMaUSsPAc6nY5yI0WBe56Mgl+MoJtipK0ml7naw7pRNnPoUd9udhVYeoSsjst6eIiSAl/KANwddGGjQN0AXv7mzdAjqRYLmk5m439ilVNR1fQ4Mdu4HURpyHbkXEp3ySDbRPGq8AiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160497; c=relaxed/simple;
	bh=g3ZTG1KSnGaQNVJemQbW4oz6uMYLIEPkkvP3ibALqis=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dVoEIda8G+Mvx6IFoJ1oPliFZsYBHci2M5HwBG42I4dWz5SIGFqXw1B743nVuInRd01Z11/2z0t912Abd/HbRlOFICoqnS2fRtraX4G0Ze+GXEaZd3RzRg2Qu0DiUduHe1mRgaCOSyCIwWxWYdru0hp24w5fp5mMhWBfKDRBs8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1ZZ23K+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1ZZ23K+"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48896199cbaso57306745e9.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 02:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776160494; x=1776765294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=175FuFGsJP7TC3gXUJaotZZkFi03qkrY8SnMuKXl66k=;
        b=e1ZZ23K+g+2q9YQKBE9aZDyefMV1HQ4GHa2SMmd+yAwAIIn6zZFt0xh0ayiGscO4Xp
         JYoHgWOQOXZRtx6T8tuse2DDTHrBnRdpQ4qGHZsqRw0YCJ2LlEwIP8tUto+E9ee9kxWD
         62SPT2s4NIvHdADyj50nEL9yEd6BZ8hl69slWTu6hfenkvFHaHc6k17Ntq4FMkSJnmA6
         ZIhz6hmsSwToiUrU/gbMh8dhsh0+w+BdhTMxcS04OH3bQV1gi4F2FA06ZBc7V1cUm0f6
         Otr/AubH/usk9nASvzaxB/PLy+fcki/xc7Otr7VccYVOwvBftWzJh0f1Qk/EdOKnYJvi
         nLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776160494; x=1776765294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=175FuFGsJP7TC3gXUJaotZZkFi03qkrY8SnMuKXl66k=;
        b=SsbVtDp64r8YIVdoD7CA+T6uC1M00dVGG9UBi5idSl8CRCVIfdn8NCwJ69zxdJC9j0
         9BnJgOslwUISJWPJ3T7hKZGyX2lN69hvFnoRY5iXbAWmAQ9wmEsrQfks+Lyij3QU85SZ
         qgRQEZaJ3aPWdY9wnqFdG3NdjE+J3hf46x2t1DuWQ5yu3CBf8iY+EnNFtjl1kzvA+/Oz
         Jj/ThSRtInJ6QVtx9w1J1ChP0h7S8elV+smD1MKS1GMZtm1ctxYdelB87qzVq8El3k9o
         3eH7S+lALDAa6tM5Ps1cepBgfNTR6QOf1JZyVvUILxJg/CcXyaMn2hFk5KuQ/R7+qoyN
         BajA==
X-Forwarded-Encrypted: i=1; AFNElJ8iP5oMCjknH8IJQ8ASVzv5rjfeMu1Zvgr0gHUHQDU7gBTRqeSV4d7twSub15mW0vEL5Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL6ctLUSMBnToeRXLk1xvuQUFKny2U9JPhqATMOv9FeSPQjOzL
	2E3LERW7klozTSZ84IRRAT3/w4ClhpMlKVBVx0I4SEnualIhB3xPcuKp1XIaBlUO
X-Gm-Gg: AeBDietTP+km039fQP/ojqBqhBSWUHvMniEGZSj9uRYtlEc62UgPFk3o6MBYidD9a/J
	+estxbqNPrKnaQz2p+RtUsQP8NczkMC6a72HvXC9RumgfLyPDzJxwknxiQw43MQ8TJ+jOXqMPRi
	TRFr0DbcWJn+8T4oBXXx7Wv4ur0j9MEnqbSH+zYeK0/CgEwwnJRGwMYbtrrBtx0wUxEe2SiRONU
	pv8D/6ZhNSPokQAbsvYkEUQUS00vxDN7XfXGDMBrQeqXArWoMGUvpzeu1fwfdmLqg3aL6UGi8Eg
	JkeaBZf/zkQevEhp/dj2791P5NbRULXU7zILMdIlHucbKYiBGjlpO44MZSNPcMkPE4UG6CV0iWx
	38u6bzujAcScKd39GftNHpyFGsrdtA5C/mmcQOaZmCKBFbKSUk3aaeZpjOeTzcFUDDZ9TrW5Z7C
	pm4KcE5I5V+0nTdSi0vC47xC8nf74gfStLePHmvCflYQegoUJwoX4poNsjkJutqhO7KLHBXPjFP
	U6V9trn
X-Received: by 2002:a05:600c:5249:b0:485:7f02:afd5 with SMTP id 5b1f17b1804b1-488d680079bmr222771405e9.13.1776160493979;
        Tue, 14 Apr 2026 02:54:53 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:2caa:994a:1164:dca? ([2a02:8109:a307:d900:2caa:994a:1164:dca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede15694sm59959145e9.3.2026.04.14.02.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:54:53 -0700 (PDT)
Message-ID: <7ff9b6b6-7f4f-413d-8495-6500c666d6e2@gmail.com>
Date: Tue, 14 Apr 2026 10:54:52 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next 1/4] selftests/bpf: Only define
 ENABLE_ATOMICS_TESTS for cpuv4 runner
To: Tiezhu Yang <yangtiezhu@loongson.cn>, bpf@vger.kernel.org
References: <20260414071507.29804-1-yangtiezhu@loongson.cn>
 <20260414071507.29804-2-yangtiezhu@loongson.cn>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260414071507.29804-2-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/14/26 8:15 AM, Tiezhu Yang wrote:
> Currently, ENABLE_ATOMICS_TESTS is added to the global TRUNNER_BPF_CFLAGS.
> This causes build failures when the default test_progs runner (typically
> uses -mcpu=v3) attempts to compile atomic operations on 8-bit and 16-bit
> variables. The BPF backend for Clang only supports BPF_B and BPF_H atomic
> instructions when -mcpu=v4 is explicitly specified.
> 
> Refactor the Makefile to only define ENABLE_ATOMICS_TESTS for the cpuv4
> test runner. This ensures that:
> 
> 1. The default build (make) passes by skipping 8/16-bit atomic code paths
>     when using older instruction sets.
> 2. Comprehensive atomic testing is enabled for the cpuv4 runner where the
>     proper compiler flags are guaranteed.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   tools/testing/selftests/bpf/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index f75c4f52c028..c38a149932e3 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -775,7 +775,7 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
>   		       $(wildcard progs/btf_dump_test_case_*.c)		\
>   		       $(wildcard progs/*.bpf.o)
>   TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
> -TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_TESTS
> +TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)

Does this change disables 32/64-bit atomic tests for the 
./test_progs?This does not look right. If the goal is to make sure that 
8/16 bit atomic tests run only on cpuv4 test runner, we should probably 
introduce another guard or runtime check for that specifically.

>   $(eval $(call DEFINE_TEST_RUNNER,test_progs))
>   
>   # Define test_progs-no_alu32 test runner.

