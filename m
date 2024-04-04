Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCA812AAE4
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247162; cv=none; b=tvwHXy+37YbWB76zjHuqSqnIVptUlE/EE2hRAroitiheL+ppmSU+76E9l+Ha4kua6RZcwqs7fWz7kSU0ovElwQoB9yG6QKclYb6i2nryfa6EqUJevKtLdX//bsNMy7DLkPA1s45tsvzdKNbdbE56J3Rq1hlLaNnFWVGEJGp0zeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247162; c=relaxed/simple;
	bh=BIRK2tUdxHpNKH7i5AgkS00bhiJ1q4Qx/MLqW673wK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkjwwnBeHGPKs5iOF7VYzDCGqjOmK9H9Qutty6Hv/mPGCEVqJIXtciugfi3LCQeXCUzv/f3Okylkx8Spv15TGeJ3IXLT/2X1Melr6RFKOHXswSv9XuQgCtoYSsDco2XUsf8qRQA73zIzCO+rlwYeiXEkW8spCiTzNDLaEym9hFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnk+Y19G; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnk+Y19G"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5f034b4dcecso857324a12.1
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712247160; x=1712851960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDovgBtz7HDihfoLoqYrxcZz/wJyec5Jnx11DKmVr90=;
        b=jnk+Y19GM+EoEMlhsyIajJ7ywKARfhYQmkxFq3h4R4vSY1LxdC17tfohe33VAsjYus
         yoqCHOFY8RUJ3q9IcGjiVYnKjA+om8/a3eNeKUkpLfR9kVroOQpGorAIcqznVAUSZoQ8
         XxlJhsLOVVwGaIyeGy+7wfB2ZjF44QBfwGAaRsksi20bnFopT6OWOhP5yw05naIyd08G
         FBIBZOU+vgFgy9H9yuEm49V19vcaquRzmjd+bIzFELTW0hzUbaZ5eig27VAfqidkJe11
         5x5tVc2TPvXhFxof+IFRmbhYFkhFpv2GkzU/XKlW/lGYltGlrL49Z9RAtltEEax5k4aJ
         U2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712247160; x=1712851960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDovgBtz7HDihfoLoqYrxcZz/wJyec5Jnx11DKmVr90=;
        b=EUDKMn3kPVv3DrCv1aZbLry0Ye2JCeTtLd0Nq0MBVx+4tSHT8AdXjdX0NbGaUXdZQf
         sYV2ft0A+M4SWJs9kA3esZ6X2R+FNBhuAlSkkxwraaVT++5yGltoosOHiILJE7L3SzgM
         bKUlHu3Malt1v7TDXiePGT3pHk5bV4sRCMJak2MgYtTMbVoBZqEbJLD4oIQuCEOoC4eU
         qYTqiYx3UJaTHH6BegKorYEht4ytkE9CtXGG4fZjxIIpZ/xMqnkMybsQhC6VPwEsriu2
         KmMrWMqy0w1O5lOipg1Mezz1oJKfgOEvqClpHreLBTcdqpMAsuX7oVwbkB8ndgN2QGWJ
         s7Mg==
X-Gm-Message-State: AOJu0YyK9YkvsSUYRKmIgVZ3dAbL/bmMc92TK5EnmjVqMNORXSIPmUN3
	HQXEg0J478bfcktGsFu8l4hXRRpU5VZF4cI5DXf+yXQgO+07oVk6FNRLXGdNq/XbOQ7xu2/qAPA
	fCY5IzRUrKrho2GkW8fSxxoIKyK0=
X-Google-Smtp-Source: AGHT+IFHMN9ZX5m2FUjODZJHRveHORWRUcgM89nbXc1fV8hIAJBcCfl1iSmisSOcZzR39+sjKxLyC8Wx6QD5UIgctCc=
X-Received: by 2002:a17:90b:192:b0:2a2:9e5d:9bf9 with SMTP id
 t18-20020a17090b019200b002a29e5d9bf9mr75017pjs.8.1712247159953; Thu, 04 Apr
 2024 09:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402021307.1012571-1-andrii@kernel.org>
In-Reply-To: <20240402021307.1012571-1-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Apr 2024 09:12:27 -0700
Message-ID: <CAEf4BzbQrZ5XpSTv-0NXLRcb3g4VZRymar66zs2QyCVBmB1Mpw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] Add internal-only BPF per-CPU instruction
To: Andrii Nakryiko <andrii@kernel.org>, Pu Lehui <pulehui@huawei.com>, 
	Puranjay Mohan <puranjay12@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 7:13=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> Add a new BPF instruction for resolving per-CPU memory addresses.
