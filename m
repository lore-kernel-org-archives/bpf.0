Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6EC26B755
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769549750; cv=pass; b=FGNCMVqnDKVuSZ5SWH0+ZlXrEbuGcwGq0webP5h42cuFVLvKVwDhY0ZL0lNQWrBhFeCmnTJbO4vSbNknJxc57hgXVvMdJ8BeXjhfp6Tc1N72vImhHYMcfn0MAKxAupGsTQe4PqoyS933BnuJ7ssB4J9uwVKTx4oxzBJct6rt8d4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769549750; c=relaxed/simple;
	bh=C97C3q1f2+9ANaJScwvxdbsdk/KxVo+LBXn35SlkaQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVUEUBHAPbDu8sQ5R1Bp/3HPsb+SaDjdYutt9GUta8R1MSGMoKJckqZnS4feW+/ZEPm2xzt1AOOfk9Bs2fRNaWtVIG5qHJnrU4G8+MfW2dxfil1ExxhvEORRg4XShXQou3OFpYYMQbC0hIElh57tm6um9iqfjaJC/c6Bq3UmbD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewnjjSZ4; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewnjjSZ4"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a743050256so40511835ad.3
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 13:35:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769549748; cv=none;
        d=google.com; s=arc-20240605;
        b=WXeyvw/d1k1EAcV1kC1rbq1dNzyRnaw7E+9oGz+A1cLbmFvc6yFm1CaZfHgegNlupU
         VA3350osi+llVFKG8YZmqEhRj3P8W9SdLPCAIC87kclje5DJnmn03iNkwGfalM73pjD0
         sXoJwWgKhO1QaS4IAJuPlomGPHTgC1BFTufDf1avJoi6wVsY8IbWBItWN8Y9CLbux+2x
         98w9EFcaWm06slL5aiRQax7XQtpuxVvMsP+RIgUks9lUjmFR+OJZUY6yzZp4XiZMNsqA
         uP1UCo/ssFzq9Hsz244vPGFsp6JUGn0+JeqU7WW/tVS1Euu8T+QZUe2B5HYn6bR/IBKq
         wU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TsrB0WKEEM0I9Fpgpuk4REg1XhpPCR9Gqn9MJNXWOek=;
        fh=YHxLubhbemRf3cenotURmEjbkKXZd8Y4a/97UMvi8Os=;
        b=eeYVMD/42gXt+tc5gC1+uqZbuC2j3Eo3Ybb7vCnN6WQnHCZhHdd6BKZsI7MyF/dxds
         8L9m94oPmPkEk0lzt14CswgnHRqYMUDVq+poFrc6P7GwgaD6szMtbIL/nbhyt699eBLM
         zAcD0TBNZUATh/QUncQ0RA4VScFVJrR+Wksbvdwp3XjbqsTx2lZyl+YoWTBdKDuNN2VZ
         9zGvEIVq5UXtrldbCC84LEA88iJPIRN6Fd9/7R5mbgSF64a/aLBeofIYv/nbuwJkRH+g
         m40HzarcaqSlpDzXDwpQ2C9AmLjGnMAQh5bTbUW/8O0hZLGKfS+1PGI6uJSuB+5xZuQj
         kaEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769549748; x=1770154548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsrB0WKEEM0I9Fpgpuk4REg1XhpPCR9Gqn9MJNXWOek=;
        b=ewnjjSZ4ygb9/D8aheg2EQwKCLg3wMzg73q0728GCAmev0w2WvMXSx0BQ/KXVLxKq6
         vyBjuW0/sB/C+MSM+f5SljrIivyAtSnbBaIxCsK+kSntQ1c884Zc32l+Tlk+5ykpS5Fi
         f4hKElhygaalZrcS2hmnJxPjkdiP7ExkkAwRBDi7sZv+/Ux6cxcIpej2uf0D2LUiSmp5
         +GxbuXS1j42cUXgduRUd/DtWVbFRfYimg+yYiCBj8j3TMlBpi9LUZsmXzUoEkczMUx/X
         kK+QwZgQAvZrsw+rroDugiUrD8vf0T06ibZhNxGM4rzr3769iAdA7PBh5dVbBwyDo18Y
         pVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769549748; x=1770154548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TsrB0WKEEM0I9Fpgpuk4REg1XhpPCR9Gqn9MJNXWOek=;
        b=Cv/T69FfWatDrTQtP3xqt365Wx3RM7W+ww3HDgEyAQQjdBODmAKpQGKjp+kg3VRROp
         CgXU0XotNRoukMf9s1lBaH/yx8Cgb89OYm+1UmmhZBx8lNPxGtu3NsS0oOba4n4lih8v
         PXRKBEO9mBkCtc0IVqbebV9DCicyMlovqOML9cLQHKG9fJtCMekljgguWHVXNr7wGFFC
         x5t0iv1LzE+HWgt4piOXdeA7LqYC0+RZd2LU0aBMpaU/YeTZcc0xWBLzTDvVsmGExBdl
         8Vy+IhYudTrU/M2NBNSbgAIOCQujrjPeAIAZKTbjdlkhpsCC2paAaP/LuMzliEvDYt4q
         bPdA==
