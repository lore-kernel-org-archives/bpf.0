Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8EAE55A
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 01:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773797025; cv=pass; b=PsFtvlkjRrOofgeBPb2ZBAnLp+1Og0UAsBkTwK5YUHgmR99DMa5xY6qGcsTCuurVna2ZSb17E8hOrRJEXQCH1AjWPJqAx7V6/KxtAE+0fkp//Se7RU4LfojwbB5n3dUniqBjvyBOWjDJ7KmNt8FUn+bxj2k/w3zt4KsX0vnfKTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773797025; c=relaxed/simple;
	bh=09d8heTqxwpp/ypC3AJf2DE1WAr6SC1w7sdsJoyhj9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5f9YiMHB2+SeowQmjfbw1y9c42KnUX754fIC8qWiinLN/mQiDUh+7pMYNBkbzznQ5iSBxErTw8zjSJoqjY1vVxvjHJIqMpWPu7eGl0UbDb+skFaMsP2fG3vakUvUo3aX/Kn6t/df1ZcyabAHVorWgsC2Z0fxMBLJXCTqhgucrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhsgIha4; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhsgIha4"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439bcec8613so4874724f8f.3
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 18:23:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773797022; cv=none;
        d=google.com; s=arc-20240605;
        b=MpkNx5cr+VtdUndgxlsw4Pfu7/T83+nR+Auoor93/srCSSv7lPslKyMMZkvJU1XDoO
         tDSNCzp4Kt3JeScW7cwqv1BXr8wF+aFn16CS8SHy1FnkCIVhAsQ9RD6Wk/8g4YIbxdoU
         JLKGgQI8ZL/jw7TxHooz5ekule08QLdsfayzvkW0MqDnIWyE9J06/RVn15EA97Y0a0/x
         FLtumVD6/BrMs17haDTyF2ib9yiceGWfI9WnIlIDZgt7FarAE6Ils0gPbCyOe5hmzBtN
         6Xx7txzN5QicrmMLNjDlYLZaHYl7Bryd2sIaMPWYWtadmRXvYKwugrdOfetGM2EOJfMT
         tXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ji/WQTk/y1R+GsfD6vGo+raZaRh0quTJY4IfUvtwV5I=;
        fh=wwN9NkstWzTs8fFmE7/Six9ut9YG3fgaAc05Dar6gJY=;
        b=Pk/Zgks4o6uIXVDpFSL9UrswNSsE1q+XSNMOUq6r/PIoLQz6/1Do7WDx8NgdSPcoEb
         ytH/eYrbdxpXV3WkRTubbYQLl/Y9ufWOkp3i24CU1P7xkvRb2IWm53LcXqbm6grAi+up
         UJaMZfPU4LzS1SRIQ5kDre4oW1OD8mG/Pg052UmVN6BIpt9DD6YObJWgHHbEmePolVMf
         jZr9ErDvcCsGWZQhF8qMp4AVb1y4FOTdmbukgOgJA3HIIPYqGqUSVGFxuxY/Yv8juj7v
         MXAxzfLqbjnpLo2BGJKv2iM1hjz4hs7/rf77HKozGD1sU712SBRVr42i9myjkYDwq+th
         wqaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773797022; x=1774401822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ji/WQTk/y1R+GsfD6vGo+raZaRh0quTJY4IfUvtwV5I=;
        b=OhsgIha4I+bDK0XCgeCu7Hm8hC93FtJRflUoVLr2Zb4OLxGprfDQAwRvEawEaf42Fx
         LLT1DixaFjILcz89WSrmmlb3DhcjpF7ffElHs995F3sW4HA3Vu8KydW9Agwtop1iOjMv
         sGnT/YXoOTywlJNiNRdKiC0cMKE2KFR0j0Ilc3wcmSiwbq/aFd4RxFq5H7TN+J5lAbDU
         n2rwvIbMaVhmEQqTKwHXYxEqSuqfNQ4iydxJ/3eWTpV0ABqpYGCpk3DxIp1Vs8ZyFEqU
         d0zcf+l099IJOFLr5IbGKQNMTGTKfQACksEocAVuereh7xbU0mIaaXxMKTyytPUVIFjP
         i+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773797022; x=1774401822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ji/WQTk/y1R+GsfD6vGo+raZaRh0quTJY4IfUvtwV5I=;
        b=bGxxj09w/ylmpwCz/bkK+7kP7U6FQ1guLZfGtJQM0ULufpWDC4NeKT6f7gIMzgtAW/
         gLpt4gykgu1QWISiSOpa7maXYUNRdw/W6PnnLvPZUHV5F4xreiG8sbfbekQi+itGQE/j
         cIpbK8Ux5765cMLMiiwnPvnoRVRKstMLYq1n7Zq06GccDTjSV8KkUvKXVO0udn8PdI5u
         pIs9DJWiacHBTg4HBAccZSi9BkZorUVSDyjMHl2BVs3DxhEVWZpLLnmo3uNyQrQx5b4B
         +WHByIRlErVR6aZV1rBAdINP42VPkY5lyRqrXKbj2vYaXnDwGx+zFnBu8RorPrkXGwZZ
         3s+w==
