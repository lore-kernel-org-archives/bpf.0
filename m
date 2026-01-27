Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F2727A477
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531658; cv=none; b=ofunqZNAhRm02JO7RmLSZdnYRIDFNDzCXudzaposK828z2sdS6n4e/dr1etgEbmQEzAr6/p3fwyVNKbM3h/UO6VyDw4KbCghCjeXDuqT7p+QRdrXfTDwe3qoUtCdx8H4UVFDQfrtj0mi7/6mOWWJmRoJhQfZBa+JgZ/A34GgZ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531658; c=relaxed/simple;
	bh=psELCIfY+W4ONj905+j1vFlO5Yf6mkhivbJrVOMnDPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KJtjDWjeWFseS3YmbwEcjXmW+M8CT8FduZ+YCMTJX4wv4dBtL2m0gWx6Bn67d4zhg00GXtr50d9sScOdnfY1/bpm5i0JUbPfBz6U+4fDwiGcRTsV349jZDqG47FgNQL2R7Nvu2L1Fl8rbVuN5K46uPGSvEooGTT9Dq02UHteS6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BRJK7kqF; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BRJK7kqF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769531645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qVzkEJu0rwGv9GhSscFNxi7pazkxC01AqWhJ4PtbAR8=;
	b=BRJK7kqFv7WhgeaGPzXl1G7bDC4goqi3TlEQzgGws2bMWxApxlNxAWLIpNoV7i70r0pTgI
	yy7NkXzI17/2bvw027HbIv+ZLZoZyC4gG2JAWdSwlcbWC3CUBUlI7SD9jc2FbdosvVs22H
	w+kGgJgFS2eWE2yyK+dt4zDkHxsww78=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 0/2] bpf, arm64: Add fsession support
Date: Wed, 28 Jan 2026 00:33:42 +0800
Message-ID: <20260127163344.92819-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Similar to commit 98770bd4e6df ("bpf,x86: add fsession support for x86_64"),
add fsession support on arm64.

Patch #1 implements fsession support in the arm64 BPF JIT trampoline.

Patch #2 enables the relevant selftests on arm64, including fsession,
get_func_ip, and get_func_args.

All enabled tests pass on arm64:

 cd tools/testing/selftests/bpf
 ./test_progs -t fsession
 #135/1   fsession_test/fsession_test:OK
 #135/2   fsession_test/fsession_reattach:OK
 #135/3   fsession_test/fsession_cookie:OK
 #135     fsession_test:OK
 Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

 ./test_progs -t get_func
 #138     get_func_args_test:OK
 #139     get_func_ip_test:OK
 Summary: 2/0 PASSED, 0 SKIPPED, 0 FAILED

Leon Hwang (2):
  bpf, arm64: Add fsession support
  bpf/selftests: Enable fsession and get_func_ tests on arm64*

 arch/arm64/net/bpf_jit_comp.c                 | 66 ++++++++++++++++---
 include/linux/bpf.h                           |  7 +-
 .../selftests/bpf/prog_tests/fsession_test.c  |  2 +-
 .../selftests/bpf/progs/get_func_args_test.c  |  2 +-
 .../selftests/bpf/progs/get_func_ip_test.c    |  2 +-
 5 files changed, 66 insertions(+), 13 deletions(-)

--
2.52.0