>
> New instruction is a special form of BPF_ALU64 | BPF_MOV | BPF_DW, with
> insns->off set to BPF_ADDR_PERCPU (=3D=3D -1). It resolves provided per-C=
PU offset
> to an absolute address where per-CPU data resides for "this" CPU.
>
> This patch set implements support for it in x86-64 BPF JIT only.
>
> Using the new instruction, we also implement inlining for three cases:
>   - bpf_get_smp_processor_id(), which allows to avoid unnecessary trivial
>     function call, saving a bit of performance and also not polluting LBR
>     records with unnecessary function call/return records;
>   - PERCPU_ARRAY's bpf_map_lookup_elem() is completely inlined, bringing =
its
>     performance to implementing per-CPU data structures using global vari=
ables
>     in BPF (which is an awesome improvement, see benchmarks below);
>   - PERCPU_HASH's bpf_map_lookup_elem() is partially inlined, just like t=
he
>     same for non-PERCPU HASH map; this still saves a bit of overhead.
>
> To validate performance benefits, I hacked together a tiny benchmark doin=
g
> only bpf_map_lookup_elem() and incrementing the value by 1 for PERCPU_ARR=
AY
> (arr-inc benchmark below) and PERCPU_HASH (hash-inc benchmark below) maps=
. To
> establish a baseline, I also implemented logic similar to PERCPU_ARRAY ba=
sed
> on global variable array using bpf_get_smp_processor_id() to index array =
for
> current CPU (glob-arr-inc benchmark below).
>
> BEFORE
> =3D=3D=3D=3D=3D=3D
> glob-arr-inc   :  163.685 =C2=B1 0.092M/s
> arr-inc        :  138.096 =C2=B1 0.160M/s
> hash-inc       :   66.855 =C2=B1 0.123M/s
>
> AFTER
> =3D=3D=3D=3D=3D
> glob-arr-inc   :  173.921 =C2=B1 0.039M/s (+6%)
> arr-inc        :  170.729 =C2=B1 0.210M/s (+23.7%)
> hash-inc       :   68.673 =C2=B1 0.070M/s (+2.7%)
>
> As can be seen, PERCPU_HASH gets a modest +2.7% improvement, while global
> array-based gets a nice +6% due to inlining of bpf_get_smp_processor_id()=
.
>
> But what's really important is that arr-inc benchmark basically catches u=
p
> with glob-arr-inc, resulting in +23.7% improvement. This means that in
> practice it won't be necessary to avoid PERCPU_ARRAY anymore if performan=
ce is
> critical (e.g., high-frequent stats collection, which is often a practica=
l use
> for PERCPU_ARRAY today).
>
> v1->v2:
>   - use BPF_ALU64 | BPF_MOV instruction instead of LDX (Alexei);
>   - dropped the direct per-CPU memory read instruction, it can always be =
added
>     back, if necessary;
>   - guarded bpf_get_smp_processor_id() behind x86-64 check (Alexei);
>   - switched all per-cpu addr casts to (unsigned long) to avoid sparse
>     warnings.
>
> Andrii Nakryiko (4):
>   bpf: add special internal-only MOV instruction to resolve per-CPU
>     addrs
>   bpf: inline bpf_get_smp_processor_id() helper
>   bpf: inline bpf_map_lookup_elem() for PERCPU_ARRAY maps
>   bpf: inline bpf_map_lookup_elem() helper for PERCPU_HASH map
>
>  arch/x86/net/bpf_jit_comp.c | 16 ++++++++++++++++
>  include/linux/filter.h      | 20 ++++++++++++++++++++
>  kernel/bpf/arraymap.c       | 33 +++++++++++++++++++++++++++++++++
>  kernel/bpf/core.c           |  5 +++++
>  kernel/bpf/disasm.c         | 14 ++++++++++++++
>  kernel/bpf/hashtab.c        | 21 +++++++++++++++++++++
>  kernel/bpf/verifier.c       | 24 ++++++++++++++++++++++++
>  7 files changed, 133 insertions(+)
>
> --
> 2.43.0
>

Puranjay, Pu,

Is this something you guys can help implement for ARM64 and RISC-V
architectures as well? I'm lacking the knowledge of the specifics of
this architecture to be able to do this by myself, but it is a nice
improvement for BPF applications, so it would be nice to get wide
architecture support.

Thank you!
