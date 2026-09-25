Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0EF4E2F02;
	Fri, 25 Sep 2026 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351792; cv=none; b=YuYaJt5pV2d/GdNxS6a90s5kHLKIKeGXvBkUGaojeOiWYqdDcKoU3JWhh2wUKqtD5mXR5df2TgY8ym1Xi7hF9H1GoX4EtQ6k1lujTwHTbIf0XBarVKrRADyVHCnPWs8KiWaHrHIg+nr+dV1uXypDtoQSR+FkcLs9OlZnHoyUaTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351792; c=relaxed/simple;
	bh=WSlP9Beit+HhNmpFZRkX51X2r42T+utGkwLpdOhYUP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZcXEzRlUWbMzDXCtj1nxT+Y0qR35lCnLkSjX9NJ6r6sv5VwiuxcfC7PzpJ63hC8N1JnqLZSrig4US38F2beNsrep4aQPo39T4BPtQsuZwb8YXniImPfoVjQ558G2p5S0R9WoO7xNUUetJbhFbjHqFj3lfd4u3MO7RismC7UXxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=HcsKZQ79; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="HcsKZQ79"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=7/u3O+5CofNhzwgV8gLJqqSThYVao22PZEKp33FChtQ=; b=HcsKZQ79Ysp+OlMLBibdiyzQXd
	MBVLiS8cgkfLA6kLRZX5vegT2M3ejnYOYPFtetMfOID5cY2FdjNvqV/2MCVSkgEZ9q+Ye/aNCrONv
	COF3I8VT33oPQZZpGgqw3y2H0Uht5PuIf7A2PiUf2Al1OBot5YjBSJeasVWVoYiwMwQRvRKNgwK8l
	di+q0crmdYATGKUDhJQZjBPsKjqjtdoM75qSh1wcurW1KGEBYtHNUOk4hnS0sPwSt7DHVNcmrEab2
	OzYgQiMbZK4vBtc6zxqwc5SqCpn68FjuJ/J3jSMVKezU3pGPVXM09g/WHgWxI5g5jw6PSTol311cI
	Vwg6+dwA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xA8Hh-005Pma-05;
	Fri, 25 Sep 2026 15:56:25 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 25 Sep 2026 08:55:21 -0700
Subject: [PATCH net-next 6/6] selftests: net: getsockopt_iter: cover ip and
 ipv6
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-sockopt_expand_out_v2-v1-6-c3ef2e3bb5c0@debian.org>
References: <20260925-sockopt_expand_out_v2-v1-0-c3ef2e3bb5c0@debian.org>
In-Reply-To: <20260925-sockopt_expand_out_v2-v1-0-c3ef2e3bb5c0@debian.org>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 david.laight.linux@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=8647; i=leitao@debian.org;
 h=from:subject:message-id; bh=WSlP9Beit+HhNmpFZRkX51X2r42T+utGkwLpdOhYUP0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqtpl6haoSGsEOfWCxMqiAmtXUzCjPNbtA1NXzj
 5F50/mBuAuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaraZegAKCRA1o5Of/Hh3
 beV/D/9OnYxNiPCM8ZjZBYGJngwWeJblZOos4+Y/dY+k0ZCGgXuRjdvZ6RBTUvFQhcByLFQnr0s
 yLA9nTkvXjkK9/f8HDNP64Npq7jQ5ig0SLiW1moluIAMNfEF2oADkVMpKKic7UcLNGZcbIEn5RC
 tsCMBIh6xuRRDpgnChGj5POeUjZFDr6r+HDjxT/FMts90sp9QpsVlh0ahqjOTUoNFcPT7cSiZvO
 lOoPI7ep1XBgaRAlvePdbTwm1qmHeJyYfLVyia0Qxbm8GjuJlqdVrctdeC/ClIiNhQFEBj9FbcX
 XLazAnwakqoElMzp2digPSjLyVFf/O3kw/ABU9fzPPikZdDcifQb5Rx+jjgjAXRdjvCxXti2UaR
 j2JlgW2hX1jJJYMPeWeJSTgd0ZwC31UdEziWFk6S0I29zPQNE+X/cAqQ8Fq9GIwM5hoys5p1dlL
 4o0VNC4zo9PAHIFdySIUvJEV1YBm/jvLELWn0BTm1V2J+uiyfFQ4WeCFsHPI8wQaiWQ0Lhm1YT7
 ZpzK8ZauihzyEfytHDEyOyQore7yRX7EC55JH6vNosqUepW2rvfi9aBNxm765PiJUvNNSghy3tW
 R9hh9xTo4ZRacTbHn7SrAnV1LFzkeBa3tosH9RlWA5sxA3FPMgiefbsxyx6UqiC6BRxos0MMWIS
 CTCy8QCoXH8IoeQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Add an ip and an ipv6 fixture, pinning the returned length and errno
