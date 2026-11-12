Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503275;
	b=ZyQSxMLvEqDuEA+r7aZyEbSklosn8QvqO5A/yWAI9QWe21qF0YMsN6X0Giu2NgjW7iEi
	 ZYiDhIONnzf4rn9n3AmczYcxZ0vX7fLS8h0QjAYrH9bxs1zuhsOn6Q9RW1GPJsdI6uxuP
	 mFXVtKnb6n6Ud99qpYkmKe0xU40aGkxFh3E4DXf2h7gFKEDYPf5V7WpYyglcCo7Jb75cp
	 erV5zZ/pxASAybVNAK+dRvPMRLtAWmXBLIkBkdShRj0eBvmebFohm712XaJm+/ymTByOK
	 PyPERU3g002sWAliTQWkLYl9d8HI4dKdUB73GaryDI4dwTyyWFv7FoHSScVTHG17U2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503275;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=yohNCCFWJ3Uy+nibYm0CCRLWC35AUKC1qEGysk1UZlg=;
	b=A8kcsjG1DVQdAgq3H8T8eZoepMCvjuwipGze7neMcwoMl+HRUDCLScLA+KeuDA1LhnBg
	 fi3HBTx+0gcoyo0SX4ZR0TRdvTqgU1tGUPQnUMc/NOLCTOQ+LLK72XWwBk+i2zYRS2loD
	 1Z4HFVAK3q82ul7TiEwEq7Mj1mlSVN1X19qngfnRcw6+P/4+PfsHTxN0PUzWF/5SDGiMB
	 ZefKAE7px1DLHQhmiVQpe9jkF1O0UE9lfnOEIMNQpcFhpa7RvWvexf5Fetv2gCBGsJPWl
	 lSTL5DZTKPAVMRipl+1y9sR0MyF3NhQTO93U8qvFAwMNURJyy3UfkkhIKvE9j2zI9UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=vwqJg43g;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811B6606A330;
	Thu, 12 Nov 2026 17:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 811B6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=vwqJg43g
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=yohNCCFWJ3Uy+nibYm0CCRLWC35AUKC1qEGysk1UZlg=; b=vwqJg43gaqm3Q6O33oofZGubLN
	YnO8fHX0H8WbWVF0kbw5LALfHryZtnYAGRbPNNle3dxMt83hDoIdnNGb/10YpYxQmoEZfw4d8APdM
	CH9BUc7A2s2zcQLTGTAw9esSh+4UdSGXXH7R3xd77yCRbsTeK8t0zlBeakdMhPkktIPWERbp3rFM5
	TUcaMteXwJ7cMbiOWg3jMAgYr9r4eBsoXGlCgjf8ePSjYs+w1ghyGSW1HWrtC/0/WYYYc+ccP3Ay0
	/weQM6ykdNpVmO/4RcmaCr4q/CUUP5H4FtfFXeYDa3tDeqgGxPPEew9YxId5GFbtEI54CsvXm26OC
	R3lzTJvQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRYH8-00E7aO-0m;
	Thu, 12 Nov 2026 17:07:50 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 12 Nov 2026 09:05:27 -0800
