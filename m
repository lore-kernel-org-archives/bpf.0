Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876D6364028
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776787161; cv=none; b=u9gQ9CxrbyKnRsKZ9fpB7iSEECN75dq4evIKWlTONKAYiSNrOPplZKPB6wc1uGtZC373Zjs/DwFeERGuh8u+G+vBrZDu/ZdPj/MgomzfTiTKBbOFweqzP6ZNRHjkhyuPgb+4Wj3L8ImYtlEJi5JE9uFFeVTDXG13EyMESXYKGgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776787161; c=relaxed/simple;
	bh=MASmzLLYx8bP7k5KvtnKIA/J9TSasL0lOIuwGyJ/+7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJs62EajFNXveP1Aozmmf+aVU8BmfULa9vt6mtgFMtzDr9q6jo64U4PHM3ffX4M/QJ6CXnUMgQL85M0pdH0mNu7/0qe3IyQuEsa+hL0zMP0MZjh7eEWKoea9iZTTalWHDBekar3JRbx6VVSXKs3r3EUG4XCf6dF7OsiKwkIVp3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DWyyV3jM; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DWyyV3jM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776787157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FXbVn3w1/0ZWZKtjjV1fGo1JJvX0eigdezJlZf0mPI=;
	b=DWyyV3jMcOMdC0EmdqPxblY+4mvPESGFDAqc+ig3S481VnOVlcQq8ps3g66z8vJHJ4hn2P
	1JHKrBX6mWHNYGOENSq7DL7NhkF+7gFJd2/REPcFdpNIUhppUNjVO6GHOiqxHOcBr4/6qT
	2vdSvsqGbo97DTQ7DORzzTROtnt58dk=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	shuah@kernel.org,
	ihor.solodrai@linux.dev,
	kafai.wan@linux.dev,
	jiayuan.chen@linux.dev,
	hoyeon.lee@suse.com,
	ameryhung@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Quan Sun <2022090917019@std.uestc.edu.cn>,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>
Subject: [PATCH bpf-next v4 1/4] bpf: Reject TCP_NODELAY in TCP header option callbacks
Date: Tue, 21 Apr 2026 23:58:01 +0800
Message-ID: <20260421155804.135786-2-kafai.wan@linux.dev>
In-Reply-To: <20260421155804.135786-1-kafai.wan@linux.dev>
References: <20260421155804.135786-1-kafai.wan@linux.dev>
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
bpf_setsockopt(TCP_NODELAY) from BPF_SOCK_OPS_HDR_OPT_LEN_CB or
BPF_SOCK_OPS_WRITE_HDR_OPT_CB.

In these callbacks, bpf_setsockopt(TCP_NODELAY) can reach
__tcp_sock_set_nodelay(), which can call tcp_push_pending_frames().

From BPF_SOCK_OPS_HDR_OPT_LEN_CB, tcp_push_pending_frames() can call
tcp_current_mss(), which calls tcp_established_options() and re-enters
bpf_skops_hdr_opt_len().

BPF_SOCK_OPS_HDR_OPT_LEN_CB
  -> bpf_setsockopt(TCP_NODELAY)
    -> tcp_push_pending_frames()
      -> tcp_current_mss()
        -> tcp_established_options()
          -> bpf_skops_hdr_opt_len()
            -> BPF_SOCK_OPS_HDR_OPT_LEN_CB

From BPF_SOCK_OPS_WRITE_HDR_OPT_CB, tcp_push_pending_frames() can call
tcp_write_xmit(), which calls tcp_transmit_skb().  That path recomputes
header option length through tcp_established_options() and
bpf_skops_hdr_opt_len() before re-entering bpf_skops_write_hdr_opt().

BPF_SOCK_OPS_WRITE_HDR_OPT_CB
  -> bpf_setsockopt(TCP_NODELAY)
    -> tcp_push_pending_frames()
      -> tcp_write_xmit()
        -> tcp_transmit_skb()
          -> tcp_established_options()
            -> bpf_skops_hdr_opt_len()
          -> bpf_skops_write_hdr_opt()
            -> BPF_SOCK_OPS_WRITE_HDR_OPT_CB

This leads to unbounded recursion and can overflow the kernel stack.

Reject TCP_NODELAY with -EOPNOTSUPP in bpf_sock_ops_setsockopt()
when bpf_setsockopt() is called from
BPF_SOCK_OPS_HDR_OPT_LEN_CB or BPF_SOCK_OPS_WRITE_HDR_OPT_CB.

Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/d1d523c9-6901-4454-a183-94462b8f3e4e@std.uestc.edu.cn/
Fixes: 7e41df5dbba2 ("bpf: Add a few optnames to bpf_setsockopt")
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 net/core/filter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 5fa9189eb772..96849f4c1fbc 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5833,6 +5833,12 @@ BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 	if (!is_locked_tcp_sock_ops(bpf_sock))
 		return -EOPNOTSUPP;
 
+	/* TCP_NODELAY triggers tcp_push_pending_frames() and re-enters these callbacks. */
+	if ((bpf_sock->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB ||
+	     bpf_sock->op == BPF_SOCK_OPS_WRITE_HDR_OPT_CB) &&
+	    level == SOL_TCP && optname == TCP_NODELAY)
+		return -EOPNOTSUPP;
+
 	return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, optlen);
 }
 
-- 
2.43.0

