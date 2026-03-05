Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929253E3DB4
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732197; cv=none; b=sv0f0FQjoyFc2SI/nEZSfcPIKTOc6wtM7VN/Gb+qstWklI2tR3oaplykJT5UZ4tnYsq9FJ0026Xw/WntChO6j9G+ox2InM8faC2RakUhXImbF5J1qnbw/zPH+lbjozJ8L/bORJyK+ymXxaSqTJE7X00dcgVMKiSNzWrOqxViDWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732197; c=relaxed/simple;
	bh=qBk+C5KTynRczKTvXOk32pNaN5moZ+yvyju/sedZIPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OUlYcTFOUQBHNfQaY3Dc4xVU7Q10AjB35RlAIrwET8OtfQPNKJ4P4eSIquOhkD8dSUxGczhgPKYaEWEdZLNR3aiQKjkvAfFe3Aoj6X5NKVQgtrMRdg8g3UpUTFq0Fed8pqqbCH8/PKSK+pwGTo+pNq6gW4ca7o+pjfVJ/alvYQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+mv5mQX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+mv5mQX"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-483770e0b25so70915075e9.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 09:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772732195; x=1773336995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6I0KgZiaS/h9wcexf6z+S6OaoLtr8QN/v50dsSxnhz0=;
        b=d+mv5mQXhqFIn6dRmwoonmGX/iY+FdTwzUlHrOCdUncpppxExKZY0qne3GArKugSJr
         dfvaLrsqYZd1CaJVHl1U6DVjFjQ6dniCYxBT8ojJE09axpSud/45biJBpkfU6T8eDrfz
         gXORico6jz2oN0btK33TEhFKD++7Q9ZS77H6OP3FW8kEAlvpO0O/9HnvYYSvpcBzDFC0
         UMr8oGcsS6JrGZsM3DOJ9NKYvYHJwTC+XUaIfbvhRjlknzfYBWuS2onk4aZBESTgQaNo
         hLOs2x+8iU5eDRDhrg7BhCGeSK7YkSCIggrUWxgRkDRUX+IV+qhIJIT84VlNV/7cpxXx
         Tr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772732195; x=1773336995;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6I0KgZiaS/h9wcexf6z+S6OaoLtr8QN/v50dsSxnhz0=;
        b=OjYt+Ub6xqoqRYeTt+OqKvuFC55RkKhK4CW7V+8Hw5xHEDnTKR5djNE2F7CrXXNyt4
         yFolTvxVtnSSj0YvQrRlcaYiWNNNxf0wHfUtgU4N8pCk6RoOER/aMg6UV7c+yWwC5Ya1
         r0sabAtH8TpPyD91FBJVBurzZcQTvlJydjmJMV/+8bSaJAZ2xkT5OL571VOpwidQGILd
         Bb1TnAeL0dapMrEaYDBCpUhHDN08T7XxwIyze+nzGbBjKCeQ6+SMS1Usg2s270ByG7zW
         rV1Gthu53roqC6F/3tqSTlWqysgBzUFI8kY1Wgl1GakNhtMxEHoKVFSDbYF9jgL4h0+N
         igiQ==
X-Gm-Message-State: AOJu0Ywo0R4clYglVNjp6X6N9BEWnxFF8crg3f6ZhWDA903ZfAZkHkon
	emB+IGROriahNluWMgfYciHkNsjGDw/NpX/jdeLlYrxxwGSlJhKG5pIZ
X-Gm-Gg: ATEYQzyJHgP+HlSETK4qKIcm8l/F9ujej7UFP7groSeShxxr7pl1a7jOWIsyym/+Sls
	L89XcRPRNwFIZtAs/4d/JrJHM4o1vfwt9yVfbXgVdFLNVByXmuv0o5V+PFAlocoEAQvbrtWnNvY
	18zlV+jVz9A20f6h4memn7pAM7OBpj1FY3TMPnpt4Z0Cy8uOtXFkpa0crXYJIvN2gxZQIsYW2mS
	a/ctMGDqeW3KVUaQ7Hlj6taZYjvI6lUKiTNZkX5+PPyzbmNYIDp3H3BRcYAaQlvwuYBSSF5KhOY
	VbHBHb7UlcqLA17AWgb4HbZYtxGVR4BkpKihHJyBW9S/Qi7H+s4spg9tylWyI2cM2gC/M4ogR3y
	a8jNQAuXo5bx2YJw4AISDcqD7Q89ZFX8+wZ4Z7vUkn9Bqgo/Ke74sjctkdXJED7d248AA0i65+7
	AjEubrEpoUBPM/VVV6b65sIDaJZ8G4SHjt1i7aRw9sDMUmCFYC
