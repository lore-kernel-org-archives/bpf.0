Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9945C41D62D
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107004; cv=none; b=hQS8D5I8ku7A5SJvSeZJUNx6Tfun6Ca8EBChcrjS185JSInN0NUbdqtHV/dgOB2T9IgbH1dWhnSh2QwkxterSNbUKOCehLmyoTVInjRFklmK/9lmEv5ZPT5+eK1F51tf8E87EXlfvKVbApc2o+j3dPkj4ALtsCdrSrAYbiuPyTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107004; c=relaxed/simple;
	bh=j9GQJQzKvcMR+VCSiLR4VIzU/cQ+59f4K6xs5L/YzoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQVKhDJT1BW6XZ/7ql45qF80B9kqlW8/vEONsZsJzL610WK0Vxy7YY+N17hMGf79V/oUpCXyRSfYiwVbCqOdtA+kUFYc84AgmVEl0tPturaNM5k7GkaQu3KcnVD1qpdc/lvpnxyMV1T88zUlaj50AGRmHTzcAMN4N4KyGWbiw9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eyJ0F88i; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eyJ0F88i"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c160420289bso688366366b.0
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 02:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784106994; x=1784711794; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A1ZmhCboRG80lxcYaF433cPODXSJBxTB3W4f2Wh3+4c=;
        b=eyJ0F88ipHm7mrBSfZk5sbVGtLSJL61gfqM4lmBMfcwfbHgCK+2o0CQumTSsH7jCG2
         MhIAXtEF1t6+E0MGfjVdNOBIoSjqjqBbr3p7ZngEHg6h01XrhWlXLlvtypxmKnOdJaDm
         FUDgM08QDUiGzMuSgsg1Rh6vjTpFRmlfzmsyKSXA3mM9skH1ytlWXREnI5pX2KJ1xK2A
         baSMJRgxUenAH1cqQF+ltlf1m25ideXr1y6U2GwDutvv/u5Z3aUvEPxBkXL1W8qr4zCd
         yYNbqLuaFYOPLSd2r9hHyzp0c3NvIeiW8pZUpDN0saakUlW+FNHUC7QVVNGf/Xi0CoP2
         OtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784106994; x=1784711794;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A1ZmhCboRG80lxcYaF433cPODXSJBxTB3W4f2Wh3+4c=;
        b=HloIG9xKej8uZZEnqnXu3a8qoSNpN7HHbwZAz29z43YeHj58XMKQ6GXyieZMwgr2mK
         JfiuNPpgcaSzXLPZVohNb0TwJo6EORrgqAyLe0LuLPu+GEoSLtPu0FSsWe2vk2Bowx7M
         +cv0Dv3m9VOTbcqzCCwcvOZL4PTFg8Rf4GtDuYI9CtCfIJaS+UYlSu4FzFa+wbSZUzSq
         XYharboI8pxeldFIkgvZtRNamvXiCON/EFinkAi1yVjVE8LDMKZ3iECU88UzunDSYsPq
         u/XcZEZZscEEfbsl9KPYdP6xpEeKt+LDjHbUXIil5q7x+ke+hARlHoU5gRNY0lQDgYjL
         /Veg==
X-Forwarded-Encrypted: i=1; AHgh+RoZxynhevv8a6/R0ZG+wuaSLkIL/I+VIGfQCBRXiOhBweOyqvgF9gZnlUwn4a2GNDn7uoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3omt2i3mHOpp7OlZrtQZDJIzx9WSLSkKO0SYPOogwkXQ0oLek
	66BiSSBlui8hVBP095ed6vNaXA03JnNvV5aMauSIKihbh39/iM33yVZd6Jxa8iQBWGw=
X-Gm-Gg: AfdE7clxP2AYDlvf9urSJxz5hLyI7KNuI4jn/x3VxATJPPRLdfSM64Yr9/qQQ0EPTX+
	TBjq85+biImX4k5lphrxPBGKGQkcKuEMZYcvy+/3jBMUYaHbalg0z21TskdTkI9IiqPqImQNXsh
	TsEO1pR/KlsUpIyU0aAWiPfsxhzWitbtSltl0gxv5mq0TFR3s6i3YjE3+id9vsBD5QEutn0W9O5
	pglyE/rzvl59uySZ/mpH4kVhnuiQ8INOtB2rdsnVD/qzgcFvTTWmaKqcBSPLUjW6pB67XDXgnua
	HYHaVkIAxBoccpYz2RgIcOcTf29LaVEyGpR2yQiktyxX1+jFUlBqGbxGPiosxdi9083W9nA1g8n
	UBFu4oHqtWeeFZ/wF7N2nbzumy3VhsKCHvcdoJplVlHRUc9Nb4rcE3yncHlc62shwex3MbhBVjU
	1kpOn5eqq97EWV1c+DbBcTCIu0TXcWXq0E
X-Received: by 2002:a17:906:9c8d:b0:c16:579f:f7e2 with SMTP id a640c23a62f3a-c1667c58e81mr324023266b.64.1784106994203;
        Wed, 15 Jul 2026 02:16:34 -0700 (PDT)
Received: from u94a (27-51-89-168.adsl.fetnet.net. [27.51.89.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3c99fsm130888425ad.68.2026.07.15.02.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 02:16:32 -0700 (PDT)
Date: Wed, 15 Jul 2026 17:16:17 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: sun jian <sun.jian.kdev@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Matt Mullins <mmullins@mmlx.us>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH bpf v5 2/2] selftests/bpf: Cover negative buffer pointer
 offsets
Message-ID: <aldPkgqkV9yq9OFf@u94a>
References: <20260714093846.18159-1-sun.jian.kdev@gmail.com>
 <20260714093846.18159-3-sun.jian.kdev@gmail.com>
 <alcGgfNM94zgydlK@u94a>
 <alcKV2MXI_5dsaez@u94a>
 <CABFUUZFsJsF-C5Z2gb3FkZ7WD=vBavnGdZ7veScP_+dwZLsaMg@mail.gmail.com>
 <488c235db713648bb2f5c90e4389c96a97ebcdde.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <488c235db713648bb2f5c90e4389c96a97ebcdde.camel@gmail.com>

On Wed, Jul 15, 2026 at 01:54:37AM -0700, Eduard Zingerman wrote:
> On Wed, 2026-07-15 at 13:26 +0800, sun jian wrote:
> > > Anyway, still recommend adding a regression test that test access to one
> > > byte before the start of writable context.
> > 
> > The new tracepoint_writable_reject_negative_const_offset verifier case
> > already covers an access before the start of the writable context:
> > 
> >     r6 = *(u64 *)(r1 + 0);
> >     r6 += -8;
> >     r0 = *(u64 *)(r6 + 0);
> > 
> > Its effective access range is [-8, 0), so it is rejected at load time.
> > This is the direct regression test for the negative-start case.
> 
> The existing test seem to be sufficient, why would it matter is at
> offset -8 or -1 given that the read is appropriately sized?

Right it doesn't. Let's just, pretend I haven't suggest that.

[...]
