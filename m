Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793298232;
	b=0qp/zDsOanQV79QQfdOXnvKU7rFUP47jyxh2WXOvb1ccq24KUa7A0W2F57JgxMhcbNjj
	 uvGeYOjpU3JLmjfb1eYBjWX7hevAO5BLMCNC84VuZ2CaqTXkA+sNLlQPLnSqvgpzdmStq
	 up3YM/lMivTtxT05b4cYB6Q27xlhciVZX0NlJ+0oZ8WUSFPrz1+zJ9rubRkMp7R7facQC
	 vKP4iu6w0bp0zKV0vngplIfkzl1EXIJyIurDSaDWSmkhUacr5/ddPcJHhwwmlwyIyz2HQ
	 r3iINhrB9DhQb9Ec9PHtQmthUkuNt1IGnvU1tgG9aNDgeQdxTiWi/mU9+XGlVOsTvMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793298232;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0kPogFiW6B5fuv9DVpnabZaqR2Qn/IyW3R9/wzN8wTc=;
	b=Ldf6c25KpfXZwofzShFu/1i/CX47C5Q5co8Bri8YXCvNqfePzxEPOgYEayQDt3Nriw9v
	 Cn1a5B88/raWozCJOL5eS7H41mflYoSRPZVG/nVT7DCM+FWIDZOwiK67dWYmaC2mo7Mqr
	 WNHwBQ0+oY1oZx6ewfOdfHLT8gQ+DTu8dk01LtkMVQA+fedjS5go4t1X2eKu6zP8SQ4PM
	 rv2ue/R88Fdt4wlUOrLz36g0znq3RS96quEQJPs/3pG+LSXUTC5TNTd2GVLzp4VxQOoMI
	 tv74dOFdLMHbIWE42ADLsk/fADAau52u8XlQzV/tTnFVeJvh5PQy+ByQAZ3JBc1ED0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DxY9NYue;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618FE606A31D
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 18:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 618FE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DxY9NYue
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-533202fe429so46211cf.0
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 11:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793298231; cv=none;
        d=google.com; s=arc-20260327;
        b=S1G7d+/dQUwnp6JVbKGm8pdzdQyNz2RNSrX4cWT09NpzaJ542hO9y1Ep4FiZDG4tg2
         hXVNpSWi/q0d1QQuEquKyPR17qddEgBic6x2mDC6fkE1mN7VQtLNuklQ/g7Tmqm+k2h1
         Ivn6QkvbZ6p7FvAvOl+SnuVJsTAPt+MSULW1eFYnYx6SQ8OK89gu0ne1Y+vX8Xl5dr9T
         XRwpKBfZm2a+xom2zgjG05ktNXniBNUfRCM63zUeIftaNRnpqCCXBv6OUo1nwsuXRfj9
         8G/DGh98CD3fsLKRcebFnoWTtP5/nTF2vp2d9y+bt8wPoGpXXWkmaZFNAwBh7Mb56jHe
         W4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0kPogFiW6B5fuv9DVpnabZaqR2Qn/IyW3R9/wzN8wTc=;
        fh=+2XRl8ItqVU3FDntDve8gwBhnbtH24lhEcA6DRoMxHM=;
        b=nkHasKcSJyqhn/aVtFMhSTGx/ypq3+pwjsWsmhKB9GS7rNNAc4rVESameSJfLwdB2B
         DvKPtHeVdTBdqEvLoSKaTtf3VNCm/bRTmYCuwAjX7ONRLfdTc3l07qbtOoEo60/1cOKT
         BvUw3ziEUfo/KWgwFr08V7e7QRkizATNHIIYMPFYoO2rs3f0KjIgSl6cFWzwxc6JQGkG
         0wK9mhgB0G4GmoWTgzwMIoNknl1hDGFITlQB0GiEaJgawPnJvB7LY1lPUzaoVP7IBLjc
         EtNnr36BnzL6CLv9BT6PSAIYgappUymtQ98aWUwWxF8dm+TmYAT8VNDXl3womTm18Npw
         hVrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793298231; x=1793903031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0kPogFiW6B5fuv9DVpnabZaqR2Qn/IyW3R9/wzN8wTc=;
        b=DxY9NYueYpPUw54/1LuKABfDp60AROnzubbbXy7OzS6fWMrILGyAPx+k/TBUzTDoQf
         0+estVcf3DGr+NqskgZltpKjiTwBj0vHxfiZlAv1hdCBqEV+qUGB+fKraqRqaZGJI9Ad
         aHuqa1XDAyOvsrzYt4e2fwVCkmevUnXplUQksj+fp6M1ZkXl+zkUCRvmoFsMOA3v0kwz
         Qz991YYvpNKWfDlgqHmAUX1bJTSVeq5mbReuEAT3YssNt+yd0jN+OmcLTEbZqe3twO31
         DfUU2J0jeNSxbzemGGGlU75TQqjY6sTlc87Wxa++VyWhSCCSHud20YoCA1co6FakOgHn
         lsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793298231; x=1793903031;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0kPogFiW6B5fuv9DVpnabZaqR2Qn/IyW3R9/wzN8wTc=;
        b=0O/W9GrZQUtEVOCk9PMb4Z1kkOCQaFt8+PyPlnTYYTVQKpGRuNskjYTWcj918KFZXs
         v/gSEqcRULORBWXN6cX5skRwTLAUlhsAu2hvZDFwv1I/pgJkGmOGR8s5rlkr9JiaMQ+C
         j/WRqRvnA+yQo6bmwyYtJw6Qt9CQO1/SnUHSMzoMquXzM4qhqjVcF5erPqOckzhD6guM
         uUhea99jrvuEBU51jVBGECiXozciVMv7SbV1RlIlHf4wZa56/5LppUCheG8ySfSQB9RF
         VaesUoP5P/eBQqGeMY2vX/dcVEMkpOc9RepLEb/JnwD4cM1D3HWlk2Pg7widt+pDxZEX
         CERA==
