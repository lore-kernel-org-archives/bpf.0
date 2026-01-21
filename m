Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38445363C77;
	Wed, 21 Jan 2026 23:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769036759; cv=none; b=T6ZA+Cqshz1sEq2SGQVJdMd7vWNkVzWDrOkJyYJ/RkmrbHGANsdUWHBHaYmaAPFKjRaBhyZe0Znh7xtlhrgmoA5lRFeIq9xz5F+2JqD/O7GCKsk8YWonKfMgoy6df//xICOSDsLTTiPeWd3Vu/i+b0WOOZiAiXBiBPurHuNlpOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769036759; c=relaxed/simple;
	bh=Ue+KFqmPBWjlbMcUyRtsb/L/q1gc5YVaH8pxMsrHdRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgeGTDfO4CoM5OYzZzrs4yih6mDaHh9q2T7Ue5z8OadEtXwBe7Xruz2bZA4P2ZcuOKj0CWgsEI14M6fCHg0XfzxtV66KHQPVMRWZP4gJoQlEI1BMUcXcvuB7NWLkCovueHL+NgxyBtcgyI//NgdSF6li73FIGPCTRUSdR1B1CeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ue0Tl7q+; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ue0Tl7q+"
Message-ID: <3b4f4404-0298-4f9d-a6ba-e8b2f125818d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769036745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ue+KFqmPBWjlbMcUyRtsb/L/q1gc5YVaH8pxMsrHdRI=;
	b=Ue0Tl7q+A92I4Mkc2qNzP4zBrCvYq4xfB5zhioMQSQcwtmudCtdMtSVjkc6MyqBvIHKj76
	T7aSn8oA+w7y2Py5AG8cmmxsDBSk8rBmVfnuzNmpHcG6/G3H15aYnoFo6WTMT8m/aOts9l
	8QFDAIp/bscyQSCvtiXurvSQCbZc7WU=
Date: Wed, 21 Jan 2026 15:05:32 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] selftests/bpf: Fix resource leak in serial_test_wq on
 attach failure
Content-Language: en-GB
To: Kery Qi <qikeyu2017@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 shuah@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, yatsenko@meta.com, bentiss@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260121094114.1801-3-qikeyu2017@gmail.com>
 <214f9680-b4ce-4c20-85f1-3560624fb49c@linux.dev>
 <CALEuBam-2=QcXHH81RPdEcQ6zguY8EjzUt-Rh3BW=fn4F7vi_Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CALEuBam-2=QcXHH81RPdEcQ6zguY8EjzUt-Rh3BW=fn4F7vi_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 1/21/26 9:49 AM, Kery Qi wrote:
> Hi,
>
> Thank you for the review.
>
> You are completely right regarding wq__open_and_load(): if it fails,
> it returns NULL and performs its own cleanup, so an immediate return
> is correct there.
>
> However, my concern is about the next step: wq__attach(wq_skel).
>
> If wq__open_and_load() succeeds, wq_skel is allocated. If wq__attach()
> subsequently fails, the original code returns immediately without
> calling wq__destroy(wq_skel), which causes a memory leak of the
> skeleton object.
>
> The proposed goto clean_up is intended to ensure wq__destroy(wq_skel)
> is called specifically when wq__attach() fails.
>
> Does that make sense?

Yes.

>
> Best regards,
>
> Kery
>
> Yonghong Song <yonghong.song@linux.dev> 于2026年1月21日周三 23:45写道：
>>
>>
>> On 1/21/26 1:41 AM, Kery Qi wrote:
>>> When wq__attach() fails, serial_test_wq() returns early without calling
>>> wq__destroy(), leaking the skeleton resources allocated by
>>> wq__open_and_load(). This causes ASAN leak reports in selftests runs.
>>>
>>> Fix this by jumping to a common clean_up label that calls wq__destroy()
>>> on all exit paths after successful open_and_load.
>>>
>>> Note that the early return after wq__open_and_load() failure is correct
>>> and doesn't need fixing, since that function returns NULL on failure
>>> (after internally cleaning up any partial allocations).
>>>
>>> Fixes: 8290dba51910 ("selftests/bpf: wq: add bpf_wq_start() checks")
>>> Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>

