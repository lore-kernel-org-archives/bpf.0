Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610FD3939A2
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165852; cv=none; b=W/Uy3cMuWs8+XJTj5eTjuKkljg4iInQ1vdfc4+ySFj664dEzQvgo7J/EH3zvLyLSCE4Rg7aWbc6aOH/NtCLy0DIUwv5xZ00EsLXklH1Orvo9ELDNNAZQ46W8NpziIJhPEKJ/MoDg9M6i1mVcPVyq+APEMgyKV073E2u/mgVCHcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165852; c=relaxed/simple;
	bh=hmsqy4cV2LA86UGh87Xqb0jXa1P+m8YQHKjlqn5mTEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDNrnLBew35cW4TCH5f1kEHFVjZRf0VhucDe4DHzitX4L6V46XlGpEbgBUGZEVBn2zDiLeUNBx14aOZFwk36/0W4M4zOnvMG/4mCG0xd+ylLrxuzkJ++bsL2qDjbvJ9egmGnxxWveY7Tiocd4NlxJv+Kr7MDC0jBHMZdQYxYQG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bzm7PEnX; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bzm7PEnX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776165849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8D6l9IqgXenCYoi0Zzds89afKEXhHv1Gdqt5MlYQ8P0=;
	b=Bzm7PEnXtbS1ZFhPk5sBnr9bC0pzse8lilkNeecuWcgm7+fTqLlH9X19uykVXSda/sKwY0
	LIwHBoe2TSHRrq9A3sLBcPK5HZ6ScpPCUZExBhTlXt61AHHbur18X4oKy3ebDnp0RM3fr2
	Ye7aZoMU/+fa4hmmShnTAr8cexjhW3I=
From: KaFai Wan <kafai.wan@linux.dev>
To: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	kafai.wan@linux.dev,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Quan Sun <2022090917019@std.uestc.edu.cn>,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>
Subject: [PATCH bpf-next 1/2] bpf: tcp: Reject TCP_NODELAY from BPF hdr opt callbacks
Date: Tue, 14 Apr 2026 19:23:09 +0800
Message-ID: <20260414112310.1285783-2-kafai.wan@linux.dev>
In-Reply-To: <20260414112310.1285783-1-kafai.wan@linux.dev>
References: <20260414112310.1285783-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

A BPF_SOCK_OPS program can enable
BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG and then call
bpf_setsockopt(TCP_NODELAY) from BPF_SOCK_OPS_HDR_OPT_LEN_CB.

That reaches __tcp_sock_set_nodelay(), which may call
tcp_push_pending_frames(). The transmit path then computes TCP
options again, re-enters bpf_skops_hdr_opt_len(), and invokes the
same BPF callback recursively. This can loop until the kernel
stack overflows.

TCP_NODELAY is not safe from the header option callback context.
Reject it with -EOPNOTSUPP when TCP header option callbacks are
enabled on the socket, so the callback cannot recurse back into
tcp_push_pending_frames() through do_tcp_setsockopt().

Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/d1d523c9-6901-4454-a183-94462b8f3e4e@std.uestc.edu.cn/
Fixes: 7e41df5dbba2 ("bpf: Add a few optnames to bpf_setsockopt")
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 net/ipv4/tcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 202a4e57a218..7ac4c98be19d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4004,7 +4004,10 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 
 	switch (optname) {
 	case TCP_NODELAY:
-		__tcp_sock_set_nodelay(sk, val);
+		if (val && BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG))
+			err = -EOPNOTSUPP;
+		else
+			__tcp_sock_set_nodelay(sk, val);
 		break;
 
 	case TCP_THIN_LINEAR_TIMEOUTS:
-- 
2.43.0

