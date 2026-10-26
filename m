Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039797;
	b=k3Do5cnt74yAa0h9giMMEXnTZI9GOY0POBsCY92U3LlF/FcvgKspyNq88Wz0joBT756p
	 zg1IBxOHl/cx7tQ+pIDXVa6j6Tn4Xb0Le/3BGg2hPAYmmwb1cCx2beWdqN7mZvFwJSiOk
	 NJ6t+LJCnKo5CA+it51P86MA0SQZSpBp8S1yKv7ap226Cr4ibdcnkt6y3Fvz3mSTiw6cf
	 PrJ5oJFPXtMhSdgaFYHxz2iCsgDLYRyjkIey4AmHeOLUH3T6gEVdwEXpnD8SxGVNcVEf3
	 IfmCZKVtwZnrywilwUJjWo2MUakKO+3t8TlRzFzmrEsh7K5oNp5/EJPX7h9+yBVGF6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039797;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=EicdVyt3cuI1JNRmtgirZBSbKkrRIqYDXX+D7aKA+VQ=;
	b=kJ8Cnc82V+/btKtEdvOK17QjQCfqserjtH6avWot/uTlPNhP8x65PhTRIJ5CLOmaYlSc
	 qqVMAAXVUyXpNdHR8mZRlXSkpfpYNKuN6c1BTS1sftcXzy81jLN9DyNdSQCaTtv4jnnq8
	 K0nw5L5XCvDkVB1pzDF41YfK4sABZOZtbr3vf3sQ1ZU+VSjnazlK5+DtWD2RCN+jh6bg3
	 dw197T7lnsUakUsqoO4X4CVAbGdLT3RZd3Y2IOlTWsqaUdL+IPYnlrUNkz35ZItdUcsfy
	 7TGk1Smyt1+qNIfViaOdbNr23nKEr6wxb1FuTRaN67yZ51bvyAQVbWKa354o6JSAZcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cvx8D4lz;
	arc=none smtp.remote-ip=91.218.175.151
Received: from mta0.migadu.com (out-151.mta0.migadu.com [91.218.175.151])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7238F60A260E
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 18:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7238F60A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cvx8D4lz
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=O7bendn+vz7GZlgufTDXpvtWbXs4Nv+hlyvLUyv9A6g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793039794; v=1; x=1793644594;
 b=cvx8D4lzMyNaE6VlzcBxxkQd5kfu5UCI2Rb5Kl+44DEufBBxpibKx+V7R7tEFrYS2IhTxW+J
 xRcvKn3gyJ1vU4/sIsbyXH/U5d8ij4x3fkLemVRjPbpBC4HaMfy9/gB4ECfUxyRstJWjqYyCO0Z
 95oOFDan1D30a+pVk6VtBCn0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id efd915cbd3990552;
	Mon, 26 Oct 2026 18:36:34 +0000
X-Mizu-Trace-ID: efd915cbd3990552
X-Migadu-Flow: FLOW_OUT
Message-ID: <2a2d0450-01f5-4a87-9e4b-7ebecdbf165a@linux.dev>
Date: Mon, 26 Oct 2026 11:36:23 -0700
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
Subject: Re: [PATCH bpf-next v3 05/12] selftests/bpf: Cover the low-32 link
 for zero-extending movs
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20261020161907.2115379-6-vineet.gupta@linux.dev>
 <3e177386ed0ff37815ee705fb2cb8195952b4301858e4ff4e2b4638d14d94c3d@mail.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <3e177386ed0ff37815ee705fb2cb8195952b4301858e4ff4e2b4638d14d94c3d@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/26 9:53 AM, bot+bpf-ci@kernel.org wrote:
