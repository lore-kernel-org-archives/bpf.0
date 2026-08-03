Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26BD324B22;
	Mon,  3 Aug 2026 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785742625; cv=none; b=YXMLALOjoUMkN6bHYCPVArLXxnhVvAejU1vp9k4+IJsjT76yC/XuJt51LLhHwaguaHGWrCFfeTfgeM/z1AxnEVyV34+sL8FZzcBIuDjxDcyr/LQrl3a9NBryruj9N5k7jnVfZkNbQ2FBeQ9PwXrpOkU4Fj17C4jVHwYV3Nu5Bh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785742625; c=relaxed/simple;
	bh=svFEdn1B76UVGgM0+/7O5PR2QIi5iS6gHxasHzfBjTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qshH3bxg4snDeQC9tYjy8zuEc0+SUktkc4SJlyjwXxI6gTQeSnI/5kXpWLohDe61VJcDtLuBd9ncXtoz9l8bwZsHZQ99RoJWbasE7cI/mqGgm9uHPUuQzi3XXPDQdFT6Hkiltc2EXrzDUpjeD5kiJyp/0/XZatAYzWTngDKeQfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PRcX2S7B; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PRcX2S7B"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id ECA021A13C2;
	Mon,  3 Aug 2026 07:36:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BE5106029B;
	Mon,  3 Aug 2026 07:36:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA24F11C17BB2;
	Mon,  3 Aug 2026 09:36:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785742614; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=CUFS73zm8U9YFY30SMbmycdE+qYaXmwAHw50Ul5dEqU=;
	b=PRcX2S7BWu+HDzk6PjRWKRuXvoTTMg1Oa22H4QoKbJzUw/c1dxqtn/k0tSigZZc6RwccCb
	mHRGvRTqbgJt7SmiRFLFYy0OwRPy9+zkcYQZif1iliOI+7YNc3YOaekVlDmH3JUQh67mzg
	HQw/PD0wz1sAcXl9pTPPPnWQkaAqt12sUtAU4IIENt6afBNJKkskg+0PVgewzvLhJfjI6d
	QoK7F2lRYYif34nUSqQ6iEAwDsXg4GWdMAgcRVs/EKcr7EeVwZ76yVfHLoezrGA5e2iUN6
	jGtBRJvd7xlf3aNznE7ejVimHTWkxSIrIh0qlUm032f8vNal8hJDVhwa8dzTvA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Mon, 03 Aug 2026 09:36:45 +0200
Subject: [PATCH bpf v2] selftests/bpf: keep polling connection that is
 still in progress
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260803-tc_tunnel_flaky-v2-1-657b287dfa75@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBREr0L+2pq2oKSuvIchpC0f+YotaQuRE
 O4u4trlTN68WSBiIIxwyRYIOFEk77YgDxnYTrs7Mmq2DJLLMy8FZ8nWaXQO+7rt9XNmskSlhRK
 m4TlsqyFgS+/deAMztFD9yjiaB9r0dX2xjmLyYd5/J7HDfy8mwQQrpNbmlCulC3U13qee3NH6F
 1Trun4ARCawcMcAAAA=
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
Changes in v2:
- drop unneeded initialization
- add back error message for immediate connection failure, and slightly
  reword the async connection failure error message
- Link to v1: https://patch.msgid.link/20260710-tc_tunnel_flaky-v1-1-42aab5399a49@bootlin.com
---
I manage to reproduce the issue locally by running `./test_progs -a
tc_tunnel` in a qemu machine, while making all my CPUs busy with
stress-ng on host side; the issue happens pretty quickly. I have not
been able to reproduce the issue anymore with this fix.
---
 tools/testing/selftests/bpf/network_helpers.c | 41 ++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index db935a9d9fc1..52e7b72f8a77 100644
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
+	err = connect(fd, (const struct sockaddr *)addr, addrlen);
+	if (err && errno == EINPROGRESS) {
+		struct pollfd pfd = { .fd = fd, .events = POLLOUT };
+
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
+			log_err("Eventually failed to connect to server");
+			errno = err;
+			goto close;
+		}
+	} else if (err) {
 		log_err("Failed to connect to server");
-		save_errno_close(fd);
-		return -1;
+		goto close;
 	}
 
 	return fd;
+close:
+	save_errno_close(fd);
+	return -1;
 }
 
 int connect_to_addr_str(int family, int type, const char *addr_str, __u16 port,

---
base-commit: 2efc18d4bb9ad28d240b69bd324937f1ec12e93d
change-id: 20260710-tc_tunnel_flaky-27e9a191bd03

Best regards,
--  
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

