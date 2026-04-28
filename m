Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB18402B8B;
	Tue, 28 Apr 2026 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777384405; cv=none; b=NYZyJAyPw2uxlT1Gvpgd5MRtKqfAQk+z4vgOrTLdygJUpMME/BnInVrEY8VJX+Aay+6cwsfg9E69sV8l2Q06d0fp0tjwXBX7Zw97xkubc4qKJZFiE//4/WhqaYsIRibXaH7Je7I3EMIj0ntR0vbcU1s5jSpXxxkRF/8Kd6VONHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777384405; c=relaxed/simple;
	bh=/10/r+fyQdY/hOZIRZp/3WlejG5AKgZQH91X4BAPJBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/cpbZ2+KDzA+T7wvWmJZ5hsxxWWWzB3ypqaTWNbIzEvTB2Yq6VffQWTUfT7UdGpo3uHiE8qeBSWBde/u0dftc2mcF3T4INk0/elaEawVR1AcyeJht101t8D4UijO+KPEbvmlwZrLcl+NKtCY9UcJdEk9FRGAxoEwpbj3m1zFNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VbrPgk4e; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VbrPgk4e"
Message-ID: <e908cd1a-a0ee-49b1-8528-c455bbd4c432@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777384401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CzDFP7nbPCUcNjWgIu8emI3o1xLPnD8WwB+gomvVzqY=;
	b=VbrPgk4eAqU5ZeED8lPdpS27fwXquEz0OuRwXyj7Vp8yZPmnov4EGJz41ABDABO/FSOW/9
	0hqKE7JnFnjmCneGDKikUyuSf/6x4EJ3qh6cpHDoTth9p6cSYMTtx3ivNEycuTB6gT2i4b
	kKa9dmTXzZ/cQiU646ZKE3wXb/vpt9Q=
Date: Tue, 28 Apr 2026 21:52:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 1/8] bpf: refactor __bpf_list_del to take
 list node pointer
To: bot+bpf-ci@kernel.org, emil@etsalapatis.com
Cc: shuah@kernel.org, john.fastabend@gmail.com, yonghong.song@linux.dev,
 song@kernel.org, eddyz87@gmail.com, andrii@kernel.org, ast@kernel.org,
 martin.lau@linux.dev, daniel@iogearbox.net, jolsa@kernel.org,
 haoluo@google.com, sdf@fomichev.me, kpsingh@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev, chengkaitao@kylinos.cn,
 linux-kselftest@vger.kernel.org
References: <20260427165906.84420-2-kaitao.cheng@linux.dev>
 <af50d188f6bc2de81fe3c321b26a645a9425ba9f2644cb6f8525d5bb637385f9@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <af50d188f6bc2de81fe3c321b26a645a9425ba9f2644cb6f8525d5bb637385f9@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/4/28 02:43, bot+bpf-ci@kernel.org 写道:
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
> 
> [ ... ]
> 
>> @@ -2575,12 +2577,16 @@ static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,
>>
>>  __bpf_kfunc struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
>>  {
>> -	return __bpf_list_del(head, false);
>> +	struct list_head *h = (void *)head;
>> +
>> +	return __bpf_list_del(head, h->next);
>>  }
> 
> This addresses an unaddressed review comment from Emil Tsalapatis in v8.
> The code reads h->next before __bpf_list_del checks if the list is
> initialized. If the list is uninitialized (h->next is NULL), a NULL pointer
> is passed to __bpf_list_del.
> 
> While the function will eventually initialize the list and return NULL without
> dereferencing the NULL pointer:
> 
> kernel/bpf/helpers.c:__bpf_list_del() {
> 	if (unlikely(!h->next)) {
> 		INIT_LIST_HEAD(h);
> 		return NULL;
> 	}
> 	...
> }
> 
> this is counterintuitive - passing a potentially garbage value that is later
> ignored.
> 
> Emil suggested moving the init check logic into the top-level kfuncs
> (bpf_list_pop_front/bpf_list_pop_back) to ensure the list_head passed to
> __bpf_list_del is always valid. You can also just init the list and return
> NULL in that case - we know it's empty.
> 
> The same issue applies to bpf_list_pop_back() which reads h->prev before
> the initialization check.
> 
> Original comment from Emil Tsalapatis (Thu, 19 Mar 2026 12:17:50 -0400):
> https://lore.kernel.org/bpf/DH6W7K2SLPYB.PCO7FQ6CR1YZ@etsalapatis.com/
> 
> "The new code reads n _before_ we check if the list is initialized. So the n
> we are passing from the caller may well be NULL. However, __bpf_list_del()
> will in that case now a) call INIT_LIST_HEAD(() to properly set up prev/next,
> b) call list_empty() on the newly initialized list and exit without ever
> reading the NULL passed by the caller.
> 
> This is kind of counterintuitive: We are passing essentially a garbage value
> to __bpf_list_del that we thankfully end upi ignoring. Can you move the init
> check logic into the top-level kfuncs to make sure the list_head we're passing
> to __bpf_list_del is always valid? You can also just init the list and return
> NULL in that case - we know it's empty."
> 
> This issue remains unaddressed in v10.
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25009536772

The '__bpf_list_del' function is a static function, so its scope and
associated risk are both very limited. I think its purpose is code
reuse and avoiding duplication.

If we move 'unlikely(!h->next)' to the outer callers, I believe it
brings no benefit other than making the code more redundant. Also,
I think validating a function's parameters before execution is not
counterintuitive; on the contrary, for global functions it is almost
a hard requirement.

-- 
Thanks
Kaitao Cheng

