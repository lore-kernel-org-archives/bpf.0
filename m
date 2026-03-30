Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1733D6486
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 14:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774879456; cv=pass; b=iV3Xhed5drhbsywaLnUUqApaRiCDw/J5MSP4wcUxHQGiDD20AcDeif70A01X5PKZ64OphYn4a1tNnVkHjfkX14eHeNtyyH3gcDQ7nAHspG4iXitTaEe7B8HpLDo/7U/ql8DG3cTY5KlA676CYoPcfVtQrXQXHkFmmtO9T+lvEv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774879456; c=relaxed/simple;
	bh=IwM6nia+w7O2Dw2MvtPP09/3GYS4kTAv9x+p/WQcg3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5R8A9+qW0xYZfq3WdWAVnDZsYicGytWfVpocCRttSYLn5h2GLAS7Mys1TWZsznh8VpbfZE+nCbOHrmD6qE9eF8CPzaMGlnWkd0RgI4Qe8OJLve/MiDGFLtWz/b7MlQCe7Q/XCA42Zu4fB9I/dqNOJNK6gs3lPKFp99QmPEKcwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rcrHtazy; arc=pass smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcrHtazy"
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so605186066b.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 07:04:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774879453; cv=none;
        d=google.com; s=arc-20240605;
        b=RarE2e/JFKRJCRMwa/GD7nz19dX6heTu4UHzRguyuWpRb/JmX/nGOz9e3XMrnvzl0c
         G271sxx1zPHgQL1shRcNZZIKBsA9rg1puiinS+GzzWwgyynIzxuUXps3Fov6Bj/CMufs
         igj02h0H8lGVWeKIiF+AK3n0NV2HuVpiUlenNbYpar03MRz1bt8C/OkV2E5OsPJx5gX6
         r/dlV6belRdDCEAGJX67p55rl+N7Ih0gsqL6fmb84RJbb6vXVcmoSP6VlPbd+xhR40ao
         APlFv64Bw01D/Cs2EiISTJb9tSMLb8RF9Dw6sMjGrpRU/jva980Jx7HwCbUEMKvaMhTP
         9enw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Rjv3OuZpcpnmMaWIQN6HkcsI8txYFraJbAbYCdTBvDU=;
        fh=9d03gO6ZDIjrOrTeHaZeBUvVDHxN+aVkavLReq5lJ0A=;
        b=duCkYS0O0/9pwFVjXk3K32TSN4/N2cKe3xafqaxNSMol77tr5xQSmQxaocrc8+9i88
         Z1CU/3QeEABpt12wDJ/Wv4aqd5wewmFoCR7dG2TNae+bUkngcC9lW0U73zBWTmvuVOsf
         HxrabEActaDDOhL+BVuCegv6lfi96dNNwyGqi1dxeQujClroSpDTXgLemnNF5PWHdgH/
         OJpgWILvEjjMPuppuqJn/JIkVGTqeVCB/p+2XsQDgBoKJlcR2xq2m/Rd07wJ9hNejqR7
         W0/Uq8NibWlplDuEpU9AmY7KYbYyVLBWGzNv0rCAxrXuLYtfJBQ2lzaden85oQEl5Pja
         c39Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774879453; x=1775484253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rjv3OuZpcpnmMaWIQN6HkcsI8txYFraJbAbYCdTBvDU=;
        b=rcrHtazyvIAXeqDd0p4/vC//ByM2xY3c3zi0OTaui3dnONEFkkcjqfSZNskHo//AN3
         x3nAiyi2MScrK5l60TdN+/ZZfHfqyQ84e43J6B0qI6pxpqgqT0y/PXPeSnejer+bXr8C
         9ahPTAxFFLUeoLxPYuBe+kH066SZX/obN4AEb/a6kp3dYxw1JW63cBFeyyQ+6DNUq7FX
         iXx0t6wg//z9TQqkRdnSIbifMcP4cyRWNndpwc2Xcx0DyMOPVNzOpiGGybDg0AhV/MxF
         u6qhb4wYOUZaPGiBwWWtqnHQpmEYOVR/BS6MUpUoY6qCxnpCVTCZC5gVTl0PZCl/3QeK
         /VgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774879453; x=1775484253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rjv3OuZpcpnmMaWIQN6HkcsI8txYFraJbAbYCdTBvDU=;
        b=JKc2liLSoqC97+LasFXM6ZhYyYgvjQkid03SoR+HLYAUyRub7bdM+0gnYj1UR8nQy0
         ByYrGu+na35O6aO27nT7n4QeHaGIN+OqDEP/ygbo7lwckcLGs8ADEbzs1yBbwbDut5G+
         iNaIjB3zZ6N4XRigg2irdaIVCW7oFN2+kBSVOzbOG63HHdHOfGt0OYX8aybBk+pW86rn
         OAG5eJemtqrUMwwUMT4hmpyOS8OgMHoVGo+5XOIe0eM5I86yB4+bNQ44kNdMkAZVfXVy
         TjEaZr9XTTbu8m5VuhJXzGG9dV0ETWXD+8/nXG2m6Q6sDgjNalgz4WnLYIRK/wm9wqFi
         KMtA==
