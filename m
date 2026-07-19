Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127A33612CF
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784460956; cv=none; b=aG5Z+RvwwpoiZBSqqLq8zCOg4Y64P+IfRh+wymc8OYc7NNWROg36CMwUM3L9qcD6PbeNpysLu0rYTXKI1i/OUNVojF4HBuRbDTNI3PcgdEDQ5QFmr+ZAbgXDuuVLnJrPsdOpCJjZEMX37p9PAO5D4AB/xj7OU6Fr7aB2AKoBEB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784460956; c=relaxed/simple;
	bh=PB/eFiUDswq6btu7wgrrxP0Eu5jaApzpSDXw4EzGfTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G1z2aVbFaGPeRQhZ+BH2mOj71rBX+QjxlLHevF7jIWLb2SwweRotBF/0c+RZYvcXQemcHZZY/zqrqmj9QL2YIqQz6FJZqNR+l9qi19tMZVDmGRnR68rpP5KzQRmXAEmO4giYhzdnw0sOtXHhfnJjG4ZvrLlExbpcmh0shRriETQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzfU1cbn; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzfU1cbn"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-4700bd8aed1so723820f8f.1
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 04:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784460953; x=1785065753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IG/JejKWQ2cH7Zlw0leeKV8ROhlzIkblKJBXg0gnDyU=;
        b=RzfU1cbnUW8XjPWQKUAo8b79bWDxf9T46JRHd7RYKdCV0yEAn4vjU0DxHyIjnAnd0C
         nWxNoMs86E7kKFfuW5VhaqvYMf6jKC1jwBjVjXbaXPJVCVejIaulxLfSJtcPztV8EBvX
         Xfv1Oum8YlktS5anGiIFNQzRcL7Q9BYiHhtn8Ai0qFMZQKQk9/+DG/bOW5Kf6XAHBYtO
         kph9o52OQ10SY8QXSIs4wUwAuvLekVTSYZd1LKbkDFJufLgGV1FD+OxShVrglNKpPSlc
         SZ2Xa2vtNnVtNI2kgOsfx74wMiswPeKziRUyoaCb4bUdmJhLzAVqV8+C2UtI+NkPCczT
         HnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784460953; x=1785065753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IG/JejKWQ2cH7Zlw0leeKV8ROhlzIkblKJBXg0gnDyU=;
        b=lvi3a/+lMkaDDnl2bIo1yLpSZO1szZlEM5JL+cIPyt68kVN1ttAZzFWEM2EcxutQs+
         M/dj548/BpB7neJA3mhC6vXUAYG21gaZ4h64345WOHhbe62vo4VfZsgALFxNJefYTaHR
         SjQYxgmd5F1TNZ0vEZ1hxm18GDAd7AvKy7PbGu1cRsUgGJFxpddX/BULFbTKqGRDoNXK
         C+aDjuhiCTZhyJwEDiGxIypsyUdHJg9l14oPMaK43UKXaGZin/p+w9oKTYT42XzmL6F0
         padFtQmRPe7wguO+NZx0tBCbxsgti/n1Xx2ZE7inMXQN21VxpBMPV/Zd0sB3sXVrOySx
         kDdg==
X-Gm-Message-State: AOJu0YwHQCt1XxTBlt7FM3Tlm4Vuh9zPNsC4hK6Cm32mo3nKVnL0ecrO
	P/5a4y8Nv+IPWBZaylOfVkwuC0yya5m5fFzpPnN7OAwJjdEDLo2q7xLgDa+7wJXh
X-Gm-Gg: AfdE7cnP3E4fI4tCuo2KUvYppUXsM3YYV4BtdDxiWz5ajWB2VgX1wJgrU2sq4vbcmU0
	+0ji17kAruyvqC0A7/gfJ1XX+iHKlpCeUiLOQPkMnB4iH98NhsrrC6nhicsil29MZy/JG5YGG80
	Jslmb8hrA/w7TmXoPBMM8cQWz7KOxJg6/cRS7RlLLN2Y5y4iYm9bxDv7dmDMMsm0GU2TEprvNDl
	nWXy6uz72dwJ2P3Ca65sxtDVdKKRGBsPF69S+Ajb/NoOaJCFp1LWOapsyw5KIJKf2Ay7I9+CBxV
	pqKs8kRNMEdhGxB/iXG3w/pBqFHERa4qPHG7+Rr7dZrdZjA09TFGmTlvwUVb9fY6Ssr0aH6a2oj
	+lYUMyJWAzHlzmOlSaK/hjdkQS69J7fezOK+mCD1v/jFokQmbC6ONvGa0e6xJ0n0TOuRz3PojMK
	6QjeaJYFg1Eq8qSSnc++uHWXKOO32ED5pwhjFbP7kOZ9a0btC5w2AwgbuqWMx/UxOIFPyzHT2Ce
	y3LUtZ4OV6NlO5QE6ENjS/7PuXyBhJAX/bweqdv9+p1
X-Received: by 2002:a05:6000:46d9:b0:47f:6e8b:699c with SMTP id ffacd0b85a97d-47f6e8b6bcdmr3925476f8f.14.1784460952994;
        Sun, 19 Jul 2026 04:35:52 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e519f4sm19657181f8f.14.2026.07.19.04.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 04:35:52 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/2] Open up res_spin_lock for tracing programs, fix is_tracing_prog_type()
Date: Sun, 19 Jul 2026 13:35:48 +0200
Message-ID: <20260719113551.1294284-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=memxor@gmail.com; h=from:subject; bh=PB/eFiUDswq6btu7wgrrxP0Eu5jaApzpSDXw4EzGfTQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIStmcxfPn4OrVn7un2W/68aT9Xu+9xqKyrLN8z7xgKvi+ L/XkpEHOkpZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRPZcY/kr/XT05/YrA0zWR XlfnTkqNYjP/ubx/SqBb3pXDG80SLbcx/BVM/Pj/+1J9e15pId+3PJO0M6r+cNpPTlc6+2d1tII kOy8A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Patches in the set first open up res_spin_lock in all program types. The
second patch goes back to addressing the technical debt highlighted in [0].
While for programs affected by the second patch don't need res_spin_lock
to be opened up (since it was already allowed in those program types due
to the oversight in is_tracing_prog_type()), it is timely to do so now.

  [0]: https://lore.kernel.org/bpf/DJ3W8IZ08WBT.VTRTP72FSWVO@gmail.com

See commits for details.

Kumar Kartikeya Dwivedi (2):
  bpf: Allow bpf_res_spin_lock() in all contexts
  bpf: Fix is_tracing_prog_type() to cover fentry/fexit/fmod_ret

 kernel/bpf/verifier.c                         | 48 +++++++++++--------
 .../selftests/bpf/prog_tests/linked_list.c    |  6 +--
 .../selftests/bpf/prog_tests/map_btf.c        | 19 ++++----
 .../selftests/bpf/progs/map_in_map_btf.c      |  2 +-
 .../selftests/bpf/progs/normal_map_btf.c      |  2 +-
 .../selftests/bpf/progs/refcounted_kptr.c     | 10 ++--
 .../bpf/progs/refcounted_kptr_fail.c          |  5 +-
 .../bpf/progs/verifier_helper_restricted.c    |  4 ++
 8 files changed, 51 insertions(+), 45 deletions(-)


base-commit: ecf11bc5f56abb3a2219a8c75e8a5b54467d1781
-- 
2.53.0

