Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436311F1537
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 03:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781926188; cv=none; b=e5xUCYZf8VyR7fIqMTsCvMALYbjfCEfSYR+FtqijmEwS7TfW5SrDqzZQtjCSMBDbtly/N99C1MCUSHRorxHlVqCsvdeadShS/BB14HMSvGP8SeCkooSMP9sMLo3cr/jyfj5X+Sh/DvkMbSna+kVDt5v+243mn3a87SqRszdJA0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781926188; c=relaxed/simple;
	bh=V4fEGk23ufHa6RDD3ITKwuQgnoDx8CZs/Ah+IFbxtfM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eumrAN0CLCWR5znT0XRGUnXLjva4rWEJ2Fnica0cxy8R/oPum1lmPhpMqlW+rwtXYWmZlnd6qWEI+exVImAnAr++OGECA42saEVQmEYc0EJ8NcOTGSUIFipluyj+o7nM0C0HBSEz8XlmGgCcrmknyr9+MyKNbEc9BXaGgpchOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0CC6auw; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0CC6auw"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-43ccd4f6f6eso1837405fac.0
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781926186; x=1782530986; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TnvN+8UuJTY/MiJiIrk1qDxzqryb2D2zBpSi70DDYw=;
        b=e0CC6auwM1CRGR3O3gQUSvT4f++0PbcZBaB4LaYLG0BhcJmYenW8nhf+uGJyz6t+gA
         eijtyP38SqBIHzuSx3kQzW+Nax7Llro6jcHaoD/we9yNWCihV6ozNII/ns80DFg0xZY/
         YWO4jkXqv9elInO3wDifLItkjUC1Hi80TM8jgsx2WYMyL0p54gsAo06Bl60+Pv7lcLds
         iauwtp4TIbIkQgYkxT1aHuDpXwPWNJrLKzWLJMaD+TqGAJqsP12sav1qGN/pHoboswKI
         Y09tZD7HP5ZjVFCj8T6oZcKOs3KqmgcrvUASnXoNYZBYX164Poigk/yUQH/iyB/0dDcf
         fhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781926186; x=1782530986;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+TnvN+8UuJTY/MiJiIrk1qDxzqryb2D2zBpSi70DDYw=;
        b=e85fAsJBqa18B+ODcYjOGgNP6ijUVSQK02YcbPLrLVd3Y4/vrJgTGhx/jQqwVMEMTO
         RVIHxaXrMw2rs3bwBnp8GmFqsw+DMyNkia9Ni0wPaG+cRSueU/6ZG1owtB5ARewe1TfL
         SIQeg+j5NR5xnK3ao46baGuuAnNNpbX7GodtgKlg4yqoDLFcQg1RNPIL8TfoCwnMR+B+
         iS0Bj/dCHe7S2yd4pkIRo5T7b452mqcr0qzFcy+YbSwCp+09UVy1XsG+H+EeFS8ibeRf
         RPSYkndyb+j4mwxCTlbL1/+9dJjPBggolLPpjkF3hVL3WcHJWzBNKgu4TzOSefelEoLI
         w+yA==
X-Gm-Message-State: AOJu0YyuswcBmugtTaVeYL+/yj49T/SOmt4y1dyT+WqxGsRj7IN7I2nE
	j79s6dwmW3PdX62hl0FWTqlEOFKeVvW9HPS1OODbhJE3juAIQ2C40Fqo
X-Gm-Gg: AfdE7ckGNt75u5BcxZSuzxOAahh6G5DgUsrnj0e1l3taGrD/JlgLliYNoVtDE5sRkMx
	voOvZwQP4vRtnuytpwxsGrVD6yMowXGx24EmY0ZZml36fqGRXueF+9zDF4SRDIBIHUy/Jo/7UZS
	poQK1fMDGTrP/b4gJhShnL39MELpvNmJSpr9yJjznzORakxFL4pc7SDuOGtdtS+0HBs10+6gweX
	QKkNvYFK8eAB0/U46UUeO3EnF8tWjVS6TNB1EVUHS8eqKuoal49m5NYJztvsQ6OLeB2XbAAqKzd
	528FmEob/RBIJJAox2DGXiZ7Lzwjj0/YI5TPDPdCmr0mXggrjtemlv1qfS9cA+WnPYMBZK4Xbj5
	tbvDJMaK/iKdAf1HlkRxY0MiOrkabACQ1O2sgWAAMggOPwr34MteEKsjWil+xohv9HsIaCb6s9s
	LGSwGbk7wkI898nf9RqFyhLmI0sW/KlTmrSnSxIRlvkIdzFa+KyIeqRLJWdmoSOxzQSAl+9wrO9
	zLy/ww=
