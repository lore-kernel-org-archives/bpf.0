Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A8D2253B0
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774895021; cv=none; b=GRTgdT3XrE9cAP98E+d1w6IA0Yl1+kr4+LnHFO3I7Gc+kmlv4eaLSMpxcwTL5wuSetfDjn+3j++kDVDPAVzO5HwjOtdv7V1vq3OcAW+bPn33dTcXx8dnQF/fdmJuKMSLWou+qRgu84l+L7f5lk20HyfDkT3V/e8PAUsABDc5u40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774895021; c=relaxed/simple;
	bh=NF9rRAKZzpSK64dSGd/aPJoDtJz9TsnSxpG9OXYxyr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTHne24LXbaTfiE9LZ+fyiaq6EVcavoGjxcqnliAssjkMu0h18aLIl2OB2tm3iLJiBw4bXTLPDUVgYEBrkmK3zJUFZGVKhgVhW6ZvaaSJsCfTTqk9gnRO/geYSU0Bcpj/FkZDhddl6dFTX3U2LchsQEdKNlI9Cd0uO4okaLkEYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tb28oQC1; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tb28oQC1"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5091ed02c54so57931cf.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 11:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774895019; x=1775499819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ijPPvOqIozHHCGCm1P4OC6DU69feRYcfC1IX42DFl4c=;
        b=tb28oQC1Ak1RCQbcaZIigG/qWJjEWX5hg4CQIHlb+kNbR3+tomPGB+RuQ2oJjr8jRr
         9tL/jcwZscEekOhQDmEJRu9JG4hHSyCpOUlmqlbc1YnKm2CarqY5ZAi0SYdZSSbUzZ2E
         n+ORJjBE3Y3Me8oXu4CN+2kBF4c5x9YPORkfntbVXuhVhasgesOsXIyAshljwUlTuF8E
         zKrmF4tME4KDt7boMc0zF0J3ARenEeCk3B1sgp0FTymn9kfs+mE8HzyceDniQ59pnORo
         lULuetCj6YIKz+DNbBnuUdbLSdMU28pEpGDs7TJBCUdT5hh892meE6uH3HTKTlMqbQTo
         qltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774895019; x=1775499819;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijPPvOqIozHHCGCm1P4OC6DU69feRYcfC1IX42DFl4c=;
        b=iIu5AZOWcME5tm3dDcVxYlKa4t1JIbtbC3ysUjIrWOpWDSb1UE1G3wcfCn23htJgn6
         fEnT9tnbb8TgAfEmqMiu+Jnf56iKCtWfFqR9IBteqYHu/uhzwSTt6QfqGUPd1CgDHWEJ
         eDelqGb9C9byZJemNwCEfA/JgW/q2GUt6jleXT/Gkqj0UaAJYu/SoPwEqqRnYYeARx9w
         jcmttWGcask8CXVCye7851EJM9gFayFEd1Wn4aIYBIKtZqO8Bb8atYrLzWFKvwMBvrIy
         TCmNenMwgb7bIiRcFpIHHcolDl1DaZ7XWtFAi/aEPwlNus4ndVjvORdi4lktbepM5NAC
         124g==
X-Forwarded-Encrypted: i=1; AJvYcCXIWJBHTwIFTzkeJD/fxLR3QZG4KuLTn4cPFhziJjxyzDU11ErzECmK5hlqKAm+ARk8aFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTqpyasvST3muRmB58otA8KXtx/qteedl5e9KD8dx+DhtTpaFg
	ZkMDtapF/4NN5ZYIHoeON1EtUL3X3nh+G+dRzOs/mbLTLUZ2kqO6cJFaZEleKpcKf8ogkELqhhz
	Dnh8RXSqc
