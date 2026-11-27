Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795777022;
	b=FIyLrkQMi875qO/k8OUX89GLdEP4Jj2yQdx8tesjavbS3dLRO0w1uc7F1wNj4vydQHHX
	 03P4CjovwrtTdqf76pJLITE/f2qRVXVXtChfn/yz4xfbxrw9kauvd553tV5zJqBEkP8st
	 flSXkuoVuuC1zpa8uZO/uuab0wlQ3+4Y/4jAhfhVCh3H9B7vQY3uKUfPhTLS8qkhUgARK
	 H1TxnHhuyrR91S9U6pz806He5VrOR8QdaEm8p9SnFj16C+x6XHBYpbWPHy6/HdLd6Q9YM
	 INxF9SelwMyAVhxI8sICRTL6XuN9bkX4WQvwE0fl62rtN2FbcRm/cyRazRhYWKLqcEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795777022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=SrR+taCSYKOy0V34lVNOUOBJDJI1/m+bArOv03O8lxI=;
	b=oq0ADyJLQTJDDt1/sfBeOWgQNhQ/fmCsiA4Q4RDQaY7kUNG81hkrJeXFAF6QrsXY0Kwl
	 FK1KAYZaxcLRYBuhwKUU/wW/TsH9l3a0zCfJeSdcz78FnMCF5rO3xrdy3xfTT5+ObMepu
	 g8EiIxwp5RMiwybV+aX2TDa9ZEHMOEdmjNgHz6nIAXeCpMvMxCe5shVR7TuvNGYwWbziG
	 WCA3qlOVfBA3o3ibw71aznqlmjcAFnFr4urrlc+39cTruaRcRha57Nb307AZuYqPjD0QU
	 v1vBIwwBEboL/xdw2WLWYhuYReF7fbDripXTwMpSbmle+5Hi0IdNWCxto7FzX5UzgFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uKoUtz9e;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D36606A31F
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 10:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99D36606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uKoUtz9e
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e09aa5264so4657302f8f.2
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 02:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795777020; x=1796381820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SrR+taCSYKOy0V34lVNOUOBJDJI1/m+bArOv03O8lxI=;
        b=uKoUtz9exeCtT/J0MSQPWgKYzoqnghWgPHR6RZKb0OlBDMgOpv9wU7GcWOajaySaQB
         3D+NEuj5+2gaKkr5zM8FsiR8swBbOluzol4gjepNpc7N2SehB3AxrNCf3g72md+7nw7z
         SJdx159tA5ouvrWReL5wvUu0ihLsMnJsRiE3+PC7vk1Ln9iW/87tPDQCAc9SBdGoK8y6
         tf6SnKemDvo2VJsXLGmZEkXEeD7st33nOYFUSMF4+/sGrOY1Ntl8tLH71ikp4pmJF7Vl
         hVW8ehIz/zqQ8dlJHeSNB2JmMi0v76jYphOAqwMoP3Y5FX9ttIEnaIqsKrtU5oCX+oTo
         j2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795777020; x=1796381820;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SrR+taCSYKOy0V34lVNOUOBJDJI1/m+bArOv03O8lxI=;
        b=YuEkmn+hVYYbtU1lRXyHQyrFQyrOgorXQgneAz35SzMHBf9H8dnxQCZBkPHwzYiHT1
         wlhEVPQxjYoVddm8n4HDwtBGyy8+dRXlpTkxE4KxPNqT3HYuAH1u43fX3PRhKUcjBeRK
         5LiPLjuXWOLJxbPIqRC8GDMX9d22OrGPyScr1VNs6l2qUhAIk0q6nbpq0hAPcnKbAoWi
         kxglo3H8shchmmEDPlsKymAQ8IS5O4nRTPDl7o2Pr91aRUtbkugrnxOnFHuSRXfj2H/o
         fCIP2cBZKeDVlTy+yXaoBMuwzWU2wrfjF4syMpv0hbwbloaj6UfAQuTDxOJ28CXWa1Yv
         j7Pg==
X-Forwarded-Encrypted: i=1; AL+hErFxrHh5Dz8nBSUgdSjO8bVDp/Cz3ERMxg4QfZBAw7k4ov0bzm5fXBDEG376j+bADOtXZbY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dVpZZpN0FoUkKTcTxMWP2kBrjxAXZwp7QurTj/xFTDYnII3CT
	SjkNZziAfFj0VIk193f8bU06zKiRqu0lZDv3Rua9/TYcsN4Kp4sIwXNCnuEbtJxas9w=
