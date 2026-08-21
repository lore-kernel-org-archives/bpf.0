Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F4E3148A7
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787280619; cv=none; b=iieJXEWunEsliD9ryuNyNa8zjm1BEJhDMbjNi7QZVUaLdrHgldSbo17YIgiEIlzzIYm4CxhjKBNYR4sUlQP+dF/lW76Kx7CceK3eLGOws0sD3p9nGTJgyrkxHsGzUHuUwugungi0OG/SOrWtt+RsXdOmTp1YS8Um822XZHXp824=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787280619; c=relaxed/simple;
	bh=NZiy0I0LfKDGdP8gcLo+2A+fnvZn6aM2d+SsTHj3iko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IemxO6Swq94RjT00NpjpzdFKuoGgQa7ei90Bh0/+YiMYAvjRkNN6EV2xeiFtJfJfUmNOjaefMYWzvdeyRiPvJdHVLqKTNFdM8pKrTxVOLfKbsMDbRravIHsQG00ZdaN/01OQvGpowY8FUMvXaQopzYoAt2FVy2zT39lfllziUJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvjshYz8; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvjshYz8"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66c2d726650so725643d50.0
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 19:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787280617; x=1787885417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ow8qo7sHcSx/W3utHs5N9xZe+w2Vs/hGwVJrOJRCERg=;
        b=BvjshYz8weIHb9vHeagK4GZ3yQgGRbWkM23zxLFchzn32CrEnyNFiG1zwcCw9J96Za
         pyOyWOJThaqLPuMpoOYVxmRptx3IYZkCNo/3IblJ0zp5bKwXuxqssjBqV86w0CV9MMKz
         RH+VP8gUrPGiTIVsQJ04i9289kp3SmVoCxnH2CKs2nyLvUixQObREi2ql1mlNdVMuFD8
         Yd8N3paZ9DF/NvgkmOXMvnTpItHDPsUd2AHryGkQp+xmdfMsFGYwYhvzNricg/lwTFmv
         3r0OmgjFNI5qwk3+ElCFKplzR+8ynp6ZydEI/LDpE9PWEWoUw6blfK6/XZo04kCM6DTK
         WrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787280617; x=1787885417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ow8qo7sHcSx/W3utHs5N9xZe+w2Vs/hGwVJrOJRCERg=;
        b=CLl4xRcQYpQ0HNpmUfoLkJtRggA3U3RJlHUTCMPOfIPuNNOuNWehSkr9xUxI1HQhnm
         xqHrracKYWBd/tAKLujzgZrTKThlqDSOApX4B2Et8fMix6e401Kx8NbssdT+qcLboWQz
         ne0j7dL6CYV1QREHxNzR3+rqhIJORD3kNYBC9VlVYLihhoIRkyVv9/2yHXkQskmzxdxn
         /qTZ2aqFun4U8eE5PglPTtVH6t9dG63ES9L4YAXMDbKfnGP2scE1Ls9Hx6aEBi/ajtQw
         BuDw2Haq1s8w2R86FiIoQ6M2+Kkbhz3b+PiIRmlLUBjoXe4Z0g8yOCN9RA4mB1ORcIZ+
         BjPQ==
X-Forwarded-Encrypted: i=1; AHgh+RpXof03WHcwKyws4vGJf35gBf7ApHKy7uk5vB99huwnBBaiXQibxjsat+U/pr2d98jVsKQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n/CNEn/9WANG7ikA5Z0e45czIwTVVwAdiZursT+lgGkYEH0Hce
	1nqDyKNVGNDEHH6NSYAIK2TflYn/DXAnf/r+X8iq4+pP/3feQI4HM+qm
X-Gm-Gg: AR+sD10LgnyVawNfNv38eh5nRcHkJibdt8fCw54EN9KTXetmRPtCvdaM1ToWZ7QTQC0
	hsZp7QYRiPA5RgX71MKbz42IwNlSyRj73Fmh3BzuCG7EujJ+gjRI3pvNF4Z7q17Q5opjlCVFw1w
	VvG4V1UQDb7M84rdhE8S13vnxfPhLiRAvM0Tn2EGh3Wi8PcZZ0qP3BI9y0+h12zDNbJ+/l3hXPC
	NeNZ5iYsttEaHZ2boRBZJFElSMj7z3i1SgLtRLpGjZ3Vtiyv6P77Uv1bFFrBXbAtp1yEqXYVpsn
	o3kHvuCxcM1tDhOJ0Xb44xhDHHe/SzT+0vKgcD9/mD7KHOjBpylA4NVmO2yMLvKX1zwr19HRFBI
	dW4sOVmCAjzZjjBonIuDUFta9E3NiBAQW9qMyhpnzU9lzTwyCeZ0jXIayhAfFJFWY5sxmAy9TMR
	/gCMX/IovsNfQ3zdIAoe8VfeW0+ehOBIkYjLaY1TJDC+N6tWgnbfhOwYDBAw==
