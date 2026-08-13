Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D491B442FDB;
	Thu, 13 Aug 2026 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613922; cv=none; b=HL9VfrhVkoYv6WhApZ9+DPobBz04tduQFMk5E/zEI38HYaqWacEIYYkQQDQIz0F28dNSfwMg0SWDhwjC/Xi1YabexZXT7ByKj/g6/PQw9KXH1lAj/ggJtor/efX7CLNkwq3Q8KBAVVfYmNRToeEdzP6UhEIjkM1uGzjmBUyXGAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613922; c=relaxed/simple;
	bh=dvS9w+6WN3ViYUcsfJtmAv0+KKS3atxKxLIM+Lpp2hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=j3bCZyTynpZ5/H2/NyznP0srTspBQvYFnn1yftGeNVdYFsnFAYm5tvziUz3LyNoN7JoclYUpir/6sI8vVprnsttE4A0lJfBc8u3hpRdzC2kEdCOCqdv0bPKLpPW0U643F0ozmFElxXQpPQ7crvhxNbWa/BBzkjTFal4L4V6fUuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F8uY7L+1; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F8uY7L+1"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0E9361A15EF;
	Thu, 13 Aug 2026 09:38:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D65B9602B8;
	Thu, 13 Aug 2026 09:38:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 272A411C4DC62;
	Thu, 13 Aug 2026 11:38:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786613911; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=F6Oh1RXLncYd5Y0wyXBG7Blpj19WHQ9/KQ6xnWk45w8=;
	b=F8uY7L+1kdhqmfUUhfec1LqTlgOMBdN2pyJR92oABOth4pkzjr9Bgv8OtOW0ciOVUMp2xN
	VAhNpJe9Nu763Jt1h4V9+H5Wu1wNqcB8IF98KYoKdhD3z/5yS7FZfoKbMA9BwGYpdVGGKy
	aUrk4VQEX0sYeKOM0OxO6zoj26P4TCs8lSbjbrsC2OPiZEkl1pYt91WJ6J0vWpPhOoecqe
	SfFByoLAcRCbzWgT56E+8pIRBezoFnbVXGCvfopP8SzBmAwrzP1fvh5fL+ml40Lts2G6Yk
	8SG9NsIJUlh9NBIqZI8JWUGe4PNhCyefUv7/63JuxNFq7KeQiCy/k+8yz7ZHXA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 13 Aug 2026 11:38:23 +0200
Subject: [PATCH bpf v4] selftests/bpf: allocate a larger timeout for
 connection
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260813-tc_tunnel_flaky-v4-1-3534df3fe930@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNTQ6CMBAF4KuYrq3pD1DqynsYY9oylSq2hFaiM
 dxdwIUa4vJN3nzviSJ0DiLarp6og95FF/wYsvUKmVr5E2BXjRkxwgoiKMHJHNPNe2iOtlGXB2Y
 CpKKS6opwNH61HVh3n8U90q1Fh/cx3vQZTJqsqVa7mEL3mHd7Opf/TvQUU5wxpXTOpVSZ3OkQU
 uP8xoTr7PfsI5SELwU2CkUuNCtFZZXIlwL/EihdChwTXIrCZkC0KQj/FYZheAH+NKDDSwEAAA=
 =
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
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>
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

Set a larger SO_SNDTIMEO/SO_RCVTIMEO for the connection step, and reset
it back to the timeout configured by the test once the connection has
succeeded.

Fixes: 99126abec5e5 ("bpf: selftests: A few improvements to network_helpers.c")
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Hello,
this is the v4 of the series aiming to reduce the flakyness of
tc_tunnel/tc_edt tests in CI. This revision takes a step back, based on
Ihor's tests,  and drops the poll loop in favor of a bare, larger
timeout value applied only for the connection step. The main downside
of this new mechanism is a slight increase of the duration for tests
expecting a connection failure. In my testing setup (x86-based Qemu on
my work laptop), I observed a ~10s increase (on a ~5m18 base for the
whole test_progs set).
---
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
 tools/testing/selftests/bpf/network_helpers.c | 34 ++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index db935a9d9fc1..89336201572f 100644
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
@@ -291,6 +293,12 @@ int client_socket(int family, int type,
 	return -1;
 }
 
+static int connect_timeout_ms(const struct network_helper_opts *opts)
+{
+	/* Enforce a minimum connect timeout value */
+	return MAX(opts->timeout_ms, CONNECT_MIN_TIMEOUT_MS);
+}
+
 int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t addrlen,
 		    const struct network_helper_opts *opts)
 {
@@ -305,13 +313,33 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 		return -1;
 	}
 
+	/* Override timeout configuration with a larger value for the
+	 * connection
+	 */
+	if (settimeo(fd, connect_timeout_ms(opts))) {
+		log_err("Failed to set connect timeout");
+		goto close;
+	}
+
 	if (connect(fd, (const struct sockaddr *)addr, addrlen)) {
-		log_err("Failed to connect to server");
-		save_errno_close(fd);
-		return -1;
+		log_err("Failed to connect");
+		goto close;
+	}
+
+	/* If the timeout configured by the test is different from the
+	 * connect timeout, restore it
+	 */
+	if (opts->timeout_ms != CONNECT_MIN_TIMEOUT_MS &&
+	    settimeo(fd, opts->timeout_ms)) {
+		log_err("Failed to set timeout for connected socket");
+		goto close;
 	}
 
 	return fd;
+
+close:
+	save_errno_close(fd);
+	return -1;
 }
 
 int connect_to_addr_str(int family, int type, const char *addr_str, __u16 port,

---
base-commit: 673b1f0272d7dedeec78dee2b47040481e4332ba
change-id: 20260710-tc_tunnel_flaky-27e9a191bd03

Best regards,
--  
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