across buffer sizes, the branches that answer empty, an unknown
optname and the options dispatched before the switch.

SOL_IP answers a sub-int buffer with one byte where SOL_IPV6 clamps the
int. IP_PKTOPTIONS and IPV6_2292PKTOPTIONS want a stream socket;
MRT_*/MRT6_* want a raw one, and skip without CONFIG_IP_MROUTE or
CONFIG_IPV6_MROUTE, where the switch answers ENOPROTOOPT instead.

MRT_VERSION and MRT6_VERSION are spelled out; linux/mroute.h does not
coexist with netinet/in.h here.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/net/getsockopt_iter.c | 302 ++++++++++++++++++++++++++
 1 file changed, 302 insertions(+)

diff --git a/tools/testing/selftests/net/getsockopt_iter.c b/tools/testing/selftests/net/getsockopt_iter.c
index 6c2408df461232..32b6e0a50f1f9c 100644
--- a/tools/testing/selftests/net/getsockopt_iter.c
+++ b/tools/testing/selftests/net/getsockopt_iter.c
@@ -55,6 +55,13 @@
 #ifndef TCP_ULP
 #define TCP_ULP 31
 #endif
+/* linux/mroute.h does not coexist with netinet/in.h here. */
+#ifndef MRT_VERSION
+#define MRT_VERSION 206
+#endif
+#ifndef MRT6_VERSION
+#define MRT6_VERSION 206
+#endif
 
 /* ---------- netlink ---------- */
 
@@ -492,6 +499,301 @@ TEST_F(rawv6, bad_optname)
 	ASSERT_EQ(sizeof(val), optlen);
 }
 