X-Forwarded-Encrypted: i=1; AJvYcCVXBUzXet2gvGZtZ6dgmYt7e9BZQ/eeLiEs5nYP48fRAg76M77a2HqxGcz3sRLh7MDaTvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5XSutMGL06MhNJSySc05fDPiLGw4SmAWoYRzr90zNLWB4VNGp
	QXNrHc5DPcOwN0GXXmf8OrtDnGnDuonca8A4tBSJR8Ed9lGXWMj9w/DzQQWke2isiHGnCvikojk
	vJrGYTZMVVZUiJAyH5Mc4GCqAVnmnfSg=
X-Gm-Gg: AZuq6aKMkZ9NgNOYHN5D1eykwwUC6qjdRW7g6BMn1BxopXCBIwb+apJvCsabKgrsV4R
	nNZ6RmUq9WBDr4nD/SnMmm64n+XC+l1rx/48w+x+QlGehrqXqk9nmBusNW4ZNeLAbf1J+zPxMfM
	2PaWujMVddSmd0U5AvCersG/O1EycRMMiK846MEyNwPufk/BOHlLoPgguxWZBM0UxAAN/OtHeXP
	HnofpO7zGCCeWAKldwVA2OTXFfXYwG9/K0BHwC2uQKnAY31H06AykYS0Dzsc1hIv3+eQsRxRIHo
	0455ED3uyOo=
X-Received: by 2002:a17:903:2301:b0:295:5da6:600c with SMTP id
 d9443c01a7336-2a870d7afc2mr28445175ad.2.1769549748390; Tue, 27 Jan 2026
 13:35:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126074331.815684-1-chen.dylane@linux.dev> <20260126074331.815684-4-chen.dylane@linux.dev>
In-Reply-To: <20260126074331.815684-4-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Jan 2026 13:35:35 -0800
X-Gm-Features: AZwV_Qjnaggx7ZAyA5kZjLjV3t-88OZe0RDLvJcWlk19LJ0-lrbY8LafvDvgWuA
Message-ID: <CAEf4BzbubXxLHsO_2aVBG_oYE1Sc9iafLyvcX-PEjcQ7EXWCqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 3/3] bpf: Hold ther perf callchain entry until
 used completely
To: Tao Chen <chen.dylane@linux.dev>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, song@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 25, 2026 at 11:46=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> w=
rote:
>
> As Alexei noted, get_perf_callchain() return values may be reused
> if a task is preempted after the BPF program enters migrate disable
> mode. The perf_callchain_entres has a small stack of entries, and
> we can reuse it as follows:
>
> 1. get the perf callchain entry
> 2. BPF use...
> 3. put the perf callchain entry
>
> And Peter suggested that get_recursion_context used with preemption
> disabled, so we should disable preemption at BPF side.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 55 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 47 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index e77dcdc2164..6bdee6cc05f 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -215,7 +215,9 @@ get_callchain_entry_for_task(struct task_struct *task=
, u32 max_depth)
>  #ifdef CONFIG_STACKTRACE
>         struct perf_callchain_entry *entry;
>
> +       preempt_disable();
>         entry =3D get_callchain_entry();
> +       preempt_enable();

pass perf_callchain_entry as input argument, to keep similar approach
to __get_perf_callchain, see below

