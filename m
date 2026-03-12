Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37712BD5A8
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 07:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773300367; cv=none; b=dx9aYEEq8w6WMFaas5G2silVUNFTmBgYyMtFz0a1EAEDvXv+pdPu3IARwAbmPGen+oDsGmVN4a5OmTCtSt/KhERJ45uJb0uyeV9bwlsWpBpGNesve/lyWRyS4505x2JBhih0YvadbhJmly8gAXrJww4yfCJ17IOKN0CJ59cs1Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773300367; c=relaxed/simple;
	bh=OyUkZW+xDkqR8cfyu8NdoZsHWfNlfPEk6iBKWvt28fY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kOzEyM9ix8TlyHittvpLoz41GZz/k9p4rMyG/cubZa4Q2nXlxdt/SJDGgydat2ER7hFFfIQ1zw8WZm4UzW8TuRcIpqXlj+hi3AmsGnE/w0bcQzeyj5DJOPXeiww8ldcJPRF6+kW5HLnctSaxAyRFbaYwIVLwc81iTJsrYv6Y6Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jS9R1ZdV; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jS9R1ZdV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773300362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5UFGjeC6UydJCvXkg1Dj1jw+Nq0p5HrafCwwFZ8Izu4=;
	b=jS9R1ZdVYPrCF4BXDMXSRthDYskWq3XZl29XC732R7pNsMdj082hcfuXYSGCYndMcpPPnL
	5IgBZxHfHDzD6Y04nh0J9eQBaWDxG+vmwPuU4L2kiYde5U52IYWGhN11eQLk+Uk363QEUf
	ICOKcWlUXWD9lL5OxVV3E15RpjA3gic=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
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
	Shuah Khan <shuah@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v1] selftests/bpf: Fix sockmap_multi_channels reliability
Date: Thu, 12 Mar 2026 15:25:44 +0800
Message-ID: <20260312072549.6766-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Previously I added a FIONREAD test for sockmap, but it can occasionally
fail in CI [1].

The test sends 10 bytes in two segments (2 + 8). For UDP, FIONREAD only
reports the length of the first datagram, not the total queued data.
The original code used recv_timeout() expecting all 10 bytes, but under
high system load, the second datagram may not yet be processed by the
protocol stack, so recv would only return the first 2-byte datagram,
causing a size mismatch failure.

Fix this by receiving exactly the expected bytes (matching FIONREAD) in
the first recv. The remaining datagram is then consumed in a second recv
block, which is only reachable for UDP since TCP's expected already
equals sizeof(buf).

Test:
./test_progs -a sockmap_basic
410/1   sockmap_basic/sockmap create_update_free:OK
...
Summary: 1/35 PASSED, 0 SKIPPED, 0 FAILED

[1] https://github.com/kernel-patches/bpf/actions/runs/22919385910/job/66515395423

Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Fixes: 17e2ce02bf56 ("selftests/bpf: Add tests for FIONREAD and copied_seq")
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c    | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index dd3c757859f6b..d2846579285f2 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -1298,10 +1298,23 @@ static void test_sockmap_multi_channels(int sotype)
 	avail = wait_for_fionread(p1, expected, IO_TIMEOUT_SEC);
 	ASSERT_EQ(avail, expected, "ioctl(FIONREAD) full return");
 
-	recvd = recv_timeout(p1, rcv, sizeof(rcv), MSG_DONTWAIT, 1);
-	if (!ASSERT_EQ(recvd, sizeof(buf), "recv_timeout(p1)") ||
+	recvd = recv_timeout(p1, rcv, expected, MSG_DONTWAIT, 1);
+	if (!ASSERT_EQ(recvd, expected, "recv_timeout(p1)") ||
 	    !ASSERT_OK(memcmp(buf, rcv, recvd), "data mismatch"))
 		goto end;
+
+	/* process remaining data for udp if secondary data is available */
+	expected = sizeof(buf) - expected;
+	if (expected) {
+		avail = wait_for_fionread(p1, expected, IO_TIMEOUT_SEC);
+		ASSERT_EQ(avail, expected, "second ioctl(FIONREAD) full return");
+
+		recvd = recv_timeout(p1, rcv, expected, MSG_DONTWAIT, 1);
+		if (!ASSERT_EQ(recvd, expected, "second recv_timeout(p1)") ||
+		    !ASSERT_OK(memcmp(buf + sizeof(buf) - expected, rcv, recvd),
+			       "second data mismatch"))
+			goto end;
+	}
 end:
 	if (c0 >= 0)
 		close(c0);
-- 
2.43.0

