Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBB1390C84
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 09:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415615; cv=none; b=oRj06kdChstuCg8jXT6sv+2AW+UNCyc4Pzkk1QBCtXTREmAYsIt/Z5cXTNHoumMmI3pIrHXVjgWLW/S3grZTFmDwdvdVqC507rsjI0nkdVBp+rf88iLOjE/jypfZFDdOsy6JnbaDOfT/pO1SZlm246pMG+w4dMR8ygmmeiUsbR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415615; c=relaxed/simple;
	bh=SAMsfCqQ90e8Mr+Byud3oSw6Ke4rL+V87eU2pPZa88k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N+5oN5rT4V9pLa61qfOK+7LCxCDrtw1BtIk7ImzGy+VER8MJ0hGoMmCxt8mrR2A7DsmsGpNcf7D/MS2mxg1IscuMhk2TUNe1hsO80XuJSfcQaV3i0VBjaxNCt88rLc601UkWGOTQpcVQ5j+xGtvzi7rB3sxiwQ3QNZKJE583zJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpEg5lk7; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpEg5lk7"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ca12086c06eso2918710a12.0
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 02:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783415613; x=1784020413; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=U/SgXEBGKzfENQtAx4I6q1a9J5/Avyd8/iNOtQpGsWw=;
        b=jpEg5lk7oSOR8QuVpGCdv+GEbyIZLwbvghXBzymnJEEGDUhvrBGaXO8S/klvfvQgKf
         NRH2thClSkI07MDs80Aht6pxn+y4nXZ1W5sOikWlttIqKT29NtlvN/HeVbY1apUGrE4F
         J+8Qrl5GFl94Q4xLcsiLVA61tvTzyoI2ThKya1R35iPg8jl1HVPxsIqCRh4na9NexnMT
         +sB1dYrAfljw/YGiu2m83NvVO9L+tUQJrVxvpCASz/3pXUy2ZP0ltDIbtc1XHpIwSdK6
         3JRLcMw+/FDlriesQ9ikvGFgswL7qCbp5Vb9tHA9d8kj++/bpQjAsYRVa44WFRJMROON
         TlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415613; x=1784020413;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U/SgXEBGKzfENQtAx4I6q1a9J5/Avyd8/iNOtQpGsWw=;
        b=Yn+yv64IvoJ9lVFUC5QMEtLWCn26Z8ZJWoLnnXRDjC9lm5HTj+kXdPD5rPRj6SQCTi
         d3t1nOBkhJ2Wo31Q1SCV6XgRPVkZqm5K8xD5v7/aSOd7xiGCVt4GoKrQKWdDmF+Y/QOT
         oWmvq7FvkDmqCdZhMGaJlrvYFASNCDrcoVPgmhuGJvUHh/Pd9Ex8vpwvN5CA26S8wJV7
         L4VZeivl/3gIA1sJHLzKTzAk6kKstknbxx0XKXyBevzY+77dGIbFkn36OtGf0fVwYPa+
         b8nvoUAbVyeLscpYpM9/pkn7byGY7Wj2YN2ggp0uEL9ZVLgQdwKib/Jc5ALqDABePLEu
         nBYw==
X-Gm-Message-State: AOJu0YwKGU0az7TmPAjEb0ipxs9aPvQpLvOmxY9W/o2ebPSmv6NPWtsx
	azxvMYyXryQRoFu9icu/0mLxvMkvrl+UlZ9LFIe4fVkJnKKCij5FBUjz
X-Gm-Gg: AfdE7ckyvBpHay28Cejb1zGA/2WpvLbLlgGEZEmlA97S6ykpLbYrDU9EvNI3B7pUR4X
	7/mxOaW3nA6jenZm0JcpZL0sUtlSRABn4OIaneujHnj1YyIhqN1wCpu9YdetaKSGXgmta1/95I4
	CKVbFTHiCWudWsAKNAJ9GE2IH5hmiPVIZDcOtnoLK8CQC2kSDNg7VLyhsvIxCXLcREjGZN1z5k+
	hCgAX65dymuyCKtPaQrpX5sMfdX1D1Efj/2yCJirzAf6n6jgzXlaSXVNnvLu1s47hyfCOc07g5z
	5in2f8HLubn8p4s8t4q9EvwBGCDnZrPkhmW+IpFTocysJCoOlP3OGWDUxb4Vx0zCF8OMRC3IF8e
	x8rbB/AciLjqfzJfcKl4zVQQW45ikXYX2cL3iN0joRhijmhLW+71UiMOZy/dttLtq2CtEotQVE1
	exzxST/xyRoLecGqsNeFrnHwy7lBNEtmRIEY0IEXWm
X-Received: by 2002:a05:6a21:7a43:b0:3b2:b1ed:d1df with SMTP id adf61e73a8af0-3c08ee5184amr5383065637.29.1783415613019;
        Tue, 07 Jul 2026 02:13:33 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3a2e42bsm650999a12.30.2026.07.07.02.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:13:32 -0700 (PDT)
Message-ID: <cab476b7a3e205164d43f791d84b0e0b8101d974.camel@gmail.com>
Subject: Re: [PATCH bpf-next v8 2/2] bpf: Reject programs with inlined
 helpers if JIT is not available
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu	 <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, Jiri Olsa	 <jolsa@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>, KaFai Wan	 <kafai.wan@linux.dev>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev, Leon Hwang
	 <leon.hwang@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, 
 =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?=
	 <bjorn@kernel.org>
Date: Tue, 07 Jul 2026 02:13:29 -0700
In-Reply-To: <33d3eb99-ef5a-5413-b2f6-3217b54cce4d@loongson.cn>
References: <20260706040006.10331-1-yangtiezhu@loongson.cn>
	 <20260706040006.10331-3-yangtiezhu@loongson.cn>
	 <abd697d839043d80e0230d2b9ab30b214dfa34d7.camel@gmail.com>
	 <33d3eb99-ef5a-5413-b2f6-3217b54cce4d@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-07-07 at 09:37 +0800, Tiezhu Yang wrote:
> On 2026/7/7 =E4=B8=8A=E5=8D=885:41, Eduard Zingerman wrote:
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
> >=20
> > Imo, the simplest and least intrusive fix is to add a wrapper in the
> > verifier.c that would call both bpf_jit_inlines_helper_call() and
> > check if the jit is enabled and use that wrapper instead of direct
> > calls to bpf_jit_inlines_helper_call().
> >=20
> > Anyway, since this was broken all-along, might as well land as-is.
> > Thoughts?
>=20
> In the previous v4 [1], there is a similar way to fix unaligned
> interpreter panic on JIT fallback path, but it was explicitly
> rejected by the BPF maintainer Alexei [2].

bpf_fixup_fallback_helpers() is not at all what I suggest and is
indeed a terrible idea. What I suggest is something like:

  bool bpf_inline_helper_call(...)
  {
	return bpf_jit_inlines_helper_call(...) && <jit-is-enabled>;
  }

Used in verifier.c and fixups.c to decide whether to inline the helper.

> Furthermore, Alexei
> said "The interpreter has to be removed completely... sooner
> or later." [3]. So if JIT is not available, rejecting the program
> load is the intended design.
>=20
> [1]=20
> https://lore.kernel.org/bpf/20260615025316.24429-1-yangtiezhu@loongson.cn=
/
> [2] https://lore.kernel.org/bpf/DJMRIZ5PDWP4.12OOZ8H881H6O@gmail.com/
> [3] https://lore.kernel.org/bpf/DJN001X0S57Y.18CKUS4NDDQT1@gmail.com/
>=20
> Thanks,
> Tiezhu