X-Gm-Gg: ATEYQzy6BTaG3Yur5VFsiBsc1RrIlEEYHu9ae/ZaA6EkYjuQTVP0zSH4kkbD/iY0LcW
	WvRL7PePt2+OEgFc4h4mzxPw2GtUOQ8OO2/JGaI+MQsK+tkinEMlSPqk8cadfYtrrkWqi/x1Hyc
	p+384yZADk+A4C6VCl7DGDobndgYv8YQfGLzwaRBiTjC+pgBrZ2ptvf7Ywqpu7tWwUSam+TfEbJ
	EYX9Hu6GdRWgFPnPF3OOuQWrNqnI7ksTqTjUGd5iK/LzeNKnfZeShtnMbL0nTWlCKiCjKR1ZwKr
	4y7knIjUJsd2Ku5zrWaVJGafxQZqmLsQdEX+ODOxeI8916IzVbQX+6pr9DVgSYuT4VP+QPwYXZZ
	fyBEHVpqfsp0jrgG1dc1GBEbpfc2BPoVuklH9z/zz78sU+L9iBTxFl6mnS+RMQsym+ai8/+G0sc
	x6PkSOVfaZ7NsEf/OCCw1d5w==
X-Received: by 2002:a05:622a:410b:b0:509:25c5:42b4 with SMTP id d75a77b69052e-50d2d7057bfmr1082091cf.13.1774895018813;
        Mon, 30 Mar 2026 11:23:38 -0700 (PDT)
Received: from [192.168.1.27] ([130.44.176.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89f3ba99abbsm63723196d6.28.2026.03.30.11.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 11:23:38 -0700 (PDT)
Message-ID: <bdb289c5-c52c-4124-961f-db42553a2893@google.com>
Date: Mon, 30 Mar 2026 14:23:36 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] bpf: calls to bpf_loop() should have an SCC and
 accumulate backedges
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Levi Zim <i@kxxt.dev>, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev,
 Matt Bobrowski <mattbobrowski@google.com>, Josh Don <joshdon@google.com>
References: <20251229-scc-for-callbacks-v1-0-ceadfe679900@gmail.com>
 <ed857a23-bd73-4915-b080-558b5934bc8f@kxxt.dev>
 <79ac0188db82c675e62c36c8ab036b45cef3f3f7.camel@gmail.com>
 <9a418287-f8e3-4064-8364-ff85793de74e@google.com>
 <b943320a099bc171a10e533935eef8dd06b30e2c.camel@gmail.com>
From: Barret Rhoden <brho@google.com>
Content-Language: en-US
In-Reply-To: <b943320a099bc171a10e533935eef8dd06b30e2c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/26 4:10 PM, Eduard Zingerman wrote:?
> If not, here are a few generic tips:
> - If there is bpf_for or bpf_loop based loop and you hit 1M
>    instructions limit, this means that internal loop state does not
>    converge to some previously visited state from verifier point of
>    view.
> - Most likely there is a pattern like this:
> 
>      v = 0;                            v = 0;
>      bpf_for(i, ...) {                 bpf_for(i, ...) {
>        ...                               ...
>        v += 1;                - or -     v += 1;
>      }                                   use v for memory access
>      use v for memory access.          }
> 
>    Or its equivalent in bpf_loop terms.
>    'v' might also be a pointer incremented inside a loop.
>    Unfortunately, we don't have a simple way to identify which variable
>    is a culprit. We do have a way to identify which loop fails to converge:
>    the 'veristat' tool executed with --top-src-lines=N option will
>    print out C lines corresponding to instructions that verifier
>    visited most-often before giving up.
> - There are several possible remedies for the pattern above:
>    - hide exact value of 'v' from verifier by initializing
>      it using a global, see tools/testing/selftests/bpf/progs/arena_htab.c
>      variable 'zero'.
>    - change the logic to rely on 'i' instead of 'v',
>      for 'i' verifier does not know exact value, but knows its range.
> - Another generic advice is to split program into global subprograms.
>    Global subprograms called from the loop body won't inflate the callers
>    verification budget.

great tips, thanks!  i opted for the global function one; it's a common 
sledgehammer in my "fight the verifier" toolkit.  =)

the loop function was calling a very large function, so that was 
probably the right tool for the job.  next time i'll take a look at 
veristat.

thanks,

barret


