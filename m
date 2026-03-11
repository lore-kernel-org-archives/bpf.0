Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359213C5DD8
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220011; cv=pass; b=FqFWzDv1BD54J2TQcUXRQhDgEkhv5JzLnWDDIkoS80RmRkUzKuaiUZFfzq6+soIj+OmvhF5lQLeq0xX1uVoNmrToaefuOlwqhO9wjX14i+OxLSC7vgTmC1Wo8AmbJfdyEK7qnndvYvb5Tr0c6khFadb3C5DWMmeEgKgvBDyraAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220011; c=relaxed/simple;
	bh=g/ROASbeaF/IjWI2I8zqA9k4mfccxN4DNjH2eSqizNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EslcLtdyZz+YADviO3u7dtotkWpW2jPaQCrEKT778/Y58tKrH16vux/GstuZEwLjd4H389yELiGJqHCfcD9wifDbyWHvXnNp0wbn4Zb4p1pZV8MkMHwfwGfyZSiAkgD0HH79KgYuwBtcBVFRwGnciURYLK2M/Mv0kaZM5QhFNBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R179TJlQ; arc=pass smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R179TJlQ"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso37376005e9.3
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 02:06:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773220003; cv=none;
        d=google.com; s=arc-20240605;
        b=UGfrFxsiFBGKeP8tPckGnBnvd5MXIDphpl2X5qtiCvYTz6RHFpVb3fqAGlsfarkwAv
         zd40u9V629fKoEqmrMoJ3dhmMnmkptvCfnNSrV561+LDY8t+g4S5SBDFZQW6AQlIw/gF
         gggxOu0pie9ttfua67srJG4guVdWjDK1I7/qLYbI/ngAKOpJCn9Azxz3CK7PSexhPBjy
         PSWNenL2OmFF8ufk5d0dVGzk44Fy0Yx27zgsQoeWz6LfNWEql3NCn+6eU/vjwh+wiiPX
         x18dKYmrM4FZwTdiv6J0EHkOM4TbUj0swEL/EJnIl3881lP6kFzMwwqBhoCT+EqMDtJx
         Da2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N1EaLBSYYrgNyCVq+XkPC1rTN11UT3UwwE/Ba6Rikgk=;
        fh=+sMOFs5fR0Y9hF+4evNcyj3VPZE5BCZYRt3GxWLGuPI=;
        b=cu/kCIppUTYQfKe4GgIhTT2RIOLnh1X0YFGSQ6h1dmv1RzbszdRztvMTddySktA3Hm
         lT+6Rf3m9ojHzucPFt0xDlQ0Q1kqR+gWwLqCjcjlGPCE+oKLRzqt8idySmMszJuVFKK9
         gtwv16a8MySYv9ydGOv62Y+5r4mjXcbVAkO6G6rlznENqXRRfv4YE3yWC5cYAnc1qgGc
         J4gwl4iYU4QYsfyUe+su9me/O1kzxDsgc42rGH+yovhJCCrKkRGGjQjlBZqsIEOdswXN
         a+2fnlhXWvAtcUZOaWPyNvo5O66iMVyt8gchAaHl6S5nlm/9Nz6l180AT/qKTW2ZEovN
         B+AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773220003; x=1773824803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1EaLBSYYrgNyCVq+XkPC1rTN11UT3UwwE/Ba6Rikgk=;
        b=R179TJlQj+90ACKC8VEMuXbcKKJbuPlSv/j/HMnCxb9AHx7p8f8Njb9H0DxzgDVVeP
         2dKThypdzDjHOKFoBFdUw1fmGI0G+oKNWfAFlXzWMbcwLqLexFVIjJvMCoALxylRDjaV
         1d320ymnvbiIJH1O4fNHolBnlGW8l+Qs+T5B82h0SKLuUC4fTzy9R82B8IrjxV2awYnf
         kTzDJFDCeBPPtsalDokwYhhg0xNHNj3sCZZJIlPHiH0sCOb35jv5Lc9KM9KWB27sNDt1
         vNQif9LFXbJfSUR1Epmm5KHlh2SW34WDpQm0P/6ZARih0Hx45KWAu8diKRMArYIB/PPn
         8u0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773220003; x=1773824803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N1EaLBSYYrgNyCVq+XkPC1rTN11UT3UwwE/Ba6Rikgk=;
        b=Qj4eJBsh2cmLoJMB03XoXEDLteDo+SGdp4RV8SGP16XhRjQknbOgi4Go04BSC/AVXB
         jg8CQU81oQiQ7M1e5taMAkRTb8Jxjo49bawzrMad7y1ZkvWMf5Ee45+BlrarEvtj21eD
         sDBr6k7C6NkO5wRzMqX17IykTPiU0yn8SNMBuXytHs9ZwD1P9L21JSH62MODHZsbLvxJ
         Ny7c94JcgCLTph2PKj0X3wfweeu/e3JaCXT848HGH1lt7JoxIc2I+Z88VFrA+aSBKX/8
         FsqqFWBW6b2Xyw2BD7fwRguykcFn2lY2Z9STSazuFl2nIq00rq+XRy7g82CYAhm3DxiP
         7xAA==
