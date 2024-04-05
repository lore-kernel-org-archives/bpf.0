Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875F71465AD
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305732; cv=none; b=eq5plxhgamUaZ+us5L8kCJySPHS6TWOZuiu5KPOUn3JEfHurKmmyIWROtbivrSo56eZiv6SYpXbvxp+kZdHNJZwaW8G2wB0Ek9mRBn4pMHlsVPKwWUkwdyfcM7QxuPlfo9+ah4zsKntprsn1fsx61HTOgVweRX92pvKRqF9BbUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305732; c=relaxed/simple;
	bh=Z5bRgo90vJ1prRsFQfV4KcyZkLttI8kAD0ramKMPe8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6Rsi6Ef2qxTuDF33omzVhEwmUOf7y+vjDJET5Wv3vLIO7E2cQlxvAzDjAMpZA7yW+W6yp3KLVilgmUvrQRSlVKH+nw51IV8uUO/aNnDRKtbHGQm+jGF8iaFxbdoTh5k+Z+J4fJ2JPXga0CuAMA2MDaj2NFK7T8cIp7qA2nioEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t3Ca323N; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t3Ca323N"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4d523586a59so721597e0c.2
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 01:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712305729; x=1712910529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcjU7+cRt5Aeub+hKdmibp7iA42IF2luH5dCAZQQUiM=;
        b=t3Ca323NtbTE0MQvO2a6bAWun/Yr72xOl+dUJY+P4/CBsVj0WYdtyMkNySkcC0Hf0O
         neBlsEYsEiT1m8OK3fhVSiHL0RnG7FSPMGYacOXfZvgCG5R6CyTb5inMAk9U2rKMwsTE
         D9lwcmybgMAxKKYTJGBQugqphmwSJmaDAXZUVT83E82B5aR+iEhzB35+dap8OBH+x0Vo
         kEjk/9pGHdWtITgiMlpLCeyEWRofNF+KwV/SjkqDlgVLVjV0KVOgw8224euGxz3VZgj+
         n94i9nTdpVcoMFwdoDDnSiy31FcmXxF5OzGGPXFbJtmQIHnvly+LzroSD+VjVgY2aaJt
         8afA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712305729; x=1712910529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcjU7+cRt5Aeub+hKdmibp7iA42IF2luH5dCAZQQUiM=;
        b=mYZY5PSv2e136FW5GgJJjT7bBC+/5X3wdwGGP1ARZtR4dfm8Ktm3StWLG6Gfo+Us/v
         3GZL+J0bygj50igqIJDcKirHInuTwHRytU0qqYx58PGAmR7WsW04XYz59uLLVY3OkUub
         YNvgYzmd1XVKy5vHLovtcmOy0eWBcF4zyOZz7kWzNmeePFrDYrW3RntcVA52UtL+EiE2
         m+kuQ+Q4LYVfoS3biR3DckE5HCEb6jMkelxNBzHPaLqWaznKMcSPxr8pamutsHVpnqgb
         A1ggE9KLqtO/24C7V3uYU7O+7LwGNrMn2m66QFk3J7Y75O2m+m4rhlvdUSJ227YfZh4W
         nM4A==
X-Forwarded-Encrypted: i=1; AJvYcCVgGPCS35sld7u4oTUbRTjsbtEwLJ5/JoKSPm+hSJtjyGYYua5dY58goQiR+u5HClVhj8Vj5PjJN6ym34Z9mu8XeRpZ
X-Gm-Message-State: AOJu0YwLDDxLjFlUxYnm3ZmlN86AqZLbUErXS0KjSxKfq+gCNFB2Exoo
	abj6IvjAC0DmVw2crPdJjdg5NLOYS7Cim1IV0rjrZxtCry0y7EMUnN7GVdOfxJdhoqGj0xt4/Cn
	snS+8tC/1yLfm9LGgcz+Fuftr08L/u5dws6Of
X-Google-Smtp-Source: AGHT+IE9J6DVAmZzKmTiQk80OVY4ikVcmcvr9eGddNabGm/u9T4gAl9+FbNPe74Vg8+GJaziHkSrLGV5+PW+g6Pa8n0=
X-Received: by 2002:a1f:db04:0:b0:4c0:9ed8:57b3 with SMTP id
 s4-20020a1fdb04000000b004c09ed857b3mr764963vkg.1.1712305729227; Fri, 05 Apr
 2024 01:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404190146.1898103-1-elver@google.com> <CAADnVQKc+Z39k9wbU2MHf-fPFma+9QsyOugmmmGq3ynQCTVfCw@mail.gmail.com>
