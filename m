Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4F0420874
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416431; cv=none; b=gZoOW7Hfaoj0QMoF0Tx/hArxMxkcxPFFETfxtZtOlkXxxwRr0/JkKEG4rpOsCCz7c5e4Ng464oAkqXjvCpjlKqDBAjWx6DvrDz4pabt5wqcopByclYsaY1MuHw7/rZFbOJlpFoOP6HJxWJx7Sp97FnvId/kIGuKU7ddNp7PwZDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416431; c=relaxed/simple;
	bh=R/Ik5SAwXJUrqpt2kvjRGMeAGlzi/WQ932Xmmd0UumE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nhzYN9pvAeMwMn8eKCEwPdEfL0Dk6JUT6vpQywhBwhusp6LS6Vu3ADPWU6e0erbprHpLUrAX5auIggUFt30PJjssdevq6LD7C9mDFIZ5hld5W7baYumksvrCqQrqw0TAGisoD7RH2eaaiXhqwK1V4HCApiJwB8ubXqTtvJ31bJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HP12duo8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP12duo8"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc6ae3e7f1so16704565ad.0
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 02:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783416430; x=1784021230; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=R/Ik5SAwXJUrqpt2kvjRGMeAGlzi/WQ932Xmmd0UumE=;
        b=HP12duo8h5JD6u5uNz//mBsWFsE3SL2oH4AaahqQf+0j/GvDlsZoqF2Q3ia86bItjL
         /gJRMzWivUumOgCrF+e1nc+N88tzFf4z7LWhhLI36Ixddwva0BwCVPwJJ3QCHphqKqtn
         swV4jUnh6Hc9dUYE2zBAEDwD0AIL1gaoxNo/NoxRui7io68IGi9Lj2erioajU4oN5efL
         z0CMXcOj9cWm5Z2wVjGyY/ayMYxl/IclOUUwIMFos4xp/TBWDvhrYglIXuF9XCM+lZVI
         DKMA5XgsvOXVQRuHjAt/xL/xfCG1KXhB+mP9ZeInwwLe0NQ6zKZwZi3XKiu6uGVkIPSt
         SiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783416430; x=1784021230;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R/Ik5SAwXJUrqpt2kvjRGMeAGlzi/WQ932Xmmd0UumE=;
        b=cJ/j2HZCPPkiTDJpNAt6Ja8R/5sWuRXrBUqg6/Gho5LS/7qlDuph28DK3hwlnjjat0
         ffROslSdUUB18H1XeLdiSCPVT/nrOHX90t3nJOS630qzEBD7DdG0CwnKCaT0YCeE4AsV
         dtQqFv3w0JOt3h9K2EfD9M0GTohEAOPZgxBMp468IaUKccGl6I7jyYgrP0+s8vSzRrCs
         g2Zg0aMk+FwjMwgYwtxXK+Zc6scJtGDIsK1EqUo+nRJPKAaL/ls7loRka8aJBo8tGato
         f1zf38V0p9Qlu4e3JdZ8xFz6gqgvUykJ5LBfPIDogQwm4/ILfSkEFXpQSI4dncVt6mc1
         imAA==
X-Gm-Message-State: AOJu0Yz58iJkSjOY0axKcLtJ2496lfiFJ1SL0VM324hYlRncCmaZGitA
	FcWhos4xQDO4kpZbabORBNC8+kYOolpvCPvwrCQluWEwWujwo/6REsFL
X-Gm-Gg: AfdE7cklMP3MqH76p+CR746Etg9EhzliGW74OW9p09fkkDeOFOufuFPeMYPAE/hUU4D
	UMoSm/D19EUYtOxDyOJEfvwL2r/EsnFCZiSbt+VRZv/yzBjUQ9fiY/Jb0PO7duqS/9TkUz2x8lA
	/tXoDx9jrxldLVDtaGULMakcQ+YsyU00LSzpOCHgKngVvf1h//bjgIOcD3feV6HuKc78t9hUh3q
	QKa/s5eIZwv1xQBVHWAmwk7zw5m14TW4EjdLThgFge/ydCUF9I5FdCjA+ls5UWyOVz1iJSG6Vvk
	NpM9Tqfd2TU7CUsDp9paro9ZklQDx/KoFwuypXHim3QHJfwzZ/Cip/ijph9FB+ZRH6+gYXTeu8l
	LDwrRwGBDx8ySIkg7uGSL4upGUXlK3WxRyQi+TCFsSqNjUoz2y0Dd5hULXTy0SslRfd6mwiv9nc
	iL8YhcxDVJTlf1ebvSq8POxpiZn5Z8AALT2sIqX6I4
X-Received: by 2002:a17:902:c402:b0:2c9:bd64:8c8b with SMTP id d9443c01a7336-2ccbee1f011mr49355895ad.31.1783416429639;
        Tue, 07 Jul 2026 02:27:09 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1e1aesm8350915ad.39.2026.07.07.02.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:27:09 -0700 (PDT)
