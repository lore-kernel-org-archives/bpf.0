Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507AE3655E1
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784640711; cv=none; b=pskuVOGy7FBZcTKH3Ot3a9yeu7uxoEi+tynqZTggvpWhlDFDFInQu9EIng8YOqLIh84v8qtTEQVX5JTAG53PV0rWJBoxMemD44X0ZJnqTpnGaRXAJR7qTyZlLg+Ls1f6VAY9qSnjv7ElwmkMDoWO7nZGYmbQg31FueYZb0/rxZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784640711; c=relaxed/simple;
	bh=1Y4uCMaWFJ2YnJaUqugry8zOJdoCsJRnngLRIjXh9HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j/uSf4IwiFFJGtHLRTu6bcgdc0o8hMOXXsBAT/B0XoVe1U+05H4Bn0+z4+rDdhSkbGEVNkkHxz8+Tz0EY+JZ1kZO6bfVkv1i33zqYg/uVfWnz0ZBPb5NJHBgDTaRdn7qNG4Q9Ibi2lNzJCBW36TIrlzvZakti6G4W7vhZAR9gzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sbkg0ZT9; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sbkg0ZT9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784640695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UwoXfTfmep5EjRgLUdZq4lvJY8DxeJwoomAY6JwLMhg=;
	b=Sbkg0ZT9yL05MUIRhsvWH1vTL5S+7q8qMZNiD5MNMRJsASOsrB/ZtOu0fZP3p63PnCq1zW
	XWlCkLFpJFIJp14QlEBFus0/LQT3cGMqF9ud4+hbvHsSDnl2aV4/P7agtXzPptf4STxizO
	d2N2t42eiUtitsP78jctk+bth/4RRG8=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Jingguo Tan <tanjingguo@huawei.com>,
	Pu Lehui <pulehui@huawei.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Lin Ma <malin89@huawei.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 0/2] bpf: Fix WARNING in bpf_tracing_link_release
Date: Tue, 21 Jul 2026 21:30:33 +0800
Message-ID: <20260721133036.49265-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The trampoline could be corrupted by the blindly
'tr->flags = BPF_TRAMP_F_TAIL_CALL_CTX' in verifier.

1. A fexit attached to a tail_call_reachable prog.
2. Another fexit loaded with the same tail_call_reachable prog target.
3. Close the first fexit link.

[    3.410719] WARNING: kernel/bpf/syscall.c:3551 at bpf_tracing_link_release+0x53/0x60, CPU#1: test_progs/98
...
[    3.428793]  bpf_link_free+0x58/0x130
[    3.429293]  bpf_link_release+0x23/0x30

Fix the warning by updating 'tr->flags' with '|=' and lock.

Leon Hwang (2):
  bpf: Fix WARNING in bpf_tracing_link_release
  selftests/bpf: Verify no warning when close fexit link

 include/linux/bpf.h                           |  2 +
 kernel/bpf/trampoline.c                       |  7 +++
 kernel/bpf/verifier.c                         |  2 +-
 .../selftests/bpf/prog_tests/tailcalls.c      | 51 +++++++++++++++++++
 4 files changed, 61 insertions(+), 1 deletion(-)

--
2.55.0
