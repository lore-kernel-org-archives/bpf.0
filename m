Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055156;
	b=ITAxd8KFZzw8Fx08pGpBOwNZxMnwvCyyIJEBTObpJH7eub12JRkbz3EHFuwjAz61qKx1
	 TYlOMaKRl+LeenDNiCA7mDRpX36XAUWwfFGvypwMwx9ab0WQ10vQ/y5pKHLLhjQs/6Y2W
	 SZayb6xrOE+74hDSOLHn1SLDz5hyO+927+GmjQsDGQYu2gn3yVjYEVkcgxO/kOduHD6m8
	 WvI1oS7AIx+gLWhr6Bv08LTnjQl5vjC8uPX9etaRS4Tmyo7cjFKeEWGcdn9FJ4OccAISL
	 xkrBN5dnhgjkMUJMZ7xk4Nl+WuCdyoXO/rW5tUIZxt9PG1pEBCMDZcej6RIb9Z9/ghA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055156;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=zKAIbj4E71O6v5DHc3HNYXOZPG7g4zgY8frqPiT/8xg=;
	b=whkhNR64WMlMdf2Fjvl3nExzpmMvSvTBF0h8TXnCTBYvRalnYHkor7ckyx/+8m0/q3VS
	 YaD/A3a5Tb+bgDEGQCBs5+3s0+6YNgTVi4NToU9kBEnXRIwrHwUSYovEJj+mfNBEU98P/
	 NFakbgjRruHdtTLp3/sl8UnhXjA1RbD24jVUFlWZbfMVN47ZWG05KESRxUSmT8Zi6ysJn
	 utTmcPyN72zpMsBfSkoEPI/puLRHkNmbPyOvJGrQGITLdNfVHbCj8z4zuH96NY2XKcCRG
	 f8nMiUR7WqKUujiar94DFKkBgv4mqZWgKniF4PABj4ysB7xhkZXjEy0HDfYfwsmO8PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gUrpU0Eo;
	arc=none smtp.remote-ip=91.218.175.19
Received: from mta0.migadu.com (out-19.mta0.migadu.com [91.218.175.19])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CD8606A31D
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 22:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82CD8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gUrpU0Eo
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Z8funXGuTqu+er/8n1etAxsCUdLvAe+wEnAdyvy1xIQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793055153; v=1; x=1793659953;
 b=gUrpU0Eorbs3yADq20OuUJ7ELWR1tyFJ+LDvKwMuyQpFrqTSU6y/Ga3rr2eRJExL112ljoBK
 CBDS18LKpncnGqrL17DH+Rt/TZFhErtsCsIDHiZxBsUl+EyNZidCBF4VGY4K8KRPnDeJMnJ73gh
 S56GBVe9pUh+oJxrFhd2MMI0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 76e094ffeec065c5;
	Mon, 26 Oct 2026 22:52:33 +0000
X-Mizu-Trace-ID: 76e094ffeec065c5
X-Migadu-Flow: FLOW_OUT
Message-ID: <66f1317a-4107-4e31-a3cb-6378fc63d07d@linux.dev>
Date: Mon, 26 Oct 2026 15:52:24 -0700
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
Subject: Re: [PATCH bpf-next v3 03/12] bpf: Prepare linked scalars for
 relations narrower than 64 bits
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20261020161907.2115379-4-vineet.gupta@linux.dev>
 <443e1351eed4f46cf6c202e5f1130b189e9c5eb09cfcffd24d752c6ec73d450c@mail.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <443e1351eed4f46cf6c202e5f1130b189e9c5eb09cfcffd24d752c6ec73d450c@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/20/26 10:08 AM, bot+bpf-ci@kernel.org wrote:
