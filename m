Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020C405AC1
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543999; cv=pass; b=cYU8VAK4WtPtgbYGL2bJKK8ktbOBfH+zeBiJ33AGBb1k9EfTMr52R6twSQb/vsIKXC3gW3Slw2jXesCtZUuSAuqaCG9Ui9ZyQVoD7tvVoCRn0VCAUHNYITyt+6B/1Q6y5nvsQPA8VmqUr3YD2h4jy/gDBOz7qpgHY8ld2Y1HVrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543999; c=relaxed/simple;
	bh=LCsZ3lZBerC2oo+MzeEykaeXH8sGTX2c07YUrr3pbTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acSABqDgTyK9JdsiYWJqwjhvdfdfy70c52mZuk+aDc3Jv1ZeSYmOSsTZg3oKV7Mc7hsjwG2fc70BKTcy7/e0C9WaQnh7FGNds89+I0TEBlfu+g+FG2QcbIcU/BeQTbqWyAVRzlAalykBWdRirApQRAQ5PrLI76Z1l7dq59aOU8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2/C2JkU; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2/C2JkU"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-439b6d9c981so752959f8f.1
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 09:53:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774543996; cv=none;
        d=google.com; s=arc-20240605;
        b=Hk4Y8Wh36Ru4yYeNJpgddhSCDiDT16BCMSOUNMuD9V0fbpX38llEEimCD8vpOE7KlG
         ietxXdJTO6JrXZaL+XTWf6TTwqLUEd2nPOMIaHPdWidePVgIxPWApYsXMdltMx4HP9s6
         d/pRXAWgf1u57iASG83bYlloiFLJz0VIOO9AfYHkzxIFRA16sYwPxS4nlXgbjlg6EoGm
         PFL80IzXnsUvkFQWa0TZFUtGEBV1wz2f6RpQ5SKcHJyeLvq7lvJzmpdBJhi1Dl46pu5p
         SMufpHeDq6IxS+aP8oc3jFR3Jua7Blztgo8v2qtUlNAF5mDqzTco8lzUL1oNHoAX4/d9
         2+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qoFd78X6YpKWAicxJtLC/g0L9C/qV0h/eQ9xH9ncJmk=;
        fh=1JuR1Aycb0V8ZSPv77yGVmIk71vaa0wSf/gOb+23LOc=;
        b=VRtThd5J/WtWm7ln3hZanxeem5WwLXKVdTaT+helHVeZtGyWVFhqPE/yVjxR7eaR7r
         3IWq5hDnnMwtLZwYSA+Zj0N+EzSLZJ64GoXC182tSBW1rrOHIUcd11R+kCgczuA/kWKB
         Y36//SdgWfbXh3jFbCjH7hH89W3hPoOLrYItzrsvhkwCUosnkgWUaHb7j/LjJTU4EEW1
         KaiJRKOKxRL2kxlPqmeAB4KeFnQ9+xWvDUxFIarafIM+lXu2uiz+LfiQN2WT8pT1BlxF
         AyPinpVRHN3hrVZIyq/ef9YLwF/p6o1arN8pYeB0j/EAFXdeihyfsZphU6uWn6SvE7nU
         mjFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774543996; x=1775148796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qoFd78X6YpKWAicxJtLC/g0L9C/qV0h/eQ9xH9ncJmk=;
        b=j2/C2JkUV1VQ7MdGO1pNSgZYD5Gq3brPmqhxrX/lbhbZj7Bof4dkjhP3VzdZOUoGsi
         jFsWyvzp/sPpBH8rcud2apvLTMlzz2TNS9W7mVY95fC6M0hcKRrx04sh8cR7RS5qrhWQ
         PLtTgxV+fANZGtjaQ6O2N4FRMCveXq7WKK0wdNbFTAlKsNStkCoF5b37hURoonrYXvqo
         w44uXKNDpOsVJUelTGG6vxpw+G6iy9izGQ5WJQzLUAvUJT+lGriFEeAvPbkAv+EztBi/
         KLxb8mIa+Oh9SfxLYi4U8loSJApwTdSROWBmWGXNSH/lnmbCyx2xXRm8Bh7IsebOGjFF
         oFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774543996; x=1775148796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoFd78X6YpKWAicxJtLC/g0L9C/qV0h/eQ9xH9ncJmk=;
        b=RJuWPHtfU4xhV9KIsBoBZRQsPyZsTBQxURdAUZQOPzsl5ZBYVg6RemZC761C9LxSup
         7A19U4KYHWvmMOKZovhcovkUp+xhYp8DT1NqkM4pPK3g1Uu6j00e7kIRYRzPRnL+scgT
         omCWPtM0FKlTHlELbFzK248NgP/e3Ea4nOwSbPoaR9TttvljCHPId18OLTlfpLKtAzN+
         1Qv4dGF06kS3UsDYcz9YolOT3/rRVsk7pnwbQTjWAYvSbxJ3qLjq1eyO5Xj9brIB1n4b
         d6zKOPTxPuoHA6+6s023AnCVC3e9yoyvsHnk5Bg6h6g3ar3pooxV1Q7zcOTbiWD1CH0J
         gfAA==
