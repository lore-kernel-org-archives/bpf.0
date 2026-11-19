Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795051754;
	b=qdQghiko/LY0QHrc5x389z7m4KVfcba+GOkaG7qcArFU77pd+sQ6j2LAVDZ5HHdaTE6S
	 g5SzEynmHa29ya7uavT2NG/cWZqUNS1y2argRgennJO5hxsEjq0Qku6dkbPmSnx6hPBsF
	 CGPLKeQdsWb9C+8JYa4LDvcxEYUzdYdZp2mfQujTBbS/H4zXO++jFZNyTvTHQcPwmN7cC
	 dCuHzWoQDCWnkT3OdnkQ8MojAZ2TDNj2CBqF5Ic4N9xz+oLMrwnzhXEFdSZIN5kx072Dq
	 U+/cj/Q4r/UoUbEMelBdFofLigFUUM5tz/UaiTTA1QnStwitKII+4fShAUaCZdmT2nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795051754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NX+n13fmxvO8mjWOvG+vg5omNlBfbreh2eaIqfZkD5Y=;
	b=4OmK01znPFTE1LgITPaqlIUqAS3N54twyQTUfdxSxFF9ai6aSn7zd1F2pjLo3G3ghIjU
	 D1SYfElGIjdVLv6zZ5HxaAXks+TSuxhJZ5NisRfsWg52dFs8xQDOLGVWyeQjOqB5xlrRj
	 LutvYqv3UnwcuEASkA5bkeZsKOaGRD6UPWG73s3pk+OgnDL6IDEhDQ+AoD8N1MpvaE6mE
	 OT1IQ4U/iS1Y7jb2SIU+GkbI+WhEAmusKhB2fGcCGTpGOlFH2khlfit28HiVT7LDVECcP
	 /TppiUCio9lqdbxuXNaa4NdVzyqXhd9jgohHh12s3Fj3oaa8zrbSt6fBGheU3NLVN4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QgojFwNv;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D95606A330
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98D95606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QgojFwNv
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e9d7791b00so17794775ad.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795051753; x=1795656553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NX+n13fmxvO8mjWOvG+vg5omNlBfbreh2eaIqfZkD5Y=;
        b=QgojFwNvwyo6d2DcoHe23s5+F3mzxNLgcZpBqTgpXXXbSae4RhVKo6glgRwqiyUP71
         9OlCTnSFWGbLNJw76AbCMINDpJDCUnY8MKjgzir+ntItKXfzJe0Ndxf9JkolIDNXu4DR
         32Dyo+CzVpeEPcV+ui/pF6SCy8p3rzX6Rf1sQ90JphKWXa1Qa7I5By4vrIkPGALNf6XF
         n/Zlsv27AIDi/54oQN0uboBvxFTcDy2GGJtmO2pc5Sb7V6ZNhONzq+NHR9FCog23EqM+
         YSmaKCMHURZjP92hzUKp9eq6HNg0lFIfj4HKPXh7zWymG2HpXbhJI/QcYEqLYYCDvuIe
         DWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795051753; x=1795656553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NX+n13fmxvO8mjWOvG+vg5omNlBfbreh2eaIqfZkD5Y=;
        b=AtVXzil0eu8H+FGZlIqnSiT9coJqyV2i3zxZvpUxFcHdfW+pP8VXp46N6HmLWiMa7h
         HY5adKH6lW+dIsGMjJgZTr/FJrHl0CQ0f4u6Yair22iIQDu+Pj8WG6v+wH9sPr5+dwyj
         p/37/0FH/h0mDMhaCA8RnJTpzySPXbKEkzrBP258UvQ6etqBEB0xRqe/cDnjBERDOJ/G
         OiEu2Q3mNrBlwgV45JxCkEnUb6i34lTDv7uNYirZ93u/sZicohNGCyep4KuIXcRCpnq0
         +28Fa+eWH0+1bNHpcfXXVTnlu6XSXDNb3ZIEqT6XV7HXjcfJrQTHlrDMxpa5J6TJ7tt6
         kztw==
X-Gm-Message-State: APuU4Z+L3Ufgeb/FxaHoletb0DOkw3CKT0jy2I0Ox25tBxZJEBIBnPCp
	Im9ivG9vUrGMbiyl8xYlpsa+xA+FR7dmF3MUOgTprfeFNa9MfqGOimUPpxFLig==
