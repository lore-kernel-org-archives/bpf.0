Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34191DA26
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528495; cv=none; b=UN4ZbUOuKMFYSX5GPSlf0mBxivBfGkfjfXIm+gJwEG4A1voTLr1l104danDhKc7aDtDm7hrbNPzvHZzpg/d74b/SIcJM0eNrjkv5d6wnT08sweSiG4vzKDfY7TwBkAvfDXVskeDiAsppXOqCPI/or2cakgZ+iITsvDUdQaReT8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528495; c=relaxed/simple;
	bh=/iFxuR1z1jQCK80qO6DseXU80TY3ybn9nPa4y/2ovnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7ZVOBMpGXq2VFk0KUXR1Ik8ZaUqiNaP9pewRjidUFl9N+JNqq+Ajo9WBe5WLMijI/p0+EOGzbU7J9YLnXMJjo/txVa00yZx+l152CRmNSD1zoQvw4XAnT4483BwSwKVkvvAEFu2hqS1YxE+8XT6zAhavTKL7GtOrqxtrWo7Kb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfR1mBJe; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfR1mBJe"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-413fffcc472so8925745e9.3
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710528490; x=1711133290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGJYTfSsV4AQHA0rCwPtgtLS8zACJ4kHUNixKcypKrc=;
        b=JfR1mBJeM5AjqWXdsL7DeR1lyPFbDH2o6jJ80dQ+pqLDH6XG0TgqTbH1ShmFrH+wqj
         1lr2wsB+vGZMT9yBHBGqK8JJIa2JtMgJSCz5BtmBdYwXzCsNPjXvQIuLrde3YoXlNPFM
         XSpOOl2q1Dq/6ZaSn789WD30Oe2FgKfNQaBl03WzdHZvRJsH2GGDA3Qbsezek0KPdUvY
         aH4qHf2G0ZPe+8cioJyf0uANfQvR7pksof/XvhPyz2N+6T8CcWNS5UvGPCBoJRDP7O/v
         rem9gjLNuDV2pCfUI3bVYB+QMAiB951ZaBsGrzAsBPWPKFN+Y3bV6/UHkQCEMpsLIrr5
         pbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710528490; x=1711133290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGJYTfSsV4AQHA0rCwPtgtLS8zACJ4kHUNixKcypKrc=;
        b=SSNbTbFPGNXvWQUA7MRGeQVjOusz3lqeark3eDzcxz8xDglQw0xzWm6AlPm5H3b/WN
         xeZz/AwndXUr/Vl1+69g7Gid3KIDE5SFDR5+AUrrfva2TW6+mI1HtUgDGQzKDWQF4+cx
         KHTiCNRPXKpT+2asl9xUUEGDdzxiLc24xn03WfJu/qNx+xbY5n8EB3I5ajkfBVcDjSPv
         5ztLNYaGOYeFPzI4SiSwnILcEbRcYVZ/8A3kb6Sse9adzAse+3QaRzXBIfcLI6HKQDFV
         w/FoJB04FGnJIHVeXKCsQG8GS3w8/m4mqJi5TeaRKjo06/boppF5eo99D+0/N+Wgb5b3
         xQXA==
X-Forwarded-Encrypted: i=1; AJvYcCXD0VTprA8I8UJwbWMkVUN6WT7jcgfkClUjOIUIB+nvLzGsbzQxHc9UMzEauEoOzE8DOVAIZ6FxOko+ydmqDlrdhQFm
X-Gm-Message-State: AOJu0Yzb+bNEwaEV0hpwGXYsH7vPIz7x0/8tFTjds02ZW6g5TU9ec2Db
	+0njV7p5Yu7HHlzekWU1CIhLkL1viExHYDYeBl6u8b51SDGiq7fsBqW3tZdD3rdprPXS/y+Wiaa
	3ca+SfClTT14ag/2JtMLCNtQB43ozb1Peags=
X-Google-Smtp-Source: AGHT+IE7T8JdIqlzyCzhj76+gPCJbwuBNxS4tW1RZfybhfgAWzCnzVHOyOwAEu17Y6ocRPx0FzjSqcbIHkKQi5jgLWY=
X-Received: by 2002:a05:600c:548d:b0:413:ea5c:1b08 with SMTP id
 iv13-20020a05600c548d00b00413ea5c1b08mr2946234wmb.40.1710528490053; Fri, 15
 Mar 2024 11:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315051813.1320559-1-andrii@kernel.org> <20240315051813.1320559-2-andrii@kernel.org>
 <CAADnVQLFCVCdb4Uu+6QJMDybUc5RqLCF-5yS2eQVoQ==qq3vvQ@mail.gmail.com>
 <CAEf4BzYuMJVoEhK=wHhzDN2193ZvTupG6i+Ya6YjZNWohdADxQ@mail.gmail.com> <CAEf4BzY433C4NJog_mQLQC0oK_7k5zs2xSgxx9qQ7f+QsST5cA@mail.gmail.com>
