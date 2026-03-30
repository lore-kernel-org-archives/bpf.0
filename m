Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D7A1D5CD1
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907797; cv=none; b=rec2PNY00hzzisS/G8uR6P7TLEVbnXM7LVZ0+CFynT15eMe6mAW6kUqpQmJvfFIPqBZFmVstr4THYFYJYIIaYvLzsfcxw2qQ2B0GOu/6duGkYyDvOyi0HMtQt4LAidhzeoi8h8UeUTUdX2cd/yObWXMhVPtVj42inUzsPIotyxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907797; c=relaxed/simple;
	bh=QSbbYVg9OCD0ZKZFNDIuyz5Q0QHkhG/5EsdOa20CV6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJHQRYekCQV2c4Vg/6+WZDD6kPBAR/QsALN9o1zJ1OAYVl5U53z4JlHBMMzbteEYC26q2dr6Wt1IbFJLnm3fI/sOdJKWdewiouNdWNWq8IVpw4emN20XAGX6eKJcxZjLno/oMTsj8PGK2s92fpZklovgloYPPxRAIK9KV5FLi5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=bUZ/vnX0; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="bUZ/vnX0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2fJhU3oYbF671w6WTdyvusz/Xs9UpMEMtMRRL6V36YU=; b=bUZ/vnX01AYlHIDFRlM3YNGhoC
	2/MaWy0pcXW5F8/T//DGBnuWqevAkI3h2eMu/2zehvmH6EpscwX9uYe654gusLyCU9QGSSj/sPN9V
	rIAyjTqrIO92WUC7eFXVjxogZq6b9jeI2Ue16i7cbvOKWoCD6e1lzsZeXtt3OASxU+FsIHNCDyEXd
	XPTMev6t1ktxGqxXzw2OwaQ0ExSdC4+YY5wVOvMffrssVY2VOK35hSINJF6LqH6G/JSJvuKTuJxtD
	jukHPMaKkjmpGjK2dvp10+SpszeuR/5HME17jFwbNnT+Aw1R5GnLcd2DKNFyD747PuVu7J9vtj4vQ
	98lzMBeA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w7Kb1-0007Ba-2c;
	Mon, 30 Mar 2026 23:56:31 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1w7Kb1-0005wE-2I;
	Mon, 30 Mar 2026 23:56:31 +0200
Message-ID: <3a01a673-8cf1-43ea-808a-088998d932f6@iogearbox.net>
Date: Mon, 30 Mar 2026 23:56:31 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/2] bpf: Fix incorrect pruning due to atomic fetch
 precision tracking
To: Puranjay Mohan <puranjay@kernel.org>, eddyz87@gmail.com
Cc: ast@kernel.org, bpf@vger.kernel.org, STAR Labs SG <info@starlabs.sg>
References: <20260330132750.377862-1-daniel@iogearbox.net>
 <m2o6k5z8fp.fsf@kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <m2o6k5z8fp.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27956/Mon Mar 30 08:24:32 2026)

On 3/30/26 4:41 PM, Puranjay Mohan wrote:
> Daniel Borkmann <daniel@iogearbox.net> writes:
> 
>> When backtrack_insn encounters a BPF_STX instruction with BPF_ATOMIC
>> and BPF_FETCH, the src register (or r0 for BPF_CMPXCHG) also acts as
>> a destination, thus receiving the old value from the memory location.
>>
>> The current backtracking logic does not account for this. It treats
>> atomic fetch operations the same as regular stores where the src
>> register is only an input. This leads the backtrack_insn to fail to
>> propagate precision to the stack location, which is then not marked
>> as precise!
>>
>> Later, the verifier's path pruning can incorrectly consider two states
>> equivalent when they differ in terms of stack state. Meaning, two
>> branches can be treated as equivalent and thus get pruned when they
>> should not be seen as such.
>>
>> Fix it as follows: When the fetch dst register is being tracked for
>> precision, clear it and propagate precision over to the stack slot.
>> This is similar to how BPF_LDX handles loads from the stack.
>>
>> Before:
>>
>>    0: (b7) r1 = 8                        ; R1=8
>>    1: (7b) *(u64 *)(r10 -8) = r1         ; R1=8 R10=fp0 fp-8=8
>>    2: (b7) r2 = 0                        ; R2=0
>>    3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)          ; R2=8 R10=fp0 fp-8=mmmmmmmm
>>    4: (bf) r3 = r10                      ; R3=fp0 R10=fp0
>>    5: (0f) r3 += r2
>>    mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1
>>    mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10
>>    mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)
>>    mark_precise: frame0: regs=r2 stack= before 2: (b7) r2 = 0
>>    6: R2=8 R3=fp8
>>    6: (b7) r0 = 0                        ; R0=0
>>    7: (95) exit
>>
>> After:
>>
>>    0: (b7) r1 = 8                        ; R1=8
>>    1: (7b) *(u64 *)(r10 -8) = r1         ; R1=8 R10=fp0 fp-8=8
>>    2: (b7) r2 = 0                        ; R2=0
>>    3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)          ; R2=8 R10=fp0 fp-8=mmmmmmmm
>>    4: (bf) r3 = r10                      ; R3=fp0 R10=fp0
>>    5: (0f) r3 += r2
>>    mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1
>>    mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10
>>    mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)
>>    mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0
>>    mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1
>>    mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8
>>    6: R2=8 R3=fp8
>>    6: (b7) r0 = 0                        ; R0=0
>>    7: (95) exit
>>
>> Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
>> Fixes: 5ca419f2864a ("bpf: Add BPF_FETCH field / create atomic_fetch_add instruction")
>> Reported-by: STAR Labs SG <info@starlabs.sg>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> 
> Athough not related to this patch but it made me think about how the
> conditional semantics of CMPXCHG could interact with precision tracking,
> because the CMPXCHG could write to a stack slot or not depending on the
> comparison and that slot could later be used for precision tracking. But
> I found that although check_atomic_rmw() set's INSN_F_STACK_ACCESS in
> the flags, it also makes the stack slot STACK_MISC, therefore
> instruction reading from it will not have INSN_F_STACK_ACCESS so the
> precision tracking will stop there.

Yeap, there should be test coverage in patch 2/2 for this case to assert
the current behavior making sure we don't forget about this case when the
internals change.

> This patch looks correct to me.
> 
> Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
Thanks!