X-Gm-Message-State: AOJu0Yw8qt40qO5Y/IkvQsxsL9cYQSqr6jYkVur3t8xoHDbaXsOCN2Kf
	MXcZrQSbj55V6SNjAcX79QLbcc0P4pINWylNZ8lADSy9UtDnY2RqJ3/RyzhAXzGy0RcMi50/ewi
	F/2ym4hjzcX7fnT+6wvMxDJaxxDtD2wI=
X-Gm-Gg: ATEYQzx3tOM7TnSqa4D+jP+J60Me+pKc4b4Ioln4CTZdyr9IyzMKQQcx8sTgt+HZXlC
	CiddnMZdoSMTQZHAyiMvAMO+WGfxFULr86NLZWXbFZ6qk0mhGWJ0xilh45UO+XjaChlqu80XDJJ
	ITgCtj8y2bY1OLDynMyPxsadvQlEjKr4BbkWcSyEnVlRAkqTF8bIwa6o4OaA52cLCF3P85py4U5
	/GIeBtQsd3mdU3MBSgu2x5M+J7IHamq/zdKzHg3aTLeBikQidvIIYmnddbCK+v9kE/D4xxNJPEx
	aQrG6F2pcWk5vpy/RCZjvqwqkxNPRlZFydViYp6PUL2Fm+M0W2fFl5ddg1xysEUzlFfyLx7PRqQ
	KGcOVPEHFVoHPZSnjo3ZTrTK+rg==
X-Received: by 2002:a05:600c:c491:b0:485:2fc5:39e with SMTP id
 5b1f17b1804b1-486f44635e2mr26089625e9.27.1773797022142; Tue, 17 Mar 2026
 18:23:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318004118.1780755-1-ZeroXJacks@gmail.com>
In-Reply-To: <20260318004118.1780755-1-ZeroXJacks@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Mar 2026 18:23:31 -0700
X-Gm-Features: AaiRm52brxzGL4b2qtWNdBydx8H_j8X4HXnaS10zEgMQbmKNfbb5Cx87maggj2k
Message-ID: <CAADnVQLL1ZwytKKMcry0AaEU2-j1LzvSm9VorLCriwuo=B74hQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: verifier: fix integer wrap in
 regs_refine_cond_op() BPF_JNE case
To: Ibrahim Zein <zeroxjacks@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Menglong Dong <menglong8.dong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 5:41=E2=80=AFPM Ibrahim Zein <zeroxjacks@gmail.com>=
 wrote:
>
> From: Ibrahim Zein <zeroxjacks@gmail.com>
>
> In regs_refine_cond_op(), the BPF_JNE case narrows register bounds
> without guarding against wrap-around at type boundaries. When
> umin_value equals U64_MAX, incrementing it wraps to 0, producing
> an inconsistent bounds state (umin=3D0, umax=3DU64_MAX-1).
>
> This can be triggered by constructing a register state where:
>   r1 =3D unknown_byte | 0xFFFFFFFFFFFFFFFE
>   -> var_off =3D (value=3DU64_MAX-1, mask=3D1)
>   -> constrain with JGE U64_MAX -> umin=3Dumax=3DU64_MAX, tnum non-const
>   -> compare with BPF_JNE const=3DU64_MAX -> wrap occurs
>
> The comment above these checks incorrectly claims this boundary
> condition is impossible. However, is_reg_const() uses tnum_is_const()
> which requires mask =3D=3D 0, so a register can have umin =3D=3D umax whi=
le
> tnum is non-const (mask !=3D 0). Remove the misleading comment and add
> explicit boundary guards to prevent wrap-around in all
> {u,s}{min,max}{32,64} variants.
>
> Fixes: d028f87517d6 ("bpf: make the verifier tracks the "not equal" for r=
egs")
> Reported-by: Ibrahim Zein <zeroxjacks@gmail.com>
> Signed-off-by: Ibrahim Zein <zeroxjacks@gmail.com>

Please stop resending incorrect patch.
Instead please create a selftest that demonstrates the issue.
