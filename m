Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C7051E42D;
	Thu, 15 Oct 2026 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058795; cv=none; b=sQwG2MMPwh6BPJPt0OtY84csfpXyn/I3uDz30MXqlUDbe74o9MqdAa33Z7ajD0/hCOuYCW5POLlWYJba08TjkIgJ+jOm2i1JhI01CQNUCm23Mq58t7nAFLbgbTguaI0CJ8G9QY9n5KeoDAttXSTDQFNYzlow0LWqDigf8LTDJ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058795; c=relaxed/simple;
	bh=hYiVd7xQGK/RrGKEZyn0VM9lAbN8CrAvEzy6zQFMKio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oeinaN/mr6PBEW0rmuLx3R9m+DRJfB7AEZWjPRzmnyeW9GaIdL1/G7UXQu5xFe8g/lDQeYYla/IRlZzgLfhryTQmyG95NE6YMU0CtYpd53a5Sv/XQ3PvoylL4Unt7PEi8K5/wgKwIs8Ty0C59dRbRpdpU9LXCB9Zj7/F52CRa4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=bv9ELFz3; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="bv9ELFz3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=z+sI7s742wJbYSxc5a8DMEfxhxFF0woCQDyj9EiPlCo=; b=bv9ELFz3vG+ElDYdUJkpywLyM3
	FtkO0QcSAiu35n6dDk5Bj+Bj5pZbSkJBbkw0x0+NHsm6sxUIJad8Wc3xnn5gO+mCi2iDyJoqRZefQ
	aH3JeKcujWqwl/THSY67O6+O+Unk1vt3RW6YphKasxBY9jrPlxbqyQeU5aBbtyt0dw7dVS4K8b6ck
	r0VAGUgS1pgKOpFTu2HVMBQBAPlN9nfLO6qfjCNgdXA4cvdyfuMOv1AzNX410MXzdx5oA0z7UH7Tj
	KSrLgcSY6LLH2jym5rXfepzAW3EAFsoUrHwv+qd4VvXdF1EtNMCY69y3EYTv8ixzo0e/04CTzStbt
	SPoQkIlA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xHIM2-0057Ca-13;
	Thu, 15 Oct 2026 10:06:30 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 15 Oct 2026 03:05:36 -0700
Subject: [PATCH net-next v3 7/7] selftests: net: getsockopt_iter: cover ip
 and ipv6
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sockopt_expand_out_v2-v3-7-7d05ef2df448@debian.org>
References: <20261015-sockopt_expand_out_v2-v3-0-7d05ef2df448@debian.org>
In-Reply-To: <20261015-sockopt_expand_out_v2-v3-0-7d05ef2df448@debian.org>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 david.laight.linux@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=11931; i=leitao@debian.org;
 h=from:subject:message-id; bh=hYiVd7xQGK/RrGKEZyn0VM9lAbN8CrAvEzy6zQFMKio=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq0KV0d4bb3ZS2ref5fvkDbA+xAnnMY7R4amOQC
 rXddOZU9fKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCatCldAAKCRA1o5Of/Hh3
 baUFD/9iNmXNGBIGzxSphI0hspigKDySyURvbwNA9Yxv4/iSXd5gSDeEFb/ISqAyIHXhJa4w2jF
 e+Lkfej8r0lTvrUXJTWYNtVq3JW0ntVMQLHy/QuhAodlkRRteIKa/O+UzWcPgbLB1vWq4tSQxej
 xSKfiDs/0VI+krhU7PmORmVZ+1UmEemM1fXPVo/9w5LCbTOsKpOHqoWgnBuPQtJY4F3Q/i09ius
 emb8qxuIdXuqDY2Wz9HhQMgytYMcA6M7RL6YDoq5uczxl38zEhix6NZCv8bm301od19UW+3Sa8b
 +JvSAvORcnvsyx4b//BSmyA8zNTyseM9kn276opKuYREjLeKKyiIq8RdUqs8kQ1/1Q29LetoqHB
 ldlXCN3wYAl8PYpgtVKx/dw8a+LgbmPqUgvpf4qe4Eaq16zPYwojcVoXVN/Ktr2zUZim4Foy471
 2e4+mOkhlZgNWdLvT8HVMIRyocee0PzD0IV/I76Yd2E1vkz2JP53c4kfr498b7DKqUKLdJMM4cw
 Zw/uxAbippT9qpOg9gnPqoTaB3Ep8nvQVosoNeWTl86QoFA/btvY0Gh+35OFCj225TYR5G3zaOR
 IU8XTnUag3qfxCxf2HSoY5KuTXCTLB08PiqC1NRoiZs2l8di592PgCubwx+Y31OaQQ2WaucH9E9
 9B9ad1lAwoNw/xw==
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
CONFIG_IP_MROUTE=y for the ip test.

MRT_VERSION and MRT6_VERSION are spelled out; linux/mroute.h does not
coexist with netinet/in.h here.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/net/config            |   1 +
 tools/testing/selftests/net/getsockopt_iter.c | 372 ++++++++++++++++++++++++++
 2 files changed, 373 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index d355cf98059770..07296f0df13943 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -28,6 +28,7 @@ CONFIG_IP6_NF_MATCH_RPFILTER=m
 CONFIG_IP6_NF_NAT=m
 CONFIG_IP6_NF_RAW=m
 CONFIG_IP6_NF_TARGET_REJECT=m
+CONFIG_IP_MROUTE=y
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

