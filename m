Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B269282F10
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772821849; cv=pass; b=O6y1PvZIF7lmrTV4e2n6jgF17j9ihnHwy/u6pQrpCuVoxybA0DtsKdQwTM/b26q80P/N/JCbu/n4GjHRPbOoM2jEvj/6BLtX0i55JtrIikU1i/9cpMJE4mVADabfB0/t5YzgFEq4ETDZ6FzdXZapKgdw08GyInH0qL+5ky9iTRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772821849; c=relaxed/simple;
	bh=5bZGG1A9irtdpEkKIMpjS7aEUAgk5eBgRz+IMtGwNxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBcOAXsdmFfFvtBHeiVPFxobNFnYwo8KRibfHaLNaIgMqSa0UsS88uYuOqjXGKuYyx58c4c6ZUhZd4Syxl9BCpXMIHoUkh1RYpl55ulVNOhKMfkzFTHHZW+jpUMT3p/PQueztF2U7ohhBoalswmKS8g92Td3ENMNi+BLr2IEea0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPOTuhjz; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPOTuhjz"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b94a19fdso5502662f8f.0
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 10:30:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772821847; cv=none;
        d=google.com; s=arc-20240605;
        b=HY5fyrVBPnZRqkXYs/JG+aVeNmOarDYKliD3l342jO59ifaoOVdax0ym3o1gV6k93v
         hMhIyQEVcQBD4qDa4W2KdA5t4Obv2WOsaiUlikQnOwyQD/qJhNBfyjRFUvq+BBmztRQI
         41X7U6zos9tiVMda00WzbYFmBPUxntrPsSpw+R4PMruhkUqCEThmITwSHjRWUxG+25wM
         /x4Bf6NLn0ozsXVRQW8lhZkTt1E79kyqTKYqxq2yi5QxlAODwaSyXzrdsk5kXKI1X5F+
         iCmimkTM7e3PaNbuYmR5fJcgebN5Wte1OIELbsJGPB61vGyZ3UlTKduePrTgvUUuNT3y
         9Hxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OuSGvLRcijRhyv53Fhaa02Fta5OZReKa/jZoeaJdDZ4=;
        fh=aV1b9aV80BuBRQwQGjVsuQlkQs2c7G26yGp5h14gbh0=;
        b=EoyGGYL0jC1UYChIDuQbwCXi3hPHTWLpqc1lSLR2RA6S2q/ld9IdItbk92r5veu0rD
         Rx/dVjgqR0Rd4gVajk8tw2SqTROfGvYLphEBcHr++IoIPIQ9TKPdMMaouiwoRSfEkMOU
         CiqASCStSoSyyZfLeC/lyEkYAS4gXFW8xwgle2i6O/j1h2bnjZDZBjXdWfiQVnp+1q6o
         zMDdtUhQt3xeDvg1s+mDy01wiuf2CO+e1NpQfo1BkgAUprKd+IJPQGianxQiG4xoIoMj
         aCKsItQ1k6CQAg8g/XUEtk13oHgDYQ4nNO6GC+yY1QBXKczf6n25qQ+IowfibjVlR4kI
         nBPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772821847; x=1773426647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuSGvLRcijRhyv53Fhaa02Fta5OZReKa/jZoeaJdDZ4=;
        b=WPOTuhjzjW0uEIxrcrhjCu3FJQf1rAo1B4Pf2bxeXde6GhPeS8foE4J1BiS9KmvkbI
         l04t0SyUsYN+2IrrmChy9rm1O+nTGI0qXp0oEUy02MQ9pG8uvyA2c4DMRNB4qhqvf8+2
         vbgV+ju3gxtVyJfd4guSVfVQeXEueda+XUgTofA39kyyjrqb93l2fvcyTgOzfzWKrR4N
         OFIgbn5kN05iMUGjUyzjRQcUsCc/5/e3HcphC1lSbiPplw+VYQXl48kxxBGiOsX6A00C
         vDxN/4T9rAdoib0N6fP6hygF1AtleQPK+CphEcNgk7bktiT4F8xlDayBYGoH8MmmWqEh
         ldtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772821847; x=1773426647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OuSGvLRcijRhyv53Fhaa02Fta5OZReKa/jZoeaJdDZ4=;
        b=Gu/I7GbPkGyDDKnscXMnMDnbMefwn2ULqLo39ibW577FkO0HTIysozXu9rwK0Dc4pj
         H4Igs/V25dFLQ8VqP2onWVjx7g9chPBVsnLeyvnbEexIZLCcMrUal775mrASc8hiod/2
         YrAvCQMODbph1jCCg9rDm5nNViJDqx55qnAQcgiEQ7Tv7idpcOVTCVzVnhaB7CCtKnwa
         64H05BqIbxoTHvvi0xvLlmBwCOTWy2W/dmMXVm6BL6R5bUJUNnaz2Vy/jWM4I7rmaSNU
         lB6KlLEgfVGo+ljiQHPOJKeRH04orekRNc1ZRix2BmZ2YJpRs1GTAQLyC74KYQIdYqNZ
         Geww==
