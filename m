Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194A3630AE
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781269815; cv=none; b=pgbVkHY7CapNHWykkhrAXxOVRIam8dvqTsaPL3SkqUmaqchRaE2z1mpenlOjZ2uhct0pozufjw1dpriGSep44l9vrW+qZou6u4U5jTP2SdjmdheW2VOu+ZwOyGUnI0G+XrejOxclHxyHVFYwWEeE+KlGA0VfK+/OhiX4DEmhGN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781269815; c=relaxed/simple;
	bh=XbOAUH8WytbqjJf9mEkN3aInkJAhMWRdnUnVGUdY6KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eY7L+BmlV4TOqIBL7MgTJQQBh3c0iq2cirbuQFHrkNGk0OLnwiT9lSO64mLq39Qrq+WkjP9kaoAVIPkR7xx/mGCD/GPrua6OBQwQLI5E+5McboFgSiPg4+QZoph/1d/AI0Q3MHA/lQNNkOCREw2OTxC3eHZG27G9sHKnkf8xKiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f5Vbkv83; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f5Vbkv83"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781269811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XXGieA2RvXVOHyZqSrDmHdDLXTrUoXN/n+L6EQb3E0=;
	b=f5Vbkv83237tLq0igmnAYC+JxfLDO4gB1mqRF0BDy2dNoL8DuIwH8/pMD0H12f02LDsBDb
	YRJMlyVYf/y6v8UyUjq7qFFgx1qOi1aOJjAgfh2XsbyzjH4NkrpbWIoGH823HOYwYZamib
	lnUDIkgZqssxzl1XLt4f/jkSsNpcF1I=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
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
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Cong Wang <cong.wang@bytedance.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 2/7] bpf, sockmap: Fix wrong rsge offset in bpf_msg_push_data()
Date: Fri, 12 Jun 2026 21:07:46 +0800
Message-ID: <20260612130919.299124-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260612130919.299124-1-jiayuan.chen@linux.dev>
References: <20260612130919.299124-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Weiming Shi <bestswngs@gmail.com>

When bpf_msg_push_data() splits a scatterlist element into head and
tail, the tail's page offset is advanced by `start` (absolute message
byte offset) instead of `start - offset` (byte position within the
element). This makes rsge.offset overshoot by `offset` bytes, pointing
to the wrong location within the page or beyond its boundary. Consumers
of the corrupted entry either silently read wrong data or trigger an
out-of-bounds access.

 BUG: KASAN: slab-use-after-free in bpf_msg_pull_data (net/core/filter.c:2728)
 Read of size 32752 at addr ffff8881042f0010 by task poc/130
 Call Trace:
  __asan_memcpy (mm/kasan/shadow.c:105)
  bpf_msg_pull_data (net/core/filter.c:2728)
  bpf_prog_run_pin_on_cpu (include/linux/bpf.h:1402)
  sk_psock_msg_verdict (net/core/skmsg.c:934)
  tcp_bpf_send_verdict (net/ipv4/tcp_bpf.c:421)
  sock_sendmsg_nosec (net/socket.c:727)

Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
Reported-by: Xiang Mei <xmei5@asu.edu>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
To sashiko:

Regarding bpf_msg_push_data() reading "copy = msg->sg.data[i].length" with
i == msg->sg.end (appending at the very end of a full/near-full ring):

This is pre-existing code, not touched by this series, and reproducing it needs
a narrow combination -- a pure append at the end so the loop exits with
i == msg->sg.end, a full/near-full ring, plus a prior push/pop history that
leaves a stale length in the otherwise-unused end slot. A freshly built ring
zeroes that slot, so copy stays 0. We don't consider it practically reproducible.

Even then it's already covered: the overflow check in patch 1 ("copy + len <
copy") rejects the dangerous case, and __GFP_ZERO in patch 3 prevents any data
exposure. Not worth fixing here.
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 3c8f1cedb217f..3e555f276ba80 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2872,7 +2872,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 
 		psge->length = start - offset;
 		rsge.length -= psge->length;
-		rsge.offset += start;
+		rsge.offset += start - offset;
 
 		sk_msg_iter_var_next(i);
 		sg_unmark_end(psge);
-- 
2.43.0

