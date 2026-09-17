Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F504AC149;
	Thu, 17 Sep 2026 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648354; cv=none; b=eIVyGbpsligiL+8DMKVP8JHAMGiri8mEPivAyMP9Hp74luE7GJ6ftRyG6yW3D5MmiQURh3wA3l5mMz4u0O12ZI+vYj1371vEw72hMv1iKLCYZPrJERN/uOCDBaaPSPoiJJPKUIAcDKhqkYWZcV6LYEu01CBJet7YMvL6aGDfx8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648354; c=relaxed/simple;
	bh=aJiF+doRyO3eXif4YHhOlFRuWpg73AkhKycRAGqVZi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQhYzMQgFxOorxUVy1mSlBjG84nqu7pG7eqz4Px0oaS12QeaoD/JhCV7SpTI9Moy3qEAIJqebsMi6Nr2XuGAoxNBrqwn8HMvx263+H1RQ5mAivXOoi7YewWBfP2PMYOpmCWgGiI6rymwmj8eET26Lul5Y5TgXavOxSEyynLjiEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dkkupUwu; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dkkupUwu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=zOmtb+AOaI3k9OHip3G+6xsDVCwh2HkZuKcbtFQGgCU=;
	b=dkkupUwuCxQVvbYZ+O4K3WAUp6LMBltMuqN1ereTtxvxbdJicSlMNzbrII87Sl
	wvpHrUS8SXurECI6r0MBjdA6hcLkOj7xlbkzW9T07urj3ir/yMaB8DSa8OoVXF/n
	xrcJ2M8x7YKkzWvbmuCmwxWoyAw8ChjEh1EWxqcG/Dnag=
Message-ID: <d80f4015-6ef9-4ce8-bb77-b25e902b5059@163.com>
Date: Thu, 17 Sep 2026 20:31:31 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/2] selftests/bpf: Fix timing-dependent assertions in
 task work stress test
To: bot+bpf-ci@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 ihor.solodrai@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 shuah@kernel.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20260917080839.462038-2-luyun_611@163.com>
 <80c4a1ad857e4007c54a10110ff85897791545942a2cb3be4d9f5e69cd17de82@mail.kernel.org>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <80c4a1ad857e4007c54a10110ff85897791545942a2cb3be4d9f5e69cd17de82@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAn_6Ck3atq4Z41BQ--.44139S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF47Xr17uryDArykGw13CFg_yoW5CryUpa
	95Kw47tr1qkFy2yr4Ika1fXa4Ykwsaya15Grn5Kr1xA3s8XF1xtrWxtF1YgrW7Aryvv3Wa
	9a1Ygws7CrykZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UuyIUUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbCwwYm9Gqr3aY5MAAA3k


在 2026/9/17 17:00, bot+bpf-ci@kernel.org 写道:
>> task_work_run() assumes every stress run observes both scheduler
>> contention and, when the delete thread is enabled, cancellation of at
>> least one pending callback.
>>
>> Neither outcome is guaranteed. Contention is observed only when another
>> scheduler selects the same one of 128 map values while its task work is
>> outstanding. A valid run can therefore have no scheduling errors. This
>> was reproduced with a single scheduler: more than one million callbacks
>> were scheduled and completed while schedule_error remained zero.
> This isn't a bug, but would it read more clearly to say something like 'the
> task_work_stress test helper' (or name the file) instead of the bare
> task_work_run() in the opening sentence?  There are three functions with
> that name in the tree: kernel/task_work.c, prog_tests/test_task_work.c, and
> the static helper being changed here in prog_tests/task_work_stress.c, so
> the bare name could be mistaken for the kernel function on first reading.
Agreed. The opening sentence will be reworded to "The task_work_run()
helper in prog_tests/task_work_stress.c assumes ...", so it cannot be
mistaken for the kernel function of the same name.
> This isn't a bug, but was nthreads reduced locally to get the
> single-scheduler run quoted here? The test hardcodes 'int nthreads = 16;'
> (prog_tests/task_work_stress.c:50) and the only environment knob is
> BPF_TASK_WORK_TEST_TIME for the duration. A reader trying to reproduce the
> quoted numbers has no way to get there without editing the file. It might
> help to say so explicitly, or give the 16-thread numbers, since the test
> has no knob for the thread count.
Yes, that run came from a modified copy of the test with the scheduler
thread count reduced to 1. v2 will state this explicitly: "reproduced
with a modified copy of the test running a single scheduler thread
(nthreads is hardcoded to 16 and the test has no knob for it)".

These are commit message changes only; the code will be identical to
v1, and 2/2 is unchanged. If there are no further comments on the two
patches, I will send out v2 later.

Thanks,
Yun Lu
>> Likewise, a successful map deletion may remove a value after its
>> callback has completed. delete_success can therefore be nonzero without
>> callback_success being smaller than callback_scheduled.
>>
>> Drop the assertion that schedule_error is nonzero. Keep requiring exact
>> callback accounting when deletion is disabled. With deletion enabled,
>> allow equal counts but still reject callback_success greater than
>> callback_scheduled.
>>
>> Fixes: c6ae18e0af5e ("selftests/bpf: add bpf task work stress tests")
>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35199472874