>> selftests/bpf: Cover the low-32 link for zero-extending movs
> TL;DR:
> - Selftest comment calls the mixed-kind no-sync case unsound, but the program
>    is safe; it is only lost precision
> - Commit message says "Twelve" programs, but there are thirteen
>
>>      selftests/bpf: Cover the low-32 link for zero-extending movs
>>
>>      Twelve programs, one per decision the previous patch makes:
>>
>>       - zext_mov_narrow_src: narrowing the source reaches the destination
>>       - zext_sync_makes_member_const: and over all 64 bits, since the member
>>         is the zero-extension
>>       - zext_narrow_dst_keeps_base: the reverse must not happen
>>       - zext_u32_src_is_full_link: a provably-u32 source still propagates
>>       - zext_self_mov_no_link: a self-mov mints no id
>>       - zext_chain_drops_link: a second 32-bit mov drops the link
>>       - zext_no_sync_between_mixed_kinds: differing kinds do not reach each
>>         other, in either direction
>>       - zext_no_sync_from_subreg_base: nor does a member reach a base whose
>>         high half it knows nothing about
>>       - zext_sync_between_two_subregs: two low-32 links on one base do
>>       - zext_unlinked_path_stays_reachable: one unlinked path keeps the
>>         guarded div reachable
>>       - zext_mov_breaks_linked_src: forming the link drops the source's own
>>       - zext_sync_keeps_narrower_member: narrowing the base does not widen a
>>         member that already proved itself tighter
>>       - zext_contradiction_keeps_range_sane: a contradiction leaves no empty
>>         range behind, under BPF_F_TEST_REG_INVARIANTS so the violation is a
>>         load failure rather than something only dmesg sees
>>
>>      Written in asm so the bytecode is the same whichever compiler built the
>>      suite.
>>
>>      Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> The changelog says "Twelve programs", but the list below it has thirteen
> bullets, and the patch adds thirteen programs:
>
> zext_mov_narrow_src, zext_sync_makes_member_const,
> zext_contradiction_keeps_range_sane, zext_narrow_dst_keeps_base,
> zext_u32_src_is_full_link, zext_self_mov_no_link, zext_chain_drops_link,
> zext_no_sync_between_mixed_kinds, zext_no_sync_from_subreg_base,
> zext_sync_between_two_subregs, zext_sync_keeps_narrower_member,
> zext_unlinked_path_stays_reachable and zext_mov_breaks_linked_src.
>
> The count looks like it was not updated when
> zext_contradiction_keeps_range_sane was added.  It is the last bullet, but the
> third program in the file.  Should "Twelve" be "Thirteen"?

Yes there was a last minute test update and this missed the update.

>> diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
>> --- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> [ ... ]
>
>> @@ -710,4 +710,352 @@ l_exit_%=:							\
> [ ... ]
>
>> +/*
>> + * Two members of one id set carrying different link kinds do not propagate
>> + * to each other: r7 is (u32)base and r8 is base + 3, and the deltas were
>> + * added at different ALU widths, so narrowing r8 says nothing about r7.
>> + * sync_linked_regs() declines the pair on the kinds before the deltas are
>> + * ever consulted. Note neither register is the base -- that is r6.
>> + */
>> +SEC("socket")
>> +__failure __msg("div by zero")
>> +__naked void zext_no_sync_between_mixed_kinds(void)
>> +{
>> +	asm volatile ("						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r6 = r0;						\
>> +	w7 = w6;		/* forms the link */		\
>> +	r8 = r6;						\
>> +	r8 += 3;		/* r8 is BPF_REG_LINK_FULL, r7 is BPF_REG_LINK_ZEXT */	\
>> +	if r8 != 3 goto 1f;	/* must not propagate to r7 */	\
>> +	if w7 == 0 goto 1f;					\
>> +	r0 /= 0;						\
>> +1:								\
>> +	r0 = 0;							\
>> +	exit;							\
>> +"	:
>> +	: __imm(bpf_get_prandom_u32)
>> +	: __clobber_all);
>> +}
>                  ^^^^
>
> This isn't a bug, but is the comment accurate for this direction?  It says
> narrowing r8 "says nothing about r7", and the asm comment says the narrowing
> "must not propagate to r7".
>
> r8 is a BPF_REG_LINK_FULL member, so r8 == r6 + 3 over all 64 bits.  That
> relation inverts exactly, so knowing r8 pins the base, and r7 == (u32)(r8 - 3)
> follows.
>
> In this program the fall-through of "if r8 != 3 goto 1f" forces r6 == 0, so
> r7 == 0, "if w7 == 0 goto 1f" is always taken, and "r0 /= 0" cannot be reached
> at runtime.  The program is safe.  The verifier rejects it only because
> sync_linked_regs() skips every pair with differing kinds:
>
>      if (reg->link_kind && known_reg->link_kind &&
>          reg->link_kind != known_reg->link_kind)
>              continue;
>
> That check exists for the other direction, a ZEXT known_reg against a FULL
> member (scalars_alu32_alu64_cross_type), where the 32-bit wrap really does
> break the relation.  If the differencing arm ran for known=r8 (FULL, delta 3)
> and reg=r7 (ZEXT, delta 0), it would compute r8 + (0 - 3) and then
> zext_32_to_64(), which gives exactly (u32)(r8 - 3).  That is sound.
>
> So this test pins a deliberate loss of precision, not a soundness requirement,
> but the comment presents it as unsound.  The text is unchanged at the tip of
> the series.  Someone who later makes the verifier propagate FULL -> ZEXT will
> see this test fail, and the comment will suggest the improvement is wrong.
>
> zext_chain_drops_link and zext_mov_breaks_linked_src also reject runtime-safe
> programs, but their comments say the link is dropped by rule.  Could this one
> be worded the same way, for example "sync_linked_regs() declines mixed kinds
> even where, as here, the relation would hold"?

Yes this is correct as well, I'll update the comments.

Thx,
-Vineet

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39458500836