X-Received: by 2002:a05:6820:81d3:b0:69d:fd96:c3e with SMTP id 006d021491bc7-6a0d8d14caemr5089817eaf.41.1781926186124;
        Fri, 19 Jun 2026 20:29:46 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0e9da0e34sm1194869eaf.0.2026.06.19.20.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 20:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 20:29:43 -0700
Message-Id: <DJDK43Q9Y1RJ.3SDUVLSC5I50E@gmail.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Quentin Monnet" <qmo@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "LKML" <linux-kernel@vger.kernel.org>, "open
 list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v6 11/12] selftests/bpf: Add test to verify
 xlated insns for global percpu data
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Leon Hwang" <leon.hwang@linux.dev>
X-Mailer: aerc
References: <20260615152646.27639-1-leon.hwang@linux.dev>
 <20260615152646.27639-12-leon.hwang@linux.dev>
 <DJ9XY0Y2D2R8.16S9E0QFFMLQS@gmail.com>
 <d9eaffaa-6bbd-4af1-97cd-e5e37917c526@linux.dev>
 <CAADnVQLnnSrHDbw4OQCPrXz38wZ15PC1HuS1-aSB7LZxOQhd1g@mail.gmail.com>
 <b1efbbb0-d2ea-4050-aef7-e35db35bd8d9@linux.dev>
In-Reply-To: <b1efbbb0-d2ea-4050-aef7-e35db35bd8d9@linux.dev>

On Mon Jun 15, 2026 at 9:33 PM PDT, Leon Hwang wrote:
> On 16/6/26 12:23, Alexei Starovoitov wrote:
>> On Mon, Jun 15, 2026 at 9:19=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev=
> wrote:
>>>
>>> On 16/6/26 05:29, Alexei Starovoitov wrote:
>>>> On Mon Jun 15, 2026 at 8:26 AM PDT, Leon Hwang wrote:
>>> [...]
>>>>> +    ASSERT_EQ(ld_imm64_xlated[0].code, ld_imm64_raw[0].code, "ld_imm=
64 opcode");
>>>>> +    ASSERT_TRUE(ld_imm64_xlated[0].dst_reg =3D=3D ld_imm64_raw[0].ds=
t_reg, "ld_imm64 dst_reg");
>>>>> +    /*
>>>>> +     * The xlated instruction has the map ID in imm and the offset
>>>>> +     * in the next instruction's imm. The raw instruction just has
>>>>> +     * the offset in its imm.
>>>>> +     */
>>>>> +    ASSERT_EQ(ld_imm64_xlated[1].imm, ld_imm64_to_u64(ld_imm64_raw),=
 "ld_imm64 off");
>>>>> +
>>>>> +    mov64_percpu_reg =3D BPF_MOV64_PERCPU_REG(ld_imm64_raw[0].dst_re=
g, ld_imm64_raw[0].dst_reg);
>>>>> +    ASSERT_MEMEQ(&insns[idx + 2], &mov64_percpu_reg, insn_sz, "mov64=
_percpu_reg");
>>>>
>>>> If the point of the test was to check that percpu_array_map_direct_val=
ue_meta()
>>>> computes 'off' correctly then it failed to achieve that goal.
>>>
>>> It was to check the 'off' and the mov64_percpu_reg insn.
>>>
>>> To avoid relying on the insns loaded from ELF obj, use raw insns to
>>> check the 'off' with a percpu_array map:
>>>
>>>         struct bpf_insn raw_insns[] =3D {
>>>                 BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0),
>>>                 BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0),
>>>                 BPF_EXIT_INSN(),
>>>         };
>>>
>>>         skel =3D test_global_percpu_data__open_and_load();
>>>         exp_off =3D offsetof(struct test_global_percpu_data__percpu,
>>> struct_data.nums[6]);
>>>         raw_insns[0].imm =3D bpf_map__fd(skel->maps.percpu);
>>>         raw_insns[1].imm =3D exp_off;
>>>
>>>         prog_fd =3D bpf_prog_load(...);
>>>         err =3D get_xlated_program(prog_fd, &insns, &cnt);
>>>         idx =3D find_percpu_ld_imm64(insns, cnt);
>>>
>>>         ASSERT_EQ(insns[idx + 1].imm, exp_off, "exp_off");
>>>
>>> Would this achieve that goal?
>>=20
>> Hmm. There is nothing like that in the patch.
>> What are you talking about?
>> Some future improvement to the patch?
>
> It is future improvement to the patch. Sorry, it is too far from the patc=
h.
>
>> My question was about the patch you posted.
>> What was the point of it?
>
> The point of the patch was to check that
> percpu_array_map_direct_value_meta() computes 'off' correctly against
> the 'off' encoded in ELF obj, and a mov64_percpu_reg insn should be
> added after loading the prog.

If that was the goal then it wasn't achieved. Just test manually
that the 'off' is updated correctly and skip such selftest.
There is little value.

