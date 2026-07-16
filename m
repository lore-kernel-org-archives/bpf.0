Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D7B3CB573
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188886; cv=none; b=MgGhZZ8M08lLhejUcWV0u5jTUu8MoCx816a8dtcZrp/xEBVObBuT40MxSDeKOBsH8CwJwE2Is+sjsL2vmao3+O4hGvShLSyO2VMAelgM5CgbpR4m+dI7dZGRJxzoAZEz1Jci/LtnC7sGOY3IGHtq6uILVSjeuvvdsYEsP/MReeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188886; c=relaxed/simple;
	bh=/2Hys85UdvGh+siSTWXF/43ktg9C4EZ8mkEVwsTG90Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpS0Fazg4HxF82WNwJB4OfjmdG0xTIq2dxtoN7bagSiYn9ECx1YCGKfDsjgQ2PZ/9IDOD7TU59pX+466JCMZ+WrpZXICWxGcgC9dZWS2MwaubQaJIHdbEImyuSymLeVgYaAT+t4Wk/CHjYPkpOpfk3kXorZT5JsUgFtpje0tcZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JqYsjz2Q; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JqYsjz2Q"
Message-ID: <d7d1ff88-eedf-4428-b4c8-bfd4c7ebb836@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784188882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6/joMqxfQrU9eDe2vBG1p3OB2Jd1Iz66PvDymTd85c=;
	b=JqYsjz2QuYTFEBK4QUsFZcIwLrNfalShn91XGEZVz+ryu5FCtNAqp1d53IpuSwzZ8IYG0+
	GGi/wb2QhQCOQmkjUNWFmTEF21/3Hf63QVO5lBgiHw6L2soPp8CwwZWcS97DNQ7dJgaGXv
	5YGeTUEZfBtagBI3iYGNb9jEskqMWf4=
Date: Thu, 16 Jul 2026 16:01:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf:syscall: Log error code on trampoline unlink
 failure
To: xu.xin16@zte.com.cn
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, xu.xin@linux.dev
References: <20260716150330696WUY2gk5CaNNaxqm2ggKWL@zte.com.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
Content-Language: en-US
In-Reply-To: <20260716150330696WUY2gk5CaNNaxqm2ggKWL@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 16/7/26 15:03, xu.xin16@zte.com.cn wrote:
>>>>> Well, the crash may happen when the kernel is booting, or too hard to reproduce,
>>>>> in which case, bpftrace does not work.
>>>>
>>>>
>>>> Do you enable kernel.panic_on_warn sysctl?
>>>>
>>>> If it's not enabled, the kernel won't crash, I think.
>>>
>>> I'd like to clarify that the panic in our case is not triggered by the WARN itself.
>>> Instead, the real crash is a use‑after‑free (UAF) that happens when one CPU is
>>> executing a trampoline while another CPU is concurrently freeing it. This results
>>> in an illegal instruction (or page fault) at the PC, which is fatal and will panic
>>> the kernel regardless of panic_on_warn – because it's an Oops with Fatal exception
>>> in interrupt.
>>
>>
>> Why not fix the root cause instead?
>>
>> If you want some help from upstream to fix the root cause, pls provide
>> the crash dmesg and the reproducing demo.
> 
> It's already fixed due to some OOT drivers.
> 
> I think if we have this patch, it can speed up trouble-shooting.

OK. Let's wait for Jiri's opinion.

Thanks,
Leon