In-Reply-To: <CAEf4BzY433C4NJog_mQLQC0oK_7k5zs2xSgxx9qQ7f+QsST5cA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 Mar 2024 11:47:58 -0700
Message-ID: <CAADnVQKYDLEkcfWCfs6xzBc_gfn-dSX39WynoKV629Q-Kw1aQA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: add fast mostly in-kernel
 BPF triggering benchmarks
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 9:59=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Mar 15, 2024 at 9:31=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Mar 15, 2024 at 9:03=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Mar 14, 2024 at 10:18=E2=80=AFPM Andrii Nakryiko <andrii@kern=
el.org> wrote:
> > > >
> > > > Existing kprobe/fentry triggering benchmarks have 1-to-1 mapping be=
tween
> > > > one syscall execution and BPF program run. While we use a fast
> > > > get_pgid() syscall, syscall overhead can still be non-trivial.
> > > >
> > > > This patch adds kprobe/fentry set of benchmarks significantly amort=
izing
> > > > the cost of syscall vs actual BPF triggering overhead. We do this b=
y
> > > > employing BPF_PROG_TEST_RUN command to trigger "driver" raw_tp prog=
ram
> > > > which does a tight parameterized loop calling cheap BPF helper
> > > > (bpf_get_smp_processor_id()), to which kprobe/fentry programs are
> > > > attached for benchmarking.
> > > >
> > > > This way 1 bpf() syscall causes N executions of BPF program being
> > > > benchmarked. N defaults to 100, but can be adjusted with
> > > > --trig-batch-iters CLI argument.
> > > >
> > > > Results speak for themselves:
> > > >
> > > > $ ./run_bench_trigger.sh
> > > > uprobe-base         :  138.054 =C2=B1 0.556M/s
> > > > base                :   16.650 =C2=B1 0.123M/s
> > >
> > > What's going on here? Why two bases are so different?
> > > I thought the "base" is what all other benchmarks
> > > should be compared against.
> > > The "base" is the theoretical maximum for all benchs.
> > > Or uprobe* benches should be compared with uprobe-base
> > > while all other benchs compared with 'base' ?
> > > Probably not anymore due to this new approach.
> > > The 'base' is kinda lost its value then.
> >
> > naming is hard. base is doing syscall(get_pgid) in a tight loop. It's
> > base compared to previous trigger benchmarks where we used syscall to
> > trigger kprobe/fentry programs. uprobe-base is just a user-space loop
> > that does atomic_inc() in a tight loop. So uprobe-base is basically
> > the measure of how fast CPU is, but it's unrealistic to expect either
> > fentry/kprobe to get close, and especially it's unrealistic to expect
> > uprobes to get close to it.
> >
> > Naming suggestions are welcome, though.
> >
> > I'm not sure what the "base" should be for xxx-fast benchmarks? Doing
> > a counter loop in driver BPF program, perhaps? Would you like me to
> > add base-fast benchmark doing just that?
> >
>
> How about this.
>
> base -> base-syscall (i.e., "syscall-calling baseline")
> uprobe-base -> base-user-loop (i.e., "user space-only baseline")
> and then for "fast" baseline we add "base-kernel-loop" for
> "kernel-side looping baseline"

I think "base" part in both doesn't fit.
Maybe
base -> syscall_loop
uprobe-base - user_space_loop

since the first is only doing syscall in a loop
and the 2nd doesn't even go to the kernel.

>
> Or we can use some naming based on "counting": base-syscall-count,
> base-user-count, base-kernel-count?

Instead of fenty-fast -> fentry-batch
sounds more accurate.

But in general it doesn't feel right to keep the existing
benchs, since we've discovered that syscall overhead
affects the measurement so much.
I think we should bite the bullet and use bpf_testmod in bench tool.
Then we can add a tracepoint there and call it in proper kernel loop,
then add fmodret-able empty function and call it in another loop.

Then bench tool can trigger them via bpf->kfunc->that_looping_helper
and capture as accurate as possibly overhead of
tp, raw_tp, kprobe, fentry, fmodret.
And all of them will be comparable to each other.
Right now fmodret vs fentry are comparable, but both have
syscall time addon which makes the comparison questionable.
Especially consider the kernels with mitigations.
Overhead of syscall is even higher and the delta is smaller,
to the point that fentry vs fexit might measure equal.
A benchmarking tool should be a gold standard and accurate tool
for performance measurement.

The trick:
+       for (i =3D 0; i < batch_iters; i++)
+               (void)bpf_get_smp_processor_id(); /* attach here to benchma=
rk */

is neat, but since it works for fentry/kprobe only
we need testmod to generalize it for fmodret and tracepoints.
