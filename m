Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0539283FCF
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772737220; cv=none; b=Tb4YS5RTJVWsWgK4Z7qgLJqgQ3VnM0m4zWiapbWhLTWbt3RIljRQH1I5dCeBKlqVzU6Nd5lLFOG/m+afsfLzo46iyE90iND/VL/JWFbdmpqkv1zYyynmiRwPzt+lpQMDVKcAlLizE1r2hbhvvKSJT6vvdIqfgTmi/9kD8RhKTGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772737220; c=relaxed/simple;
	bh=kXAItG71XvY4d9Pl7iswIgW8t3fyXQmAH7EftQTPxsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJePZwf/3pcO6Sr0Em/xvwxlE9Vds0l4DCqCVm8k6zXmKfwwevCjv4U511FW+xu2swcIA9d6ns5cZZ9688Kr2G8rqqp/yWwTpyMalajvmxGRQJv9lmEmY3tmEW9IeQG9kalfPOBJ+KGotXQZtmKpBeucOb0u8bzffX6gPgy7pqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PxjZYy3D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxjZYy3D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772737218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aR5ra7UnNvsZdQxAhgAUxS4DtQm3eiNJ91FDQLXcpd4=;
	b=PxjZYy3DJRMFLXs1dbT7Qgwn+cXta5fOtWxNTLOQ0HLlX++Mq/rmSAIMSJ8FPKcbkr1hVc
	FzS/VPtw9/i+OdYd45Rdfk8YJP0HKUXhyWjoA6Npc+/uFs8xiJHeUF9xo+vpOTXzO9sAEM
	xcKq8Xuks2QrFtTm5pxbHyIiN7Ns+yU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-6lxmoy2dNYiChAseosEaAA-1; Thu,
 05 Mar 2026 14:00:13 -0500
X-MC-Unique: 6lxmoy2dNYiChAseosEaAA-1
X-Mimecast-MFC-AGG-ID: 6lxmoy2dNYiChAseosEaAA_1772737211
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 597CF18005BA;
	Thu,  5 Mar 2026 19:00:11 +0000 (UTC)
Received: from [10.22.88.171] (unknown [10.22.88.171])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD839180049D;
	Thu,  5 Mar 2026 19:00:08 +0000 (UTC)
Message-ID: <d161ea96-8023-4a5e-a4eb-3e17780c8308@redhat.com>
Date: Thu, 5 Mar 2026 14:00:08 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
To: David Laight <david.laight.linux@gmail.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, will@kernel.org,
 boqun@kernel.org, mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260304074650.58165-1-laoar.shao@gmail.com>
 <20260304074650.58165-2-laoar.shao@gmail.com>
 <20260304090249.GN606826@noisy.programming.kicks-ass.net>
 <20260304095415.4d5f2528@pumpkin>
 <20260304155742.7b4de2d1@gandalf.local.home>
 <20260304214447.3e5817ea@pumpkin>
 <CALOAHbCOynnRdc8JkNJHb-nyoerrz0K5GUhnD8OR2hv4x==5LA@mail.gmail.com>
 <20260304212802.458b878e@fedora>
 <CALOAHbBA643_QOsnTmrfjKE71hSa+v1cToiELvGk+vjtcgJsxg@mail.gmail.com>
 <20260304220019.3efa12ab@robin>
 <CALOAHbA4Dtc3cXs2JiQ=kxES3kT+Acb=amUxkOvQ22fns-Mqgw@mail.gmail.com>
 <748e8e0d-5164-4c8a-9bb9-110874c5daa0@redhat.com>
 <20260305093254.61facfb6@pumpkin>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260305093254.61facfb6@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 3/5/26 4:32 AM, David Laight wrote:
> On Wed, 4 Mar 2026 23:30:40 -0500
> Waiman Long <longman@redhat.com> wrote:
>
>> On 3/4/26 10:08 PM, Yafang Shao wrote:
>>> On Thu, Mar 5, 2026 at 11:00 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>>>> On Thu, 5 Mar 2026 10:33:00 +0800
>>>> Yafang Shao <laoar.shao@gmail.com> wrote:
>>>>   
>>>>> Other tools may also read available_filter_functions, requiring each
>>>>> one to be patched individually to avoid this flaw—a clearly
>>>>> impractical solution.
>>>> What exactly is the issue?
>>> It makes no sense to spin unnecessarily when it can be avoided. We
>>> continuously improve the kernel to do the right thing—and unnecessary
>>> spinning is certainly not the right thing.
>>>   
>>>> If a task does a while 1 in user space, it
>>>> wouldn't be much different.
>>> The while loop in user space performs actual work, whereas useless
>>> spinning does nothing but burn CPU cycles. My point is simple: if this
>>> unnecessary spinning isn't already considered an issue, it should
>>> be—it's something that clearly needs improvement.
>> The whole point of optimistic spinning is to reduce the lock acquisition
>> latency. If the waiter sleeps, the unlock operation will have to wake up
>> the waiter which can have a variable latency depending on how busy the
>> system is at the time. Yes, it is burning CPU cycles while spinning,
>> Most workloads will gain performance with this optimistic spinning
>> feature. You do have a point that for system monitoring tools that
>> observe the system behavior, they shouldn't burn that much CPU times
>> that affect performance of real workload that the tools are monitoring.
>>
>> BTW, you should expand the commit log of patch 1 to include the
>> rationale of why we should add this feature to mutex as the information
>> in the cover letter won't get included in the git log if this patch
>> series is merged. You should also elaborate in comment on under what
>> conditions should this this new mutex API be used.
> Isn't changing mutex_lock() the wrong place anyway?
> What you need is for the code holding the lock to indicate that
> it isn't worth waiters spinning because the lock will be held
> for a long time.

I have actually thought about having a flag somewhere in the mutex 
itself to indicate that optimistic spinning isn't needed. However the 
owner field is running out of usable flag bits. The other option is to 
add it to osq as it doesn't really need to use the full 32 bits for the 
tail. In this case, we can just initialize the mutex to say that we 
don't need optimistic spinning and no new mutex_lock() API will be needed.

Cheers,
Longman

