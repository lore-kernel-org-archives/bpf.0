Received: from va-2-113.ptr.blmpb.com (va-2-113.ptr.blmpb.com [209.127.231.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5733431ED7C
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 07:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789456703; cv=none; b=CNiILqKl0O2LuDKhVbudxF1NsB7rw7nOPdez2RAr/4XdRgnbnAp3UyA+dk4v5zt96UfFJ3z5gbSPQs5TCOtvmhDWMeDq3mXLNZgRhaasHVs6yRlpx9vubbZz4iVfQQiNjpq75CErLu9RfFztuXR2jVDH/1Gyadta7YFyBZ99ZB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789456703; c=relaxed/simple;
	bh=WPjmzXV0oRUSu6jjE8ItS8IHx7MXiaHsntQbQfUvp0c=;
	h=Date:Message-Id:Content-Type:From:Subject:To:Cc:Mime-Version; b=dE6Bva5YdkV4fJBb3XQdbzNVwkrF0oz6s7cl1UormYDulJzQjkLkV1CzMf1lS6l3notY5hJ+qJ/y5cuDaQl6nDCxbnk4eOWGFK2cEf/8FW/mPOjNgh8y8Z6iXJ9XPemqU3YuyzYlKTGiTh9eNNxkhcjgkUZSTAizOE4Y3uKlCak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=qp1lAlJ2; arc=none smtp.client-ip=209.127.231.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="qp1lAlJ2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1789456689; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=rpZp6c+c9TilKHtms8cL/6N80wMrjmu+kVr2MiahNVk=;
 b=qp1lAlJ2yMfphrakgB0MtW2rDtRWT8D3zNZtyrCLesUtRW1mTzwTfnM9noXhOE4zkzJDip
 j/ubuZ3K7bsMCvYE4uJcuXqd3xwDGYHQ0XoQqLiPkIKHocFy4+NKaEkZOW7qVPSyd51OGP
 j8JjW/H7W7Q3/HsRKwm3Zec/bbF5ZXUNocsp/liEgUdOSRtcSYIZcibItq/+hL7p1oYOQH
 z9/IWdrxPpbJXDiM1zgvJKm5QEFyGDuZBaR8AUmykfTWR7zHmhzyRbAFzjQ6lVm9Xow7aD
 x1u+fFz+NE9IpE4541NqVJrlGCt/ThE17cbwaNJkJq2FW1FK6q7qtVicxYNpvw==
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
Content-Transfer-Encoding: 7bit
Date: Tue, 15 Sep 2026 15:17:43 +0800
Message-Id: <20260915071743.29394-1-zhaogongyi@bytedance.com>
X-Lms-Return-Path: <lba+26aa8f12f+028877+vger.kernel.org+zhaogongyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Subject: [PATCH bpf] bpf, sockmap: reject max_entries > INT_MAX in sock_map_alloc
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
To: <bpf@vger.kernel.org>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<john.fastabend@gmail.com>, <jakub@cloudflare.com>, 
	<jiayuan.chen@linux.dev>, <edumazet@google.com>, <kuniyu@google.com>, 
	<pabeni@redhat.com>, <willemb@google.com>, <davem@davemloft.net>, 
	<kuba@kernel.org>, <horms@kernel.org>, 
	"Zhao Gongyi" <zhaogongyi@BYTEDANCE.COM>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

From: Zhao Gongyi <zhaogongyi@BYTEDANCE.COM>

sock_map_alloc() only rejects max_entries == 0 and never caps the upper
bound.  sock_map_free() then walks the sks[] array with a signed int
iterator:

	int i;
	for (i = 0; i < stab->map.max_entries; i++)
		struct sock **psk = &stab->sks[i];

When a SOCKMAP is created with max_entries = 0xffffffff (UINT_MAX), the
allocation of 32 GiB can succeed on large-memory hosts.  During free the
counter reaches 0x80000000, wraps to INT_MIN, is sign-extended by movslq
and turned into a ~16 GiB negative offset from stab->sks, pointing far
below the allocation.  On a KASAN kernel the shadow check for that
address hits an unmapped shadow page and oopses:

  BUG: unable to handle page fault for address: fffff521b59c5a00
  RIP: 0010:kasan_check_range+0x107/0x190
  Call Trace:
   sock_map_free+0x93/0x190
   map_create+0x68d/0xb30
   __sys_bpf+0x21e/0x2e70

Vmcore confirmed stab->map.max_entries == 0xffffffff, stab->sks ==
0xffffc911ace2d000, and the faulting address sks + (s64)INT_MIN * 8
exactly at 0xffffc90dace2d000.  The same Oops triggers on the normal
close()/bpf_map_free_deferred() path whenever such a map is destroyed.

sock_hash_alloc() already bounds its allocation (buckets_num >
U32_MAX / sizeof(bucket)).  Reject max_entries > INT_MAX at creation
time so the signed iterator in sock_map_free() never sees a value that
would overflow.

Triggered by syzkaller and reproduced on both a 6.6-based KASAN kernel
and the upstream v7.3-rc2 kernel.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Zhao Gongyi <zhaogongyi@BYTEDANCE.COM>
---
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
