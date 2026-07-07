Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F17B360ED0
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783450938; cv=none; b=Oft+vscTJ8HF2xYpXnsFsCqnor5TzqigLGUY+0lj4zkTX3L0mOE+nYZBgayMTzaxd9yNK9NwvDq9ZWDVoKQBxKDFxBK4OvgXLFy+wWkKr42LBe0WeNHigqWIe07s7bOd156/tOaukg7mGsxyu9ZssJYv1QonwowOX5C8egdf4pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783450938; c=relaxed/simple;
	bh=svsgUm/jJt+eXJnCt1RWCG8aEN7E3pO7GARa+R2sxeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mlW+BaXEHTSOenDPzPf7PWpsojATG0iGO+h9kZk+307KoSOXy5RfVnqLQ+od/M/icotPXZpXPbYZG8V0rv7kLSONNt5Bn/v1jSWdnhKDv0aHdKWJmPyvUyfUjZxegY+NMMGVvJL/0g5RCQBNdCngqej8i796ZjmYOo9sABjfeHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/ERuW9U; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/ERuW9U"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47528970fbdso910512f8f.1
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 12:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783450936; x=1784055736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KNdKf3idjKg18UOSQxmR6B+n8nNVb0F/yYSMmRJDLrw=;
        b=l/ERuW9U/7sh6sK0k2N3e/LBqMAjOqOA/LTtJu59VfIUmN4YAbX0Gr0SwhWlM0/DMm
         BG1A0ePnMk1d+FSZtVCnI8q/TIQyHCf3sRck/n2FIXmkiMva9pSWAT30m5zcOSSa103H
         nz4hepzjmqRtsr6Qk5a4GNbeGr25t/jhApKI/AyRB/dVVdXR6ltsjLwIheZ6zMWY6leG
         MejHtfDW1EIxz2xz8/GGyAmC5a8Foi7AZ9PjXwyM5NHo+UssF9NxUCLtBy/wSLJ7nBOc
         dOllpuaypTkCX+r7se9hfbCCu48UklMnEiY+vwlJ9EMwpUA0Ea+zxW9zwcXuY58Ejc7l
         Yzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783450936; x=1784055736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KNdKf3idjKg18UOSQxmR6B+n8nNVb0F/yYSMmRJDLrw=;
        b=Bhinor+lwd4llUpBVRVUJ3CHNAdQ0BTJZ2uZMx9zaNK7jej8G9lTdNrLEIAByBL9N3
         EHqsKgldbqqFPRSKhXa5A62/thVUKPknC4li3NMHF4BcjQG229e0w8qYbBLZkvw0H4uk
         3iWZwJzYpCvyoCuZHzCO09jNhwV6cb6PO7iv8cuT4chPAEmW8yhwmEn+mfwDS7Ps1GTG
         tELsKNlIJX9M7qaOIvV5P44hU1NzgU7uIsFpLW0LmhHqIows6nfhosYTaABFWqk78Mbf
         CdbVrwM7Ox2Ns7MfLehQLXlVCrbqDcuuL6DgRtZ9OOCWs3vRg2+U7rzkyrZgsy9pdAln
         uiQQ==
X-Gm-Message-State: AOJu0YzCKmcloz75aICjqRzvAQsZAHyWTyf5m3juxLRRXdrMq09N2TCj
	KmubxmGE7D4I4euqXlviAaYFfl50lQeAEJ30pZbPY40tNTePRcuPi/Gx8MQiB8i7
X-Gm-Gg: AfdE7ckDOdl528M51cUx+eBY13qH7kfwTeBTm5i3pgVezvPdu0xIn31fKw6BLYm3htS
	lRAZzfc/HgpJTReAn+xqmyoqAyaEg3dpnlHFFXN5EcJVMzt4W0Fnd6GzONsxLWAwJvJS0VS8WQ9
	3BwierUY4KZ11QdAmnJV7u4Xf0SiFeqgQvoT3+EC4v28nioKTfxwH+gpiIknRD0GMBRS2KjiXtB
	q5By4MEBW5CH8/QrNBXeUw6QcNL7LkVuy3PWpdRxpLu6MJjtk0Q85My5lvynUzUZB1Ee5pW6axA
	7Y8tezT8VhzNHGAQlHLFbEx5n76A8aHbZLAt18xn1OC//zK67Q9cyyy8c3QiChKdN/acz7Ixu/w
	hy2fYzt643FP0MFZbNftwTbFXLG/ssLUkTXyVc05deaop7r2XPR13v2rChzPVMRTRaRYPIEkXbf
	6Gn5Z3GKQMXmUQfnI4zO2PH6vthLcgfQFp4Syg3FJDz5HNhIzWzUMTl09v681gAH2AGkKeYP7Bo
	dtbRBG+wBdSx/bV9azWmgIrkuxPkc092JC1OfwZ+xh8t8M2BQOygQs=
X-Received: by 2002:adf:e807:0:b0:476:8d5:cf34 with SMTP id ffacd0b85a97d-47de6689f31mr5688306f8f.8.1783450935480;
        Tue, 07 Jul 2026 12:02:15 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e3e2702sm36830361f8f.9.2026.07.07.12.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 12:02:15 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/2] Fix for untrusted BTF pointer writes
Date: Tue,  7 Jul 2026 21:02:11 +0200
Message-ID: <20260707190214.1997705-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=704; i=memxor@gmail.com; h=from:subject; bh=svsgUm/jJt+eXJnCt1RWCG8aEN7E3pO7GARa+R2sxeI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIcvXJ5+xlee3Tc3dy2vll1z3jrpy8bgRx6813xd7JOwI0 7PPe6fUUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIl4SjMyfJZLa2VgaJpaWCEy 9U6utry29B6B0GPCDZsM7s+O/p/kxvBPwSb0zDF5wflNnr/frN1W8Uh7cz6bEeseVu2v1w8wxhs yAwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

When using custom btf_struct_access() callbacks, we miss rejecting
unstrusted BTF pointer writes. Fix and add a selftest for coverage.

Kumar Kartikeya Dwivedi (1):
  selftests/bpf: Add untrusted BTF write regression

Nicholas Dudar (1):
  bpf: Reject writes through untrusted BTF pointers

 kernel/bpf/verifier.c                         |  8 ++++--
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 12 +++++++++
 .../bpf/progs/tcp_ca_untrusted_btf_write.c    | 26 +++++++++++++++++++
 3 files changed, 44 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_untrusted_btf_write.c


base-commit: f425a0443b7f0221a4b34f6acc0c2924bf5877f2
-- 
2.53.0