Subject: [PATCH net-next 3/3] selftests: net: getsockopt_iter: cover tcp
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-getsockopt_phase7-v1-3-1eb759dd0929@debian.org>
References: <20261112-getsockopt_phase7-v1-0-1eb759dd0929@debian.org>
In-Reply-To: <20261112-getsockopt_phase7-v1-0-1eb759dd0929@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7537; i=leitao@debian.org;
 h=from:subject:message-id; bh=Srvv6RQGgVr8JyB8jL0B8DLntHE5zYTcmX3okIhkLZo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9fJM8lzEroo+ZLLOVzVZ4NZCjVBPxSReqG2u2
 g2mGqoa//2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavXyTAAKCRA1o5Of/Hh3
 bZPMD/4zrNOymciutmKdsHclbjI3QTIPOwmtmeMw89tClpBHfYi7AMP6AEed3PBGJFpj/e52m72
 CZG+iclY7rQR3N5N87BuHZVFtknwdByLxYd6U9vaKik7lFFlf/6vJ9kHHGqGPbNTtRxJjB2oHOy
 Mig/X+aZnyhcmjAdYOxRWz/IFO4Ws0CgufqvkSCaidA45i1bRxpC+XxqevfXAESBxnggQHMilRa
 ClLmoMtt5OF9Y9H5OxyecZOhQfxFkH0uzBbsJbeh4jVscSUAg7aBPoKo8q99uESs4B+ri4Gpy7X
 cZ58CRzaosRsw8H38Yo1vYkn8V0Nf6FIhrs7b9bivcmEkF/UtFOqyqQKomCJE4nmUdnDD78rXXH
 FAhUspldV1PllljWq4WjKd1//I8wT6lob1SqmDpjVOVmjO9yYv7MExZEQo26YYKzhfTkyN8a45x
 t+RcF3XH/P6ojY6SgPjwb8cdKpHT7sQaUkV5QTwMBHwpfM9zT99ImED4gsP3k4i+WGHxs6G2OJV
 htSnPXdJhzcq3EVsqopDsgyRNxeyJoTCCa/zGIjUgS5RGo8GTkcrkdc5W5qVrhUQleXXwAgZVy9
 /Qkldm2/UWAcly4xswPO4U1fmOZmo/R2sDZJPvCjQbRiHZRBUeC5GAx/N2Vdyk8bGW//lYO2R7L
 u+Am1a0+eYkCE2Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Add a fixture for do_tcp_getsockopt(). The setup keeps both ends of a
loopback connection, with TCP_SAVE_SYN set on the listener, so the
accepted socket has a saved SYN to report.

TCP_INFO and TCP_CONGESTION cover clamping the reply down to what fits,
TCP_ULP covers reporting zero and writing nothing, and TCP_SAVED_SYN
covers the length-then-EINVAL path, which the second half of that test
uses to read the SYN back.

TCP_ZEROCOPY_RECEIVE reads its struct from optval and writes it back.
With nothing queued it maps nothing and succeeds, so the tests cover
the 16-byte struct glibc still declares, a larger buffer cut down to
the kernel's struct, and one whose extra tail is not zero.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/net/getsockopt_iter.c | 245 ++++++++++++++++++++++++++
 1 file changed, 245 insertions(+)

diff --git a/tools/testing/selftests/net/getsockopt_iter.c b/tools/testing/selftests/net/getsockopt_iter.c
index 2367fce226d4cc..4e51c8aa6a8555 100644
--- a/tools/testing/selftests/net/getsockopt_iter.c
+++ b/tools/testing/selftests/net/getsockopt_iter.c
@@ -55,6 +55,9 @@
 #ifndef TCP_ULP
 #define TCP_ULP 31
 #endif
+#ifndef TCP_CA_NAME_MAX
+#define TCP_CA_NAME_MAX 16
+#endif
 /* linux/mroute.h does not coexist with netinet/in.h here. */
 #ifndef MRT_VERSION
 #define MRT_VERSION 206
@@ -1005,4 +1008,246 @@ TEST_F(tls, bad_optname)
 	ASSERT_EQ(ENOPROTOOPT, errno);
 }
 
