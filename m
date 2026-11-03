Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704039;
	b=hQEBHs9P8paut+KTC0Yp1ItaLEQoPAUbAmT6ZMSMPzbW2tzAOVSMuUD89HMjG3YEmww1
	 uIVjl4z09mpKyO8kmIhBCdbbOvSblOcFeBehAcbgZ01imiAQ1spVxBs9jlQ64h5wT0X+v
	 JiacxESGh+L3U0jzflCrOBKMXkUmXX6hHpFhtAHSDFKh3Vai5St41Kv6grZYAFK5PtbfB
	 NQKAtZAGGiJl5n03IWVuZ86gFGbpzB7Mg8CHAkgXPpgjK6/+j+9KaQ+ELhOSTYQiBP285
	 Kt3ZG0usTdnGXCrgkfC/kHVj3Bc77Mm8ZHNWx7OBYdmIMxEX843EYuCOqVUAGSz/bBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704039;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=sUGQUZ32jParOvnwDMoBtI99f85BW6ba9gLM9CHewyY=;
	b=CS+wCHb3UuE8TVm93XwQWUWw3KycL2BE6pKw7K/iNkl0SfG2txX6pQP1OdIuLOLSb2ZL
	 fuQ9821MkxjrmMbQq9Pj0RUlaBHCb5xqKzr+p9Yj783nmTpXKoxAijx/G5s2/xUeEwFYO
	 iEnzAHu1MuJkzr/5/wgehJwpEF9eiuptCr3JAf3TqhkidWl8XjypqWNsZ3mzuxY80ipWT
	 YGxgkSUO4Zz8hIDo/aHdLlPvqCZWOP6DUu3zDPSfi0yfif5PMTIgYM5NNTG4cWrHIbrOs
	 PDJchBCyeAPSSxB50QgpIce1iDPSjp2/fRnEWofpFW17hlvtbl2VTBMNGqFZUs6S8xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=fP0Fb8gO;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EE0608508A;
	Tue,  3 Nov 2026 11:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73EE0608508A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=fP0Fb8gO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=sUGQUZ32jParOvnwDMoBtI99f85BW6ba9gLM9CHewyY=; b=fP0Fb8gOYeSG1TwzthIzvbHkqz
	1bzAvi6/zfTW1wnfHYzPUBZB6rY0uhpizOS8L4ZrnlA91DVVVAMLjw87KxHJiFkHtmIw5FnlAeawy
	0eHwKp0DZkud5jcs6NWfTx/0dBzD8n3OUX2A0hW0skf2f8fDZE8NHWI3JNFLmk5RccpaqocJTqm4Q
	PovV2knSv96Ol0Xi/t4dy7nAYJoLzXhTdPNKk2dm7zxwKgk0Qu7LFd+XqE3+v/e4lO0IyxGZng6IS
	qYKvvorizZwonEb3NavdD7LvJywXusnv32ox6vZVXwXd/G1nKq0ze8kwW8tZRF0PoTZWqMPbbSven
	NZ3H8BGQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOCME-006tE9-0B;
	Tue, 03 Nov 2026 11:07:14 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 03 Nov 2026 03:01:06 -0800
Subject: [PATCH net-next v4 7/7] selftests: net: getsockopt_iter: cover ip
 and ipv6
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
Message-Id: <20261103-sockopt_expand_out_v2-v4-7-2d36da923578@debian.org>
References: <20261103-sockopt_expand_out_v2-v4-0-2d36da923578@debian.org>
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-0-2d36da923578@debian.org>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 david.laight.linux@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=12055; i=leitao@debian.org;
 h=from:subject:message-id; bh=CkMTiEmNzovOQ0GgtPHD9ZU8il55r/o+VSXapnTkXcw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq6cAv79nl2VAhCS00JEFp2ylXzwA+9zLdhGbhz
 EGWeVXDJBOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaunALwAKCRA1o5Of/Hh3
 bUBhD/92Npl1oEo2TcI27U8lfm6kvNBuZ2dgS5Yg6isfMKXYXVWWumyaguQ4/OdNTLYBzTdSxEn
 YbMfKkFXRN48XGauYdG4+4zcXuKB6vC/Ea/KhEX3SAGLkmUl1c/MQYBrXqrxMGJzKeTQfBFGB91
 X56GyZ+cg9YZXoksFJ5X6P4X/jRAhHst0JoHjp7ojczyOm+16v5PuN1fikYXsUMLpfuyHXzke7e
 lT4ESK2/KOKj8GG4aspzIQbxd/mKVFtLXThqNnjtvi4JbQOkX7yscXvckOCFjvk+SsWrreF1yHU
 yXLMLGVrPU6CA+YwlzgDzjusaB4mQAh56CJhXySaEJLFy+JdpRRzS9q+crmyTAEbm8mpZw0hvfz
 kCzbxHvftrzCB9yL8aFIQK77TaVEiMMI2OSTpMOrVTNH324wFeB5OfluNeWCw728LqQxDVVjxV5
 CbtnEpkPeBXbn792/ex3jdRlINqliSsGFktGXyASsXI0o3Exk3hBmAIwb8Xani8k7SwsPEEOHBi
 l/XrZrJzlpZ1d4Z5oOWRnNqqsNHX664LLgJkt7jSV/UE6/8RCU3+9uj02OIXUyzxFs0GXBDzxz6
 HoFUUbR4+RIlC2pSkhh91xeOjcsWwwika8tD4N9w3ZKygVXteKcNWeSDVraqcwrpyUZBjVcIfiW
 ROnBYTKdJqlxcdQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Add an ip and an ipv6 fixture, pinning the returned length and errno
