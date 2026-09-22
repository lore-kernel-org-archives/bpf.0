Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com [74.125.227.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B202448423D
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102161; cv=none; b=Tror/XfhnKxYxL+Zl9EZpAhQtQpBnbJ2aBSLWF04R6lBNLN5Z2Q+kfUx68cz41T7oqCsSwPoGdxtha38Tv1Icsp8aw5Gzhz7M+OpuazdzARQu5gq26kNyZYZS0Qve1Nf4pcGKiRxwO/QXs6Yl8SXz47L7JECr2ypzUvJ3JzrDqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102161; c=relaxed/simple;
	bh=FiXQQMnSThXNo69Khk8wztrgg1MwX3yS9NudTb5lLzE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=c+pZoqsxvdIROcqUgVvgYdJoHhbWO7zlNsQeptwdeHibgccBdN4cNfGaVSPcmQ6OpsfPLQUVESEsYMXAtwS6A3uWNhPlCVRuM+Y+WyvIbfT2WvuEectrSELFY+ll1jwIaoenziNdlEUW/7uOEr8eu3KXLWvXHN77kDYYRCXqj9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qdga4HmU; arc=none smtp.client-ip=74.125.227.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qdga4HmU"
Received: by mail-pj2-f14.google.com with SMTP id d9443c01a7336-2d747f0135fso1292565ad.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 11:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790102158; x=1790706958; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fv1Vy7Ad4KYNfz8s9Yj2zAWmlMEYHenEzx9mXO0mK3w=;
        b=Qdga4HmUhNHZUgFQ2vXg3po8MYe4b4qJdWSpOHTxSDfTWMUygebO4lq9MZZOPmdkT7
         VO8Gi3PPMcuYlne1lR5FIJAMGpurHmCd22HviRrtc41Glf/UX2bQRlOJuDBd8qgg6nqq
         r1ffPiW4HV/t2ZBx8OcO3qRTrmBJeCL8FptBULlUjarXINk4CGJGdnrgt/g75m6oqbkl
         GjOnPTAmEHGCRyCxkE0nM3Rtabehq3tkWychOaB4bCstreFTyiqZtL85W2IAvRp63jtJ
         HnWkKy+z8R3+DV84QkA2LfEkEb6Zzo3Wg3rqcRpeF0jggDyPhbfxV1wMlaya6AkMgJM/
         K8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790102158; x=1790706958;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fv1Vy7Ad4KYNfz8s9Yj2zAWmlMEYHenEzx9mXO0mK3w=;
        b=Fp7Sm478+ktcJx/I9Mf+qTECWA6Sqpb/0iwpEGib2kIkUkXQn+drHczIK8NynETOEW
         VvmmDjzLiHd3c0YmQpcMS2JehybkjsYd0CJkIR9Lf0WWg8fJ7ChUY0CPkO/H0IEo8XFb
         lh7Wmd6ktpLxQUUzccjyWjujFbh5jo6hwJvYSFMviYU4v5p22uHGuLPGkJjN8Y4+5E+m
         ELkBa3XR3x6qKtJlgB+b64I0SrEOHaVbRkGCCdQBUOHmMcttJyavG4Un7UoHPk7MsN/p
         3JoX7qg5GYs1YZQJp+r5rt0Kw/3/yCdvsk+wmJKHuOYuWiyIbkyxYkigNQLfcF2jNp8x
         GLJw==
X-Gm-Message-State: AFuF++kxrh9g6UbBPW5PNvOVPpvPpGiARny/zyiG5BRvUBAciAhFoZxz
	l0p499mbvImEVuCPG39iymKQtohXwtrsdW/DHkpRm+gd2dW4fqJZoP3O
X-Gm-Gg: AYBFou2J/vA5fu4t+qQi3bgB4j2tzIc3brvHfT+tU6D9NjqdZ/4RoPBT9A72iX/n67d
	aiFzUFq74RCr+G/H2o4TZSjXIgQbM8YLFz9kRJEorMZReH2Y+XbQaD5A7Z5D4OxHrXE5cIt3TOW
	px3QdsoNHrtukNnlePZWNXVuNNA7254R/F0Wcc8EIJ2OHT7rSGfsbTC4xNvRyzKG3CrZxZcHsAn
	PiLCzD+5LOgFehQiyijp82kCIpxizI1tgvOyAl2+0YplK1KPvWtRGHyi3bPWEGOP8tKRmeGrnkO
	w76NQY3nkwzgM+UnANBhZZm/VB4HGsqZ3ZEYtNzeJEYBObeNYtQD1ZSiAJF+37cdcn0YsxIdVRu
	XTPTthHV5eY4UGJxPWBsAvrj1xUX4TSQpkbW/uOMQxj5TLnLJQB+pZvqaWAi5hfPlElsqqtHx2G
	yGIIdnIbsmxNczXMfUj9W89xzZfjcgthT1Kz1jR+ml8zz6JEk3ZoH751DQeELTcrEz0kIcQnPAD
	8p5JDqOtC8Q33+FAnJYX64YD6MEzg1r1/zaK2QVLAStRXcxpgNKAjC5Z/j0bHFhWwOr2OOXe+CH
	8PDvHL+SZv6thQ==
X-Received: by 2002:a17:903:370b:b0:2d0:cc92:f7c2 with SMTP id d9443c01a7336-2df69d332cbmr2348995ad.1.1790102158303;
        Tue, 22 Sep 2026 11:35:58 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a517b8dsm155205ad.10.2026.09.22.11.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 11:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 18:35:57 +0000
Message-Id: <DLM296AAASVA.3IGQUR5NOALQ6@gmail.com>
Cc: <bpf@vger.kernel.org>, <rcu@vger.kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Harry Yoo (Oracle)" <harry@kernel.org>, "Paul
 E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: Add bpf_call_rcu() kfunc
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Puranjay Mohan" <puranjay12@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260921191407.1742386-1-puranjay@kernel.org>
 <20260921191407.1742386-2-puranjay@kernel.org>
 <DLLGX9F9UG4Q.2YJWNSO4FXT1P@gmail.com>
 <CANk7y0hpi+vjXCR1oZBoeL8XLDss-HoufJfYkqNwRUXghFYCMg@mail.gmail.com>
In-Reply-To: <CANk7y0hpi+vjXCR1oZBoeL8XLDss-HoufJfYkqNwRUXghFYCMg@mail.gmail.com>

On Tue Sep 22, 2026 at 2:17 PM UTC, Puranjay Mohan wrote:
>> > +     prog =3D bpf_prog_inc_not_zero(aux->prog);
>> > +     if (IS_ERR(prog)) {
>> > +             WRITE_ONCE(rhk->armed, 0);
>> > +             return -EBADF;
>> > +     }
>>
>> can we drop prog_inc and remove prog pointer from rhk ?
>> with something like if (prog->has_call_rcu) rcu_barrier() during prog un=
load?
>
> That could work but we would need more than just the calls to
> rcu_barrier_tasks_trace() and/or  rcu_barrier(). As the rcu_barrier
> only waits for callbacks enqueued before it was called, the registered
> callback and re-queue itself and cause problems. So, we would need a
> flag that is set before the call to rcu_barrier() which stops further
> queueing of callbacks from that program. Also, assuming we add these
> barrier calls in bpf_prog_free_deferred() which is runs from
> system_percpu_wq, it could make this run for much longer than
> expected. What is the motivation for using rcu_barrier() instead of
> bpf_prog_inc_not_zero()? is it the 8B pointer in rhk or the atomic
> operation in bpf_prog_inc_not_zero()?

ok. fair enough. let's keep prog inc.

>> > That avoids an allocation and a state machine on the arming path at th=
e
>> > cost of 64 bytes per element, 48 of which are used today.

What was the thinking here? Why ask all progs to waste 16 bytes
for future extensibility that may never happen?
If rcu_head growth we can switch to dynamic alloc while
keeping the struct at 48 bytes.

I feel it's a better trade off.

pw-bot: cr
