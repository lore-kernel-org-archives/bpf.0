Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28080353EC0;
	Fri, 26 Jun 2026 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782506235; cv=none; b=hbNwgkC3vwLZy5ukkPYJhKocaJWIEdioaq6jmGVbgye7p8S3jJsib+ufeX3bnghQS+fNVZpj4HaG7wxFIX5lU70IBRgQWGm7vO/JVj92lC2psTIFsJmQVjnkvbASoNMwHWYrsERhUsSJj0WkFtLNkUUsIzqUbT8C5elXaLV97fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782506235; c=relaxed/simple;
	bh=ggX3CeKQoY+YK79hIXDqQs4j+F4opYLSe0QU8rrRKV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=txPenefeLq7uc/iH5NuuxnQRPUwAPkRTjRuyRCDtJE646svoQ4VXUAH9mxkiCVcV0NgB4mSMLu7ZZKjcajwtaTKRZCS3gcRHcHDhpLYOmsK0nluqd0D4YOqPgjT55SMlDy3l6bKrxtZJWp9p5Z7TnwptL74kPo4a54iu1W059AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=KHOO7Xtp; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="KHOO7Xtp"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wdDIJ-00DBGU-PW; Fri, 26 Jun 2026 22:36:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=nJRdFVBly5JmvM+Y9nWiIbByIUX/cU+uTj6Oryeotoc=; b=KHOO7XtpIcYAlWkL/zJHm4Uhj+
	1nIh1EN6Z4Lz74nNmIYVELnBen2cO/jULmoBnALHdAWyN9aQUMOHwBrmwq90wtb3+VLH9/ks0JXw2
	CY7hlVJyzSTyFoE+5rVU8CFBxYUdPRY4seX3e7bKtzpkR71tT7FtQmhcMBjhxR51TFLQkrWzjvIb2
	cKnL+zyBZ1T4O6U85oc8lexlA8bZpjKLcAuor4PTWODtxpOLcVhHnK28y5q+bfTuh8ez1hhZOWO90
	n6U7LzPmIJZNURXMr6z1rd7Ynb10b8n23VSPDh6G5ETVds2MyXymnKcJ3Gm2dauRZTpjtz95uRvoB
	YdD1LP5Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wdDII-0006SK-9W; Fri, 26 Jun 2026 22:36:58 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wdDIB-006anB-NP;
	Fri, 26 Jun 2026 22:36:51 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 26 Jun 2026 22:36:31 +0200
Subject: [PATCH bpf v2 3/4] selftests/bpf: Adapt sockmap update error
 handling
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-sockmap-lookup-udp-leak-v2-3-7e7e201c951a@rbox.co>
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
In-Reply-To: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Cong Wang <cong.wang@bytedance.com>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

Update sockmap_listen to accommodate the recent change in sockmap that
rejects unbound UDP sockets.

TCP: Reject unbound and bound (unless established or listening).
UDP: Accept only bound sockets.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index cc0c68bab907..6ee1bc6b3b23 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -63,11 +63,8 @@ static void test_insert_opened(struct test_sockmap_listen *skel __always_unused,
 	errno = 0;
 	value = s;
 	err = bpf_map_update_elem(mapfd, &key, &value, BPF_NOEXIST);
-	if (sotype == SOCK_STREAM) {
-		if (!err || errno != EOPNOTSUPP)
-			FAIL_ERRNO("map_update: expected EOPNOTSUPP");
-	} else if (err)
-		FAIL_ERRNO("map_update: expected success");
+	if (!err || errno != EOPNOTSUPP)
+		FAIL_ERRNO("map_update: expected EOPNOTSUPP");
 	xclose(s);
 }
 
@@ -93,8 +90,12 @@ static void test_insert_bound(struct test_sockmap_listen *skel __always_unused,
 	errno = 0;
 	value = s;
 	err = bpf_map_update_elem(mapfd, &key, &value, BPF_NOEXIST);
-	if (!err || errno != EOPNOTSUPP)
-		FAIL_ERRNO("map_update: expected EOPNOTSUPP");
+	if (sotype == SOCK_STREAM) {
+		if (!err || errno != EOPNOTSUPP)
+			FAIL_ERRNO("map_update: expected EOPNOTSUPP");
+	} else if (err) {
+		FAIL_ERRNO("map_update: expected success");
+	}
 close:
 	xclose(s);
 }
@@ -1289,7 +1290,7 @@ static void test_ops(struct test_sockmap_listen *skel, struct bpf_map *map,
 		/* insert */
 		TEST(test_insert_invalid),
 		TEST(test_insert_opened),
-		TEST(test_insert_bound, SOCK_STREAM),
+		TEST(test_insert_bound),
 		TEST(test_insert),
 		/* delete */
 		TEST(test_delete_after_insert),

-- 
2.54.0