across buffer sizes, the branches that answer empty, an unknown
optname and the options dispatched before the switch. The clamp tests
also compare the bytes copied back, not just the length.

SOL_IP answers a sub-int buffer with one byte where SOL_IPV6 clamps the
int. IP_PKTOPTIONS and IPV6_2292PKTOPTIONS want a stream socket;
MRT_*/MRT6_* want a raw one.

ipv6.pathmtu_negative_optlen pins the clamp of a negative optlen: taken
as 4, it is too short for IPV6_PATHMTU and fails with -EINVAL, where it
used to pass the length check and fail with -ENOTCONN.

Only the two hop-by-hop tests set IPV6_HOPOPTS, which needs
CAP_NET_RAW, so the other ipv6 tests run unprivileged.

The MRT_*/MRT6_* tests skip on a missing /proc/net/ip_mr_vif or
ip6_mr_vif, rather than on the ENOPROTOOPT the switch also answers for
an unrelated regression. A kernel with CONFIG_IP_MROUTE or
CONFIG_IPV6_MROUTE built in no longer hides that regression behind a
skip.

The config fragment only had CONFIG_IPV6_MROUTE=y, so add
CONFIG_IP_MROUTE=y for the ip test, and CONFIG_IP_MULTICAST=y, which
IP_MROUTE depends on.

MRT_VERSION and MRT6_VERSION are spelled out; linux/mroute.h does not
coexist with netinet/in.h here.

Acked-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/net/config            |   2 +
 tools/testing/selftests/net/getsockopt_iter.c | 372 ++++++++++++++++++++++++++
 2 files changed, 374 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index d4416f8bdcfd1d..7c8bf84eaa6dfc 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -29,6 +29,8 @@ CONFIG_IP6_NF_MATCH_RPFILTER=m
 CONFIG_IP6_NF_NAT=m
 CONFIG_IP6_NF_RAW=m
 CONFIG_IP6_NF_TARGET_REJECT=m
+CONFIG_IP_MROUTE=y
+CONFIG_IP_MULTICAST=y
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_IPTABLES_LEGACY=m
diff --git a/tools/testing/selftests/net/getsockopt_iter.c b/tools/testing/selftests/net/getsockopt_iter.c
index 6c2408df461232..2367fce226d4cc 100644
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
 
