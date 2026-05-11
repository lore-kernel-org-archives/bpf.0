Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBBF477E46
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517680; cv=pass; b=lSPcTDo79jon3rHuDRjjYE8KHKvD/O+tGkgN5ijk5OpVA7xrJ1Ea7mo9MP1BblV00Hrys1rnFVPhwbA+T1EyCnjHMYS4AJ1lsUWjRejQKjVRVrvmNcCYMzCR9fKF1v6LAUj7lUe5/dEIFm6k5Kg3AamukbZLIXUnnuU2vu4fNNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517680; c=relaxed/simple;
	bh=ychIqoH2N9RkBSK1oqMvOJTasQOsN2jS3M8Rh7cNElY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3jwV3XxAGqmWAtFM6S8j6O04cRSctN3TGQ54vqi4ZfsPtzJBH0DhsfQg3ClW/64bevILuLn3TiOq0dZjo9dtcfjszQ5PRN8ziEcFywho6uFeBwFVZZeX3O1syd7pqhJsN2wXDbD4C7kQ756UdUJ3D+mveG5UndTXpJA/Y1KMpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFYMd16o; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFYMd16o"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-366139223e4so2818877a91.0
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 09:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778517678; cv=none;
        d=google.com; s=arc-20240605;
        b=Olp7KN2MjchPcALf8DwgXf3L2eHYw5TJ+A8403yunbt/LCM+/EKaXKTlEriBHolaLJ
         R5J91j2Y2UEg4KDPZ8HHgxwYwhNWVrzsPusXk0oGTPI8iAzbyW3R26aPdsGgnAVgXoM1
         R+OUN2OEqbCH6dR3kEksIloWLfOpSTN/ZotBqtYJdpfOG2YN5gi41B4dSyUMU55caL81
         zFwhj5i1L6MFedHeHGCWD5S+LqKYDc+1WsVwkYSR17WsjN/3r0Xkm1H5SiZdBhFDuBL2
         nrGW0WiQS7e3w4qFeBBRLCQ1ZK+Y5iLgvO5Y95gMwguGnHOJ2O+WolQBL5UlkjDI5uxW
         LfIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=twgMFzrPk4l1LS+jrmzU69hpjXt2Fx2pEmRL5onfYHo=;
        fh=BjK3lwsQ0drZa22HwGwl/q9L0ZefOc4RZ7rTOBtfzXc=;
        b=YBC33cYpnAy7Jix/qlaKJcpcYmVHx0kuXHs7jy1fpFiEhMZWXHVpOBAEG0yJww0Fox
         B54KG8o4t/j2suLcfRI0aDNlb2vyXhnHBOXV5TdnJfKGKbglf+ADKy2IiZ2M1D+5Akkt
         aUX/hDXFQ95yFIG/6fUKjUdoAX97e7FgaXawXvq7P+29TZUaL5i3xwt6g2nYkGgSbEvs
         XgYH4ZyT3XD2eonbcTIHQ4Jj0Da8L6tr6qrUNOW7pRJF5nDGpvMVS2CYKWrQPk7CMuTc
         4ivgzPEy5i2l7EyMn96k6WpY5Th7DuCO5BNtrciENW0OdYGt/w8B4EsOINlDOQqUlySh
         ffag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778517678; x=1779122478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twgMFzrPk4l1LS+jrmzU69hpjXt2Fx2pEmRL5onfYHo=;
        b=BFYMd16o3t3UbuUDq1QN2iHooHaROgnFEufAvwoMn/4CB3QFmtvZWhfNGzMxL/qvlp
         bLIWuyq3qTX9pDCMkF8vXQq83mb4CReEXiBIgjWKrZhS3FqPMJQgh8CiTK4of0zszkPY
         Zb4UAhOq7cnEGUVjQloRK41A8CK3Z/0Slp91cy2WfNHIdHMwZXUkkJa1N70SbbiZUDyM
         JY6NG6Ux7B0x3Y0pevLkpK+ErvQBMaYP48KjXMXZbAwqBzoOU0VDFz91qo6sUPjYDW0/
         WNwR9DF8H99wasMxTu8iGocC03fL9QtPLFHJ9WY8Gs4DvaJsNYVgYysEpt2c8M4zkl4S
         KyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778517678; x=1779122478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=twgMFzrPk4l1LS+jrmzU69hpjXt2Fx2pEmRL5onfYHo=;
        b=ZVc93nuS3Z8/zjIXJSHDW3YLTKO3DPV+gw+1TSxBkg2aUbfiLC9RhGOH5W2hK1Qwyp
         FTlcKPFd9MR7b2FAk9VT6SjiH0ugES06/UyhS79Zs4koCP7wFrFryY2FFR/8aV5gvq7i
         3U9mlleMe3WjO046RDw9gQ95jeygNPE5WUv4luNOEgOzq348fm3Vh9/ZhBMq4h6fFMFE
         ToF3M4t7RAur1FOSczQO+8bdfQBQQbYPnqTHoW+X/2ZwL5bqJdfRBIM/NNkQY3lFDjOO
         iXGlmykT/WSmu+R28tK8auTcbszdDgySfLiTxyDU9WhGlq2HhRNl4FEiqdoPsVEQgW72
         IadA==
