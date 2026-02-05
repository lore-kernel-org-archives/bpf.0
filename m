Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC4D254849
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 01:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770253713; cv=none; b=VlwyWUzmOVpPMZ7b+Mh9rTBuQX0pDHI+Hpuxu1Ybk3ZlOjPiDBuJyCi8VmCMibS7xiXwf8yaRiUcWkooCryMyRdL0z+SOAASgWW+C5V6CIvk3a1SdavdKaPHQjBbgMQ+jMgF3BWPdSjXJZcUW5pB+0sldkuFvDvs8DdhFNSHY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770253713; c=relaxed/simple;
	bh=lUpzawT/cI2Hl2egFbTnG2HOixMPZMnXe5mWldvCM5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6sLm+ZK/v+4YeXJhPxvjPLM/G+5JZ5m1rNE0J7Z37ZIQ0VA8OaoUUpmHmPJWSM9lFxLaGN2vV3c7m6p5OBHSZ398rDE1L1bIR4YzywQIsEPCeZfbe7K9XCR6+0Fynkc6n18HqB8BF2EezqHi3HcCwUf/17g4954+8Pej/3b1xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mmgeZqJz; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mmgeZqJz"
Message-ID: <4c125283-b5a4-47f2-be84-a932b50312ab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770253710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4P/A1lPY4sEdG9P6sQm+3NNXntitfvg5YGleJyTfow=;
	b=mmgeZqJzHX2fPGB6T1DgvLDN7j4Yx42TRkQ9GjYVoKneXxTpKlLgpTj9/mIqagnm5eWHEw
	RSOpCIVXEp3OFrWyhyPPpRzB2PDWWbzv6pR11tr1gAMNpKh0J7xmprFx2VSEE3OQxor06L
	bJoTZNjw4AWSOh/jHuqP8IwYvfk2K28=
Date: Wed, 4 Feb 2026 17:08:23 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 10/16] bpf: Support lockless unlink when
 freeing map or local storage
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org,
 kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 haoluo@google.com, kernel-team@meta.com, bpf@vger.kernel.org
References: <20260201175050.468601-1-ameryhung@gmail.com>
 <20260201175050.468601-11-ameryhung@gmail.com>
 <d512e9fd-eb04-4194-ab75-b1d2e775461a@linux.dev>
 <CAMB2axPMJe6hGeyaAXvzHKyap+9uoH=q66dtCTD-C4zioJa5DA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axPMJe6hGeyaAXvzHKyap+9uoH=q66dtCTD-C4zioJa5DA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/4/26 3:14 PM, Amery Hung wrote:
> On Tue, Feb 3, 2026 at 9:39 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 2/1/26 9:50 AM, Amery Hung wrote:
>>> +/*
>>> + * Unlink an selem from map and local storage with lockless fallback if callers
>>> + * are racing or rqspinlock returns error. It should only be called by
>>> + * bpf_local_storage_destroy() or bpf_local_storage_map_free().
>>> + */
>>> +static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
>>> +                                 struct bpf_local_storage_map_bucket *b)
>>> +{
>>> +     struct bpf_local_storage *local_storage;
>>> +     struct bpf_local_storage_map *smap;
>>> +     bool in_map_free = !!b;
>>> +     unsigned long flags;
>>> +     int err, unlink = 0;
>>> +
>>> +     local_storage = rcu_dereference_check(selem->local_storage, bpf_rcu_lock_held());
>>> +     smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
>>> +
>>> +     /*
>>> +      * Prevent being called twice from the same caller on the same selem.
>>> +      * map_free() and destroy() each holds a link_cnt on an selem.
>>> +      */
>>> +     if ((!smap && in_map_free) || (!local_storage && !in_map_free))
>>> +             return;
>>> +
>>> +     if (smap) {
>>> +             b = b ? : select_bucket(smap, local_storage);
>>> +             err = raw_res_spin_lock_irqsave(&b->lock, flags);
>>> +             if (!err) {
>>> +                     /*
>>> +                      * Call bpf_obj_free_fields() under b->lock to make sure it is done
>>> +                      * exactly once for an selem. Safe to free special fields immediately
>>> +                      * as no BPF program should be referencing the selem.
>>> +                      */
>>> +                     if (likely(selem_linked_to_map(selem))) {
>>> +                             hlist_del_init_rcu(&selem->map_node);
>>> +                             bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
>>> +                             unlink++;
>>> +                     }
>>> +                     raw_res_spin_unlock_irqrestore(&b->lock, flags);
>>> +             }
>>> +             /*
>>> +              * Highly unlikely scenario: resource leak
>>> +              *
>>> +              * When map_free(selem1), destroy(selem1) and destroy(selem2) are racing
>>> +              * and both selem belong to the same bucket, if destroy(selem2) acquired
>>> +              * b->lock and block for too long, neither map_free(selem1) and
>>> +              * destroy(selem1) will be able to free the special field associated
>>> +              * with selem1 as raw_res_spin_lock_irqsave() returns -ETIMEDOUT.
>>> +              */
>>> +             WARN_ON_ONCE(err && in_map_free);
>>> +             if (!err || in_map_free)
>>> +                     RCU_INIT_POINTER(SDATA(selem)->smap, NULL);
>>> +     }
>>> +
>>> +     if (local_storage) {
>>> +             err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
>>> +             if (!err) {
>>> +                     /*
>>> +                      * Normally, map_free() can call mem_uncharge() if destroy() is
>>> +                      * not about to return to the owner, which can then go away
>>> +                      * immediately. Otherwise, the charge of the selem will stay
>>> +                      * accounted in local_storage->selems_size and uncharged during
>>> +                      * destroy().
>>> +                      */
>>> +                     if (likely(selem_linked_to_storage(selem))) {
>>> +                             hlist_del_init_rcu(&selem->snode);
>>> +                             if (smap && in_map_free &&
>>
>> I think the smap non-null check is not needed.
> 
> While smap is still valid in map_free(), SDATA(selem)->smap could have
> been init to NULL, and then mem_uncharge() will dereference a null
> pointer.

hmm... there is a "if ((!smap && in_map_free) || ...)) return;" at the 
beginning of the function, but may be the next revision will need this 
check though if it does not depend on "!smap" to decide the second visit.


>>
>>

