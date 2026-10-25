Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792942096;
	b=jC9K/quCrFyoeKpTaQ3762pW/3399K7p0GDiiJV+bdkAPJt1RFf2PiaodBk7hzhyho0m
	 jCX9WIx77UOKDRgLOVpg5JxfeY+yZuvGcZ185cQn/cFNytxx3W83tzfGgABfV8MVGjhZP
	 JOA9Bb8p8sa8EUZxH5r259A5KbCSzkiYQegoPe2qFdAQuL/ip3uxMzwftbiFRVRWyNJ4M
	 MgzDhG5oY73VafqnX3vP3NfrHwr9if92C1Q1Tk14xVIXQvSOloTp7JVeVYmegUqJtYkEL
	 cX7wfA0vC2PFV0Zd+XHd6zI0VlxhjocC7ZYd5O2d2rNAAdicBC820Z6LfVTCuA4Tm5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792942096;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=Rthwxh+zT2y3t40uv7dYDirQ7LAJVYO14/tkgXayeX0=;
	b=dtOGvOewTRYUDj2EKdaLOuf4kb0IzXtREToIqeZeBX0I3+EVOhHKLgF1a3rPU1x4sW1D
	 Pm4feTspxf7nGZF6lM3fL3CmbuG56gtp2LzxvorIe6SrXUmm5JOw9FN3vcgNVQHJ40xV5
	 D02GSSimyTV/5YHSrLoUkj0iCNgUB/CLmEeQWgvTll5vBXlkYhPVUUUgdsVuX1SCFMMvm
	 tyD2P1Gk+XaEDRYX+M4E93QrYwRSboyeqGtbzwHMDBNrUWFHPEiP9ThWmTopVvtsg9ITK
	 ceViu1Ms8UWe/amrtIZJtex1ZCG9Fe88mOK0QD7yGd+oxEc8KiCEpv4hLZMMp/LU+kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=maly4NUO;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87901606A31A
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 15:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87901606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=maly4NUO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Rthwxh+zT2y3t40uv7dYDirQ7LAJVYO14/tkgXayeX0=; b=maly4NUOlUjFcoWPXMynZaHJU3
	rrY2G6OXH1QcukMdKghELmpj6Q1OImFHL1llo22z4zKtF7fV8opIQ3gfRjCz4k+mxypmmNcXRYi9X
	s3bteezcLA9qYKVjTz87m5WEyJM+9zz+lhu7vlQkkB4PThRzUE4FZ7+Xdp1QsQtWbT7gJQ8HeOVlZ
	H2tteV2Xy1ZHQERBlRXQ4QpZl/QwSYH8vwJ1jzqmrzJMnqDBocLda3sh25lvb+huVcVssxNAkS1yK
	rcjqusZOIJJjNVY1lelwttM8oR3Lkiu7jzPT2EHGxnSVbzN3lgHIV6p98ghy214Yuo1W76jLq9FM1
	d67Eb+3A==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xL08a-0006dr-2t;
	Sun, 25 Oct 2026 16:27:56 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xL08a-0000px-0b;
	Sun, 25 Oct 2026 16:27:56 +0100
Message-ID: <8c2784c0-2b13-4cc2-b770-51bbb8006f26@iogearbox.net>
Date: Sun, 25 Oct 2026 16:27:55 +0100
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
Subject: Re: [PATCH bpf 1/2] x86/ftrace: Use jmp mode only where functions are
 aligned
To: Jiri Olsa <olsajiri@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org,
 Menglong Dong <dongml2@chinatelecom.cn>, Steven Rostedt <rostedt@goodmis.org>
References: <20261024073712.1074591-1-daniel@iogearbox.net>
 <DMDB1EESN4U0.KLEICFNC4NUP@gmail.com> <at4BvTcsjWwDuvbl@krava>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <at4BvTcsjWwDuvbl@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28164/Sun Oct 25 07:24:12 2026)

On 10/25/26 2:18 PM, Jiri Olsa wrote:
> On Sat, Oct 24, 2026 at 07:10:57PM +0000, Alexei Starovoitov wrote:
>> On Sat, Oct 24, 2026 at 12:37 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>> Bit 0 has that meaning only for the direct trampolines that a dyn_ftrace
>>> record can point to, so jmp mode relies on every other target being even.
>>> Select HAVE_DYNAMIC_FTRACE_WITH_JMP only where it is, with
>>> CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT or without CONFIG_CC_OPTIMIZE_FOR_SIZE.
>>
>> Disabling it for -Os builds is not great.
>> Can we fix the users of ftrace_call_replace() instead ?
> 
> looks good, it takes care of the C function targets, the rest
> should be aligned ftrace trampolines (static or dynamic) or
> direct api targets

I had the below first as well, but then saw that there were similar issues
regarding function alignment in the past and they were solved on kconfig
level, some picks:

- b3f11af9b2ce ("arm64: ftrace: forbid CALL_OPS with CC_OPTIMIZE_FOR_SIZE")
- a743f26d03a9 ("arm64: ftrace: Don't forbid CALL_OPS+CC_OPTIMIZE_FOR_SIZE with Clang")
- c41bf4326c7b ("riscv: ftrace: align patchable functions to 4 Byte boundary")
- 9315e22b0c0a ("arm64: ftrace: allow DIRECT_CALLS without CALL_OPS")

But I can also spin a v2 with the code change instead if preferred.

>> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
>> index 17d6edf..654c3f2 100644
>> --- a/arch/x86/kernel/ftrace.c
>> +++ b/arch/x86/kernel/ftrace.c
>> @@ -190,11 +190,11 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
>>   	const char *new;
>>
>>   	ip = (unsigned long)(&ftrace_call);
>> -	new = ftrace_call_replace(ip, (unsigned long)func);
>> +	new = text_gen_insn(CALL_INSN_OPCODE, (void *)ip, func);
>>   	smp_text_poke_single((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
>>
>>   	ip = (unsigned long)(&ftrace_regs_call);
>> -	new = ftrace_call_replace(ip, (unsigned long)func);
>> +	new = text_gen_insn(CALL_INSN_OPCODE, (void *)ip, func);
>>   	smp_text_poke_single((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
>>
>>   	return 0;
>> @@ -503,7 +503,7 @@ void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
>>
>>   	mutex_lock(&text_mutex);
>>   	/* Do a safe modify in case the trampoline is executing */
>> -	new = ftrace_call_replace(ip, (unsigned long)func);
>> +	new = text_gen_insn(CALL_INSN_OPCODE, (void *)ip, func);
>>   	smp_text_poke_single((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
>>   	mutex_unlock(&text_mutex);
>>   }
