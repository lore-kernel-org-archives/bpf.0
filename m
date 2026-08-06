Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316353DFC82
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008730; cv=none; b=BN25u+WqgO1drtR3/sh9fTcO8F1jLWV3fT6q5JliSrB/Ug2z131wlvjAa3dle1DUfPtinNLbxyUDlsJr0Q8kcXXuBustUzc6KalagLS/LRHAHGvEzqPeGL6evLwGN9ToHCh4mNysrYWSlM7vKuk11YswfDqNOhx8jHBzNkQ0T40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008730; c=relaxed/simple;
	bh=0tFWkmtlJNhtJXVHM8POMPbqoAu+ddTnlBMhmmxP1e4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gtXYTvKNHX/MbtpEn5Ep7VgObxRsBFGL8lvUC1OXZE3pZWN1KF+7GvXghl2ETIfJMcfeFt9eH1AQI71BMNlopgvHZZDVS1lTLpJhY++uHBDeSgQvAt2NmsPQbP2aUewwfWDYr8s7OaDmM0MTE/cKvoSHjH2WNO75GdZUdZExfRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsBCUsee; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsBCUsee"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-49242309566so4381715e9.0
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 02:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786008727; x=1786613527; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oSqaiLHhKVpqwKh9qJg7C60sOI+DPd/x+924Kr388uo=;
        b=IsBCUseeRhZScAmvh6pU2tcTg8PxAO4OwQEfzEuhbKqTeiIEo/KJGduAGmJcC+LMxw
         yOOcHaUq4FhL0o5C+ICk+QtmIkBwuOLL7qbLcB/d6XtihpS5APt2EK0R6JXn8MNSFpNE
         SEsEMJ7xwLLe9b6o8dmpSCn/uCGgxfDvRROQB6cq9xzv6mCdc1HszMguRQJlu6ytM4NM
         IhOZI6ex05zJHMASQhkjVwQEYsSwrNYb8MAUhtWBz+xxHtmUl9c/upm4dM6RUVqdOS1t
         tL+mBzCr8uE5u9SANGuaVQGSTOKfvDlgbMOJrYe89m6nC9LEeSlB7Da9ySERIs+Gm2lZ
         +1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786008727; x=1786613527;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oSqaiLHhKVpqwKh9qJg7C60sOI+DPd/x+924Kr388uo=;
        b=WvYHDuX5CD9N7WxJF/2NdX7E+XWDJXhujyifr7pZgGnxFqO58Zz/wOEZs1go3giqvW
         bkb9Qo+6old4axuUt6qaAUmNpddtBaDubpsX6xrtdV8WczThxbP2Y/d4CLlKtfgq+QGt
         +eBdnfOq1NEqeJCpb7p9axNAri3ikZmBXB6MYvgNfC37LyaC0njxheUheBdbF9wTuQ7N
         QXje+wzI+J+d4L37SrguhSTODANNCGyBllWOq+PhZPnvX/UZ8q1KP43gWLm1aaa7oNle
         bigtUgCLSI1e5gWGLKTWBW3CTK870i6XUqZa9Am8GIX14rl6udWuw4wUEkJD2jPjjlO0
         EKqw==
X-Forwarded-Encrypted: i=1; AHgh+RoWLwGyg3Tm72PuFGP6UItIbVXA5qNfgcl0S21wtpcMnTbwclsNxr3q+bZ0d8Eh2XmBJFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzvDf/LGSK+PlNIkdjywLc7CgTKj5QFqfudMyqLl0ztRsSVSbw
	VPJQKFmDD75PVftvVaJsS34CPAL1ax24y3GS9sRCi9SSKq5VY63Y3Eam
