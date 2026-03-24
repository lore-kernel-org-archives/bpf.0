Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4932D3225
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382779; cv=pass; b=RfbzW/KMuzFfGJIKYvUC2YjTsUqxM1Tp02BDeeMN8kkHuaLcEFSNJZ20kWeCOTCGcHPJu2jd/PQuhOgLgzENAafJmIF5Unzp75XXEpUYudri8U3t27PdRZaEIkCa1przcmquWuAzL7q9OVlEElQLkTEyvGeRByNHI3TMMmOsf48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382779; c=relaxed/simple;
	bh=dD3ybklty/hwZATb0cnmLGK1rJyMs5lsQV3HYgspqkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fW9EXeReypnEfaW1plTGdHK/+wxUpVookctBfANxm1v+mjtqX6yUOa8eXW1EY2UWp2YvsOYDS288NBeqXTQBdgxmdIRZRZw62lxGftWOM1kn3jDAKVRLVtVIddsU1uWOSWBth130kj+I2KLHs+tJWslfljeYOIRfA7xESH79w2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0R7Up4k; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0R7Up4k"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-439b9b190easo1346351f8f.2
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 13:06:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774382776; cv=none;
        d=google.com; s=arc-20240605;
        b=Nm4jH6pJDTnPq3iw75N6+5CIZDAwaSRtn0dPKNWkMs5xLbmpA+ZXog9lvaMQ9mrr44
         R38yr3g6KnXrpM1wydbuCNPG8t7bRRJW4CTypezpuMrHA8EZ/8hd6+gR+MGHrCy1DnMW
         b+UhgqWu2AbnEJMEKn4uRO7mg1Kw0tthrru60XcHTDjaHik7Eh0soFKsI8l3BOVY1FqB
         afuLKZg595POnVnu/WLbAQ+TvPrYzS9t8rCYwPO8clNIyRf9rAIozklDDiJ9X8hPUuV3
         oqKUEZsVY+1MyCzVvkjjKZxnCu0ArXV+ISTiccfWzzHEgkiHdVOCXqoAyxzjkD31Mgg2
         WBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dD3ybklty/hwZATb0cnmLGK1rJyMs5lsQV3HYgspqkI=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=Ft2wssJTeCtuQxCxJIJnb1lDMMP4mopcEYK2bQ3GdH+MptQ35ptYsV//NXIx+5QhQL
         d0wfDBstEr/yNne/WE0NGeBoDFtRjyL6me0p99XvuoM2o754VdLxC5D+84tlc/TEqMha
         AbjQ1QF9sBM6GcdQy34NVrDVVooire+ZllZTkl9/VW5Ka6/lBa9bhj8nZLW9mNihThCC
         s9HhammDvAvR8BjIzMAce5VEXtFyu7Jaz7ycTCadUR1JgQXQ2rT1Xs9xHxibjTu9m64m
         4QsbuQ7r4e4wFx8HUu7LmSspJdcbzNDP2owy93PiWf+cgrgqBLSzf141R2ktyDfYoUjO
         K/7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774382776; x=1774987576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dD3ybklty/hwZATb0cnmLGK1rJyMs5lsQV3HYgspqkI=;
        b=J0R7Up4kKxR9ozxpJTKMtit8tNvhJ0XsdG2FMnWgl8oBsIIHE5YXU8P5vhRgDUXQRf
         VUSNboIEAMxf9Wq6G7hDUuyhPFrOcS7N7V1SEUT3gdYEKAq7kv0BfC/oK9gVlzcwqehy
         0otR4bl/t5sKoZVx07XysVlXoDDRkf/vk/+4Yi4neRB0jxHZsVUjUVFWeEdT6ZQoAyl3
         J4Gw3PBwOB9RmcG3cFGHBTeFtxKXbzohernCByNZBYpBceUXIsw48r3O9iArd+RaOuV7
         y4ScXr8Uh739Q9tn7tg0lcT5ilhy7kHbGwGWBGfooE4oVmi+UGy5JeMk9FzRbia6s7eD
         XKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774382776; x=1774987576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dD3ybklty/hwZATb0cnmLGK1rJyMs5lsQV3HYgspqkI=;
        b=OtJYMZIl5gFinOua+SCd3qYqeODDvwLy5pcUptjRxP1mERx/KJTb0hR6zczzqVey2F
         5ML0AtxtUwY/HCV9JHCrAYQ3eQmY6tFtBwuNTyd4OQGNud+RGx3nkZcvCIxt8rQvraI4
         eHmfMKI0UYFccC1xjnfsv4A6qkq3GFc5nvsHL+quPCOeLlAPPcVjy/Ringvq+NCi/ZZh
         A+1I1Rcw5EzZ6ExtVZZitUcc/v97942qLewP+pYoIbUxIS6ePbbdUpXNAvcKxYYaTBUL
         5Zkm4gKuD/7wBbw19F+NwnBYz2+In3DL5YrzX/3zPjDw+1vZsWakU0AtzWMMfLGVgGJj
         6dNA==