X-Gm-Message-State: AOJu0YyLTBNrgEtvmDDr2YeoEy7Yu5cTvTTLPbXJZEGbQdC6B7wb48OU
	ljo4ZJySHK6cjSBZVlq/KdQY6K8Puynbnp/8iX17ORmhm7xWaaRJ7tVU/5sCGJSF+qkPY4fKrgm
	nQCMDyYxubHilOhpNjtXUb3DL4wCiFTs=
X-Gm-Gg: ATEYQzwc3oI6gYdQE2uMXvLqfjtCsG+xQjew/MQ2xLp+Q8X64oyPhXaVLq0jhksm1pR
	QQHxfSVjG8chxTSkIuSLVXrKJ0og8jWfP31mhnJ1JQxvxNY9TqZ6kPSIJlXUawCwn2XDiQtACdO
	wIxuxpF4jE+glJAbM3cLjrWEpe2Hf+AKExMgJmqbB0O9rEwB7ND34rZCUoRI4gO/rJp9FX6T4ac
	NOiRnBDDjiG9ikVZWhXtnmlWaoRQeGOlmo0x87tzYRnPTWc9fbraudaOmhXDdbBqmiCfwzVYk/1
	OxKr3Yb6FlWh+ZufzSuk9RFyWhL9+/iSaHAlpy2W6xrkzOfIS3PY/ky/Ln2Ew0M8QBUzDU5/t+9
	hESbZtYYoVawwQq+a160FcGKUtCb2O2G0A8pr
X-Received: by 2002:a05:6000:290d:b0:439:b8b2:fac6 with SMTP id
 ffacd0b85a97d-439da6621femr5656153f8f.22.1772821846273; Fri, 06 Mar 2026
 10:30:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306102329.2056216-1-xukuohai@huaweicloud.com> <20260306102329.2056216-2-xukuohai@huaweicloud.com>
In-Reply-To: <20260306102329.2056216-2-xukuohai@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Mar 2026 10:30:34 -0800
X-Gm-Features: AaiRm53NBXg75ZsVgxZZRREOs1exnnImw86xT6rvgG7ywSHYFj2tZC-NCuB719g
Message-ID: <CAADnVQLv1+8SePM9K0A0gS+zqjePafSmwtNAo=Sh7cEEy99Xkw@mail.gmail.com>
Subject: Re: [bpf-next v6 1/5] bpf: Move constants blinding from JIT to verifier
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Shahab Vahedi <list+bpf@vahedi.org>, 
	Russell King <linux@armlinux.org.uk>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Hengqi Chen <hengqi.chen@gmail.com>, Johan Almbladh <johan.almbladh@anyfinetworks.com>, 
	Paul Burton <paulburton@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>, 
	Christophe Leroy <chleroy@kernel.org>, Naveen N Rao <naveen@kernel.org>, 
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Pu Lehui <pulehui@huawei.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	"David S . Miller" <davem@davemloft.net>, Wang YanQing <udknight@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 1:56=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com>=
 wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> During the JIT stage, constants blinding rewrites instructions but only
> rewrites the private instruction copy of the JITed subprog, leaving the
> global instructions and insn_aux_data unchanged. This causes a mismatch
> between subprog instructions and the global state, making it difficult
> to look up the global insn_aux_data in the JIT.
>
> To avoid this mismatch, and given that all arch-specific JITs already
> support constants blinding, move it to the generic verifier code, and
> switch to rewrite the global env->insnsi with the global states
> adjusted, as other rewrites in the verifier do.
>
> This removes the constant blinding calls in each JIT, which are largely
> duplicated code across architectures.
>
> And the prog clone functions and insn_array adjustment for the JIT
> constant blinding are no longer needed, remove them too.
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  arch/arc/net/bpf_jit_core.c      |  20 +--
>  arch/arm/net/bpf_jit_32.c        |  41 +----
>  arch/arm64/net/bpf_jit_comp.c    |  59 ++-----
>  arch/loongarch/net/bpf_jit.c     |  50 ++----
>  arch/mips/net/bpf_jit_comp.c     |  20 +--
>  arch/parisc/net/bpf_jit_core.c   |  38 +----
>  arch/powerpc/net/bpf_jit_comp.c  |  45 ++----
>  arch/riscv/net/bpf_jit_core.c    |  45 ++----
>  arch/s390/net/bpf_jit_comp.c     |  41 +----
>  arch/sparc/net/bpf_jit_comp_64.c |  41 +----
>  arch/x86/net/bpf_jit_comp.c      |  40 +----
>  arch/x86/net/bpf_jit_comp32.c    |  33 +---
>  include/linux/filter.h           |   3 -
>  kernel/bpf/core.c                | 263 -------------------------------
>  kernel/bpf/verifier.c            | 215 +++++++++++++++++++++++--
>  15 files changed, 288 insertions(+), 666 deletions(-)

JIT changes are fine, but pls don't move main
bpf_jit_blind* logic from core.c.
It makes the diff unnecessary big.

pw-bot: cr
