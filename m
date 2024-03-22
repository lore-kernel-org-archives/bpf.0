Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFDD5C8F8
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125933; cv=none; b=RwYnWEJmsN5KNZg+v4YcaFOnW7fuLeqsHbIpqMh0vP4ABmFsk+rNHvhlNlQv7OAS91cpy1a1qagiTqvi9a2U/NZcP3bVyaOy3N+R56PId62isQBN+gjGC65qm0QVTmXEMbaNLv0J0eN6QJkHLIGTcTTwiFl6b3UM62jig4Xgegs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125933; c=relaxed/simple;
	bh=nMJERKd+wd1OEm5DSo0FfmVFfpFsmSfVQ2z2Dt4FRx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cn7yuPwbLFE5wcG3FPGFVxURnnWClpZe11ziXOPxIG12tXAot0OgenucwsqHQ2R5p0obpHH96O/qfQBJhZPTeBuiiwSIp1jnXxexO8k1LkkwiKlfXP3Zz9oJjsWMyZuBmH2STUxWVlgMP0EIeBll5T+PEoAXdwF2uF5r/CPCHeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3wyrp0p; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3wyrp0p"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29a5f100c1aso1414856a91.0
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 09:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711125930; x=1711730730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xg09QVoUZKnhKRdG2DTQiLc8j1k9EWvo6w+HSH0CWy0=;
        b=A3wyrp0pW2g+7Szx2V2fzS2dx7W+Bvj5pwBH5Fm5T/x0d3u1GsKvEADFEoj4wcQwjU
         AWEz2zm4n76vLfG7LEHY4cTJ67zqXC9n/rNWdDj2IxhhW4yltdheskqurj4VXUSbwSFN
         Cadv3rWgHUSCCppCIcsXf62XzEheSRyuVt0WX2my0ZkXKvop9fWFRk2mWIPGtukMQ5ZN
         krBcPNUBvoc//TAya14t0OHmP3D0jyqt2R9wrS1D1mTvqe+eaRNHz5ZFkxj4AXh3pHtJ
         eFZkyv+xG5Ma7b8/g8U57EaJHUYRMw187I95vzGpFwEej8o0xuZq2HWYZ1ajnUheAFe6
         jRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711125930; x=1711730730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xg09QVoUZKnhKRdG2DTQiLc8j1k9EWvo6w+HSH0CWy0=;
        b=QKVHOr441g/fplOqW1N8GNTrscLSOyA9gERhl0K3o15R1pQrUu6ldt3znSgcf0yZoO
         BsQm6m9dllV0uz+e45LbT/kjn5yFh25QiKmSsIM5vL4BGXXShGXzmR13jVY4y08kDElZ
         1JROhOzTUb/4EMYaAI+fczCiyUaN0PAqJ0jAqagCjpLwcOerYkrAxV5AS/2AKB0Er+cF
         tycFNhOOECHD+ABIPlTWWiALq6xhgGj2lrPDmr7E2Ny6YZJ9SOnPcV0yuMvMK8ussbj/
         3tdqrqk7KzBU6FzwhnTwvN4eOenYNvTQdDZT66Wah7X/+EGCrvVxG9NbP5hYDgKRD9oE
         LvJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRkq85yqeTTu1bz10eg5U71tJwkKtyp/oeMJpDDKRNmNiM4l4AZama8LOzOl+LxCZ6Sc/FQYkaQqg4AyCR6A21tDdt
X-Gm-Message-State: AOJu0YwZkvBlsiH9gaWGk8L6trRCa/dV755jvQhVdQdyBR1c0rm2NNiX
	yi70N4wwPWmXQKeOZZWLCud9510/ubsqUo1l2KosfssFLlQVysL3F4w4wf+cV4aOibYRJnxbdGr
	/wp16VyVS65kC/g6x8Nm2tVqUkeD3pMVC
X-Google-Smtp-Source: AGHT+IGu6etZNHQ141yA4P3rpMyJ+xALNZOijOfXY4GRTdDfM/rxg+cAfTzDxwQtg0Z8Wk5nXDfAIpH3t+LzqrS7R/E=
X-Received: by 2002:a17:90a:ce09:b0:299:3f5d:b5e8 with SMTP id
 f9-20020a17090ace0900b002993f5db5e8mr189095pju.20.1711125930295; Fri, 22 Mar
 2024 09:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321180501.734779-1-andrii@kernel.org> <CAADnVQJqnLnv4AUvCaefP13CDcJOXM=kJpSOv33t-u-OTzb0UQ@mail.gmail.com>
In-Reply-To: <CAADnVQJqnLnv4AUvCaefP13CDcJOXM=kJpSOv33t-u-OTzb0UQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Mar 2024 09:45:18 -0700
Message-ID: <CAEf4BzYFc1b-OAXWf4WN_vM2evZgsW7reJqo8iwKP80EXBJMKw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Inline two LBR-related helpers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 4:46=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 21, 2024 at 11:05=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >
> >
> > There are still ways to reduce number of "wasted" records further, this=
 is
> > a problem that requires many small and rather independent steps.
>
> I feel this is a wrong path to follow.
> I think it would be better to introduce a flag for kprobe/fentry
> to do perf_snapshot_branch_stack() as early as possible
> and then bpf prog can copy these 16 or 32 8-byte entries at
> its leasure.

This is basically how Song started when he was adding this feature a
few years ago. And I feel like we discussed this and decided that it
would be cleaner to let the BPF program decide when (and whether) to
get LBR, based on conditions. It still feels like a right tradeoff.

