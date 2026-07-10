Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2845B383316
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 19:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711132; cv=none; b=ZZ33XVQ6DQrc9CscXiO0x+SoDVsTQ6vKjJtTdTnDfJD26sE6XNAS8GYaM0qGw9ycyAJ9D1Sv6xWD9+1hqwkLx5d5cVkuJwerzxF4VDhL85jZRwCrYnHnkV4X115PQ7iQR19t/uHqGW0rKyB8SLWZxoSv9AssXNbovKmQztC2A6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711132; c=relaxed/simple;
	bh=tz5l1P2egXZ+99pX+TrYhBbm0hYsBmZPTPE5maYt1kM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=abTIYtqS5NeRHi8I6NEZdDCpUBAe6UdJ8jreoX2OAvl/85PrLHR9up2G/schmircYnSoIgz+QamJlPzFQGdNs0/Jfgw+pl2Rv+0wGkGTZ7kN3lg6AjikJY1qH+g4nTuVTjkjAMmBm3MumuKlVOc0PnXw7DLPYx/Y0zsNxCxOsuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mq/tGkon; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mq/tGkon"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-4667c5dfa9dso369102f8f.0
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 12:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783711129; x=1784315929; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Tp/39SgrHI5z29550UsltrkPPkRKtfmpmPjcf1jfZbw=;
        b=Mq/tGkonFACk1P9wdfWF/4R5RC/QlnyMrDlawuACBa69kydNIenmMEFr4JkK3r3ntz
         qU4JbK9NJgVXltB8N42X+qH+lyF/FLRtHjdgi/Vrys+AFoqyubir7Ko1z4LMCPXZboe2
         ozUOCJLcXjpZ83tkZSTxT+GjOk0O4zuaMn+iDhut5j9ucwiTEYxElXA51Nr1JXs+v7CU
         T7WOoew2HLNqUQrhPjTR09QuZXuFF/ezyjxfawrt2jE/HAgffHqgT73a9svKfDHUimrb
         XVo4naQn+ryYnwdgn5Cqzn6EzzxFjjPzedGPNoTO1caYj6Vlxr247JW/0MSIWsBwNbrJ
         LlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783711129; x=1784315929;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tp/39SgrHI5z29550UsltrkPPkRKtfmpmPjcf1jfZbw=;
        b=cxG48fdVfoGRI9BUSlk56JSV/7tUkH9de1RIIFX7/2ONaO7SKzEjYMnl3Agzp41u4B
         rPvCAQpEtbn9zydKJR5eoOu4D83+0gIktkZvZ8iZ9mnm69a4CrSvtEnX5JhCFB5dGr46
         bjBBcwrhAE2Q/QUv58gUOPTopVgczNgj7TQ+K/XaVVeHBVzWrMNqsgKaqi6TM7xbJS1X
         qgH0e5mGS2NmRbt5DTbWH8PtzU6JIwX6us+Ylz7a0qBgKMapXlhwk1wEMaDAyGMhE0zd
         1v9L4/u3U60TTfyFtDgxoUM/Uu9sWYi1Y6FR2qYxHRt9zqZQsNIW0D+c+6j9tz/dGqj/
         Ng9A==
X-Gm-Message-State: AOJu0YyfmThFzF1ESmpCPvBS6onGb4ZU1kDHawW31hiMiEoM35J8Knhy
	4Y2cTyG4Ace04PtXqQoEW+MRk9IhLgQtZhwIufQh9LHVMwXAyVEgVrbmwN8l3XKN
X-Gm-Gg: AfdE7cnFqTKkoPwi+99D87Ga0m5vw8mFPsI7gJW9DCWs+qPmvh5tG4WXcNBIylz6GpX
	Z86E1kj9/m5t2oDf1+wpe26+waFqDfiFlyjlMDJX5aHz2Mqo0W3oiMlKqzy0uiir235VOEQLo3e
	KvcXZPlXRBAa5H/9x0h+hmQc+eFaTnh4L0YyYY61OWCcoQukYNqeQWLfp4JMhnO4rtkgtUpzhVj
	1parFIH+xEzayh0xR+CYPzh/aMFkPjR0UOF9zkCBerFBWxfYwjG1Y79hk0HQ6Lutc+eEvMefylt
	RjlUNk5HugKYW0wiaviKYjwK9sWH7oz5sj3k+tLYSMZfloinbbUFJYU4qAspedgTxMqyJ6Hc8ks
	laxtrFmw6Mced1NUGq9AREKh9FsotNI26nasSqPIZjwbgZ0vzYEf/taxtqIl9iopbytOIZ0Oyuh
	D289N8tDH+WBb5ZaSeJM1JKYeMAx4L2YDRUGqSOl18SMsg0NBCSZrgejR9kSBVd3XZgGtjqBMHt
	sfGu/BUPJ2UNBp4r7oXcSuq4tADPiMU1V6wdUK48TG0edSNSCe1k28=
