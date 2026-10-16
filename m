Received: from mta1.migadu.com (out-70.mta1.migadu.com [95.215.58.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C07C2877DE
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165562; cv=none; b=rkWYQg+oOmISfazdM49R0ee8LCT9mr7Kst8W37ymXFhK2QnkVEUoaycjdszK4ADzGTfuHg2qenrdlFqRc3dQQBOoKVuSJNhwy09EJ8OBJ2IivVWxAsNUedYWm6rkuelskgLI2uvKvL0qLEGZbH7j0f+VNKeN3L7iGqKzLYcAarY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165562; c=relaxed/simple;
	bh=0GSxD0NzJWqzbVAUi7hSqH/TNjjgblumNNG2PXmD/+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1IjjLdBKAg8fPA97UuQZMzg3RKLpfIOWdxWt7nTUFu2LhU+9fdKjTBiXSEmEMfNImHoC7u7ekC9tck5TwlXfqHRXBs62HmsMPQw1Ad776t4NRPhEXjBqY/IwH2zn4+4NIUA0wn23U7kXjG7pkKRS0DSqsw3eItv6dlY1OG02H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HocIVM7w; arc=none smtp.client-ip=95.215.58.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HocIVM7w"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0GSxD0NzJWqzbVAUi7hSqH/TNjjgblumNNG2PXmD/+o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792165558; v=1; x=1792770358;
 b=HocIVM7wxRZK4Akx4PNpU9EoPV9mY7pjLc0BCrvdCYrAbZpRvcCoKN578L9R3CKp9DmYSVFH
 SXmn7ZU5YoUQji24QhrszuzhMWKOxo7L34zS8e60VCZTw85jXzCgt0+IH08XcF2VJqM48XLK2xC
 BsSol0fbo98saLSevsE9RXDs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9e3cef12ebf06e4b;
	Fri, 16 Oct 2026 15:45:58 +0000
X-Mizu-Trace-ID: 9e3cef12ebf06e4b
X-Migadu-Flow: FLOW_OUT
Message-ID: <ace9e0d5-0357-4401-be7a-b77ddca86f0b@linux.dev>
Date: Fri, 16 Oct 2026 08:45:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 10/11] bpf, x86: Give a kfunc's stack argument
 the 16-byte alignment it needs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20261013170910.2126673-1-yonghong.song@linux.dev>
 <20261013171035.2137865-1-yonghong.song@linux.dev>
 <DM5X2Z5473A5.DNWH4JDJTYJF@gmail.com>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DM5X2Z5473A5.DNWH4JDJTYJF@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/15/26 7:46 PM, Alexei Starovoitov wrote:
> On Tue, Oct 13, 2026 at 10:10 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> The JIT places a kfunc's stack arguments at the offsets from RSP that
>> the convention gives them, holes included, but RSP itself is only 8-byte
>> aligned in a BPF program, so a kfunc can get such an argument at an
>> address that is not 16-byte aligned.
> There are no kfuncs that take __int128 on the stack.
> The kernel is built with -mno-sse, so nothing but cmpxchg16b on &g
> cares about this alignment.

Indeed, with -mno-sse, the stack base whether it is 16-byte align or
not probably does not matter.

> Can we drop this patch?
> because...
>
>> +	for (i = 0; i < n; i++)
>> +		EMIT4(0xFF, 0x74, 0x24, disp);	/* push qword ptr [rsp + disp] */
>> +	skip[-1] = prog - skip;
>    u64 kfunc(u64 a, u64 b, u64 c, u64 d, u64 e,
>              __int128 x, __int128 y, __int128 z, u64 w)
> takes 133 bytes total. BPF_MAX_INSN_SIZE is 128.
> do_jit() prints "bpf_jit: fatal insn size error" and the prog
> fails to load. It was 92 bytes before this patch.

Yes, will drop this commit and the next self test which is to demonstrate
this commit.

>
> pw-bot: cr