X-Forwarded-Encrypted: i=1; AJvYcCWT/MBNpsXOVG2XshsjMwJIvCMlgQrPhqiqnVVBoRfCnWS1Fbeyt2nG7apx77TB5vI9ReM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmNMdEKOhhm7S0YtWCXtpgevcixlIsTMUeBBLLDKIXgiJGvkTE
	u3/OFRZlmGBr/zb7sqt//YhYyKT0SUw4X2ByvPim6IbT6lFeH1bqybLeRED/sAsxAq9nUv5G8Dy
	RTAfLKV+MYRNSoeMSwQOjHNNUFzOajJY=
X-Gm-Gg: ATEYQzyDlVUqF2Hxiv3pApLdirh6YmftGPRHF/4osZnb1HpA4vLt+szKzEWqAhzIVt+
	PB0y7YTzl7JOL9iIig6PK1T285JXn9UcruSWLFgizTpD52IQSXMa2ZGyizZT07VSJCFgF5BW6OD
	KNOy167BxxdC8fXlz3oKk8Ry9L2M48ERAtbpCxJLASQ6iUnyMGd9yKfYKpxQSScT1mVh/RSO0HA
	QibZsQtPAY2lAQJX7sYQgkXJ9q30Dl+F5Antl3v+kaMDsBWY7O/F0ijmqhDbFw0/FrZOQfcvS1l
	AXUDXVMh6hDFzHAZl8FK5XfW1Z5MU/ZVbmhjQuqOzaAqDSyhssH1GU0a7AEv
X-Received: by 2002:a05:600c:8b0a:b0:485:3ae8:2236 with SMTP id
 5b1f17b1804b1-4854b123cd6mr28330295e9.32.1773220003052; Wed, 11 Mar 2026
 02:06:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225210820.177674-1-wusamuel@google.com> <CAG2Kctp1q1QtB1-JT2cgBsYu-WceV1YdSM1sSwNm8pyGtZQ6TA@mail.gmail.com>
 <CAP01T776Ni9R6CT_phx5wNDUoN13Tztz3DD5ZgKWedNLx7Nb0g@mail.gmail.com>
 <CAP01T77EZDLhjwtZBSt+DXLG-ftHfows-p_6FgXZQDQGowcDtw@mail.gmail.com> <CAG2KctrkGjk3SMQ=8-rrYnKCTUseSmBV+kg+=OyT9M2mBT1bwg@mail.gmail.com>
In-Reply-To: <CAG2KctrkGjk3SMQ=8-rrYnKCTUseSmBV+kg+=OyT9M2mBT1bwg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 11 Mar 2026 10:06:06 +0100
X-Gm-Features: AaiRm52PHPIATVHLejy9VoMDSkcJIo-xhDv2D3PD2a7QMCb-5IDtVAgsuRLOLOM
Message-ID: <CAP01T77YFR9227YpTZin-i7w-hNLWMM9ANuzmiAzLwzPGJ=gEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 0/2] Add wakeup_source iterators
To: Samuel Wu <wusamuel@google.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Mar 2026 at 01:23, Samuel Wu <wusamuel@google.com> wrote:
>
> On Sat, Mar 7, 2026 at 12:17=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Sat, 7 Mar 2026 at 00:28, Kumar Kartikeya Dwivedi <memxor@gmail.com>=
 wrote:
>
> [...]
>
> > > I think it's still unclear why this cannot be achieved by exploring
> > > what Andrii proposed initially in [0], i.e. by using existing
> > > primitives and adding extra kfuncs where necessary to solve
> > > bottlenecks, and I didn't see any indication where it was explored
> > > sufficiently.
> > >
> This is my bad, I misinterpreted/misunderstood Andrii's original
> proposal to apply only to open-coded BPF iterators, hence the follow
> up patches with them removed. However, I don't disagree this can be
> achieved via open-coding. Both proposals are viable to traverse wakeup
> sources via BPF, however I see two distinct advantages of the BPF
> iterator:
>
> 1. Iterators provide a stable kernel interface that decouples the BPF
> code from the kernel's internal data structures and refactors

I think this is my concern; committing to a stable interface that
we'll have to maintain forever.
It's a narrow use case that can be better served by dedicated kfuncs
and rolling your own solution.
There will be no end to the number of iterators if we keep making one
for every linked list in the kernel.

