Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE4B28F1
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710520298; cv=none; b=iCCcRQ4oHOjjPvIDu4tqHJuo8UGrGpIQL+Jocl0vJEZyTzo7Fkc7fNdLM6DSBLInBRp6BNCySxVYIwUVNqbo6NtxEH5xCXOXK4PYC7TiOhCqmuCLt4R7grTTw35ibxtExPmrq8d7ZSCOhc4mK4rHvY4a31c2sC7tFx1fEv/i420=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710520298; c=relaxed/simple;
	bh=f8FB23SdJpoVg+IOqbIwsSdaRHo86KC7ydsQhUlC2Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Va5hvi4lJOcm0dPvR6eCJdAxbn/Y4bX0tsLgJ3+XeQQPUS+Ux2hcaAG7IPcBcqzfx5adZnB2dpZvScyVgkmI1fcJvjpyqnfz6qhjWm8O4USl3jji3I4Rj5T0ucqc3U6SVzcxWUtQN2AV66OG0NYrX7pGk+bb03KrmCxYnLoy/EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBmaKs8X; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBmaKs8X"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6b3dc3564so2108440b3a.2
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710520296; x=1711125096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6//baylfDmx6HuBtFjDiC8hoWG3ghl44iKczNM+77k=;
        b=FBmaKs8XSZirasQsQCdSpjYI6pG9zLjnjmiT/llIUJN4M/9FiMNULU+zj7TAB5gSbg
         I2gHQ6et1jMNp/zqmGimf52v0gXaMCVlHzyXBARplBeTbFiE1FedkxU+b16KgGUmiMtO
         ogjRFpVTfhNWLln0ma1Ew7SF4/eCU4WtSBNLPsbhNxGJJ7C1/gUlCjzx5+erMVb3b8Sz
         BgifnXowQixDXfraCDDjWqWKf0KzBGxkeE1AIZOqyXe8P39L0ETCrpAUv11xBVmv6R7X
         SzU7P3g+u9KW5U0j82XOmkQ3chDEDJ3uWdhceskFFICsSuQ9sfcTlxGY6r912gTtNB28
         t0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710520296; x=1711125096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6//baylfDmx6HuBtFjDiC8hoWG3ghl44iKczNM+77k=;
        b=f1tiMuUiIhWr4Psbjr6GR+SUyGS3f9mJdKugzunOTh0tC9BO4sVsPf0HtPzctdwB/s
         rk0tUGXLW31cXkscXiAZZgCbMmxYlDLvvaVUlolIl6DRVftt+LMmXUsWSYCFw8EZOLU9
         UkuTTws68DP0+yqapsC77CYj8tWja4jiDFMhsdNRpWiafzpZaC+L8sK1df596mPq/1AX
         mW2a3pGnl5tm5NbbusPd6dw/jpTpk+XaLdQf64dlMl8tauZNPk/iex9Zpx2JrA8ymVwK
         LFmYIYMk8jCiJCXda9SBXyIcLZy7uemdht5Mu9EcPS0XYSERZKaUvuj2eGIlMpIHjSuJ
         w6TQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8bVKgOCF4LxoSpJOAyDXcJYzigUYMMMSLeqdViD8tYxDyDFgXA5aiScMWwtzgdbDz9m94vp+ZW6L6oMYFJWf9u9pe
X-Gm-Message-State: AOJu0YwhE21jVmzAOqt+HzqT76qa6Zc5sOGZjSteUyJCA8FUVcwKk1L9
	r35Tv9NOglXuRH00diy/zvMn9WyPVhqskM0Arr2ScdRsJWo9QaA5/hPI1w7ZcF3mef8fnJiqysT
	rBLgsbFzE+u3ZaSn2iOhlMvb3t/8=
X-Google-Smtp-Source: AGHT+IHoMRdrYvUZ3Zg3D5FG3qKx0P6hQ5VJKMpg3wZ4syFsu21gi6PvrW3265IFhOWTdo+NQ203CAVHQ3oRn/rhTyk=
X-Received: by 2002:a05:6a21:6d90:b0:1a1:667c:eeca with SMTP id
 wl16-20020a056a216d9000b001a1667ceecamr6469729pzb.3.1710520295813; Fri, 15
 Mar 2024 09:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315051813.1320559-1-andrii@kernel.org> <20240315051813.1320559-2-andrii@kernel.org>
 <CAADnVQLFCVCdb4Uu+6QJMDybUc5RqLCF-5yS2eQVoQ==qq3vvQ@mail.gmail.com>
In-Reply-To: <CAADnVQLFCVCdb4Uu+6QJMDybUc5RqLCF-5yS2eQVoQ==qq3vvQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Mar 2024 09:31:24 -0700
Message-ID: <CAEf4BzYuMJVoEhK=wHhzDN2193ZvTupG6i+Ya6YjZNWohdADxQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: add fast mostly in-kernel
 BPF triggering benchmarks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 9:03=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 14, 2024 at 10:18=E2=80=AFPM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >
> > Existing kprobe/fentry triggering benchmarks have 1-to-1 mapping betwee=
n
> > one syscall execution and BPF program run. While we use a fast
> > get_pgid() syscall, syscall overhead can still be non-trivial.
> >
> > This patch adds kprobe/fentry set of benchmarks significantly amortizin=
g
> > the cost of syscall vs actual BPF triggering overhead. We do this by
> > employing BPF_PROG_TEST_RUN command to trigger "driver" raw_tp program
> > which does a tight parameterized loop calling cheap BPF helper
> > (bpf_get_smp_processor_id()), to which kprobe/fentry programs are
> > attached for benchmarking.
> >
> > This way 1 bpf() syscall causes N executions of BPF program being
> > benchmarked. N defaults to 100, but can be adjusted with
> > --trig-batch-iters CLI argument.
> >
> > Results speak for themselves:
> >
> > $ ./run_bench_trigger.sh
> > uprobe-base         :  138.054 =C2=B1 0.556M/s
> > base                :   16.650 =C2=B1 0.123M/s
>
> What's going on here? Why two bases are so different?
> I thought the "base" is what all other benchmarks
> should be compared against.
> The "base" is the theoretical maximum for all benchs.
> Or uprobe* benches should be compared with uprobe-base
> while all other benchs compared with 'base' ?
> Probably not anymore due to this new approach.
> The 'base' is kinda lost its value then.

naming is hard. base is doing syscall(get_pgid) in a tight loop. It's
base compared to previous trigger benchmarks where we used syscall to
trigger kprobe/fentry programs. uprobe-base is just a user-space loop
that does atomic_inc() in a tight loop. So uprobe-base is basically
the measure of how fast CPU is, but it's unrealistic to expect either
fentry/kprobe to get close, and especially it's unrealistic to expect
uprobes to get close to it.

Naming suggestions are welcome, though.

I'm not sure what the "base" should be for xxx-fast benchmarks? Doing
a counter loop in driver BPF program, perhaps? Would you like me to
add base-fast benchmark doing just that?


>
> > tp                  :   11.068 =C2=B1 0.100M/s
> > rawtp               :   14.087 =C2=B1 0.511M/s
> > kprobe              :    9.641 =C2=B1 0.027M/s
> > kprobe-multi        :   10.263 =C2=B1 0.061M/s
> > kretprobe           :    5.475 =C2=B1 0.028M/s
> > kretprobe-multi     :    5.703 =C2=B1 0.036M/s
> > fentry              :   14.544 =C2=B1 0.112M/s
> > fexit               :   10.637 =C2=B1 0.073M/s
> > fmodret             :   11.357 =C2=B1 0.061M/s
> > kprobe-fast         :   14.286 =C2=B1 0.377M/s
> > kprobe-multi-fast   :   14.999 =C2=B1 0.204M/s
> > kretprobe-fast      :    7.646 =C2=B1 0.084M/s
> > kretprobe-multi-fast:    4.354 =C2=B1 0.066M/s
> > fentry-fast         :   31.475 =C2=B1 0.254M/s
> > fexit-fast          :   17.379 =C2=B1 0.195M/s
>
> I think the "-fast" suffix doesn't really fit here.
> It's a different way to benchmark fexit vs kprobe overhead.
>
> I think the old approach should be replaced with the new one.
> There is no value in keeping the old stuff around when
> now it's clear that it's measuring much more than it should.

I'd say we should keep them. Note that fmod_ret, tp, and raw_tp can't
be benchmarked the same way. So we don't have -fast variants for them.
If we get rid of pre-existing fentry/kprobe benchmarks, we won't be
able to compare raw_tp/fmod_ret/fexit.s to them.

And to be clear, in practice I'm not comparing xxx-fast with xxx at
all. I just put all the numbers in this patch summary to show that we
indeed have a significant performance lost on syscall.

In practice when comparing kprobe vs fentry, it should be kprobe-fast
vs fentry-fast.

>
> > One huge and not yet explained deviation is a slowdown of
> > kretprobe-multi, we should look into that separately.
> >
> > kretprobe           :    5.475 =C2=B1 0.028M/s
> > kretprobe-multi     :    5.703 =C2=B1 0.036M/s
> > kretprobe-fast      :    7.646 =C2=B1 0.084M/s
> > kretprobe-multi-fast:    4.354 =C2=B1 0.066M/s
>
> That is weird indeed. Since it's a single cpu run
> it cannot be due to contention.
> My gut feel is that something odd is here:
> #ifdef CONFIG_X86_KERNEL_IBT
> static unsigned long get_entry_ip(unsigned long fentry_ip)
>
> Did you have it in your config?

No, this was without IBT. I do have an upcoming small patch to
eliminate unnecessary copy_kernel_nofault() in IBT path, but I don't
think this is it. It should be pretty clear with profiling where we
are losing CPU, I just didn't have time/desire to look into it, as I
have tons of small things being worked on in parallel and didn't want
to add another one.

>
> > +SEC("raw_tp")
> > +int trigger_driver(void *ctx)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < batch_iters; i++)
> > +               (void)bpf_get_smp_processor_id(); /* attach here to ben=
chmark */
>
> bpf_get_numa_node_id() is probably even faster and
> not subject to DEBUG configs.

Sure, I can switch to that, np.
