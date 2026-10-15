Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8B750B426;
	Thu, 15 Oct 2026 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058764; cv=none; b=QUi2TKsxtJJ8sZW8V9rmq/B0ftXnUKWmNT9kyYVzO7Ef7LxOBlHRIXzqcxgHSlmsbWnoHBrhDz5kKWd5espgVIZ3s3D9KHDLBDOyF/cpILnB2s+6TMFI0F36zc/4DPLKesU78Iy/8tV5Cf2hbpgKLA1+KYHouieFw+hO1wUtj3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058764; c=relaxed/simple;
	bh=BKKGC8j7kmj3qQsDkOgKmlZngZ3IPq2oRZrf/VyOiUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KWwntzfI8rCxktIj7avE7unagwp2PJb1w54r4JWaw2LRWQbhBESDAv0G4yajVE3UZjaQgcFF/tOuBZxtZ7klHZG0dFfzjJRcKpzva76uj7plK8+u0y6/y3E/+8opl7y0v6pohqRFAzrIh6HJfdkSIGra4xZyGiAArQUsTxRWd9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=cDp25/NW; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="cDp25/NW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=89lnP5mpdJjWe4eGgzelQkBONXW9fkepGuDbuiUIPzA=; b=cDp25/NWvDoHAUWmE+3evU671B
	aLOmw4Xk1G6dxA6SHNotxEinXcJpzlT7pOtBYtROzaz23Qg6YkurJ98gvji3Y1wFh5tBPNErncJ39
	Ivu4Vc003a8GlrFHBGXsc9upnQiz+2EnBLBaMSjXmlZC990NAL8+Wkp71lzmHb7KTRivOnmSIQgka
	M+K2wCew2V55NlGb3oBsTyMbD6bax9TDNcHZbAU7djic0xpH8pWzBWhAO56Jqz3v7DUTmUpIqHblY
	3nB8hcD7Ku2I+IqhcAwmW/Cj0xM52Njop+B0BIHSQExwe8YfoVKloLX5MsdD2B6yunqflMd6imEug
	QVNcWZyg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xHILY-0057BH-13;
	Thu, 15 Oct 2026 10:06:00 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 15 Oct 2026 03:05:31 -0700
Subject: [PATCH net-next v3 2/7] net: cap sockopt_expand_out() at
 MAX_RW_COUNT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sockopt_expand_out_v2-v3-2-7d05ef2df448@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2172; i=leitao@debian.org;
 h=from:subject:message-id; bh=BKKGC8j7kmj3qQsDkOgKmlZngZ3IPq2oRZrf/VyOiUY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq0KV06q4Xw/ePYUg0gExh0OqsuxACZkG1YA6YX
 RErVMsn5wWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCatCldAAKCRA1o5Of/Hh3
 bRTsD/4j8TVSpN+pqqO3WhBxfOx0F/6nzueKHBabSKntvVTaV32VljaJdKnUwJLoLf7zcufSJxg
 BLP7tbN6mWcWyzEpVXQl7dq0IrrHZX4g2cmOokB9LGn3HbY1s9AXHpLGDZKF2FC1ab2xXY4GnKw
 DIafqBrZGl7EOSyuFQ0MA2noIkzsZzHJNT4u9Ffyx8m2na7UPiEkd57ioZP/7F1SYTlN+RG02Mn
 es+GvYztrbLX0jq7LUueRErcqc3L2pcGbkvPaJHqcjgP30TFXcx4tTqltqvNZzI7gFQfYUZTVxq
 z9ktdBVOyjzr5Cug0Usws92M9X8oTbttQ9Uc2xC0iRVmitXd2EXaaQeaESdcwHQ9u4t9cztex9t
 NMcp/3P4ThpeKMrQWXhNAxdgPLhMzCSUtFJzaF0+7gF+0sshkCQd0APsm1Vv6P8TggEb2+/BlIX
 U6a6PxRi6HYZFpnP8b7lvhh+Ns3B8OBypwE4IKJ5pJZ4YSzvaUHg9bWlJB3C6P1Vep+KOKBCNKU
 umQJXbmF4Ned4y+UNp6TBi+bHlBaVEUCWha8BD0S9uRVrmfO8b40fyJpHxTZcdXB/oto6iP8Gt4
 6WuqUWcJj8lmbGHen6FuEHwuKStGohpcqCqOWAtLPImszF9SOCauF+IQuQPTxyfM6tq8PJfKVmi
 DPprLl7l1NV0Dng==
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

