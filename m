Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704006;
	b=NThR2ecP9ADEfX4CuFW4gmuuNXNq6VeRAhknylBDfKtlY4UyUBNh2ahzrC3X0tj5yxCR
	 97ajTpZJCdmvM+t7yZH/zL1wcaB2vJZU8YMe2MJzL5DGg6RB5pn5n3ZsMpq/VeJhVVEC4
	 REJOjxlv8znpcCMH+IKlpA0juoMzZPvi4HFR8XHhEgbsk0gmuOr6HEtNiM2sAchO85A4g
	 g6fB0s/SsHrd9OrnhT7CZ8SsFkSAnNiF8HFMn973zrLF0umrNCpz/G20gy9NFLLAsAOMC
	 WCQTCVaL90tgHMj1Eidb3FhycjlnwLV4tSzrHlDmiCFO338L99njUfTtkIiqcV1vI8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704006;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=d+krdw05+J40NomB6F/KwnFL/XiX/c+4kaBli9PCuyw=;
	b=4L9RtUGtDgCEm9bX8l+nKbByHa+TIxPLjT8jqrusfQREGDZRFKUl1DTxLThzKUow21g3
	 DexTKjXI51vsulBI4CATjV6Q6N0PAL2uuLDBx9Z9eANa7Oa52b2klM4oI54rZPh4Wftkz
	 qK7QaLpTiqMyZQ2YCG0DJesl7htQu3zcjdvq+rZChW0R96gCWZTDiFf/7SnHnDLIDHLyj
	 0vNCs2SNJf2wg++xXhG0D1cgpFbYo2uZ8k2W2tT8Ih+jXlWi/Y53/9xUaSA7ibCJa9wh3
	 r8oqqv06jf7y/reKAWimjwkGdE3gmsbUaqiXfl9Bi3++Y72oIchIchm3Tcmy0WQ6p/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=owjQilSN;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327A0606F7E6;
	Tue,  3 Nov 2026 11:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 327A0606F7E6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=owjQilSN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=d+krdw05+J40NomB6F/KwnFL/XiX/c+4kaBli9PCuyw=; b=owjQilSNpkgvlXsfMY5OmcOaFU
	uwIgU8ARu4ysD37MG1rx2bmcA1oGonC2u3SSxURDczP5iifoOt6oAWU9bDHYzcYW87usv1Zw5BIOb
	zhwIxIK3sFC3HV+Odj20e94/DEzK4FwzTQ7YkMcVyqg/TySB3Ksd1w6J34ItDVfRvvdVuRCMkyn59
	ByV+ywf6n4bqz9QGQkHBCm30Zzn/GLwWaf/2/Hn/+8/g4dnTX22TVd8Ib/o4MpsLgSRi6/M7gya2q
	p6jLp1Y1jIE60CIQbVjMflAKwF3VPS0nL7FvQ79Ob6bmZRDZ6L+p+Cvh5uQ9TKVkwcInjWGap70W3
	/RCugFog==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOCLi-006tCh-1B;
	Tue, 03 Nov 2026 11:06:42 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 03 Nov 2026 03:01:01 -0800
Subject: [PATCH net-next v4 2/7] net: cap sockopt_expand_out() at
 MAX_RW_COUNT
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
Message-Id: <20261103-sockopt_expand_out_v2-v4-2-2d36da923578@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2216; i=leitao@debian.org;
 h=from:subject:message-id; bh=/EovrQAEKMSHePpIN2DsLxndOGIMLcVnjPekE0pIjlY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq6cAuF1DMsbhQAXMiPOZOKwyn/lZcx58XG8ZgI
 91MPYJKd9SJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaunALgAKCRA1o5Of/Hh3
 bZrpD/9Z8dVTQnJiGkw0kvQm5v7yEqZQerbRu5AXXWqNW8sNKyqzIqdPN0RpBcHbHSw7TTa5BxM
 8wXB2Y5bH5iW8K1rBPMLrA7Os2mxkA+PDDAVY7UggRJs6yEF26wv3xOvdrNNGnYdBureQSKvAbL
 aVqmp78g1OZXRBSpcfSij41o+EAPySbYyX2Tt7WADOyhg3zv01ths+nfVRADWH/F1lT6q5mvvSd
 1Xm0T/DkrkNsYrzK3tuRJM3+NWejj3U7/w34abjPhmBZvSxMWqqzT8VQclPSPX985/cOAGD2xDd
 cM+AcBqnw9w4bAv0TbXaM5G0IF/xDjsMbV4NYoO4iP1i/+npQz+hXTv2j8rKTrCc8AtQ7gLUEGV
 6BjrKt9eARJMv8q39X+pUrtVZc00FYjawMwXG0qVSg/NaJvutMOHR2gfdGDXA9JLqhQkIc/uuYg
 Ghej4PFjL0TztcUunrzHl668G3+Hfi6u/J4X/mnF1LM5WuyAh2vGdYnIqRBS1SVbwHEV/qKXF4N
 +qOmfy3V2mq+DCK1B7XwxTlXj7ZaBLadOgJ67LRnD+5H9yq9XG7V03H92D0r9M3FdN1zqWYDOfm
 zj/Rt2tgZLgZiAkNUhcUUkiGltc7U8gok3ox8DTmuuYi5QWf1rbwzoaPIrZPVg9eqP/22+6aemL
 rVXrB4n7JBZJLJg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

sockopt_expand_out() grows the output iterator up to INT_MAX, but the
MCAST_MSFILTER getters converted by the next two patches rewind it with
iov_iter_revert() once they know the real reply size. iov_iter_revert()
refuses to unroll past MAX_RW_COUNT:

	if (WARN_ON(unroll > MAX_RW_COUNT))
		return;

MAX_RW_COUNT is INT_MAX rounded down to a page boundary, so a caller
that expands into the (MAX_RW_COUNT, INT_MAX] range and then reverts
hits that WARN_ON, and the iterator is left where it was instead of
rewound. So does a caller whose optlen already covers such a size.

Cap the size at MAX_RW_COUNT instead, before the early return for an
optlen that already covers it, so a size that could never be reverted
later is rejected up front.

Sashiko found this while reviewing the conversions.

Acked-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/net.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index e2a866fbcfa5ea..de56f89d475ee2 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -80,16 +80,21 @@ static inline int sockopt_init_user(sockopt_t *opt, char __user *optval,
  *
  * Call it before writing through opt->iter_out: it re-anchors the iterator at
  * the head of optval. Only a user buffer can be longer than the optlen the
- * caller declared, so a kernel-backed optval is refused with -EINVAL.
+ * caller declared, so a kernel-backed optval is refused with -EINVAL. So is a
+ * @size above MAX_RW_COUNT, which iov_iter_revert() could not unroll.
  */
 static inline int sockopt_expand_out(sockopt_t *opt, size_t size)
 {
+	/* iov_iter_revert() refuses to unroll past MAX_RW_COUNT, so a size
+	 * beyond that could never be reverted back to the fixed part later,
+	 * even when optlen already covers it.
+	 */
+	if (size > MAX_RW_COUNT)
+		return -EINVAL;
+
 	if (size <= (size_t)opt->optlen)
 		return 0;
 
-	if (size > INT_MAX)
-		return -EINVAL;
-
 	/* Re-anchoring reads iter_out.ubuf, so the iterator has to be a user
 	 * buffer that nothing has written through yet.
 	 */

-- 
2.53.0-Meta

