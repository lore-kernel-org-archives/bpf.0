Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB80D35A393;
	Sat, 16 May 2026 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778948320; cv=none; b=YjEinyiYu2MJLn6r7wjFCmRbymO1ULtIJo7aSIqEjsk/lsP8NJQJ4y3KwhD2mhfLlqZhnsgxvmEMGEWFwdlPJo992ortJlmisjZ/mQujb7jfqiT97W4B1qXaq/u6sP6Udqhvy+zJorkDGJBITzeEYSAPAkvsli5C+zC/6wMSSd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778948320; c=relaxed/simple;
	bh=FM7gTZ1mmAAgFi4vaJTykZhCfX+sgQguDzAIZMiy5x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPp1Dj7KGtr6K9vzGVu7NjLRZJhje2d8i4V5K/7Sc4IPci8llua+lol9vPBgP7CSi8rYejzeo3MepsegTVUe95hYdhlwaDaVafZM/r/f8YpC3x9qTqw6LqI7vfBmz0fiYY3DLQyT2VqsvLx04TyyK8VD3TxW83NB0ay3o+l6RL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r4UtEKN8; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r4UtEKN8"
Message-ID: <0171629c-bdd3-4661-a4e6-2698dd623c3a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778948306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vR+lCQ0+V0Cdos5Ij8lDKUWYnxsl8sJZdNMOw6mrUN4=;
	b=r4UtEKN8a1UsCGh7yOfFegUVpsKLPA7q0L22MVLySoDpU72FG41c8Sk94hzx7+op1L62Oz
	NaCH7lToB2Na5CMycO9mwvJGHJ713s+iLAHLlfLJz9LDQQyL/4fsf4ntfucLEX4VYbYYuz
	BvPZAYWr9/U61fKJ1pRdQpQJBOlkbSs=
Date: Sun, 17 May 2026 00:18:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND bpf-next v10 2/8] bpf: clear list node owner and
 unlink before drop
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, ast@kernel.org, memxor@gmail.com, corbet@lwn.net,
 martin.lau@linux.dev, daniel@iogearbox.net, andrii@kernel.org,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, chengkaitao@kylinos.cn, skhan@linuxfoundation.org,
 vmalik@redhat.com, linux-kselftest@vger.kernel.org, martin.lau@kernel.org,
 clm@meta.com, ihor.solodrai@linux.dev, bot+bpf-ci@kernel.org
References: <20260512055919.95716-3-kaitao.cheng@linux.dev>
 <da95f45b43d94d17796b19abc4c555e35daafab7d5e1cdca3714fe0f54ab8cce@mail.kernel.org>
 <e141699dab70282d811ec30bbf2aa8279706817b.camel@gmail.com>
 <DII0TT9LXYCX.2GMM6QA4Q9BPZ@gmail.com>
 <0fb2d99b-b122-44fa-a8bc-9befe6e350bc@linux.dev>
 <7fa6794161a8bd4fdbc21dad68e86e9770c873cc.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <7fa6794161a8bd4fdbc21dad68e86e9770c873cc.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/5/16 02:24, Eduard Zingerman 写道:
> On Fri, 2026-05-15 at 12:34 +0800, Kaitao Cheng wrote:
>>
>> 在 2026/5/14 09:50, Alexei Starovoitov 写道:
>>> On Wed May 13, 2026 at 3:53 PM PDT, Eduard Zingerman wrote:
>>>> On Tue, 2026-05-12 at 06:41 +0000, bot+bpf-ci@kernel.org wrote:
>>>>
>>>> [...]
>>>>
>>>>> When a BPF program holds an owning or refcount-acquired reference to
>>>>> one of these nodes (node X), which is structurally supported because
>>>>> __bpf_obj_drop_impl() uses refcount_dec_and_test() and only frees at
>>>>> refcount 0, a concurrent push to a DIFFERENT bpf_list_head becomes a
>>>>> corruption:
>>>>>
>>>>> CPU 0 (bpf_list_head_free, lock released)  CPU 1 (BPF prog, refcount X)
>>>>> -----------------------------------------   ----------------------------
>>>>> (owner of X == NULL, X linked in drain)
>>>>>                                             bpf_list_push_back(other, X)
>>>>>                                               __bpf_list_add: spin_lock()
>>>>>                                               cmpxchg(X->owner, NULL,
>>>>>                                                       POISON) -> OK
>>>>>                                               list_add_tail(&X->list_head,
>>>>>                                                             other_head)
>>>>>                                                 -> overwrites X->next,
>>>>>                                                    X->prev, corrupts
>>>>>                                                    other_head's chain
>>>>>                                                    because X is still
>>>>>                                                    stitched into drain
>>>>> pos = drain.next;      (may be X or neighbor using X's stale next)
>>>>> list_del_init(pos);    reads X->next/prev now pointing into other_head,
>>>>>                        corrupts other_head's list and/or drain
>>>>
>>>>
>>>> Kaitao, this scenario seem plausible, could you please comment on it?
>>>
>>> I think bot is correct.
>>> This patch looks buggy.
>>> It seems to me an optimization that breaks the concurrent logic.
>>> May be just drop this patch and reorder the other one, so that bot
>>> sees nonown suffix logic first.
>>
>> This patch is still necessary because it addresses the problem discussed
>> in this thread:
>> https://lore.kernel.org/all/DH846C0P88QU.16YT12I1LXBZM@etsalapatis.com/
>>
>> The patch does have a bug, however. To fix the issues we are seeing now,
>> I propose the additional changes below and would appreciate feedback.
>>
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2263,8 +2263,10 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
>>         if (!head->next || list_empty(head))
>>                 goto unlock;
>>         list_for_each_safe(pos, n, head) {
>> -               WRITE_ONCE(container_of(pos,
>> -                       struct bpf_list_node_kern, list_head)->owner, NULL);
>> +               struct bpf_list_node_kern *node;
>> +
>> +               node = container_of(pos, struct bpf_list_node_kern, list_head);
>> +               WRITE_ONCE(node->owner, BPF_PTR_POISON);
>>                 list_move_tail(pos, &drain);
>>         }
>>  unlock:
>> @@ -2272,8 +2274,12 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
>>         __bpf_spin_unlock_irqrestore(spin_lock);
>>
>>         while (!list_empty(&drain)) {
>> +               struct bpf_list_node_kern *node;
>> +
>>                 pos = drain.next;
>> +               node = container_of(pos, struct bpf_list_node_kern, list_head);
>>                 list_del_init(pos);
>> +               WRITE_ONCE(node->owner, NULL);
> 
> I think this still leaves a short race window open.
> Why does the .owner has field to be NULL?
> Can the logic that implies for it to be NULL be extended to accept
> POISON as well?

Here, before setting owner to NULL, list_del_init() has already been
executed, which means the node no longer belongs to any list. This
should match the semantic meaning of owner == NULL.

Do you mean deleting WRITE_ONCE(node->owner, NULL) and preventing
all subsequent __bpf_list_add() operations on this node?

> 
>>                 /* The contained type can also have resources, including a
>>                  * bpf_list_head which needs to be freed.
>>                  */


>> @@ -2481,6 +2487,14 @@ static int __bpf_list_add(struct bpf_list_node_kern *node,
>>         if (unlikely(!h->next))
>>                 INIT_LIST_HEAD(h);
>> 
>> +       /* bpf_list_head_free() marks nodes being detached with BPF_PTR_POISON
>> +        * before list_del_init().  cmpxchg(NULL, POISON) below would fail with
>> +        * that old value and fall into the generic error path, which wrongly
>> +        * calls __bpf_obj_drop_impl().  Reject POISON up front instead.
>> +        */
>> +       if (READ_ONCE(node->owner) == BPF_PTR_POISON)
>> +               return -EINVAL;
>> +

This code block is not needed; I will remove it.

-- 
Thanks
Kaitao Cheng