X-Forwarded-Encrypted: i=1; AKwUvBxXWO70xTx1jBoqjR0IgO7M8Xds2INxxnt1kAnPXFdsnbz1w4qPMANpVLDZZhPmkvN5Usk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKW/61fWh/VqulDMtRDqj1D5wxYqJdA8FNMKM1PwlR5rw42s0cD
	td/hevLj7eb5j1yQkaVP55ckUxROIQgVs5rQcMjShbvzf6qd4lfRKgGdV+4Yeh0HEoJumkCFC9t
	LRQHJa8xk0gNMo1IPHb1YPCnkVlq0IDn+TRyR85Gk
X-Gm-Gg: AYBFou3Z7TtWJkTPfjrfJ+HJeWGw6ucb7Kh/7Z5oxAhM1UadVNucXA2TLmaLxDR79gB
	KRW9iaqI30mZu59kNdxTbYgXWmzkhDGQWJJ4kfcK9U4Ndwh9shK8Jt6vFJkXv9ChwjG+qca4tun
	xHAVZQKI5yChUnNFVgmvEovJhX6FEpbVMF+LMwSNvhLGoPBYHo3pNMXOfZtYvi4iNcnB07CKsnT
	OOlnQNcX0pR6YP4Q+RX/qctuOrUkw0pA0GBe27d0tcakz/21ikDF2f9/DasF/Gryn52SDB9jaCq
	piV8QmAi1WkhMusvZwX+NkGXH3T2aBQYtnhskxfNZQFo26Q27TkIR3sGyUxYiK6/Ge4csbTT4FT
	HuqGMg4XzhFEhcJgBMp4fFHCyL2cGDEfEjzRd+hRiAG1MHUbvPR30Z44kI4pkjR5J6Q==
X-Received: by 2002:a05:622a:2b45:b0:532:eff8:3491 with SMTP id
 d75a77b69052e-5414ebdf590mr23748491cf.14.1793298230692; Thu, 29 Oct 2026
 11:23:50 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029162958.3224280-1-irogers@google.com> <CANiq72nrhqK0NP5q8_G=936++gZR3=zrES+cK96T95-ThVTpbg@mail.gmail.com>
In-Reply-To: <CANiq72nrhqK0NP5q8_G=936++gZR3=zrES+cK96T95-ThVTpbg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Oct 2026 11:23:39 -0700
X-Gm-Features: AclHuK8I2R6ZBL0M8gpXX54gY1Y2jQq5EjXVV3xSH1Vs5_u0FZ2MTRQeP10WsJs
Message-ID: <CAP-5=fU8K4as51_Vi2vKAC-kGMVEFn1LDjCg1WvP8R0Y=8SbcQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/3] tools: Add Rust library build infrastructure
 and prefer zlib-rs
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 10:32=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Oct 29, 2026 at 5:30=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > 1. **tools build: Add Rust library build infrastructure and zlib-rs fea=
ture test**:
> >    - Adds `tools/build/Makefile.rust` with helpers to locate Cargo crat=
e
> >      sources in distro (`/usr/share/cargo/registry`) or local Cargo
> >      registries (`CARGO_HOME` / `~/.cargo`), map `.rlib` prerequisites =
to
>
> When we were discussing whether to vendor crates for the normal build
> or whether to fetch them locally from the registry a couple years ago,
> we discussed approaches like this one, i.e. picking a version from the
> registry by folder name etc.
>
> But that doesn't work too well. For instance, the graph of
> dependencies may change, there may be several versions available (and
> the highest may not be the proper one to pick), there may be different
> major versions available (i.e. not backwards compatible), they may
> change the build scripts, etc. Even picking the highest major wouldn't
> always be correct, from what I recall.
>
> I also asked a few distributions how they felt about it, and they
> indeed said that it wasn't a great idea without querying properly the
> registry.
>
> So one should really ask Cargo for the right information about the
> local registry (i.e. offline). It has been a while, so Cargo (or maybe
> `pkg-config` or whatever) may have better support for querying it
> nowadays too -- I would suggest checking that first (e.g. `cargo
> metadata`).
>
> I think depending on Cargo for this, especially nowadays and for
> `tools/`, should be fine (we were considering even back then and for
> the normal build).
>
> By the way, checking Cargo's cache sounds very strange to me: that
> means the version that gets picked is even more "uncontrolled".
>
> I hope that helps!
>
> [ In the end, for normal kernel crates, we decided to vendor for other
> reasons, e.g. we wanted to pin the versions, to customize sometimes,
> and most importantly to avoid any possible user misconfiguration that
> could lead to a subtly incorrect kernel. But for `tools/` it makes way
> more sense, of course. ]

Hi Miguel,

This is great feedback, and it's why I thought this was an RFC series,
rather than a full blown series intended for immediate merging. I
think the other obvious point of contention is preferring zlib-rs over
zlib. I'll incorporate your feedback into v2 along with addressing the
large amount of feedback Sashiko has given, which may become
irrelevant if we trust in Cargo more.

Thanks,
Ian

> Cheers,
> Miguel