X-Gm-Gg: AR+sD137W09q8YXEwJFi04si/QlJTXcBkbjkzWhDGXiGBbAJzGvjspAwYnc+f+ccRcg
	x9+sNxTsoeyp6/OH9TXd/xnlMyyM+CaiZxs3X37ii60JNDIs/fTF6fNlo0hhg/WTs8u3ASsSfNv
	C9wSNEc2kk4IWuAz5+22bybI9i6ZrfDia6MC2raNaYsEh/fJlHJhO+rlFSdArEG8X5WZt+9fPrT
	9AXaMj4o+d2d7kEoeoaCeiStpiJkwDGQAVmoesUwciNVYao57iht0SKNxnGkDhKOSiV2oi57K5D
	UUFqgzftout4tNTdau0npBidnWYa4LQQH76MTCnBANnBCb1nBZJJVoDoegkOsI42CGV1OH2pMa+
	RDVuEWv9yl5uHCXOYd3OOU6IPZfqMbJQH8AvEU8NbklJeIHmUt2e3iqUVqa67B/Y5xqrdYKzTOa
	9JyL6P4xXVoCy+2lN5ZPtw4Z5WHgToOvaDAZlGiapfb4OkajTxBydPL5SvevN0ACbcfIz8SuV0X
	piyWmhAA9CCMZ4TBE41sSS7srEUAdMZv2onMYJTGxJafnMvdRZgsdxNW7WZMw5EceUrY/+FxyL+
	NR0y0cSSGsUP2Xv01Smmx+BSQNk=
X-Received: by 2002:a05:600c:1c25:b0:499:4e47:eaf2 with SMTP id 5b1f17b1804b1-4994e79dbf0mr189219895e9.6.1786008727015;
        Thu, 06 Aug 2026 02:32:07 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499541b525dsm59425675e9.0.2026.08.06.02.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 11:32:05 +0200
Message-Id: <DKHR95T6P1ZC.G09YF6M1QEL2@gmail.com>
Cc: <puranjay@kernel.org>, <paulmck@kernel.org>
Subject: Re: [PATCH bpf-next 0/2] bpf: Track overlapping RCU protection
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Ning Ding" <dingning04@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260805233940.3966981-1-dingning04@gmail.com>
 <DKHQUVB5TV0R.1OLK7GG1APAOR@gmail.com>
In-Reply-To: <DKHQUVB5TV0R.1OLK7GG1APAOR@gmail.com>

On Thu Aug 6, 2026 at 11:13 AM CEST, Kumar Kartikeya Dwivedi wrote:
> On Thu Aug 6, 2026 at 1:39 AM CEST, Ning Ding wrote:
>> Preemption-disabled and IRQ-disabled regions provide RCU protection, but
>> the verifier does not account for them. Current implementation can inval=
idate
>> a task kptr while another RCU source remains active, or keep it valid
>> after the final source ends.
>>
>> Track these regions and invalidate RCU-protected pointers only after the
>> last protection ends. Add task kptr tests for overlapping protection and
>> final-exit rejection.
>>
>> This follows review of the applied spin-unlock fix series [1].
>>
>> Tested in QEMU/KVM:
>>   ./test_progs -t task_kfunc
>>   ./test_progs -t preempt_lock
>>   ./test_progs -t irq
>>
>
> Overall, looks good. There are various failures in CI, so you might need =
to
> update or adjust existing selftests.
>
> Make sure to include selftest changes for _existing_ tests within the ker=
nel
> commit making changes, so as to preserve bisection. Your extra tests shou=
ld
> still go in a separate commit.
>
> Also, do we need that was_in_rcu_cs logic for bpf_spin_lock(). Would it b=
e
> possible to drop it and do it the same way you've done it for other cases=
?
> If that makes sense, I would fold that cleanup in the first patch as well=
.
>
> https://patchwork.kernel.org/project/netdevbpf/patch/20260805233940.39669=
81-2-dingning04@gmail.com
>
> pw-bot: cr
>

I think from cursory look, the reason is that we forced any MEM_RCU pointer=
 to
be invalidated before, even when program wasn't sleepable, which does not h=
appen
now. The failing test used a non-sleepable program. So making it sleepable =
should
preserve the failure case. In some ways, this is probably an improvement ov=
er
current behavior.

>> [1] https://lore.kernel.org/r/20260803112615.3362122-1-dingning04@gmail.=
com
>>
>> Ning Ding (2):
>>   bpf: Account for preempt and IRQ state in RCU protection
>>   selftests/bpf: Test overlapping RCU protection
>>
>>  kernel/bpf/verifier.c                         |  13 +-
>>  .../selftests/bpf/prog_tests/task_kfunc.c     |   6 +
>>  .../selftests/bpf/progs/task_kfunc_common.h   |   2 +
>>  .../selftests/bpf/progs/task_kfunc_failure.c  |  49 ++++++
>>  .../selftests/bpf/progs/task_kfunc_success.c  | 147 ++++++++++++++++++
>>  5 files changed, 214 insertions(+), 3 deletions(-)
>>
>>
>> base-commit: 11c1e836710dcba03e50454a4eedfdbaf8d3050e

