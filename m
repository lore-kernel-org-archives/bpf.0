Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7FA3EFD21
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 08:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535320; cv=none; b=YSsSr9KJpXsNA3ab8zycjTgmTIpyzKUkNSrio19LBmFpAqtrlfTjPRySHeWOvXPDXqI2DntO9Byb0ZqqqUD4xB+7Oi3Pq3oiUKdgrqMT70hguNetoFUm7LE3U6DeUSt0WvCMV5i9dUC45GGChiaGcE++egrYurQB7iJkgzUZRhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535320; c=relaxed/simple;
	bh=w5DCDJVn95Yo5XIl3127SNSbiovw7McPLZin5c/THbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZi6/WBsNHiDmX8JSbLAi+i4sF1E6Uy5D3RXYf2ktupUCafxYZZt8R9HpTjpJb4ZYpufd80acnYYWeZBWjmFl03tsoAJcgheftcu0BL0cwwu6WUn0cQfxpvfRl+rOutzu+mhs1J0zWAfSbTZzxnfYWaXOlz8VN9ara+D9xV2SDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LG3X0e3A; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LG3X0e3A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=3JmF3y+xgyOSESSfmeO6eN8emoVJjuAe/ppWqqYZVUY=;
	b=LG3X0e3AMGIN2A0QVBO634GaOPWuqydfCIWhN+/UnN9RSOi7VrZerW9iJHRpiV
	bkRoSn/tsvx/BKRYL4OkYsYOQBojx01eJ6q2GiUqIK1//RKOkCuVj7DTPZm4SrR3
	qoj/lZV+lg8hVRiLL215N8pZAfO9tUj7/vvD7GPcHOjX0=
Message-ID: <b240f38e-ac1e-4eb5-9f7c-192c160af374@163.com>
Date: Fri, 9 Oct 2026 16:40:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: Add task work scheduling
 race test
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev
Cc: yatsenko@meta.com, bpf@vger.kernel.org
References: <20260930085417.186729-1-luyun_611@163.com>
 <20260930085417.186729-4-luyun_611@163.com>
 <DLUBLDLVFYLU.393R1ZG12F4W9@gmail.com>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <DLUBLDLVFYLU.393R1ZG12F4W9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnF3uaqMhq1C27DQ--.11171S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4DWrWxJr17tw4UXFyDGFg_yoW8AFWfpr
	Z8Kry5Jw4kAayjyF47Za18AFySkwn3t3y5Gr48tr1xA3s8Wr4fKryfK3Wjyay7ur4vgF1a
	vw45Z3yxGrWjvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5sqAUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbCwxsd62rIqJvHHgAA3m


在 2026/10/2 19:36, Alexei Starovoitov 写道:
> # DECIDE: optional, log accuracy only. 1/3 and 2/3 are unchanged from v4 and fine. Drop pw-bot if you apply 1-2. Delete this line.
> On Wed, Sep 30, 2026 at 04:54 PM Yun Lu <luyun_611@163.com> wrote:
>> Add cross-CPU stress coverage for the captured-task cancellation and
>> irq_work context-reuse fixes in this series.  Run scheduling and the
>> target callback on different CPUs, rotating through three map-value
>> lifetime patterns for 1500 rounds.
> This test cannot hit the bug from patch 2.
> race_sched_work() is the only caller of bpf_task_work_schedule_signal()
> and it runs in the trigger thread only, which is pinned to one cpu.
> irq_work_queue() queues on the local cpu, so bpf_task_work_irq()
> returns before that thread gets to the next getppid().
> irq_work_is_busy() in bpf_task_work_acquire_ctx() is never true here.
> The target thread doesn't exit, so task_work_add() never fails either.
>
> Either make the test cover patch 2 or say that it's for patch 1 only.

Hi, Alexei

Thanks for reviewing.
Yes, the race test cannot reach the BUSY window: the trigger thread
is pinned to one CPU and the local irq_work invocation completes
before its next scheduling attempt.

I'm preparing v6: the existing test is narrowed to the cancellation
races it covers, and a new task_work_busy test constructs the
STANDBY + BUSY window directly (an fexit program on task_work_add()
delays the scheduling handler, and the target thread attempts to reuse
the same context from its next syscall) and asserts the in-window
-EBUSY rejection, the successful retry once BUSY clears, and
exactly-once callback execution.

I'll send v6 shortly, once the new test has finished verification.

---
Thanks.
Yun Lu

>
> pw-bot: cr

