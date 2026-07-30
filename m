Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F2B2EBBB7;
	Thu, 30 Jul 2026 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380768; cv=none; b=Km0g3m2pKskxmyJyvME0nESsZVKfnqWTxcRbUXonIVtdgj1nc6823BOao3i6HRYJBIk1HNwc9OzkLUZHAmcAQHPQsGB8pEVFYoepzfTL+4d9hp535WrLgjgqRrMowAMbd/3IPxyUPcIo+qjMpr6vCBAqEdDdZLQpRjYAtsRJy/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380768; c=relaxed/simple;
	bh=cllLhgmRjXVeqwURSS43GIa+82qyOa48o4iQoBUuXwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IC+Z9e4z282x4cRoDF2B3vmoVrW8IMJudVK5nffDLUwJ5PSupzicdcHc2mWYlF1P0u7uCJ4uPfdzxu+76iuoukShrXSiTuba1E3j0a16pLbRInUhPuXI0pLLkhvEVhZPqHxIp5/ewTp+6RhHTi/WwLop0/Ov8cf/uHCYKpaJNH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DP14HDqt; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DP14HDqt"
Message-ID: <d745ca80-6516-4c61-8107-88c6a2d9cea4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785380753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eMkah/7xCdD4zUghDYh4eVNm7WoXmd5uInZAQK3gLPA=;
	b=DP14HDqt8/CWCynEUMpJuo5di6yH7F1t3gzWP9h5l5ZP5yRB8fSAQsJyc3igiPwr4sXStT
	UMKuJWYdNe15ZE0uL72LHZDVS3nEW3+3HoK/kKgm5hIAhhndT5GUTYq2PWvO8ztr1CMzab
	LXWPuRRQbVlQNMnJeIRsKmX2Y92EnMw=
Date: Thu, 30 Jul 2026 11:05:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] arm64: ftrace: enable single ftrace_ops for direct
 calls
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260727142844.21212-1-leon.hwang@linux.dev>
 <20260727142844.21212-2-leon.hwang@linux.dev> <amnqXeC6D4mjcAe_@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <amnqXeC6D4mjcAe_@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/7/26 19:56, Jiri Olsa wrote:
> On Mon, Jul 27, 2026 at 10:28:43PM +0800, Leon Hwang wrote:
>> The BPF tracing multi link updates several direct-call sites through one
>> ftrace_ops. Its implementation is therefore gated by
>> HAVE_SINGLE_FTRACE_DIRECT_OPS in addition to
>> DYNAMIC_FTRACE_WITH_DIRECT_CALLS.
>>
>> Select HAVE_SINGLE_FTRACE_DIRECT_OPS whenever arm64 enables dynamic ftrace
>> direct calls. This enables BPF tracing multi links on arm64. Also
>> generalize the unreachable-trampoline comment because the single-ops path
>> does not use ops->direct_call.
> 
> hi,
> iirc arm needs ops->direct_call for trampolines to work properly,
> that's the reason we enabled single ftrace_ops on x86 only:
> 
>   424f6a361096 bpf,x86: Use single ftrace_ops for direct calls
> 
> I don't understand the arm usage of op->direct_call, but it looks like
> (codex thinks) that the fast path won't always work without op->direct_call
> being set


In theory, op->direct_call is the fallback for the case:
HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS=y, out-of-range target, and non-BPF
direct ops. This is what Codex thinks about.

However, after searching the call sites of
register_ftrace_direct()/__modify_ftrace_direct() in kernel, which would
set ops->direct_call, the actual callers are in bpf/trampoline.c, which
have been gated with HAVE_SINGLE_FTRACE_DIRECT_OPS. That said, for
normal usage of HAVE_SINGLE_FTRACE_DIRECT_OPS=y, op->direct_call is unused.

If someone uses register_ftrace_direct() or
modify_ftrace_direct/_nolock() outside BPF in the future,
op->direct_call will be used.

So, I'd like to drop the comment change in the next revision.

Thanks,
Leon

> 
> from arch/arm64/kernel/entry-ftrace.S:
> 
> 	#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> 		/*
> 		 * If the op has a direct call, handle it immediately without
> 		 * saving/restoring registers.
> 		 */
> 		ldr     x17, [x11, #FTRACE_OPS_DIRECT_CALL]             // op->direct_call
> 		cbnz    x17, ftrace_caller_direct
> 	#endif
> 	#endif
> 
> jirka

