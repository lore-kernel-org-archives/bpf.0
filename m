Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B028CF5D;
	Sat,  4 Apr 2026 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775311840; cv=none; b=C15nfHHFQR9Kw4T6dyOss4hGLHyZGfU7q4hI9GB4k8Qr6JUfjQm2KgD6Xye1b+MevYwGmKw/GRyhqnVotH9lxUBH6nTjxjcOXlflm5UgLGuNMQy9/eOUJ7syL9yIU61MIL4cJpnIDuGGjsJQJR9Hie6OQ1s2GbsST1EteyT6hKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775311840; c=relaxed/simple;
	bh=tqh6ln50kOE+rSkuGSuyVQT3R3+31MNO9m2m0wq/w1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IMeW9RIq2ATrtR1jV06OiFxGtDpk+FWc1T+GW8QTbofTXAlMXG75IymzcH3kV5LiyuCK757EcGAwqvxAfo2XSDUxh4oZs5rhMgaEgxIvx1A3miNqH7pK93CnYXY7PiO6vP9Iw4sP1wsHHmapks9Df+80b6sI9XIufjhOzUaKE8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KEHaBxq8; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KEHaBxq8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775311826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/IyuYsATSl0pJuMEsDyoffT+pfBv2FLC+gkechdJ0kU=;
	b=KEHaBxq8qjA7xfTGLibFmk4tKB0hJfMf8yHsK9uuJPe7I6cBg777ngp1nEoQ7OzESJni+0
	DOmk1aavXUvwWhqY9UnCuHozyrNXDG+RqIvogi15G+nX2TdahqL0Fr00kwNvYzGbCWAqU9
	HdCw077vsI31UzEo0GXuDbtyUBYGE6I=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Quan Sun <2022090917019@std.uestc.edu.cn>,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v1 1/2] bpf: Fix SOCK_OPS_GET_SK same-register OOB read in sock_ops
Date: Sat,  4 Apr 2026 22:09:35 +0800
Message-ID: <20260404141010.247536-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When a BPF sock_ops program reads ctx->sk with dst_reg == src_reg
(e.g., r1 = *(u64 *)(r1 + offsetof(sk))), the SOCK_OPS_GET_SK() macro
fails to zero the destination register in the is_fullsock == 0 path.

The macro saves/restores a temporary register and checks is_fullsock.
When is_fullsock == 0 (e.g., TCP_NEW_SYN_RECV state with a request_sock),
it should set dst_reg = 0 (NULL) so the verifier's PTR_TO_SOCKET_OR_NULL
type is correct at runtime. Instead, dst_reg retains the original ctx
pointer, which passes subsequent NULL checks and can be used as a bogus
socket pointer, leading to stack-out-of-bounds access in helpers like
bpf_skc_to_tcp6_sock().

Fix by:
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
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
Apologies for the Easter timing!
---
 net/core/filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 78b548158fb05..8fee00e6adef4 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10618,10 +10618,11 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
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

