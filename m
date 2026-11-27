Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776992;
	b=2Tn/PSYZLZDX9ar9ikgVeCj5WHd/iUod2bM3RbxvDEGw9zd76fnk0diB8/3y34BxvMnB
	 BkIA5w+NpALADqunhazGTsAAdTdDEnCstTcU9aIFfJui82as8qRzYTBJx4EGniKburgog
	 Yd0IGk14iAnTTDjmd39nwMa+WQH0OZQvbyBwSOIAJ2vESsG2MjbzNWN5+IW1P5FOHqsZF
	 FCj3jLHRbkD+u8kwLlrbNVFk8ZABNPxqYYUwwSFYOaINMXlCp5VHO4lZJiLkGpQWNxGCx
	 ZU1ezcaXynOplA7/J0UklQoQY5zv07zdvqsKXqZCVE8YLflqCyv89W/VKcr6Os5CusA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=1P9jh/3dNVPHo3/JRb6QOjFyR52ByPWaY+Xbs/2Psnw=;
	b=OrKi/s7C4P46cNlBauFi8MOSGFuZO97WX91EIGaLNyYFozC/a67EEQZETaiZ3S9kjh1F
	 RCK2ih40Icqj0f75fRq6X3ql1qeFYkdBUU/Va4y8lgATYxsJ2FTFribLE21yHwDRAdG6v
	 EGHy6lFoBL3W3VXgB6FetS+3O6mkdpkO0YAuPdSC9dRVc6QuobjTiXuKBgJCaqn5EG8CW
	 Rsokr3YL3CoMa5fEzc/f9QgCqJZU2/Z7Ox/GoMDyQDZGwQOU0eSV+UOMdXiThJYFUx1Iq
	 qZ9Fmig8tCxOUnFlFJG9CRU9/3Z4VDNWWxk7/UF3I3nlvFZTxAp+uyBr64YYSUmTQxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dyb5RJbM;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF94606A33B
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 10:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BF94606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dyb5RJbM
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso75835275e9.3
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 02:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795776990; x=1796381790; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1P9jh/3dNVPHo3/JRb6QOjFyR52ByPWaY+Xbs/2Psnw=;
        b=dyb5RJbMSTNIthJgsi/N2ySzW1R3mcY+ZvZe6M9AuUMbmlx2TUCqkrG2xu3erNO2t+
         Qoj9vIYm2Fdngl22sNhHrSlriisnh2LFEUQqXdYF6mSfhVxPdTknYvcBiynXMFaSR+wG
         WnCOHJTLxU8GWrIjotHjCKr0AWZuFkiFCDMF98GVoeoJyg2WPjK6644T4whLKPa3QPV0
         VFP1nA5/mud1GwPgrX7H1aMp2ftpoQlR1vr3Jj0gbxdP2IX1nO5tLsBKPIcxsGi98L8N
         WBKsN0ILSfkYkl0WsTMR2/rxCZqw4WtQ988KHlu8QZXS6aLMpHItXNprbyyTSPNXrAp4
         6tZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795776990; x=1796381790;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1P9jh/3dNVPHo3/JRb6QOjFyR52ByPWaY+Xbs/2Psnw=;
        b=Clj/vw8qWT44ESlq4DMnyk6ErnGQiVie9TyvBGfShywVKcg4gL1D15zdQCDGKJOm+a
         iXMtoBp4lNWRYnMkDl//Za4TQzIsOTIRxZzCorQd17xNzvnUVtOe+8KKooofaluGwqdE
         9nHZltv0D6S+HPWamo6A7N0I5nEI9BpadyMZq4OelUQjVSCYSAD8YNoc4ZI2g6UmVOWQ
         qquKQS1YgVn07IxbyXb30SGruBsCCQNFQ45HLKotvPQbQaBxHvpLT5fkBgj/eH477XIH
         PcD0m4JsZUG3R0ZXwJ6fKOAiB63BZCMqfEK5o8K1lroH9lWKdjDYQEBCClaCvSV22jH3
         CL8A==
X-Forwarded-Encrypted: i=1; AL+hErGb0Ll1TEjvA8ZdzIkA2DjmVcVdlzxJZsKz+swJsAxoc7Z12+ThOH+doyaRuq/E+j4xhMU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+kASbvTOaEPSup8QdZV8B+qL73eo/hFGIe88h3lvtcPDHMe2zd
	iVYUUe+ae7FFBpeffGKiQeblKhx2GDjs+dPMycX4F2a+fevkgHzZmObYeKjgRAgWlJA=
