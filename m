Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19391271468
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775973839; cv=none; b=Af2nXpNWIXpStnW/csM1VrikrwZvTtTNWVtOUHxj8xfMyTzahVUVeBJZxITquG2WAeQ+c3jKtHS0kw7MBKKSMjvjUBa8EFntEiHAy3WB/HHHpEGHTfzIiVkXSXiNmnpXgvRHoyhTMw5ENamjMTzt0l0PWOsOshUiiyE/PUwgOOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775973839; c=relaxed/simple;
	bh=S4TXCDrvBtG070uX5Lc31lW4uy+uw16gQjyA0jgmlIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YtWXU1ViHW00daEvcOJBTCTuVxFiA4RwhYhwxZsit/0gukSapebzjX8VOl8799CULhO6wYNR0tcL151OfYa+PpvqIKF6CnwZjSNkVlBkTOmN+bLWANJctz7US4PM5wnXFykqlhFWuL+JBAkxOABir/uKfcGW5cuZWcnRdU8ECiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQR7/7wz; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQR7/7wz"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-823c56765fdso1964392b3a.1
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 23:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775973837; x=1776578637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=26xXQQRZJP4kKGBjp0Vx8Z52JjR/eF2ZNpcBSkc8AQA=;
        b=FQR7/7wz8C9jX+WPT3vsDAwHrbvrsPv04VydLgAyPA+dXWQ7sIlceVrPUlYvb+EkhX
         zdW0JJbWMtzgMe4vcd3eHbLfxREpuN/wwbFafhnUVJ4IyuGyVi+imUpghmlb7UBAF1C0
         ySrPYXOttWvcCMlMKGUXloOhGLXbTz0BEa3SQTSSfEAXgdKSdYhwj4Tf0FBEeOwVAzWx
         hDp8JREF+eN8IUJQL5kLpC2EnQ3kACK036y6J9DbrwenI9RkLV8fFPvEDe85USRM1e/W
         Bc9up1h17aLaE6nbUtCftRiXp2hhk1CFhu0DYj5P5kSK+OoDgUykI4V6AKWkKIoFZz1b
         GJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775973837; x=1776578637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26xXQQRZJP4kKGBjp0Vx8Z52JjR/eF2ZNpcBSkc8AQA=;
        b=CPRIrFSucc4DozDEtm1OB9/teOzAxede7dUdMd535dFIvYFyy5UoWsfBdvooyo3K3M
         +xSiBgV+EQcpTliax3Cot70rHWWxdVzKEU5eszgFdL2WwD3gLDl84Ta9WoCV8SdTaesm
         87z2Eh51Qa3fZng28MXzjQZAnbfcsDmSHIopUhJsFdBYG6n6xI0tjSLoTYGHLvjT0r5X
         zyXQmPEZat/zzwfztP8j73DRAmLLAJVIDBXMz8MXEYPMBksPutWBKQrYoFlxvkTrmeVG
         sUtAx7AKQJJGvdqlm/Ihmnpp2Ftrwcg57KC7/g7vt6udK/ORBi4F2vqGXKUTkQBb5YRM
         v0MA==
X-Forwarded-Encrypted: i=1; AJvYcCVch1BeI+jY6w2tcWCPFgXViM4+Lnk6qtik3BdFv2Gam9CCqFCEd/5Y7gGkcUzPOfWtft8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3bJcf6ilXJ8RBOGDLt1RfD9/9zY7X75GDFmfVbWL2gbzwrt6f
	EXhuBFoZVsNCgdbwDI1FIwAuIv22m4tfZ2c4nBxvOoFUOVtqW3GzHCTT
X-Gm-Gg: AeBDievn2E5sD4qMaVnIzxAxTWKT//jb0TkEhdw3eAZBk2fH+3H0ERX0cQlyJ4qyL4O
	etbFqeRxfIADVK1rVncSZEGNJwshC2u1d+eJIPM1j0pcr1Wgo+Ta6ZaqnVuznCyntRXQO6Bh8Hh
	76lZeLNJT+YDWnTIt9hGeqnAc80WLBmLt8qmRr5X3g1cvVjTCVzSDhh5y3ETyy6t6U62rs0k4vj
	i47Pn3OoA92wc7z+FAU9uh2BUwXj7MZqB/aA3fYBFVbVyVyLHGbGcB8wGTF7wFU2lX0o8MApy9O
	IOgzSyxi87/Fsdrzaf1ZThkpVd3PC/7p9kclcUGDrjt25G2EKBuYmw3/HPT50ilAVPie8z19ebU
	Rz15np6sEe4pkqgOBXBOk/5rQKEr5JgnLBHG2okPBzbc1HFAJuMwqZFcgJAW7612RkumwoZas38
	WZvPy+bRQ3ZWg6RGVtVRW2
X-Received: by 2002:a05:6a00:b88:b0:82a:7dfd:9757 with SMTP id d2e1a72fcca58-82f0c1c8bc9mr9516041b3a.4.1775973837453;
        Sat, 11 Apr 2026 23:03:57 -0700 (PDT)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b251esm7072645b3a.37.2026.04.11.23.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 23:03:57 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	emil@etsalapatis.com,
	leon.hwang@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 0/3] bpf: add the missing fsession
Date: Sun, 12 Apr 2026 14:03:43 +0800
Message-ID: <20260412060346.142007-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing fsession attach type to the BPF docs, verifier log and
bpftool.

Changes since v2:
- replace "FENTRY/FEXIT/FSESSION" with "Tracing" in the 1st patch
- v2: https://lore.kernel.org/all/20260408062109.386083-1-dongml2@chinatelecom.cn/

Changes since v1:
- add a missing FSESSION in bpf_check_attach_target() in the 1st patch
- v1: https://lore.kernel.org/all/20260408031416.266229-1-dongml2@chinatelecom.cn/

Menglong Dong (3):
  bpf: add missing fsession to the verifier log
  docs/bpf: add missing fsession attach type to docs
  bpftool: add missing fsession to the usage and docs of bpftool

 Documentation/bpf/drgn.rst                          |  4 ++--
 Documentation/bpf/libbpf/program_types.rst          |  4 ++++
 kernel/bpf/verifier.c                               | 10 +++++-----
 tools/bpf/bpftool/Documentation/bpftool-prog.rst    |  2 +-
 tools/bpf/bpftool/bash-completion/bpftool           |  2 +-
 tools/bpf/bpftool/prog.c                            |  2 +-
 tools/testing/selftests/bpf/prog_tests/exceptions.c |  8 ++++----
 tools/testing/selftests/bpf/verifier/sleepable.c    |  2 +-
 8 files changed, 19 insertions(+), 15 deletions(-)

-- 
2.53.0

