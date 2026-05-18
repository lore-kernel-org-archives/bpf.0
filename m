Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F24148850;
	Mon, 18 May 2026 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116149; cv=none; b=T8Bu5Nw/IfNK/IrvxKA//7hJk2aA/42NhhtarbXr9nVRBTk0MIhhb+3pIC44OuaWgN1I5X16U34EZUeasg1zk482qupA8Z7Tetenogz7fMAxAmhMWcvNFiQ9cbSu3Kf+r+M16HBkfrHMAjwam1mVi0peEK6eZs1mSX6RjMbAyjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116149; c=relaxed/simple;
	bh=Yk3219VG2ut6DPRJgK3Tl4N5fQt7vHJy9LEbePS13QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fq/4v3cly/EJkdijTF9FS06g6HZNsF02NXx7f7T3r3E709dzM5g7k5UeqtL0mGBCcTFjk0J5rDiEYMqW3eGxAZ3EzuDUEknH+IIHY2Z1csGl2XgjYWoxRJwa7ymo0x0v3Ko5kljQUA25rT1i4LU/Bb9EmVER3ExINYQKpPCWNro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ML3knJtl; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ML3knJtl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779116134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rd9b/2X0bEGP1sS/sz9x4vSzJm+NCcnN8TqOF/mxFJc=;
	b=ML3knJtlH6BcwK423T69osW1itHz5YqAZHhyVam1bK2JLyx+tP5J65VgG3J0AmCCUWMJRT
	el4ljJC+D3Jj0OLMPGtdNpqCmig3CHh1441IgS4fPwjbHhPohGqobyhZ8fnIkqldiuMDyD
	eHLNkIEgo6Kap9nUCO7L+0O3SbtBakA=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 0/5] bpf: Follow-up fixes for BPF syscall common attributes
Date: Mon, 18 May 2026 22:54:41 +0800
Message-ID: <20260518145446.6794-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Address sashiko reviews for BPF syscall common attributes series.

1. The tailing padding bytes in struct bpf_common_attr should be
   checked. [1]
2. There was a concurrent regression in syscall.c::map_create(). [2]
3. OPTS_VALID() was missing to validate the nested struct bpf_log_opts
   in libbpf. [3]
4. The token_fd should be -1 to avoid a valid token fd in test. [4]

A test is added to verify the fix #1.

The fix #2 is hard to be verified by test. So, I decide not to add a test
for it to avoid over-engineering.

Decide not to add a test for fix #3 to avoid over-engineering, as the
fix looks really simple.

Links:
[1] https://lore.kernel.org/bpf/20260513224823.6494FC19425@smtp.kernel.org/
[2] https://lore.kernel.org/bpf/20260512233658.CEED7C2BCB0@smtp.kernel.org/
[3] https://lore.kernel.org/bpf/20260512235629.C5CABC2BCB0@smtp.kernel.org/
[4] https://lore.kernel.org/bpf/20260513003358.55836C2BCB0@smtp.kernel.org/

Leon Hwang (5):
  bpf: Check tail zero of bpf_common_attr using offsetofend
  bpf: Fix concurrent regression in map_create()
  libbpf: Add OPTS_VALID() for log_opts in bpf_map_create
  selftests/bpf: Use -1 as token_fd in map create failure test
  selftests/bpf: Add test to verify checking padding bytes for BPF
    syscall common attributes

 kernel/bpf/syscall.c                          | 19 +++++++++----
 tools/lib/bpf/bpf.c                           |  3 ++
 .../selftests/bpf/prog_tests/map_init.c       | 28 ++++++++++++++++++-
 3 files changed, 44 insertions(+), 6 deletions(-)

-- 
2.54.0

