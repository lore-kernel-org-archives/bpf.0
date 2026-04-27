Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592143A7F57;
	Mon, 27 Apr 2026 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280082; cv=none; b=GqjUUuJ4N6rIifEXVy6vLciSzVzOF+kZhkTsyrudsfmWcaKUwrabqzGbsgk9qanQ7AjyQvqmqVdSXO9a/bc4tQ45vjhA30/gFr8g7pq5ztL79W2T0UaiO9sx3O5av+BSC0P05T7oNZZGswPNOuYtPqjUitHveamORjfMTY5cbqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280082; c=relaxed/simple;
	bh=dgk/faZOLQpUEXsQ40iSJFeDRRavJjkiC5juXZ4aZ6o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=NDxM7xcw0LIn0QXszPLdA6t0QN5GxcV9PS9+4txkt+cqM8gzTj34jEfYDMQnIIpmgCealQDzLUHM2CI8jfMGGAuvvxzP+L9w0UdtO5q6LTIMbFDMZb79DIBELCuByO/NfUntiUj20uVamrqf3M/E8nY1+LagnX5YgD/le40pkeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S6fWitaV; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S6fWitaV"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 32E231A342E;
	Mon, 27 Apr 2026 08:54:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 00C60600D1;
	Mon, 27 Apr 2026 08:54:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3E6B410722270;
	Mon, 27 Apr 2026 10:54:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777280074; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TXqEElTwN2Tki8IktRXTfIVL9D01k/xyxgMf0ctrAd4=;
	b=S6fWitaVDU/VTZT6yPZJGXT7mUzoaUUbLCjgB4vRC3fCgw3YaEa8rUxESSeQ4XM7sjxdld
	w2wJkszlpI/+wJv4VqWfh21mPO0o4KNiRTj9oqzk+O10QqDUfqSImMWvLhCIOcLEjFMtyG
	sUY57bQmm2xTj8ZjKaHYGBs4eCyHXGr/RuUPsVyddOb3ET/DEUbe3cIOjRYxQgYqhcHujv
	mmeRT0Ooj0pRPIPSI9VdRSjRGsZnUXRi8k6doRZ/9vcuXQtb+ezrvE5e+kTwdL2pM/S1MO
	LmYK6n6Izjxt4mzCaSxAD8ryLg7XzSE0B+bbHBjSDcwj2rcfoRc1SPkXzxFAtQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Apr 2026 10:54:24 +0200
Message-Id: <DI3T7A3A3LWQ.1WBAS2CWS2343@bootlin.com>
Subject: Re: [PATCH RFC bpf-next 0/8] bpf: add support for KASAN checks in
 JITed programs
Cc: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, "David
 Ahern" <dsahern@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "X86 ML" <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Shuah Khan" <shuah@kernel.org>, "Maxime Coquelin"
 <mcoquelin.stm32@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
 "Alexander Potapenko" <glider@google.com>, "Andrey Konovalov"
 <andreyknvl@gmail.com>, "Dmitry Vyukov" <dvyukov@google.com>, "Vincenzo
 Frascino" <vincenzo.frascino@arm.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <ebpf@linuxfoundation.org>, "Bastien
 Curutchet" <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Xu Kuohai" <xukuohai@huawei.com>, "bpf"
 <bpf@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>, "Network
 Development" <netdev@vger.kernel.org>, "open list:KERNEL SELFTEST
 FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel"
 <linux-arm-kernel@lists.infradead.org>, "kasan-dev"
 <kasan-dev@googlegroups.com>, "linux-mm" <linux-mm@kvack.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
 <71fb19ff-6dde-43f4-a0e9-5c8cf2ba4ed4@linux.dev>
 <CAADnVQ+ytaX5oq_1TjKC66dnjd1-yh3yjmPrP-kEg5wEvX643g@mail.gmail.com>
In-Reply-To: <CAADnVQ+ytaX5oq_1TjKC66dnjd1-yh3yjmPrP-kEg5wEvX643g@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Sat Apr 25, 2026 at 1:28 AM CEST, Alexei Starovoitov wrote:
> On Fri, Apr 24, 2026 at 4:10=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linu=
x.dev> wrote:
>>
>> I wonder if it's feasible to implement KASAN support on the verifier
>> side in post-verification fixups. AI slop for illustration:
>>
>>   ;; Original (1 BPF insn):
>>   dst =3D *(u64 *)(src + off)           ; BPF_LDX | BPF_MEM | BPF_DW
>>
>>   ;; Rewrite (~7 BPF insns):
>>   r_tmp1 =3D src                         ; BPF_MOV64_REG
>>   r_tmp1 +=3D off                        ; BPF_ALU64 | BPF_ADD | K   (fu=
ll address)
>>   r_tmp2 =3D r_tmp1                      ; copy
>>   r_tmp2 >>=3D 3                         ; KASAN_SHADOW_SCALE_SHIFT
>>   r_tmp2 +=3D KASAN_SHADOW_OFFSET        ; shadow address
>>   r_tmp3 =3D *(u8 *)(r_tmp2 + 0)         ; BPF_LDX | BPF_B   (load shado=
w byte)
>>   if r_tmp3 !=3D 0 goto +2               ; BPF_JNE | PC+2
>>   dst =3D *(u64 *)(src + off)            ; original access (fast path)
>>   goto +1                              ; skip slowpath
>>   call __asan_report_load8             ; BPF kfunc
>>   dst =3D *(u64 *)(src + off)            ; retry the access after report=
 (non-fatal)
>>
>> A sort of inline kasan directly in BPF.
>>
>> There are plenty of issues with it: instruction limit, exposing asan
>> API as kfuncs, etc. On the flip side we get cross-arch support out of
>> the box with no or mininal JIT changes.
>>
>> Honestly I'm not excited about this approach, but curious if anyone
>> thought about this, or maybe it was already discussed?
>
> We discussed this.
> It won't work because we don't have that many temp registers for once
> and second it has to preserve all (both callee and caller saved regs).
> This is arch specific.

This "fast path" was indeed part of my initial proposal. For the record:

https://lore.kernel.org/bpf/DG7UG112AVBC.JKYISDTAM30T@bootlin.com/

in the "Basic instrumentation" block.


--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

