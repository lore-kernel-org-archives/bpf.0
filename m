Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7240B32ABCD
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 06:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784182191; cv=none; b=iT0kcW0LODSszNL1B8i/IFdfY1LlNnb0/UjH+ogjqhMn3OkMrJOSDdBwNguAZyxjGlIvZ7wD9Ghbtlc9Ag/qxpYaRX0J8FC9IyrPHZDkrpBcQJThc3cggIO94robH5x0NzhEK4JQ1zuzyJupZ6qm46UFtO/FoTZ5y/7TM7IFq44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784182191; c=relaxed/simple;
	bh=P8wcxkTAnG3gCRRhfC1C5hhJN2KGx119D/3yu0S/8E8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMtNTJFy3qNrmgtSYrEYttFA7ard13/XfveXKPAuinu0NsnTEX4z3aWt8r28i9bLGdy8n9ahPcLByQxYCJt1dnuBRRnGRIm9x1qwcPQgKgparcQ6e5U/Swva3eJAg5ToRIpN848lO9NPkIXrcOV58qemeQ1WBbfXQo27vuihAfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M92vOKI5; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M92vOKI5"
Message-ID: <acc8805c-2e66-49c9-95be-43ce1c954ee7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784182177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9TkxBsd5OOPvbMqn5M000sbjpDiqVrsetwzspe2LW48=;
	b=M92vOKI5yROOAuHcXC3dazaqslM9VkUYE0aiRjHofnUmydY3avEcM6vD98aUS9U4jZSSO4
	KyOfH43SuR4W7EOTNjHWsoW3cLNJQwA2pp61yvIOXq1+2hCcEOkrxKiiGEHYVK22wjabg1
	jB72xXvTTUwQLDyS/CawPbBG+my5ndU=
Date: Thu, 16 Jul 2026 14:09:12 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf:syscall: Log error code on trampoline unlink
 failure
To: xu.xin16@zte.com.cn, leon.hwang@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, xu.xin@linux.dev
References: <20260716135515586meEuKQ_R48nXmdnpldURM@zte.com.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
Content-Language: en-US
In-Reply-To: <20260716135515586meEuKQ_R48nXmdnpldURM@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16/7/26 13:55, xu.xin16@zte.com.cn wrote:
>> In subject, 'bpf:' is enough, 'syscall:' can be dropped.
> 
> Ok, thanks.
> 
>>
>> On 16/7/26 11:34, xu.xin16@zte.com.cn wrote:
>>> From: xu xin <xu.xin16@zte.com.cn>
>>>
>>> Replace silent WARN_ON_ONCE with WARN_ONCE that prints the actual error
>>> code from bpf_trampoline_unlink_prog(). This aids debugging of race
>>> conditions during link teardown, while keeping the warning rate limited
>>> to avoid log flooding.
>>
>>
>> Have you tried to trace bpf_trampoline_unlink_prog() with fexit?
>>
>> bpftrace -lv 'fexit:bpf_trampoline_unlink_prog'
>> kretfunc:vmlinux:bpf_trampoline_unlink_prog
>>     struct bpf_tramp_node * node
>>     struct bpf_trampoline * tr
>>     struct bpf_prog * tgt_prog
>>     int retval
>>
>> Since bpf_trampoline_unlink_prog() can be traced with fexit, it seems
>> unnecessary for this change?
> 
> Well, the crash may happen when the kernel is booting, or too hard to reproduce,
> in which case, bpftrace does not work.


Do you enable kernel.panic_on_warn sysctl?

If it's not enabled, the kernel won't crash, I think.

Thanks,
Leon

> 
> So this change will be more helpful, I believe.
> 
> Thanks,
> xu xin
> 

