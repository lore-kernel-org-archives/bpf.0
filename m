Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A63D33D512
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771609847; cv=pass; b=Kz6+50PdLR1NXc64hSj56GUaHGUjNkCdKEmwCh5B9n9c9rUSMhGrb8jiqmCZDltCbEqLCuEn5Ie3Md3JYC8VTgqcdiASR9hwFDnyiW+FaSA1gMtL5GTY5yqnZuva+VNiD6kdN98/GLPrjnMy2Hj29yryfV+CVKo8v+WdAoYafBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771609847; c=relaxed/simple;
	bh=zbNY7Qy6p+yAvMxGWsPgEuZC3JfRtGQtQzYwmYwkF6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QT73PpOFFQAkfZISbA86JW/qET3/nXikrMeXYkCklFqiP4nQRortPM5fZ6aKOA/zMU3X1llB8gveUNeU0CO+s9ewjGzwl0PHXFg5/dAk9/VSzP58RuW2xN7BeY0ddPCSuC4eWyMdQZCqzbOJg9IZHBkyXn5gIAvol0joVRo26qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrGzythD; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrGzythD"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48371119eacso22595505e9.2
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 09:50:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771609844; cv=none;
        d=google.com; s=arc-20240605;
        b=TvjHReNrGVgP8qVzkjNspSTW8RrQUqSu4PlTJGKJYYjdlMdkxFTAdA5/6Yz5PgamAE
         WwSrut+VzJlNNFkCXh8XQXVw0Kchi4l55NKV5nSsnk5yH2OAYVWtJZm6s8+T3CVKbNKI
         JxvsIMbnQ4pML3SxZLJ1w7eSWigSfsaYBdLBQigbAapiVvEadzyKtZ3AYKyh6WHnB749
         gsIe2cehbzuej63Kp+w8G0NZFea42SD/Z+R2QTAN+EARs4OATpQuqpDqXJanHFobRLaQ
         M5gRk0imUohNV5+e2iPXzbDfhfOJptwIw1Lm0MypmiWaFxd+8oWIooG6Wl5VYQvBWChK
         HBAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RO4uLlKzg+agTjcOCUVy5m78c6Cx5Y93TL1UPBWaM7I=;
        fh=wC3BLpMGc6fdhojeVGF5vxiqXHgiEnEg6+xYRK90ums=;
        b=JLFeemS0fUAjcJwiucEfioxYWlKgsSnXrU+VX741UzHkHN/UA3DJvY2nsalObx3Cdl
         d+m5nBnqm9DGb13svsDQo/LnbzjBcKe8ONN0La15FL2fCN3qHsU1j1gNQJI7Dmk71Q1M
         u+/AiNS5gWE9xawFCRIImdanI43NKmzEGmD68g6yPCGCsKEHXtthCTJqEMRz4lei9SxT
         O/1ADM31akiu2uzQ61ejE4AkUwhSsRglN11on+TOxzARU/UfTMEHSSl3sSCnGsHNE43/
         svkG/j1+DtoCIdQN8wzr7Stiy7qkD3Rx4RgGKG0XIEfWoIZQJ3bSfX3A7U7FA4CXR96p
         FaGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771609844; x=1772214644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RO4uLlKzg+agTjcOCUVy5m78c6Cx5Y93TL1UPBWaM7I=;
        b=BrGzythDzr68lT8P+X+zv4IULDkav/bhr70YF9wtZlpLwODzP7UpPJDcEt2dpLE/xg
         6fuHGy+gMznnxXFeP2cC6/1rxm5Vjar5WUr0a5naf/DlnadfM6eqeeRKYLeMCrzj+pWM
         S+TgqZASFnVjHXSY9y/MVdLL7FQdMXMM7vxUQLbJTapkEkj6RUwhfVlqGH8Z5i02Dlq3
         lAp24c0AAVpL7xEQaEIcDCdU/vsaFmR2jUd0ypGEmL/0SqjKa/9nGIgX9nPrkjAGnypp
         vX6twv3VebpVLuV1dAS3qj/GRvlfdr1cIAe5jGGbTRJ12aZzN4VTDwqsx7XFDpJpubMl
         2xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771609844; x=1772214644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RO4uLlKzg+agTjcOCUVy5m78c6Cx5Y93TL1UPBWaM7I=;
        b=HzmznY677o9Ze3q+BooneoorkYSs9n+3Ih8+zxLGxBmfTZS5omIcCxk0ellBSxHQpq
         JpWKuGh/7pVBy98a3gLq/aziboYvGwb68mkNlShGXJfVMHL8vin/BXNVBSIyfHDOuZbF
         6ilMVirvOQSTsk+ig+eEczy6bXl7z8jZTYvvd+NyuILSiHjR2IKiolVpAbOBP2HEKtHE
         AdXq9K0bKWjE6LK8HrCMlgTZ6xOc/9XMwwVeGGFJO6A6Gz110EtZaU/a4e2vV8snDRIw
         7Ks6/8PMTmYF8is7agy3zsLlksOtLI1BkXHeskr1SZb9yEhjICSU+ocJqDF45bcTt0qd
         JdKw==
