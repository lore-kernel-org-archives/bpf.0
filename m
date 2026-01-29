Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61092F7475
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 03:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769655647; cv=pass; b=lNJIKlCMmmHJBn683uA/08Xdhe6qEQfqb52yD5ntml9h09IyAziI+db8agR/DiO7wi6i7LHRaHkp9WnWo5pSaOJcbAwGdoNj9wbmEgS4o6eHzpxZNQlOcSKB7BJjjwZlfpL9kW0ldKpN47KkWCoorwfseqOnARsjRJ5gKi/ILQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769655647; c=relaxed/simple;
	bh=vyxfgOAmnll94zm1S/hC33w2HAY37KwnCm13wAOLxCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZB1lDy1bYhtLSSAIBueTRji1+5etmoBDshKw0Y2xazFvq7s3LhhqeHlhaIKV/s4tYVCIbv4v52A2tzA4CZlrOORwX9PXu+vybjO/PJNjPMwJFBOsD5Z8X0EV1yRUpY6xs1An2foXxV80RO3u8ymqErU+rmdM7iGZQ7l/spsdms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGN0MCKa; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGN0MCKa"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-432da746749so342095f8f.0
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 19:00:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769655643; cv=none;
        d=google.com; s=arc-20240605;
        b=eVjX2KlD8vX/ewrcC/6cfhcxS5iygMMby2ugOM7VRG1fi4N+as3n0lWC2cfDc/r4Iy
         xwPkna6yvjNL/4MQno5WPIWvdEWO+j3Mr1IK1XCkM9aZ230zFwdfb9xiX4eBxWxTSayW
         i8/JQZ5nfTLS4+Qd0jhmDtFWihKRYYPYL4BqdFk8uWMmfidw9WOeFHMqe+B0GZIU3OfZ
         lNnQoP/RsO/kyHsTMnFuA7OQ0uzN3OHQuh0bFUKoZnR6UTaAwbjuXBRnRoZkyEW68XOB
         oiE8hbLCWaDkSeuCMkywOK1hPyGptIX0WsYqMLiHy6ynkjKz1DfGTi0Z4BQfRFM3k/WY
         ismA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oHvURcRfYHsscuuITIRNvgvNBY1MZsRCLrZGQ5/heFA=;
        fh=mXIxbOrl/vDt8agksZiwYQ+RA+LecLtuZFGdiPWn0iM=;
        b=HEQ5X5hhUQ1hePoS7/bbs5PMNsLjcgImeMRnPn1aL8CM+FfT9I77gy3Vx93R9snM+9
         EiYvR0KsOQMeu/RkzsbBE5qC/wrQs6r/T0SP23y8UUld4AwgMmDb9FuUJsoW2IamFgtF
         D3ODmnY8gMkT7i6w8hw/ZF6IJ8nQd86dM74OxsCVeAKld1PQM7llEabaukryzxHGsauf
         P3fzkWs9rwDtC51qJgM8IlEYgfF2xtmMsHv804DNwj13GUMXwiTMSJ08a9fis22FBjib
         uVBulEebzCJJkZS1vHwpj3poLlKae+pAx97q56nB3A8k/jL+JYsHgPupDhDrrKJFJprE
         kCQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769655643; x=1770260443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHvURcRfYHsscuuITIRNvgvNBY1MZsRCLrZGQ5/heFA=;
        b=lGN0MCKaXyEvfjG53CKa1EkcHhTjtzdHWFfzJyi8My9iZtIgbiP603dTHho8pgNdyo
         6GxcQHkjtTDiKawv8FWyOHm3XqiEDoWYRTiuEtTdDRcHVgiV3PihybRwJeePFStjx8sb
         HMvQUMmUsZ36iLd20jAa96bhHswC3Rsy/AlnwTk6dnfQOQtKgGRm6feuVa/K0drWoEBq
         TF4a2ZziYVPyWmzQEENSTskEghj/p6jTSvmmg5gremXQr4q/GeXFriSAo75YoJ59ZPlR
         s9cpd0LCEj6LD8UQBkTLM70PQZgTzzlZ3tL6tsLILK8bRoGTj3+u36fXpvjlGslD45XD
         FeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769655643; x=1770260443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oHvURcRfYHsscuuITIRNvgvNBY1MZsRCLrZGQ5/heFA=;
        b=A0pT/iNdKPQNa8kA/2XwYnopLL3DGj/GtwnrgD8zyPWSnEE9zpJRsz16Xa/Jk7eI9W
         h3CE/RkOJgr6TVuIkG5CYTliSbd1enqDOxpsnhM5Y24LZLaVwtWnyf6Dh6d6FgcYN7mp
         zeljftviyZX2rNmcXhL4HwI/rZyafne97GBaWIplokK+3XIEQI44HiY7c3EGbKDM8R8m
         3U4w9vVH0PuAw1LSdMSkWYU0LLlrCrBsg3NNtvEbbB1PKI1Z9jc0IWvfFKyk7gV9trQc
         l3nlNPYoWweYkzUFp0nYYUMPdBhmEH7pkv4G9kdTd3NOt/lgUtJt9S1Io6DHWdfuAcLE
         NTUw==