Granted, for PERF_SAMPLE_BRANCH_ANY you gotta take it immediately (and
that's what retsnoop does), but for PERF_SAMPLE_BRANCH_ANY_RETURN this
doesn't have to happen so fast. BPF program can evaluate some
conditions and grab LBR optionally, saving the overhead.

With prog flag saying "kernel should capture LBR ASAP", we:
  a) lose this flexibility to decide whether and when to grab LBR;
  b) pay overhead regardless if LBR is ever actually used for any
given prog invocation;
  c) have to dedicate a pretty large (32 * 24 =3D 768 bytes) per-CPU
buffers for something that is pretty niche (though hugely valuable
when needed, of course);
  d) each program type that supports bpf_get_branch_snapshot() helper
needs to implement this logic in their corresponding
`bpf_prog_run_xxx()` running helpers, which is more than a few places.

Now, let's see how much we can also realistically save with this approach.

For fentry, we do save a few (2) entries, indeed. With changes in this
patch we are at:

  [#07] __sys_bpf+0xdfc                          ->  __x64_sys_bpf+0x18
  [#06] __x64_sys_bpf+0x1a                       ->
bpf_trampoline_6442508829+0x7f
  [#05] bpf_trampoline_6442508829+0x9c           ->  __bpf_prog_enter_recur=
+0x0
  [#04] __bpf_prog_enter_recur+0x9               ->  migrate_disable+0x0
  [#03] migrate_disable+0x37                     ->  __bpf_prog_enter_recur=
+0xe
  [#02] __bpf_prog_enter_recur+0x43              ->
bpf_trampoline_6442508829+0xa1
  [#01] bpf_trampoline_6442508829+0xad           ->
bpf_prog_dc54a596b39d4177_fexit1+0x0
  [#00] bpf_prog_dc54a596b39d4177_fexit1+0x101   ->
intel_pmu_snapshot_branch_stack+0x0

With flag and kernel support, we'll be at something like

  [#07] __sys_bpf+0xdfc                          ->  __x64_sys_bpf+0x18
  [#06] __x64_sys_bpf+0x1a                       ->
bpf_trampoline_6442508829+0x7f
  [#05] bpf_trampoline_6442508829+0x9c           ->  __bpf_prog_enter_recur=
+0x0
  [#04] __bpf_prog_enter_recur+0x9               ->  migrate_disable+0x0
  [#03] migrate_disable+0x37                     ->  __bpf_prog_enter_recur=
+0xe
  [#02] __bpf_prog_enter_recur+0x43              ->
intel_pmu_snapshot_branch_stack+0x0

So we get 2 extra LBRs at the expense of all those downsides I mentioned ab=
ove.

But for kretprobe-multi it's even worse (just 1). With changes in this
patch set, we are at:

  [#10] __sys_bpf+0xdfc                          ->  arch_rethook_trampolin=
e+0x0
  [#09] arch_rethook_trampoline+0x27             ->
arch_rethook_trampoline_callback+0x0
  [#08] arch_rethook_trampoline_callback+0x31    ->
rethook_trampoline_handler+0x0
  [#07] rethook_trampoline_handler+0x6f          ->  fprobe_exit_handler+0x=
0
  [#06] fprobe_exit_handler+0x3d                 ->  rcu_is_watching+0x0
  [#05] rcu_is_watching+0x17                     ->  fprobe_exit_handler+0x=
42
  [#04] fprobe_exit_handler+0xb4                 ->
kprobe_multi_link_exit_handler+0x0
  [#03] kprobe_multi_link_exit_handler+0x31      ->  migrate_disable+0x0
  [#02] migrate_disable+0x37                     ->
kprobe_multi_link_exit_handler+0x36
  [#01] kprobe_multi_link_exit_handler+0x5c      ->
bpf_prog_2b455b4f8a8d48c5_kexit+0x0
  [#00] bpf_prog_2b455b4f8a8d48c5_kexit+0xa3     ->
intel_pmu_snapshot_branch_stack+0x0

With custom flag support:

  [#10] __sys_bpf+0xdfc                          ->  arch_rethook_trampolin=
e+0x0
  [#09] arch_rethook_trampoline+0x27             ->
arch_rethook_trampoline_callback+0x0
  [#08] arch_rethook_trampoline_callback+0x31    ->
rethook_trampoline_handler+0x0
  [#07] rethook_trampoline_handler+0x6f          ->  fprobe_exit_handler+0x=
0
  [#06] fprobe_exit_handler+0x3d                 ->  rcu_is_watching+0x0
  [#05] rcu_is_watching+0x17                     ->  fprobe_exit_handler+0x=
42
  [#04] fprobe_exit_handler+0xb4                 ->
kprobe_multi_link_exit_handler+0x0
  [#03] kprobe_multi_link_exit_handler+0x31      ->  migrate_disable+0x0
  [#02] migrate_disable+0x37                     ->
kprobe_multi_link_exit_handler+0x36
  [#01] kprobe_multi_link_exit_handler+0x5c      ->
intel_pmu_snapshot_branch_stack+0x0

We save just 1 extra LBR record.

For PERF_SAMPLE_BRANCH_ANY_RETURN return mode there will be no savings
at all. Is it really worth it?

Any other improvements (like flattening of rethook call pass somehow)
will benefit both approaches equally.

> Hacking all over the kernel and requiring bpf prog to call
> bpf_get_branch_snapshot() in the first few instructions
> looks like self inflicted pain.

While inlining bpf_get_branch_snapshot() does benefit only LBR use
case, it's a rather typical BPF helper inlining procedure we do for a
lot of helpers, so it's not exactly a hack or anything, just an
optimization.

But inlining bpf_get_smp_processor_id() goes way beyond LBR, it's a
pretty frequently used helper used to implement various
BPF-program-specific per-CPU usages (recursion protection, temporary
storage, or just plain replacing BPF_MAP_TYPE_ARRAY_PERCPU with global
variables, which is already a bit faster approach, and now will be
even faster). And the implementation is well-contained.
