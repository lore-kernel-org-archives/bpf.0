Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904235678DB
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191497; cv=pass; b=iw/hNxxZUqYCunxBv2w5oG+QecRM1Gbsg4DU1N/rN6nh+++R0xs9DM2oXmmCNpz5N4N92qkw5CIlI4i0b9vRZnWPMocfKAHny9GvzJZGMNCwskMnMlB2GNJ8do9i+lDHqhICPDmFJKJ35bsEK288JYyR0dbLklgaCkMjsFaH2lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191497; c=relaxed/simple;
	bh=gXG6xNkGxv/rBdcodVCyKHh2zAauwkxvGOgrJjSvwMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIBUSYGicUw9nHxg3G6Pv9BTMSnht2nz7beV6A8hvf7zEusw5uiNd1BJGXvFzHajUcVanzCy+HHEyA4HzfZdw1vvlewV8dk2bYUMWd/sx1kJSkes7eoEAVpUqDoT1akuSxc+Nwc3RyfyWQpXWgngX5S00HFNPla2EJ/RY/riYnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKWlp+pl; arc=pass smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKWlp+pl"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-39b5b07ec78so766586a91.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:24:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790191495; cv=none;
        d=google.com; s=arc-20260327;
        b=UMrSYxzbbKKn2rpQEjZ9BlR7dKd/fBhpbhFKkZQpqPionAl2eY1T3ANLhKOlzlDSBF
         8LDC/+fSF5Nx+V8P8RzNC/Bh3igy5lKxaH+qR+hfg7G6WeIqkTO4SrIti2PdCj+lEJhO
         Tk0hcpfy7FglGCn8rO2IVVHbM2VIdVmk1DbhV+L4O1ydM077qV2fu8ueteGzMvttWpgS
         BpOAHLNQOmw+jjrw0TzYLJF5DM9oe1Z0515nV0IPiEdZ+Yyu8od6/goJ/GkaI6G3F4WF
         NkzovMHUUh1xXSFsvN2lHDCAmgoLnap60VG9mrwaKosGgRsSJunvmyYyUH8W1n/AO+Wg
         3Ijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AiWeXBrK1Tq6z8N+Xb51+qsoVtUVLmpC8Dc38O9cOjM=;
        fh=rRpU41TS4pDVRLZCsWEHIkRjyMtWAJzja20lws6wPUo=;
        b=sPb4ga+BG1+trBEGkpu8aFJ1SDBIemzlDUlKUdHZOyNgiwReP/WMbwnmLAhasA3JEo
         T1TDm9E3zz4nLV0n79PGI/fw0IEzJksh0Dwe3K8rFNAbGWFO+5PAl4jOXw5rfNL6LTwM
         hyumVcWzwhnAUdfHe+r1Qk4GXuRz/xN75cPUmLKu077jjWmUXLANqaQKbT4hPV6bNcSY
         XSchHXZNvqBkMeVisgmhTRRqbC0VPcy8mU5VSloslvn2/QVm6chmHi6KAjNBOIRY+/78
         rySsrvai/pyrX5bMWFCj+C7ipCnJmJKIUfZSGyYjpH4X5Gl6WzY6F/x5/H5DmAzL3yiA
         5jSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790191495; x=1790796295; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AiWeXBrK1Tq6z8N+Xb51+qsoVtUVLmpC8Dc38O9cOjM=;
        b=gKWlp+plUhNxtqkl8qARXtc6V8+graIJp/3KafioYsNxwRz7hbdxI9e4ZBuYyLeySN
         5Hws5/fgMpzTmuylZ+mwRlbj58ckQKu6KihobdS1xPE7gqRVa9B14eJOgknWr2KXm+W4
         9COxEZobLXWc/lR0XZkJXUpmYsVm1pOh8uFArvjUlqdA+fOa6Xa2gv/loccoI/vZFOhA
         RiDPL7cBryeBxLHYKWXGlRlqfonXqIbeeettqcpPcSzzWC/TnYo72NImh7fC6RjenSOV
         G5pbFLyjikQE2EIisO49/zH/LpzUox9a5X1SLQqXwa8TTk4iMV8UrwMS7nSbghP1wypp
         jAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790191495; x=1790796295;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AiWeXBrK1Tq6z8N+Xb51+qsoVtUVLmpC8Dc38O9cOjM=;
        b=jgK6tJc5QCRRov6muy3hwxbeSlRiSNtEMbQztnDVaF+buBx3Zf4oCDtOHZ+LCtou7U
         uuQKObDCt0Qx41SedrcTRihYf4kx98jOJnTeTW0VAAcCZ6yweBBv+6+5+0IWM8g80RmM
         jCPYNIaEdLGzgBh1690IzancJbr/4x6Bz6JsovCzib9PRum77pobB5+8GQztmcAmeooW
         6n95PBAnfwxyxCLYkeTBDOnK5poT+pjHJaQVHDZvBHFPQEeGYE0wwc6/HgVUlkbLPNXz
         8E4k3Yfg1LU/7nypQfHwO/NQYDeAhyWkg5+z/BuXoRjiEEIoHThfsVaaRVHQTW85mc19
         BgCg==