X-Gm-Gg: AZFdTZfMsc2AuV5QxGFRGvvwbnliOIZ6kpJCZpov30BB/UTLfu1SP2eIfMxf+Klr40d
	Zy5ayDxWyUwlTCtB/Lx0Tvr/dB+KJEqJmvil1IGcSKjVdoQIAtU5VxSgopoMIXT9/maWasuYT24
	1bu41aGUFyhaAokMuycoZ8ZTR3OH0ZO/7Q0BxWORGa1U+XL8b+L8M6VgqV4Hgm+WI2lyOarP2nr
	0UPu9cdLRRIXPm2xBrMQ3rwrT2bbyR4wucit925bV86N3Wi8m5cpz/KCLOHfEs696paPQQNT9Pp
	XIZfMo4Rz8JLkJQeXbuPVC/MvyQkzs2RsSZOHZKOVkb7Ok+pde+l7aBzVLdF5D7/a1ejVhPHdgW
	Sf0wVUp7VpIuKGt19eckKAnHV1yj4SysMCMNLAMopNw/bNDVq110AlXaWQunY8ZLLMjLG2FPTG2
	tYWJNiKeORju1i0HINBbCBrLrVGc0FEAhdcsO7paBr4yPMw+kURMupx5XsjcsWBjcr1qyLGj5Ru
	RIK6S1OCoDfMlgP7oECFh0oi4skRHqJlGDUK7hC3bosCOyrBB3T/aB0+GZUjXjHDYyhk7S7JYGc
	WfcO0JR1PBKw8wqNc7zDvPvVj0ld434HHQ==
X-Received: by 2002:a05:600c:6744:b0:4bb:afae:150d with SMTP id 5b1f17b1804b1-4bbafae24acmr75249945e9.33.1795776990010;
        Fri, 27 Nov 2026 02:56:30 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906c089dsm408746585e9.1.2026.11.27.02.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 02:56:29 -0800 (PST)
Message-ID: <9a471409-04c2-4f6e-aec9-0b23bb9b69f0@linaro.org>
Date: Fri, 27 Nov 2026 10:56:27 +0000
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
Subject: Re: [PATCH v6 0/3] arm64: Add BRBE support for
 bpf_get_branch_snapshot()
To: Leo Yan <leo.yan@arm.com>, Puranjay Mohan <puranjay12@gmail.com>
Cc: vladimir.murzin@arm.com, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
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
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <20260810164622.1829843-1-puranjay@kernel.org>
 <CANk7y0ixo5a3Vfzj_HVhVHRNce2Rsit4pP27GCtXd4jHHzmiKg@mail.gmail.com>
 <CAEf4BzapC=7YM2QLMyKKfyOWGgBTfEJmPPN8e9Jf5xT9SutBTQ@mail.gmail.com>
 <dfa8362e-0dad-4f23-9d2e-dde03cb5facc@linaro.org>
 <CAEf4BzZ=ahQNtA-1KdZFRONXMOEkV9Nb1OUY==JRQCarkbMM0Q@mail.gmail.com>
 <5c7f4a5f-fe5e-4367-9c60-86f1818346e8@linaro.org>
 <20261126180214.GB809232@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261126180214.GB809232@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/11/2026 18:02, Leo Yan wrote:
> On Thu, Nov 26, 2026 at 12:39:52PM +0000, James Clark wrote:
> 
> [...]
> 
>>>>> Mark, Will, you guys seems to be designated as maintainers for
>>>>> drivers/perf/arm_brbe.c, can you please take a look and give your
>>>>> feedback as well? This is important and useful feature for newer arm64
>>>>> CPUs, it would be great to get access to this functionality that we
>>>>> had on x86-64 side for a long while now. Please help get this upstream
>>>>> or, if it's not in the right shape, guide Puranjay towards a better
>>>>> implementation. Thank you!
> 
> ...
> 
>> + Vladimir
>>
>> Hi Mark, Will, Vladimir,
>>
>> Any thoughts on this approach where NMIs need to be disabled? Alternatively
>> we could do something like track where the PMU interrupts and BPF snapshots
>> overlap and then discard the BRBE buffer and make sure they don't trample on
>> each other etc, but it looks like it would be significantly more
>> complicated.
> 
> Could we restrict bpf_get_branch_snapshot() on arm64 to a free-running
> BRBE mode? On a given CPU, at least one active event would have to
> request a branch stack, and every such event would have to be a
> counting event.
> 
> This seems to fit in this series. The selftest opens a CPU-cycles event
> with PERF_SAMPLE_BRANCH_STACK and sample_period = 0, then takes the
> snapshot from an fexit program.
> 
> Counting events can still generate overflow interrupts for bookkeeping.
> It requires to refactor the PMU driver to leave BRBCR_ELx.FZP clear so
> an overflow doesn't freeze BRBE. The interrupt handler could service the
> counters without touching BRBE and losing the branch records.
> 
> Thanks,
> Leo

Yeah I think this is a pretty good idea. It looks like it would avoid 
having to disable NMIs. You only need a local_irq_save() to avoid new 
events from reconfiguring BRBE while taking a snapshot, and you don't 
have to disable the PMU counters either.

If any sampling BRBE event gets scheduled then the snapshots just start 
skipping and returning empty.
