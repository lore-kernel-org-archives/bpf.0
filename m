Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2363E9C18;
	Fri, 14 Aug 2026 07:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691611; cv=none; b=hGu7sPaqfu4plXay1sKOgDj/y7PgZk3SOaVjmRNbTKTQkL79jhKIvsNGJdmdsr5St5u3Nidj84l4HF+tHuoHnmQVM20YOIqjBlkGWEhw//A6f2YuFOWVaATA64vuFAfX3E+i7j++VEkHHLkGw3jT58E7nSj8rljMNi5aagUIAu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691611; c=relaxed/simple;
	bh=o3/AKJ1BkfhYXq+Dg59HF5Hxq3bczX2JLmtlREB/jpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QxjC2xd31LKCYev+4l1n8KumHFwrp0HIVI/1QGU9S201LABo8P0BI90NsPGR2J6YLqWXTLJq1UjcYCHaZXZKDAGYx46KgNpeyD3337H0EZp5MEpcKCTRieZ4iVudbl1X61Lcd0N+HQiML5vyRbfIOJTjcD920N1c0VdQsRJMXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wrFIonor; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wrFIonor"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 194F51A162B;
	Fri, 14 Aug 2026 07:13:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DFD636046D;
	Fri, 14 Aug 2026 07:13:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 07EE211C4E895;
	Fri, 14 Aug 2026 09:13:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786691591; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YiK4yiTW2Lx/mwsS/lDLH9lOApYiCd32mWNiNG38Bxw=;
	b=wrFIonorpQUlxtkTaSaqE554IeXUFP0EHNrxaINcgSXFTfzWUOSBk2Pp6xSwiGPMZUu7I9
	7FnisLw605/ywpnmVwnf/34em421xMvrZd1kdckg5Ge1BwO5xUlKZSq/Y7lyQbOyjJWAqy
	B+iTx+HPsY1G4WE7tM/q9c2QGAGK8+cCyCkQrwFegV1UkKwOkL9Gm2/+hVS1ZJlx2YSOYJ
	CsRuZp9rLyxDBsl5fsJ2molFKDM7iw+Dy79yOQ3TL+eEEEVcBYY40XymJ1a1TsMZ19s0TT
	qZbL2qHaBv2me+YTRuhkecLnlWcCiDjIl8UbHFmfmJwWpZ0v1u9KPqsjKw2joA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 14 Aug 2026 09:11:28 +0200
Subject: [PATCH bpf v5 2/2] selftests/bpf: allocate a larger timeout for
 connection
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260814-tc_tunnel_flaky-v5-2-5b93d030c42c@bootlin.com>
References: <20260814-tc_tunnel_flaky-v5-0-5b93d030c42c@bootlin.com>
In-Reply-To: <20260814-tc_tunnel_flaky-v5-0-5b93d030c42c@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
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

Set a larger SO_SNDTIMEO/SO_RCVTIMEO for the connection step, and reset
it back to the timeout configured by the test once the connection has
succeeded.

Fixes: 99126abec5e5 ("bpf: selftests: A few improvements to network_helpers.c")
Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 36 ++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index cdf2d7d3ab32..8c9236c0a5a5 100644
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
@@ -305,13 +313,35 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 		return -1;
 	}
 
+	/*
+	 * Override timeout configuration with a larger value for the
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
+	/*
+	 * If the timeout configured by the test is different from the
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

-- 
2.55.0

