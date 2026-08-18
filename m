Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B44B3EC69A
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078600; cv=none; b=Jr0PSSaxuBywQuocK5u6hdOiUBAts96F4FWWolMwamOvsEvLgypliQD4vrFrSalEYsqEymOwzQPvw3xJRRYoOL9edev3wQYXcnLkcpiqjNix0hzeKKhRoy/SEb7QEdSM+82FnnSutVEEwc9J9Ufmx5Mne2qhmB3j+iqt68EBNws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078600; c=relaxed/simple;
	bh=kAEDJCPqyoKjD+l/lDLobuvNq/DEFL9L2BSzanJWrbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jED4YeQrRVD9s1893QqsFGR+GWDqiVB3norAFaz9jytN2lQ0moiBhvHhg2NFfPESb+bsE6Lzelj2yf8HmI2JLyJlGXD6gXRuO9+WXf6rMgxr60qfujnWwB9niCT//a96L3kczBCqHoVZbQ5vcmtAnqnRlTSuzSH2ZPp4OGqioIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tL1u9lqR; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tL1u9lqR"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 331494E412B1;
	Tue, 18 Aug 2026 18:43:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 05BE760355;
	Tue, 18 Aug 2026 18:43:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD62C11C74E6D;
	Tue, 18 Aug 2026 20:43:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787078590; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Ap51WNcGdd25uy5SZ78+w9tj0DK1Y5FTnSNfvb7SrCc=;
	b=tL1u9lqRCDzPzEOEL/a2Nrkv16v2aOp/n5fLRQHHs4vvZO+e1Tc3Xr89Hd9EQBFvN2LTJs
	Nmvmpsg0axgdHaoGbJT42Eq/EL6W7ojx+CKVPds3eOUvP5hSDIhmyp7SiTbWyDJLk3BDzP
	Xlch81mADE1egjle1dzk9EmwgzC02JIfDhOP+uxUAnLq3SeDXteiW/xlk0CMxqlTBc93Vh
	GcUZMGLbsPmVSLwVP6hjurrqxrmmpPy5NyGwJBEAD1DgcqVHfpo88blOUVvBxJC8TDWhc1
	a6nP3YuNwR4PLhVVNz1r8xgvXbdKkhetE0yNMkZnwTj2o6noK9mwv0pDbUKQjA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Tue, 18 Aug 2026 20:43:00 +0200
Subject: [PATCH bpf v7] selftests/bpf: allocate a larger timeout for
 connection
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-tc_tunnel_flaky-v7-1-aec161e74ef2@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XQzU7DMAwH8FeZcibIifPRcOI9EJqS1GGBrp3ar
 mKa9u5k5UBR4GjL/vkvX9lEY6aJPe2ubKQlT3noS2EfdiwefP9GPLelZhKkASuAz3E/n/ueun3
 q/MeFS0vOCydCC8jK1mmklD9X8YWFU2Kv383pHN4pznfrPnbI0zyMl/XuItbhf08sgguupPdBo
 3NeuecwDHOX+8c4HFd/kT9CA1gLsghG2yAb2yZvdS3gRhCiFpADb6xJiiBEA1gLaiv8kUGVDKh
 RtQkTOYRa0FtB1YIuGXRwWF4NUclYC2Yr2FowJUMEGWNLjbJJ/hZut9sXRuEvrhECAAA=
X-Change-ID: 20260710-tc_tunnel_flaky-27e9a191bd03
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Some tests, like tc_tunnel or tc_edt, sporadically fail in CI with the
following logs:

  (network_helpers.c:309: errno: Operation now in progress) \
    Failed to connect to server
  send_and_test_data:FAIL:connect to server unexpected error: -115

This is due to SO_RCVTIMEO and SO_SNDTIMEO being set on the client
socket (see settimeo() in client_socket()), allowing connect() to return
an error and to set errno to EINPROGRESS instead of ETIMEDOUT.
Increasing the timeout value for those tests is likely not a good
solution (and it has already been done by commit 2790db208b44
("selftests/bpf: Improve tc_tunnel test reliability")): some tests
expect some data transfer to fail, and so the timeout value would
increase overall test execution duration again (not only the connection,
but any socket operation).

Another solution is to allocate a timeout budget specific to the
connection: we can apply a larger timeout only for connections, and once
the connection is established, set back the timeout configured through
opts->timeout_ms; this would allow connection to succeed under heavy CI
load, while keeping timeout reasonable for the rest of the test traffic.

Create a dedicated connect helper that sets a large timeout for the
connect step, tries to connect, and if successful, finally sets the
timeout value to the one configured by the test.