X-Gm-Message-State: AOJu0YySL3bthPWS1EetOziAgYuocrN9mE9s9kYIJgzzTfJRbV1mR020
	bmo+BcMPUlW+dczV4zUbCeHFtgWJn+0MqVsUkOVBep/axHOWlH7TumLf4pn6cNrkqjWnvkOh6cL
	sO+xVFNhUzZLWYRqx5MDrSLb1c8fsHIs=
X-Gm-Gg: ATEYQzzQTVHPvg3QCq/lh5WQhwbjHe9P2e9HHDqiIzXnBHCas7Gu+LdwsO3dl4ef4Hy
	upXtNrVw9QPLUW+4sLf9g5Je6TJRcPZHf8r9P7GRICguzybw3GB7qnqpgi6Iu6vCVK1W0ketBBx
	rfS5KuFsT+UfN7HlGs/z4UjjbfzZV1dsElpV5T2qBC8fHG/GDmuHpM3v7ZHTgUJK1PSR4G1yREq
	x48Tpmz7CruYcWYzbnLfgeNCqtsiC3OLaRG6I+j/OXrVrjJU9NpKMytKD9M0FMXOGYyvKNSkrsk
	lXCMmGrB3Wi5w2LRL5xJLfnXEFqN985mUCwSvbEXDUFPjosdkfP3UumHxVB7IdbwX45h86M=
X-Received: by 2002:a17:907:7ba4:b0:b98:2c44:6631 with SMTP id
 a640c23a62f3a-b9b502c0086mr658415966b.14.1774879453093; Mon, 30 Mar 2026
 07:04:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330032124.3141001-1-memxor@gmail.com> <20260330032124.3141001-2-memxor@gmail.com>
 <CAP01T77HcqyBKZRzRbLbHuZeskJ7XJ+FU2GQpZX-WXTCPMyikw@mail.gmail.com> <m25x6d1vsi.fsf@kernel.org>