>> bpf: Prepare linked scalars for relations narrower than 64 bits
> TL;DR: Commit message only: regs_exact() now also rejects states whose linked
> scalars share a base id in old but not in cur, a stricter infinite-loop check
> the changelog doesn't mention.
>
>> bpf: Prepare linked scalars for relations narrower than 64 bits
>>
>> Two scalars sharing an ->id are always related by full 64-bit equality
>> today: reg == base + delta over all 64 bits (this is true for
>> BPF_ADD_CONST32 as well, which implies upper bits to be all zero).
>> Sign-extension needs a genuinely low32 equal only relationship kind
>> with bit 31 supplying upper 32-bits.
>>
>> Today the following 2 relationships exist
>>
>>    #define BPF_ADD_CONST64 (1U << 31)
>>    #define BPF_ADD_CONST32 (1U << 30)
>>
>> Model them differently as
>>
>>    enum bpf_reg_link_kind { BPF_REG_LINK_NONE, BPF_REG_LINK_FULL,
>>                             BPF_REG_LINK_ZEXT, BPF_REG_LINK_SEXT };
>>
>> So BPF_ADD_CONST64 becomes BPF_REG_LINK_FULL and BPF_ADD_CONST32 becomes
>> BPF_REG_LINK_ZEXT with the exact same semantics as today. But this paves
>> the way for a future BPF_REG_LINK_SEXT in the same framework.
>>
>> The implementation needs to change as well. Today the above 2 bits are
>> shoe-horned into ->id, needing masking and OR'ing to get ->id and kind
>> bits: with more types and bits needed, move them out into an enum
>> bitfield of its own. To avoid growing the storage (and stay within the
>> 1K allocator bucket), borrow 2 bits out of ->map_uid, 31 -> 29, which is
>> still far more ids than a program can generate.
>>
>> ->id becomes a plain identifier, so check_scalar_ids() loses its "compare
>> the compound id, then the base id" dance in favour of one check_ids().
>>
>> With the kind out of ->id it also leaves the idmap key, so regs_exact()
>> and regsafe()'s explore_alu_limits arm have to compare it explicitly.
>>
>> One case changes behaviour -- old {r2.id=A+delta32} against
>> cur {r2.id=B+delta64} was accepted and is now rejected, correctly, since
>> alu32 and alu64 deltas diverge in sync_linked_regs().
>>
>> Clearing a link is no longer just ->id = 0: any stale ->link_kind needs
>> to be cleared out as well. And given this needs to be done in the newly
>> added kernel/bpf/scev.c, it is moved into bpf_verifier.h as
>> bpf_clear_scalar_id().
>>
>> The helper also zeroes ->delta, which the open-coded clear left behind.
>> Unlike ->id that field is inside the memcmp() prefix state comparison
>> uses, so a leftover value could keep two otherwise-identical states
>> apart; clearing it can only help pruning.
>>
>> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
>> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> The changelog lists only the delta32/delta64 mismatch as a case that changes
> behaviour.  Is that the only one?
>
> regs_exact() also changes.  It used to run check_ids() on the compound id,
> so old {r2.id=A, r3.id=A|BPF_ADD_CONST64} against cur {r2.id=B,
> r3.id=C|BPF_ADD_CONST64} built two independent idmap entries (A->B and
> A|flag->C|flag) and was accepted as exact.
>
> With the kind moved out of ->id, the same pair now maps A->B and then A->C,
> and check_ids() rejects it:
>
>      return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
>             rold->link_kind == rcur->link_kind &&
>             check_ids(rold->id, rcur->id, idmap) && ...
>
> regs_exact() is reached through regsafe(..., EXACT) from the infinite loop
> check in bpf_is_state_visited():
>
>      states_equal(env, &sl->state, cur, EXACT)
>
> so this is a stricter comparison than before.
>
> Could the changelog also say that regs_exact() now enforces base-id
> consistency for linked scalars, which the old compound-id idmap key did not?

Right. The example you mention is new.

Basically v2 had a patch of its own on this topic and it listed two cases

     old {r1.id=A, r2.id=A+delta}  vs cur {r1.id=B, r2.id=B}
     old {r2.id=A+delta32}         vs cur {r2.id=B+delta64}

Both were same category: one register whose kind differs between old and 
cur, caught by the new
rold->link_kind == rcur->link_kind line.

What you mention here is a different scenario:

     old {r2.id=A, r3.id=A|BPF_ADD_CONST64}
     cur {r2.id=B, r3.id=C|BPF_ADD_CONST64}

kinds match but it is still rejected, by check_ids().

v4 mentions both mechanisms.

Thx,
-Vineet

> --
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39458500836