It would be different if the synchronization scheme for the
wakeup_sources list was really complicated and hard to express inline
in the verifier, but that is not the case.

> 2. If wakeup sources are accessible via BPF, the next step should be
> to deprecate the existing interfaces for wakeup sources, such as the
> sysfs and debugfs stats. In that case, a text-based BPF iterator
> output will provide less friction during the transition.
>

I would agree if this was a one-to-one conversion, where you just
replace the directory for look up.
But you'll be reading from one file vs several, so it's already a
non-trivial change in the consumer.
At that point, the conversion burden doesn't have the same weight in
deciding whether to stick with textual representation.

> > > I think all we need is the wakeup source read_lock()/unlock() APIs as
> > > KF_ACQUIRE/KF_RELEASE kfuncs. Just need to ensure we pair each lock
> > > with unlock by passing the index, which can be an opaque value
> > > returned from the kfunc (e.g. dummy empty struct pointer encoding the
> > > index). Then you can use bpf_for() to open-code the list iteration.
> >
> > I had a longer discussion with Paul on this. When having multiple open
> > SRCU sections, mixing nested calls doesn't flatten the protection
> > scopes and leads to all kinds of issues, an example of which is in
> > [0]. That said, in this case, the verifier isn't tracking what the
> > underlying SRCU section protects or isn't even aware of it, all it
> > needs to ensure is that section is closed eventually, out-of-order
> > unlocks are ok, it would just exist to allow looking at the list in a
> > stable fashion using safe bpf_core_cast() accesses.
> >
> > So, I just wanted to clarify why I think this should be perfectly ok.
> >
> >   [0]: https://www.kernel.org/pub/linux/kernel/people/paulmck/Answers/R=
CU/SRCUhoha.html
> >
> > (if you are like me, please follow the link at the bottom of [0]
> > before feeling good about understanding the example).
>
> Appreciate the thoughtful feedback from you and Paul. The example was
> nuanced but well-explained by the post, however, a key difference I
> see is that the BPF iterator solution creates continuous locking
> segments during traversal, as opposed to hand-over-hand locking in the
> example provided. I could be missing something fundamental here- do
> you mind elaborating?

It was just an illustration to identify what guarantees the verifier
would need to enforce.
The most we need to do is just ensure SRCU indices are passed back
during unlock, in whatever order.
Critical section will be using bpf_core_cast() anyway to do safe
walking of the list.
With the KF_ACQUIRE/KF_RELEASE kfuncs you will still have a continuous
locking segment.
Just enclose your list walking loop between lock() and unlock().

>
> >
> > > The iterator would become unnecessary, and everything can be done fro=
m
> > > a syscall program's BPF_PROG_RUN invocation. I didn't
> > > check how we can get the pointer to the wakeup_sources LIST_HEAD, but
> > > you could try several options (__ksym,
> > > bpf_kallsyms_lookup_name+bpf_core_cast and then walk it, or return
> > > pointer from a new kfunc and walk it using bpf_for()+bpf_core_cast())=
.
> > >
>
> Getting the static variable is key to the open-coded approach, but a
> clean way forward isn't obvious to me. Passing around raw addresses
> seems brittle and can raise security concerns. The wrapper kfunc to

I don't understand the security concern. All of this happens inside
the BPF program.
If you're writing these addresses to user space and leaking them, it's your=
 bug.
You can do that with iterators too. You have all the raw addresses
available to you.

> get the static address might be the best option, but it feels like it
> violates the power subsystem's encapsulation. The iterator approach
> abstracts all of this cleanly.
>
> > > Also, how much speed up does this really provide? It is hard to
> > > understand the motivation from the current cover letter. Is the
> > > bottleneck due to opening multiple files in sysfs? You will still hav=
e
> > > to read text and parse text from the iterator's output in your curren=
t
> > > solution. Wouldn't it be faster if you just used a syscall program,
> > > and used binary output (using a ring buffer) to stream data to user
> > > space?
>
> With the BPF iterator approach on a Pixel 6 in a quiescent state, I'm
> seeing a 10x speedup when traversing wakeup sources; the speedup would
> likely be even greater on a loaded system.
>

I'm sure you can replicate it with the approach described above.
It might even be faster than parsing text from the file.

> As alluded to earlier, the next step is to remove the
> /sys/class/wakeup node and debugfs nodes. My apologies for not
> explicitly listing this in the cover letter, but ultimately this would
> save memory by removing those nodes, eliminate work by not creating
> the nodes, and improve performance with a faster traversal, all while
> transparently replacing legacy interfaces.

And you can do that regardless of the type of solution chosen above.

>
> Thanks!
> Sam
>
> [...]
