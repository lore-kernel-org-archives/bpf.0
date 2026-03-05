Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD7B218EB1
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 04:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772685052; cv=none; b=br/b9tAW9oupkx6fPQwWnDoZ49qgT3cmFYkjVksYL4x250xCQ1TtscSVXhzqSUUDby0g2ahGRjy14fuaEM0/IUJXadE8im4Kg+usOkqMtOq64DCtagd90d4JcC/zXpFvvs7BcnxPh70C90cGuBjsLSBoi1XcrUIFVSWOE/fhrsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772685052; c=relaxed/simple;
	bh=QTOAJdJHLxTPFR5OqvROS0AZ4JRRRNMhA+ygvECGKvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCPiGLPheCt5nUikWfHgb5VIZ77Vv425vtFvH9/om742pBiK7h88GFLPlXYjfVBm8sJmPOw5LxY7De93sFVHqI3pkl+ukWFT3FS6tz3gqyE3QMp3a/rO+WEHRTtEIo+vEl5dcBJAFscyA02TTVK6goQkVI37jSZvomZcxUlqISM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dbCdO2f9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbCdO2f9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772685050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x464U0tUPJx+URPpXwJ8QkoXpsT7JusMpBoZ0qTDLr0=;
	b=dbCdO2f9xvvCwcFkCr/qvr+9QGmq5fDKGGimYXDu9nP08Ng1xIvE83u6krBTH2WqcBWuRe
	Wb7DGzqZDfVkmSKsHpZGBMObejtFsWCU0XEY/iwnICA88ucu5y5UEjykhHS4ykBAo2zBhS
	TwzEBl8ngpB81fn9Jv+Ys4+2Vz0NAG4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-Qtj_jFyoPVWudsp51JB-fQ-1; Wed,
 04 Mar 2026 23:30:48 -0500
X-MC-Unique: Qtj_jFyoPVWudsp51JB-fQ-1
X-Mimecast-MFC-AGG-ID: Qtj_jFyoPVWudsp51JB-fQ_1772685046
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7250195605A;
	Thu,  5 Mar 2026 04:30:45 +0000 (UTC)
Received: from [10.22.89.197] (unknown [10.22.89.197])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A3E6B180049D;
	Thu,  5 Mar 2026 04:30:42 +0000 (UTC)
Message-ID: <748e8e0d-5164-4c8a-9bb9-110874c5daa0@redhat.com>
Date: Wed, 4 Mar 2026 23:30:40 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
To: Yafang Shao <laoar.shao@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: David Laight <david.laight.linux@gmail.com>,
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
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CALOAHbA4Dtc3cXs2JiQ=kxES3kT+Acb=amUxkOvQ22fns-Mqgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 3/4/26 10:08 PM, Yafang Shao wrote:
> On Thu, Mar 5, 2026 at 11:00 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>> On Thu, 5 Mar 2026 10:33:00 +0800
>> Yafang Shao <laoar.shao@gmail.com> wrote:
>>
>>> Other tools may also read available_filter_functions, requiring each
>>> one to be patched individually to avoid this flaw—a clearly
>>> impractical solution.
>> What exactly is the issue?
> It makes no sense to spin unnecessarily when it can be avoided. We
> continuously improve the kernel to do the right thing—and unnecessary
> spinning is certainly not the right thing.
>
>> If a task does a while 1 in user space, it
>> wouldn't be much different.
> The while loop in user space performs actual work, whereas useless
> spinning does nothing but burn CPU cycles. My point is simple: if this
> unnecessary spinning isn't already considered an issue, it should
> be—it's something that clearly needs improvement.

The whole point of optimistic spinning is to reduce the lock acquisition 
latency. If the waiter sleeps, the unlock operation will have to wake up 
the waiter which can have a variable latency depending on how busy the 
system is at the time. Yes, it is burning CPU cycles while spinning, 
Most workloads will gain performance with this optimistic spinning 
feature. You do have a point that for system monitoring tools that 
observe the system behavior, they shouldn't burn that much CPU times 
that affect performance of real workload that the tools are monitoring.

BTW, you should expand the commit log of patch 1 to include the 
rationale of why we should add this feature to mutex as the information 
in the cover letter won't get included in the git log if this patch 
series is merged. You should also elaborate in comment on under what 
conditions should this this new mutex API be used.

Cheers,
Longman