X-Forwarded-Encrypted: i=1; AJvYcCUHdwL9Pt5stpCuJc60wAn3LEXGpPTiIilUvDEGUGLNvAE6gVP9HtXUp83Bk5kNTduVM+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIqXGjfqmBKJGm99kwzH9TteazNJvx6hHz1gakH2QCdewQ5WAs
	5FY4LuUP4/6i8QzeHbeHv1iTBSioav36Oj4+61hTjMlqFm6zKPB/DliimYwnSjmeAaKVL2MD9GM
	SEjrlphhywdYsAwhcw47bhaRAMkLpkaCRxQ==
X-Gm-Gg: AZuq6aJ08IO2N+eA7dqqYfcxNmodIlxADOG5uCkTP+OvxIqkvKPpCWZqFmrKClpuLNN
	8meK+ITUUUFvABaA8TAbhcK6YDIAl9omS1rls+OKSS05JthP8C9j6Q9yjvCSO4MPFOkDGqyAG82
	hJuiARPlfs8BgZNPBsDWgtgM6u1GeEVzwzGHmiek2zwIY6itaY5Qlj+KiH+sU0PTVFG8vzITjgS
	H+NmYXUyJceXnEABtjm8skSEF7RUx3KupRcqSXqphwd/6N6ENaqCBBECfqecMtTagQbD90R+SyY
	tv6vG1IN3OPqv2UWXjiBtRrVFvEC6NAeWYZO7JA/X1tQ8LZrFNKUCW0AkqTOVQQJmCnk2TJD7nF
	F1a9hYacj5pZGUCLa2l93i2eEeg==
X-Received: by 2002:a05:6000:22c1:b0:437:719d:a74a with SMTP id
 ffacd0b85a97d-4396f1822eemr1349284f8f.58.1771609844263; Fri, 20 Feb 2026
 09:50:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219142933.13904-1-leon.hwang@linux.dev> <20260219142933.13904-3-leon.hwang@linux.dev>
 <CAADnVQLNmQGKf5S5ZNwHYzScYBhnWFmnzLg=5Xxy4SgYKE3EfQ@mail.gmail.com> <c6c2ffcf-acdf-4bda-ad82-dc4cc1a9260e@linux.dev>
In-Reply-To: <c6c2ffcf-acdf-4bda-ad82-dc4cc1a9260e@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Feb 2026 09:50:33 -0800
X-Gm-Features: AaiRm51uyzLsKizzJvG3f9kn6T1NTHikVXRFmQWXpkFAQIgwLjOzg8dZ0x3Ke_4
Message-ID: <CAADnVQ+iQkvb9-wOchuPrUOneqzx9Rrqto88=R7GUOqih6PhZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/6] bpf, x86: Add 64-bit bitops kfuncs
 support for x86_64
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Peilin Ye <yepeilin@google.com>, 
	Luis Gerhorst <luis.gerhorst@fau.de>, Viktor Malik <vmalik@redhat.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 7:54=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 2026/2/20 01:47, Alexei Starovoitov wrote:
> > On Thu, Feb 19, 2026 at 6:30=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> Implement JIT inlining of the 64-bit bitops kfuncs on x86_64.
> >>
> >> bpf_rol64() and bpf_ror64() are always supported via ROL/ROR.
> >>
> >> bpf_ctz64() and bpf_ffs64() are supported when the CPU has
> >> X86_FEATURE_BMI1 (TZCNT).
> >>
> >> bpf_clz64() and bpf_fls64() are supported when the CPU has
> >> X86_FEATURE_ABM (LZCNT).
> >>
> >> bpf_popcnt64() is supported when the CPU has X86_FEATURE_POPCNT.
> >>
> >> bpf_bitrev64() is not inlined as x86_64 has no native bit-reverse
> >> instruction, so it falls back to a regular function call.
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  arch/x86/net/bpf_jit_comp.c | 141 +++++++++++++++++++++++++++++++++++=
+
> >>  1 file changed, 141 insertions(+)
> >>
> >> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> >> index 070ba80e39d7..193e1e2d7aa8 100644
> >> --- a/arch/x86/net/bpf_jit_comp.c
> >> +++ b/arch/x86/net/bpf_jit_comp.c
> >> @@ -19,6 +19,7 @@
> >>  #include <asm/text-patching.h>
> >>  #include <asm/unwind.h>
> >>  #include <asm/cfi.h>
> >> +#include <asm/cpufeatures.h>
> >>
> >>  static bool all_callee_regs_used[4] =3D {true, true, true, true};
> >>
> >> @@ -1604,6 +1605,127 @@ static void emit_priv_frame_ptr(u8 **pprog, vo=
id __percpu *priv_frame_ptr)
> >>         *pprog =3D prog;
> >>  }
> >>
> >> +static bool bpf_inlines_func_call(u8 **pprog, void *func)
> >> +{
> >> +       bool has_popcnt =3D boot_cpu_has(X86_FEATURE_POPCNT);
> >> +       bool has_bmi1 =3D boot_cpu_has(X86_FEATURE_BMI1);
> >> +       bool has_abm =3D boot_cpu_has(X86_FEATURE_ABM);
> >> +       bool inlined =3D true;
> >> +       u8 *prog =3D *pprog;
> >> +
> >> +       /*
> >> +        * x86 Bit manipulation instruction set
> >> +        * https://en.wikipedia.org/wiki/X86_Bit_manipulation_instruct=
ion_set
> >> +        */
> >> +
> >> +       if (func =3D=3D bpf_clz64 && has_abm) {
> >> +               /*
> >> +                * Intel=C2=AE 64 and IA-32 Architectures Software Dev=
eloper's Manual (June 2023)
> >> +                *
> >> +                *   LZCNT - Count the Number of Leading Zero Bits
> >> +                *
> >> +                *     Opcode/Instruction
> >> +                *     F3 REX.W 0F BD /r
> >> +                *     LZCNT r64, r/m64
> >> +                *
> >> +                *     Op/En
> >> +                *     RVM
> >> +                *
> >> +                *     64/32-bit Mode
> >> +                *     V/N.E.
> >> +                *
> >> +                *     CPUID Feature Flag
> >> +                *     LZCNT
> >> +                *
> >> +                *     Description
> >> +                *     Count the number of leading zero bits in r/m64,=
 return
> >> +                *     result in r64.
> >> +                */
> >> +               /* emit: x ? 64 - fls64(x) : 64 */
> >> +               /* lzcnt rax, rdi */
> >> +               EMIT5(0xF3, 0x48, 0x0F, 0xBD, 0xC7);
> >
> > Instead of emitting binary in x86 and arm JITs,
> > let's use in kernel disasm to check that all these kfuncs
> > conform to kf_fastcall (don't use unnecessary registers,
> > don't have calls to other functions) and then copy the binary
> > from code and skip the last 'ret' insn.
> > This way we can inline all kinds of kfuncs.
> >
>
> Good idea.
>
> Quick question on =E2=80=9Cin-kernel disasm=E2=80=9D: do you mean adding =
a kernel
> instruction decoder/disassembler to validate a whitelist of kfuncs at
> load time?
>
> I=E2=80=99m trying to understand the intended scope:
>
> * Is the expectation that we add an in-kernel disassembler/validator for
>   a small set of supported instructions and patterns (no calls/jumps,
>   only arg/ret regs touched, etc.)?
> * Or is there already infrastructure you had in mind that we can reuse?
>
> Once I understand that piece, I can rework the series to inline by
> copying validated machine code (minus the final ret), rather than
> emitting raw opcodes in the JITs.
>
> I also noticed you mentioned a similar direction in "bpf/s390: Implement
> get_preempt_count()" [1], so I=E2=80=99ve added Ilya to the thread to dis=
cuss
> this approach further.

You really sound like LLM. Do your homework as a human.
