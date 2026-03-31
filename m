Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626403FF8B8
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774968878; cv=none; b=rfgY2ZSFMX4PabgyHgRE9bvoBLJEbUKq3FqKxJus0705HhWiZZNV8pcgIKB6bRcxI9eqBJ/Cs3ciddsqGL7Uepy7MCEgRXGJBKslG43pVdHFmx2xwYGLFb48VVkcXEHYSAAyfPeHgCYy4ZddVj6ITuagD313PJQEf8GrHnx3rOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774968878; c=relaxed/simple;
	bh=wmGctNvJm+LUvdvzxLmUY+Cdst0Fdd5k4gFWggYhe1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Il113TNWCNMAfHxIUSiHlw8vUIyGnyvNhNKlrUtlQ8Z9aDz2v3/c1sKbmIpULwovYgQfPQFWJ3hA23ajXhIIYvuKLpIgkfTlLd+B8rc+5VmUcTARJBf5TQWSSstkJhyKD4NU+JymWbZt/tNjz/5OFBbqe8Xs9qOSpZRDeJcTahc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QhpSbKGN; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QhpSbKGN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774968864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X3jet/uB7C0ONYzapS8AJ6DXNKMgEBrk+xtIraylg5Y=;
	b=QhpSbKGN3pESpZD2lYAg/gutJ/TIfyZESs6nwfaD4BIEzDmS73m91hLEKrdoO/WEd5dDvr
	3nSBsMdoqYxm3zw3DjydzKEKXukRScy1jMIeR4vepktnwb3NFGnqGqKxDVK2nL+nrJ2bxp
	6GGtzidI0i9bxzcw2zIuRFZmTDGbAKw=
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
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 0/2] bpf: Fix abuse of kprobe_write_ctx via freplace
Date: Tue, 31 Mar 2026 22:53:51 +0800
Message-ID: <20260331145353.87606-1-leon.hwang@linux.dev>
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
v2 -> v3:
* Add comment to the rejection of kprobe_write_ctx (per Jiri).
* Use libbpf_get_error() instead of errno in test (per Jiri).
* Collect Acked-by tags from Jiri and Song, thanks.
v2: https://lore.kernel.org/bpf/20260326141718.17731-1-leon.hwang@linux.dev/

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

 kernel/bpf/syscall.c                          | 17 +++++
 .../selftests/bpf/prog_tests/attach_probe.c   | 64 +++++++++++++++++++
 .../selftests/bpf/progs/kprobe_write_ctx.c    | 19 ++++++
 3 files changed, 100 insertions(+)

-- 
2.53.0

