Received: from mta0.migadu.com (out-14.mta0.migadu.com [91.218.175.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D81A353ED9
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813752; cv=none; b=lTl88X7sB0AAuArypGb8rjHLir0kTj5bWEmPdTFC8BjnIWRN4l2HPvXPNGRnLB2iquhC1lriEmlg53BEmHdfzPyQnyv2Jj1UdDz+nv8EajSgu3L64XXPTo392PGGsi7W8uxTYXxa5ZzW5uqiGsGk7FvaHfyGlUbJQX0GivfohOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813752; c=relaxed/simple;
	bh=T1KEXbx4Yz9GAO6E3Pv8Mav6Z4XB2c8W/TEdwAmBmpQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tfqatDQ4NI7gCHIdI4I2antAoJTpPpbYO6FRzLIC1IVpTPJiZZhzGyd2RZtfBfD8/vnYKjf7kVlcnO4b9UuBj//TC3NZnr3D+x+3D8T8TkN7zfRi63IZk6tgzap+Z6R7q6dLIcjdeHxbKGefAuDdqE8Rs7u774aylvLgJSeMwSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qMyNuDw+; arc=none smtp.client-ip=91.218.175.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qMyNuDw+"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=T1KEXbx4Yz9GAO6E3Pv8Mav6Z4XB2c8W/TEdwAmBmpQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791813749; v=1; x=1792418549;
 b=qMyNuDw+5gtSX+sjlV4fSBuZZnZ64xQYkjEsG1efjaTm9/FGPTkUfCPcRtj0o4jBfyhfF5i8
 fUXee7COQq82ZFN0x/5HcuZCPXpSkbYN6KDxTyTXvCdvA1+klxmz6ZDa/7SW1e1621UCp93DTEq
 ClJoMfYaMwgQfYz13BqmF4uM=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id e984e808a0ba7d6d;
	Mon, 12 Oct 2026 14:02:29 +0000
X-Mizu-Trace-ID: e984e808a0ba7d6d
X-Migadu-Flow: FLOW_OUT
From: KaFai Wan <kafai.wan@linux.dev>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	KaFai Wan <kafai.wan@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/3] selftests/bpf: Fix prog_tests framework self-tests
Date: Mon, 12 Oct 2026 22:01:58 +0800
Message-ID: <20261012140202.2754552-1-kafai.wan@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three prog_tests framework self-tests fail depending on how test_progs
is invoked:

- ./test_progs -t prog_tests_framework/test_fail -v
  test_prog_tests_framework:FAIL:skip_cnt_check
  unexpected skip_cnt_check: actual 0 != expected 2

- ./test_progs -t prog_tests_framework_expected_msgs -v
  Caught signal #11!
  Stack trace:
  ./test_progs(crash_handler+0x38)[0x55620006fbb0]

- ./test_progs -t prog_tests_framework_compare_text -v
  test_prog_tests_framework_compare_text:PASS:mismatch_rc 0 nsec
  Caught signal #11!
  Stack trace:
  ./test_progs(crash_handler+0x38)[0x564ddbfcfbb0]

Patch #1 counts the subtests that actually ran, so the skip and error
count checks no longer fail when -t or -n filters out some subtests.

Patches #2 and #3 skip the subtests that inspect the log buffer when the
output is not captured, such as with -v in non-parallel mode, instead of
crashing on a NULL log_buf.

---
KaFai Wan (3):
  selftests/bpf: Fix prog_tests framework subtest count checks
  selftests/bpf: Skip expected_msgs subtests when stdout is not saved
  selftests/bpf: Skip compare_text subtest when stdout is not saved

 .../bpf/prog_tests/prog_tests_framework.c     | 34 ++++++++++++++-----
 1 file changed, 25 insertions(+), 9 deletions(-)

-- 
2.43.0