Message-ID: <1c1738784ae321ed5c9dfa0aca6d0f483592713f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v8 2/2] bpf: Reject programs with inlined
 helpers if JIT is not available
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>, Tiezhu Yang <yangtiezhu@loongson.cn>,
  Alexei Starovoitov	 <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko	 <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>,  Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, KaFai Wan <kafai.wan@linux.dev>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev, Puranjay Mohan
	 <puranjay@kernel.org>, =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Date: Tue, 07 Jul 2026 02:27:06 -0700
In-Reply-To: <e86ba5c0-41c2-4492-a316-7693c7d8d3fd@linux.dev>
References: <20260706040006.10331-1-yangtiezhu@loongson.cn>
	 <20260706040006.10331-3-yangtiezhu@loongson.cn>
	 <abd697d839043d80e0230d2b9ab30b214dfa34d7.camel@gmail.com>
	 <e86ba5c0-41c2-4492-a316-7693c7d8d3fd@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-07-07 at 10:03 +0800, Leon Hwang wrote:
> On 7/7/26 05:41, Eduard Zingerman wrote:
> > On Mon, 2026-07-06 at 12:00 +0800, Tiezhu Yang wrote:
> > > When an architecture (such as LoongArch, ARM64, and RISC-V) implement=
s
> > > bpf_jit_inlines_helper_call(), the verifier skips rewriting the helpe=
r
> > > call offset (insn->imm) during the bpf_do_misc_fixups() phase, becaus=
e
> > > the helper is expected to be inlined by the JIT compiler. As a result=
,
> > > insn->imm remains as the raw helper enum ID.
> > >=20
> > > However, if JIT is disabled at runtime (net.core.bpf_jit_enable=3D0) =
or
> > > if the JIT compilation later dynamically fails (e.g., due to OOM), th=
e
> > > core BPF subsystem falls back to the BPF interpreter.
> > >=20
> > > When the interpreter executes (__bpf_call_base + insn->imm) with the
> > > unpatched raw helper ID, it jumps into an unaligned invalid address
> > > space, triggering an instruction alignment fault or a memory access
> > > panic.
> > >=20
> > > Fix this by setting 'jit_required' to 1 when helper call rewriting is
> > > skipped for JIT inlining. Loading will be rejected early with -EINVAL
> > > if JIT is disabled, or safely rejected with -ENOTSUPP during runtime
> > > selection if JIT compilation dynamically fails, effectively preventin=
g
> > > the kernel panic.
> > >=20
> > > Fixes: 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
> > > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > > Suggested-by: KaFai Wan <kafai.wan@linux.dev>
> > > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > > ---
> >=20
> > Sorry, I'm late to the party.
> > As far as I understand, the patch #1 doesn't really change anything fun=
ctionally,
> > it just adds the flag, right?
> >=20
> > As for the patch #2 and looking at the helpers that jits currently inli=
ne:
> > - bpf_get_smp_processor_id (implemented as a function in the helpers.c)
> > - bpf_get_current_task (implemented as a function in the bpf_trace.c)
> > - bpf_get_current_task_btf (implemented as a function in the bpf_trace.=
c)
> >=20
> > It is perfectly fine to call these as helper functions even if jit is
> > not available. But this was broken since:
> > 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
> > from May 2024, so I guess nobody really cares?
>=20
>=20
> Vincent Thiberville reported an interpreter fallback issue for the
> internal BPF_ADDR_PERCPU insn [1].

As far as I understand, [1] is caused by map lookup helper inlining,
bpf_jit_inlines_helper_call() is unrelated this mechanism and only
covers that three helpers I listed above.

> And, I was trying to fix assorted interpreter fallback issues [2].
>=20
> I think it is worth fixing the interpreter fallback issue for the JIT
> inlineable helper.

Meaning that you'd prefer the bpf_get_smp_processor_id() and co to
work correctly w/o JIT, do I understand you correctly?

>=20
> [1]
> https://lore.kernel.org/bpf/MR1P264MB331494502C9D13D8A9EAFB99B7E82@MR1P26=
4MB3314.FRAP264.PROD.OUTLOOK.COM/
> [2] https://lore.kernel.org/bpf/20260626154330.33619-1-leon.hwang@linux.d=
ev/
>=20
> Thanks,
> Leon
>=20
> >=20
> > Imo, the simplest and least intrusive fix is to add a wrapper in the
> > verifier.c that would call both bpf_jit_inlines_helper_call() and
> > check if the jit is enabled and use that wrapper instead of direct
> > calls to bpf_jit_inlines_helper_call().
> >=20
> > Anyway, since this was broken all-along, might as well land as-is.
> > Thoughts?
> >=20
> > [...]
