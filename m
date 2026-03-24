Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4582ECE9B
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382182; cv=pass; b=C48xFI8qU0KBwQ7mGo/rJX9nrqI54/NkZv+ny5wmM4266/A2ETzvBwXxlHGJFuQj/Jin32c09Ner/uISRPRWo2mXnXSwEPBliI3UZFYZRDoyKxnBEB5FtsNU+lPPpG7+MpOiTJnXvayP+O8p5k3DI6uGhRNZVi4NSyOEE+8G1k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382182; c=relaxed/simple;
	bh=HdeSv//rf3/Q5CI04QJIFd/tTh2gIioZVNJv3xbWO7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSQhCk/VxZpALYsfA1ArxqqnTHjOdfGjf1MO+n5wAtBDuIYbl8fqHL1HEdoVvsYP2JKrFTCvLKuCV6x/xiWez3D5vbaDBxE0qBss3w/8mZ0NRwvsqEUwrHAMQ51cTnoEOCvrejkojrkvl/dPDpi9XU6TCkxHf+e1O4fhs6XMKwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVW91wJg; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVW91wJg"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439b94a19fdso4038668f8f.0
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 12:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774382179; cv=none;
        d=google.com; s=arc-20240605;
        b=j6RLOjj8jFRNpCLjH3HubQD4+2NRZ7hINFC9ziAVcPqVOuslvE5D9YvErChkY2d4A8
         D5PnVLgRV4Dcs8aHa1+ACjWMIy68mpRJt5w055gFcyYiq6CowloUbhKpUTNFIgEeZ/1Y
         nQNgS/LN6/Y8+NOlqsVncANnf0Zsfym3hLWbxAtw/0l6HEtEfuJwYVtfrdhYNUdsTEn8
         JaVD6V7/FL3qflyXiVZfRuQO0CZf02Jy1CzK/hUTYK7odbZl6KQJU2T109C2U1869lPE
         5CusO2UqvUkVUC//GQbn9Ygm6Ad4fRz4XdOiuzQfkMLU7szaprY287sDjl/cUOrFmq0X
         6Kqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fMTElr/1qM+QD41PA/qAY/jaP9tLMh5Xsdai4VeMyGk=;
        fh=oEMtQAMr3zPZpaJG5v1tfpkLsv0x83ljrknzlFra+uA=;
        b=D3I2CIzVHtkGrQWNz6Px1yPyYKXLu1obpfadFIQIRcoxH9tMpoO7o8Ppdan2WmnlW1
         2b8zjOPp+8jLsKwhlPRDg1Ib5EV9jdgsNQMEZwz0786GP47GxFbfZSUZJ8dh48GLOCWH
         ujPkm7654+0n2BwZCVZ/71014UJ2tHt7qSSU2ASZDB/bIZDlVzpVU8gcPlOY+dvJ1x07
         UTKkAi+/P47DKsDOOTnQOeAqTTXYj2kR5HwNN2zz2pkNKwEPugkeDEG6p7xQDaHVYqH+
         yCp6xOg0gCOH7pcV1f0qdh69gp0OrbNdPABmApbAeB8JhmOKFg6LlB3Uo/nxmCvOecGW
         o4+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774382179; x=1774986979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMTElr/1qM+QD41PA/qAY/jaP9tLMh5Xsdai4VeMyGk=;
        b=TVW91wJg3HHWfQBO70qXaD+NZhs7bUwQ9BK6q1jab0ks4NUSSgUeCxsQwlJhQQ38Zu
         tcnIO6u2xH8jr1Yj1cLuYKopw6xt/0r9pgINSwXeAq7Zp2yj7uCRKjxHuQZcyqebVdLd
         sJHH/pqCJnrAgPGgE+aMJ7MYf6oJEgv0OK8g/0xCTNNS69l2Afk6/OuFWy4tA1SqoOjr
         orpqQnaQEn3gOsOC7lJpEk5Nxtwg/56YK8W8A6cZP5Xecj+qpgitEm7BPObCE9y9Yd+G
         NZVOy9Si7rZZzN+3XFCCwNYQ3hc0s45+BAEeJBVMxnj5EDkMK1gyMn0WXAhiF+KvE8PT
         EfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774382179; x=1774986979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fMTElr/1qM+QD41PA/qAY/jaP9tLMh5Xsdai4VeMyGk=;
        b=fmXxHILg1THnTrjtY9BAQ5PmGHrmGQTc8nWSlkD0ut/xofmyFBgMg2o/6rAChoCd3t
         x7rDWdT8zjniKhyNn4AQ7x+uNmleUxXNV5RJMfCec+MbAhdbgp/YqKmPJlrBPyuBkolL
         oIW5yN9TzppYjtRDMlrRDqg50MT4tA9Aby7e6sdZO7PawK2xuMOpCinq3Tc+TXoxQUew
         k/0H68FGhNnmPL5D4rjt/eKo0aD2fgJzIYjXn3AgOeMMSNXIl6KT5MWlKf1Q2vblIXXn
         4Ea5q7k/9HSt0jrDlUGgk+JPE+vpT4r5gAYnMIX0i9sZOuDUz+KDJz4JC9aSnvFpFlLm
         J2vw==
