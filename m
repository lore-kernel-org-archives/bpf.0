Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E3634A3AB
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184997; cv=none; b=Y5+eE9Shb8Walj39kGYkKCeBHJjw3AmLlGfbC4JG72Q+6T2x1aO9paG/FcGcqDaxt45KZICoUgZsJMCdRf/uNG3y5lr9ib1Nd1re5qqO034PeEXO7Mss3ZmrdqxTrYg+Ci6K0nwBMcb6k9bApQl9ZoVIcm20zf1H3ds8aXU1YQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184997; c=relaxed/simple;
	bh=Cv/N1L+YNfNNoDZ8ZKoV/S1AELPfUlzjJA1DbA9Gbz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8U5hZHZDv6Pb5B64pdCb8WSEmBZb0d91ZyoF0S+66SjXKAZha6JJntReEPswgaqHVlvXqXf9B+4onqOAvwmhV5EyfHKhnMhTeg0qY+yNInaq8fovLz3/NIETlgxV/7qDd0toRKaNfn91Fkcb+t+89EfONfXl9Od1r/0jXq3gNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FwIknOuL; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FwIknOuL"
Message-ID: <2528a896-a0f4-46ef-a7c5-83c7c8a2980a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784184983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYiGjNxhXvM9lkBqPYl3fjOblmr5js/K8FgoFt45DIA=;
	b=FwIknOuLo4Fc77ndz5SZrExsHV8VRIXWTffAruI+Aprr35oOG6fxNkRgOBeU11CsJf4kYf
	CgNa+dBygy1NfJs1Dop6/KGWg/w0+zz4U3H+1bKkr2Y2LlxskZP7OVmTBvkBomlWwn1AwA
	QfbI3dx4v8II2UtPg8wFmwdiDFKOTaA=
Date: Thu, 16 Jul 2026 14:56:13 +0800
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
References: <20260716142613346GZ_NR5Zi4awr3wEReuIMG@zte.com.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
Content-Language: en-US
In-Reply-To: <20260716142613346GZ_NR5Zi4awr3wEReuIMG@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 16/7/26 14:26, xu.xin16@zte.com.cn wrote:
>>> Well, the crash may happen when the kernel is booting, or too hard to reproduce,
>>> in which case, bpftrace does not work.
>>
>>
>> Do you enable kernel.panic_on_warn sysctl?
>>
>> If it's not enabled, the kernel won't crash, I think.
> 
> I'd like to clarify that the panic in our case is not triggered by the WARN itself.
> Instead, the real crash is a use‑after‑free (UAF) that happens when one CPU is
> executing a trampoline while another CPU is concurrently freeing it. This results
> in an illegal instruction (or page fault) at the PC, which is fatal and will panic
> the kernel regardless of panic_on_warn – because it's an Oops with Fatal exception
> in interrupt.


Why not fix the root cause instead?

If you want some help from upstream to fix the root cause, pls provide
the crash dmesg and the reproducing demo.

Thanks,
Leon

