Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2012E36F8EA
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954913; cv=pass; b=C26KAVPAwUVR2u7jrIqjLNB7YpVCZUBEdSSb36TA2A3B3usM8pYes8C3tmuBxbYh8PFg4oR34FVSq9EXvvAzYcN/q24MsQIsNnL8NpJ7j4h3f4AjDP9fWi8DKSJefxmk2mTrTqyfO8BRxGNworacY0qYrKM804mZgHfFHJFlFDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954913; c=relaxed/simple;
	bh=y7iDB2T1ItqNgNVxSxCRzMPlJGQiP3oIzeC9CjpbaeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/ghOh6splmMdnkMIDt8gASJD5mo0z08dsIfUtutj6PEm0019hS9/xncX7Ab9j1dblQGwXjIjxMn+zW0ZBHW3z5IcmKkJ4/34Ls0+t9jdRkhNLZ+GY7kWJnTeXoj8KXRS4xivhZVjSkVWBtakSV/qdwgW7qTuJCZzuGJBaBqOjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rMomXlQ2; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMomXlQ2"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8485b358552so1146518b3a.2
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 11:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785954912; cv=none;
        d=google.com; s=arc-20260327;
        b=MO4h+LoiKdA+f4jDKLxPIp3ewd+LFdt83bgoYT+dSa5C3HP9xoHIHiCMUxp4OaeMY7
         YLp/28HMEB1ZkplxLT8dkVhXGptiQ29LjSuIGks/m2eRljQXPb8mflJj6DGfqqw9wvdJ
         N3XiHndA/uxJ9M1T3hni3M+PhCW2/j4eT4+7RA9UBHsxoft4bqy9299tth+JuhvbYwLc
         dS8tD8PD0W3rbv43gvhakiCn2J1B3BTL3oanPqN1weVy2Ts3omDsYZI1a9JTMnJiVs5Y
         jQZTkda8LaHLUHeGbGnc1ixwWOT35wOehxpnnvoWdjxepqdaztsjdkQBmxqwlqI0KGqZ
         iNmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=41qka+EIjjsEce/PTgUDMj48v0yLdWjZXwp+NSobgCM=;
        fh=p7IOGXIGcND0vK8vo/pbjKD0LdvYlMFA2c4QAnqtgIg=;
        b=q/ExGmbeifwOW0v+NlPToXUXDoAHOj1SMh8N6UTJlRfsE+ao4DIvKKcaYwlKczKpDH
         ve1WONXZnONcAvrFihBEqX+DD69bUAkKOFs0hFSSvizXu33pEikTQtVefuxAXV8bCs2k
         b/xWF/RbH5sDoZPrwxqcMnWtzRbOS7+rzs+1GyuqyeRfLvPJ3bJqrWqbDK+GpyAd0eMQ
         J3D7yzgCtHQRJutZzL3ARja8ZYK4+iue+knXxy02yAFalgaH4UpWB0GcDAbsb82aNrxc
         D/+Z7Isa+5jj/zys8nTU8CeTKduCjYG7VmnvkrqIAgr2Cnk7IZzKF1uuve0Mqs//tYTd
         Dgqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785954911; x=1786559711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=41qka+EIjjsEce/PTgUDMj48v0yLdWjZXwp+NSobgCM=;
        b=rMomXlQ2hmX8MLnHl3cTIFLEmn8Rg3DVbHfF7+rIQSx7Q2jZzp174tEEW1a/BWO3NE
         rBNYjv1VqrVZUgz+XPvO6dHweoOLPNOHNunn5hWcrJ4BGY4fg7EpCWav11BKnj2x1JoL
         +AumRFEETL4a+cRwKsxtcU1k2XvPOFSdHmtYhrNtP5pgGedYo4aIezJZOgbRcedPc2lO
         BXkzC71snfZkXo44kuNfJGA1DnLrivdHXl7GUDEiyhIh3a2OwcGru2E6r/tzH9pSzlkT
         38wArcB0nLA71lDZpzNzqomhFN+01C73jenENwslTF02KHvQ86jpZgGNqPGVvDC6cl1p
         XX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785954911; x=1786559711;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=41qka+EIjjsEce/PTgUDMj48v0yLdWjZXwp+NSobgCM=;
        b=gpqlxTzFyCpVwp8Fj1F4IvOCdUxdHqjxVd32Pv6qZLoEiXZC0MTeba4OZwDV70COBk
         NG73K5AuvkwAYiFEf4ET6BwV6M70Q+RZQnijIea051fyc3O40I4uJQiuecZb7Tx/rhgR
         Z089lOwHeiTgadp/0hlvMxYcGVrjxKPX2hOT/UY5vGe9z6oZ1fjzgMoFRsTgMKaqnwyj
         uJNiJbZmcNAPmF6tfTe1AJl9pTdZXGBr61FGzsk6JrWWx7wcKFzcKD2r0B0v56KMuKj8
         gIVYYeR1KGKwfzVEcQXMdrO4iU+MYx9Y5H5e8ABvbXnt21lS69SczYIvKa3Kk5kqbeVe
         V12w==
X-Forwarded-Encrypted: i=1; AHgh+RpDn89iZpOjYj8FhtF1nA9HTwo8D0yZCVMKo/TgUv/QS1DDCf60gpQknRziEsq3QcUuL8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Rz864t0ccbUpRv9GtQfj6J497NmjrBsl4tqS/lDSccKsvXhk
	WB7MA+xYZDbtD+reQ0BFBT9Ja5ZCHtOm+sX9Cxztu6JjHreKrQ1GxHdJ5eNllO2Rha0J1IFQzyg
	4RUKWNF4wLkWPWy7WsItekWmiAhz6fXM=
