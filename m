Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795823875;
	b=Zp4WkF2wcc5HO7WA9TkSLnotm2EjVSHML67gc3PVlGzcgEzhXaQTmoNX2/3yM3Po6IZG
	 wXtM6tc2B7DNWY8Eq2kdDaJEP/YWRjalT6GbjO3uNbdA0nREmxwaUY4SLpkroT5gNe8hT
	 9NYyLxTN+FyYGxmcPwBRwhqWVEc65PD1z6lshNWY45egPt3Bf4E3IMpBerdcX/iLf79BA
	 7wg8kPX4kaiV//zO+3AE+r/QD+m7EeurN4H84qPA8Hl3i96miSozHZAkJlajQsN+7yBD7
	 oX8F/LYUPLyeRbzu+OAlF5z9XuZPB/cdb9Eq1+Eu4oDSrO0mexmZQWCwzd3nXLzXUaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795823875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=HOeWwMSOTYKZEoz5p7s6n0V8NpIF79oQ9Pl2GNXiK78=;
	b=aVqN2m4qIizl4YU2AnEqkZ1YH+oiwo9Hb9dFHWHFZOPIjj5uoj4hchNkm/JE1ryYBlHv
	 GFcTs2eA2QmDQwb6/YHvaHZ8o9w+f+yPyHcJgP/cvwwCCUQb2gOoLBYDA82ezQrQVt/GA
	 IRkiWjK5XBzS2SL5/VhC5W/UmjUt5VstSKevJR/V8MgIgwFRatI7br+HMqYMKhI7JVRgx
	 J6vT02Ik4+kNy253fy6Bxr/K/HxtY3NZ18xsV9ZQ7aUVhPEvrXr9vo1gX4B3afpVNmfN8
	 Sqgpxhsc0KaYIFPVR/CMrD9rScIw3S0CCxwbiEaM+9VZhHGRmABmD3pBkx/rPqxIa0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MoES4Mli;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAC4606A31C
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 23:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DAC4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MoES4Mli
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b413d04c93so4954812a91.1
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 15:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795823875; x=1796428675; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HOeWwMSOTYKZEoz5p7s6n0V8NpIF79oQ9Pl2GNXiK78=;
        b=MoES4MlicHFbfTELS5EyiLrtl45WOccrlWI+fuVqp/3uSMDAStiNrJG9VZOpqNRsW1
         pr5hheOFRch6+LX57Kg70G/KbzNLoRRAB8GRtDF7U5VxcJgmiy/u48kbge72e2Bp0pMu
         BuowuVC1aaEvE4YKGDve1Itg13F1NS0Y1I8LwqxDaoQTG9O77ePs+J4WXZCW6wgyXe4X
         dGnuUFGXnRLIjs6itU0EQP/CZlWPoTWQfU/KxlUU92WGlxTOdT1+gVIrX9iIbCAs7wp2
         +wGlmlQiFHF9Qoc/AOeXsbFU2adbQhNlzyUVXhEi8iBHLP6M2+KNoTzPAlC32ITU1dvW
         S/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795823875; x=1796428675;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HOeWwMSOTYKZEoz5p7s6n0V8NpIF79oQ9Pl2GNXiK78=;
        b=K+FmktPkSY2T3KpjihavImytMY+DmLtuWkavfmhMPb9nEG6V/BHetIfNen8LP754ct
         XqVhf16QoBpdpds0dlLZIByGOZKdzK/Zl+5fQjimgmrN9RJVfQsxuUfJm95t0AbG4+UG
         uSzcBB298BiSP5PnKhXKCWYHrJb09VBVeVFJ0N3YqewpEUHIW6nu7VW2zhIABY+RRuhQ
         7HISxwu+j2NF9M33sqFTSqw6+IxV10xCpIc3aOodR/P2TIRZ4o9Y3R/+0LdVSHG6dvbG
         iQUO4rfxQ/K3Ft9Rw8e5alLwzW67sGGwZ58VWAaQQQ7zbkS6zG68bCB2tBqUqvORoxOB
         PK3g==