X-Received: by 2002:a05:600c:c173:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-4851983b3dfmr115161605e9.3.1772732194656;
        Thu, 05 Mar 2026 09:36:34 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b03db76bsm36621675f8f.18.2026.03.05.09.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 09:36:34 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 kernel-team@meta.com
Subject: Re: [PATCH bpf 1/3] bpf: fix mm lifecycle in open-coded task_vma
 iterator
In-Reply-To: <CANk7y0hybd2RyQi-rUROo6a=Tu36b0L-+ntYrDObaQyK2iHPCQ@mail.gmail.com>
References: <20260304142026.1443666-1-puranjay@kernel.org>
 <20260304142026.1443666-2-puranjay@kernel.org> <87pl5ixmjt.fsf@gmail.com>
 <CANk7y0hybd2RyQi-rUROo6a=Tu36b0L-+ntYrDObaQyK2iHPCQ@mail.gmail.com>
Date: Thu, 05 Mar 2026 17:36:33 +0000
Message-ID: <87ms0mxjoe.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay12@gmail.com> writes:

> On Thu, Mar 5, 2026 at 4:34=E2=80=AFPM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> Puranjay Mohan <puranjay@kernel.org> writes:
>>
>> > The open-coded task_vma BPF iterator reads task->mm and acquires
>> > mmap_read_trylock() but never calls mmget(). This violates refcount
>> > discipline: the mm can reach mm_users =3D=3D 0 if the task exits while=
 the
>> > iterator holds the lock.
>> >
>> > Add mmget_not_zero() before mmap_read_trylock(). On the error path
>> > after mmget succeeds, the mm reference must be dropped. mmput() can
>> > sleep (exit_mmap, etc.) so it is unsuitable from BPF context.
>> > mmput_async() is safe from hardirq but not from NMI, because
>> > schedule_work() -> queue_work_on() takes raw_spin_lock(&pool->lock)
>> > which can deadlock if the NMI interrupted code holding that lock.
>> >
>> > Add a dedicated per-CPU irq_work (bpf_iter_mmput_work) and a helper
>> > bpf_iter_mmput() that calls mmput_async() directly when not in NMI,
>> > or defers to the irq_work callback when in NMI context. Use it in
>> > both the _new() error path and _destroy(). Add bpf_iter_mmput_busy()
>> > to check irq_work slot availability, and use it alongside
>> > bpf_mmap_unlock_get_irq_work() in _new() to verify both slots are
>> > free before acquiring references.
>> >
>> > Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfun=
cs")
>> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> > ---
>> >  kernel/bpf/task_iter.c | 77 +++++++++++++++++++++++++++++++++++++++---
>> >  1 file changed, 73 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>> > index 98d9b4c0daff..d3fa8ba0a896 100644
>> > --- a/kernel/bpf/task_iter.c
>> > +++ b/kernel/bpf/task_iter.c
>> > @@ -813,6 +813,55 @@ struct bpf_iter_task_vma_kern {
>> >       struct bpf_iter_task_vma_kern_data *data;
>> >  } __attribute__((aligned(8)));
>> >
>> > +/*
>> > + * Per-CPU irq_work for NMI-safe mmput.
>> > + *
>> > + * mmput_async() is safe from hardirq context but not from NMI, becau=
se
>> > + * schedule_work() -> queue_work_on() takes raw_spin_lock(&pool->lock)
>> > + * which can deadlock if the NMI interrupted code holding that lock.
>> > + *
>> > + * This dedicated irq_work defers mmput to hardirq context where
>> > + * mmput_async() is safe. BPF programs are non-preemptible, so one
>> > + * slot per CPU is sufficient.
>> > + */
>> > +struct bpf_iter_mmput_irq_work {
>> > +     struct irq_work irq_work;
>> > +     struct mm_struct *mm;
>> > +};
>> struct mmap_unlock_irq_work is exactly the same struct, perhaps an
>> additional patch renaming it to something like struct bpf_iter_mm_irq_wo=
rk
>> is needed. Then we can reuse it for mmput.
>
> They are similar but do different things, mmap_unlock_irq_work is used
> to defer from NMI and hard-irq, but mmput_async is safe to run from
> hard-irq and only needs to be deferred from NMI. I had thought of
> combining these but later felt that keeping them seperate would be a
> better approach.
Sure, I just suggest to reuse the structure, not combining the code.
It's very generic: mm_struct + irq_work, basically some async op on the
mm_struct. I agree with you it's better to keep the code separate
in this case.
