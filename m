Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB8A23C503
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769540826; cv=none; b=kCdoGS781mi1BEK/Pz7cGIWKlabgKo+479XwaF+DQ7BFwyfYedeorWPQq4exr3pYkTdN9Ha8ZDaeK6O7atpZ2Y90l/0Iin8YC3ye50rxifaunLda+SV+DCpU0OlCpu7HNz3YClZf10RH1qTBIG4iagaDXLv/mTPS+wdYiyacUPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769540826; c=relaxed/simple;
	bh=FqVkiqS9rd727usiavtaBldcChihlNxSJdQkx5eLni4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4w3scO7JIdrBG9w3MOnQ+W2K9IJ0PW+mbWf5HvulcHrQxI52YiNbK4FKbBsIiw/58BcnrbK9jwlAHMfOrNpiT1hBK8U7Dk5bFtiRHALSofuvXpzICHKiW2/AMhhkg9xujaKy6hT0qXWcyQ8KF1N0dl29cqdQ6ZBSv+nL6VPxgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2rgn1Cr; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2rgn1Cr"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43246af170aso102647f8f.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 11:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769540823; x=1770145623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hUGAgqQ38zIXAYKYCeaxIKZeDwSnTqOgRfXtiSfl/WE=;
        b=P2rgn1CrJ1Jvf8TFmEwEzeoWY9JroTdgp99iP3XmJ/FVY49rZyOH7T4nfufsVCbZJa
         IT9WenAKfbnOeB9yMXjl9R40L8N38kpAvsd2fxYywOWMhzH1G6EyQBsgDWnzBfr8XFkp
         TPVOMrTLijnlP1ojl2MQWH9MqQbIdjdV5y4QgAu1g4U0XbFCd902wkDqS8PHjtBr9+wk
         E9GRx41gmtgmgzWk/dc3+y5BL1wLS38C2RfLjUwvJ2bAHdJofMwocnR3lZv3Sb0+cC3m
         1bfbR4OAbJdYZPH1+tjrULUUu88QnYgwq9mIb3eKcWPv7Dgwneo1p85PuEY9HNfMLbbP
         g+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769540823; x=1770145623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUGAgqQ38zIXAYKYCeaxIKZeDwSnTqOgRfXtiSfl/WE=;
        b=JbdsgpS0sd76HFTyehoUpl92CIS4zah5mKV6DMFJb73DEZG3MB0Uy/+JpBreLo9Qfe
         UKmOkXI+9YYEIbrazMc6+Z1gfzomuGpWEVje1Ook8MoIDtn1673EnQzdh39KZH9fczgS
         v4k+KI+AOW+Yg0MWjJAlaQMk+JkgjEebtmvQmghD8hqrlpUSERiJJP4ziFLkxkAQFzOe
         XFI56OhOxcEFa9jPGhISNWK9vXR/3KG72ua28I/CG+ylPH9QRAFKesVcf70aFtSBvU6p
         hrpdQ3Sn1W4sCy670pDweqt2perfy5eGkv5I7srOZUvO5wk6lpRYmXhxBn+KRd9Hf7/F
         U2Cg==
X-Gm-Message-State: AOJu0YxqRcEkJc2EPq4EnsJRCu7brRerp63yCKwmKAPZFWhj41Zf7ttR
	SRz7TBImOTA0V0OUhDdNJPvM4r8VQcwemQzaooVn2G94Vo7P4ZMOgfN1
X-Gm-Gg: AZuq6aJ8cb0a+iTBEP0OxIH9H6lF8nQPM4kIy9xX0iWlywhFHLfpdjVF8mxm0Hog1n4
	UgsQ9TYmbMcCEFVOWOaHDyjlcN9TLB0R6uNs/boCvWRnvCzOzRKUHGZDsYcElBxvcaz3kn8t2oJ
	Y9ukrrRtnRhSyjR2juaQboe1xbubmmkvkAYjg7Xid0cuXX7zhngrUBvhwq1vF32IQcFDi9o4yN1
	u8bLl1zUKN8NaC0SKWOs3LH0bPJJrpGCowsqk8QCuan2URxIJ0gpWuJHEqlZ6J6YEss/qzH+Kpf
	p1hJEfRb/rkgyAJ/onQ23voSkta+BNEH0bPhdZnM0HnUmuHCDmFIYa91WnWcN+sTiiuOICNd/iW
	sXZ7vp9MACzLbPncVYILz2aioBdoWve2HrUIvzatfbI6Sf6w6oXxiF97GJa1blQyP5d4Nrd4up7
	sC8jPLTlPG1VAI6r+KSJju8MnDGepG22GzSKP6HgW69A5iTeM=
X-Received: by 2002:a05:6000:2483:b0:429:cb8b:b58e with SMTP id ffacd0b85a97d-435dd22fc21mr4840759f8f.28.1769540823271;
        Tue, 27 Jan 2026 11:07:03 -0800 (PST)