X-Forwarded-Encrypted: i=1; AL+hErFins9BEg5bgheNcCTzsXk197E8y/6AuUVVRjylfwCvkjlywqUoylczbYS8xyhD/t5PhV0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GIUI7C3qV4uKNf9GFBnT47AI5Ykt5l/f12mYwjOxqd67+HU2C
	Waw9HjXcyUSNBF55+oC2sYctS1ypovv0I1d8tW7ZsYjsFi/cZlPOYV4t
X-Gm-Gg: AZFdTZdRlTfbxu2Y8kwHM5ATVTGHPOd9EezTZUdELD8bqjBc1BT2Jp3desCp1QfxX8s
	Mod/PrskHOv2fAZkCEwInTbE1DAod+s+O/hqSpHgcjguUZcDqnIvNr/cPRsS2iX06d8E9FLjlgm
	OvkEBBRycUBlFocV96fvRQsf7eo22yBjGKtdpo9d7pL9RANkTbJWO1fuggwjjVv/jPHbShZ/oo6
	QW9Uk98p6P0a9ZbnphWtJEA3nEjU2CozK2Tbg25SILmVsk839jMG0D89q1PbJZ887axhBU9/8Kk
	nYNrTcIcdW0lzOFXSttL24UK5ayi1pToOAmi0BAWEOZ0wk29Ua+693aiBSL5TlBGfQlvgDdkmMS
	zp9GGfG2Md0R7zqo+B3Z/dSWcLtJxzGviZ5kksu5p0AzRu0guT9y5WC/4iQiMIUPDi8OfFzr+5/
	3uOum9W6jejtx+ARe8Qtg0Hh+JNBWNdAcdDDWlpXOgC5HlLVa8t/r+0fn35FWohigk7GOhn+UL+
	G/6qq1DUkaIvw7vRZwEanxXAdvvnfpJrJBn27ReKPQZpRcPDqfgLE1r2qOXLbk8+8+4c7PC7Lfw
	h52WYQm4Y6Lf7LC4VoEhZTwEcPPA0avmhfWTYORjAxeJNjcB1y2zVftXbgGXZIlcwnrLIhhfsj+
	CziukdbMCqkvi/3EVaAMV13yVL2B56QmU0XYFT58uM5qSzX20cHpDeuA=
X-Received: by 2002:a17:90b:3912:b0:3b3:b632:7f1b with SMTP id 98e67ed59e1d1-3b41c9b2be0mr27724599a91.12.1795823874735;
        Fri, 27 Nov 2026 15:57:54 -0800 (PST)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm40486742a91.8.2026.11.27.15.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 15:57:54 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 23:57:53 +0000
Message-Id: <DN6EFMGS13UD.3T3JBJD0ZBLWQ@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>,
 <andrey.grodzovsky@crowdstrike.com>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <john.fastabend@gmail.com>, <mason@kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 0/5] libbpf, bpf: Utilize CO-RE for BPF
 program parameter presence, ordering
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <almagui@kernel.org>, "Andrii Nakryiko"
 <andrii.nakryiko@gmail.com>
In-Reply-To: <21d38d84-0520-4fd2-ad98-04253d0405f2@kernel.org>
References: <20261125165845.45806-1-almagui@kernel.org> <CAEf4BzbkrVyCSW1aRCo_s=2pxK7NRfUnznk21CY4-txqveRcnQ@mail.gmail.com> <21d38d84-0520-4fd2-ad98-04253d0405f2@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Nov 26, 2026 at 08:41 AM Alan Maguire <almagui@kernel.org> wrote:
> I couldn't find an LLVM issue for this problem specifically, but
> looks like [1] describes things from the gcc side.

Ihor fixed the combination in this PR:
https://github.com/llvm/llvm-project/pull/234280
clang 18 to 23 crash on bpf_core_field_exists(ctx->arg) when the struct
has preserve_static_offset.

I recall we discussed making both args work in LLVM, but I don't
recall whether anyone started working on it.
