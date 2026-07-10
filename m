Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973EA369D4B
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701529; cv=none; b=Si/BwM8WzUeFlTZnEe6O8vv2uvlwx7IhCwtZ+RPHRlTHaCONki76+6sg2d+yAmOT7RQzK9Ksvs8PkGTJ71jvgTMPz2JluNeWuyHwaJfupo1pefQEzw5Nk1cvqRflroz1HQXeA+2M3X/Q0/kP7rj68YrhkuAXwRZ32euCsuJ5Y9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701529; c=relaxed/simple;
	bh=ZPNcJGr4jET8+wX9qzX/Ku0wxWKr33LabA34lYSlVeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aKEGqpEU3LxdkcuVycwP9Vp/xoGa2nwjWn47pdof5bj2YaasLbwrwv264E5ugZg5haZ+nfK3OgkTnnPHtrel+Kpk3WkwItHTdhElWJGQFC/5t0ek2OZ8bLZ/Ef4avmoFWD40wK500q0qPssx1SxSVuGdwIytQ1P4ihBRxLwOoTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wvRYj7mA; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wvRYj7mA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 080064E40D46;
	Fri, 10 Jul 2026 16:38:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BBEAF60342;
	Fri, 10 Jul 2026 16:38:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 93D5011BD2A81;
	Fri, 10 Jul 2026 18:38:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783701523; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=cActg0ZuiluOTvW6fkhk0aXHYtC97UmzZgGeZw4PjUY=;
	b=wvRYj7mAxw138yzW9/sSLEPCMBHjGskKAwYqEWKyD6GLZ7bNadawGPwGgWP7fzfIZgz2M1
	rqi4WX4qv57j69GTg+/JoCrTmWzxXI7vj0K8ckiEfpsa4BkDPtJqaBAKnKPLAt3s55Uqd0
	tRBfrFKyN8565qPz3EXziVplSGNsrlJ18XzXFFXTjEcZgGueKCqFWHmcShg2ffiKzBRvqO
	3E5WSv5MO3T1a0cPb2WhgOtcLTr6XWo1W1YPp9BqL8bTKbsU+AaernBY0lDgRVm90BWq1D
	xvBsTrkUhCgWbr4ARgB6YcVqZY5gvyo1PFe7pL1jk2jJOxWjXkHsj/CwK8Dm/w==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 10 Jul 2026 18:38:23 +0200
Subject: [PATCH bpf] selftests/bpf: keep polling connection that is still
 in progress
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260710-tc_tunnel_flaky-v1-1-42aab5399a49@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QqDIBhGXyW+6wnqoGivMkao/dbfwoXa2IjeP
 bcuz4FzNiSKTAm3akOkNyd+hQLqUsGNJgwkuC8MLXUtGyVFdl1eQ6C587N5foVuqDWqVbaXV5R
 qieT58z/eYRePxynTaidy+ffCvh/TiLC5eAAAAA==
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
check the connection result via getsockopt(SO_ERROR).

Fixes: 99126abec5e5 ("bpf: selftests: A few improvements to network_helpers.c")
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
I manage to reproduce the issue locally by running `./test_progs -a
tc_tunnel` in a qemu machine, while making all my CPUs busy with
stress-ng on host side; the issue happens pretty quickly. I have not
been able to reproduce the issue anymore with this fix.
---
 tools/testing/selftests/bpf/network_helpers.c | 43 +++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index db935a9d9fc1..43c9e215c3f1 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -14,6 +14,7 @@
 #include <sys/types.h>
 #include <sys/un.h>
 #include <sys/eventfd.h>
+#include <sys/poll.h>
 
 #include <linux/err.h>
 #include <linux/in.h>
@@ -40,6 +41,8 @@
 #define IPPROTO_MPTCP 262
 #endif
 
+#define CONNECTION_IN_PROGRESS_TIMEOUT_MS	3000
+
 #define clean_errno() (errno == 0 ? "None" : strerror(errno))
 #define log_err(MSG, ...) ({						\
 			int __save = errno;				\
@@ -294,7 +297,8 @@ int client_socket(int family, int type,
 int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t addrlen,
 		    const struct network_helper_opts *opts)
 {
-	int fd;
+	socklen_t errlen;
+	int fd, err;
 
 	if (!opts)
 		opts = &default_opts;
@@ -305,13 +309,42 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 		return -1;
 	}
 
-	if (connect(fd, (const struct sockaddr *)addr, addrlen)) {
-		log_err("Failed to connect to server");
-		save_errno_close(fd);
-		return -1;
+	err = connect(fd, (const struct sockaddr *)addr, addrlen);
+	if (err && errno == EINPROGRESS) {
+		struct pollfd pfd = { .fd = fd, .events = POLLOUT };
+
+		err = 0;
+		err = poll(&pfd, 1, CONNECTION_IN_PROGRESS_TIMEOUT_MS);
+
+		if (err <= 0) {
+			if (err == 0) {
+				log_err("Connection timeout");
+				errno = ETIMEDOUT;
+			} else {
+				log_err("Failed to poll connection status");
+			}
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
+			log_err("Failed to connect to server");
+			errno = err;
+			goto close;
+		}
+	} else if (err) {
+		goto close;
 	}
 
 	return fd;
+close:
+	save_errno_close(fd);
+	return -1;
 }
 
 int connect_to_addr_str(int family, int type, const char *addr_str, __u16 port,

---
base-commit: 3d40a7b2210fcab4b147c006a5291d9eb4f6241f
change-id: 20260710-tc_tunnel_flaky-27e9a191bd03

Best regards,
--  
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

