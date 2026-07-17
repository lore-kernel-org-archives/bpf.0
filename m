Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5FB33F38B
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784315171; cv=none; b=VyfDNsG4e5qA0jHiqtszPt9kdP/19/CN8js+QlxoXXhaFwZknrL3Fq5o6gSvvMURXDOJHMzMCF/fhiwWR4GB0Aps32uuqyjoLNx04RnP6k0cQuRQ65gFUrVZ4b5Jxb09iJ47yMItYS7aKFd0o6sDAmwHfmYbEe1L5HjDyKXv31Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784315171; c=relaxed/simple;
	bh=SmKAs9qFcLTR3agDAsPoMblcsCPnahuVR9tnj9R3Vso=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KrQQNyG83GVZSGulBTjltHP5MZwqGdK2eBVdUheIPN+Cohx0DbgCVExGJSknYo1eH9WMVBWc8jmLmLtr0oC+qpBcv5Y+qgPoTChwg57sgyX46rQ7U4tVtGh8pGwCfP/a08uViVQ1J/bgaewPkDXtPhLR+NKgexCgRz+iad+hGaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P43hC9Mj; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P43hC9Mj"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8efef6533aaso47306926d6.0
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 12:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784315169; x=1784919969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nbm0vupgXVGHi1DpNIYtN3nv8LfK+SAoC7r8NbSjB9U=;
        b=P43hC9MjtHBZUqSBwTJV9f2a3mLTU0IZ9TVf9oAdhf4vJ8Flan5m7heG0BTohPL6Df
         +ZdD8hNm1u3ujxL2vEU5Bi6ZEin1x85Q3wkQvP0kxmrdntzT1Nnlq1475E4UIILCuOLo
         qKSbIkzzmU6owAC95Tga51ZC7m48UqOAbc7FUMZb76QEfBnFF1tdlOcCh/ZAMlAX4PQr
         t35F1EN454wq0jUwz3k3qUhTD4kFAEFbtWt14zLCu9QM6MgXwjwVYxtLB4O0LeeQEkBT
         3+F6+gdWYTDX66M8ZMzmeZ7F7yJ9I8/ntsD6dP6d1Nb1Pd3Vfp6d2cZG9EnUk1u9Yi07
         l6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784315169; x=1784919969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nbm0vupgXVGHi1DpNIYtN3nv8LfK+SAoC7r8NbSjB9U=;
        b=NGyyyyRkSEbR6w+xBQ9sow1qtp5Y2ZqqvLVO+ygJnMhcpaL7n8If+z21y3bPnv7C8t
         /1zcspFbZP16ki6RTqKFifKprr1/ijI2QV+/aMR4YYoCKaSYxW8Ib9lH6kf8ys4gVHkN
         jOI9XNauFKO8DuWtTFlF/Qyp1Ci5d8uDA24UP20ZhaHa7gUCwRPaDiTjtjgNdUHDazmt
         1l3meUvr31o3T1uoC8W4Yt2zhXmYoh7v7MveFSb395ERl0a6mPUP4ZJd0rdK+LRQcmV/
         L1MCdBCS1XFjR8lQLae8GAIt/pnYRkyCAEGoEri7WxTZ+RmHz665kEDyEq6jDlph4XQg
         F39w==
X-Gm-Message-State: AOJu0Yw8/No+j8vQFGpWMrosTAhG4u5hWGsoHMeGtZ9LCwXaLmmLflYq
	3+CCpK36+6mqZP1JfL2M+Ik8mllB4BeehrK+h/LsPAFZqc94ODARGed2
X-Gm-Gg: AfdE7ckgMvEmK5AgDJmbESWN2voOEFRV6jMo11Bbq9yZl4lozDboXV8DC9xukY4evrS
	vrr1dlCh360qOg+EwsSKF8gHJm7aeaturQ1dss5utRsAdd6tGJufpbTzfHEgec+KmrdyU6VxUzZ
	QBmBSiicoRzAjjWEnHq3uy3qy8VLSXV+ju09CipTQ/+k7xE9oTKDdWtkT4Kx4CNsG7K0e6Ljdrl
	qGDIdC8KZ5nocmh/+gt1/trDpSb2GKWcpeV8uCbYHR0KN1qoAmLvhln1zCUpFPjqUGxlC51j6Rb
	/WDue5WtLUJeGzEdM9iM71UCD2lrBv4r3+ow3S5u5692r9C/HLhZKoAHUNnCNqf8SJ6jV1Jw0dP
	kxsRSatGqAU1if/RZW7h7kDCZY4SpXwrnZiRSzM1mptwLejeIs5Gb7szn9ZQwnliQ7Rmq5wPbIQ
	5HKe88maxO
X-Received: by 2002:ad4:5c43:0:b0:8f1:36c7:497c with SMTP id 6a1803df08f44-907784ddb2dmr47350846d6.33.1784315169083;
        Fri, 17 Jul 2026 12:06:09 -0700 (PDT)
Received: from TurinLinux.. ([184.144.109.221])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9077871d06csm24035606d6.43.2026.07.17.12.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:06:04 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	deller@gmx.de,
	James.Bottomley@HansenPartnership.com
Cc: bpf@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	visitorckw@gmail.com
Subject: [PATCH bpf-next 0/2] bpf, parisc: Add support for BPF_SDIV and BPF_SMOD in the parisc JITs
Date: Fri, 17 Jul 2026 15:05:42 -0400
Message-Id: <20260717190544.257306-1-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The parisc BPF JITs emit unsigned divide and remainder for signed
BPF_DIV and BPF_MOD (off == 1) on the 64-bit and 32-bit JITs, so
neither implements signed BPF_SDIV and BPF_SMOD. Signed div/mod
return an unsigned result for negative operands rather than the
verifier's and the interpreter's signed result.

Patch 1 adds signed support to the parisc64 JIT and the shared signed
64-bit helpers (hppa_sdiv64/hppa_sdiv64_rem) in bpf_jit_core.c. Patch
2 adds it to the parisc32 JIT, using those helpers for the 64-bit path
and the $$divI/$$remI signed millicode for the 32-bit path.

Both were tested with test_bpf on qemu-system-hppa; the signed div/mod
cases fail before and pass after.

Nicholas Dudar (2):
  bpf, parisc: Add support for BPF_SDIV and BPF_SMOD in the parisc64 JIT
  bpf, parisc: Add support for BPF_SDIV and BPF_SMOD in the parisc32 JIT

 arch/parisc/net/bpf_jit.h        |  2 ++
 arch/parisc/net/bpf_jit_comp32.c | 29 +++++++++++++++++---------
 arch/parisc/net/bpf_jit_comp64.c | 35 ++++++++++++++++++++++++--------
 arch/parisc/net/bpf_jit_core.c   | 14 +++++++++++++
 4 files changed, 61 insertions(+), 19 deletions(-)


base-commit: 1d91ea01185656ac3ee63c5f9f6f8bde3c746b3d
-- 
2.34.1

