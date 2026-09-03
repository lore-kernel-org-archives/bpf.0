Received: from mta1.migadu.com (out-151.mta1.migadu.com [95.215.58.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6472247F799
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430201; cv=none; b=JgbL8DYWOSv/BKt6o6vuvL3Bv7vkaDeCKEWoIjo8UBXH363C7CgEL1SJO3gCYWL4Y74FLAIqQ8mmFTow2E6Xnhf07JOUvwUUZYQ572b4FxtEA/sa5fzW0SCMdC52Rr0uKfgwnH1NAaaXMcsnsuAtU7jXuSUxhhZCCBNi0YkwUnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430201; c=relaxed/simple;
	bh=c3BKTF59VZktP3ACG4MFSbcPV9qbzIS6Z4cfOyHB/9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jQnmaA9fr+mD1pWVaWF1wYx6Fd++wr/27Oi4yI1l6zk6JvtH2pIgxEheDlJuwUXBRbiD4eHKnla7YK9pZHJ8mpz+szJPBjwmk0KDZvLxZTx35QoiFdLL8L0AoO2RUbe/t2ieb44CyQ1i3Bm/JtwcP5GsHxUXa5/1+Mwpbxq2K4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mvY9o47k; arc=none smtp.client-ip=95.215.58.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mvY9o47k"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=c3BKTF59VZktP3ACG4MFSbcPV9qbzIS6Z4cfOyHB/9I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788430192; v=1; x=1789034992;
 b=mvY9o47kLQ+fZBihqsiYOtxO12o9ZFoH1yMwjkfa//Kxy25zWgef2CEZoQnx656mM+Rqbyo2
 S+bhNKMRlVxd3f5EKec5la7yrTdJnbnsklIhVnggbZgI/IAbR6WZEyeuYSY7HuaL8ZMoYQ3MQlL
 p64m0TjQTERk7H9WcHbv8yJ0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 83a0c04ce43bf8e0;
	Thu, 03 Sep 2026 10:09:51 +0000
X-Mizu-Trace-ID: 83a0c04ce43bf8e0
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	VEGA <vega@nebusec.ai>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Lawrence Brakmo <brakmo@fb.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: Fix out-of-bounds read of rtt_min in sock_ops
Date: Thu,  3 Sep 2026 18:09:20 +0800
Message-ID: <20260903100921.113374-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sockops prog reading skops->rtt_min never checks the sk type: on the
tcp_conn_request() path sock_ops->sk is a request_sock (non-full), and the
ctx rewrite casts it to a tcp_sock (full) and reads rtt_min past the end of
the request_sock, returning dirty adjacent memory.

	SEC("sockops")
	int prog(struct bpf_sock_ops *skops)
	{
		switch (skops->op) {
		case BPF_SOCK_OPS_RWND_INIT:
			leak = skops->rtt_min;   /* reads the request_sock OOB */
		...
		}
	}

For instance one such read returned rtt_min=0xffff8881, the high half of a
leaked kernel pointer.

Guarding that cast is exactly what SOCK_OPS_GET_FIELD() does -- it checks
is_locked_tcp_sock and returns 0 when sock_ops->sk is not a locked full
socket. Every other tcp_sock field in sock_ops goes through it; rtt_min is
the only one open-coded, so it skips the check.

Read rtt_min through SOCK_OPS_GET_FIELD() too. rtt_min is a bit special:
it is a struct minmax and we only want the current min, so pass
rtt_min.s[0].v. That is equivalent to the old hand-computed offset

	offsetof(struct tcp_sock, rtt_min) + sizeof_field(struct minmax_sample, t)

(s[0] sits at rtt_min + 0 and .v at + sizeof(.t), i.e. what minmax_get()
returns), so the loaded field is unchanged and only the full-sock guard is
added. The two BUILD_BUG_ON()s that protected the hand-computed offset
are no longer needed.

Before patch:

	0: r1 = *(u64 *)(r1 +0)      ; r1 = skops->sk
	1: r1 = *(u32 *)(r1 +2324)   ; ((tcp_sock *)sk)->rtt_min.s[0].v

After patch:

	0: *(u64 *)(r1 +56) = r9
	1: r9 = *(u8 *)(r1 +50)      ; is_locked_tcp_sock
	2: if r9 == 0 goto pc+4      ; not a locked full sock -> 0
	3: r9 = *(u64 *)(r1 +56)
	4: r1 = *(u64 *)(r1 +0)      ; r1 = skops->sk
	5: r1 = *(u32 *)(r1 +2324)   ; rtt_min.s[0].v
	6: goto pc+2
	7: r9 = *(u64 *)(r1 +56)
	8: r1 = 0

Fixes: 44f0e43037d3 ("bpf: Add support for reading sk_state and more")
Reported-by: VEGA <vega@nebusec.ai>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/filter.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 61940e753552..a043d179ff1a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11105,18 +11105,7 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 		break;
 
 	case offsetof(struct bpf_sock_ops, rtt_min):
-		BUILD_BUG_ON(sizeof_field(struct tcp_sock, rtt_min) !=
-			     sizeof(struct minmax));
-		BUILD_BUG_ON(sizeof(struct minmax) <
-			     sizeof(struct minmax_sample));
-
-		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(
-						struct bpf_sock_ops_kern, sk),
-				      si->dst_reg, si->src_reg,
-				      offsetof(struct bpf_sock_ops_kern, sk));
-		*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg,
-				      offsetof(struct tcp_sock, rtt_min) +
-				      sizeof_field(struct minmax_sample, t));
+		SOCK_OPS_GET_FIELD(rtt_min, rtt_min.s[0].v, struct tcp_sock);
 		break;
 
 	case offsetof(struct bpf_sock_ops, bpf_sock_ops_cb_flags):
-- 
2.43.0

