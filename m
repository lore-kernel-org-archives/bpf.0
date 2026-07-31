Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA67357D05
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 05:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785475242; cv=none; b=nxMmpHynPvmzaJM1rJHFweWdwt0mqzyPiKjYh4eaN3ZtrtsO4zjyJhHa3xQ/NIOkn4Pb+1ysPO/L7CyJS+wi9rpUWKXx4JaVhKX70Ow3OHilf/pKWPuFfn5oI7jlmPtoCAceMZd/iGjiVJ/4WVTAx6Sqkkr91GwO6R3wSz4iOn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785475242; c=relaxed/simple;
	bh=4DE+BGGFZ3lbTaMXTgeG3KlatLYDVgNbDOjJ5MlJ84w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4wJVB4cXIMxwCk0GWby11nS2ctMpVrxCMeO9DBmO4QlUzlLloidTAaNneJPJdSeC6bzE39MwRueHP1hFcLUirXJMPZeWVbPdaYHD8HnTFY1ScfSgbG1LY9uVZJ1kj4wQxWyjQFXgAsIuc9BJv2x5YTdrV8AjBSvUEwwJDM8AkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=olbHzuCL; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="olbHzuCL"
Message-ID: <66eaf62b-202b-45b9-8934-fbbc80caa84a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785475237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bc45Iw8dDn/v0HbunpRl3SnMCcbOwMXJUnAbG4NHxoo=;
	b=olbHzuCLiFlT8JfA0UUxWbjzsTO96XucjaJv3ffWeK86sN/xzGyiPRI6amgrXYNjC1sNqr
	B14JkOA4eBFtYuYeQE1XGfW6E350xzo+yG1MAeB3Dri7p5qWTrRWvPdwIIG+MwDgQb+Ogz
	g1SBimTsEB7j7pez65JAzAhpM7T6edY=
Date: Fri, 31 Jul 2026 13:20:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix sleepable check for tracing prog
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 Sechang Lim <rhkrqnwk98@gmail.com>, Varun R Mallya <varunrmallya@gmail.com>,
 Viktor Malik <vmalik@redhat.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
References: <20260725132624.78373-1-leon.hwang@linux.dev>
 <CAEf4BzaoQaODE4F1wfrp37=83bePY=gKpunacKr3rmO230+B3Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzaoQaODE4F1wfrp37=83bePY=gKpunacKr3rmO230+B3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 31/7/26 08:07, Andrii Nakryiko wrote:
> On Sat, Jul 25, 2026 at 6:27 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> When CONFIG_FUNCTION_ERROR_INJECTION is disabled, a sleepable tracing prog
>> is allowed to attach to '__x64_'-alike prefix symbols.
>>
>> It is because the verifier does not verify whether the symbol is a kernel
>> function or a bpf prog. That said, a sleepable tracing prog is allowed to
>> attach to a bpf prog target whose name has '__x64_'-alike prefix.
>>
>> For example, a sleepable fentry prog attaches to a '__x64_sys_nop' XDP
> 
> we do have addr, so we should be able to distinguish between attaching
> to kernel function vs BPF program, no?


Yes, we can distinguish a bpf prog from a kernel function by addr.

I'd prefer passing 'tgt_prog' to btf_id_allow_sleepable() as a simple
change.

> 
>> prog, and copies buffer from a user pointer with bpf_copy_from_user()
>> helper. After attaching the XDP prog to lo interface, the kernel BUG
>> could be triggered by 'ping -c 1 -W 1 127.0.0.1':
>>
>> [    3.460756] BUG: sleeping function called from invalid context at kernel/bpf/trampoline.c:1324
>>
>> Fix it by disallowing sleepable tracing prog always when its target is
>> bpf prog.
> 
> what happens when we freplace sleepable BPF program/subprogram with
> another sleepable BPF subprogram? And same question for sleepable
> fentry/fexit program attaching to sleepable BPF program? Is it
> something that just cannot work or we can actually allow that?


Currently, sleepable freplace/fentry/fexit progs are already disallowed
from attaching to bpf prog, because btf_id_allow_sleepable() returns
-EINVAL for them (except for this BUG).

Since no one has proposed relaxing the restriction, I'd like to keep it
as-is when fixing this BUG.

I'm not sure whether allowing it would introduce any issue.

Thanks,
Leon

> [...]


