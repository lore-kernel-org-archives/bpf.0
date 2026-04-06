Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F02299AB1
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 03:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775445250; cv=none; b=J+pjVUh1+8SOVr8cW7jcSur7beY5B1zV6AhuEFe62VuUpDkhBqllAqdG9hrFO2AYApn1u6DMGBbJ+1W1MQzY+WsZNmAi5fSKzhuwkW/9PG9ELaibqeXIWq1OGRONDZX8SKOGHXK7iaw0S4HOvvtsdqXMHDI/KgAWQmf1X8RCRrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775445250; c=relaxed/simple;
	bh=2fjFS/gE89SvskAExn1rVUPRVLS/Gzk5i+5JAEqPtJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wmc+4lpkWg+QOZwz2PGeWwTE6uxBpNz/0qlPBHAHNjao5rjRzy8oBQx7yUvlp8sDXPH4fFGt5NFfDhMfvENIcEZzJvFKTVrQJS0E2ss2uxY580c4Lo/AY8Tr0FgXJTBx30aUZCFb/Cj1i2Iqdj3SB2yAtcK+eGJpwXs+sJMtt0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KxDU230x; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KxDU230x"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775445242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V8LOeE8Mt1+8duHHQlOPBHk9dC42/Rtrw2fZLp3yyEU=;
	b=KxDU230xxLhMLKfMSJsN+zEWAgqD1NEpSr8cPuReToo+QefkYiSqkjDUA8ho6DRMEIdWbN
	nEM/NAxgxe/ylkjIn6P0yZPg1k6JTQ48WXXXhnfrCggr+EGjUk2KMyCa4ArqGNFAebOqN4
	zWBkN6KJ8Bvq+RRqJy/k38ils4pr4Dg=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Quan Sun <2022090917019@std.uestc.edu.cn>,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 1/2] bpf: Fix same-register dst/src OOB read and pointer leak in sock_ops
Date: Mon,  6 Apr 2026 11:12:50 +0800
Message-ID: <20260406031330.187630-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When a BPF sock_ops program accesses ctx fields with dst_reg == src_reg,
the SOCK_OPS_GET_SK() and SOCK_OPS_GET_FIELD() macros fail to zero the
destination register in the !fullsock / !locked_tcp_sock path.

Both macros borrow a temporary register to check is_fullsock /
is_locked_tcp_sock when dst_reg == src_reg, because dst_reg holds the
ctx pointer. When the check is false (e.g., TCP_NEW_SYN_RECV state with
a request_sock), dst_reg should be zeroed but is not, leaving the stale
ctx pointer:

 - SOCK_OPS_GET_SK: dst_reg retains the ctx pointer, passes NULL checks
   as PTR_TO_SOCKET_OR_NULL, and can be used as a bogus socket pointer,
   leading to stack-out-of-bounds access in helpers like
   bpf_skc_to_tcp6_sock().

 - SOCK_OPS_GET_FIELD: dst_reg retains the ctx pointer which the
   verifier believes is a SCALAR_VALUE, leaking a kernel pointer.

Fix both macros by:
 - Changing JMP_A(1) to JMP_A(2) in the fullsock path to skip the
   added instruction.
 - Adding BPF_MOV64_IMM(si->dst_reg, 0) after the temp register
   restore in the !fullsock path, placed after the restore because
   dst_reg == src_reg means we need src_reg intact to read ctx->temp.

Fixes: 84f44df664e9 ("bpf: sock_ops sk access may stomp registers when dst_reg = src_reg")
Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/6fe1243e-149b-4d3b-99c7-fcc9e2f75787@std.uestc.edu.cn/T/#u
Suggested-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
---
 net/core/filter.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 78b548158fb05..53ce06ed4a88e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10581,10 +10581,11 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 				      si->dst_reg, si->dst_reg,		      \
 				      offsetof(OBJ, OBJ_FIELD));	      \
 		if (si->dst_reg == si->src_reg)	{			      \
-			*insn++ = BPF_JMP_A(1);				      \
+			*insn++ = BPF_JMP_A(2);				      \
 			*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
 				      offsetof(struct bpf_sock_ops_kern,      \
 				      temp));				      \
+			*insn++ = BPF_MOV64_IMM(si->dst_reg, 0);	      \
 		}							      \
 	} while (0)
 
@@ -10618,10 +10619,11 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 				      si->dst_reg, si->src_reg,		      \
 				      offsetof(struct bpf_sock_ops_kern, sk));\
 		if (si->dst_reg == si->src_reg)	{			      \
-			*insn++ = BPF_JMP_A(1);				      \
+			*insn++ = BPF_JMP_A(2);				      \
 			*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
 				      offsetof(struct bpf_sock_ops_kern,      \
 				      temp));				      \
+			*insn++ = BPF_MOV64_IMM(si->dst_reg, 0);	      \
 		}							      \
 	} while (0)
 
-- 
2.43.0