X-Gm-Message-State: AOJu0Yw4gTFnpGT+g+IofW58cWHI4PNHlqLFFB/ed1g7ThFzfknKOMwE
	zCHs00yekxzQIakqFLBqQuzap8YjJYpQqIihEdk6I+VM4OmsMMn1CHTERzOunh3hsGoDks4oJ+I
	2vIpvi2k92U+eh9y177aqMVS0MsmHSXM=
X-Gm-Gg: ATEYQzzqikM1KMlFLLUXRW9lACnDe2U6YDh+pqVUEJqaRX9A49ee/ExCZEhKHi2m+7G
	Xz0BAj4YzrbSQHIGw4ZwHjk2xVXZmnnk/18XrFC4Nzo9Arj6viJaGKK1tqTZiTNxVsJdKswiyp6
	EtnTYOO/ATs5lNuE8dEFx1aNzY8kavy2TjqFAR1Z2jdgOe29/gCWHBSdgmGtWVAANG8/ftKbAtz
	L8z6dFtx0xhQ6wtL+gmV+UJ1YOnzr44ea3eX/smhdLWAg5uQT8QLxTwLg81lMJ6MAZ+0irdQorU
	+NBowQvRWg167XfXyI5YPoHsGegd+2ouW2N2/NQrkeuQR8hVzvclFj5DYahK
X-Received: by 2002:a05:6000:1848:b0:437:7719:ca82 with SMTP id
 ffacd0b85a97d-43b979fc0f2mr4433868f8f.3.1774543996426; Thu, 26 Mar 2026
 09:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325-sleepable_tracepoints-v6-0-2b182dacea13@meta.com>
In-Reply-To: <20260325-sleepable_tracepoints-v6-0-2b182dacea13@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 26 Mar 2026 17:52:39 +0100
X-Gm-Features: AQROBzDuNxyXz9OoDi7pAiSYMF36KCnCgzxBX3N2NEgCrJ7Sx80e-RlSvy4oYCY
Message-ID: <CAP01T74=ckD5V4OR5Yydru4QGuDSJoBdrutetxujRgZK3H30bw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/6] bpf: Add support for sleepable tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Mar 2026 at 19:55, Mykyta Yatsenko
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
> Changes in v7:
> - Add recursion check (bpf_prog_get_recursion_context()) to make sure
> private stack is safe when sleepable program is preempted by itself
> (Alexei, Kumar)
> - Use combined rcu_read_lock_dont_migrate() instead of separate
> rcu_read_lock()/migrate_disable() calls for non-sleepable path (Alexei)
> - Link to v6: https://lore.kernel.org/bpf/20260324-sleepable_tracepoints-v6-0-81bab3a43f25@meta.com/
>

It generally looks good to me FWIW.

I looked through Sashiko's reviews [0], everything except the bit
about bpf_prog_test_run() looks bogus to me, but please double check.
bpf_prog_test_run() bit is definitely real, I can get a splat by doing
a run for sleepable raw_tp prog. Please add a test case to cover this.

I think you resent it as v6 by mistake, please fix that in respin
(should be v8 now).
Tests have copyright year as 2025, since you will respin that is also
something worth addressing while at it.

  [0]: https://sashiko.dev/#/patchset/20260325-sleepable_tracepoints-v6-0-2b182dacea13%40meta.com

pw-bot: cr
