Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6DA394483
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534678; cv=none; b=pO1J9gndxf1+BtXYbhQjWJHNalk/Py1wjzQUoI1uDFtIcl3oTGE3JK8c09zYUd+pQ/I5Dtu/0G/vvE54Y2I61VRJzrdXbUEIkmQEBN+/WI3RerNh/s8zQDZh+x1quF+UuabZTFihIzpWOi4B19MkQLWbogAafXCm/eZXWnEQbJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534678; c=relaxed/simple;
	bh=NMScAA6hNVmNhCc8Muq8ntdk+FO1XR4h9y05BqtAR28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ikq77RzcicU7HeBM0rfMpO8nsmZxeUc2Tpbbv/gn6+NpF7kzs06M2dpNVc487tteWtEN8TMWupvSw/pyf3y7Owkfn0zEMGDfb4ofTKmzaUbvTElSYGxULQ5CcjdVRy+XwPERi3uh/Y226JElqm2p5nKgax4mRPT0r/PBqWmBokE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V1AS4OB2; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V1AS4OB2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774534660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rm8TkcxUTuxeADC4a4Qleb3gNKfjlb2uAkIj4nzO8I8=;
	b=V1AS4OB2ROL19/k7rMJeejGVR2Quufrho6C96IVznPj69GqjQclWAZgrU/oA087I4uot4f
	4JFOIZax5g5l6Tws+wIEk569g6E0smT01FQYhby6Cs9k4Nnp4nnwSdRCfehYKw3g0bMoAj
	MIBYZfcnvv9Ok81+se5vXoWzCa6XiHk=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	Leon Hwang <leon.hwang@linux.dev>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 0/2] bpf: Fix abuse of kprobe_write_ctx via freplace
Date: Thu, 26 Mar 2026 22:17:16 +0800
Message-ID: <20260326141718.17731-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The potential issue of kprobe_write_ctx+freplace was mentioned in
"bpf: Disallow !kprobe_write_ctx progs tail-calling kprobe_write_ctx progs" [1].

It is true issue, that the test in patch #2 verifies that kprobe_write_ctx=false
kprobe progs can be abused to modify struct pt_regs via kprobe_write_ctx=true
freplace progs.

When struct pt_regs is modified, bpf_prog_test_run_opts() gets -EFAULT instead
of 0.

test_freplace_kprobe_write_ctx:FAIL:bpf_prog_test_run_opts unexpected error: -14 (errno 14)

We will disallow attaching freplace programs on kprobe programs with different
kprobe_write_ctx values.

Links:
[1] https://lore.kernel.org/bpf/CAP01T74w4KVMn9bEwpQXrk+bqcUxzb6VW1SQ_QvNy0A4EY-9Jg@mail.gmail.com/

Changes:
v1 -> v2:
* Drop patch #1 in v1, as it wasn't an issue (per Toke).
* Check kprobe_write_ctx value at attach time instead of at load time, to
  prevent attaching kprobe_write_ctx=true freplace progs on
  kprobe_write_ctx=false kprobe progs (per Gemini/sashiko).
* Move kprobe_write_ctx test code to attach_probe.c and kprobe_write_ctx.c.
v1: https://lore.kernel.org/bpf/20260324150444.68166-1-leon.hwang@linux.dev/

Leon Hwang (2):
  bpf: Fix abuse of kprobe_write_ctx via freplace
  selftests/bpf: Add test to verify the fix of kprobe_write_ctx abuse

 kernel/bpf/syscall.c                          |  5 ++
 .../selftests/bpf/prog_tests/attach_probe.c   | 64 +++++++++++++++++++
 .../selftests/bpf/progs/kprobe_write_ctx.c    | 19 ++++++
 3 files changed, 88 insertions(+)

-- 
2.53.0

