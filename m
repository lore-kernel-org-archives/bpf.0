Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590628;
	b=ODHhSC4cRVC/Y+yVUKLdzChzy9+NQUAM5IcPqcvxOXSOmHwTwZsDGamRRllT2Ala9OnY
	 RojB3w1GpIwOs77wTcd+N8Bn5zdksS7Mz/k6qTIk2DQmtcaTJy0NLuzJy+ELLAVobF6ig
	 LnFDQoS3LKTsi7Mfh0VZheITWCLgg9+JsXrCF4PpyNCIBWk3Puk8fuwy9vtwsWQ+6A7kE
	 8RWccGft/zCgJ5XCTYPh+ep52RyVlmsmbkNv3EO+eTL+qCn11YWLzS6lM1YdWKqO01Zjk
	 RstbeJqGyxcsCM/biYxS9eVbgK1cXOG0MuhjhpBhnIsr5uddNZaMQk3pbmx57eMtVLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590628;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=cF9KWNLmTGcxUMihypB/shQsLilE+4ZcqZbL8jRLwPA=;
	b=Agg7IMuHJsUZuPG5MGaIWpTyLqHd8q52WRcJ3+fr3QbkXTvog6rvTrAzcKE/rssHuuNh
	 uVrEMUxDsxyJ1M1pSzO8tsnb5epSwac7JfkIXkIoXD28QjkXzgQYFeqt21BQNqA8NHKvh
	 ihbr4GQOrgGlE35w+zTIfeOpdIUzGfzIx5/npFNgNG+hzn3tO2hsrLGAHEKgK2iR7rHpJ
	 F9TBgQ5U6j2WciJ/bKq/fa/mX/yFJJ4II60KZQT69/jEgdiQHjS+OvA9HYVCyPkcPjlWB
	 90PbHthhpJSIHyaKrng/4CDkhdxlGcc1efm+p1le4kCgQSqkDQt1l2tDO4ISGpV8MiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X+3539rv;
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF52F6075E33
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 17:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF52F6075E33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X+3539rv
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-679334baa1fso1693416d50.2
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 09:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794590627; x=1795195427; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cF9KWNLmTGcxUMihypB/shQsLilE+4ZcqZbL8jRLwPA=;
        b=X+3539rveCIyD3d+ncAyz0R5kfKqSZ4WCX0KEdoq9wRVz0ht5qWpdLE0sq3paWVC6C
         mOGvdPSoriqOdyoHNZVTR5kQXp45FoxjegM5ZMBy2a3oAirlDsQCXXk91Y4Ysde0l8cB
         21nX94hZ3af0NVfB9yaJWcINOXQvgKFZ2HM2e/4T8Beo73U/3ZXlsDTUPqLHq4myywRg
         j20AXAGZNuO0V48RL8/Xy2ti6feWsA3YUZjFMf+0qr7d1ECF1+QzLNFrOT2nIcga78Oi
         6TcqPgiN1IGuEDEGvul1V5kLxwzxsQ8JMzqQ3s1WpQ0ED1bPEKvb6QlXaXgBFpL2bLP/
         seyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590627; x=1795195427;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cF9KWNLmTGcxUMihypB/shQsLilE+4ZcqZbL8jRLwPA=;
        b=i26Z2S0TohVepjmLmzK5tUchotNVquzFBDGHqZwK8q8wWIJPthoX51dCvaVQ4+9w/O
         SBO8xrpK8Jo6/GXoJN35xpA8Bsu1haQcfbhlNXjgCwpA8cetPQSCXwQdbsINEFoDF67o
         abDIlHcLyyXP/RK0+fU9idwri4Uvf/7NH2Bxv87Y394le3jfyZHcC6grRrfvrWEaqHMH
         wcyxXI4EnXwzRbdIW46RS0P7FXubT5fYXn2UhEqecXgZmWBPPTeQA8c/7gPMdimUDOf+
         AlSwGCph4SXp5c/G4BqVugMvAC6eBI61ZBf1/UKI8AhsMSkeVxTrrkYc1QoaC/Qh7wCq
         P40w==
X-Forwarded-Encrypted: i=1; AL+hErGXO1tfKZDxjsyM7tYXoHnxa+kT6+J8cihzqT4/cHqyeJ0u8srMng/3XkZv3s6Q9DstcLg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8S5eMJYyEdTBncTbGVxatkvpye0awcSRCWaUBLOaAQUCaEmKy3
	Nb/EwARNd6FDZVu7+SCixPbp+PDF5sRK1hDcsDge4pStgJsbTCPLV9Vq
