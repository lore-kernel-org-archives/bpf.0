Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6096C1E5B9A
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771979654; cv=none; b=aAr6VnLG+KAcI6effcede7K06D+dUNxalG0YSquyMKFDiEDedRxupAunKw1jsXboVhwIq34yZPBsoCxw/5HkdSBdDXcwsEeMTLrXySOaAyL/Rjn++aAvdzP0H9pRFUdyX2GM2zKNc4v7e6R0vpVCOmC9Cd0fHYLHRM9rqvGVGW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771979654; c=relaxed/simple;
	bh=7S0ZAGEtN+MYa1b6Sg1G3e/c415FMUzoQXGMYFiY6oY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EbOVjc8TsfQ8AanyuMXIyrCMT+CjxMhDrgimQ21TGIl1OJEQIRlH2tFQnNubjiUY7oXQ0D21UMKItzmUJoZb7y9giupV6mlue7bH7hCc5x8Iw/2SzIUj6JmMCi/FVTxCl0bEz0OopjjvUI9PDYreLBsTWuiK6aV7TVCztZuHReY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Huax2na4; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Huax2na4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771979649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5YcB//ck1gWfDekLLfSSM3SiB/eEYrbR7pG+NGLy91E=;
	b=Huax2na47Rx6KDj7iuOhY4k0tHjl3hbLY5UKW+l0nGIbDq4QzpGJBV8smNlxZk0cWSDxU/
	QUYa2hqiPXwHE1A9m4kVCYApcs0QWHoeJ+L3FlOsB1bJO2VgpaEoOj7sn453IUQQ1W5Qbk
	9FHuwT6bjWFLKR3Qojmm0s2cGSFF5jw=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v1] selftests/bpf: Fix a memory leak in xdp_flowtable test
Date: Tue, 24 Feb 2026 16:33:51 -0800
Message-ID: <20260225003351.465104-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

test_progs run with ASAN reported [1]:

  ==126==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 32 byte(s) in 1 object(s) allocated from:
      #0 0x7f1ff3cfa340 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
      #1 0x5610c15bb520 in bpf_program_attach_fd /codebuild/output/src685977285/src/actions-runner/_work/vmtest/vmtest/src/tools/lib/bpf/libbpf.c:13164
      #2 0x5610c15bb740 in bpf_program__attach_xdp /codebuild/output/src685977285/src/actions-runner/_work/vmtest/vmtest/src/tools/lib/bpf/libbpf.c:13204
      #3 0x5610c14f91d3 in test_xdp_flowtable /codebuild/output/src685977285/src/actions-runner/_work/vmtest/vmtest/src/tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c:138
      #4 0x5610c1533566 in run_one_test /codebuild/output/src685977285/src/actions-runner/_work/vmtest/vmtest/src/tools/testing/selftests/bpf/test_progs.c:1406
      #5 0x5610c1537fb0 in main /codebuild/output/src685977285/src/actions-runner/_work/vmtest/vmtest/src/tools/testing/selftests/bpf/test_progs.c:2097
      #6 0x7f1ff25df1c9  (/lib/x86_64-linux-gnu/libc.so.6+0x2a1c9) (BuildId: 8e9fd827446c24067541ac5390e6f527fb5947bb)
      #7 0x7f1ff25df28a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2a28a) (BuildId: 8e9fd827446c24067541ac5390e6f527fb5947bb)
      #8 0x5610c0bd3180 in _start (/tmp/work/vmtest/vmtest/selftests/bpf/test_progs+0x593180) (BuildId: cdf9f103f42307dc0a2cd6cfc8afcbc1366cf8bd)

Fix by properly destroying bpf_link on exit in xdp_flowtable test.

[1] https://github.com/kernel-patches/vmtest/actions/runs/22361085418/job/64716490680

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

---

This should've been part of the recent series. I missed this locally
because the test is skipped if nftables is not installed.

---
 tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c b/tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c
index 3f9146d83d79..325e0b64dc35 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c
@@ -67,7 +67,7 @@ void test_xdp_flowtable(void)
 	struct nstoken *tok = NULL;
 	int iifindex, stats_fd;
 	__u32 value, key = 0;
-	struct bpf_link *link;
+	struct bpf_link *link = NULL;
 
 	if (SYS_NOFAIL("nft -v")) {
 		fprintf(stdout, "Missing required nft tool\n");
@@ -160,6 +160,7 @@ void test_xdp_flowtable(void)
 
 	ASSERT_GE(value, N_PACKETS - 2, "bpf_xdp_flow_lookup failed");
 out:
+	bpf_link__destroy(link);
 	xdp_flowtable__destroy(skel);
 	if (tok)
 		close_netns(tok);
-- 
2.53.0

