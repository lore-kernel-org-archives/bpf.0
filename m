Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BC01A6817
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786815576; cv=none; b=A/C1AVIJjkk7/CVd3cHw6ooQtTvB62WV+hYIQahfmoOWyr2f4XPEEBJxNlt4e2Bv4MNsj6BuqrgfdSxdnCbMyH0kgNeTDNatN6tlrepOj7CmEwI0O7jEqSIWe70v32wBK22MdGR9f260iB8DdCrftldlx/5zhWcgPqpzTuXMZTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786815576; c=relaxed/simple;
	bh=L6Ff+isucmwi+fteTERAP2G1U44DL9kK9FEh2vaUOeY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=amFNMODtuCopDKm5MBAr19zcnLNMi36VL1n9sO6hdh2G/61KlFYLJBj01WGzvL+KXDPA7RadLqFMxWdmVjqlkjCZQY6MbhENA1BKBkZGLqxYuEflDapM/dcXqhKnfZxZC1yxdpPF6U+mI6xBCuixCmCGApguJn4TDWAETpjlTuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFjaaFdZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFjaaFdZ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cedda2ce6fso13686135ad.1
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 10:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786815574; x=1787420374; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=or3AL+px49lYDfeSBc6VrDFGFlsgyPI+bElKUV86aiY=;
        b=mFjaaFdZZOpJIDAnc1KfvzJAY7Fu3bVXKuU8cUcDKYh1D/39FlJfw6wfGJ5WLbPOYB
         bb+lc4mTfCKE3OyKmLJf90+dTbfavs5Zx8XMz+oZ3SN6kYDXgnbOCIUIdPctz4BrMvAz
         jFAIT0BQR1x7wNNeZ2szczPG6uOAG2MpzjFgJMb2QOTaTTm18Tbzfb9NwQqhnzdqqqFI
         8Pfqahkpi6y71E2S0xkVwnbtJIHfoALl6YEP5XxVlgUf/t5/QpGe9ec6Lf6kh2+tBM8W
         aOXCufo4aHvoeawqsyonPgy8XTC8p8+Kq649R4ejddkz/uRSsPUe4KUxK8P9JiB7ycef
         C1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786815574; x=1787420374;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=or3AL+px49lYDfeSBc6VrDFGFlsgyPI+bElKUV86aiY=;
        b=fmjrhD2c5Au9COE/+41rwcYgp48ZEvCD9JLRfReC7CmycvjGq4mIXkDeZLmREgheJ6
         KfXndHqlJphncU+8TNK9kawpb4mnXB7q3GFK9+xCuTRS21EnQsfm1az3uOTdJcx1VSWp
         WjQ9jC7gDtwpjJ8CN7SHjOjyi+jNO0iTXRcJxRlpilXh4eMmaRYYqZ1wU9qwGWKFbLhm
         h7wzFScXJB4QPTbkhFxm2SW3t5DVkwO9Xim53Q2eddzUPzXt0m/jl9z8QRmU5Kuez8Lw
         UDQQD7VrA3CzfSqrDLbSih0Erq27q9ujf/bnLkHNMNdikPUGvfkcOlsZxob2FOsZor/G
         vx3w==
X-Forwarded-Encrypted: i=1; AHgh+Rox7KqRkUZjM4nXV753R3DGdNBlaAADBe29TV17jQpdCp3z9/kDTlIvpFvg/kuiieOzkss=@vger.kernel.org
X-Gm-Message-State: AOJu0YweRBuQkYho4caGuF5DHdHoL4CoAd2XcywxysQNKIxz4rDATO10
	mAvCy8HKviX0b5Ii+gYKCKVxiIWzRnz+83sJpbj63G576Q1FiesJ30Ur
X-Gm-Gg: AR+sD10DrkzhGp8tY3p2bGTBBu+aUnHTqwpRkjzSExZFLb7ntVzn78+SCDkEvuji+a9
	JOFtCbFfnYFVqi3Y8wObQTV20wpYUTt68qbarVnPt28QVVgxebCX8hHha2fzRztlW9DcqVk/RyO
	M86Wp8gC58PXXhiPX3i4QdLBN8rYkdCWmoPp/iIDezMN8bF63x1PUOJ7QgzQUMqpFAPuEtXlqF7
	UKgI0uMLYY4tkVB0Ei3PTu4E7a2KE5t1PbyRAY0rlgJwbN19aIpr1gdXeO6Gw9O2LD/QYG5Ukqj
	8+kACSORCTiZeyCImor9maTDVoSRECdDB7UINlx9vnastp3T0IS7TXndHm1uPe906rJebLlSDVG
	em9p3ZzwBe72I13v9jDBDc3WzrYCE5PRDnjA9AIVe0eq8AbZDjatBLH1wbljsmWiLeMwyipanGR
	EqRUbKqz/2FaL5639jN2R48HpydM7AeCA2ZfiHlB960EVd/HaxoO9XcogvGB3bOqUmqW7KBexXQ
	8xs7mlgyJf37vfV
X-Received: by 2002:a17:902:d4c5:b0:2cf:8131:75e8 with SMTP id d9443c01a7336-2d3b0c813f6mr150407015ad.13.1786815574538;
        Sat, 15 Aug 2026 10:39:34 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3ae79f0cesm20917775ad.18.2026.08.15.10.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 10:39:34 -0700 (PDT)
Message-ID: <19dbfd3376729992d019f576ffcc782c9e5eb594.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 14/14] bpf: Report Policy helper and kfunc
 errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, memxor@gmail.com, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 emil@etsalapatis.com, 	kkd@meta.com, kernel-team@meta.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, 	clm@meta.com,
 ihor.solodrai@linux.dev
Date: Sat, 15 Aug 2026 10:39:30 -0700
In-Reply-To: <d02e6a6d3b2dc43a207b8ba836ce62497b250dede9252e7409c5212201c794b7@mail.kernel.org>
References: <20260815064612.378577-15-memxor@gmail.com>
	 <d02e6a6d3b2dc43a207b8ba836ce62497b250dede9252e7409c5212201c794b7@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-15 at 07:20 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 64c5c31ed230..ff028a8c1cca 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>=20
> [ ... ]
>=20
> > @@ -2924,6 +2924,10 @@ static int add_subprogs(struct bpf_verifier_env =
*env)
> >=20
> > =C2=A0		if (!env->bpf_capable) {
> > =C2=A0			verbose(env, "loading/calling other bpf or kernel functions ar=
e allowed for CAP_BPF and CAP_SYS_ADMIN\n");
> > +			bpf_diag_policy(
> > +				env, i, "BPF-to-BPF function call",
> > +				"loading or calling other BPF functions requires CAP_BPF or CAP_SY=
S_ADMIN",
> > +				"Load this program with the required capability, or avoid BPF-to-B=
PF function calls in unprivileged programs.");
> > =C2=A0			return -EPERM;
> > =C2=A0		}
>=20
> Does the operation string here accurately describe both cases? This
> branch can fire for two types of instructions. The loop filter above
> checks:
>=20
> =C2=A0=C2=A0=C2=A0 if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contin=
ue;
>=20
> So it matches both actual BPF-to-BPF calls (bpf_pseudo_call) and
> ld_imm64 instructions that load a subprogram address for later use as
> a callback argument (bpf_pseudo_func).

Wording is fine.

...
