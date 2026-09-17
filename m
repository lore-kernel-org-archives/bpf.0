Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D5E4BD34E
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647061; cv=none; b=WzyT/iGXBMjRQVlZvEJoAoBMuhNw+EXhwETqVtl6VFuiqeBqv+ssPdF6ZEZOZzK1ZJbCEyNVrfCfXV56lAEXWdv+m8ut/GJtlZ31h3a2MSLIjbKzFR4XJJ8dRrxlSJDDKlkdhkMxxPB0Div49Fb9kFN6+AHiE38kzLy1CXZfZNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647061; c=relaxed/simple;
	bh=R/LUprRLLIwHn62Aa6X+Qeen23stIshNt80hL1nPc3A=;
	h=To:Cc:Message-Id:References:Date:Mime-Version:Content-Type:From:
	 Subject:In-Reply-To; b=AuhCaN4dEl4290DnTLsDcCGzT7isLCcitJqVi9+1OdQAAfvMqYn3PKVYOOr6zjzno9Om/tPR0SftdBB+P22s7NZJ+cTs/AZD7Knc54Mm7HRo2cYEH2LPQGDc4kO3FxD+HVinTWCzrc+NQN5hlcMbmVKYWJllsBjLl50r0eJX9Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eiYvEvni; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eiYvEvni"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1789647046; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=/M6XW7TajI5wGVtKhZBxGWB0mPjI/XpBYPgZ/W1nlaQ=;
 b=eiYvEvniDk/QnafpoHOXZg2e8cRAS7+or5s6fQLVpUw52Drmwxw+4BDEWuejbElHLkFggy
 LPjCXo8AQ34r3KqsAYHppkX/kEebXDzFvKSr/TWCzxIYrdZyRNos6oRqLUUANzTFOPmk1X
 aHi2D1EXcY9IeXTQN/y6T4JRWhUIlzkNh8DTHN5zFjfuzsoSxultY3rQuN3RR1QxKO6ba6
 Onx/Ecmb+y5LxWlB6La+TpLB6EOVojFauEL5XJ6UGVmcG0t61zDIUgebTCiCDKb6bw4s/X
 di30M59xD036NKOwoBxBJkg9LKXfc4vBLqU00gYgSIEtQkAXJdx+hhPGZdOG3A==
To: <bpf@vger.kernel.org>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<john.fastabend@gmail.com>, <jakub@cloudflare.com>, 
	<jiayuan.chen@linux.dev>, <edumazet@google.com>, <kuniyu@google.com>, 
	<pabeni@redhat.com>, <willemb@google.com>, <davem@davemloft.net>, 
	<kuba@kernel.org>, <horms@kernel.org>, <daniel@iogearbox.net>, 
	"Zhao Gongyi" <zhaogongyi@BYTEDANCE.COM>
Message-Id: <20260917121016.48171-1-zhaogongyi@bytedance.com>
References: <20260915071743.29394-1-zhaogongyi@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Date: Thu, 17 Sep 2026 20:10:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26aabd8c4+6b47c4+vger.kernel.org+zhaogongyi@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Subject: [PATCH bpf v2] bpf, sockmap: reject max_entries > INT_MAX in sock_map_alloc
In-Reply-To: <20260915071743.29394-1-zhaogongyi@bytedance.com>

From: Zhao Gongyi <zhaogongyi@BYTEDANCE.COM>

sock_map_alloc() only rejects max_entries == 0 and otherwise allows any
u32 value.  sock_map_free() then walks the sks[] array with a signed int
iterator:

	int i;
	for (i = 0; i < stab->map.max_entries; i++)
		struct sock **psk = &stab->sks[i];

When a SOCKMAP is created with max_entries = 0xffffffff (UINT_MAX), the
allocation of 32 GiB can succeed on large-memory hosts.  During free the
counter reaches 0x80000000, wraps to INT_MIN, is sign-extended by movslq
and turned into a ~16 GiB negative offset from stab->sks, pointing far
below the allocation.

The faulting access is an xchg() write in sock_map_free().  Without
KASAN, the same out-of-bounds write can fault on an unmapped vmalloc page
or corrupt an unrelated allocation if that vmalloc address is populated.
On a KASAN kernel with CONFIG_KASAN_VMALLOC=y, the shadow check for that
address hits an unmapped shadow page and oopses first:

  BUG: unable to handle page fault for address: fffff521b59c5a00
  RIP: 0010:kasan_check_range+0x107/0x190
  Call Trace:
   sock_map_free+0x93/0x190
   map_create+0x68d/0xb30
   __sys_bpf+0x21e/0x2e70

Vmcore confirmed stab->map.max_entries == 0xffffffff, stab->sks ==
0xffffc911ace2d000, and the faulting address sks + (s64)INT_MIN * 8
exactly at 0xffffc90dace2d000.  The same buggy path is reached on the
normal close()/bpf_map_free_deferred() path whenever such a map is
destroyed.

sock_map_alloc() used to bound its allocation size through
bpf_map_charge_init(), but the bound was dropped when rlimit-based memory
accounting was removed.  Reject max_entries > INT_MAX at creation time so
the signed iterator in sock_map_free() never sees a value that would
overflow.

Triggered by syzkaller and reproduced on both a 6.6-based KASAN kernel
and the upstream v7.3-rc2 kernel.

Fixes: 0d2c4f964050 ("bpf: Eliminate rlimit-based memory accounting for sockmap and sockhash maps")
Signed-off-by: Zhao Gongyi <zhaogongyi@BYTEDANCE.COM>
---
v2:
- Correct the Fixes tag to the commit that removed the allocation-size
  bound.
- Clarify that the bug is an out-of-bounds write reachable without KASAN.
- Add Daniel Borkmann to Cc.

 net/core/sock_map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index ca49bc7f8..38df84284 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -41,6 +41,7 @@ static struct bpf_map *sock_map_alloc(union bpf_attr *attr)
 	struct bpf_stab *stab;
 
 	if (attr->max_entries == 0 ||
+	    attr->max_entries > INT_MAX ||
 	    attr->key_size    != 4 ||
 	    (attr->value_size != sizeof(u32) &&
 	     attr->value_size != sizeof(u64)) ||
-- 
2.39.5 (Apple Git-154)
