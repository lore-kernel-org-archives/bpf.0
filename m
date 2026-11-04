Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825719;
	b=i8ab0NHN1BaxddVCYhfzc3jiZmS/j+8RB+wAPG60PwnyFK0rtHr0q7JG7+TGg2UKORFn
	 QdGbB+YQQgLHFHWD9HOljvhyadf6lJ8qjh6X+Nwh4tG/HyCXMSnWDzGRlBkNghsAXsTE6
	 l0mDVFgj/hNr1pcKB70M8JplEsHQFN/ehPjx+UVvT30W2QuB8TOeF0sOfrTp45piTd2eq
	 MDXD+RcbLg7pZbFt7fvLzS+pP8+nDkeBHtWXFNvpjkga6gcfM8wsXo0puUqUH1BOe3WDL
	 q/91uxhU/nYz1WMXC8L1wR5v3tNqbV2pUewaZmYBgHfcDw7FJgDi1yCz187dogUHCrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825719;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=MT1dhAso7qHFLq0iaAatVFL/NEYT/vU7az8cSYFYlWo=;
	b=zsJ/zV9dEAnOewsoojZlRH6G9298ZjMJQfWh8XzRrqKoLxfoxT6lXiYek/jnNJ+S9KYN
	 5UI8/fGDMUkI3jfbHcSdT9mrYVv27BR3VP4mYxj/FwDJZXi/3XloLQY1v23zIrcyYTJo5
	 RYxAzHx4+ejOxt+Ywgdu0QmX8XG2YMn6PAejpQemfhwLzg9bzdBx6WArGPNWLPZ/1QY3+
	 c/hKE7BN4e55JWvJJpLSgxKg30SH50joHPLirXulqbgp5p+fWJjgxdH8YJ82IN/cIHKtF
	 T7LAdo4rfqQ5w13jlsZSye8I4GAIfOyNCgPaHj9kXjTZuOvnaMfo3eh09hYjcp5Z65A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="DK9/ESoS";
	arc=none smtp.remote-ip=91.218.175.149
Received: from mta0.migadu.com (out-149.mta0.migadu.com [91.218.175.149])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AB6606C922
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 20:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4AB6606C922
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DK9/ESoS
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2wHMPTNxJIGUJZhji4UnCl9+7oU4WjoytLuAWQg1w+c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793825715; v=1; x=1794430515;
 b=DK9/ESoSRBbJt40I6JdgstrbTeYHFNBS8FiCeOmoR4tLcLrRIUQdC04yZoEtc6Ipn+jsuKLK
 EZGA+yzknAfdGWDlQHB02DgVhkjHICqvk2gLSRw/mqK2H7PyVXvJXjjC8xVjr5wSufC36cTRXTS
 YDgSOZUXdQLybE/clptATy/g=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e97d27abcf91b971;
	Wed, 04 Nov 2026 20:55:12 +0000
X-Mizu-Trace-ID: e97d27abcf91b971
X-Migadu-Flow: FLOW_OUT
Message-ID: <1bb8be94-400c-4c81-a4ce-84e4f78387c8@linux.dev>
Date: Wed, 4 Nov 2026 12:55:08 -0800
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
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20261020161907.2115379-1-vineet.gupta@linux.dev>
 <20261020161907.2115379-4-vineet.gupta@linux.dev>
 <49019042b63d5718a9419e8fac035cf9104ae8bf.camel@gmail.com>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <49019042b63d5718a9419e8fac035cf9104ae8bf.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/26 3:51 PM, Eduard Zingerman wrote:
> On Tue, 2026-10-20 at 09:18 -0700, Vineet Gupta wrote:
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
>> ---
> Nice refactoring.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Thx.

> ...
>
>> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
>> index 5432c0fc442b..a6f205653a9e 100644
>> --- a/kernel/bpf/log.c
>> +++ b/kernel/bpf/log.c
>> @@ -651,8 +651,8 @@ static void print_reg_state(struct bpf_verifier_env *env,
>>   		verbose(env, "%s", btf_type_name(reg->btf, reg->btf_id));
>>   	verbose(env, "(");
>>   	if (reg->id)
>> -		verbose_a("id=%d", reg->id & ~BPF_ADD_CONST);
>> -	if (reg->id & BPF_ADD_CONST)
>> +		verbose_a("id=%d", reg->id);
>> +	if (reg->link_kind)
>>   		verbose(env, "%+d", reg->delta);
> Nit: it would be nice to see if the link is full or zext.

Done in v4.

>>   	if (reg->parent_id)
>>   		verbose_a("parent_id=%d", reg->parent_id);
>> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
>> index 48500d73105a..f0aa314233c8 100644
>> --- a/kernel/bpf/scev.c
>> +++ b/kernel/bpf/scev.c
>> @@ -2285,7 +2285,7 @@ static void scratch_widened_reg_id(struct bpf_verifier_env *env, struct bpf_reg_
>>   {
>>   	switch (base_type(reg->type)) {
>>   	case SCALAR_VALUE:
>> -		reg->id = 0;
>> +		bpf_clear_scalar_id(reg);
>>   		break;
>>   	case PTR_TO_PACKET:
>>   	case PTR_TO_PACKET_META:
>> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
>> index 953700822fa7..a1b90a31747a 100644
>> --- a/kernel/bpf/states.c
>> +++ b/kernel/bpf/states.c
> ...
>
>> @@ -574,13 +561,14 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>>   		 * Linked register tracking uses rold->id to detect relationships.
>>   		 * When rold->id == 0, the register is independent and any linking
>>   		 * in rcur only adds constraints. When rold->id != 0, we must verify
>> -		 * id mapping and (for BPF_ADD_CONST) offset consistency.
>> +		 * id mapping and that the link kinds agree, along with any delta
>> +		 * they carry.
>>   		 *
>>   		 * +------------------+-----------+------------------+---------------+
>> -		 * |                  | rold->id  | rold + ADD_CONST | rold->id == 0 |
>> +		 * |                  | rold->id  | rold linked kind | rold->id == 0 |
>>   		 * |------------------+-----------+------------------+---------------|
>>   		 * | rcur->id         | range,ids | false            | range         |
>> -		 * | rcur + ADD_CONST | false     | range,ids,off    | range         |
>> +		 * | rcur linked kind | false     | range,ids,delta  | range         |
>>   		 * | rcur->id == 0    | range,ids | false            | range         |
>>   		 * +------------------+-----------+------------------+---------------+
> Nit: "linked kind" -> "link_kind".
>       also, the table should show when link_kind equality is required.
> ...

Done as well. I'll carry the Ack.

Thx,
-Vineet