X-Gm-Gg: AZFdTZdDH7qW6q07oo3jkNzJ+df764QFWNdVq8SYNe1WLtlC4i/H1QbJcAfegvYcy88
	QNsvuAm2uu9wXn8seE86+za7tYcU5qyP7y/G4eRhccwXkJJHzbjXuTgeqtXh2mtp4icH1alNac0
	6/f5avW6TA2A4CBWxnZ2JZ/D8SxILqux5oZpjcpUtFC18PbI5InSTYXBz01VjYPMCyF7w9RfdiA
	MUg2GC3jRoBxXewjRnLxdD8ljKj5PW0K1YKEubwxpk+if6i8mmlOONK0GwqzUocaB87xq06+QwO
	7E9j4HGKcO+P+srM1AA9Dyd2G92molM/6wBVnX6fbkRpCrwo5hGVB73dxyot0AbxhCn6wEl3vDZ
	FNCzP+qsOv9KfYHtniCJiVyxp+/u4aYYF4BYwr+Rjbcx3Z+1b+RKDKo+MT3JxXgq1QUiW1fm9YM
	HzytCTKKmkajjXq6NN8cQjPbMZ0Y+NE3mgwJFzdfP92VuTy5Hzj2gX7NHTvk0EVT/fXI3SPZBtH
	7cLy9+shEMaGxsw/dLISCGQ4JEx9Hpcw8uRIodPg7A0JUTaOtjLsAhfEh7iZ8+M1IIbCSQO0SIS
	SHtTNbm6z4xDdXuKmIzjB0oT49S4IWPdaZRxNbFTk/YVJwkR4LE7dsZ17gvodck0k+dHz9gfEXj
	Y/ZVBQ+sG0wwxSpnonCT7PLGNBQ7ITIyhV+0k2RPPe3J7om2npbK8n4CAjVTIrOBFDj4tza19hA
	==
X-Received: by 2002:a17:902:f705:b0:2df:9556:6848 with SMTP id d9443c01a7336-2eff720bc4cmr36006005ad.4.1795051752773;
        Wed, 18 Nov 2026 17:29:12 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff6183f8csm20818975ad.31.2026.11.18.17.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 17:29:12 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 0/5] bpf: Trampolines: the size of the image, the type of the return value
Date: Thu, 19 Nov 2026 01:29:04 +0000
Message-ID: <20261119012909.3657417-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Two things that the x86-64 and arm64 trampolines get wrong, and a limit
that does not hold what it promises.

Patches 1 - 3, the size of the image. BPF_MAX_TRAMP_LINKS programs are
meant to fit in a page. They may not: on x86-64 with call depth tracking
the pass that finds the size warns or writes past its scratch page. Let
that pass count without an image, as the other JITs do. Then the size is
the limit on each architecture, and BPF_MAX_TRAMP_LINKS can go.

Patches 4 - 5, the return value. A BPF program returns 64 bits. The
trampoline hands them to a caller that was compiled for a function that
returns int or bool, and it tests all 64 bits to tell whether an fmod_ret
program wants the traced function skipped.

	program returns                   before              after
	fmod_ret, int f():       1 << 32  f() is skipped,     f() is called
	                                  the caller reads 0
	fmod_ret, bool f():      2        the caller gets 2   1
	struct_ops, bool member: 2        the caller gets 2   1

Extend the value from the width of the return type, as s390 does, and
make a bool 0 or 1. The trampolines of the other architectures do not get
that.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (5):
  bpf, x86: Count the size of a trampoline, do not emit it
  selftests/bpf: Don't use BPF_MAX_TRAMP_LINKS
  bpf: Remove BPF_MAX_TRAMP_LINKS
  bpf, x86, arm64: Fit the return value of a prog to the return type
  selftests/bpf: Test the width of the value of an fmod_ret program

 arch/arm64/net/bpf_jit_comp.c                 | 39 ++++++--
 arch/s390/net/bpf_jit_comp.c                  | 18 +---
 arch/x86/net/bpf_jit_comp.c                   | 87 ++++++++++++------
 include/linux/bpf.h                           | 24 +++--
 kernel/bpf/bpf_struct_ops.c                   |  2 +-
 kernel/bpf/btf.c                              |  2 +
 kernel/bpf/trampoline.c                       | 25 +++---
 kernel/bpf/verifier.c                         | 12 ++-
 .../selftests/bpf/prog_tests/fexit_stress.c   | 29 +++---
 .../selftests/bpf/prog_tests/modify_return.c  | 51 +++++++++++
 .../selftests/bpf/prog_tests/tracing_multi.c  | 35 ++++----
 .../bpf/prog_tests/trampoline_count.c         | 89 -------------------
 .../selftests/bpf/progs/fmodret_retval.c      |  2 +-
 .../selftests/bpf/progs/modify_return_width.c | 39 ++++++++
 .../bpf/progs/test_trampoline_count.c         | 24 -----
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 19 ++--
 tools/testing/selftests/bpf/test_progs.c      | 37 --------
 tools/testing/selftests/bpf/test_progs.h      |  2 -
 18 files changed, 256 insertions(+), 280 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/trampoline_count.c
 create mode 100644 tools/testing/selftests/bpf/progs/modify_return_width.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_trampoline_count.c


base-commit: 32b66b94c86f009b49668de7340f2ed65aad2dc5
-- 
2.55.0