Received: from [172.16.1.11] (i68975BB5.versanet.de. [104.151.91.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e476dsm906954f8f.4.2026.01.27.11.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 11:07:02 -0800 (PST)
Message-ID: <7689224e-6cf4-4be9-b8b1-686dc689fd5a@gmail.com>
Date: Tue, 27 Jan 2026 19:07:01 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 1/8] bpf: Enable bpf timer and workqueue use
 in NMI
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260122-timer_nolock-v7-0-04a45c55c2e2@meta.com>
 <20260122-timer_nolock-v7-1-04a45c55c2e2@meta.com>
 <CAP01T74WHyfVvtb8E+f7=B-yTHjJ+4qxDpO_RDdOZj6LW275pQ@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAP01T74WHyfVvtb8E+f7=B-yTHjJ+4qxDpO_RDdOZj6LW275pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/27/26 17:45, Kumar Kartikeya Dwivedi wrote:
> Resending because I screwed up formatting.
>
> On Thu, 22 Jan 2026 at 19:03, Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Refactor bpf timer and workqueue helpers to allow calling them from NMI
>> context by making all operations lock-free and deferring NMI-unsafe
>> work to irq_work.
>>
>> Previously, bpf_timer_start(), and bpf_wq_start()
>> could not be called from NMI context because they acquired
>> bpf_spin_lock and called hrtimer/schedule_work APIs directly. This
>> patch removes these limitations.
>>
>> Key changes:
>>   * Remove bpf_spin_lock from struct bpf_async_kern.
>>   * Initialize/Destroy via setting/unsetting bpf_async_cb pointer
>>     atomically.
>>   * Add per-bpf_async_cb irq_work to defer NMI-unsafe
>>     operations (hrtimer_start, hrtimer_try_to_cancel, schedule_work) from
>>     NMI to softirq context.
>>   * Use the lock-free seqcount_latch_t to pass operation
>>     commands (start/cancel/free) and parameters
>>     from NMI-safe callers to the irq_work handler.
>>   * Add reference counting to bpf_async_cb to ensure the object stays
>>     alive until all scheduled irq_work completes.
>>   * Move bpf_prog_put() to RCU callback to handle races between
>>     set_callback() and cancel_and_free().
>>   * Modify cancel_and_free() path:
>>     * Detach bpf_async_cb.
>>     * Signal destruction to irq_work side via setting last_seq to
>>       BPF_ASYNC_DESTROY.
>>     * On receiving BPF_ASYNC_DESTROY, cancel timer/wq.
>>   * Free bpf_async_cb on refcnt reaching 0, wait for both rcu and rcu
>>     task trace grace periods before freeing the bpf_async_cb. Removed
>>     unnecessary rcu locks, as kfunc/helper allways assumes rcu or rcu
>>     task trace lock.
>>
>> This enables BPF programs attached to NMI-context hooks (perf
>> events) to use timers and workqueues for deferred processing.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
>>   [...]
>> +
>> +static int bpf_async_read_op(struct bpf_async_cb *cb, enum bpf_async_op *op,
>> +                            u64 *nsec, u32 *flags)
>> +{
>> +       u32 seq, idx;
>> +       s64 last_seq;
>> +
>> +       while (true) {
>> +               last_seq = atomic64_read_acquire(&cb->last_seq);
>> +               if (unlikely(last_seq > U32_MAX)) { /* Check if terminal seq num has been set */
>> +                       s64 expected = BPF_ASYNC_DESTROY;
>> +
>> +                       if (last_seq != BPF_ASYNC_DESTROY)
>> +                               return -EBUSY;
>> +
>> +                       if (!atomic64_try_cmpxchg_release(&cb->last_seq,
>> +                                                         &expected,
>> +                                                         BPF_ASYNC_DESTROYED))
>> +                               return -EBUSY; /* Someone else set it to DESTROYED, bail */
>> +
>> +                       *op = BPF_ASYNC_CANCEL;
>> +                       return 0;
>> +               }
>> +
>> +               seq = raw_read_seqcount_latch(&cb->latch);
>> +
>> +               /* Return -EBUSY if current seq is consumed by another reader */
>> +               if (seq == last_seq)
>> +                       return -EBUSY;
>> +
>> +               idx = seq & 1;
>> +               *nsec = cb->cmd[idx].nsec;
>> +               *flags = cb->cmd[idx].mode;
>> +               *op = cb->cmd[idx].op;
>> +
>> +               if (raw_read_seqcount_latch_retry(&cb->latch, seq))
>> +                       continue;
>> +
>> +               /* Commit read sequence number, own snapshot exclusively */
>> +               if (atomic64_try_cmpxchg_release(&cb->last_seq, &last_seq, seq))
>> +                       break;
> I guess you could fold in the change we discussed offline here:
>
> return atomic64_try_cmpxchg_release(&cb->last_seq, &last_seq, seq) ? 0 : -EBUSY;
yes, thanks for help with the stress testing!
>
>> [...]
>>