X-Forwarded-Encrypted: i=1; AJvYcCU6vuBmMOodRbCoExJZ4QkSPDFGdsHM6lhV8X2hyzlVWD3LgzmFW3uBHIru3904+AArgV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzSBz90J53UFi43I9+c2V1IAbeceTAwF5PJMs3MXyxFymtD8Pa
	MDODtrfJwJa1ZqVxInb6PBtRksiwFSV4F4H9SX77whEzcm7ydyzRnvasr3YLMXgMVrS6E6lfmyR
	qv0EYVTXDbLb8aQRgScumTFbtYjoyuvY=
X-Gm-Gg: AZuq6aIAEbDxOaQYesyiT++CI2icKAlwuPsfV9ql839x0piEKhI8n6yhgINU2VBd8fj
	skoo/yFb7U1BZtYgXWp89TNhjq8AVD22A89lxmM74H3wXwNfxr9XWbvMCsyeMcHbbQ4IXgpO768
	mz+zMxucgqA4l6fG5cJvOanYO9RalUMaIccPZxgsATgC8+qXqHk+M99g6KhL5GIzMg8ZLPR+dtW
	5rwHFjsddp1g+td2b7T42Hg6Fq6B4IE2IppKSn9B/sRr+DSeWygyLWYC5kSS9zGTld05mA+ZX7p
	LIp992VoLE7kjnXaxSCYW2qDrx1pb/JsA5XAdtvHp29ndoFs9Z3V4gXyU/UkwxON4VrM6WAyyO8
	yTAdkMisxqqFJ4F+3N8ZmB1Na
X-Received: by 2002:a5d:5d10:0:b0:435:985c:48f8 with SMTP id
 ffacd0b85a97d-435dd0b2a34mr11417615f8f.45.1769655642380; Wed, 28 Jan 2026
 19:00:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ca43be24-6f54-4689-aa8e-23573e83ca5b@h-partners.com>