X-Gm-Gg: AZFdTZellGdIdIY15XQT7RMkYhkGI97I3B03IqC/e+OsBO1SgbtdqMuIYEY4UKxE9Nh
	1tpdoLCCVQ6ljTlYizvUhK4eLIAQqIJwDAJInU2X+W0o7Cmx9KP2btyu9SNRYAZR+TKIx8LsBhJ
	KIC1/TaC5dsruBAwVJSdN8NLs+IWr0bmfAmvNI+W8p1TOoUQVfTOhl+igEr5KfXXgp4EVYO5Vnz
	Yy9qObOIIj61mky4TXtxsCqfwBG1uL31Y7YTgzRnnGWqYq/JRZQWrbXq2amUHaDUvNEaw5Y1jrY
	ZMqm+hK3yoqgMgtyvTDzTVMB3BupNpWXU14kRKuBBwdePuEun1+vkQj8V5JJR+QCDihGOjt8EFp
	FZQGSoQKa9ScoO1Q/69lJ4soH91SUEenDxd4SOymqsnNuZaIY2NX5hiF0tk/EiVAewMQr5VinB8
	DNgIu23FFe7127BlEWB7nl+YIKTR9rdV7KTfwwvrBUMW6q33ZEcM0lCkXQPb3AwmLGXp2F3FGMB
	R31EvY8QULQPrMibrbaPcFdl7MRT+nyp5fAnGss/d7Zlvpt58qIQZXNCWRtLTzn6ubu2T7724u3
	Ptp2zAdbOg1OTmaxSn0tD29ySeq8qcl6hA==
X-Received: by 2002:a05:6000:2309:b0:4a7:45a2:ec26 with SMTP id ffacd0b85a97d-4abb0f3bc89mr49275277f8f.16.1795777020031;
        Fri, 27 Nov 2026 02:57:00 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab65cb4341sm46346149f8f.4.2026.11.27.02.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 02:56:59 -0800 (PST)
Message-ID: <167b3016-4881-4ef4-9c1c-100ba96b50bd@linaro.org>
Date: Fri, 27 Nov 2026 10:56:58 +0000
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
Subject: Re: [PATCH v6 2/3] perf/arm64: Add BRBE support for
 bpf_get_branch_snapshot()
To: Leo Yan <leo.yan@arm.com>, Puranjay Mohan <puranjay@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Rob Herring <robh@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Shuah Khan <shuah@kernel.org>,
 Breno Leitao <leitao@debian.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Stephane Eranian <eranian@google.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Usama Arif
 <usama.arif@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260810164622.1829843-1-puranjay@kernel.org>
 <20260810164622.1829843-3-puranjay@kernel.org>
 <20261126171904.GA809232@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261126171904.GA809232@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/11/2026 17:19, Leo Yan wrote:
> On Mon, Aug 10, 2026 at 09:46:19AM -0700, Puranjay Mohan wrote:
> 
> [...]
> 
>> +int brbe_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
>> +{
>> +	u64 brbidr, brbfcr, brbcr, pmcr;
>> +	int nr_hw, nr_copied = 0;
>> +	bool paused_here = false;
>> +	unsigned long flags;
>> +
>> +	/* Called with migration disabled, so this is the CPU read below. */
>> +	if (!valid_brbe_version())
>> +		return 0;
>> +
>> +	flags = raw_local_daif_save();
>> +
>> +	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
>> +	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
>> +
>> +	/*
>> +	 * PAUSED is only ever set behind our back, so finding it set is final.
>> +	 * likely() keeps this inline; a taken branch costs a record.
>> +	 */
>> +	if (likely(brbcr && !(brbfcr & BRBFCR_EL1_PAUSED))) {
>> +		/*
>> +		 * Stop the counters so a freeze cannot set PAUSED behind the
>> +		 * value read below; the D19.3 conditions need a PMOVSCLR_EL0
>> +		 * bit, which a stopped counter cannot set.
>> +		 */
>> +		pmcr = read_pmcr();
>> +		write_pmcr(pmcr & ~ARMV8_PMU_PMCR_E);
>> +		isb();
>> +
>> +		brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
>> +		paused_here = !(brbfcr & BRBFCR_EL1_PAUSED);
>> +
>> +		write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
>> +		isb();
>> +	}
> 
> AI pointed out a edge case:
> 
>   1) The PMU is enabled (PMCR_EL0.E=1). The first BRBFCR_EL1 read
>      observes PAUSED=0.
>   2) A counter overflows and hardware freezes BRBE before the helper
>      stops the counters. This can happen while interrupt is masked.
>   3) The helper saves PMCR_EL0 and clears PMCR_E. Its second BRBFCR_EL1
>      read observes PAUSED=1, so paused_here becomes false.
>   4) The only write restoring the saved PMCR_EL0 is inside
>      "if (paused_here)". The helper therefore returns with PMCR_EL0.E=0.
> 
> This can happen with a normal PMU IRQ because hardware can freeze BRBE
> while local IRQs are masked.
> 

Nice catch. This can be fixed by adding 'pmcr_saved' in addition to 
'paused_here'. So 'pmcr_saved' would always always be set if the 
likely-not-paused branch is true, and then 'paused_here' is still set 
from the second read of BRBFCR.

Then on exit they are both treated separately. 'paused_here' invalidates 
and unpauses again but 'pmcr_saved' can control restoring PMCR.

>> +	trace_hardirqs_off();
> 
> The irqsoff tracer misses the time between raw_local_daif_save() and
> this call. Other callers could introduce similar gaps by using the raw
> helper.
> 
> I'll reply separately on the pNMI / NMI cases with an approach that
> may avoid adding the raw helpers.

And that other approach also avoids having to disable the PMU counters 
so avoids the edge case above.

> 
> Thanks,
> Leo

