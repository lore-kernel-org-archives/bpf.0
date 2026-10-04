Received: from mta1.migadu.com (out-138.mta1.migadu.com [95.215.58.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB0D471402
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136786; cv=none; b=bd4q1L1HdONceYguv2aoA5GpWRvROHcbytilkSSMvEGjAzHr3gNUn6ai+3PZwMcKtEjR2+PtUrLzFFOWAvsSoP/InB1ngHnm+59YmrUFiYnBBrhBgEkbfRYKbhx0L0bt5riTZ9bXjnz8L441aAWpiEsdFkilraOpz/Q1Hf9coWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136786; c=relaxed/simple;
	bh=ctetipqagztx00dWNra+Lss2+wHLNxgZWCIEzOIqEwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGC8IzB9sbD0wK5WqN5Xj5H2r3DAHCxaTwuVFn4t+OLEoCM7xMHYuYhN9cnMSZsupFiID5Pi2rqj0PiTlPHL4VTcONlyx+KFr/cqT2cE0IHyOXm6v59vcXjxgYMqQWgG5CUMYEG6/FUe3uGHxbeJEgrQIr/91HfXmcjDbU4asuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=htx8jKBU; arc=none smtp.client-ip=95.215.58.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="htx8jKBU"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ctetipqagztx00dWNra+Lss2+wHLNxgZWCIEzOIqEwY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791136777; v=1; x=1791741577;
 b=htx8jKBUlAiR0xqSd3gXRZrmB+7XQlP/YZ4ymS/zUOOl5WUZw9VuBgcj+uF/VGQtzXHuVNir
 HIUqOBS8J3q5veFZD0D0rTiJU+PqAluGe59CrMT6D8tabNqdDBkLM7m4uAYJ98ckDKLwsltznDZ
 q8pjro2pLbGksysfV3bE04xY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9de13ca0c98727d2;
	Sun, 04 Oct 2026 17:59:37 +0000
X-Mizu-Trace-ID: 9de13ca0c98727d2
X-Migadu-Flow: FLOW_OUT
Message-ID: <372a2358-31a6-4b01-90fa-e218f8ad4a92@linux.dev>
Date: Sun, 4 Oct 2026 19:59:36 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 08/22] bpf: Require an unwind to leave a frame
 holding what it entered with
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20261001133006.1335369-1-yonghong.song@linux.dev>
 <20261001133047.1339752-1-yonghong.song@linux.dev>
 <DLV79B84WZW4.BP3KA640VKGX@gmail.com>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DLV79B84WZW4.BP3KA640VKGX@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/3/26 2:25 PM, Alexei Starovoitov wrote:
> On Thu, Oct 01, 2026 at 06:30 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> frame that dropped it. The rule does refuse a program that could be proved
>> safe, a callee releasing its caller's reference and a caller's pad that
>> relies on that, but compiled code does not do that. A pad only knows about
>> its own frame.
> Compiled code does exactly that. It's a move.
>
>    fn consume(rec: Record) { may_panic(); }
>    fn foo() { let rec = reserve(); consume(rec); }
>
> consume() owns rec, so the pad of consume() drops it.
> foo() has nothing left to drop and rustc emits a plain call with no
> record over it.
> 'call consume' is refused with
> "an unwind through this call keeps the reference".
> With a record over that call the resume in consume() is refused with
> "a resume does not leave the frame's references as it found it".
> pad_drops_caller_ref_frame() in patch 19 is what consume() compiles to.
> RcuReadGuard passed by value is the same.
>
> [...]
>
>> +	u32 entry_active_locks;
>> +	u32 entry_preempt_locks;
>> +	u32 entry_rcu_locks;
>> +	u32 entry_irq_id;
>> +	u32 entry_id_gen;
>> +	u32 entry_acquired_refs;
> The verifier doesn't need them anymore.
> "Unreleased reference id=%d alloc_insn=%d" at exit already points
> at the insn that acquired it.
> Drop this patch.

You are absolutely right. We only need to check resource
right before main prog return. This patch indeed not needed any more.

