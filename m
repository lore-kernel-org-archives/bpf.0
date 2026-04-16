Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6FF399009
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338665; cv=none; b=KKuMgKgCljXwYYWE/X44N+9+b5NpnvWWEg4yIP9racG7TZcHPvYN6yxGv+84ZEreB59xRAdjQhbKV3pycy0cQTgeTb4AvO7G62a32uBhS8eydziJJu0CfPoXrlCHaRWujwHQPdIjg4vWzmE77cwcPZNtENHkjORmon/iafBYnW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338665; c=relaxed/simple;
	bh=tGOhrptT9PJ5/cvzp6EKffTU5Kr88yNrPL4dsjtp0/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dy5fobXbgEzyoIaSClMNigqoS014s6XAs20dibZ0NebmwO4EAwtdFIRRm3bxcNdZKZ4LRBk+kPHUzvIujOxnmajqpQAoKB+2avCkFR9oofb/sSbi4KyD45UM8EB7q5QLoRtlNm+mFZkbA3pWS7qQjqbqS1URnootqdBJxzBcFUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UF1KpSD0; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UF1KpSD0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776338662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8AldNZMVHS+FDrWsqQWGH6HMzCXTBhC6l0kEDtweIFA=;
	b=UF1KpSD0RSSqrsSf0EPQ+pdlhKbgUzEbBpVt3z0hBlQ9KX33ed7Ig5M4GtdluxgiCN2NdE
	NtRnLLXQ+AAm4swHPVKFRRkpN+J2ZGW/ycKIQwiQNJzvTko3F5O3GFRrx+5/FKPmFEY917
	a0VVUGPFpWNVuzdxNaUDTio4cDNPofg=
From: KaFai Wan <kafai.wan@linux.dev>
To: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	jiayuan.chen@linux.dev,
	kafai.wan@linux.dev,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Quan Sun <2022090917019@std.uestc.edu.cn>,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>
Subject: [PATCH bpf v2 1/2] bpf: Reject TCP_NODELAY in TCP header option callbacks
Date: Thu, 16 Apr 2026 19:23:07 +0800
Message-ID: <20260416112308.1820332-2-kafai.wan@linux.dev>
In-Reply-To: <20260416112308.1820332-1-kafai.wan@linux.dev>
References: <20260416112308.1820332-1-kafai.wan@linux.dev>
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
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 net/core/filter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index fcfcb72663ca..911ff04bca5a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5833,6 +5833,11 @@ BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 	if (!is_locked_tcp_sock_ops(bpf_sock))
 		return -EOPNOTSUPP;
 
+	if ((bpf_sock->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB ||
+	     bpf_sock->op == BPF_SOCK_OPS_WRITE_HDR_OPT_CB) &&
+	    IS_ENABLED(CONFIG_INET) && level == SOL_TCP && optname == TCP_NODELAY)
+		return -EOPNOTSUPP;
+
 	return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, optlen);
 }
 
-- 
2.43.0

