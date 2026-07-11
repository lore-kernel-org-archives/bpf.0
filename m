Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECC425B0B6;
	Sat, 11 Jul 2026 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783771793; cv=none; b=WE+d7lNosJ2Qkz1diDbqqCJPZwyil+LzvZAD/YqzHv9BtyltMaZ9lm9Z9/odHndLFoAnTNXnG7Zz5vKgO+S2aTeC+fo1TstiEp1dqZONN/m+Oqln+vnZVfORvzVZqaV0QwdNwId+Xnt/BviPESkNOh7kf3E98yEQmOYVAN9Wms8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783771793; c=relaxed/simple;
	bh=vqS+W1jU6KbctOdHjdtMfnextmJZlOJ9Cn/6aDbg6IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbwdoaQtx1RxfUP3UWoDx26GTfZ8nspf7P/NfsLFLVRh1jogcpgjifsztfukVT4QPw2/GpZmc1EpcDclyV2mnLljftWOuHaprM3bF81xOYytJKfynJmpsF7YKTjR8GFIZj5UNotPmLGWauNyaCqx4QouOGwjBMnNH8V6lnWDAUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PpygNmqn; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PpygNmqn"
Message-ID: <3b473dcf-54de-4925-8939-4a8c08f48341@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783771788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KBR2/ci64dEFqKoBwWixeRCc/qpnm8OhZ34VDlvHtzA=;
	b=PpygNmqnaIXUOESeF1UzYLC5kiOqvsNJdxifAMxpLWiMGwNxLn+2qESHABY54LgixDaS71
	IAeKY6QdmHS9Fuq9FvNbkMj9pqKFVxUHrdHrvsdzzIUtPTyVrhi/lq/9z1SHtSnZ/vmSVt
	ohTtVnAkMajZl2NNG44m2dRa//CluXA=
Date: Sat, 11 Jul 2026 20:09:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Mark tracing_multi trampolines as
 ftrace managed
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260710144734.78203-1-leon.hwang@linux.dev>
 <20260710144734.78203-2-leon.hwang@linux.dev> <alFvBaC7moSlJMh6@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
Content-Language: en-US
In-Reply-To: <alFvBaC7moSlJMh6@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/7/11 06:15, Jiri Olsa wrote:
> On Fri, Jul 10, 2026 at 10:47:33PM +0800, Leon Hwang wrote:
>> Since tracing_multi link does not set ftrace_managed, it would fail to
>> release the tracing_multi link when attaching tracing_multi link and
>> then attaching fentry link.
>>
>> [    3.714215] WARNING: kernel/bpf/trampoline.c:1727 at bpf_trampoline_multi_detach+0x20b/0x240, CPU#1: test_progs/97
>> ...
>> [    3.733170]  bpf_tracing_multi_link_release+0x14/0x30
>> [    3.733890]  bpf_link_free+0x58/0x130
>> [    3.734414]  bpf_link_release+0x23/0x30
>>
>> Fix it by setting 'ftrace_managed = true' in register_fentry_multi().
>>
>> Fixes: aef4dfa790b2 ("bpf: Add bpf_trampoline_multi_attach/detach functions")
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  kernel/bpf/trampoline.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
>> index 1a721fc4bef5..6eadf64f7ec9 100644
>> --- a/kernel/bpf/trampoline.c
>> +++ b/kernel/bpf/trampoline.c
>> @@ -1536,6 +1536,7 @@ static int register_fentry_multi(struct bpf_trampoline *tr, struct bpf_tramp_ima
>>  	if (bpf_trampoline_use_jmp(tr->flags))
>>  		addr = ftrace_jmp_set(addr);
>>  
>> +	tr->func.ftrace_managed = true;
> 
> I wonder we could set tr->func.ftrace_managed early in bpf_trampoline_get,
> but we could do that as follow up


Makes sense. Let me try it when adding tracing_multi link support for
bpf progs.

> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>


Thanks for your review.

Leon

> 
> thanks,
> jirka
> 
> 
>>  	ftrace_hash_add(data->reg, data->entry, ip, addr);
>>  	tr->cur_image = im;
>>  	return 0;
>> -- 
>> 2.55.0
>>