X-Received: by 2002:a05:690e:702:b0:666:3df9:8643 with SMTP id 956f58d0204a3-66ce4a10b1amr1040646d50.19.1787280617165;
        Thu, 20 Aug 2026 19:50:17 -0700 (PDT)
Received: from Turin ([187.15.143.241])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66ccb144956sm3682195d50.13.2026.08.20.19.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 19:50:16 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	johan.almbladh@anyfinetworks.com,
	paulburton@kernel.org,
	tsbogend@alpha.franken.de
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bpf@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC bpf-next 0/2] bpf, mips: Add BPF_MEMSX support to the JITs
Date: Thu, 20 Aug 2026 22:46:38 -0400
Message-ID: <20260821024640.1601299-1-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf-next is closed for the merge window, so I am sending this for
review. I plan to post this series after it reopens.

The MIPS32 and MIPS64 JITs reject BPF_MEMSX byte, half-word, and word
instructions, so a program containing one cannot run when JIT execution
is required.

First factor ordinary narrow-load selection into backend-local helpers.
Then extend those helpers to select signed native loads for BPF_MEMSX.
MIPS32 observes the load-delay rule and propagates the low-word sign into
the high half; MIPS64 obtains the full result from the native load.
Ordinary loads remain unsigned, and BPF_MEMSX with BPF_DW remains
unsupported.

This series must be applied after the in-review MIPS MOVSX and SDIV/SMOD
series:

MOVSX: https://lore.kernel.org/bpf/20260819010523.1057789-1-main.kalliope@gmail.com/
SDIV/SMOD: https://lore.kernel.org/bpf/20260810194215.3754591-1-main.kalliope@gmail.com/

Applying MEMSX removes a whole-program JIT fallback that otherwise keeps
mixed programs containing unsupported MOVSX or signed DIV/MOD out of the
JIT.

The ordering discussion is here:

https://lore.kernel.org/bpf/CAJZwKkis=3NGw9At0WfiZaRYEoMPbQfqJKN0e+vtRDvp4VY5Ng@mail.gmail.com/

On four little-endian profiles, patch 1 leaves the complete test_bpf
results with 1031 passed/31 failed on MIPS32 and 1030/31 on MIPS64.
Patch 2 changes the three MEMSX cases, yielding 1034/28 and 1033/28,
respectively. Ordinary unsigned-load controls passed at each boundary.

Selector-focused QEMU testing covered MIPS32 base, R2, and R6 plus
pre-R6 MIPS64, each in big- and little-endian configurations. The focused
mixed-operation matrix reproduced the unsafe MEMSX-first ordering and the
correct fully composed result on MIPS32 and MIPS64, both big- and
little-endian. No physical MIPS hardware was tested.

Nicholas Dudar (2):
  bpf, mips: Factor narrow loads out of emit_ldx()
  bpf, mips: Add BPF_MEMSX support to the JITs

 arch/mips/net/bpf_jit_comp32.c | 51 ++++++++++++++++++++++++++++------
 arch/mips/net/bpf_jit_comp64.c | 47 +++++++++++++++++++++++++++----
 2 files changed, 85 insertions(+), 13 deletions(-)


base-commit: 91ec2035134982b98fab0609a9fd8480e8217dc1
prerequisite-patch-id: aa8ca3f50fc4b0160c5fdba43a92e4b7ec3f2e07
prerequisite-patch-id: bda4c3f3d59b48d784ed98bd8558d9591399bc86
prerequisite-patch-id: 35236f563c0536859077709d52b345b696e5c26e
prerequisite-patch-id: c0f282b0e57ecd60e9582fb1e89e4b3112ae7893
prerequisite-patch-id: 4e93eed38f6585e21fc13931c314907b4e437ef5
