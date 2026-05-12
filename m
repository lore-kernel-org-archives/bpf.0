Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557BC3A4F33
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576238; cv=none; b=eXBtnhn5qXNZJW0zh4ooI9U/hQ7OkxlES5siqOsAN7u634/QsGHPUm3rqa1C4aq33oDrktjg3oiCXhuAULb80oYoYuimiC+fVY0lkpJhbYeZfg8d+3eVKbCPfhMttpep/wPX1pk2gIDe28HZM1tTaZK8+izyUBxbyFDbAzsk7y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576238; c=relaxed/simple;
	bh=Rlk7APYLUhRDFXVDwVWk3a09kszEYGfYDGOrXzHLDbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amRuC29z7dDS+agHoQPWNwvYZjXhEzyniCYsEo5bSzgZI8yw6GTjjk/tPMiNubHYXG7o0FYTgnr+f/U78oUWmBw1ndQijmTP9MNkmbJ/XheTtOyRTV1wyWc3hF2dAQBp8LAlwxriCW3Ps7+QLli+Bg3oU3ZSAYqkylVId6ITFWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jzUXdEt6; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jzUXdEt6"
Message-ID: <4e1d29b5-38d5-4419-9f2b-1b421486ab46@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778576218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5i+1kkpA2Ee08JGHavIhKppUEEy/+Cg51zFy81CfIe4=;
	b=jzUXdEt6zqwwYcBlI0smv5otUDttm+oRSftGru12EDpf9GHYcMnaCjaWY7NoJvJFVaCbQR
	8JciHSfsAVzhs7nt7D0uKPRmYLJlMPaM5q/JJi7zyXuSdxLqrn44JwkgroMSjrTN39S40P
	Lw0RKjANJxPjuWB8OBXjP/YbBoN97UI=
Date: Tue, 12 May 2026 16:55:59 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND bpf-next v10 1/8] bpf: refactor __bpf_list_del to
 take list node pointer
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, corbet@lwn.net,
 martin.lau@linux.dev, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, skhan@linuxfoundation.org, memxor@gmail.com,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, vmalik@redhat.com,
 linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260512055919.95716-2-kaitao.cheng@linux.dev>
 <6eb07d559a41965a3a9b186b4c28c0942cf1bfb982d539b92c76c27b08db0b04@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <6eb07d559a41965a3a9b186b4c28c0942cf1bfb982d539b92c76c27b08db0b04@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

I have clarified this issue in the [PATCH bpf-next v10 1/8] patch,
with the link provided below:

https://lore.kernel.org/bpf/e908cd1a-a0ee-49b1-8528-c455bbd4c432@linux.dev/

在 2026/5/12 14:41, bot+bpf-ci@kernel.org 写道:
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index baa12b24bb64..9cd7b028592c 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2550,22 +2550,24 @@ __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
>>  	return bpf_list_push_back(head, node, meta__ign, off);
>>  }
>>
>> -static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tail)
>> +static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,
>> +					    struct list_head *n)
>>  {
>> -	struct list_head *n, *h = (void *)head;
>> +	struct list_head *h = (void *)head;
>>  	struct bpf_list_node_kern *node;
>>
>>  	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
>>  	 * called on its fields, so init here
>>  	 */
>> -	if (unlikely(!h->next))
>> +	if (unlikely(!h->next)) {
>>  		INIT_LIST_HEAD(h);
>> +		return NULL;
>> +	}
>>  	if (list_empty(h))
>>  		return NULL;
>>
>> -	n = tail ? h->prev : h->next;
>>  	node = container_of(n, struct bpf_list_node_kern, list_head);
>> -	if (WARN_ON_ONCE(READ_ONCE(node->owner) != head))
>> +	if (unlikely(READ_ONCE(node->owner) != head))
>>  		return NULL;
>>
>>  	list_del_init(n);
>> @@ -2575,12 +2577,16 @@ static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tai
>>
>>  __bpf_kfunc struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
>>  {
>> -	return __bpf_list_del(head, false);
>> +	struct list_head *h = (void *)head;
>> +
>> +	return __bpf_list_del(head, h->next);
>>  }
> 
> The new code reads h->next before __bpf_list_del checks if the list is
> initialized. If the list is uninitialized (h->next is NULL), a NULL pointer
> is passed to __bpf_list_del.
> 
> While __bpf_list_del eventually initializes the list and returns NULL without
> dereferencing the NULL pointer, this is counterintuitive - passing a
> potentially garbage value that is later ignored.
> 
> Can you move the initialization check into the top-level kfuncs
> (bpf_list_pop_front and bpf_list_pop_back) to ensure the list_head passed to
> __bpf_list_del is always valid? You could initialize the list and return NULL
> in that case - we know it's empty.
> 
> This concern was raised by Emil Tsalapatis in v8:
> https://lore.kernel.org/bpf/DH6W7K2SLPYB.PCO7FQ6CR1YZ@etsalapatis.com/
> 
>>
>>  __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
>>  {
>> -	return __bpf_list_del(head, true);
>> +	struct list_head *h = (void *)head;
>> +
>> +	return __bpf_list_del(head, h->prev);
>>  }
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25716874656

-- 
Thanks
Kaitao Cheng

