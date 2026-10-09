Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1300D392C2C;
	Fri,  9 Oct 2026 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536947; cv=none; b=iEuARoBHqmoyNGEjWwTBmusHfpk5LO38gTIW83R2il9bBiMaetKOk4D6PXYLS6hXjAZVB6r5ctLAxmBa+1o5/hHhI96OdnC4U6kJqc5il4bThmgWLlOCra/7r5nNJ/X+wopwuRAMSqmjUZjVtxlzChHAA9XzO/mCzvp2BWoeeco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536947; c=relaxed/simple;
	bh=UssMmlpVtkPI5Wr6neO959SSjUtPHjWJdh77WyJr1rM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hQlCCIu8fSEoh/D+3f3QuA0DDKCm/5y+HOCHQyi2FVq2x0jPLMPIztHhEcSxI3ywferF3bKL3Obboy6Ci6hmT67/KZAGkYwhzbzvs37OOAUJ36+dWK7AWqy/wTHmdWC8GL96c0ECDwUF29gOEL1gQZys9AQo9PzL+VT0LxitXrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=DR8d+5vx; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="DR8d+5vx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=g1HSaSuXUDV17Nv/I4lWWspoQoSuGywUd6SpKuR4wJY=; b=DR8d+5vxo4pibCgG9MYD7Za0iA
	dl3rsgfGikRa/6/+wx1NeHkfxmASPMW0JOE1csSYMP5XusjIZLeY7TqTgfD6/QpabeBr8bYKKB+79
	53kA2n6cNi4axMbcz63OsCpNzpIf47gM19FI5/vngfsBI0Reqsbxrq2U/POOE1vSThpluyMCskNjw
	GGaLm0Hm34PItlvPxupjSqQCIdkzFZ+lMYnNjF43FJtrDwtlhUcKpDGzF96OUoqEOOuc6AJ1SZWvS
	+cF09Xgck70VgW/iYkF5kfPW573GpOfYAWS7X9/J1tunHzYcE0UkPQHcKq7ssRQCOp/X8IL/LPlFc
	lKYZ2bTw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xF6aq-000QDB-2h;
	Fri, 09 Oct 2026 09:08:45 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 09 Oct 2026 01:53:35 -0700
Subject: [PATCH net-next v2 1/7] ipv6: treat a negative optlen as 4 in
 do_ipv6_getsockopt()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-sockopt_expand_out_v2-v2-1-8ac08c469ecb@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2091; i=leitao@debian.org;
 h=from:subject:message-id; bh=UssMmlpVtkPI5Wr6neO959SSjUtPHjWJdh77WyJr1rM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqyK8N7gbgS47YCjeeENEWvwqFa2drZykdowiQy
 OFABDV6m7qJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCasivDQAKCRA1o5Of/Hh3
 belREACXeK3CiefomWL2OShRO38fWPwn84Hz/Weo8k/9D3gq+0wzoVla8ADCW5W4kINgWSSIk4V
 q8VCwaRIJFYkTwle4WMDNButYWbIsNveClRmw8XF4fYQYPr/L3OGSifR1J3m+HFARYDttt3sJFF
 8yU7d5lM5fFtBzAa5Jx2N2CildLktXg/SRbNueyz8Rf3Hdv7AKtDK+Xsjq53vZ83a8E+zKqNip2
 lGRyIJvMji+/KfwXC8id2JthCzi3pKrx5mS9NoMAC2GSQlp/E63569z2jBLSmWDi9fDbki4aZsh
 jttxLoveqUs8C/9VpcU/vFHfnyLpbgLZ//fMpVjqlR2TsGawWPEMnEyjhwJ9JsywjgMBb+rLpmH
 w2xTA3haUoUhcoMVIlhEQEGwWmjidFpSRIDVbCjP9yh+5q+ViknEfQxILF9yJ+6jkn7zwaZrson
 cMPH5cIIX/j+prFuD2Iz2BjrS++5J9JzkASeu/bToBB82BNM/FDrr3M0+VFnJ4c1Uoux5cBpLtl
 k4gRr/j2qN21lQUZIe0m+uspRP5YbE93kNBq/WBfijq/qoyKsiaWE8QVcwTnoj6Zcdhj3CAMdCc
 uh9pwGyKTzIAt6X0744fnummnRwynhhLUlS9EXFZeRoDvsqJkJcutQDybm+uy6jUXnln02oqP7o
 GIhFlwdzR0waSMg==
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
option.

That leaves the int options as they are. The sticky headers are cut to
4 bytes, IPV6_2292PKTOPTIONS gets a 4 byte control buffer, and
IPV6_PATHMTU and IPV6_FLOWLABEL_MGR fail with -EINVAL, as they do for
any other undersized buffer.

The conversion of this function to sockopt_t builds its buffers from
optlen, which the standard helpers reject when negative, so the answer
has to be settled before that.

Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv6/ipv6_sockglue.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 4b3536571c9804..4091d1521cc09f 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -1002,6 +1002,11 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 
 	if (copy_from_sockptr(&len, optlen, sizeof(int)))
 		return -EFAULT;
+	/* Historic bug compatibility: the int options have always taken a
+	 * negative optlen as 4, so take it as 4 everywhere.
+	 */
+	if (len < 0)
+		len = 4;
 	switch (optname) {
 	case MCAST_MSFILTER:
 		if (in_compat_syscall())

-- 
2.53.0-Meta

