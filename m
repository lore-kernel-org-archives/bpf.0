Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3672843B6EF
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446940; cv=none; b=jcf7xKKnFTQ9EnCawUWjpAunhWsBRPF4iVnOhu33oZfUK7Clno3xHF1MZLYaFHm49PV8Tp424O7khFhhSc/zTyDYJmzX71PrOStHwNYUVSMA1KvHzNim6/pnFDrCYCGPDejJ1NxI8ZwEbnZPjbCCuni5klvW6go0mfXkX+Nk+bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446940; c=relaxed/simple;
	bh=Z6+XLs0Jh9sCn/dl/thX9TYrWOYqd+dH1E3SOpD1BTo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KGR4I5J9lK4ZKFMm/SljLKoHIJZz9tzCB4NHcrf74uD2B4TYW09P59z9pjKGA3fcrLfMpkthG/CekgA6y29zyFIlDwcDPEJU2+NoBNgAFYxQ68DGpOBpfaqjPCSSMRFlDcXXPre7UHdOsgKNIMulYuJLKdmC+TPOenHdW7x+1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUWTW84z; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUWTW84z"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8454160043aso4496979b3a.3
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 10:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783446938; x=1784051738; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Z6+XLs0Jh9sCn/dl/thX9TYrWOYqd+dH1E3SOpD1BTo=;
        b=iUWTW84z6Q28KAhhuV+ksW+efxIQ1GRluLRS5h3Kb0G/wBVTNXY+498IsAVMRRumOp
         ebhQv/fQZ8fA6IO4pHVRU5xpgZlf+FSOtDT+5cGNNWRXFYjLgl+DOF6GJzV4BtaV+B7L
         9UBz8JQ3je0rfNi+jPreGoUb6COn1JOfCK32keJZEs3UCrj6xzP7misma+8dbfJf8o19
         JY5R/uUYvnOzeGiS+4NY59EfgMCZEh16qz+yLDLpRxMWabZIvdOKUm6/UiXkacIV0OJK
         I05Lq2eL0vQzqujEQYxomM7nKi6RnXD29AbFTmGdyT4Irup7y74gjqth3V/WE2V+Tg/4
         1fTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783446938; x=1784051738;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z6+XLs0Jh9sCn/dl/thX9TYrWOYqd+dH1E3SOpD1BTo=;
        b=UYn6VIf7+fB6gwMirTFDW5n6U8Ur23rE1BQXoOmekkL4UPAKSmBXalD8slBlqyVC49
         WLfaxoj7swkspIIh3d4JN52DjwzNvRnfYJpaAGjLYwf8H1t0ktBwv7U50qTQxc2FE21q
         evZnsfclQQB3g4XAxM8nXfB2IPrECS+MMaiOfR9NqtUsPrdL3zzrhrYUHP1lZjLE5YeL
         bn6dHRlv9SpW0v0AfTA2OgEl36D/sgYsvlCAgOcFy//NWQjDynsSeEM4eAq8W6p2DSZC
         zqUEzln1uPUefmksXKCsBt2Wc5b5YAyrSQeeYTx6jSh7CxguhXqfgNLuzHJrWNkapQLf
         /fwA==
X-Gm-Message-State: AOJu0YzwolbVpxbPc31GzN+rhAx58SBsdairu4xTXixX0tSP5AXf2m/Q
	ywTSj8GaBXsJ1AvyPi9La1shx9HLPk/aqhpDYZoeVph/4rpwXYjMh1NT
X-Gm-Gg: AfdE7ckDUry76MgJVaCOppwGWJpF8RCKi2RQhUcDGBpo+O4GlYQlopwc8YL7b+0p+SY
	QKLAjNZU74k+AySRxydwL3ktCBDDCSUWz0+IMhKoQCSMov/Ock40xKQ4DFTtZz7Y8PI750dk9ku
	vcL1OzC+9uUo4iH2H2w57etiESDGqB5wnWFk2WiJo175zRbO/P1W6W6sZbn9CK7I2E7nl6V0zhc
	edS2JdW8fNiK1ci0otJJh7uDWaoLABAMlO/6Xrzcxi6sg+9K2sB8MJ+s9U/PtoA0BydvAlEuy27
	Q6XVZL8xoMLYSUwGHiQ57CYmqiF/cb2gYUqpqtnSKZMVjI17xsrxKIRh3zRTdbg0EFjhiU3QW/X
	wiDsU2Mfc+sWdXYDkkOd5WO5iAaYXwMG40UJ0FfpEhREe0l0G9SQmz9Yj5VxCIIGjqltgBYgoUa
	gLBsViIBZPLM9fbxyn1SPNrUPZRQpmV0ZdMiPqX7bL/JJS0krvrZ94Z2vOTlicMWQg1oWy
X-Received: by 2002:a05:6a20:d495:b0:3bf:7081:9356 with SMTP id adf61e73a8af0-3c08ecb17f7mr7407132637.17.1783446938434;
        Tue, 07 Jul 2026 10:55:38 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:471b:7d0d:285:8a95? ([2620:10d:c090:500::3:70d9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174892711sm11265443eec.13.2026.07.07.10.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 10:55:38 -0700 (PDT)
Message-ID: <792983909e60289981e08026fe810e03a73f4f73.camel@gmail.com>
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
Date: Tue, 07 Jul 2026 10:55:35 -0700
In-Reply-To: <450340cb-26a4-d3b2-4861-3016f0a08b13@loongson.cn>
References: <20260706040006.10331-1-yangtiezhu@loongson.cn>
	 <20260706040006.10331-3-yangtiezhu@loongson.cn>
	 <abd697d839043d80e0230d2b9ab30b214dfa34d7.camel@gmail.com>
	 <33d3eb99-ef5a-5413-b2f6-3217b54cce4d@loongson.cn>
	 <cab476b7a3e205164d43f791d84b0e0b8101d974.camel@gmail.com>
	 <450340cb-26a4-d3b2-4861-3016f0a08b13@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-07-07 at 18:39 +0800, Tiezhu Yang wrote:

[...]

> Hi Eduard,
>=20
> Sorry for the misunderstanding.
> Your wrapper handles the load-time JIT-disabled case nicely.
>=20
> The problem is, it cannot protect against the case where JIT
> is enabled during verification but dynamically fails later.
>=20
> In that scenario, the verifier would have already skipped the
> rewrite based on the wrapper, and the fallback to interpreter
> would still trigger the kernel panic.

I'm not sure I understand what you mean. The decision on whether to
use jit for a specific program should be taken at the beginning of the
load system call processing. bpf_prog_alloc_no_stats() sets the
fp->jit_requested before the bpf_check() call in core.c:bpf_prog_load()
and that should be a final say.

At no point the program should be processed with bpf_check() assuming
that jit is enabled and runtime is selected assuming that jit is
disabled. If there are such instances now, these should be addressed.

> By using the 'jit_required' flag, we can cleanly catch both
> cases, and reject early or return -ENOTSUPP at runtime.
>=20
> Please see the test log for the detailed fallback behaviors:
> https://lore.kernel.org/loongarch/aa26b3fc-9717-4273-dd76-a0dd6b15ff61@lo=
ongson.cn/
>=20
> Since you mentioned it "might as well land as-is", I will
> proceed with v9 using this flag architecture.
>=20
> Thanks,
> Tiezhu