@@ -492,6 +499,371 @@ TEST_F(rawv6, bad_optname)
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
+	int buf[16] = {};
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IP, IP_TTL, buf, &optlen));
+	ASSERT_EQ(sizeof(int), optlen);
+	ASSERT_EQ(42, buf[0]);
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
+	static const unsigned char ipopts[4] = { 0x94, 0x04, 0x00, 0x00 };
+	unsigned char buf[40] = {};
+	socklen_t optlen = sizeof(buf);
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IP, IP_OPTIONS, buf, &optlen));
+	ASSERT_EQ(sizeof(ipopts), optlen);
+	ASSERT_EQ(0, memcmp(buf, ipopts, sizeof(ipopts)));
+}
+
+TEST_F(ip, options_undersize_clamped)
+{
+	static const unsigned char ipopts[2] = { 0x94, 0x04 };
+	unsigned char buf[2] = {};
+	socklen_t optlen = sizeof(buf);
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IP, IP_OPTIONS, buf, &optlen));
+	ASSERT_EQ(sizeof(buf), optlen);
+	ASSERT_EQ(0, memcmp(buf, ipopts, sizeof(buf)));
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
+	struct in_addr any = { .s_addr = INADDR_ANY };
+	socklen_t optlen = 64;
+	unsigned char buf[64];
+
+	memset(buf, 0xaa, sizeof(buf));
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IP, IP_MULTICAST_IF, buf,
+				&optlen));
+	ASSERT_EQ(sizeof(struct in_addr), optlen);
+	ASSERT_EQ(0, memcmp(buf, &any, sizeof(any)));
+	ASSERT_EQ(0xaa, buf[sizeof(any)]);
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
+ * dispatched at all and the switch also answers ENOPROTOOPT, so the
+ * config check has to come from somewhere other than this errno.
+ */
+TEST_F(ip, mroute_wrong_type)
+{
+	socklen_t optlen = sizeof(int);
+	int val;
+
+	if (access("/proc/net/ip_mr_vif", F_OK))
+		SKIP(return, "CONFIG_IP_MROUTE disabled");
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_IP, MRT_VERSION, &val,
+				 &optlen));
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
+/* an 8 byte hop-by-hop header, so the sticky options answer */
+static const unsigned char hopopt[8] = { 0, 0, 1, 4, 0, 0, 0, 0 };
+
+FIXTURE(ipv6)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(ipv6)
+{
+	int hops = 42;
+
+	self->fd = socket(AF_INET6, SOCK_DGRAM, 0);
+	if (self->fd < 0)
+		SKIP(return, "AF_INET6 dgram socket: %s", strerror(errno));
+
+	if (setsockopt(self->fd, SOL_IPV6, IPV6_UNICAST_HOPS, &hops,
+		       sizeof(hops)) < 0)
+		SKIP(return, "set IPV6_UNICAST_HOPS: %s", strerror(errno));
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
+	int buf[16] = {};
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IPV6, IPV6_UNICAST_HOPS, buf,
+				&optlen));
+	ASSERT_EQ(sizeof(int), optlen);
+	ASSERT_EQ(42, buf[0]);
+}
+
+/* Unlike SOL_IP, SOL_IPV6 clamps a sub-int buffer down to what fits
+ * rather than answering a single byte.
+ */
+TEST_F(ipv6, hops_sub_int)
+{
+	unsigned char buf[3];
+	socklen_t optlen = sizeof(buf);
+	int hops = 42;
+
+	memset(buf, 0xaa, sizeof(buf));
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IPV6, IPV6_UNICAST_HOPS, buf,
+				&optlen));
+	ASSERT_EQ(sizeof(buf), optlen);
+	ASSERT_EQ(0, memcmp(buf, &hops, sizeof(buf)));
+}
+
+TEST_F(ipv6, hops_zero_len)
+{
+	socklen_t optlen = 0;
+	int val;
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IPV6, IPV6_UNICAST_HOPS, &val,
+				&optlen));
+	ASSERT_EQ(0, optlen);
+}
+
+/* Unlike SOL_IP, a negative optlen is taken as 4 here, as the int options
+ * always did.
+ */
+TEST_F(ipv6, negative_optlen)
+{
+	socklen_t optlen = (socklen_t)-1;
+	int val = 0;
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IPV6, IPV6_UNICAST_HOPS, &val,
+				&optlen));
+	ASSERT_EQ(sizeof(int), optlen);
+	ASSERT_EQ(42, val);
+}
+
+TEST_F(ipv6, hopopts_roundtrip)
+{
+	unsigned char buf[64] = {};
+	socklen_t optlen = sizeof(buf);
+
+	if (setsockopt(self->fd, SOL_IPV6, IPV6_HOPOPTS, hopopt,
+		       sizeof(hopopt)) < 0)
+		SKIP(return, "set IPV6_HOPOPTS: %s", strerror(errno));
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IPV6, IPV6_HOPOPTS, buf,
+				&optlen));
+	ASSERT_EQ(sizeof(hopopt), optlen);
+	ASSERT_EQ(0, memcmp(buf, hopopt, sizeof(hopopt)));
+}
+
+TEST_F(ipv6, hopopts_undersize_clamped)
+{
+	unsigned char buf[4] = {};
+	socklen_t optlen = sizeof(buf);
+
+	if (setsockopt(self->fd, SOL_IPV6, IPV6_HOPOPTS, hopopt,
+		       sizeof(hopopt)) < 0)
+		SKIP(return, "set IPV6_HOPOPTS: %s", strerror(errno));
+
+	ASSERT_EQ(0, getsockopt(self->fd, SOL_IPV6, IPV6_HOPOPTS, buf,
+				&optlen));
+	ASSERT_EQ(sizeof(buf), optlen);
+	ASSERT_EQ(0, memcmp(buf, hopopt, sizeof(buf)));
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
+/* A negative optlen is taken as 4, which is undersize for IPV6_PATHMTU. */
+TEST_F(ipv6, pathmtu_negative_optlen)
+{
+	socklen_t optlen = (socklen_t)-1;
+	char buf[64];
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
+	if (access("/proc/net/ip6_mr_vif", F_OK))
+		SKIP(return, "CONFIG_IPV6_MROUTE disabled");
+
+	ASSERT_EQ(-1, getsockopt(self->fd, SOL_IPV6, MRT6_VERSION, &val,
+				 &optlen));
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