In-Reply-To: <m25x6d1vsi.fsf@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 30 Mar 2026 16:03:36 +0200
X-Gm-Features: AQROBzBOzEMnKK_VI2QCfIu13WUcCUcM_DU23crI0vjPGjcRCCs6UwzEfjeh9YQ
Message-ID: <CAP01T76f-M9ZnaCCtjXspk+XmRb4mbs7yMnZX6NybviOiiyo7g@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix grace period wait for tracepoint bpf_link
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Mar 2026 at 12:00, Puranjay Mohan <puranjay@kernel.org> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> > On Mon, 30 Mar 2026 at 05:21, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >>
> >> Recently, tracepoints were switched from using disabled preemption
> >> (which acts as RCU read section) to SRCU-fast when they are not
> >> faultable. This means that to do a proper grace period wait for programs
> >> running in such tracepoints, we must use SRCU's grace period wait.
> >> This is only for non-faultable tracepoints, faultable ones continue
> >> using RCU Tasks Trace.
> >>
> >> However, bpf_link_free() currently does call_rcu() for all cases when
> >> the link is non-sleepable (hence, for tracepoints, non-faultable). Fix
> >> this by doing a call_srcu() grace period wait.
> >>
> >> As far RCU Tasks Trace gp -> RCU gp chaining is concerned, it is deemed
> >> unnecessary for tracepoint programs. The link and program are either
> >> accessed under RCU Tasks Trace protection, or SRCU-fast protection now.
> >>
> >> The earlier logic of chaining both RCU Tasks Trace and RCU gp waits was
> >> to generalize the logic, even if it conceded an extra RCU gp wait,
> >> however that is unnecessary for tracepoints even before this change.
> >> In practice no cost was paid since rcu_trace_implies_rcu_gp() was always
> >> true.
> >>
> >> Hence we need not chain any SRCU gp waits after RCU Tasks Trace.
> >
> > ... or chaining RCP gp after SRCU gp, rather, the commit log should
> > probably say that instead. The above might be confusing.
> > But more eyes on this would be great, I went back and read a few
> > discussions on why we were chaining RCU gp after RCU-tt gp and
> > couldn't convince myself it was necessary for the tracepoint path.
>
> Yeah the commit message is a bit hard to follow, let me try to lay out
> why chaining isn't needed for either case, let me know if you agree with
> this analysis:
>
> For non-faultable tracepoints (the call_srcu path):
>
> The tracepoint dispatch macro in __DECLARE_TRACE does:
>
>         guard(srcu_fast_notrace)(&tracepoint_srcu);
>         __DO_TRACE_CALL(name, args);
>
> which calls into __bpf_trace_##call, which calls bpf_trace_runN, and
> that ends up in __bpf_trace_run() where we have:
>
>         struct bpf_prog *prog = link->link.prog;
>         ...
>         rcu_read_lock_dont_migrate();
>         ...
>         run_ctx.bpf_cookie = link->cookie;
>         bpf_prog_run(prog, args);
>         ...
>         rcu_read_unlock_migrate();
>
> Both the link dereference (link->link.prog) and the
> rcu_read_lock_dont_migrate() happen inside the SRCU-fast read section
> from the tracepoint macro. So classic RCU is nested inside SRCU-fast
> here. When the SRCU grace period completes, all in-flight SRCU-fast
> readers have finished, which means all their nested classic RCU read
> sections have also finished. No need to chain a classic RCU GP after
> the SRCU GP.
>
> For faultable tracepoints (the call_rcu_tasks_trace path):
>
> __DECLARE_TRACE_SYSCALL uses guard(rcu_tasks_trace)() instead of
> SRCU-fast, so SRCU isn't involved at all on this path. The link and
> program are accessed exclusively under RCU Tasks Trace protection.
> A tasks trace GP is sufficient on its own, and since tasks trace GP
> implies classic RCU GP, there's nothing to chain.
>
> So in both cases, the outermost protection (SRCU-fast or tasks trace)
> is what we wait for in bpf_link_free(), and the inner
> rcu_read_lock_dont_migrate() in __bpf_trace_run() is subsumed by that
> outer GP wait.
>
> Am I missing something?

No, this is my thinking as well, but thanks for laying it out so clearly.
I think it was unnecessary before too but I think the purpose to chain
them was to keep things generic and not tracepoint specific.
I don't see a path to that here (or unnecessary chaining penalization
with RCU gp after SRCU gp, which isn't implied unlike with RCU-tt gp),
so I leaned toward the current change.

>
> Thanks,
> Puranjay
