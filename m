Received: from mta0.migadu.com (out-102.mta0.migadu.com [91.218.175.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930373D891F
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593741; cv=none; b=P3veBACO9LYYh7Lym1omcbN1Um0apLrRqr4SqG7US78tB2JJJpHimoSaFo0SUlsi3lg1Kh8PNeHyzgEQbRyCmHXKOFvluU/eES7ZOGdEg3b0z/LCgYG3bdrtYY3ii0yFGqBB5es9nRvmKFv6Yco9a2OvCje9z+KDU8qtcQzSPjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593741; c=relaxed/simple;
	bh=TKqfw40iLLCdcqUk+pf6hQQvVP/pt7DLVj4/paVDPE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pKh2VC/F3Ib5LiUVnMJmeGnyKisOdvxLImdbJcYOdLVypbp08qKQlY5m6sZTjB096FTypneRkespGlAD+E2oeqg7Zy8gnxM3LKZO4Y7NlR089t0p+PGw6I7uVelxLnQB+TBrpZP3cRrgBY3LOXky11YZauz3/SOxB+dTbO2akjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YftSTz39; arc=none smtp.client-ip=91.218.175.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YftSTz39"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TKqfw40iLLCdcqUk+pf6hQQvVP/pt7DLVj4/paVDPE8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789593722; v=1; x=1790198522;
 b=YftSTz39qvJWfHwAumN910fcSnrRrQrU2o5E+DSzwz7mpO7e1iwrVPYiz/G8+xn4VoJZBp0a
 jjUjJBfKqrhIzV6Nyp+vXtb27CxH+y9SjaHcwzAjjUFLjRUOiLAnEaQeiDR/o+PuDlRaxqXKD+A
 /9kWrcKOi1tzM7DChkpSHQdg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5d1bf85c37014b36;
	Wed, 16 Sep 2026 21:22:02 +0000
X-Mizu-Trace-ID: 5d1bf85c37014b36
X-Migadu-Flow: FLOW_OUT
Message-ID: <e4faecf5-8734-4c5f-9fb4-72886d80ec2b@linux.dev>
Date: Wed, 16 Sep 2026 14:21:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 01/13] bpf: move linked-scalar flags out of
 bpf_reg_state->id [NFC]
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bot+bpf-ci@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20260910164635.459558-2-vineet.gupta@linux.dev>
 <6ba21fcb39349c144c340d3605e25a30710ff43c5ea0c53045e78f4408411fdd@mail.kernel.org>
 <4cddd4a4-d684-46c9-862e-5708797f399d@linux.dev>
 <DLH1N1KP02XT.1KJ79QEMQORI2@gmail.com>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <DLH1N1KP02XT.1KJ79QEMQORI2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/26 2:03 PM, Alexei Starovoitov wrote:
> On Mon Sep 14, 2026 at 6:02 PM UTC, Vineet Gupta wrote:
>>
>> On 9/10/26 11:22 PM, bot+bpf-ci@kernel.org wrote:
>>>> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
>>>> index 66fb11b6c6a7..d974baad37ee 100644
>>>> --- a/kernel/bpf/states.c
>>>> +++ b/kernel/bpf/states.c
>>> [ ... ]
>>>
>>>> @@ -369,13 +369,6 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
>>>>     * and r7.id=0 (both independent), without temp IDs both would map old_id=X
>>>>     * to cur_id=0 and pass. With temp IDs: r6 maps X->temp1, r7 tries to map
>>>>     * X->temp2, but X is already mapped to temp1, so the check fails correctly.
>>>> - *
>>>> - * When old_id has BPF_ADD_CONST set, the compound id (base | flag) and the
>>>> - * base id (flag stripped) must both map consistently. Example: old has
>>>> - * r2.id=A, r3.id=A|flag (r3 = r2 + delta), cur has r2.id=B, r3.id=C|flag
>>>> - * (r3 derived from unrelated r4). Without the base check, idmap gets two
>>>> - * independent entries A->B and A|flag->C|flag, missing that A->C conflicts
>>>> - * with A->B. The base ID cross-check catches this.
>>>>     */
>>>>    static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
>>>>    {
>>>> @@ -384,15 +377,7 @@ static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
>>>>
>>>>    	cur_id = cur_id ? cur_id : ++idmap->tmp_id_gen;
>>>>
>>>> -	if (!check_ids(old_id, cur_id, idmap))
>>>> -		return false;
>>>> -	if (old_id & BPF_ADD_CONST) {
>>>> -		old_id &= ~BPF_ADD_CONST;
>>>> -		cur_id &= ~BPF_ADD_CONST;
>>>> -		if (!check_ids(old_id, cur_id, idmap))
>>>> -			return false;
>>>> -	}
>>>> -	return true;
>>>> +	return check_ids(old_id, cur_id, idmap);
>>>>    }
>>> [ ... ]
>>>
>>>> diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
>>>> index d571fbfc86a3..da6cb961a520 100644
>>>> --- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
>>>> +++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
>>> [ ... ]
>>>
>>>> @@ -648,10 +648,10 @@ l_exit_%=:							\
>>>>    }
>>>>
>>>>    /*
>>>> - * Test that regsafe() verifies base_id consistency for BPF_ADD_CONST
>>>> + * Test that regsafe() verifies base_id consistency for ADD_CONST_*
>>>>     * linked scalars during state pruning.
>>>>     *
>>>> - * The false branch (explored first) links R3 to R2 via ADD_CONST.
>>>> + * The false branch (explored first) links R3 to R2 via ADD_CONST_64.
>>>>     * The true branch (runtime path) links R3 to R4 (unrelated base_id).
>>>>     * At the merge point, pruning must fail because the linkage topology
>>>>     * differs.
>>> Does this comment still match what the code does? The patch removes the
>>> "base_id" concept from kernel/bpf/states.c (deleted the paragraph that
>>> defined it, removed the two-level compound/base id check from
>>> check_scalar_ids), but the comment here still describes the test as
>>> verifying "base_id consistency" and refers to "unrelated base_id" on the
>>> next line.
>>>
>>> Looking at the function name and __description below:
>>>
>>>>     */
>>>>    __description("add_const base_id must be consistent for pruning")
>>>>    __failure __msg("invalid variable-offset")
>>>>    __naked void add_const_base_id_pruning(void)
>>> and later at line 695:
>>>
>>>>    	/* Runtime: R2.id=A, R4.id=C: base_ids A vs C inconsistent,
>>>>    	 * pruning should have failed. */
>>> Should these be updated to use current terminology, or does "base_id"
>>> still have meaning in this context? The test itself still works correctly
>>> after the patch, so this appears to be a documentation consistency
>>> question rather than a functional issue.
>> Indeed base_id as a term is gone, but just id alone might be confusing
>> as well.
>> How about link id as a replacement for base_id
> I don't think "link id" fits either. Just use id.

SG !

Thx,
-Vineet
