Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5072F44A3E2
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458403; cv=none; b=bUTo1wOPth1ucff4sVwv/gcYg2SY3wZFbEGaVjeyS79F0L6Mc0TfTAENkr5ItUtekP2W3tteWxuirkpO11vx8Q2pH+x5sxdCcO+Bz4t7QQ4hAIwj8Z8mWfqYPDLgm09ixgyGLDU+zbL6yk/Ur33clgKwqr2/YexjmEfuataF4kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458403; c=relaxed/simple;
	bh=t34v5pofXCcvsJml/SmKoD7OcpnsCoV22qyaPqthfeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZeW8nAm3GBpwc4OYAs7LglhYyhR6ui/JKCb9RUEvnS/jr0DVNfbAGhTMXCFfdcSAAAzhHRKZIjxqcZi/k9C5xkSat7GM2lPh/xmLcfJxh55yfMn7/9gBzp3YW4Fnc+ZjPZTj7jUPD7yT8XS/mE0Gy/1p0+npAmaQVpBRb7p2dzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TErAflpw; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TErAflpw"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 71F781A1570;
	Tue, 11 Aug 2026 14:26:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3EC866033C;
	Tue, 11 Aug 2026 14:26:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6403611C48D16;
	Tue, 11 Aug 2026 16:26:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786458391; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PHSRe3UI99cyzDoEYGH3n3eZ/Qu3PVCTNTZCUoD2LD8=;
	b=TErAflpwOC/MwI9I1E9FmyfB/wDF6DR9C6J5ztre4FOP2VYrl5LqsB7VfqOvKvJ9ErAEEp
	XpzYplJmyvImZNUbF4qFkxUSnkyAnDreBxnom7Qxegh2VPqp1LUye7ucV14277MYakbiQo
	96b7HpFupwzRVQczFm/EBdmLNC5oatUjDAIuZWyODrjDAXtyz0PuoGRpp26GRUEweoZ6RE
	1+W5jr+Ovor5ZH1tZ0uupyjIAUt57l6rjsSYiNCM3fupy4iOe5T1uPoL98g36pLX3JQwvA
	oXuMwvEU2CN0iDTK5AZNCalwh9hhnR+I4Ar+W6ing78AkdfLRfc+cm9KrYLEpQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Tue, 11 Aug 2026 16:26:12 +0200
Subject: [PATCH bpf v3 1/2] selftests/bpf: keep polling connection that is
 still in progress
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260811-tc_tunnel_flaky-v3-1-876f4e0bc603@bootlin.com>
References: <20260811-tc_tunnel_flaky-v3-0-876f4e0bc603@bootlin.com>
In-Reply-To: <20260811-tc_tunnel_flaky-v3-0-876f4e0bc603@bootlin.com>
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
an error and to set errno to EINPROGRESS instead of blocking until
connection result is known. Increasing the timeout value for those tests
is likely not a good solution (and it has already been done by commit
2790db208b44 ("selftests/bpf: Improve tc_tunnel test reliability")):
they involve subtests that expect the connection to fail, and so
increasing the timeout value would increase overall test execution
duration again (not only the connection, but any socket operation).

Another solution, as documented in man 2 connect, is to poll the socket
for POLLOUT once connect has returned EINPROGRESS, and to get the actual
connection result through getsockopt: this allows to keep the overall
timeout values low for the general traffic, while letting a chance to
the connection to succeed even if CI runners are loaded.

When connect() returns EINPROGRESS, poll the socket for POLLOUT and
check the connection result via getsockopt(SO_ERROR). This new handling
conforms to the configured timeout: the polling loop will only run for
the amount of time still available, accounting for the time used by the
initial connect() call.

Fixes: 99126abec5e5 ("bpf: selftests: A few improvements to network_helpers.c")
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 70 +++++++++++++++++++++++++--
 tools/testing/selftests/bpf/testing_helpers.h |  9 ++++
 2 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index db935a9d9fc1..e3157724adec 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -14,6 +14,7 @@
 #include <sys/types.h>
 #include <sys/un.h>
 #include <sys/eventfd.h>
+#include <sys/poll.h>
 
 #include <linux/err.h>
 #include <linux/in.h>
@@ -294,7 +295,10 @@ int client_socket(int family, int type,
 int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t addrlen,
 		    const struct network_helper_opts *opts)
 {
-	int fd;
+	__u64 start_ms, duration_ms;
+	__u64 remaining_ms;
+	socklen_t errlen;
+	int fd, err, ret;
 
 	if (!opts)
 		opts = &default_opts;
@@ -305,13 +309,69 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 		return -1;
 	}
 
-	if (connect(fd, (const struct sockaddr *)addr, addrlen)) {
+	start_ms = get_time_ms();
+	err = connect(fd, (const struct sockaddr *)addr, addrlen);
+
+	if (!err)
+		return fd;
+
+	if (errno != EINPROGRESS) {
 		log_err("Failed to connect to server");
-		save_errno_close(fd);
-		return -1;
+		goto close;
 	}
 
-	return fd;
+	duration_ms = get_time_ms() - start_ms;
+	remaining_ms = duration_ms < opts->timeout_ms ?
+			       opts->timeout_ms - duration_ms :
+			       0;
+	if (!remaining_ms) {
+		errno = ETIMEDOUT;
+		log_err("Can not poll connection, already in timeout");
+		goto close;
+	}
+
+	while (remaining_ms) {
+		struct pollfd pfd = { .fd = fd, .events = POLLOUT };
+
+		start_ms = get_time_ms();
+		ret = poll(&pfd, 1, remaining_ms);
+
+		if (ret == 0) {
+			errno = ETIMEDOUT;
+			log_err("Connection timeout while polling");
+			goto close;
+		} else if (ret < 0 && errno == EINTR) {
+			duration_ms = get_time_ms() - start_ms;
+			remaining_ms = duration_ms < remaining_ms ?
+					       remaining_ms - duration_ms :
+					       0;
+			if (!remaining_ms) {
+				errno = ETIMEDOUT;
+				log_err("Connection timeout after signal");
+				goto close;
+			}
+		} else if (ret < 0) {
+			log_err("Failed to poll connect status");
+			goto close;
+		}
+
+		errlen = sizeof(err);
+		if (getsockopt(fd, SOL_SOCKET, SO_ERROR, &err, &errlen) < 0) {
+			log_err("Failed to getsockopt");
+			goto close;
+		}
+
+		if (err) {
+			errno = err;
+			log_err("Eventually failed to connect to server");
+			goto close;
+		}
+		return fd;
+	}
+
+close:
+	save_errno_close(fd);
+	return -1;
 }
 
 int connect_to_addr_str(int family, int type, const char *addr_str, __u16 port,
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index 2edc6fb7fc52..7440cfcd1025 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -52,6 +52,15 @@ static inline __u64 get_time_ns(void)
 	return (u64)t.tv_sec * 1000000000 + t.tv_nsec;
 }
 
+static inline __u64 get_time_ms(void)
+{
+	struct timespec t;
+
+	clock_gettime(CLOCK_MONOTONIC, &t);
+
+	return (u64)t.tv_sec * 1000 + t.tv_nsec / 1000000;
+}
+
 struct bpf_insn;
 /* Request BPF program instructions after all rewrites are applied,
  * e.g. verifier.c:convert_ctx_access() is done.

-- 
2.55.0

