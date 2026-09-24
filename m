Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B6D429CD3
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243809; cv=none; b=G9O+QUl6mmu/HYVAhlQHCAnX93Tqe4kI4UdNBxeQjdw6OymgpCsOh/KALXxCDDkc3d4hlVO93d5K8lk5T3dMFSlkq269rnrl1yNfMHcMzGVbxmiNVf8cx9LZ30nMNCtKrcpE/kZvzQsDUah7qfy8auDYIIXU7LuPKqv1MrIiqCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243809; c=relaxed/simple;
	bh=77x5+7GhhgvhxrqspMdaH7jy4VNNgMZ+qTq0xTd4GzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhWlF16z+T4QXHEwJhuSW3oMN6djXd+Y3zTv3nzmHfs5PU7769bv3sgkMlkeJ9ps2UihhOw2WHr3sZXWX0lSDKt2TfUU4gIo/c2aRTc66+297V83hUkiI5IWNQBVZ8gAqMYjTjll2FBCkKXeL8wamTR0HMGNPo9HVRqk8rHhxfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U2IoXks2; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U2IoXks2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=erd/Ppwil1r+WROLH/A3LGejNHq6cTMe7IvwG2u99aE=;
	b=U2IoXks2rTtvoNkFj/iw6GMC2ankFqQIc/B7/URCihuY4y1BxP83OJMWwX0xId
	+S5STbFPYX/Z+oZMdl9utxLbSVdgo4WurdIQm926vzLyOXc4N9osWti42MdtoGE0
	eAMRU6KAy8HXQRM64xVNevtI6cgkLNU2T6+hfKOf43aj4=
Message-ID: <7771232b-2085-4a70-95b4-beebb741b802@163.com>
Date: Thu, 24 Sep 2026 17:55:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix task work scheduling and
 callback race
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev
Cc: yatsenko@meta.com, bpf@vger.kernel.org
References: <20260922100042.136818-1-luyun_611@163.com>
 <20260922100042.136818-2-luyun_611@163.com>
 <DLN2KZR6RHH5.2OO4ZIR0XA36T@gmail.com>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <DLN2KZR6RHH5.2OO4ZIR0XA36T@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDnp4Sa87RqlGqYBA--.23952S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw1kZw48trWrAr1rtFyxZrb_yoW8WrWfpF
	sak34jkFs8Xr1vkF12vw4DA3Zakwnag3y5uryrtr92yw15Xr1Sy34UK3y7uayfAr1FqF10
	vF4qv3sIkw1DCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5sqAUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7Bzrumq085zhUQAA3g


在 2026/9/24 07:04, Alexei Starovoitov 写道:
> On Tue, Sep 22, 2026 at 06:00 PM Yun Lu <luyun_611@163.com> wrote:
>> -	err = task_work_add(ctx->task, &ctx->work, ctx->mode);
>> +	task = get_task_struct(ctx->task);
>> +	err = task_work_add(task, &ctx->work, ctx->mode);
> Why?
> There should be no need for get_task_struct().
> rcu_read_lock() keeps task_struct around.
> bpf_task_release() is put_task_struct_rcu_user(), so the task is
> freed after rcu gp and guard(rcu)() covers the whole handler.
>    task = ctx->task;
> is enough.
> The commit log still says that rcu_read_lock() "does not retain
> ctx->task". why?

Hi, Alexei

Thanks for your reviewing.

You are right.
I added get_task_struct() to keep the task valid for the handler's post-add
cancellation, but overlooked that guard(rcu)() already covers the handler
and bpf_task_release() defers freeing the task past the RCU grace period.
v4  will drop the get/put_task_struct and captures the pointer, also
correct the commit log.


>
> [...]
>
>> +	if (unlikely(irq_work_is_busy(&ctx->irq_work))) {
>> +		(void)cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_STANDBY);
>> +		bpf_task_work_ctx_put(ctx);
>> +		return ERR_PTR(-EBUSY);
>> +	}
> This is a fix for a different bug.
> Pls split it into a separate patch and describe the sequence in
> its commit log the way it's done for the first one.
> "publishing a false SCHEDULED state" doesn't say what breaks.

OK, v4 will split the irq_work_is_busy() check into a separate patch,
and describe the interleaving and the concrete failure in commit log.

---

Thanks.

Yun Lu


>
> pw-bot: cr

