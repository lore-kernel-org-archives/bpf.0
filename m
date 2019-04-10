Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CDEC10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 17:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD13020693
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 17:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfDJRTi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:19:38 -0400
Received: from www62.your-server.de ([213.133.104.62]:60314 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbfDJRTi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 13:19:38 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hEGsi-0003ND-Ov; Wed, 10 Apr 2019 19:19:28 +0200
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hEGsi-000BiN-Gt; Wed, 10 Apr 2019 19:19:28 +0200
Subject: Re: [PATCH 1/3] bpf: Use spinlock_t in bpf_lru_list
To:     Yonghong Song <yhs@fb.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20190410143025.11997-1-bigeasy@linutronix.de>
 <813645e9-6a09-4aa4-0e2e-9b68359b83db@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4150a0db-18f9-aa93-cdb4-8cf047093740@iogearbox.net>
Date:   Wed, 10 Apr 2019 19:19:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <813645e9-6a09-4aa4-0e2e-9b68359b83db@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25415/Wed Apr 10 09:53:39 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/10/2019 07:08 PM, Yonghong Song wrote:
> On 4/10/19 7:30 AM, Sebastian Andrzej Siewior wrote:
>> There is no difference between spinlock_t and raw_spinlock_t for !RT
>> kernels. It is possible that bpf_lru_list_pop_free_to_local() invokes
>> at least three list walks which look unbounded it probably makes sense
>> to use spinlock_t.
>>
>> Make bpf_lru_list use a spinlock_t.
> 
> Could you add a cover letter for the patch set since you have
> more than one patch?
> 
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> ---
>>   kernel/bpf/bpf_lru_list.c | 38 +++++++++++++++++++-------------------
>>   kernel/bpf/bpf_lru_list.h |  4 ++--
>>   2 files changed, 21 insertions(+), 21 deletions(-)
>>
>> diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
>> index e6ef4401a1380..40f47210c3817 100644
>> --- a/kernel/bpf/bpf_lru_list.c
>> +++ b/kernel/bpf/bpf_lru_list.c
>> @@ -313,9 +313,9 @@ static void bpf_lru_list_push_free(struct bpf_lru_list *l,
>>   	if (WARN_ON_ONCE(IS_LOCAL_LIST_TYPE(node->type)))
>>   		return;
>>   
>> -	raw_spin_lock_irqsave(&l->lock, flags);
>> +	spin_lock_irqsave(&l->lock, flags);
>>   	__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_FREE);
>> -	raw_spin_unlock_irqrestore(&l->lock, flags);
>> +	spin_unlock_irqrestore(&l->lock, flags);
>>   }
> 
> This function (plus many others) is called by bpf program helpers which 
> cannot sleep. Is it possible that under RT spin_lock_irqsave() could 
> sleep and this will make bpf subsystem cannot be used under RT?

Back then in ac00881f9221 ("bpf: convert hashtab lock to raw lock")
Yang Shi converted spinlock_t to raw_spinlock_t due to exactly the
above mentioned issue. I presume that hasn't changed, right?

>>   static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
>> @@ -325,7 +325,7 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
>>   	struct bpf_lru_node *node, *tmp_node;
>>   	unsigned int nfree = 0;
>>   
>> -	raw_spin_lock(&l->lock);
>> +	spin_lock(&l->lock);
>>   
>>   	__local_list_flush(l, loc_l);
>>   
>> @@ -344,7 +344,7 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
>>   				      local_free_list(loc_l),
>>   				      BPF_LRU_LOCAL_LIST_T_FREE);
>>   
>> -	raw_spin_unlock(&l->lock);
>> +	spin_unlock(&l->lock);
>>   }
>>   
>>   static void __local_list_add_pending(struct bpf_lru *lru,
> [...]
>>   static void bpf_lru_list_init(struct bpf_lru_list *l)
>> @@ -642,7 +642,7 @@ static void bpf_lru_list_init(struct bpf_lru_list *l)
>>   
>>   	l->next_inactive_rotation = &l->lists[BPF_LRU_LIST_T_INACTIVE];
>>   
>> -	raw_spin_lock_init(&l->lock);
>> +	spin_lock_init(&l->lock);
>>   }
>>   
>>   int bpf_lru_init(struct bpf_lru *lru, bool percpu, u32 hash_offset,
>> diff --git a/kernel/bpf/bpf_lru_list.h b/kernel/bpf/bpf_lru_list.h
>> index 7d4f89b7cb841..4e1e4608f1bb0 100644
>> --- a/kernel/bpf/bpf_lru_list.h
>> +++ b/kernel/bpf/bpf_lru_list.h
>> @@ -36,13 +36,13 @@ struct bpf_lru_list {
>>   	/* The next inacitve list rotation starts from here */
>>   	struct list_head *next_inactive_rotation;
>>   
>> -	raw_spinlock_t lock ____cacheline_aligned_in_smp;
>> +	spinlock_t lock ____cacheline_aligned_in_smp;
>>   };
>>   
>>   struct bpf_lru_locallist {
>>   	struct list_head lists[NR_BPF_LRU_LOCAL_LIST_T];
>>   	u16 next_steal;
>> -	raw_spinlock_t lock;
>> +	spinlock_t lock;
>>   };
>>   
>>   struct bpf_common_lru {
>>