+/* ---------- ip (SOL_IP) ---------- */
+
+FIXTURE(ip)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(ip)
+{
+	/* a router alert option, so IP_OPTIONS has something to answer with */
+	static const unsigned char ipopts[4] = { 0x94, 0x04, 0x00, 0x00 };
+	int ttl = 42;
+
+	self->fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (self->fd < 0)
+		SKIP(return, "AF_INET dgram socket: %s", strerror(errno));
+
+	if (setsockopt(self->fd, SOL_IP, IP_TTL, &ttl, sizeof(ttl)) < 0)
+		SKIP(return, "set IP_TTL: %s", strerror(errno));
+
+	if (setsockopt(self->fd, SOL_IP, IP_OPTIONS, ipopts,
+		       sizeof(ipopts)) < 0)
+		SKIP(return, "set IP_OPTIONS: %s", strerror(errno));
+}
+
+FIXTURE_TEARDOWN(ip)
+{
+	if (self->fd >= 0)
+		close(self->fd);
+}
+
+TEST_F(ip, ttl_exact)
+{
+	socklen_t optlen = sizeof(int);
+	int val = 0;
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IP, IP_TTL, &val, &optlen));
+	ASSERT_EQ(sizeof(int), optlen);
+	ASSERT_EQ(42, val);
+}
+
+TEST_F(ip, ttl_oversize_clamped)
+{
+	socklen_t optlen = 64;
+	char buf[64] = {};
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IP, IP_TTL, buf, &optlen));
+	ASSERT_EQ(sizeof(int), optlen);
+}
+
+/* SOL_IP answers a sub-int buffer with a single byte when the value fits
+ * in one, rather than clamping the int down.
+ */
+TEST_F(ip, ttl_single_byte)
+{
+	unsigned char buf[3] = {};
+	socklen_t optlen = sizeof(buf);
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IP, IP_TTL, buf, &optlen));
+	ASSERT_EQ(1, optlen);
+	ASSERT_EQ(42, buf[0]);
+}
+
+TEST_F(ip, ttl_zero_len)
+{
+	socklen_t optlen = 0;
+	int val;
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IP, IP_TTL, &val, &optlen));
+	ASSERT_EQ(0, optlen);
+}
+
+TEST_F(ip, negative_optlen)
+{
+	socklen_t optlen = (socklen_t)-1;
+	int val;
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_IP, IP_TTL, &val, &optlen));
+	ASSERT_EQ(EINVAL, errno);
+}
+
+TEST_F(ip, options_roundtrip)
+{
+	unsigned char buf[40] = {};
+	socklen_t optlen = sizeof(buf);
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IP, IP_OPTIONS, buf, &optlen));
+	ASSERT_EQ(4, optlen);
+	ASSERT_EQ(0x94, buf[0]);
+}
+
+TEST_F(ip, options_undersize_clamped)
+{
+	unsigned char buf[2] = {};
+	socklen_t optlen = sizeof(buf);
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IP, IP_OPTIONS, buf, &optlen));
+	ASSERT_EQ(sizeof(buf), optlen);
+}
+
+/* With no option set the reply is empty and the call still succeeds. */
+TEST_F(ip, options_absent)
+{
+	unsigned char buf[40] = {};
+	socklen_t optlen = sizeof(buf);
+	int fd;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0)
+		SKIP(return, "AF_INET dgram socket: %s", strerror(errno));
+
+	ASSERT_EQ(0, getsockopt(fd, SOL_IP, IP_OPTIONS, buf, &optlen));
+	ASSERT_EQ(0, optlen);
+	close(fd);
+}
+
+TEST_F(ip, multicast_if_oversize_clamped)
+{
+	socklen_t optlen = 64;
+	char buf[64] = {};
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IP, IP_MULTICAST_IF, buf,
+				&optlen));
+	ASSERT_EQ(sizeof(struct in_addr), optlen);
+}
+
+/* IP_PKTOPTIONS only answers on a stream socket. */
+TEST_F(ip, pktoptions_wrong_type)
+{
+	socklen_t optlen = 64;
+	char buf[64];
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_IP, IP_PKTOPTIONS, buf,
+				 &optlen));
+	ASSERT_EQ(ENOPROTOOPT, errno);
+}
+
+/* The MRT_* options are dispatched ahead of the rest of the switch and
+ * want a raw IGMP socket. Without CONFIG_IP_MROUTE they are not
+ * dispatched at all and the switch answers ENOPROTOOPT instead.
+ */
+TEST_F(ip, mroute_wrong_type)
+{
+	socklen_t optlen = sizeof(int);
+	int val;
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_IP, MRT_VERSION, &val,
+				 &optlen));
+	if (errno == ENOPROTOOPT)
+		SKIP(return, "CONFIG_IP_MROUTE disabled");
+	ASSERT_EQ(EOPNOTSUPP, errno);
+}
+
+TEST_F(ip, bad_optname)
+{
+	socklen_t optlen = sizeof(int);
+	int val;
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_IP, 0x7fff, &val, &optlen));
+	ASSERT_EQ(ENOPROTOOPT, errno);
+	ASSERT_EQ(sizeof(int), optlen);
+}
+
+/* ---------- ipv6 (SOL_IPV6) ---------- */
+
+FIXTURE(ipv6)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(ipv6)
+{
+	/* an 8 byte hop-by-hop header, so the sticky options answer */
+	static const unsigned char hopopt[8] = { 0, 0, 1, 4, 0, 0, 0, 0 };
+	int hops = 42;
+
+	self->fd = socket(AF_INET6, SOCK_DGRAM, 0);
+	if (self->fd < 0)
+		SKIP(return, "AF_INET6 dgram socket: %s", strerror(errno));
+
+	if (setsockopt(self->fd, SOL_IPV6, IPV6_UNICAST_HOPS, &hops,
+		       sizeof(hops)) < 0)
+		SKIP(return, "set IPV6_UNICAST_HOPS: %s", strerror(errno));
+
+	if (setsockopt(self->fd, SOL_IPV6, IPV6_HOPOPTS, hopopt,
+		       sizeof(hopopt)) < 0)
+		SKIP(return, "set IPV6_HOPOPTS: %s", strerror(errno));
+}
+
+FIXTURE_TEARDOWN(ipv6)
+{
+	if (self->fd >= 0)
+		close(self->fd);
+}
+
+TEST_F(ipv6, hops_exact)
+{
+	socklen_t optlen = sizeof(int);
+	int val = 0;
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IPV6, IPV6_UNICAST_HOPS, &val,
+				&optlen));
+	ASSERT_EQ(sizeof(int), optlen);
+	ASSERT_EQ(42, val);
+}
+
+TEST_F(ipv6, hops_oversize_clamped)
+{
+	socklen_t optlen = 64;
+	char buf[64] = {};
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IPV6, IPV6_UNICAST_HOPS, buf,
+				&optlen));
+	ASSERT_EQ(sizeof(int), optlen);
+}
+
+TEST_F(ipv6, hopopts_roundtrip)
+{
+	unsigned char buf[64] = {};
+	socklen_t optlen = sizeof(buf);
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IPV6, IPV6_HOPOPTS, buf,
+				&optlen));
+	ASSERT_EQ(8, optlen);
+}
+
+TEST_F(ipv6, hopopts_undersize_clamped)
+{
+	unsigned char buf[4] = {};
+	socklen_t optlen = sizeof(buf);
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IPV6, IPV6_HOPOPTS, buf,
+				&optlen));
+	ASSERT_EQ(sizeof(buf), optlen);
+}
+
+/* With no header set the reply is empty and the call still succeeds. */
+TEST_F(ipv6, hopopts_absent)
+{
+	unsigned char buf[64] = {};
+	socklen_t optlen = sizeof(buf);
+	int fd;
+
+	fd = socket(AF_INET6, SOCK_DGRAM, 0);
+	if (fd < 0)
+		SKIP(return, "AF_INET6 dgram socket: %s", strerror(errno));
+
+	ASSERT_EQ(0, getsockopt(fd, SOL_IPV6, IPV6_HOPOPTS, buf, &optlen));
+	ASSERT_EQ(0, optlen);
+	close(fd);
+}
+
+/* IPV6_PATHMTU wants room for the whole struct ip6_mtuinfo. */
+TEST_F(ipv6, pathmtu_undersize)
+{
+	socklen_t optlen = 8;
+	char buf[8];
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_IPV6, IPV6_PATHMTU, buf,
+				 &optlen));
+	ASSERT_EQ(EINVAL, errno);
+}
+
+TEST_F(ipv6, pktoptions_wrong_type)
+{
+	socklen_t optlen = 64;
+	char buf[64];
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_IPV6, IPV6_2292PKTOPTIONS, buf,
+				 &optlen));
+	ASSERT_EQ(ENOPROTOOPT, errno);
+}
+
+TEST_F(ipv6, mroute_wrong_type)
+{
+	socklen_t optlen = sizeof(int);
+	int val;
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_IPV6, MRT6_VERSION, &val,
+				 &optlen));
+	if (errno == ENOPROTOOPT)
+		SKIP(return, "CONFIG_IPV6_MROUTE disabled");
+	ASSERT_EQ(EOPNOTSUPP, errno);
+}
+
+TEST_F(ipv6, bad_optname)
+{
+	socklen_t optlen = sizeof(int);
+	int val;
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_IPV6, 0x7fff, &val, &optlen));
+	ASSERT_EQ(ENOPROTOOPT, errno);
+	ASSERT_EQ(sizeof(int), optlen);
+}
+
 /* ---------- tls ---------- */
 
 FIXTURE(tls)

-- 
2.53.0-Meta