X-Gm-Message-State: AOJu0Yw6E6hkiYq9iziYP1JRsrX5ba5e9ier9nFOor5iIGpjrVnGKANb
	emilMKtMlYOV7mdH2H6Y4BwF/tOj4mtgfBzZTDs70wuM1hMtxKLdGd4fQyVRVLirzsvnJ2P2kOd
	LAuYFJb+CUcGTP07d3wr3s+x4YDHFRCU=
X-Gm-Gg: ATEYQzyHb9E0QnhPrrrsci8CaF4ivOFqhVDtBmIbTIxTXzS+mY6W6PPhPUWRa5pkXU3
	4G3wwe4auX9WQMtm31tYzbNrCUo3yaDENJulWLb1gloAOlYMeSxDZYE42fcoSrxVNP5PVFs/IUG
	wz5HsERWQf+7EP/rJKexNir4mB1sUCNXX680DuUNzmc7kygK8Gh27gBnxRZVrWF42oseromVG5Y
	Q+nB5G3t9KGPWRBCPgDZcGqmiac50yP+sLwRX+CsaDNqJByHRNFmzBSwkjgFMTrkz0xWgvin8NQ
	T8YkoWQem4A4NDf6RoQzs+mYhYleO5yhMblfr2nVgU9TyZpUgcp/urKG3dc=
X-Received: by 2002:a05:6000:220b:b0:43b:43ae:8c25 with SMTP id
 ffacd0b85a97d-43b88a44842mr1096280f8f.52.1774382776006; Tue, 24 Mar 2026
 13:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-sleepable_tracepoints-v6-0-81bab3a43f25@meta.com>
In-Reply-To: <20260324-sleepable_tracepoints-v6-0-81bab3a43f25@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 24 Mar 2026 21:05:39 +0100
X-Gm-Features: AQROBzBH7NrZnfcNObchQ_qi1W7CsRunr304f7HbeAqa_taRuU03UyzJaFukB9o
Message-ID: <CAP01T74asfp5DY+wFd6pDVpSsiuPxjPaPE8iaFaczBUHe0BERw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/6] bpf: Add support for sleepable tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Mar 2026 at 20:03, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> This series adds support for sleepable BPF programs attached to raw
> tracepoints (tp_btf), classic raw tracepoints (raw_tp), and classic
> tracepoints (tp). The motivation is to allow BPF programs on syscall
> tracepoints to use sleepable helpers such as bpf_copy_from_user(),
> enabling reliable user memory reads that can page-fault.
>
> This series removes restriction for faultable tracepoints:
>
> Patch 1 modifies __bpf_trace_run() to support sleepable programs
> following the uprobe_prog_run() pattern: use explicit
> rcu_read_lock_trace() for sleepable programs and rcu_read_lock() for
> non-sleepable programs. Also removes preempt_disable from the faultable
> tracepoint BPF callback wrapper, since migration protection and RCU
> locking are now managed per-program inside __bpf_trace_run().
>
> Patch 2 renames bpf_prog_run_array_uprobe() to
> bpf_prog_run_array_sleepable() to support new usecase.
>
> Patch 3 adds sleepable support for classic tracepoints
> (BPF_PROG_TYPE_TRACEPOINT) by introducing trace_call_bpf_faultable()
> and restructuring perf_syscall_enter/exit() to run BPF programs in
> faultable context before the preempt-disabled per-cpu buffer
> allocation. trace_call_bpf_faultable() uses rcu_tasks_trace for
> lifetime protection, following the uprobe pattern. This adds
> rcu_tasks_trace overhead for all classic tracepoint BPF programs on
> syscall tracepoints, not just sleepable ones.
>
> Patch 4 allows BPF_TRACE_RAW_TP, BPF_PROG_TYPE_RAW_TRACEPOINT, and
> BPF_PROG_TYPE_TRACEPOINT programs to be loaded as sleepable, with
> load-time and attach-time checks to reject sleepable programs on
> non-faultable tracepoints.
>
> Patch 5 adds libbpf SEC_DEF handlers: tp_btf.s, raw_tp.s,
> raw_tracepoint.s, tp.s, and tracepoint.s.
>
> Patch 6 adds selftests covering tp_btf.s, raw_tp.s, and tp.s positive
> cases using bpf_copy_from_user() on sys_enter nanosleep, plus negative
> tests for non-faultable tracepoints.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
> Changes in v6:
> - Remove recursion check from trace_call_bpf_faultable(), sleepable
> tracepoints are called from syscall enter/exit, no recursion is
> possible.(Kumar)

Is this true? Can't the same program reenter due to the same syscall
from a different task which preempted the task running the previous
program?
Just asking because it wasn't clear to me, since we discussed
bpf_prog_get_recursion_context() instead.

> [...]
