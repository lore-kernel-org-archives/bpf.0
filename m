Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C5C3D4127
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772736298; cv=none; b=FXf9EYtAmeFuwQppbceiqblf8jLGcj5boavinnLE8+/vJnIIu99qcP7JTiWyBDGQtuo+IZsOdZ++qIaFAJzLez/XB7ZahQdVRPxdUNVTxUEvNUZkGfLMSK0Dn4ZZ+FuL1g1meGLNz45aBfsynpYK5xl80AdY+ihxjRCnaNi81nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772736298; c=relaxed/simple;
	bh=2RWk/CofiplfEgm9SkwR9d4nGhuLe0Y3v8zkyp2ospo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oLYzrOwzaRedtyCBFLnaXyLemIY45FdWpj822ekSE/zV2uBW6Hk4wbwmhk4JtlJHHKPp9wMzkxDrq2FewWnSBSgUNTGyXz3tjwKagsrpcL9nv8HZxTp6Ui7LzxPzcbszj9gChdx0BQG+5DcqWkvw5AAc8zUpCR3C2zIL9ywX0P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WsVzsjqJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WsVzsjqJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772736295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rCsRP8L9lM6fo/Lk/q3osinV3Un46K47JkCliA1d2Sg=;
	b=WsVzsjqJcH9zngeprXSO8u974JGs/h8TBtgEzex+xdtIkI+NkXCtVa3TFiQVRvWlfcfViB
	AEa3djJQM73F8J7ZHUBdBDAg7VqmCzbuL17GqjhNwiMIPtVwrs1p/GuiApdWI76mSa7CgY
	gGWN6qzdVyCzQ2d8DmkEPACrfoGnymI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-w9Jj-wgEMFyxq2d_yXSbiw-1; Thu,
 05 Mar 2026 13:44:54 -0500
X-MC-Unique: w9Jj-wgEMFyxq2d_yXSbiw-1
X-Mimecast-MFC-AGG-ID: w9Jj-wgEMFyxq2d_yXSbiw_1772736293
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D105A18005B8;
	Thu,  5 Mar 2026 18:44:52 +0000 (UTC)
Received: from [10.22.88.171] (unknown [10.22.88.171])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 802CA1800673;
	Thu,  5 Mar 2026 18:44:49 +0000 (UTC)
Message-ID: <9e4e356e-25b0-4ac5-8d25-ad093b241b94@redhat.com>
Date: Thu, 5 Mar 2026 13:44:48 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
From: Waiman Long <longman@redhat.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 David Laight <david.laight.linux@gmail.com>,
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
 <CALOAHbAsiVNC7COL7rCJBdaC-8oZQvg+pjudR4QexQQaYLBmgA@mail.gmail.com>
 <c58807dc-74ea-469e-9c21-0300b80f2a82@redhat.com>
Content-Language: en-US
In-Reply-To: <c58807dc-74ea-469e-9c21-0300b80f2a82@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 3/5/26 1:34 PM, Waiman Long wrote:
> On 3/5/26 12:40 AM, Yafang Shao wrote:
>> On Thu, Mar 5, 2026 at 12:30 PM Waiman Long <longman@redhat.com> wrote:
>>> On 3/4/26 10:08 PM, Yafang Shao wrote:
>>>> On Thu, Mar 5, 2026 at 11:00 AM Steven Rostedt 
>>>> <rostedt@goodmis.org> wrote:
>>>>> On Thu, 5 Mar 2026 10:33:00 +0800
>>>>> Yafang Shao <laoar.shao@gmail.com> wrote:
>>>>>
>>>>>> Other tools may also read available_filter_functions, requiring each
>>>>>> one to be patched individually to avoid this flaw—a clearly
>>>>>> impractical solution.
>>>>> What exactly is the issue?
>>>> It makes no sense to spin unnecessarily when it can be avoided. We
>>>> continuously improve the kernel to do the right thing—and unnecessary
>>>> spinning is certainly not the right thing.
>>>>
>>>>> If a task does a while 1 in user space, it
>>>>> wouldn't be much different.
>>>> The while loop in user space performs actual work, whereas useless
>>>> spinning does nothing but burn CPU cycles. My point is simple: if this
>>>> unnecessary spinning isn't already considered an issue, it should
>>>> be—it's something that clearly needs improvement.
>>> The whole point of optimistic spinning is to reduce the lock 
>>> acquisition
>>> latency. If the waiter sleeps, the unlock operation will have to 
>>> wake up
>>> the waiter which can have a variable latency depending on how busy the
>>> system is at the time. Yes, it is burning CPU cycles while spinning,
>>> Most workloads will gain performance with this optimistic spinning
>>> feature. You do have a point that for system monitoring tools that
>>> observe the system behavior, they shouldn't burn that much CPU times
>>> that affect performance of real workload that the tools are monitoring.
>> Exactly. ftrace is intended for debugging and should not significantly
>> impact real workloads. Therefore, it's reasonable to make it sleep if
>> it cannot acquire the lock immediately, rather than spinning and
>> consuming CPU cycles.
>
> Your patch series use wordings that give a negative connotation about 
> optimistic spinning making it look like a bad thing. In fact, it is 
> just a request for a new mutex API for use cases where they can suffer 
> higher latency in order to minimize the system overhead they incur. So 
> don't bad-mouth optimistic spinning and emphasize the use cases you 
> want to support with the new API in your next version. 

BTW, for any new mutex API introduced, you should also provide an 
equivalent version in kernel/locking/rtmutex_api.c for PREEMPT_RT kernel.

Cheers,
Longman