Fixes: 99126abec5e5 ("bpf: selftests: A few improvements to network_helpers.c")
Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Hello,
this is the v7 of the series aiming to reduce the flakyness of
tc_tunnel/tc_edt tests in CI. This revision refactor a bit the new
connect timeout logic, and makes sure to apply the new logic to the
other connect() call in connect_fd_to_fd, as suggested by Daniel.
---
Changes in v7:
- Unwrap line in connect_fd_to_fd
- Link to v6: https://patch.msgid.link/20260817-tc_tunnel_flaky-v6-1-c02ccde847f2@bootlin.com

Changes in v6:
- Factor settimeo/connect/settimeo in a dedicated helper
- Apply the same strategy to connect_fd_to_fd
- drop comment-style updated patch, applied separately by Daniel
- Link to v5: https://patch.msgid.link/20260814-tc_tunnel_flaky-v5-0-5b93d030c42c@bootlin.com

Changes in v5:
- reformat multi-line comments
- collect Ihor's Acked-by
- Link to v4: https://patch.msgid.link/20260813-tc_tunnel_flaky-v4-1-3534df3fe930@bootlin.com

Changes in v4:
- dropped the polling loop in favor of a larger, connect-specific timeout
- drop timeout configuration from tc_edt test
- Link to v3: https://patch.msgid.link/20260811-tc_tunnel_flaky-v3-0-876f4e0bc603@bootlin.com

Changes in v3:
- set errno before logging errors
- respect time budget set by
- respect opts->timeout_ms when polling: only poll for the remaining
  time not already consume by connect()
- keep polling if poll returns with EINTR
- reorder early returns and add intermediate variables to clarify code
  flow
- Link to v2: https://patch.msgid.link/20260803-tc_tunnel_flaky-v2-1-657b287dfa75@bootlin.com

Changes in v2:
- drop unneeded initialization
- add back error message for immediate connection failure, and slightly
  reword the async connection failure error message
- Link to v1: https://patch.msgid.link/20260710-tc_tunnel_flaky-v1-1-42aab5399a49@bootlin.com

To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/testing/selftests/bpf/network_helpers.c | 46 ++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index cdf2d7d3ab32..d27dc79475de 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -49,6 +49,8 @@
 			errno = __save;					\
 })
 
+#define CONNECT_MIN_TIMEOUT_MS	5000
+
 struct ipv4_packet pkt_v4 = {
 	.eth.h_proto = __bpf_constant_htons(ETH_P_IP),
 	.iph.ihl = 5,
@@ -291,6 +293,37 @@ int client_socket(int family, int type,
 	return -1;
 }
 
+static int connect_with_timeout(int fd, const struct sockaddr_storage *addr,
+				socklen_t addrlen, int timeout_ms)
+{
+	int connect_timeout_ms = MAX(timeout_ms, CONNECT_MIN_TIMEOUT_MS);
+
+	/*
+	 * Override timeout configuration with a larger value for the
+	 * connection
+	 */
+	if (settimeo(fd, connect_timeout_ms)) {
+		log_err("Failed to set connect timeout");
+		return -1;
+	}
+
+	if (connect(fd, (const struct sockaddr *)addr, addrlen)) {
+		log_err("Failed to connect");
+		return -1;
+	}
+
+	/*
+	 * If the timeout configured by the test is different from the
+	 * connect timeout, restore it
+	 */
+	if (timeout_ms != connect_timeout_ms && settimeo(fd, timeout_ms)) {
+		log_err("Failed to set timeout for connected socket");
+		return -1;
+	}
+
+	return 0;
+}
+
 int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t addrlen,
 		    const struct network_helper_opts *opts)
 {
@@ -305,8 +338,7 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 		return -1;
 	}
 
-	if (connect(fd, (const struct sockaddr *)addr, addrlen)) {
-		log_err("Failed to connect to server");
+	if (connect_with_timeout(fd, addr, addrlen, opts->timeout_ms)) {
 		save_errno_close(fd);
 		return -1;
 	}
@@ -376,20 +408,12 @@ int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms)
 	struct sockaddr_storage addr;
 	socklen_t len = sizeof(addr);
 
-	if (settimeo(client_fd, timeout_ms))
-		return -1;
-
 	if (getsockname(server_fd, (struct sockaddr *)&addr, &len)) {
 		log_err("Failed to get server addr");
 		return -1;
 	}
 
-	if (connect(client_fd, (const struct sockaddr *)&addr, len)) {
-		log_err("Failed to connect to server");
-		return -1;
-	}
-
-	return 0;
+	return connect_with_timeout(client_fd, &addr, len, timeout_ms);
 }
 
 int make_sockaddr(int family, const char *addr_str, __u16 port,

---
base-commit: 530113d7299dab089435a6cd772c87fa4e0e40eb
change-id: 20260710-tc_tunnel_flaky-27e9a191bd03

Best regards,
--  
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

