Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283AB49AA35;
	Fri,  9 Oct 2026 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536951; cv=none; b=mMJvaursTu78YTihGsEP8yYuAg4Dto08QHizhlRmDKX6ByhsK4oZjCjei/QE6IoYzZj3fKFyfoRfEprfLh4sbt+4o0I9X0UO673zP2hJXnvT/E4KBkcOvQwueuKeL3UiaSk+4Wv7kd6k/dX9OGsi3a8M/iqjvXEUBeGa42tSdRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536951; c=relaxed/simple;
	bh=PkslookZmOEAsO/zLp1hyjxSUvEuiAClTznXsClXGJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HqPiKQY7qF7vbZrljzn7FEu+gdF7SZLfgRSMjAfyZjfK/KTuKLB8adIYoJzAvGBrp2UuA5LAVf5X5eLrbAPr82mWKdehcOdcPql10S1R5mhfUPc3AMuWG1QEzjRw1njVKsQxubMH9UQ7PXyWrF7UYrm/gymsc2aqLLl9YLzWuxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=EkCD0Xl7; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="EkCD0Xl7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=uTbBQO/mPp1jVqoiUKrSJ5YHsDWbvfv67v9Nx+aEG9k=; b=EkCD0Xl7oB/rsddjzICrVOECIc
	IYPM+cV5zRfNrr+V8OkeU4KzzMGthmYbpL5cQU42/PitZub6+TotBUU80UjKI6cKIBMq9z+aWhdHt
	VovqTbhEYXBpjNJbcfchYbaV4+zHI4/lRob/CvRyCfRbvxNkg2sXN3E39fK1lSW5bHpIj12dSfRce
	kPbc8SR2nsN/KL6utkzKIrNszbritWVtMfJOTHq/iDb743qXbq9gyE6HBiZmhxhfE2hhfGkTnilMR
	5Ks8wXVsdcmK/RNJln+Mbi7Rpw9vO2ZlFeZRB/K6YO/a1QVvYOw3DtrwKoeF4jHZ7i6wDUkhVyzY6
	1ZoSY+6A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xF6aw-000QEP-2v;
	Fri, 09 Oct 2026 09:08:51 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 09 Oct 2026 01:53:36 -0700
Subject: [PATCH net-next v2 2/7] net: cap sockopt_expand_out() at
 MAX_RW_COUNT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-sockopt_expand_out_v2-v2-2-8ac08c469ecb@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1842; i=leitao@debian.org;
 h=from:subject:message-id; bh=PkslookZmOEAsO/zLp1hyjxSUvEuiAClTznXsClXGJo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqyK8NK1DqJTPGZPj1XWBTQAToGrkHQtUv73nHJ
 j2BO6BD6WaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCasivDQAKCRA1o5Of/Hh3
 bY1PD/4i7qSIdf7AjKAcg869RE126w0eqQaGm3bGielCalXRg7s+jypawKF9vJkmn2wzjAWNaOR
 kF2xu+0i073N3mvtNDA/m8n5+OMOWyAhNKZDOCtfesyuRCzXtHbnVBj1AvtJ8I0jT/URepxpL5s
 H966gNLfq4xQ+0DEScTp+TEOY/M4UJ7wAooanWVvq9qFwivmp0dNKgXzZyadyoeZSiway9iWT3a
 JtaRZ5Nk9weFj3p9/xtNfFVgWzNneyrxr7xwyvO+J2oE8SMrzPtNzG5s3hM+lY+KxU8i/bYiNDW
 G2uD6xSlWHOYnNxpisuGJYxzwMA+3doDtMI03HnO+ou2rsmm+VtLJJm08TrshV7Mgszry/CZafq
 HVhPqofkpVfZp4E5XYjC7lBRPboVfxB4XaXESsF5x/jnmq3Bb9QJoUkVIe0K1OyMCq9mB/8lA9N
 qlsEmcTVo0qXBPiLssmHLFUpCh/HpsSmC+XlGSInAVYToAhnR/HVhF/nUela3/N+A5vP4O0/e60
 r+q2pPua94WS6DhXfSGL75jWQAfp+VF0Ffobv5uoYwQJKhk3mLGu8fl7xfZrlXD0U4Bsf1XoyfD
 EC5aI0gvpZG1v4hZZA0CMO0LHPIObv6MrswiCG2QtaOZh1hozAn7gpKYLkEZ6LQmD7hYp8txAlj
 RSMnzUMn//CTIoA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

sockopt_expand_out() grows the output iterator up to INT_MAX, but its
callers rewind it with iov_iter_revert() once they know the real reply
size. iov_iter_revert() refuses to unroll past MAX_RW_COUNT:

	if (WARN_ON(unroll > MAX_RW_COUNT))
		return;

MAX_RW_COUNT is INT_MAX rounded down to a page boundary, so a caller
that expands into the (MAX_RW_COUNT, INT_MAX] range and then reverts
hits that WARN_ON, and the iterator is left where it was instead of
rewound. So does a caller whose optlen already covers such a size.

Cap the size at MAX_RW_COUNT instead, before the early return for an
optlen that already covers it, so a size that could never be reverted
later is rejected up front.

This was detected by sashiko, and I fits in this patchset/net-next,
given this doesn't seem to be a big deal.

Fixes: 0093f7db9c47 ("net: add sockopt_expand_out()")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/net.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index e2a866fbcfa5ea..461137bdc8817e 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -84,12 +84,16 @@ static inline int sockopt_init_user(sockopt_t *opt, char __user *optval,
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