X-Received: by 2002:a05:6000:2912:b0:454:a41f:d082 with SMTP id ffacd0b85a97d-47f2dcb3f2fmr79469f8f.3.1783711129397;
        Fri, 10 Jul 2026 12:18:49 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm63392320f8f.15.2026.07.10.12.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 21:18:48 +0200
Message-Id: <DJV4TO9OH6AN.58C10SBPE8FF@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Nicholas Dudar"
 <main.kalliope@gmail.com>
Cc: <bpf@vger.kernel.org>, <sched-ext@lists.linux.dev>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Require a BPF cpumask for
 bpf_cpumask_populate()
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260709182800.2037938-1-main.kalliope@gmail.com>
 <20260709182800.2037938-2-main.kalliope@gmail.com>
 <20260709183918.E42371F000E9@smtp.kernel.org>
In-Reply-To: <20260709183918.E42371F000E9@smtp.kernel.org>

On Thu Jul 9, 2026 at 8:39 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] The BPF selftests and their headers were not updated to reflect t=
he new `struct bpf_cpumask *` signature for `bpf_cpumask_populate()`.
> --
>
> --- Patch [1]: [PATCH bpf-next v3 1/2] bpf: Require a BPF cpumask for bpf=
_cpumask_populate() ---
> commit 79080c077263fb184f42fe92f3d8db1f3967a4b5
> Author: Nicholas Dudar <main.kalliope@gmail.com>
>
> bpf: Require a BPF cpumask for bpf_cpumask_populate()
>
> This commit changes the first argument of bpf_cpumask_populate() to requi=
re
> a struct bpf_cpumask pointer instead of a struct cpumask pointer. This
> ensures the function follows the same ownership rules as other mutating
> cpumask kfuncs.
>
>> diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
>> index b8c805b4b06a0..1336a4efa7553 100644
>> --- a/kernel/bpf/cpumask.c
>> +++ b/kernel/bpf/cpumask.c
> [ ... ]
>> @@ -467,7 +467,7 @@ __bpf_kfunc int bpf_cpumask_populate(struct cpumask =
*cpumask, void *src, size_t
>>  		!IS_ALIGNED(source, sizeof(long)))
>>  		return -EINVAL;
>>
>> -	bitmap_copy(cpumask_bits(cpumask), src, nr_cpu_ids);
>> +	bitmap_copy(cpumask_bits(&cpumask->cpumask), src, nr_cpu_ids);
>>
>>  	return 0;
>>  }
>> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/=
include/scx/compat.bpf.h
>> index 87f15f2962348..3f74d522f7e79 100644
>> --- a/tools/sched_ext/include/scx/compat.bpf.h
>> +++ b/tools/sched_ext/include/scx/compat.bpf.h
>> @@ -84,7 +84,7 @@ bool scx_bpf_dispatch_vtime_from_dsq___old(struct bpf_=
iter_scx_dsq *it__iter, st
>>   *
>>   * Compat macro will be dropped on v6.19 release.
>>   */
>> -int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz=
) __ksym __weak;
>> +int bpf_cpumask_populate(struct bpf_cpumask *dst, void *src, size_t src=
__sz) __ksym __weak;
>
> [Severity: Low]
> This isn't a bug, but should the BPF selftest headers also be updated to
> reflect this new signature?
>
> Looking at tools/testing/selftests/bpf/progs/cpumask_common.h, it appears=
 it
> still declares the old signature for the kfunc:
>
> int bpf_cpumask_populate(struct cpumask *cpumask, void *src, size_t src__=
sz) __ksym __weak;
>
> Because of this, the tests in cpumask_success.c and cpumask_failure.c und=
er
> tools/testing/selftests/bpf/progs/ continue to use explicit C-level casts
> from struct bpf_cpumask * to struct cpumask *. For example, in
> test_populate_success():
>
> ret =3D bpf_cpumask_populate((struct cpumask *)mask, bits, CPUMASK_TEST_M=
ASKLEN);
>
> While this doesn't cause runtime failures since the BPF verifier matches =
the
> runtime register BTF type instead of C-level casts, updating the selftest=
s
> would ensure complete consistency with the new kfunc signature.

Once this lands, please send a follow up to address this.
