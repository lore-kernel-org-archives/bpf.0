Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203C214D717
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 02:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711332358; cv=none; b=fidP5pC7oIiaxby6Kuox35xkKo8yUmxUet3z/4NfEYtXYoKnk/4PkU7vEjL/mPjNfXZ5GeDke9b2+QNL8uPxM/DBcgfKpviuFJRF1qzl5GQWdn0HtC+M4a1Sc9K0vcfV+qdWOJ3yDf799VNt+zIWF+OKHGjcjtNB4MyoyvA7QQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711332358; c=relaxed/simple;
	bh=ist6b2W8f51/dCldoqObvp0ORS0RN1sU7oiIBBo3ncs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9JrucIz9F8Gj9Nko8ybt24lmrw1N8+ChukHDLmFIaScocOkYYuB8yB3IS58+k3jeKOs7KKgkkbNYkWKBgU7nwO4JGOiUWAaq3T+FwORoNJRcqfE9QPdLpxghBkqUR088B5AM0V3D12EbkSiYlhE08sd16QVxLNWdiRe8VrnaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcKh1m+n; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcKh1m+n"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-341ccef5058so399199f8f.2
        for <bpf@vger.kernel.org>; Sun, 24 Mar 2024 19:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711332354; x=1711937154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRQPHZfFBmWJiYtdRcQoRHlFnkvR3KEopMtRyZgLzJ4=;
        b=dcKh1m+nZlmmVwygoGzwVCBVhFrjkmM2GvkeDGg6L/yESCp/4mLoMQfnTeoUEOGmSP
         QQ7gBOIdMQmUTS8EFiB1eBihs2TwKDL91u1gB8JGSk9xFUat07SiPO7iVsYPD2nrUiml
         mvOj7JASq+yCEMGUW8he+qYgUkqUUg/rpB/9iWaWnqQcf1kaqCUSdwjS1dyGblqcFBVm
         e22lu8dJHtlXSAwzEf+w7cbkpLzPaejY2OeGdBxc+SaCsnFFKidSo+TKWvkUthG0m2Aw
         oQEkUdJvMpMxymDX4zE4/4pk5GTNzlvwCQ7hc5zRBEqb2bMg0Luyj1UEDRSCpdMUizhl
         XgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711332354; x=1711937154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRQPHZfFBmWJiYtdRcQoRHlFnkvR3KEopMtRyZgLzJ4=;
        b=siCZSNIlYre9rcbOPR9JIafFjX7pWkvoS5+pDAVaN5wBM8KO9GC2a8/67kOg7NdxE/
         igDFoL2DUCkbzGx41HzDmDgJzU1vCDkW0i4WjXr4TxPLdpoOx3AUwP1dztMzM+WlfCVi
         N+TkRiJjdksXKDxVhqK4jUujH9TklqCwJG+vIwuWQSY/6ydluEevYIcyWwgnsQ3SLgm+
         MU5XHPocM5Y1nqUHLNkPdTED3wvX9S6fmonjwi78l7danIWi3e6vwvqQIIpDmNK38bIZ
         gF8h+2PHKBDP62C8RFOFWGVvo77hvM/BojzvMFGaNj9UwboSMfPfmjWN+cvVus1hDGP/
         nzFA==
X-Forwarded-Encrypted: i=1; AJvYcCU1AOxpzF49sG0it527wBp2wlTXmkzEpCmuOa8+e8ySKxFIRX3102oCE8PnsLCp0XZ/WGIvn1AEmAO5JtYSk94SFhhc
X-Gm-Message-State: AOJu0Yya8hwFIFw46kmW8vColyjXRHopZ6cKpPpq34SWFZUfuyztbCsJ
	lZvOAk4FtXkPAqOXeXOo92vtXFD8odYj4Jguyz1phHbfjWAPzd4KiJBCGHI4uT3mQrVmu/SCuBj
	nVBSBEFweYl46Fh7XObx/ML2fxrQ=
X-Google-Smtp-Source: AGHT+IGuSBVmqV085jDqvQUAf8i68IEUnyytNHkfFRI9GOcvPBBTnyjUT2ikFR7lzMrLMmFDGN42uoRKPnDAghMRcG0=
X-Received: by 2002:adf:c849:0:b0:341:b997:7a4b with SMTP id
 e9-20020adfc849000000b00341b9977a4bmr3452539wrh.34.1711332354202; Sun, 24 Mar
 2024 19:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321180501.734779-1-andrii@kernel.org> <CAADnVQJqnLnv4AUvCaefP13CDcJOXM=kJpSOv33t-u-OTzb0UQ@mail.gmail.com>
 <CAEf4BzYFc1b-OAXWf4WN_vM2evZgsW7reJqo8iwKP80EXBJMKw@mail.gmail.com>
In-Reply-To: <CAEf4BzYFc1b-OAXWf4WN_vM2evZgsW7reJqo8iwKP80EXBJMKw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 24 Mar 2024 19:05:42 -0700
Message-ID: <CAADnVQ+zT8C=rHtTbbsdoPVw-n7PPufPp0CC+jt2PUn9bB5gxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Inline two LBR-related helpers
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 9:45=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Mar 21, 2024 at 4:46=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Mar 21, 2024 at 11:05=E2=80=AFAM Andrii Nakryiko <andrii@kernel=
.org> wrote:
> > >
> > >
> > > There are still ways to reduce number of "wasted" records further, th=
is is
> > > a problem that requires many small and rather independent steps.
> >
> > I feel this is a wrong path to follow.
> > I think it would be better to introduce a flag for kprobe/fentry
> > to do perf_snapshot_branch_stack() as early as possible
> > and then bpf prog can copy these 16 or 32 8-byte entries at
> > its leasure.
>
> This is basically how Song started when he was adding this feature a
> few years ago. And I feel like we discussed this and decided that it
> would be cleaner to let the BPF program decide when (and whether) to
> get LBR, based on conditions. It still feels like a right tradeoff.

