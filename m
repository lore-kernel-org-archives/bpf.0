Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D144851AFC2
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683263; cv=none; b=mtL7VzTMwPcoSE3u4mjIl0eVa/R3Bt7JF9dfEhdn4uKE8p68EPb12rnyuwPbn2ZnSDPfNPchZPUktA89jMnWbrv3aDCdoFjybYyBfjhkzrgRIy2zXvWYSLSHmxaKyZQqjQMC7osPhvHB/E/p5vLbMPIz8gzcFMQon34te/yBe1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683263; c=relaxed/simple;
	bh=qdhJGebqsfb0gclk8ihu6PI6J7GbV5Fek9Elmf6NIZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RK84/MZI/IbDkSKP0xynG2+bMD06fuW1sIOXHMl5maCa16LH5mk88JMCPDyKI1uEl6Yvfd6PHNK//cIJrUm8C/wFKbGySL9K4jxUxzy32dS8nNNB0RVoI8+9u3k8fIWZiJFxIl5hxoUqzlCOFIZNEdfvM1nbPySf8oeE5e/4W/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaAP5pPJ; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaAP5pPJ"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4885d4825adso2486680f8f.0
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 05:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790683260; x=1791288060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GTReE5FyogOIDiEYxZgO9GD5/QvwXo0l8UPlZCtTrY8=;
        b=CaAP5pPJyTjn3ksR7YNUjjokIhpNnWf9BUkPU/nX527gK0t1KbUBSFGb9hTtSRBHEM
         stoNrU31S2JOr88/FvFQmJGLTq8nz9+5SN5Xd2Nrv42rzOOm1n04tIg11dzIAY2I2wHU
         7r8RhoiY77zp+I0ReBFcPJvtv20ATZZuTPG9RH1NJ16P9AgdQXOJik0EbU0ehuGIZzs+
         iRC+ZT2ftlD+9eU1Ha3GTE3fG9XPNlEJGLawYUcmBgE4Gn9F4kM9Wj6gT0amjQd11H4C
         PPf+GD8QkR04kqDNGvkrMFth9fjxyLSFEdEu4PiZAeHewvNUfzjB/iPUNozR4K5I0T8+
         QrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790683260; x=1791288060;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GTReE5FyogOIDiEYxZgO9GD5/QvwXo0l8UPlZCtTrY8=;
        b=rIBI0yP6DWNxH7UrhRB/BxXwCizbvfwUCz9WnEpdTvkhTbhzSyFUTO7TRmbZhcy0cH
         fHc03ZmJ7bnIkobyDOKkEGtwcMuVEVCXzZRaKM1kiK5+T4ibUXBRpEH4bm9UOhdEwCAZ
         V1Ek32IXhTKgPW9i82UBPDuWlsNjkJBBCCKicK4OKkVL++/9OVruE9OxfRDwA0kMGE0k
         89S6XZyUadeDgU1R8nN7m7HjiElbJZiDRXXNPcBheLAtaC+FRJ8cLKWrG0lj7pu0Ydsn
         ZozJPNRDgKv7ZP75t5Xk6y4ij1s9fyZJusQa3Q+sHH/yMR+vO5/xsuNc8epGVVnB9OxL
         atDQ==
X-Forwarded-Encrypted: i=1; AKwUvByN2VVyvvAvwHpE+L2nKBA4vPA2g4TtC0mKfjTmdmW5F3DRCENLvIKC/gJJUEmZgepPTtk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIR1qaE0a4zzA7iAO6Tl1IjJMmcYi6tLTOFIcMd1EtjTXEqBDHa
	IAxlw+aHd1q/amJlD65Pzwk+CwSmxvM5i8LmG9a63igNV+fDRfbS2ZBE
X-Gm-Gg: AYBFou0Tm80++khigeXlrUJvpY3ltEkHzhdC6naYk08taSWpROcpwV1qyBcEKAs6iRM
	gZWHiPmXQ1drQZNci2n7iatiyFbH3rTpId6fwKgaIeEbUUQ/Zbyu8GEKfOXghHVuaWvKh/YfMZb
	OJLKN2UQkik5Kpd48hSB06Z3Ay72vRgBlXA0Dhyc5/RKp2a6BxakI+M4swPoX1gU56JAVJNErG4
	ZfjeTJ6AdGoCfunYQ24iOJP/zpR6GMpjscP8WLTJzVlV2hMrWEBBmotTxqt2l3cLXF04MqrCo6K
	hSoAaZoEVf5bTR7IInBM8xxSGq/d0sZi61aH98aAis2cWHlH5tFDOp76jLtHkf5iG6cOMuM0O6U
	g+zTAYn4Ukr4uoukHE3jlkGkjsISoQnnjAmPyOgSY9txi44M6R748mtFzAtaeE/gDClS4BZ+4O0
	L8cImoQQBcFNFzLm1VG3r/Kd00yxwcrcXERbxOdgS/OBbzbdM2o/5prFjt23FQhHnid4ltW0nZz
	9RYNU72OH5Fi+fEBUX5fp/FI4AJvFMVh3Q=
