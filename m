Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960813559D6
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 22:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774391113; cv=none; b=izFy9Ducg6bk+pPKWxVl1fl5AttCtAgZp5CX48S/bYfTEQnN3sPeqR0wgjJyejmiskl/F7cNkQK26jGk/YteBjrXMS6nBpKyLsPpHBvC/jOEHWtVLYXCfAOPjKJFIcDSHiVk/YFgS6Gk54XvLhVX+Yzo0Kso6ObeQzzsDqYPcPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774391113; c=relaxed/simple;
	bh=TqGTcxgIa2rwhBv+HpFEXmuGCj4DCv58K1BJDeZyIyw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qqpYtSPYvND/WZwzLjBQCohnz9ujmU11ufMaCcSfxES4D7nWdkNB8J0n9bdom63zfdTt1wGpfJzHELJ8/aSkXXy6nxftIu7epx+xKJF0YRsDB+tlDEyG1A4ML5OEXY+nAyHvT/YZcc3FbOay1F+wUnu8bxq2lzZ0GI9u2kKt9w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2zA7tPp; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2zA7tPp"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b87970468so564060f8f.3
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 15:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774391110; x=1774995910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLR1tc7tDXQmQgCtvhcyTLHCEZ0KabW0UPR7knv3ypg=;
        b=F2zA7tPpm7OACsWmZNkPYgOmGT2DWCUHaIDR259SHROldK7fy6DKOB15t8N9P3WhFM
         j/aBlUZfh5dCkGsvKgg6IHJxJ88td7mMtsf0+WZCrzhNDsMscKRX2nEAa48nF+F3Wigt
         7kHrF5nH+vvvh7Uewqd26Dc1ruoQcqseaK/6Y5gFbaWV0s0/KQdrmp0s8lKBnJJMhV6L
         6CdfyU5ieYYvTtXM2fUNdT5wQYj6qiAq1Z01J8Q7yGOP0JohU3Js1GGfceXrL8tHMUAT
         mCOK1OrHqJ9ZLrnS2Gaqxl49gOsBG3ZSMTIWF13ZxM4R+biJ/0ADXDLY8LsgZ+SXMASX
         F20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774391110; x=1774995910;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VLR1tc7tDXQmQgCtvhcyTLHCEZ0KabW0UPR7knv3ypg=;
        b=hEIwFEx96XrNuR8vMDmNb7A1LNi/TX5rawSP8S1oBD8uOpxCfEygAmirV1BV00a4IR
         MQ0ZfDym44xEMIygZbM7IUfX4BH58BEcT2uKxjW+qN0HtNQfd8gHIKEnQcNIV6fHD940
         ZU8SIvX2JqONwCTdSXtYmzHpMOzSIYIxRCa99zGYX/YA8UNQ3T5sPMtD32t5hsBUuZtP
         NwQz1k16Xhe2AyiC6gK5vL4+fFZ4VlIKU8TwnFKrVuUBFgsykZi55UNU4WXUKMfU7PB+
         2M6EOGv39qq0KEN0EhxcCcQO2cO8NxtEhfWGEpMRyrvcwxnHDhPUeQNOpI9npk+xcj9B
         S8vw==
X-Gm-Message-State: AOJu0Yxyh4db8Jcaot7wdXQ3B56jwql6Mvqx70h/NfOoFZk+/ShICgUM
	/VREe/txRyEujmJ5yrY8dKbMlGcNuTnmrXbMHd7SSOGlQ3dO+BRaZCgJg5ude1zs
X-Gm-Gg: ATEYQzzCyraVKnC9ONwR9QzHbb9/NeBHbomX4BR0iG0btGTSi4xKTi1AVWXNeOCJq+D
	KcQ6n9NzNxADHTSvQorP2Bkho6qbln5VaRuz5h7rUdLWateczBP72KqdyvvgHiZruntAWghpqI+
	wykIAobgg87X5mvomFZHYxpNitZufc8C2TpC0S0da5PnOjiZkvpxM44ECjYa5re87Egtbwdqx9+
	SutOMaqQ162Cuf463L+QEYiZM2EXeETZRptQbz9RIRkwx6uwj6kkOnlebDe2gtCrn4sxCoyomC4
	xAZXLXkxUM/xU++0Ucz5Mqdq57Li01F00dpMAJBONZCiaGgysOfJ4WCSnUV7i4PY6KSvjh6wtpa
	LKgbsGORnugu+OmQB75F6b0d/qsx680dTMf1gz1WiM6Lo7s+3FZfzUxSuuzhR0r5VtiXYtjaWHq
	A9tYbDZbGbtBC7w698No1f/xPqHkPw6xdQk62ltck4YlzH
