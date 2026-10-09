Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5FC49DBB9;
	Fri,  9 Oct 2026 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536978; cv=none; b=KcSbK4F/y9/z9WOxuEdoba/1ydg4wh7E8l63FD/QaEB84bDptq5Vb6izFirmR44CjEypepelKx2p3RERT9AR9SRPLTU4AMaNVZx/BxzRvPoIQLS+yPzYMC85HSo+8/oobOLMiUkV1f3mdmENSX8Q79FbtC09nCnbxcm2vqbx3VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536978; c=relaxed/simple;
	bh=y/DdLvZwcbjQxjHN8oQ9pYfPq48DBk/RMYgxKlGaCw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b049r+rYGHdzZEyGFtjc67b+pAxJC7ct/vNQJnIbfFx5H8vrUJFC7PQI/d3ks9XPRFEYcw7n5EG5ll2l8oi2gqbbUOoNeoEZuIWmCRO563CJdYFlNtE2tmfwfPgReNCohOxmJI8xrEV/8way7S/sXpT2Z1FVKWx0B8zbSW715KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=SFcTPKK7; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="SFcTPKK7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=k253xa+jW0J1+auPkR3Hs4PCn1fzRXXjoAXncl1ClCo=; b=SFcTPKK7EPB8jfgojL7E510+BI
	azC1BMbNrZA6C4zqx9rhWi9e3l2lwpnQDTTUG67gWiiMnbsQsAlct1eIdwlGs+MSorWXDhleJyGVO
	uyvURLnWBkf3kZ1due2Srq0kzxxmNOFmNRxgSwDb0SBaO3kMRwTDgPCw7zG4S6rdZeW71K+In8Non
	dwKGLhVJBT22lTVX71nhjRv8SlsTVcl22C4ZhRG3xeyTHWc8NgXWeQ4o4beubOav40uiQzgr3VmVK
	AGN4rJsabjEm/tIq8Kor6oZZHl15s2iyH9jkuTbYHgZauGffVdEjnFGqvFMyRB5gJIBy/K9miL+sC
	lVRysSmQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xF6bR-000QKx-0H;
	Fri, 09 Oct 2026 09:09:21 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 09 Oct 2026 01:53:41 -0700
Subject: [PATCH net-next v2 7/7] selftests: net: getsockopt_iter: cover ip
 and ipv6
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-sockopt_expand_out_v2-v2-7-8ac08c469ecb@debian.org>
References: <20261009-sockopt_expand_out_v2-v2-0-8ac08c469ecb@debian.org>
In-Reply-To: <20261009-sockopt_expand_out_v2-v2-0-8ac08c469ecb@debian.org>
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
 Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 david.laight.linux@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=10798; i=leitao@debian.org;
 h=from:subject:message-id; bh=y/DdLvZwcbjQxjHN8oQ9pYfPq48DBk/RMYgxKlGaCw8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqyK8OuJaZyFMeyjKUlFdHfkZBuygqnUwMOUJhB
 A5GwpoMYNmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCasivDgAKCRA1o5Of/Hh3
 bchdD/9jvAouWnFuj7QEZ1zUJaGrvyHDGkH1b6tlEEbajwRdHEP5BsN8hXV5u9Rmjl/qOlM62uk
 QdtX2wa9UfoM8XY+/IS4lUcbBYcKZsNChUqAUTzcbYlZZlTPC3T3CUkSmZUN8fAlbsUXhP79zmE
 GCfU7ILkPdKrfk22qoo85kuaA1WAIL6SQyy9hyMcUIA3sUcXrdG3akv0M7jHyc0k1DJtmJOwlDT
 h4XLjq8zICL8cTqOuYHtZrKw3Hh9BybbSjs7zcXvb0Mi25F3abMb7PrH498PM+oRAdH46EOYhAR
 SsRUeHsYkv1UEueQzxLWgReb9Qo/ZR6gAp8z+bWot8ah/tYBuhKrBI1fdJwm57S6Jxd4w507WFE
 ICmVagOc37L7SIPY7Nufnjc8pVRx4KKFE7TSMouwM/Bf+Bg98QQS9BKiaEzhzYuTgIqW+WCTt7S
 3T7BWjmN+DltRxeXAcvCjeNwf9NdCeQPh6lxu2qJLduZNjAGFdw79Jr2/HHXHIKdxU543URI9QG
 RvKCeS+nqYzY1scR7Br0Q3GTXyJtnIj4WS7Z8lsIKJSP95XBa4q1YMKkp2dhVMcv0sGhP5SptZa
 G15zQTxouuURn3mVEEbofX565O0Fdhm2vd7vrAPZZe13DO8upKJWf1ejpuRaoe/KfXvfJR8To/q
 rTiTP33yaLyeYNA==
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

Only the two hop-by-hop tests set IPV6_HOPOPTS, which needs
CAP_NET_RAW, so the other ipv6 tests run unprivileged.

The MRT_*/MRT6_* tests skip on a missing /proc/net/ip_mr_vif or
ip6_mr_vif, rather than on the ENOPROTOOPT the switch also answers for
an unrelated regression. A kernel with CONFIG_IP_MROUTE or
CONFIG_IPV6_MROUTE built in no longer hides that regression behind a
skip.

MRT_VERSION and MRT6_VERSION are spelled out; linux/mroute.h does not
coexist with netinet/in.h here.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/net/getsockopt_iter.c | 359 ++++++++++++++++++++++++++
 1 file changed, 359 insertions(+)

diff --git a/tools/testing/selftests/net/getsockopt_iter.c b/tools/testing/selftests/net/getsockopt_iter.c
index 6c2408df461232..252a46d44e522b 100644
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
 
@@ -492,6 +499,358 @@ TEST_F(rawv6, bad_optname)
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
+/* Unlike SOL_IP, a negative optlen has always behaved as 4 here. */
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