X-Gm-Gg: AYBFou3EQLh4HQ1TqCZGIEGMz8xBQ7zBfRrCo1XU8KAleOSnZmQuyxGLjR1/R3/S4xs
	6gsvO2dbfGTYu0sTHYAXWLVRBLfXbvg7VrArHn+mKxXWgPQPMHzbz9uvxLUH8JUiUEAkAZDcNCK
	159mAp1w9SJSm5d6F6zh3QFiPbzSopvu4fMT2bNplNUK0RhrkFZu3SdVg2sNO+ee2363/Om4exJ
	QP3PxXj27j49HR+3gPGovxExgdoIBUDwLYHZzv/Hl4oJZ2K68JKJXDXwau7vdAsh3a0Jq0rZBrs
	U+8EZldyVLaSafHRnhDMgzSobTYEVz/Dxlo3j66wOmVvQ3HvC2otCYf3wzH4dXzmc+SOpGj+KhZ
	Z26GvNKEox+IWSo98QBAd5S7Me34IFAepSFxTSbGpiE+cXNZLGE6DcsWzdzB4blmpuSUAAWe/8w
	PtqYqPsdfYMOcqZdjU1JXLC9OEztUaXnRmXwlvd2yd5rybXZYuWKqUXtOFWPepod6kT8XtwW71q
	s0J+A1dQ9/h2FSInh8P1SLLIk+j5ZHA3mn1sHAZAoE3sfMSfJrPDzIDqB2RC+9fpT3NfSXZ3oHG
	sdd4RrYEvh5dKK+/2EyqujgUVeBrBVl+eQ==
X-Received: by 2002:a05:690e:d49:b0:67b:edf1:7294 with SMTP id 956f58d0204a3-67d896b00e2mr1265391d50.79.1794590626789;
        Fri, 13 Nov 2026 09:23:46 -0800 (PST)
Received: from [127.0.1.1] ([187.15.141.223])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa9dc1c9sm25187277b3.36.2026.11.13.09.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:23:45 -0800 (PST)
From: Nicholas Dudar <main.kalliope@gmail.com>
Subject: [PATCH bpf v2 0/2] bpf, x86: Fix i386 JIT signed ALU32 DIV/MOD and
 MOVSX
Date: Fri, 13 Nov 2026 12:23:41 -0500
Message-Id: <20261113-i386_bpf_jit_wrong_code_20261028-v2-0-1dd0b03072a3@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWN2wqDMBBEf0X2uaFmLVb6K6WEJK66QqNs0guI/
 97EPs7hzMwGkYQpwq3aQOjNkZeQA54q8JMNIynucwassdVao+Kma41bBzNzMh9Zwmj80pM5hBo
 7dcVL62ps9OAJ8swqNPD3uLhDLsLjD+PLzeRTGS+as5GUExv8VFAWz08bEwns+w9xhiT7pgAAA
 A==
X-Change-ID: 20261112-i386_bpf_jit_wrong_code_20261028-7246b0231fce
To: Wang YanQing <udknight@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, Yonghong Song <yonghong.song@linux.dev>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, "H. Peter Anvin" <hpa@zytor.com>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, visitorckw@gmail.com, 
 Nicholas Dudar <main.kalliope@gmail.com>
X-Mailer: b4 0.16.0

The i386 JIT accepts signed ALU32 DIV/MOD and register MOVSX, but
ignores the offset that selects them and emits an unsigned div and a
plain move. The results differ from RFC9669 and the interpreter, and a
verifier-accepted program can use values outside the range proved by
the verifier. In i386 VM tests, three verifier-accepted programs
supplied helper lengths beyond the verifier's bounds before these
fixes, and the helper wrote that many bytes. With the fixes the lengths
stayed within the bounds. The test programs are not included here and
are available to maintainers on request.

The series is meant as a minimal fix that closes this gap between the
verifier and the JIT. It makes the two instructions the JIT already
accepts produce the values the verifier assumes and adds no new
instruction support.

Tested on i386 under KVM. vmtest.sh has no i386 target and test_progs
does not build in full as a 32-bit binary, so it was built with
jit_insns, verifier_sdiv and verifier_movsx only, with a strtol() to
strtoll() change in test_loader.c. The commands and output are in the
patches. The six jit_insns subtests that still fail (arena_zero_off,
cast_to_user, staggered_jumps, acq_rel, probe_mem, shift_counts) fail
without the series as well.

On the unpatched kernel the unprivileged subtest "MOV32SX, S8,
range_check" hangs in the kernel: the wrong value takes a branch the
verifier proved dead, which for unprivileged programs is a jump to
itself. The unprivileged verifier_movsx subtests were therefore run
with both patches only. There it passes, and two others differ from the
expected xlated text by an additional zero extension on i386.

Claude Mythos 5.2 assisted with this patch series.

v1 -> v2:
  - Dropped MEMSX, 32-bit-offset unconditional jumps, unconditional
    byte swaps and the load-emitter refactor
  - Added the signed DIV/MOD change, which was posted on its own [1]
    and is superseded by this series; the code is unchanged
  - Sent as fixes for bpf with Fixes tags instead of new support for
    bpf-next, since the JIT already accepts both instructions and
    miscompiles them
  - Tested with jit_insns and the verifier tests of test_progs

[1] https://lore.kernel.org/bpf/20260731002950.179573-1-main.kalliope@gmail.com/

v1: https://lore.kernel.org/bpf/20260915021338.1520964-1-main.kalliope@gmail.com/
---
Nicholas Dudar (2):
      bpf, x86: Fix signed division and modulo in the i386 JIT
      bpf, x86: Fix sign-extension moves in the i386 JIT

 arch/x86/net/bpf_jit_comp32.c | 76 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 8 deletions(-)
---
base-commit: b7cc45994c3f9c5f24397fcc0251f6c23bff9bd8
change-id: 20261112-i386_bpf_jit_wrong_code_20261028-7246b0231fce

Best regards,
--  
Nicholas Dudar <main.kalliope@gmail.com>