X-Received: by 2002:a05:6000:2484:b0:43b:433f:48a9 with SMTP id ffacd0b85a97d-43b88a3cf15mr1603135f8f.15.1774391109752;
        Tue, 24 Mar 2026 15:25:09 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b878a7b87sm3423926f8f.25.2026.03.24.15.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:25:09 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>, Eduard
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta
 Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v6 1/6] bpf: Add sleepable support for raw
 tracepoint programs
In-Reply-To: <CAADnVQ+C6fJ1UpTzdYyJrookqjyOh1iGO9LqjwwFyRCf4W16+w@mail.gmail.com>
References: <20260324-sleepable_tracepoints-v6-0-81bab3a43f25@meta.com>
 <20260324-sleepable_tracepoints-v6-1-81bab3a43f25@meta.com>
 <CAADnVQ+C6fJ1UpTzdYyJrookqjyOh1iGO9LqjwwFyRCf4W16+w@mail.gmail.com>
Date: Tue, 24 Mar 2026 22:25:08 +0000
Message-ID: <87y0jgj263.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Mar 24, 2026 at 12:03=E2=80=AFPM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Rework __bpf_trace_run() to support sleepable BPF programs by using
>> explicit RCU flavor selection, following the uprobe_prog_run() pattern.
>>
>> For sleepable programs, use rcu_read_lock_tasks_trace() for lifetime
>> protection and add a might_fault() annotation. For non-sleepable
>> programs, use the regular rcu_read_lock(). Replace the combined
>> rcu_read_lock_dont_migrate() with separate rcu_read_lock()/
>> migrate_disable() calls, since sleepable programs need
>> rcu_read_lock_tasks_trace() instead of rcu_read_lock().
>>
>> Remove the preempt_disable_notrace/preempt_enable_notrace pair from
>> the faultable tracepoint BPF probe wrapper in bpf_probe.h, since
>> migration protection and RCU locking are now handled per-program
>> inside __bpf_trace_run().
>>
>> This prepares the runtime execution path for both BTF-based raw
>> tracepoints (tp_btf) and classic raw tracepoints (raw_tp) to support
>> sleepable BPF programs on faultable tracepoints (e.g. syscall
>> tracepoints). The verifier changes to allow loading sleepable
>> programs are in a subsequent patch.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>  include/trace/bpf_probe.h |  2 --
>>  kernel/trace/bpf_trace.c  | 21 ++++++++++++++++++---
>>  2 files changed, 18 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
>> index 9391d54d3f12..d1de8f9aa07f 100644
>> --- a/include/trace/bpf_probe.h
>> +++ b/include/trace/bpf_probe.h
>> @@ -58,9 +58,7 @@ static notrace void                                   =
                \
>>  __bpf_trace_##call(void *__data, proto)                                =
        \
>>  {                                                                      \
>>         might_fault();                                                  \
>> -       preempt_disable_notrace();                                      \
>>         CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64=
(args));        \
>> -       preempt_enable_notrace();                                       \
>>  }
>>
>>  #undef DECLARE_EVENT_SYSCALL_CLASS
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 0b040a417442..35ed53807cfd 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -2072,11 +2072,18 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event=
_map *btp)
>>  static __always_inline
>>  void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
>>  {
>> +       struct srcu_ctr __percpu *scp =3D NULL;
>>         struct bpf_prog *prog =3D link->link.prog;
>> +       bool sleepable =3D prog->sleepable;
>>         struct bpf_run_ctx *old_run_ctx;
>>         struct bpf_trace_run_ctx run_ctx;
>>
>> -       rcu_read_lock_dont_migrate();
>> +       if (sleepable)
>> +               scp =3D rcu_read_lock_tasks_trace();
>> +       else
>> +               rcu_read_lock();
>> +
>> +       migrate_disable();
>
> Pls don't sacrifice performance just to have common migrate_disable path.
>
>>         if (unlikely(!bpf_prog_get_recursion_context(prog))) {
>>                 bpf_prog_inc_misses_counter(prog);
>>                 goto out;
>> @@ -2085,12 +2092,20 @@ void __bpf_trace_run(struct bpf_raw_tp_link *lin=
k, u64 *args)
>>         run_ctx.bpf_cookie =3D link->cookie;
>>         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
>>
>> -       (void) bpf_prog_run(prog, args);
>> +       if (sleepable)
>> +               might_fault();
>
> why?
> might_fault() is there __BPF_DECLARE_TRACE_SYSCALL.
>
Agreed, thanks.
> pw-bot: cr