Right we discussed it back then and at that time it was about
collecting stacks.
What's different now is you want to collect all types of branches
in retrnoop including plain 'jmp pc+10' and conditional jmps.
This is not something that C code can control.
always_inline in C and inline by the verifier reduce call frames,
but they may have both positive and negative effect when
all branches are collected.
Hence __always_inline in kprobe_multi_link_prog_run()
is a leap of faith with assumptions that compiler won't
add jmps before calling into prog,
but lots of different compiler flags add instrumentation:
kasan, stack protector, security mitigation that count call depth, etc.


> Granted, for PERF_SAMPLE_BRANCH_ANY you gotta take it immediately (and
> that's what retsnoop does), but for PERF_SAMPLE_BRANCH_ANY_RETURN this
> doesn't have to happen so fast. BPF program can evaluate some
> conditions and grab LBR optionally, saving the overhead.
>
> With prog flag saying "kernel should capture LBR ASAP", we:

I was suggesting to use per attachment flag.
And kprobe is a lost cause.
I would do it for fentry only where
we can generate 'save LBR' call first thing in the bpf trampoline.

>   a) lose this flexibility to decide whether and when to grab LBR;
>   b) pay overhead regardless if LBR is ever actually used for any
> given prog invocation;

when retsnoop attaches a prog the prog gotta call that 'save LBR'
as soon as possible without any branches.
So per-attach flag is not really a downside.

>   c) have to dedicate a pretty large (32 * 24 =3D 768 bytes) per-CPU
> buffers for something that is pretty niche (though hugely valuable
> when needed, of course);

I wouldn't worry about such a tiny buffer.

>   d) each program type that supports bpf_get_branch_snapshot() helper
> needs to implement this logic in their corresponding
> `bpf_prog_run_xxx()` running helpers, which is more than a few places.

I think new kfunc that copies from the buffer will do.
Nothing needs to change.
Maybe bpf_get_branch_snapshot() can be made smart too,
but that is optional.

> Now, let's see how much we can also realistically save with this approach=
.
>
> For fentry, we do save a few (2) entries, indeed. With changes in this
> patch we are at:
>
>   [#07] __sys_bpf+0xdfc                          ->  __x64_sys_bpf+0x18
>   [#06] __x64_sys_bpf+0x1a                       ->
> bpf_trampoline_6442508829+0x7f
>   [#05] bpf_trampoline_6442508829+0x9c           ->  __bpf_prog_enter_rec=
ur+0x0
>   [#04] __bpf_prog_enter_recur+0x9               ->  migrate_disable+0x0
>   [#03] migrate_disable+0x37                     ->  __bpf_prog_enter_rec=
ur+0xe
>   [#02] __bpf_prog_enter_recur+0x43              ->
> bpf_trampoline_6442508829+0xa1
>   [#01] bpf_trampoline_6442508829+0xad           ->
> bpf_prog_dc54a596b39d4177_fexit1+0x0
>   [#00] bpf_prog_dc54a596b39d4177_fexit1+0x101   ->
> intel_pmu_snapshot_branch_stack+0x0
>
> With flag and kernel support, we'll be at something like
>
>   [#07] __sys_bpf+0xdfc                          ->  __x64_sys_bpf+0x18
>   [#06] __x64_sys_bpf+0x1a                       ->
> bpf_trampoline_6442508829+0x7f
>   [#05] bpf_trampoline_6442508829+0x9c           ->  __bpf_prog_enter_rec=
ur+0x0
>   [#04] __bpf_prog_enter_recur+0x9               ->  migrate_disable+0x0
>   [#03] migrate_disable+0x37                     ->  __bpf_prog_enter_rec=
ur+0xe
>   [#02] __bpf_prog_enter_recur+0x43              ->
> intel_pmu_snapshot_branch_stack+0x0

with flag migrate_disable and prog_enter* will be gone.
It will be only bpf_trampoline_ and intel_pmu_snapshot_branch_stack.
If we try hard we can inline
wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, 0);
Then it will be bpf_trampoline_ only and
that's as minimal as it can get. One entry.
Hacking all over the kernel with inline won't get anywhere close.

> For PERF_SAMPLE_BRANCH_ANY_RETURN return mode there will be no savings
> at all. Is it really worth it?

any_return is ok today.
Especially with fentry.

> While inlining bpf_get_branch_snapshot() does benefit only LBR use
> case, it's a rather typical BPF helper inlining procedure we do for a
> lot of helpers, so it's not exactly a hack or anything, just an
> optimization.

Inlining bpf_get_branch_snapshot() may be ok,
but the way you're doing is not a clear win.
Replacing size / 24 (that compiler optimize into mul)
with actual divide and adding extra mul will be slower.
div+mul vs mul is quite a difference.
How noticable is that is questionable,
but from inlining perspective it doesn't feel right to do
"inline to avoid extra frame" instead of
"inline to improve performance".

> But inlining bpf_get_smp_processor_id() goes way beyond LBR, it's a
> pretty frequently used helper used to implement various
> BPF-program-specific per-CPU usages (recursion protection, temporary
> storage, or just plain replacing BPF_MAP_TYPE_ARRAY_PERCPU with global
> variables, which is already a bit faster approach, and now will be
> even faster). And the implementation is well-contained.

Agree that inlining bpf_get_smp_processor_id() is a good thing,
but please do it cleanly so that per-cpu accessors can be
reused in other places.
I'll reply with details in the other thread.
