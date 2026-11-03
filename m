Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704000;
	b=I2e7WXzeNrm0LdlktVEG5nOk/eKdp7jsy1LXBnJvLVApV3Ek2f39tVjHKzAI4POHFPZC
	 94Gxnc+PtiWa0Ozh+6Kmp9mOWMb6lxctjBy2bylg328M2P3eBhAgEt/GgX3XGqwSBN5re
	 UzqMCyT8+KSkesp24YxVviJ9XkeuLtby+1WZCy2jz+Bi0KO5/Vzh3LW+28+RKUDzQ+3x1
	 zSiuaclQToeopnH6GwEguyj0rUJu/FPfw66u8wLz3UMb06nQamb7cQTaH5cw0yaV0Y2YV
	 FOyWphDF4cSG9P1PEujbce8MzUNv6xzlyILUzm5kDt3PwyeoKI82/BlR1t/KOZWHIoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704000;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=d5Z9wG+EVu9kY+hFLz3UoxaHzvTb8LC6qwfAF10+NBw=;
	b=lUokldruqQYwQ3V8HLuIQB/E9Mt07hKGLWZjk/+nvp+sSWV5s4qdsp1jmYY5VkUtT39i
	 t1MxdCgGYKrNHmik25UzrF7zsni0vc/KnjKQVfvEtNl6/2zWPRY57/I3LULarHoCnlS46
	 lwv+gy76Q1ZT9M4T+D59Cfg4KDqK6rgfrjhPlPq/SgxnYqoMHNOWAXbkCou25iTQWy/xK
	 uv7BCJfChGJAPfenxtPybrFhckjuD/vIJbQstW+oAT2GF4WJkj4dNcnQIXPLCM8j9JgP+
	 FvJluJE7Xe3jU8znS1ktNodXK62MzjHr77jbJrAHL/MedGmKU4lZPXEcPhqaEgFpZmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=reMgaxj+;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DFE606F7C2;
	Tue,  3 Nov 2026 11:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1DFE606F7C2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=reMgaxj+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=d5Z9wG+EVu9kY+hFLz3UoxaHzvTb8LC6qwfAF10+NBw=; b=reMgaxj+DRua4X65pjHbGjieoV
	ee1LPp/r4JIAzLFuIRajFlgCIgSP9czYZd+MV8XL20rlVWyKMtZwaPaxVyfiswrKx4gaA10wSJPH/
	hGbZM0rpqkt5+H6qoH2fLrSfUljGdfqjW08V64VB34fP5DP+sQmwbIU04d11DW3GVkKiHRFLNQmmY
	PEbOQHTxTBuGCUvwbpdKCEqwpaHGYiqHMy//ZSHmPrRJxY1woXNwEl1vhr6TwWVREtU40rFXV0t1j
	OSG0JnYeik7/LcHAO4O+zKcDO+/djkcbfEZICrph210eZZqC6DNRRWXiXi8PV+za1eehhySB7EcLl
	5rVpXdeA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOCLc-006tCW-0O;
	Tue, 03 Nov 2026 11:06:36 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 03 Nov 2026 03:01:00 -0800
Subject: [PATCH net-next v4 1/7] ipv6: treat a negative optlen as 4 in
 do_ipv6_getsockopt()
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
Message-Id: <20261103-sockopt_expand_out_v2-v4-1-2d36da923578@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2443; i=leitao@debian.org;
 h=from:subject:message-id; bh=oB/f2JpXdqBpX3duFOcpr87zR35sk8trgG1TCFAjf8k=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq6cAuX0649qpXHECEQ3+3dfugqYwG+0TotbMBq
 coYFGyUg8mJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaunALgAKCRA1o5Of/Hh3
 bVZVD/9zRKL+8ozqwUKJqHzWcmiYLGlEIyZ5GkqrzsmckwpcsuN5Z8ytdZCqIOoGD3DCfIDkKuo
 bgOnTqG5wMy8Jw+SU8U8SWLkqaCMqCpSBL52h4rUdeoVGANjHOVC89qo1dmVx2KlDzqvGNwUH1v
 3shECH67etIKkojbPVM9jQrdXhv6UMlgstLLoADCobME2Y7+RCFAsy15OHWAuDRkNX+Z1s5NlEu
 9Z46K2wJOK4wbljDTxI3qMEDAhzQ7Sx6N9jTO39Npl3obSRrKSII+E+W7lHk7Q9DuWC1xkTdWxp
 LBjLC1h2nUUs6B1M/Ufrokr5yh2OXmrRmCSdhOGA7RzOJXsFIEDCSeKW785SyJdoZ2FDDlqrQrF
 V96Xo8wa4kQMgpF3Bw1OWU/gOYoHpxFu0oD3mktQDcQa861pwZlHIsETd5M9tCyqSSqvzytVEoH
 sjcKkD/rQ4MU29ZAxDRLA9wNO6IQ/ZS+phF8ugwLInKFUy1zvz5P7EgbKcEsEMWxf1AjbNE9bxa
 U+7f+uGKi3RB8WcLJHrC8KecnVnjWH4rqmaDfHRRnDF8l9RcIeg5W1R4PrcMmfVUoERjcVyEFpU
 A9jcoZQkMDDqiumujLfrryYcJ3pCntisRcQ7QHpuXSi9n9aGp2WTyAKK9pcgcAqZz+k0yizWB+X
 PYeHMpPblG5yYSg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

do_ipv6_getsockopt() reads optlen into an int and never checks its
sign. Most of what consumes len compares it as unsigned, so a negative
optlen reads as a huge buffer, and the reply depends on the option.

The int options clamp it to their own size:

	len = min_t(unsigned int, sizeof(int), len);

so getsockopt(fd, SOL_IPV6, IPV6_TCLASS, buf, &len) with len set to -1
answers 4 bytes and reports 4, rather than failing.

The other options see a huge buffer. The sticky options reply with
their whole header, IPV6_2292PKTOPTIONS writes every pending control
message without a limit, and IPV6_PATHMTU and IPV6_FLOWLABEL_MGR pass
their length check.

do_ip_getsockopt() rejects a negative optlen, but doing that here would
turn a call that works today into an error for a caller that passes an
uninitialized length. Answer it as 4, as the int options do, for every
option this function handles itself.

That leaves the int options as they are. The sticky headers are cut to
4 bytes, IPV6_2292PKTOPTIONS gets a 4 byte control buffer, and
IPV6_PATHMTU and IPV6_FLOWLABEL_MGR fail with -EINVAL, as they do for
any other undersized buffer.

MRT6_* is dispatched earlier and keeps rejecting a negative optlen, and
the netfilter fallback still sees the caller's value.

This changes what callers that pass a negative length see. It is a
behaviour change, not a fix, so there is no Fixes: tag.

The conversion of this function to sockopt_t builds its buffers from
optlen, which the standard helpers reject when negative, so the answer
has to be settled before that.

Suggested-by: David Laight <david.laight.linux@gmail.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Acked-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv6/ipv6_sockglue.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 4b3536571c9804..700133e2fd11c2 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -1002,6 +1002,11 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 
 	if (copy_from_sockptr(&len, optlen, sizeof(int)))
 		return -EFAULT;
+	/* Historic bug compatibility: take a negative optlen as 4, as the
+	 * int options always did.
+	 */
+	if (len < 0)
+		len = 4;
 	switch (optname) {
 	case MCAST_MSFILTER:
 		if (in_compat_syscall())

-- 
2.53.0-Meta