X-Forwarded-Encrypted: i=1; AKwUvBxtZccJvvytx8BCVgNy8OBYB5RZgONoDxdzhwa6Z8I7NCUyWJyqtk8Ci8SD9917JKDMnRw=@vger.kernel.org
X-Gm-Message-State: AFuF++mtoZyQpjgfREh9RLTLToaVKHlmJRqp6RM99Uau7COteZe9Y0T4
	n9DCouf3lec7uPEde0g/WOGV1D58eysOzs17VrDdIz3NISN4d/XBlsGtqk/ygLAAH+K5/WjRyav
	DM5OltUwhnYKDRUp17vBIrJ9zJP27GsM=
X-Gm-Gg: AYBFou2FxiCyb+8OmnXE/sHAmbfbRgOOYuTutrtLJWSQj9xPLJFDRKy7vWfNJWRJ6Kr
	xBoAPV9LRK6+Q5rRWRVC2g9wAcHAhAP6CVT8uynKRNOtkzMGmH2RVMLbvsAKzBANWn0QLURSA8s
	lx7DIadcKMVW1BeFUgxRkAfWkVucXsKHYL1QnGDBd0hnHRCKOg8hG2uL/DXYACD+wWuTUzmRDMN
	d7ujvMf9DPwkYiy4JFKKuMOwCWaZP1LI09DMN2eJfivS97VrvXmPnS4PB2m3VnKDbVubFas7Xkl
	JbPfGJvsAzCz0wc948q3LlcGrsAApO2VMADB3jxxUkY4BzANpzZ2w5rDRML4l4IWdwmaci2Gg7/
	l1zaIfHg6VY+rRTEZFBRcm+JgYlsuirX3pIk3
X-Received: by 2002:a17:90b:51:b0:39e:6c6a:2092 with SMTP id
 98e67ed59e1d1-3a09896ff66mr132272a91.51.1790191494871; Wed, 23 Sep 2026
 12:24:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <7e7076ce94e803403bcee003569d4b2ac7bc4e2c.camel@gmail.com>
 <DLLHFJDS6G5L.2B273FIKF9A09@gmail.com> <7eba4eb055e15d5c78f463d013fa98bb21d7b494.camel@gmail.com>
 <DLM6BVU1G0V3.29T5BPPZTZ77Z@gmail.com> <37e53199dfda608de30a31fc51d22ed2b25d6d2e.camel@gmail.com>
 <DLM8NP9S8A4E.1YIS9HRMSR62@gmail.com> <a9c4ebe0c1a08d7025179b1ec2297a4d975cd072.camel@gmail.com>
 <b3a29c0b77ada6a7eff101a5d8b4e83021a3052e.camel@gmail.com>
In-Reply-To: <b3a29c0b77ada6a7eff101a5d8b4e83021a3052e.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Sep 2026 12:24:41 -0700
X-Gm-Features: AclHuK-QWSgqf9RJYR_J3WRCmp70PVH2QFdPCWC3CezJ5pl2gQGw0bDEl-mKUPc
Message-ID: <CAEf4BzaStrSG-hGERB8J=mt3agEq7d9L8+L9rsr4Z+=68gtA-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 00/20] bpf: Run exception cleanup landing pads
 when bpf_throw() unwinds
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 12:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2026-09-22 at 17:04 -0700, Eduard Zingerman wrote:
> > On Tue, 2026-09-22 at 23:37 +0000, Alexei Starovoitov wrote:
> > > On Tue Sep 22, 2026 at 11:08 PM UTC, Eduard Zingerman wrote:
> > > > On Tue, 2026-09-22 at 21:47 +0000, Alexei Starovoitov wrote:
> > > > > On Tue Sep 22, 2026 at 4:27 AM UTC, Eduard Zingerman wrote:
> > > > > >
> > > > > > Total size of executable sections for all Meta BPF object files=
 used