In-Reply-To: <ca43be24-6f54-4689-aa8e-23573e83ca5b@h-partners.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 28 Jan 2026 19:00:31 -0800
X-Gm-Features: AZwV_Qio7k27WZ58i6eNFKEJ38oNLVberCPg94we3c2b69Th8HMU-Xt5YEfTDIg
Message-ID: <CAADnVQJCYsA6b_DSZEZMRMyt4cADEvX90KkJf6h2fBpep4z8Vg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Userspace JIT for eBPF
To: Gladyshev Ilya <gladyshev.ilya1@h-partners.com>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 10:43=E2=80=AFAM Gladyshev Ilya
<gladyshev.ilya1@h-partners.com> wrote:
>
>
> I'd like to propose the idea of adding support for optional userspace
> JIT engines to the eBPF subsystem. I have a promising prototype already,
> but I=E2=80=99d like to discuss the broader implications and open questio=
ns
> around this idea before moving forward.
>
> Motivation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> In modern systems, eBPF is often used as a robust and easy-to-use
> extension mechanism. However, the verifier that provides this robustness
> also introduces several issues:
> - It requires a unified intermediate representation (eBPF bytecode) that
> limits the expressiveness of underlying architectures.
> - It can=E2=80=99t verify some sophisticated compiler transformations, wh=
ich
> leads to either disabling them or using inline eBPF assembly as a
> workaround.
>
> And while verifier has some basic optimizations like dead code
> elimination and map access inlining, without register reallocation and
> other rewrites these optimizations do not provide significant benefit.
> Furthermore, current JIT implementations translate eBPF code
> instruction-by-instruction, so generated code is far from optimal (7
> instructions with push/pop for DIV on x86) and can't fully utilize CPU
> capabilities (extended ISA like cmov, extra registers available on ARM
> or even amd64).

The work on a register allocator has already started. It's very early,
but yeah we do expect nice performance benefits on arm64.

>
> But reinventing yet another sophisticated compiler inside the kernel
> doesn=E2=80=99t make sense.

That's actually what was happening for years now.

> Instead, I propose an optional userspace JIT engine
> with a fallback to the existing in-kernel translators.

There are several issues with external JIT.
1. It's hard to extend the trust into user space.
Currently there is no mechanism at all.
There were proposals to send proof-check into the kernel, but that's
not trivial either and not compatible with JITing.

2. JITs have to conform to BPF and kernel memory model.
The barrier() doesn't exist as an instruction in BPF ISA.
So any kind of instruction scheduling by JIT (whether in kernel
or external) might break memory model and break concurrent programs.
JITs have to follow Documentation/memory-barriers.txt
We added bpf_load_acquire() insn recently, but it's not enough.

> Overview
> =3D=3D=3D=3D=3D=3D=3D=3D
> Kernel side is very simple: it only sends eBPF code to userspace and
> then integrates resulting binary blob into eBPF subsystem -- or falls
> back to in-kernel translation in case of any error. While this does
> introduce new code, the integration itself is non-invasive and very small=
.
>
> Userspace side is responsible for correctly compiling eBPF bytecode into
> binary blob and writing it back to the kernel.  In my implementation,
> this is an LLVM-based compiler (single statically linked binary)
> designed to be as simple as possible, offloading all the hard work to
> LLVM. In the future, some reference compiler can reside in linux/tools
> as part of the infrastructure.

LLVM and any other compiler will break concurrent bpf program.
bpftime project is doing that though it's danger zone.
They demonstrated good performance results too.

> Because every loaded eBPF program still passes through verifier before
> JITing, this approach maintains bug-free execution and other eBPF's

... maybe bug-free.

>
> Performance
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> I ran performance tests on amd64 (Xeon E5-2690 v3) using sched_ext=E2=80=
=99s
> eBPF programs, along with a few others. Timing measurements had some
> skew, but as a pessimistic estimate LLVM-generated code was ~10-20%
> faster [2] than in-kernel JIT, and produced assembly had 40% less
> instructions. The most noticeable optimizations were:
> 1. Re-allocating registers, inlining "DCEd" subfunctions, and cleaning
> up code after verifier=E2=80=99s DCE [3].
> 2. Removing leftovers after verifier's inlining (uneeded register
> shuffles and spills).
> 3. Using specific instructions like cmov, imulq, seta, mov(8*reg+reg +
> const) and other.
> 4. Using jump table (though not for sched_ext).
> 5. Lots of other small optimizations.

Would be great if you can contribute these optimizations to the kernel.

> Discussion
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> I=E2=80=99m currently improving existing prototype for an RFC submission =
and
> will try to collect more reliable performance data. However, there are
> several discussion points that require community feedback:
> - Overall design

Sorry. no go.
