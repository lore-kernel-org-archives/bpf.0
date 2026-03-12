Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774C32E0B71
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348693; cv=pass; b=H9Z7WwliAt19F4uLTIOUjGWfPBZKeeuTnWxXgKG7a4xD72C28y/1yQZdtaA4xZedMtXl6SUBDsMzWbPEakiud9EbMoi2czBcjzI93pVZHxhghz69RG9czpMjkhmworzaqNF2tsNEpkwQ1otJtCVymyUv3sKbPlYESMr26bLFxNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348693; c=relaxed/simple;
	bh=yEXEB+XIExW6jhKbpp7aTQm0ye8is1mfuk9hTkr8dlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJ4ED9+l2xWNjWH9FQXYo7Zu/7/Qdhbq9h3kYoCBnK5kAFTj2NFubP57Z/y1AZ640Q5MiMj24AxVy3LpGICYajzoDwWMSNGJ3wS/0SQ9oPqXFV/odKwwuMwee5OaL3eCsW8idZuezAxsIOt9LnIoZVa/j9yGG+n8nnOL3cOJ7Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRdP24tY; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRdP24tY"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35a1a36f0c0so648708a91.2
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 13:51:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773348692; cv=none;
        d=google.com; s=arc-20240605;
        b=Lpikgj22eL6fytVnjMmXMiyfkrDT7RsTPCt1/fAhrgBgvdurf9ajR4jU7Z62BcYKdw
         NfTSwDeMLAjZC0sXlSxeURXWVUbFi8Y3RLIFkEaoYtV23j370YCdY5TjTFWRTESkm7zU
         FgDpLxXEAd9BvdPqiLFRtKENMkayPGZUO3dpulkBU8WGTqPNBLWFbfDhgsQ9f4aExQ69
         61e7aUTi7sKiPeziWSO+sQU6KQjPz+0FbNzsJObVONfIA2Ze8n4+rtAWQ0DKGAAimHz3
         fRrjGAG4bO/22HB7M9M0foQw/jyU1U4NxQUd9Y6/5uVwNrtd9bKwszrMxDoegmk7b72N
         YYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yMkSNysss/cPZE6pre4BlqUbGSIi/DTFDjvJ21md2YM=;
        fh=un2GWPmYwFWbdF1XpxMPQYRxhKazl5Rxm/QZWha9hkc=;
        b=b9yV2bMeKve9QVQ0kNHdmgiSWtmWtNa9IdkaUyvUISF4jgny7Xom1wWOOjknz9yHfB
         +jQccCM0Tm1K//Fgnhpz2ZkTCcIHo4nlsRpYyyYEGkd4uYd6s+u2m13LdDqvD0Q8NDM+
         e6cPUbXUeyjfplUA0d+GZfYT/hnE1NAQmjaB0965TeVOsuG1lpFTvSI2vyEmQ19wFYMH
         zRVDy9tmgu7DyTSl/dw1xSKiMfFJlpC7p/52oDwtB89DGxutMi+Gf2PLP/iN9q1IUb5A
         qEi/Q3YyQJcH/EYktmE/R+KvSzox1dojJYOkr/jwY3Tu+zZELvYUBgl8UcMHmEbMZlxu
         rW/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773348692; x=1773953492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMkSNysss/cPZE6pre4BlqUbGSIi/DTFDjvJ21md2YM=;
        b=mRdP24tYtQZDtwQuA8l+wY1Ww9duGAtROeuju5DgKvatlQQrYv6OmiA2IYGj1g0nnV
         xfihm3DEMT4yhHBdRLPBdqhi6MjPNkm/3soc7S56n2lGyWP9B/EplgCrWWfMXi/UJ47W
         uRKuifo64oOn+WBe6JWB7zaYUePdjUBkYPogbpYQ9lfrunYCXiLvxdm9le9QTndKat8x
         f2um+0EcVo3yZVx+a4/DWlk2kxiDRlIOjDCyymFqFc0lL4To6ipTHudHmxcV1auE3dsE
         TcLIRcK58k6lubY2BihqyVfcrzzUsl2d9WnrECY3/mwMePn/4PeibyXv67FiNXEndV9U
         GkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773348692; x=1773953492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yMkSNysss/cPZE6pre4BlqUbGSIi/DTFDjvJ21md2YM=;
        b=sT2nY85alGnAXyYXCW2RJcGc0LN4CEtsZN//dfyzhgn0BJrKrGM+ad2NGHV8qFM8D/
         j9kTtFB59xu/kIEH7vdorTy+9YY1olAotm8nRvK93Zn5So7PWtCruPNurS1eo+MsGoiH
         vfKdMYv4puxp0oEMmfxpIK0czA7L6I/vnukgCgBFOE7Ytr3b47aoAWwcoU7Kcvn0aI3k
         p8q2Zv3KGeoMOAr0bXCsSmFWHNcKOIJHW1a3bLPoJCawcHF9kvhbqf+hT0PlVQXreYAI
         vNQziDv90O//GA/G8bA7JCoaBSYc9BtYdzYAObT1KWaynCCG+QHQDDdgVne+rfm6ecCJ
         mmuw==
