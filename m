Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5102FD1B3;
	Fri, 18 Sep 2026 02:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699051; cv=none; b=JtOXTAuuNBD6p/R1t7xHJE+xFdMUcus2rEy6uSHpdFTmIoUOwtO2eibu9JwRn/nQMYt2VYEoRv+KqTP/x055ZoYfVbCxNzEsiAOzEcEQz4RG/rTiRQMpteBkM6xsdc/W/MWwEik0/VnjVWqqst0SEYhAtJgtyHNeYpiMVaqAHSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699051; c=relaxed/simple;
	bh=26ofpiSnpoFPS7g88SGTCGreP7uD/SDa/M8h1GybdHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhfC7p12et+sX3CDZpaDELwiEgziV3pifjP1nBRKvxZPBsIz9CPOBEtEUQalHFOvTiRDYsIfa1We+JRQ7OrXUvl/DIS2SJpWCCTK1XvwC4J5+s2QTULwWNvfMxhRRIrjKTE1JKgRgmem+W6pAclovF6yWvOlVLCi7KPivUSqNWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lEGI8FWF; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lEGI8FWF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=26ofpiSnpoFPS7g88SGTCGreP7uD/SDa/M8h1GybdHg=;
	b=lEGI8FWFiAsVrntGzGKSFM1edV/P28f/Rp5N+mjEz70N7sfgkjqR3wK08/d+ZL
	j1XgxN/TqUIgarlL/W69TPQeyvf7+SoVzKCFrX5SHohA/lTX+XMZLKkMlIkUxxlJ
	DydL/poqlcuwCr3HVEz89aD8WZWvSjmE9euqBnN8W6o6k=
Message-ID: <3efb7a74-7b12-4269-9166-50835e130bdc@163.com>
Date: Fri, 18 Sep 2026 10:36:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/2] selftests/bpf: Fix timing-dependent assertions in
 task work stress test
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, andrii@kernel.org,
 eddyz87@gmail.com, ihor.solodrai@linux.dev, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 shuah@kernel.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260917080839.462038-1-luyun_611@163.com>
 <20260917080839.462038-2-luyun_611@163.com>
 <DLHO3FH8LYMR.33VPRQKV0T0TU@gmail.com>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <DLHO3FH8LYMR.33VPRQKV0T0TU@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCn8Quoo6xqBX16BQ--.8162S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr17Wr1UtFW5CFy5Xw43Wrg_yoW8CrWxpF
	Z0qay7tw4UGa42yr1qv3WrXa45uw4fta1UKrZ8KFy3A3s8CFsFkrWYya4F9rZ8Aw1rXw4S
	9w4Yqw17C3yDKaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5sqAUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbCwwnYp2qso6mjSwAA3R


在 2026/9/17 22:39, Alexei Starovoitov 写道:
> On Thu, Sep 17, 2026 at 04:08 PM Yun Lu <luyun_611@163.com> wrote:
>> From: Yun Lu <luyun@kylinos.cn>
>>
>> task_work_run() assumes every stress run observes both scheduler
>> contention and, when the delete thread is enabled, cancellation of at
>> least one pending callback.
>>
>> Neither outcome is guaranteed. Contention is observed only when another
>> scheduler selects the same one of 128 map values while its task work is
>> outstanding. A valid run can therefore have no scheduling errors. This
>> was reproduced with a single scheduler: more than one million callbacks
>> were scheduled and completed while schedule_error remained zero.
> So it was "reproduced" by changing nthreads from 16 to 1 ?
> That's not a fix. With 16 threads hammering 128 entries for a second
> schedule_error > 0 and callback_success < callback_scheduled are the
> point of the test. They check that the -EBUSY path in
> bpf_task_work_acquire_ctx() and the cancel path in
> bpf_task_work_cancel_and_free() were actual
> ly exercised. Without them
> the stress test only checks that nothing crashed.
> If the unmodified test fails somewhere, show the log.

Hi, Alexei


Thanks for the clarification. You are right that the zero-contention
result was obtained only after locally changing nthreads from 16 to 1,
so it does not reproduce a failure of the unmodified stress test.

I reran the unmodified test with nthreads = 16 for 100 iterations in
the default environment, 100 iterations with all threads restricted to
one CPU, and 100 iterations in a single-vCPU QEMU guest. All runs
passed, so I do not have a failure log for the upstream test
configuration.


>
> Patch 2 is fine on its own. Send it alone against bpf-next.


OK, I will drop patch 1 and resend patch 2 alone against bpf-next.


Thanks,

Yun Lu


>
> pw-bot: cr