+/* ---------- tcp ---------- */
+
+FIXTURE(tcp)
+{
+	int fd;		/* connected client */
+	int sfd;	/* accepted server side, its SYN was saved */
+};
+
+FIXTURE_SETUP(tcp)
+{
+	struct sockaddr_in a = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+	};
+	socklen_t alen = sizeof(a);
+	int one = 1;
+	int lfd;
+
+	self->fd = -1;
+	self->sfd = -1;
+
+	lfd = socket(AF_INET, SOCK_STREAM, 0);
+	if (lfd < 0)
+		SKIP(return, "TCP socket: %s", strerror(errno));
+	setsockopt(lfd, IPPROTO_TCP, TCP_SAVE_SYN, &one, sizeof(one));
+	if (bind(lfd, (struct sockaddr *)&a, sizeof(a)) || listen(lfd, 1) ||
+	    getsockname(lfd, (struct sockaddr *)&a, &alen)) {
+		close(lfd);
+		SKIP(return, "listener setup: %s", strerror(errno));
+	}
+	self->fd = socket(AF_INET, SOCK_STREAM, 0);
+	if (self->fd < 0) {
+		close(lfd);
+		SKIP(return, "TCP socket: %s", strerror(errno));
+	}
+	if (connect(self->fd, (struct sockaddr *)&a, sizeof(a))) {
+		close(lfd);
+		SKIP(return, "connect: %s", strerror(errno));
+	}
+	self->sfd = accept(lfd, NULL, NULL);
+	close(lfd);
+	if (self->sfd < 0)
+		SKIP(return, "accept: %s", strerror(errno));
+}
+
+FIXTURE_TEARDOWN(tcp)
+{
+	if (self->fd >= 0)
+		close(self->fd);
+	if (self->sfd >= 0)
+		close(self->sfd);
+}
+
+TEST_F(tcp, maxseg_exact)
+{
+	socklen_t optlen = sizeof(int);
+	int val = -1;
+
+	ASSERT_EQ(0, getsockopt(self->fd, IPPROTO_TCP, TCP_MAXSEG, &val,
+				&optlen));
+	ASSERT_EQ(sizeof(int), optlen);
+	ASSERT_GT(val, 0);
+}
+
+/* Unlike IPv4, TCP clamps the reply rather than shrinking it to a byte. */
+TEST_F(tcp, nodelay_undersize_clamped)
+{
+	socklen_t optlen = 1;
+	int val = 0;
+
+	ASSERT_EQ(0, getsockopt(self->fd, IPPROTO_TCP, TCP_NODELAY, &val,
+				&optlen));
+	ASSERT_EQ(1, optlen);
+}
+
+TEST_F(tcp, info_exact)
+{
+	struct tcp_info info;
+	socklen_t optlen = sizeof(info);
+
+	ASSERT_EQ(0, getsockopt(self->fd, IPPROTO_TCP, TCP_INFO, &info,
+				&optlen));
+	ASSERT_EQ(sizeof(info), optlen);
+	ASSERT_EQ(TCP_ESTABLISHED, info.tcpi_state);
+}
+
+TEST_F(tcp, info_short_clamped)
+{
+	struct tcp_info info;
+	socklen_t optlen = 8;
+
+	ASSERT_EQ(0, getsockopt(self->fd, IPPROTO_TCP, TCP_INFO, &info,
+				&optlen));
+	ASSERT_EQ(8, optlen);
+	ASSERT_EQ(TCP_ESTABLISHED, info.tcpi_state);
+}
+
+TEST_F(tcp, congestion_exact)
+{
+	socklen_t optlen = TCP_CA_NAME_MAX;
+	char name[TCP_CA_NAME_MAX] = {};
+
+	ASSERT_EQ(0, getsockopt(self->fd, IPPROTO_TCP, TCP_CONGESTION, name,
+				&optlen));
+	ASSERT_EQ(TCP_CA_NAME_MAX, optlen);
+	ASSERT_NE(0, name[0]);
+}
+
+TEST_F(tcp, congestion_short_clamped)
+{
+	socklen_t optlen = 4;
+	char name[4] = {};
+
+	ASSERT_EQ(0, getsockopt(self->fd, IPPROTO_TCP, TCP_CONGESTION, name,
+				&optlen));
+	ASSERT_EQ(4, optlen);
+	ASSERT_NE(0, name[0]);
+}
+
+/* No ULP attached: length reported as zero, nothing written. */
+TEST_F(tcp, ulp_none)
+{
+	socklen_t optlen = 16;
+	char buf[16];
+
+	memset(buf, 0x5a, sizeof(buf));
+	ASSERT_EQ(0, getsockopt(self->fd, IPPROTO_TCP, TCP_ULP, buf, &optlen));
+	ASSERT_EQ(0, optlen);
+	ASSERT_EQ(0x5a, (unsigned char)buf[0]);
+}
+
+TEST_F(tcp, repair_window_wrong_len)
+{
+	socklen_t optlen = 4;
+	char buf[4];
+
+	ASSERT_EQ(-1, getsockopt(self->fd, IPPROTO_TCP, TCP_REPAIR_WINDOW, buf,
+				 &optlen));
+	ASSERT_EQ(EINVAL, errno);
+}
+
+TEST_F(tcp, zerocopy_receive_short)
+{
+	socklen_t optlen = 4;
+	char buf[4] = {};
+
+	ASSERT_EQ(-1, getsockopt(self->fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE,
+				 buf, &optlen));
+	ASSERT_EQ(EINVAL, errno);
+}
+
+/* Nothing queued: the call maps nothing and succeeds. */
+TEST_F(tcp, zerocopy_receive_old_struct)
+{
+	struct tcp_zerocopy_receive zc = {};
+	socklen_t optlen = sizeof(zc);
+
+	ASSERT_EQ(0, getsockopt(self->fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE,
+				&zc, &optlen));
+	ASSERT_EQ(sizeof(zc), optlen);
+	ASSERT_EQ(0, zc.length);
+}
+
+/* A larger struct is cut down to the kernel's, if its tail is zero. */
+TEST_F(tcp, zerocopy_receive_oversize_clamped)
+{
+	char buf[256] = {};
+	socklen_t optlen = sizeof(buf);
+
+	ASSERT_EQ(0, getsockopt(self->fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE,
+				buf, &optlen));
+	ASSERT_GE(optlen, sizeof(struct tcp_zerocopy_receive));
+	ASSERT_LT(optlen, sizeof(buf));
+}
+
+TEST_F(tcp, zerocopy_receive_oversize_dirty)
+{
+	char buf[256] = {};
+	socklen_t optlen = sizeof(buf);
+
+	buf[sizeof(buf) - 1] = 1;
+	ASSERT_EQ(-1, getsockopt(self->fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE,
+				 buf, &optlen));
+	ASSERT_EQ(EINVAL, errno);
+	ASSERT_EQ(sizeof(buf), optlen);
+}
+
+/* The client never saved a SYN, so there is nothing to report. */
+TEST_F(tcp, saved_syn_none)
+{
+	socklen_t optlen = 128;
+	char buf[128];
+
+	memset(buf, 0x5a, sizeof(buf));
+	ASSERT_EQ(0, getsockopt(self->fd, IPPROTO_TCP, TCP_SAVED_SYN, buf,
+				&optlen));
+	ASSERT_EQ(0, optlen);
+	ASSERT_EQ(0x5a, (unsigned char)buf[0]);
+}
+
+/* A short buffer gets the required length back along with EINVAL, and the
+ * SYN is still there for the retry.
+ */
+TEST_F(tcp, saved_syn_short_reports_len)
+{
+	socklen_t optlen = 1;
+	char buf[256];
+	socklen_t need;
+
+	ASSERT_EQ(-1, getsockopt(self->sfd, IPPROTO_TCP, TCP_SAVED_SYN, buf,
+				 &optlen));
+	ASSERT_EQ(EINVAL, errno);
+	ASSERT_GT(optlen, 1);
+	ASSERT_LE(optlen, sizeof(buf));
+	need = optlen;
+
+	ASSERT_EQ(0, getsockopt(self->sfd, IPPROTO_TCP, TCP_SAVED_SYN, buf,
+				&optlen));
+	ASSERT_EQ(need, optlen);
+}
+
+TEST_F(tcp, negative_optlen)
+{
+	socklen_t optlen = (socklen_t)-1;
+	int val;
+
+	ASSERT_EQ(-1, getsockopt(self->fd, IPPROTO_TCP, TCP_MAXSEG, &val,
+				 &optlen));
+	ASSERT_EQ(EINVAL, errno);
+}
+
+TEST_F(tcp, bad_optname)
+{
+	socklen_t optlen = sizeof(int);
+	int val;
+
+	ASSERT_EQ(-1, getsockopt(self->fd, IPPROTO_TCP, 0x7fff, &val,
+				 &optlen));
+	ASSERT_EQ(ENOPROTOOPT, errno);
+	ASSERT_EQ(sizeof(int), optlen);
+}
+
 TEST_HARNESS_MAIN

-- 
2.53.0-Meta