X-Gm-Message-State: AOJu0Yx97vDsIohrkgRtk7Jm7or6+MFzaceyCgWxuMcIoMb9nnl1NN+X
	QU/3aAv1tyhjqgZf2fWDXogNg4rd4mzeUBagMmzzZAZ5aFJxNX/mChJbmEwJo5OvJmojWw5MsTv
	qJdc9u8GkovJiK9BOA599+Wxrka/Vd4M=
X-Gm-Gg: ATEYQzznpsKl5j+IO+vucP5ZOLR0lQPMM9FBRPnQHxaVpdYiKZzs8aoeatlEe6ytHK7
	IvUUDA3Wmo9PS9XdsjoDjvT4rlPO1jgLE4JGBo7oeBdmENMH376AlsbJ4bPXcmQ+7/BthNRpUBi
	tphuo1vPkULEF/fVvzqaZj/aHlXqe88ajNidDLwaj4QKpcRTfCpgfRjlyPslXUDZtJ33519NF4+
	3mV+IpAW+daX41vXxG5apNhx/EIsLhmHinBKkVA/CCeg7/atyYU5f8fEeQo/VNJZi3eENueVgFF
	p8LRZWfV1Qru/6cA5pHI1Y4=
X-Received: by 2002:a17:90b:3501:b0:359:8230:abcc with SMTP id
 98e67ed59e1d1-35a21eb7078mr869372a91.8.1773348691766; Thu, 12 Mar 2026
 13:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com> <20260311-sleepable_tracepoints-v3-1-3e9bbde5bd22@meta.com>
In-Reply-To: <20260311-sleepable_tracepoints-v3-1-3e9bbde5bd22@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Mar 2026 13:51:18 -0700
X-Gm-Features: AaiRm518pFmWZqeZWjKEeF-9BhQ7qfB9n4MtL-YVXvTdmFozu9tirvFOkT8mTtE
Message-ID: <CAEf4Bzbk4dLFUQzcrFXNw6Bgp7uzFhK-NHHTrbR6roy583ezPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: Add sleepable execution path for raw
 tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 11:23=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Modify __bpf_trace_run() to support both sleepable and non-sleepable
> BPF programs. When the program is sleepable:
>
> - Call might_fault() to annotate the faultable context
> - Use migrate_disable()/migrate_enable() instead of
>   rcu_read_lock()/rcu_read_unlock() to allow sleeping while
>   still protecting percpu data access
> - The outer rcu_tasks_trace lock is already held by the faultable
>   tracepoint callback (__DECLARE_TRACE_SYSCALL), providing lifetime
>   protection for the BPF program

we should not rely on this, see uprobe_prog_run(), we should do
something like that here, explicitly calling correct RCU flavor
depending on sleepable/non-sleepable program

>
> For non-sleepable programs, rcu_read_lock_dont_migrate() is replaced
> with explicit migrate_disable()/rcu_read_lock() pairing.
>
> Remove preempt_disable_notrace()/preempt_enable_notrace() from
> __BPF_DECLARE_TRACE_SYSCALL. Per-CPU protection and RCU locking are
> now managed per-program inside __bpf_trace_run().
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/trace/bpf_probe.h |  2 --
>  kernel/trace/bpf_trace.c  | 13 ++++++++++---
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> index 9391d54d3f12..d1de8f9aa07f 100644
> --- a/include/trace/bpf_probe.h
> +++ b/include/trace/bpf_probe.h
> @@ -58,9 +58,7 @@ static notrace void                                    =
               \
>  __bpf_trace_##call(void *__data, proto)                                 =
       \
>  {                                                                      \
>         might_fault();                                                  \
> -       preempt_disable_notrace();                                      \
>         CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(=
args));        \
> -       preempt_enable_notrace();                                       \
>  }
>
>  #undef DECLARE_EVENT_SYSCALL_CLASS
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0b040a417442..3688a7e115d1 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2076,7 +2076,7 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, =
u64 *args)
>         struct bpf_run_ctx *old_run_ctx;
>         struct bpf_trace_run_ctx run_ctx;
>
> -       rcu_read_lock_dont_migrate();
> +       migrate_disable();
>         if (unlikely(!bpf_prog_get_recursion_context(prog))) {
>                 bpf_prog_inc_misses_counter(prog);
>                 goto out;
> @@ -2085,12 +2085,19 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link=
, u64 *args)
>         run_ctx.bpf_cookie =3D link->cookie;
>         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
>
> -       (void) bpf_prog_run(prog, args);
> +       if (prog->sleepable) {
> +               might_fault();
> +               (void)bpf_prog_run(prog, args);
> +       } else {
> +               rcu_read_lock();
> +               (void)bpf_prog_run(prog, args);
> +               rcu_read_unlock();
> +       }
>
>         bpf_reset_run_ctx(old_run_ctx);
>  out:
>         bpf_prog_put_recursion_context(prog);
> -       rcu_read_unlock_migrate();
> +       migrate_enable();
>  }
>
>  #define UNPACK(...)                    __VA_ARGS__
>
> --
> 2.52.0
>