X-Forwarded-Encrypted: i=1; AFNElJ8te5D/i/j4gRiYUuc+C2Skzxjh5n0rRkrEFW6sXjRpKxo16xqS+mCQZNnHt/Qgn1evVNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqH2RkyU3rFWsBV5Lb/l1NLuJZ11QcjXeAxCSx9qC1xlYoh5Tm
	18FaU0pw6UlWwlqNcqQDyclQWCcli6tYcxoxulBHsY8Fo3T56c3ZuAP6p37Mp0gKYuc0dYnpGMe
	+Ckq6//UWHVijzq2KOEpkrTD72aZ6MnA=
X-Gm-Gg: Acq92OGdgnyWKfXEthpcqwDusGCj/pVrkT9OD07ljtuKHclzCaYpOiH2osjSx25TszT
	1HNbB9er9AYbLYIq47Bn00/+8KZ3c8fCoX6Ojg3QpvjzeffBq+Qun0dvfh2aDZ0rTACgjHXTNai
	bEkJSdBaxDWAir3zE0QKrL0RQoLGEMRw5G8ZcWV7ssc0dLNi6mHg6qnosZtGy8gVOXKxr+zR9/R
	EWkqDsh9oXnbCIMBoeLjv6PGaD+/VTC6ze1/XD/ReTxRbI9ttjqOM2QelQquTYK9LYR/3LbXG4n
	J9GvpAXNfmDyvHy+nAqvTFmObwo9GSp0Sg==
X-Received: by 2002:a17:90b:3511:b0:367:f76c:4cbb with SMTP id
 98e67ed59e1d1-367f76c77cfmr8727967a91.18.1778517678296; Mon, 11 May 2026
 09:41:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509003146.976844-1-andrii@kernel.org> <agD3xq2MUyskd7X-@krava>
In-Reply-To: <agD3xq2MUyskd7X-@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 May 2026 18:41:06 +0200
X-Gm-Features: AVHnY4JLB8eR8j4Em_tZM-C00L4Mdz2CpH3NR3klNTKSEbCfuAALzZBjHbb5abA
Message-ID: <CAEf4Bza9PjbaVjFxYDmWPXXGV+Z-_Hn2Kz_KB2TOa5s-_UJ1xA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] uprobes/x86: Fix red zone clobbering in nop5 optimization
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, oleg@redhat.com, peterz@infradead.org, 
	mingo@kernel.org, mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 2:25=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, May 08, 2026 at 05:30:56PM -0700, Andrii Nakryiko wrote:
> > The x86 uprobe nop5 optimization currently replaces a 5-byte NOP at the
> > probe site with a CALL into a uprobe trampoline. CALL pushes a return
> > address to [rsp-8]. On x86-64 this is inside the 128-byte red zone, whe=
re
> > user code may keep temporary data without adjusting rsp.
> >
> > Use a 5-byte JMP instead. JMP does not write to the user stack, but it
> > also does not provide a return address. Replace the single trampoline
> > entry with a page of 16-byte slots. Each optimized probe jumps to its
> > assigned slot, the slot moves rsp below the red zone, saves the registe=
rs
> > clobbered by syscall, and invokes the uprobe syscall:
> >
> >   Probe site:   jmp slot_N              (5B, replaces nop5)
> >
> >   Slot N:       lea  -128(%rsp), %rsp   (5B)  skip red zone
> >                 push %rcx               (1B)  save (syscall clobbers)
> >                 push %r11               (2B)  save (syscall clobbers)
> >                 push %rax               (1B)  save (syscall uses for nr=
)
> >                 mov  $336, %eax         (5B)  uprobe syscall number
> >                 syscall                 (2B)
> >
> > All slots contain identical code at different offsets, so the trampolin=
e
> > page is generated once at boot and mapped read-execute into each proces=
s.
> > The syscall handler identifies the slot from regs->ip, which points jus=
t
> > after the syscall instruction, and uses a per-mm slot table to recover =
the
> > original probe address.
> >
> > The uprobe syscall does not return to the trampoline slot. The handler
> > restores the probe-site register state, runs the uprobe consumers, sets
> > pt_regs to continue at probe_addr + 5 unless a consumer redirected
> > execution, and returns directly through the IRET path. This preserves
> > general purpose registers, including rcx and r11, without requiring any
> > post-syscall cleanup code in the trampoline and avoids call/ret, RSB, a=
nd
> > shadow stack concerns.
> >
> > Protect the per-mm trampoline list with RCU and free trampoline metadat=
a
> > with kfree_rcu(). This lets the syscall path resolve trampoline slots
> > without taking mmap_lock. The optimized-instruction detection path also
> > walks the trampoline list under an RCU read-side lock. Since that path
> > starts from the JMP target, it translates the slot start to the post-sy=
scall
> > IP expected by the shared resolver before checking the trampoline mappi=
ng.
> >
> > Each trampoline page provides 256 slots. Slots stay permanently assigne=
d
> > to their first probe address and are reused only when the same address =
is
> > probed again. Reassigning detached slots is deliberately avoided becaus=
e a
> > thread can remain in a trampoline for an unbounded time due to ptrace,
> > interrupts, or scheduling delays. If a reachable trampoline page runs o=
ut
> > of slots, probes that cannot allocate a slot fall back to the slower IN=
T3
> > path.
> >
> > Require the entire trampoline page to be reachable by a rel32 JMP befor=
e
> > reusing it for a probe. This keeps every slot in the page within the ra=
nge
> > that can be encoded at the probe site.
> >
> > Change the error code returned when the uprobe syscall is invoked outsi=
de
> > a kernel-generated trampoline from -ENXIO to -EPROTO. This lets libbpf =
and
> > similar libraries distinguish fixed kernels from kernels with the
> > red-zone-clobbering implementation and enable nop5 optimization only on
> > fixed kernels.
> >
> > Performance (usdt single-thread, M/s):
> >
> >                   usdt-nop  usdt-nop5-base  usdt-nop5-fix  nop5-change =
 iret%
> >   Skylake          3.149        6.422          4.865         -24.3%    =
 39.1%
> >   Milan            2.910        3.443          3.820         +11.0%    =
 24.3%
> >   Sapphire Rapids  1.896        4.023          3.693          -8.2%    =
 24.9%
> >   Bergamo          3.393        3.895          3.849          -1.2%    =
 24.5%
> >
> > The fixed nop5 path remains faster than the non-optimized INT3 path on =
all
> > measured systems. The regression relative to the old CALL-based trampol=
ine
> > comes from IRET being more expensive than SYSRET, most noticeably on ol=
der
> > Intel Skylake. Newer Intel CPUs and tested AMD CPUs have lower IRET cos=
t,
> > and AMD Milan improves because removing mmap_lock from the hot path mor=
e
> > than offsets the IRET cost.
> >
> > Multi-threaded throughput scales nearly linearly with the number of CPU=
s, like
> > it used to, thanks to lockless RCU-protected uprobe trampoline lookup.
>
> hi,
> thanks a lot for the fix
>
> FWIW we discussed also an option to have 10-bytes nop and do:
>   [rsp+0x80, call trampoline]
>
> we would not need the slots re-use logic, but not sure what other
> surprises there are with 10-bytes nop
>
> I tried that change [1], it seems to work, but it has other
> difficulties, like I think the unoptimized path needs to do:
>   [rsp+0x80, call trampoline] -> [jmp end of 10-bytes nop]
> instead of patching back the 10-byte nop, because some thread
> could be inside the nop area already.
>

Yeah, nop10 and this jump-over-nop10 approach is an alternative. I
don't have strong feelings apart from the ridiculousness of a 10-byte
nop :)

did you get a chance to benchmark your nop10 approach, curious how do
the number look like

> jirka
>
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit=
/?h=3Dredzone_fix&id=3D74b09240289dba8368c2783b771e678b2cc31574
>
> >
> > Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  arch/x86/include/asm/uprobes.h                |  18 ++
> >  arch/x86/kernel/uprobes.c                     | 262 ++++++++++--------
> >  tools/lib/bpf/features.c                      |   8 +-
> >  .../selftests/bpf/prog_tests/uprobe_syscall.c |   5 +-
> >  tools/testing/selftests/bpf/prog_tests/usdt.c |   2 +-
> >  5 files changed, 181 insertions(+), 114 deletions(-)
> >

[...]
