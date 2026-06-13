Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF80B30D41F;
	Sat, 13 Jun 2026 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781367919; cv=none; b=T16h+knAl9AfKbiO++U3w/1OugPrJ5USrUy/OowZPw78dkBNR4Tf3J393Q6dWxjWjgRdf1TrqL5XIVCvLd4QAjmMzM1zbInrODgbvvGXBPLFrEAw9oDDPHNUnzu/mmn+YdUmK7Q7JIqI4ANv3duTryzxXqrizHaUiZSfaPq8CIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781367919; c=relaxed/simple;
	bh=Eal2czQ95OzT7W6wIkz0a5NNDrThTK5VqMCa1pr5ZC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBSN6KlFz4zy/+ParTogTVRsKu3YdIlEvLkn/9AbFOAIakoCwAeulZMRCR0Npd0zUylzzoHCY7k4n8/mK3HL91SW55tPMWdAhc9qgYVrs7mT3NCHfIOtdwua73vSt90rPPgo+/MMzeLT+e8R/kiNDRm9o4yRfojW/q8to+ggXVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v65xRIoT; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v65xRIoT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781367914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B8tNNOKX9vfVW0agW6GrP6/656hRhnEOUOOBtzzI4Vk=;
	b=v65xRIoTDffq84H+qFuzsYjKkb5yJ2o2dSOm5M9Nzop343f3yvyHeL7X1rUSy4i841CgNa
	fqodtywTbu4Ibxv6bXrsWrdA5X1sSWodtrMrf2DUdzd/ptqSPkYDUN1vYfI2GsVReOfjYz
	HYTk9I/BG3rXCqchxpqB4g30VFM3kII=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Feng Zhou <zhoufeng.zf@bytedance.com>
Subject: [PATCH bpf-next v4 1/2] bpf: Fix bpf_get/setsockopt to tos for ipv4-mapped ipv6 socket
Date: Sun, 14 Jun 2026 00:24:42 +0800
Message-ID: <20260613162443.60515-2-leon.hwang@linux.dev>
In-Reply-To: <20260613162443.60515-1-leon.hwang@linux.dev>
References: <20260613162443.60515-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When TCP over IPv4 via INET6 API, bpf_get/setsockopt with ipv4 will
fail, because sk->sk_family is AF_INET6. With ipv6 will success, not
take effect, because inet_csk(sk)->icsk_af_ops is ipv6_mapped and
use ip_queue_xmit, inet_sk(sk)->tos.

To relax this restriction, allow getting/setting tos for those possible
ipv4-mapped ipv6 sockets.

Fixes: ee7f1e1302f5 ("bpf: Change bpf_setsockopt(SOL_IP) to reuse do_ip_setsockopt()")
Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 net/core/filter.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 9590877b0714..57b00c6cc8cc 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5544,11 +5544,24 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
 				 KERNEL_SOCKPTR(optval), *optlen);
 }
 
+static bool sk_allows_sol_ip_sockopt(struct sock *sk)
+{
+	switch (sk->sk_family) {
+	case AF_INET:
+		return true;
+	case AF_INET6:
+		/* Allow getting/setting sockopt for possible ipv4-mapped ipv6 socket. */
+		return sk->sk_type != SOCK_RAW && !ipv6_only_sock(sk);
+	default:
+		return false;
+	}
+}
+
 static int sol_ip_sockopt(struct sock *sk, int optname,
 			  char *optval, int *optlen,
 			  bool getopt)
 {
-	if (sk->sk_family != AF_INET)
+	if (!sk_allows_sol_ip_sockopt(sk))
 		return -EINVAL;
 
 	switch (optname) {
-- 
2.54.0