> > > > > > for CI veristat testing is 10Mb. Of these there are 30K non-hel=
per
> > > > > > call instructions in total.
> > > > > > So we are talking about increase by 8 * 30K =3D 240K ~ 2.4% wor=
st case.
> > > > > > Note that the instruction encoding optimized for size already h=
earts
> > > > > > us in src/dst registers department: we have no room for virtual
> > > > > > registers, which would have simplified e.g. register allocation=
 task
> > > > > > for ARM64. Point being that optimizing intermediate IR for size=
 is not
> > > > > > always a right target.
> > > > >
> > > > > I wasn't talking about increase in bpf ELF size,
> > > > > but the amount of the verifier work necessary to double the numbe=
r
> > > > > of call insns.
> > > >
> > > > I don't understand what you mean by the amount of the verifier work=
.
> > > > Traced program paths would remain the same, only the encoding of th=
e
> > > > information about exceptions changes.
> > >
> > > Any new insn requires plumbing through out.
> > > imo ld_imm64 encoding FD inline was a mistake.
> > > We should have went with relocations through out.
> > > Much cleaner to extend.
> > > Same philosophy here. Landing pad is a metadata.
> > > It's not a good idea to encode metadata into assembly instruction.
> > > bpf ISA is not a high level IR.
> >
> > Here [1] is Yonghong's series repackaged by codex with the following
> > encoding:
> >
> >   call <subprog-or-kfunc> // regular encoding
> >   unwind <label>          // a new instruction that must follow the cal=
l instruction
> >
> > The amount of the verifier/libbpf code dropped from ~2K to 1K lines.
> >
> > [1] https://github.com/eddyz87/bpf/tree/unwind-postfix
>
> I want to highlight this once more, before it gets buried.
>
> Whether landing pad is metadata or not is a matter of opinion,
> seeing the program CFG from it's source w/o a need to consult
> additional tables is definitely a plus.
> Same with ld_imm64, and yes it adds a few checks in the verifier,
> but those checks are trivial.
>
> I looked a bit at what other VMs/IRs do and it's a mix:
> - JVM has exception tables similar to ours (begin, end, landing-pad).
> - GCC (gimple and rtl) have landing pad address attached to an
>   instruction / control flow graph node.
> - LLVM has invoke instruction that takes three parameters:
>   what to call, where to jump on success, where to jump to unwind.
>
> With that in mind, I think that the rational thing to do is to choose
> based on the implementation complexity. Compared to v5 [2] of this
> series the branch [1] allows to forgo:
> - UAPI to copy the cleanup table from user space (patch #2)
> - insn_aux_data changes for cleanup_pad address (patch #4)
> - simplifies check_cfg() handling (patch #5)
> - simplifies main verification pass (patch #9):
>   - throw raises unwinding flag
>   - varifier interprets `unwind` as any other instruction,
>         jump if unwinding, fallthrough during normal operation.
> - dramatically simplifies libbpf part, dropping patches #16,17,18:
>   - no need to collect cleanup tables from elf
>   - no need to relocate these tables
>   - no need to pass them to the syscall
>

All of the above sounds like a pretty compelling reason to do the
invoke instruction. 16-byte instructions is a fact of life due to
ldimm64 anyways, might as well utilize those extended instructions to
simplify a bunch of other stuff. Not having a bunch of arbitrary
ELF-side conventions is a big plus, IMO.

Unless there are some technical reasons why metadata table on the side
is objectively better, but seeing that we have precedents with LLVM
using same approach, seems like it's workable and shouldn't paint us
into the corner design-wise, no?

Given a rather lively interest and discussion, perhaps we should do
one of those long forgotten BPF office hours and go over this in a
more face-to-face-ish way?

> > bpf ISA is not a high level IR.
>
> Well, BPF evolved as x86 in disguise and it was the right choice for
> that moment in time. Today it is a limiting factor, just talking about
> explicit stack vs SSA, it makes it harder to:
> - do liveness analysis
> - do range analysis
> - do SCEV analysis
> - use full set of registers on e.g. ARM
> - the fastcall implementation is a hack
>
> So, BPF not being a high level IR is not necessarily a good thing.
>
> [1] https://github.com/eddyz87/bpf/tree/unwind-postfix
> [2] https://lore.kernel.org/bpf/20260923045846.2414643-1-yonghong.song@li=
nux.dev/
