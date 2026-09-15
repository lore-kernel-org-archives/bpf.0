Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79F43CF213
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 02:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438437; cv=none; b=EBkMp7UecooU4OSIwYmHLe1VCL15fkmqSyimgdRhlzOjkxkKLaPMatwRdkrNlWfYrFcJD91kjtZOF04YVJCQ9eTHMMzQbk3wotEOcWp0Ka4C/sPIx5S1nTgnkpeI6PfEWjebctY0M/0tUerRZZZRzc0NCS+dy82pICXa/z7YGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438437; c=relaxed/simple;
	bh=y+uYInbziz7BukzjjZRe+/5QWjiVg8yit5JpoFjSCf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TG7uzXfNBnpvdtk4M7FVArfXp9k2WxaMFSl10sXcVQQhRyF8yvwn8iHEv97DbkF9mRIDSgSA+SEF9B4RWiPatH+Mpxr94gQBr1L9Pdwnyw/ZsXMm7FvwJN4EN+dpBaCazaOMsugQj+hYrOCXogrAdegd6BNlbZWpnPoHDVHEEHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfMcWnZ5; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfMcWnZ5"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-910431849a0so4457726d6.3
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 19:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789438435; x=1790043235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IIgk7U4YCHq9tSu9Ree/QyVtg93sX+pO1NS1iMLEj6w=;
        b=lfMcWnZ5wQktvLcrjstMyDSDIJF3+9bVPoRdQsjGKmtISq8ZgzwhCcS/dD9DsFMGNk
         mULLhWnBC5bLPV1j5jm/edGQ4Frdk6T4AIXJ2qmK0yEJRSBSlTVtGXqUW44S302g2l7J
         qO+X0dtOzk66idQ6TVz6jfRENd6+sV8Cyxt6aUtHBcn8aVjDmMpTJcJNYcIIGauM5Vev
         zZdvcD8axuNa0MzoKDnoKuYaC3/vy9qXXIEU+Wjk1gzfxIVYDlPiOVVSKiYtsvOZm5St
         c10UMOUcTXiXHOcGViVsegSqjnOpIA4OiH7KEfz42HQdYrGBStOTRlFIcLuywdbeP/bA
         9JNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789438435; x=1790043235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IIgk7U4YCHq9tSu9Ree/QyVtg93sX+pO1NS1iMLEj6w=;
        b=VJEXm/oh6+Af74Df7a1EQes2ah8m63wNcfEFUh631IBYukJyO3QYw1oWUIFiLAGXtm
         i8BSyjUdZMdpAydUOVs+fw4kquZz77wMVSWvZInGkcee8tKCwtRxiIRvg0UhY5SnsdFL
         +pFbZdGIkMAQlGDp0xgKukrq5xUJXP1VH7w/UCpyYosTz+3eL76szUi+3A96kna/EmiO
         ckVPpRD9xzNnS7CH35bfCKUb1K/KSv+y4Surjt578X8E2JMmHgfAzhYzX+p7wdZD2Dk3
         ZFRKUDQhobwf2Vwi1M7dvE+sMn59FO6h/pdmcFh5t3txUnNxUIATrMPTNsKTQN1OaXsN
         JV7w==
X-Forwarded-Encrypted: i=1; AKwUvBzasvEbTgBD5BLMtCRA78jFN9FFS4j6MsiAUnWkYCJUIIi9GTXDPmu1IQkmNTPXih72v60=@vger.kernel.org
X-Gm-Message-State: AFuF++kaJM8H6L5RRFhwg1SOr+hehyjQQps0TNbJFPOj3D8ZcXtS3lDp
	gXGLMne5LogLT6xrSRg7UaFQrEblg6xw/imh5OtlJbLfCq0MafrcqC+I
X-Gm-Gg: AYBFou0eGiIPxwY4T/SGThOlWULxFXNAgMtHaAz9+eqYMK7gEAvUBPmqsS7yBrOmlHP
	aC7j5kCPe4qqDT4x9oxavMqBKvD7AT+jQQH/mNYV0RUzkZgTwVwZfZRwJhlbkdfzVaqiTZlzqhE
	rOTuS2R6euNGjC3ifr2RYSsveco6m+cPN/N3IPek6hrXN32DvxA7Z9972rd+3yNQr5OvN24LEwf
	d+j8vHHn4gD6OnT/YhUjmP7hgp/CPP4vhakLXaB4Tar1yRKGpDneu0TR9sKBVUN7U1Xu5g8rj3w
	oujvlWDqOJRIKHmvLkgf94Ny+XpQS6EuXKLemx8Y/qBmkPoUGqYu6VxgylF+Olg6xpGuHlb9HbC
	cRurUxzLeT3TCeOAKWF0vyyPQQEVspi9Kc5CujCVr73TGkJBIHUcfRekR6u12VQ8LC1E591pkc+
	uW2GxEO5wPOYt0Xm0F1Sjh+Fqm3c/cZyFELbQPmvVxt1EJwwPB/C/do5epzyA9kAlr
X-Received: by 2002:a05:6214:2689:b0:90e:8a5c:fb6c with SMTP id 6a1803df08f44-9122e4cc937mr85906536d6.4.1789438434614;
        Mon, 14 Sep 2026 19:13:54 -0700 (PDT)
Received: from Turin ([187.15.143.6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f47e800sm113147306d6.27.2026.09.14.19.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 19:13:54 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	udknight@gmail.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	visitorckw@gmail.com
Subject: [PATCH bpf-next 0/5] bpf, x86: Extend CPUv4 instruction support in the i386 JIT
Date: Mon, 14 Sep 2026 22:13:33 -0400
Message-ID: <20260915021338.1520964-1-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MOVSX, MEMSX, 32-bit-offset unconditional jumps and unconditional
byte swaps to the i386 JIT. MOVSX currently produces ordinary moves;
the other instructions are rejected by the backend.

The load-emitter extraction is separate from MEMSX so the code movement
and signed-load handling can be reviewed independently. MOVSX comes first
because context-access conversion can lower signed loads into ordinary
loads followed by MOVSX.

The separately posted i386 SDIV/SMOD work is independent of this series:
https://lore.kernel.org/bpf/20260731002950.179573-1-main.kalliope@gmail.com/

Tested on QEMU i386 with CONFIG_BPF_JIT_ALWAYS_ON=y. The full test_bpf
suite improves from 845/216 to 862/199 pass/fail: the 17 newly passing
cases cover these instructions, with no other result changes. Additional
verifier-loaded programs check full-width results and ordinary controls.

Of the remaining 199 failures, 8 are ALU32 SDIV/SMOD result mismatches.
The other 191 fail during program creation or runtime selection: 149
atomic cases, 37 ALU64 division/modulo cases (including a mixed ALU test),
4 long conditional jumps and 1 jump/gap stress case.

All five intermediate JIT objects build. A standalone emission harness
checks ordinary-load byte equivalence across the extraction and compares
MOVSX staging with the earlier emitter, accounting for the removed
self-moves. No physical hardware was tested.

Nicholas Dudar (5):
  bpf, x86: Add support for BPF_MOVSX in the i386 JIT
  bpf, x86: Extract the i386 JIT load emitter
  bpf, x86: Add BPF_MEMSX support to the i386 JIT
  bpf, x86: Add BPF_JMP32 | BPF_JA support to the i386 JIT
  bpf, x86: Add unconditional byte swap to the i386 JIT

 arch/x86/net/bpf_jit_comp32.c | 227 ++++++++++++++++++++++++----------
 1 file changed, 161 insertions(+), 66 deletions(-)


base-commit: 29fcf9ce4bbdf4cc339def776860e1c0095bca98
