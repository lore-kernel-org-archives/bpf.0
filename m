Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF77239A7F2
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 22:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774908146; cv=none; b=pql8Zgg4Eno6o6qy/bVd/Fpj8sTmIl4GllCJfMpwGhKA6OD+UAzJnqYDUE3o9pACRDHE27WbRJfFI0YG7NjofJrxLZg7dOyVAHjhVen8LTT4HJPeWWYsq4Jb+jMlyqD5S8CvTEmSv4nc32HmewQcGmzXp/uTai6iGbjZeELW7+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774908146; c=relaxed/simple;
	bh=su2Ux1NSofP7/5brJjvFHOsBB7N9m8VH55mHswF3VuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EyfFn4t+60zp7ckXi+uFIojTUR7qt+0ANoYkFiqZUkaNYufpf2TvJ42jY/2b/SUNTvDaGZ60WE5UTsoD1Ob7X+D28IDIVbS8XYVeO2+azvgKuogk8IRhumdAFfj3ozxkYdQfJn528vUVkxccItnFcPZDqeXSxjK6JRRoironzkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=HnBjCrQC; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="HnBjCrQC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Po9S1VaSXcBrDpQo8Thp3aMZZJiF9s0PLBqWNrxEc0Y=; b=HnBjCrQCx4J9dLpcRF7+OgoKuf
	EfIXuqRtxbTN5gc5VggqmDf95UcTE+TB7SzgJIGCW5RPYFVgD/ttseyyrVXkijkFOu/eW6fnVYxEj
	Mso7AantSMvlVkbAMaTjNMaAQPiFIFBpFVEL47lkSVj3wkPVilMcBDA0jV6wAJ7PO5lzr08CC4Mi+
	KJtZR4Oz8/1ry6soSiK5si7KYGNpcRfXpOfnFCt/7JaK9Or+YTO0z0aiP1qCKhD+238IhUZAOzS82
	6ShWlSQjTCMlxAmKGaGYRd8hf8pbcMw7Jj0UoQd+gaf+vzn4i4nTcHHpnXfkinIfzcrWCExy639rh
	s/0KUKcg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w7Kgg-000Pxi-1T;
	Tue, 31 Mar 2026 00:02:22 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1w7Kgg-000MaI-0x;
	Tue, 31 Mar 2026 00:02:22 +0200
Message-ID: <daa0bd35-5336-460c-8684-ef3c7d9bfe91@iogearbox.net>
Date: Tue, 31 Mar 2026 00:02:21 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/2] bpf: Fix incorrect pruning due to atomic fetch
 precision tracking
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 bpf <bpf@vger.kernel.org>, STAR Labs SG <info@starlabs.sg>
References: <20260330132750.377862-1-daniel@iogearbox.net>
 <CAADnVQ+DtTmz2Z1mCQu31PaJKrWgOjt3FGydPfJtserwqVbuvw@mail.gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <CAADnVQ+DtTmz2Z1mCQu31PaJKrWgOjt3FGydPfJtserwqVbuvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27956/Mon Mar 30 08:24:32 2026)

On 3/30/26 4:45 PM, Alexei Starovoitov wrote:
> On Mon, Mar 30, 2026 at 6:27 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
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
>> ---
>>   kernel/bpf/verifier.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index f108c01ff6d0..293aa957a5ff 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -4474,6 +4474,31 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>>                           * encountered a case of pointer subtraction.
>>                           */
>>                          return -ENOTSUPP;
>> +
>> +               /* atomic fetch operation writes the old value into a
> 
> kernel comment style pls.

Ok, will change. The comment style in rest of backtrack_insn is the
same, but if we're converging long-term to kernel style that's fine.

>> +                * register (sreg or r0) and if it was tracked for
>> +                * precision, propagate to the stack slot like we do
>> +                * in ldx.
>> +                */
>> +               if (class == BPF_STX && mode == BPF_ATOMIC &&
>> +                   (insn->imm & BPF_FETCH)) {
>> +                       u32 load_reg = insn->imm == BPF_CMPXCHG ?
>> +                                      BPF_REG_0 : sreg;
>> +
>> +                       if (bt_is_reg_set(bt, load_reg)) {
> 
> too much claude smell in here.
> remove unnecessary indent pls.
> 
>> +                               bt_clear_reg(bt, load_reg);
>> +                               /* atomic fetch from non-stack memory
>> +                                * can't be further backtracked, same
>> +                                * as for ldx.
>> +                                */
>> +                               if (!hist || !(hist->flags & INSN_F_STACK_ACCESS))
>> +                                       return 0;
> 
> too much copy paste. I bet above can be combine with the same line below.

I'll play around with removing indent and refactoring. It's a bit of a
mix between stx and ldx, closer to ldx actually. Worst case I'll have
this as a proper 'else if' case if it gets too convoluted in either of
the two.

>> +                               spi = insn_stack_access_spi(hist->flags);
>> +                               fr = insn_stack_access_frameno(hist->flags);
>> +                               bt_set_frame_slot(bt, fr, spi);
>> +                               return 0;
>> +                       }
>> +               }
>>                  /* scalars can only be spilled into stack */
>>                  if (!hist || !(hist->flags & INSN_F_STACK_ACCESS))
>>                          return 0;
> 
> Considering we're in rc6+, bpf-next is better.
Yeap, will do!

Thanks,
Daniel
