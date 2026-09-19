Received: from mta0.migadu.com (out-1.mta0.migadu.com [91.218.175.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D963238228A
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 19:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789846384; cv=none; b=kb/0KJKwnfJPjoYmKzMHn/sFd7F926GqCP0AjognqUn727lLP7nNUCFPw0MiumJEjLEmfknFxgCnLnGcD3epcpULmXR8Ou/Xmhw4+nvvMGgGFKeTYjicM6RrypGDXNSIYstNO77nWzvDLRXvmdKdV/F3sXqYVIySChM3+BEf4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789846384; c=relaxed/simple;
	bh=xE6jfuoKYQZYMCxqg6NzQAVyKkFWrTVReaqnbLiNe50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVEaXAm3VtuuOHRb1S2f30mUbh8Gm379Gwqoy4+nL/KC15oWFeLJ4CrFbA/KfuAClPvq7srRSn3f0mBQSIr4MWyiu0JsB9LAggTQL76amHvEHPr0a0m4nC8FgyyJK7ft77/tsScpII1SDNpee4E//7UDyKt5S30S+z6Hh26dEzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PZif4kU0; arc=none smtp.client-ip=91.218.175.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PZif4kU0"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xE6jfuoKYQZYMCxqg6NzQAVyKkFWrTVReaqnbLiNe50=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789846379; v=1; x=1790451179;
 b=PZif4kU00aImbpF0X1VKZhrf97ZVfzeccLTwI06qeDxsH4HnxMQbPvzf4ijTIY+etQERa2FK
 0Vqj+PfrCpryMfG6K5gMD9mes0L44H+zppYQBFdSkWGCjjF26wzvnRubH3FwkPKycv2kvhnaDjY
 EyCMW8fmhidTMn/GZjgvCc7k=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 96355e51f462fce3;
	Sat, 19 Sep 2026 19:32:58 +0000
X-Mizu-Trace-ID: 96355e51f462fce3
X-Migadu-Flow: FLOW_OUT
Message-ID: <1dfb59b4-9c23-45f7-8fac-ade2cedb3685@linux.dev>
Date: Sat, 19 Sep 2026 12:32:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 06/20] bpf: Explore the landing pads no call
 site reaches
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260918044228.3287877-1-yonghong.song@linux.dev>
 <ef212951f3582678f582cf9d5664dcbd95377640aaf27eebdc53c86df81a7176@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ef212951f3582678f582cf9d5664dcbd95377640aaf27eebdc53c86df81a7176@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/26 10:44 PM, bot+bpf-ci@kernel.org wrote:
>> commit c93117f24a1a9cc39bfeaef79c42dbff02d8c455
>> Author: Yonghong Song <yonghong.song@linux.dev>
>>
>>      bpf: Explore the landing pads no call site reaches
>>
>>      A cleanup record need not cover a call an exception can unwind out of: a
>>      frontend is free to emit a region around a helper or an ordinary kfunc,
>>      both nounwind here. Nothing marks a call site then, and that record's
>>      landing pad is reached by nothing at all -- leaving bpf_check_cfg() to
>>      refuse the program over code its own frontend had no way not to emit:
>>
>>         0: call bpf_preempt_disable
>>         1: call bpf_preempt_enable      record = { begin = 1, end = 2, pad = 4 }
>>         2: r0 = 0
>>         3: exit
>>         4: r1 = pads_ran ll             landing pad
>>         6: r2 = *(u64 *)(r1 + 0)
>>         7: r2 |= RAN_NOUNWIND_REC
>>         8: *(u64 *)(r1 + 0) = r2
>>         9: call bpf_unwind_resume
>>        10: exit
>>
>>      The range [1,2) holds one call, and it is a kfunc, so an exception cannot
>>      come out of it. cleanup_mark_call_sites() marks nothing, nothing pushes an
>>      edge to 4, and 4 through 10 are reachable from nothing: "unreachable insn
>>      4". The pad is dead, which is correct -- no exception can ever arrive at it
>>      -- but the program is fine and has to load.
>>
>>      Walk every pad the table names that the edges did not reach, the way the
>>      walk is already re-seeded at an exception callback. From there the pad is
>>      code like any other: do_check() never enters it, because no call site
>>      dispatches to it, so the dead code sweep removes it along with everything
>>      else that was not reached.
>>
>>      Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> This looks like a bug fix for the earlier commit that made exception landing
> pads reachable in the CFG. Should this include:
>
>    Fixes: a67011bbbca1ba95 ("bpf: Make exception landing pads reachable in the CFG")

No need for this Fixes tag.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35308528711