In-Reply-To: <CAADnVQKc+Z39k9wbU2MHf-fPFma+9QsyOugmmmGq3ynQCTVfCw@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Fri, 5 Apr 2024 10:28:10 +0200
Message-ID: <CANpmjNN+rR1PWKbx6RBWhOjnmAP+jUDzc3TLcwTnmfd=ft03dg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Introduce bpf_probe_write_user_registered()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Apr 2024 at 01:23, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Apr 4, 2024 at 12:02=E2=80=AFPM Marco Elver <elver@google.com> wr=
ote:
> >
> > With all the known caveats, tracing BPF programs may directly write to
> > user-space memory with the bpf_probe_write_user() helper. Memory safety
> > is an obvious problem when using this helper, since it is too easy to
> > overwrite memory across all running processes that user space did not
> > expect to be touched (neither the verifier nor the kernel knows what ma=
y
> > be touched). While it is possible to come up with mechanisms to safely
> > communicate to the BPF program which memory region may be written to,
> > there are no built-in guarantees of safety. For this reason, the helper
> > produces a warning in the kernel log, and in newer kernels it is
> > possible to disallow use of the helper since 51e1bb9eeaf7 ("bpf: Add
> > lockdown check for probe_write_user helper").
>
> So is it a fix or a feature?

Feature. The above paragraph is just an intro. Remove it?

> > Nevertheless, direct user-space memory writes from BPF programs can be
> > useful to efficiently manipulate and communicate with cooperating user
> > space processes.
>
> But there are many different ways for bpf to communicate with user space:
> perf ringbuf, bpf ringbug, various maps including mmap-ed array and arena=
.
> The commit log doesn't explain why we need another one.
>
> > For example, one of our use cases are for events that happen relatively
> > frequently in the kernel (e.g. specific scheduler events), but a set of
> > user space threads want to check for such events in very hot code paths
> > to make more optimal decisions (the cost of such a check can be no more
> > than a load and compare). The types of events and heuristics used may
> > change based on system environment and application, and a BPF program
> > provides the best trade-offs in terms of performance and deployment.
>
> and the tasks can use mmaped array shared across all or unique to each
> process.
> And both bpf and user space can read/write them with a single instruction=
.

That's BPF_F_MMAPABLE, right?

That does not work because the mmapped region is global. Our requirements a=
re:

1. Single tracing BPF program.

2. Per-process (per VM) memory region (here it's per-thread, but each
thread just registers the same process-wide region).  No sharing
between processes.

3. From #2 it follows: exec unregisters the registered memory region;
fork gets a cloned region.

4. Unprivileged processes can do prctl(REGISTER). Some of them might
not be able to use the bpf syscall.

The reason for #2 is that each user space process also writes to the
memory region (read by the BPF program to make updates depending on
what state it finds), and having shared state between processes
doesn't work here.

Is there any reasonable BPF facility that can do this today? (If
BPF_F_MMAPABLE could do it while satisfying requirements 2-4, I'd be a
happy camper.)

bpf_probe_write_user() can, but safety is not built in, along with
getting fork + exec right is brittle.

> > To achieve better safety, introduce tagged user writable regions, that
> > must explicitly be registered before tracing BPF programs may use them:
> >
> >  1. The prctl() option PR_BPF_REGISTER_WRITABLE allows any user space
> >     process (that is allowed to use prctl()) to register tagged writabl=
e
> >     memory regions for the current thread.
> >
> >  2. Conversely, the prctl() option PR_BPF_UNREGISTER_WRITABLE allows a
> >     user space process to unregister a writable memory region that was
> >     previously registered from the current thread. This must be done
> >     before freeing memory if the thread that registered a region is
> >     still running.
> >
> >  3. Tracing BPF programs may write to any registered region in the
> >     current thread with bpf_probe_write_user_registered(). If the memor=
y
> >     region has been tagged with a non-zero value, the BPF program must
> >     provide a matching tag.
> >
> > Admin capabilities are still required to attach BPF programs that use
> > the new bpf_probe_write_user_registered() helper.
>
> We stopped adding new helpers ~2 years ago.
> Only new kfuncs are allowed.

Sure.

> >
> > With this interface, user space threads are guaranteed that no writes
> > happen to regions that they did not explicitly register. Tagging can be
> > used to associate additional semantics with the memory region.
> >
> > A note on tag allocation: Since such programs can only be installed by
> > the local system administrator, tag allocation may be done by the syste=
m
> > administrator. For example, by providing headers with tag definitions,
> > or a central service to distribute tags to the BPF program loader and t=
o
> > user applications.
>
> Not clear how that's achieved in practice.
> To do prctl(REGSISTER, ... tag)
> the process will just pass this u32 tag.
> There is no way for the admin or other process to enforce certain
> tag usage.
> Since there is no way to enforce extra tag seems like a weak
> protection against something? What in particular?

The main goal is to a) avoid accidental writes into areas the user
space program doesn't want writing to, along with 2) weakly
associating "type" via a tag. As soon as the user space program does
prctl(REGISTER, tag) it wants writes to happen. It's the user space
program's fault if it uses random tags, because in practice, we know
exactly which BPF programs are running in production and which tags
they service. The programs we do _care_ about are reviewed and do use
the right tags. The mechanism is not for protecting BPF programs or
what data they communicate, but for the benefit of the user space
program itself to bound the memory that could be touched in its own
address space (use the wrong region/tag .. tough luck).