X-Gm-Gg: AR+sD12wJG4HfGcL9Qpi+HTBBdQO1Of1nRFnGos8f+wMhdbdJbbsRUCZuBk0F2Yo7ib
	rSl5rYdUnjH75eKs4Kfbi2TqHL876fZr8MF7NeojDFKeKXiVbfIC79t5g+YgfxP6kM0cal50dZO
	3m72D6aculkBehpVj8okjQXKx0xEYvJW0N+NBmonA4n3ALiVhCJNd3tEU3qMbwNewtt3CDinsaB
	cYCLObYXUNpsRjvE8DyS/bZRQrfkUu+B1g6GsaNzmObTfdMF5xcMEGhzz8rQVl/HW2ynElLml+p
	6hmCcboLd88lggHZViv1yCvwK1Ye3nWRmION5CfY903Z4PZXnUZEkowZVYlBYCbbkWSITdbIgE1
	37OEb18SrRn936B2KsW92RBSdKh2QZy/tbFFZ
X-Received: by 2002:a05:6a00:32c4:b0:84e:2f2e:8c4f with SMTP id
 d2e1a72fcca58-84f2dfcf800mr10473335b3a.10.1785954911439; Wed, 05 Aug 2026
 11:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805092843.516315-1-jolsa@kernel.org> <20260805092843.516315-11-jolsa@kernel.org>
In-Reply-To: <20260805092843.516315-11-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Aug 2026 11:34:58 -0700
X-Gm-Features: AUfX_mwhD9_EnU4ed-9Qb7MSedhAwmUo5Ty62RDX4R8OXzlkjkFpkJucYw2PP34
Message-ID: <CAEf4BzZQXq5CNSkD4-gMOhs5+GU9Sf9Q7sHvLu1BkpqDTQHa5g@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 10/12] bpf: Disable preemption in __bpf_get_stack
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org, 
	Tao Chen <chen.dylane@linux.dev>, STAR Labs SG <info@starlabs.sg>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Quentin Monnet <qmo@kernel.org>, 
	Arnaud Lecomte <contact@arnaud-lcm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 2:30=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> From: Daniel Borkmann <daniel@iogearbox.net>
>
> get_perf_callchain() returns a per-CPU perf_callchain_entry buffer and
> releases its recursion slot via put_callchain_entry() before returning,
> so nothing keeps the entry reserved while __bpf_get_stack() consumes
> it below.
>
> A preemptible BPF program (e.g. a non-sleepable raw tracepoint program
> on a PREEMPT kernel, which runs under migrate_disable() but not
> preempt_disable()) can be scheduled out between obtaining the entry
> and the copy. Another task scheduled on the same CPU then reuses the
> same per-CPU buffer and overwrites trace->nr with a larger value.
> copy_len is then computed from the inflated trace->nr and can exceed
> the caller's buffer, causing an out-of-bounds write in the memcpy()
> and in the build_id path.
>
> The rcu_read_lock() taken here alone does not prevent this. It is
> only taken on the may_fault path, and under CONFIG_PREEMPT_RCU it does
> not disable preemption; it merely keeps perf's callchain buffer array
> alive (freed via call_rcu()) and does nothing to stop another task
> from reusing the entry.
>
> Disable preemption around obtaining the callchain entry and copying
> it into the caller's buffer, so the entry cannot be reused underneath
> us and trace->nr stays bounded by max_depth. Build ID resolution may
> fault and is therefore deferred until after preemption is re-enabled;
> by then the instruction pointers have already been copied into buf,
> so it operates only on that private copy. Note, preempt_disable() also
> subsumes the buffer-lifetime guarantee the rcu_read_lock() provided,
> since a preempt-disabled section is an RCU read-side critical section
> for the callchain buffers' call_rcu() reclaim.
>
> Cc: stable@vger.kernel.org
> Fixes: c195651e565a ("bpf: add bpf_get_stack helper")
> Reported-by: Tao Chen <chen.dylane@linux.dev>
> Closes: https://lore.kernel.org/bpf/20260206090653.1336687-1-chen.dylane@=
linux.dev/
> Reported-by: STAR Labs SG <info@starlabs.sg>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> [ changed Fixes: commit ]
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/stackmap.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index eabeaef31b63..789fe35b893a 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -817,6 +817,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>
>         if (may_fault)
>                 rcu_read_lock(); /* need RCU for perf's callchain below *=
/
> +       preempt_disable();

nit: asymmetrical to preempt_enable, I'll move it to before
rcu_read_lock, so we can have proper nesting



>
>         if (kernel && task) {
>                 trace =3D get_callchain_entry_for_task(task, max_depth);
> @@ -828,6 +829,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>         if (unlikely(!trace) || trace->nr < skip) {
>                 if (may_fault)
>                         rcu_read_unlock();
> +               preempt_enable();
>                 goto err_fault;
>         }
>
> @@ -836,6 +838,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>         /* trace should not be dereferenced after this point */
>         if (may_fault)
>                 rcu_read_unlock();
> +       preempt_enable();
>
>         return callchain_finalize(buf, size, trace_nr, elem_size, flags, =
may_fault);
>
> --
> 2.54.0
>
