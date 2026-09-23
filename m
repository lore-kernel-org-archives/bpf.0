Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C17B3E1CE8
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152937; cv=none; b=UkeAsOIp5LxVDKsZcF2yPqNQ7uK0PnoVNVHtyLpskFO8/+JU1kbLZtjtW1imF0MLYi4iWFjAA8NpB0Ey4WZV6LZ6JwzXCSADJqz0axffJaSNfmoSUkJ8r+NReViyioGOCbXsdttemvhMnM3AjhYkkCX0LDo1gXXN2IhXzRNOAQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152937; c=relaxed/simple;
	bh=ISEV0WDJU1MocpevfTDQDunXIDcK7ZQH1lGgeE6qjOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cyAjHrrJz8NZ+kvjSZbOH54tBgDkiin0YAf3uHL/AAP7BlM+Ae+7cUB+7cLy5L8inL6t/sYKpYZjn96fBWitFhkdaFmxm8knYs9Ej1rN23voBWUt9mvDK2L/F4L9DUddRutDSkCaB0dg0A3j7UIe69mhgqheQBNpB6GONKek6RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nwsmXJa/; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwsmXJa/"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-485850cf4deso358689f8f.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 01:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790152923; x=1790757723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CQZea4ihBpuB1tSHiwjYe7V7UlpafGUB9YI02U7jK/Y=;
        b=nwsmXJa/AT62VLackEI1zd+OrCW0FMj2nhJrGRDdqeNv/y6CnQPCGfzUfjpH7a1jX8
         DAszbTvoEJXBSgk+7eJ8Nk5rRQWyPRb/ETOMPXPougsbsJ2w+NAV2tazAhJWGnRRTuGm
         ONBIZxE0fDy6obYmkmp1GE6gYXQBWYxERlaVdO8MssK9k9jE7hdp24HYUkqOvsYRZvkC
         emAatPfnwJhnC/AMEaes2ZLgMJKS+JX8iuvRa5at0NPcLdihIahpzvl5DEsowPsmp8lH
         CsBOckCFr0GBhFol9Sxr+HYtCyTmH27imcBV14oZXmAsiO1ValZm16RXSGMD2Ks5Wd3U
         p/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790152923; x=1790757723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQZea4ihBpuB1tSHiwjYe7V7UlpafGUB9YI02U7jK/Y=;
        b=XIIoeJFD+BorVt4w45KbF8U5/jAGbXfHaoztvu2mFm22ENkmKwn+QCOc0SIwMOz246
         kycuBQ94RzI1MpQ+UQXyRZBbl5dG7Z0tcFaju028LNbhqd1+IGC4Y2vXA5CApIB+2r8Y
         SGjcJuHBk3llkSUns/AEK48+mxSFU+vxXXhCYx1MlTn/6h4KHJSjmllaCGZHwAk6LHXM
         Z3X66Im1VNT+qkJY6hEhZvhm7Tiv5bxwbDLxYVN1QC7oy3WFBoZqH0E1QvLI2SAV5KpO
         y0Dy/PD0Ov1Jclgzk2Wlr7sxa4p/s13GIAVyusxNpu1U2TbNzch2S8oGZ7qCOxqaNCX4
         5bSw==
X-Gm-Message-State: AFuF++lcE8VZXVSe17mcAU9PnHRhytDbojRpnZ5SnKcgzpnH6NtFb5Gz
	HCRSJBf6U6yxU6O5tZ4TB7g3SUHo1YBIOzKNz7jHsqEOHPEZ8aAotcbNUbuYU7T2
X-Gm-Gg: AYBFou3rhGcxhl1jM3+SkaqSsjW9HiU/xvyGRpIB6y1wT7f2Mm97dQajx1uZ6Bydp/r
	faC09RLEo/sqL88L1EIC2/uFUOPbwZTWmxPc3cz2GE8auzrR05ix8wjbkGfInajtuB7fM3XMNwD
	lTXS5zNo6uXaVhSSk/r2ljTXAaiZmgCIHPpqVX6yU/eONnLJ9OjkgDE8BA4lmFPECXcDfNpIMIR
	BL1gGfCsr3ONSlHpr1xTb0MS48UbJ+x4cMV18i8+LjxIL7KGDp+Xw0agVs11DfWEUCoceZGUzOT
	9QMmUaJD0ra5g70TqlIbkLlo74LhFgPnzIAK3tT1LonO+Ya2xM8dJDmaigjFWyJfENb0VOr/cbS
	j4+nDqvfVQJ7Zf1TTW1+YwApXAu3mjPZbXnwQ2CykiSj59+xTdO0J4RRjZNrAiko+NzkYCIRFmS
	hQz5BuBTnMDIhbj57Dmtvmr858slAtwjJp8NFYGAQf/wCT/NaliBHRQxx/S0gENMKPzNVXlNl2S
	TWCsZtgnou350sIjsbIa7NiuQ2AId6nzkLsV/au7LOpiRssLtWnCJ99K2MGv9KV42RGoJuA24i/
	yUABZnGw0AmwmaqzrlMzCalQVjGSXiBBKbpQUw==
X-Received: by 2002:a05:6000:401f:b0:486:fedf:d4be with SMTP id ffacd0b85a97d-48867090ff6mr3382001f8f.30.1790152922817;
        Wed, 23 Sep 2026 01:42:02 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c267sm5445486f8f.16.2026.09.23.01.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 01:42:02 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/3] Fix fastcall rewrite with indirect stack accesses
Date: Wed, 23 Sep 2026 10:41:55 +0200
Message-ID: <20260923084201.2437625-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040; i=memxor@gmail.com; h=from:subject; bh=ISEV0WDJU1MocpevfTDQDunXIDcK7ZQH1lGgeE6qjOY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvzhJ0HDmrXRKlJ9Z7XlDH7Ys/6xnnt7uqqH6WWRtMe6 39Qao7pKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwERm1TAy9B4+mOG1upR35bKd rxulXkS0vEqWXnAs9JPqEjOb924vwhkZbh5TFErdl/POQUagYLf4Ar0cpTjG3p5tQT1rTm7ZWtz EBwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

When a bpf_fastcall call is inlined, the verifier removes the spill/fill
pairs around it and shrinks the stack frame to exclude their slots. Two
kinds of stack access skip the check that must disable this rewrite, so
the program can then access kernel stack outside its frame.

Patch 1 checks helper and kfunc stack buffers, which BPF CI reported
after commit 5da4a9f26fca ("bpf: Preserve stack initialization for
generic output buffers"). Patch 2 makes a callee's load from its
caller's stack check the caller's frame. Patch 3 adds tests.

Kumar Kartikeya Dwivedi (3):
  bpf: Check fastcall contract for helper and kfunc stack buffers
  bpf: Check fastcall contract of the frame a stack read targets
  selftests/bpf: Test fastcall rewrite with indirect stack accesses

 kernel/bpf/verifier.c                         |  10 +-
 .../bpf/progs/verifier_bpf_fastcall.c         | 161 ++++++++++++++++++
 2 files changed, 169 insertions(+), 2 deletions(-)


base-commit: 91f8613d95ad8cd99d8baf094806d1ef98bc6380
-- 
2.53.0