>
>         if (!entry)
>                 return NULL;
> @@ -237,14 +239,40 @@ get_callchain_entry_for_task(struct task_struct *ta=
sk, u32 max_depth)
>                         to[i] =3D (u64)(from[i]);
>         }
>
> -       put_callchain_entry(entry);
> -
>         return entry;
>  #else /* CONFIG_STACKTRACE */
>         return NULL;
>  #endif
>  }
>
> +static struct perf_callchain_entry *
> +bpf_get_perf_callchain(struct pt_regs *regs, bool kernel, bool user, int=
 max_stack,
> +                      bool crosstask)
> +{

I don't really like having this wrapper, it feels like the flow will
be cleaner and easier to follow if we modify the code as suggested
below

> +       struct perf_callchain_entry *entry;
> +       int ret;
> +
> +       preempt_disable();
> +       entry =3D get_callchain_entry();
> +       preempt_enable();

I'd actually consider having __get_callchain_entry() that does what
get_callchain_entry() does right now under assumption that
preemption/migration is disabled, and then make get_callchain_entry do
preempt_disable + fetch entry + preevent_enable + return entry dance.

This will simplify the flow here to just with no explicit
preempt_{disable,enable} visible. Either way all of this has
assumption that we are staying on the same CPU throughout (so at the
very least we need to have migration disabled)

entry =3D get_callchain_entry();
__get_perf_callchain(entry, ...);
put_callchain_entry();


BTW, is there a way to assert that either preemption or migration is
currently disabled? I think both get_callchain_entry and
put_callchain_entry would benefit from that

pw-bot: cr


> +
> +       if (unlikely(!entry))
> +               return NULL;
> +
> +       ret =3D __get_perf_callchain(entry, regs, kernel, user, max_stack=
, crosstask, false, 0);
> +       if (ret) {
> +               put_callchain_entry(entry);
> +               return NULL;
> +       }
> +
> +       return entry;
> +}
> +
> +static void bpf_put_perf_callchain(struct perf_callchain_entry *entry)
> +{
> +       put_callchain_entry(entry);
> +}
> +
>  static long __bpf_get_stackid(struct bpf_map *map,
>                               struct perf_callchain_entry *trace, u64 fla=
gs)
>  {
> @@ -327,20 +355,23 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs,=
 struct bpf_map *, map,
>         struct perf_callchain_entry *trace;
>         bool kernel =3D !user;
>         u32 max_depth;
> +       int ret;
>
>         if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>                                BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID=
)))
>                 return -EINVAL;
>
>         max_depth =3D stack_map_calculate_max_depth(map->value_size, elem=
_size, flags);
> -       trace =3D get_perf_callchain(regs, kernel, user, max_depth,
> -                                  false, false, 0);
> +       trace =3D bpf_get_perf_callchain(regs, kernel, user, max_depth, f=
alse);
>
>         if (unlikely(!trace))
>                 /* couldn't fetch the stack trace */
>                 return -EFAULT;
>
> -       return __bpf_get_stackid(map, trace, flags);
> +       ret =3D __bpf_get_stackid(map, trace, flags);
> +       bpf_put_perf_callchain(trace);

Just as above, I think get_callchain_entry + __get_perf_callchain +
put_callchain_entry is better, IMO

> +
> +       return ret;
>  }
>
>  const struct bpf_func_proto bpf_get_stackid_proto =3D {
> @@ -468,13 +499,19 @@ static long __bpf_get_stack(struct pt_regs *regs, s=
truct task_struct *task,
>         } else if (kernel && task) {
>                 trace =3D get_callchain_entry_for_task(task, max_depth);
>         } else {
> -               trace =3D get_perf_callchain(regs, kernel, user, max_dept=
h,
> -                                          crosstask, false, 0);
> +               trace =3D bpf_get_perf_callchain(regs, kernel, user, max_=
depth, crosstask);
>         }

with the above suggestions this will be a pretty streamlined:

trace =3D trace_in ?: get_callchain_entry();
if (!trace)
    goto err_fault;

if (trace_in) {
    trace->nr =3D ...
    err =3D 0
} else if (kernel && task) {
    err =3D get_callchain_entry_for_task(trace, ...);
} else {
    err =3D __get_perf_callchain(trace, ...);
}
if (err)
    goto clear;

... proceed as before, we have our stack trace inside trace ...

for successful and failed paths (you'll have to duplicate this logic):

if (trace !=3D trace_in)
    put_callchain_entry(trace);

>
> -       if (unlikely(!trace) || trace->nr < skip) {
> +       if (unlikely(!trace)) {

this condition cannot happen: we either get trace_in !=3D NULL or we get
it using __get_callchain_entry and then validate it's not NULL
earlier, so drop this condition

> +               if (may_fault)
> +                       rcu_read_unlock();
> +               goto err_fault;
> +       }
> +       if (trace->nr < skip) {
>                 if (may_fault)
>                         rcu_read_unlock();
> +               if (!trace_in)
> +                       bpf_put_perf_callchain(trace);

do this clean up in one place, behind the new goto label? it's a bit
too easy to miss this, IMO

>                 goto err_fault;
>         }
>
> @@ -495,6 +532,8 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>         /* trace/ips should not be dereferenced after this point */
>         if (may_fault)
>                 rcu_read_unlock();

now that I looked at this code, I feel like we don't really need this
rcu_read_{lock,unlock}() dance (even though I added it in the first
place). I this RCU was supposed to be need to keep
perf_callchain_entry alive long enough, but for BPF this is guaranteed
because either BPF stack map will keep them alive by delaying
put_callchain_buffer() until freeing time (after RCU Tasks Trace + RCU
grace periods), or for bpf_get_stack/bpf_get_task_stack, BPF program
itself will hold these buffers alive again, until freeing time which
is delayed until after RCU Tasks Trace + RCU grace period.

Please send this clean up as the first patch in the series so we can
review and ack this separately. Thanks!

> +       if (!trace_in)
> +               bpf_put_perf_callchain(trace);
>
>         if (user_build_id)
>                 stack_map_get_build_id_offset(buf, trace_nr, user, may_fa=
ult);
> --
> 2.48.1
>