X-Received: by 2002:a05:6000:29da:b0:488:7737:7e5d with SMTP id ffacd0b85a97d-48877377f92mr15591801f8f.22.1790683259515;
        Tue, 29 Sep 2026 05:00:59 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:bbf9:6e62:677e:7b50? ([2620:10d:c092:500::5:e8fd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af502f491sm3308500f8f.12.2026.09.29.05.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 05:00:59 -0700 (PDT)
Message-ID: <e443d46b-1062-484a-a20e-20c0d85afa48@gmail.com>
Date: Tue, 29 Sep 2026 13:00:58 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Add task work scheduling
 race test
To: bot+bpf-ci@kernel.org, luyun_611@163.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev
Cc: yatsenko@meta.com, bpf@vger.kernel.org, martin.lau@kernel.org,
 mason@kernel.org
References: <20260929072800.113129-4-luyun_611@163.com>
 <9ea45b3f464aec62edb4a2797fe3450bae63a2d6c24666af13731730f89f39e8@mail.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <9ea45b3f464aec62edb4a2797fe3450bae63a2d6c24666af13731730f89f39e8@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/29/26 9:12 AM, bot+bpf-ci@kernel.org wrote:
>> selftests/bpf: Add task work scheduling race test
>>
>> Exercise task-work scheduling and callback execution on different CPUs
>> while userspace reuses or deletes the associated map value.  Run 1500
>> rounds rotating through context reuse, deletion after the callback has
>> recorded its generation, and deletion racing with scheduling.
>>
>> Publish the scheduling result and its generation in one packed value, so
>> userspace does not rely on ordering between separate map slots.  Record
>> callbacks in separate per-generation slots so an earlier callback cannot
>> satisfy a later round's completion check.
>>
>> Retry transient -EBUSY results while the context is unavailable for
>> reuse.  In the deletion-race case, allow -ENOENT if the element is
>> removed before a retry finds it.
>>
>> Choose two CPUs from the process affinity mask and skip if fewer than
>> two are available.  Bound the thread-start wait, report thread creation
>> and affinity failures, and stop the worker threads with an atomic
>> handshake.
>>
>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> 
> This isn't a bug, but could the changelog say which of the preceding fixes
> this test is meant to cover, and which interleaving each variant targets,
> instead of listing implementation details like the bounded thread-start
> wait and the atomic stop handshake?
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_work.c b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
>> --- a/tools/testing/selftests/bpf/prog_tests/test_task_work.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
>> @@ -5,10 +5,14 @@
>>  #include <stdio.h>
>>  #include "task_work.skel.h"
>>  #include "task_work_fail.skel.h"
>> +#include "task_work_race.skel.h"
>>  #include <linux/bpf.h>
>>  #include <linux/perf_event.h>
>>  #include <sys/syscall.h>
>>  #include <time.h>
>> +#include <pthread.h>
>> +#include <sched.h>
>> +#include <unistd.h>
> 
> [ ... ]
> 
>> +static void *task_work_race_trigger(void *arg)
>> +{
>> +	struct task_work_race_ctx *ctx = arg;
>> +	int err;
>> +
>> +	err = task_work_race_pin_cpu(ctx->trigger_cpu);
>> +	if (err)
>> +		__atomic_store_n(&ctx->setup_err, err, __ATOMIC_RELEASE);
>> +	__atomic_store_n(&ctx->trigger_tid, syscall(__NR_gettid),
>> +			 __ATOMIC_RELEASE);
>> +	while (!__atomic_load_n(&ctx->stop, __ATOMIC_ACQUIRE))
>> +		getppid();
>> +	return NULL;
>> +}
>> +
>> +static void *task_work_race_target(void *arg)
>> +{
>> +	struct task_work_race_ctx *ctx = arg;
>> +	int err;
>> +
>> +	err = task_work_race_pin_cpu(ctx->target_cpu);
>> +	if (err)
>> +		__atomic_store_n(&ctx->setup_err, err, __ATOMIC_RELEASE);
>> +	__atomic_store_n(&ctx->target_tid, syscall(__NR_gettid),
>> +			 __ATOMIC_RELEASE);
>> +	while (!__atomic_load_n(&ctx->stop, __ATOMIC_ACQUIRE))
>> +		getppid();
>> +	return NULL;
>> +}
> 
> This isn't a bug, but could the trigger and target threads share one
> function with a small per-thread argument (cpu and tid pointer)? And could
> the repeated 2000000 / 100 poll bound become a named constant, like
> TASK_WORK_RACE_ROUNDS?
> 

I think this is worth addressing.

> [ ... ]
> 
>> +		err = task_work_race_check_done(skel, seq);
>> +		/*
>> +		 * Variant 2 deletes the element right after READY, so losing
>> +		 * the race against the scheduling kfunc is a valid outcome:
>> +		 * the schedule itself fails with -EBUSY (ctx already FREED),
>> +		 * and the retry on the next tracepoint invocation fails with
>> +		 * -ENOENT because the element is gone.  Either way the round
>> +		 * exercised the deletion paths; a later variant 0 round
>> +		 * recreates the element.
>> +		 */
>> +		if (variant == 2 && (err == -EBUSY || err == -ENOENT))
>> +			err = 0;
> 
> This isn't a bug, but can err actually be -EBUSY here, given that
> race_sched_work() returns without publishing RESULT on -EBUSY? If not,
> could the condition just check -ENOENT?
> 
> [ ... ]
> 
>> diff --git a/tools/testing/selftests/bpf/progs/task_work_race.c b/tools/testing/selftests/bpf/progs/task_work_race.c
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/task_work_race.c
> 
> [ ... ]
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36538172291