X-Gm-Message-State: AOJu0YwMRdmsp/k5nZeWMK1Jw8S2vRi784EFnVS9jR1CdoUV0lKbDMDH
	SAOBZbbL9z7BsfLA4PoXP6MKH3qO5vLQnOYn+VR3LcB9rVL1+wplx/9JIcGDbQ2xTQhyYSKlILb
	+xBoEGMsxiQlq4MIIjV+qsnoCE29ro1s=
X-Gm-Gg: ATEYQzyPQ28r1emuAS14y9HoNL/Fk+uU8/P16vhZP5IQuf10wNmAkL4pVMK7PBG32Ra
	gWsT4XYSD2NoRRl3OnDsp//8wjygTPojupOSeyOB+j3QUSQTMhRnzk8BJE6V99GiMUTwY8osyGZ
	CYZUwNeHkTvPH5/9GFvpPxaVWoxXGQPMjto7DAMg4VnQVxbWD3ZImFmXy12cmExBBNZ7aRs+LIZ
	LmCBJ1Is4AqQusziHmqvLqDWNBnQfHxs+f+jiHJM5cIrBwTt7ExAtbO7L4NUs7s/XtICcD4V7OZ
	MaCB2wCyJjd43ePJ+uxivwUKeZSx4o4a2yXhD3OcKstRac8SqmuCZ5owzt9ViPD17uUlf32ubjf
	lSrfBWcAXCyo+9l4cm2fljMor7A==
X-Received: by 2002:a5d:588a:0:b0:43b:3d02:7806 with SMTP id
 ffacd0b85a97d-43b88a055d7mr1207639f8f.28.1774382179530; Tue, 24 Mar 2026
 12:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-sleepable_tracepoints-v6-0-81bab3a43f25@meta.com> <20260324-sleepable_tracepoints-v6-3-81bab3a43f25@meta.com>
In-Reply-To: <20260324-sleepable_tracepoints-v6-3-81bab3a43f25@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 12:56:07 -0700
X-Gm-Features: AQROBzCNlI2YrQikkOR2Pnat69YtlSbaTZeCzHdAPpbzcIEuBNA-KrwY6v7zuOU
Message-ID: <CAADnVQLwU3Hz-KgvdpSx+qtkmsUvJ_MeWc0T2Fisnyk+OC3grg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/6] bpf: Add sleepable support for classic
 tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 12:03=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add trace_call_bpf_faultable(), a variant of trace_call_bpf() for
> faultable tracepoints that supports sleepable BPF programs. It uses
> rcu_tasks_trace for lifetime protection and
> bpf_prog_run_array_sleepable() for per-program RCU flavor selection,
> following the uprobe_prog_run() pattern.
>
> Restructure perf_syscall_enter() and perf_syscall_exit() to run BPF
> filter before perf event processing. Previously, BPF ran after the
> per-cpu perf trace buffer was allocated under preempt_disable,
> requiring cleanup via perf_swevent_put_recursion_context() on filter.
> Now BPF runs in faultable context before preempt_disable, reading
> syscall arguments from local variables instead of the per-cpu trace
> record, removing the dependency on buffer allocation. This allows
> sleepable BPF programs to execute and avoids unnecessary buffer
> allocation when BPF filters the event. The perf event submission
> path (buffer allocation, fill, submit) remains under preempt_disable
> as before.
>
> Add an attach-time check in __perf_event_set_bpf_prog() to reject
> sleepable BPF_PROG_TYPE_TRACEPOINT programs on non-syscall
> tracepoints, since only syscall tracepoints run in faultable context.
>
> This prepares the classic tracepoint runtime and attach paths for
> sleepable programs. The verifier changes to allow loading sleepable
> BPF_PROG_TYPE_TRACEPOINT programs are in a subsequent patch.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/linux/trace_events.h  |   6 +++
>  kernel/events/core.c          |   9 ++++
>  kernel/trace/bpf_trace.c      |  29 +++++++++++
>  kernel/trace/trace_syscalls.c | 110 ++++++++++++++++++++++--------------=
------

cc Peter and Steven when you respin. We need acks here.
Or drop this part for now.
