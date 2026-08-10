Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE703AB496
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354142; cv=none; b=VjU+3kpqvy0+lr2DsE/cZEKsEjVEp21tresxZ3CyZOW8w2S39ce2t4sTq/96Ql0Zzn3soQDteesur0fIG/ZEatg9+09KG+PEl8FUq5PuHCE7ddn5geDzcj/jChslVoJPmacsnFnyd9VFfGpcSN91UpGGKJZBqa5uvV3m+E6flpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354142; c=relaxed/simple;
	bh=dQypCPKIKNS651aCXnWtt9L3TZLF2o5VyKmsfF+Vu5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTyXMg/HSx0/ZYdjOBvVgsXOjvw0d8bjzen+Sju748v19YBs93Ww8kimEoUAo5VprFU9tSyqwYMpYAC21mHlmUypirixfq0kvXQMQItm8buPl24T0dorzaccVve5DrcvhIj/wk4OuFvTVwnHjkwf4dMMIj0tfHrKmnvhSNMTmSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g1Y8aqxh; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g1Y8aqxh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=SS
	m/4Xb4KxybNJw7tqCBqLQ05KWXLUuR/uuXe6t7m8c=; b=g1Y8aqxhJE8VwzK0vX
	oNt3X2l4PzghbgzY9FLHgbs1XpqMwOvWQwgdE1tqGF0Jg01MxwOxnuGXfoym5S00
	+KsKggUocX3jHA6MavrsRtXy1z2WWGrB1Z11au77+ql7G0lLxetIT48ozQx64OyM
	t782XoGPLnaqeVXNVrMN9z3eg=
Received: from nec8-i7 (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDXP0C3mXlqOjt9Lg--.4593S3;
	Mon, 10 Aug 2026 17:28:26 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf v2 1/2] bpf: Fix queue/stack map u32 index overflow
Date: Mon, 10 Aug 2026 17:28:13 +0800
Message-ID: <20260810092814.2698521-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810092814.2698521-1-chenyuan_fl@163.com>
References: <20260810092814.2698521-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDXP0C3mXlqOjt9Lg--.4593S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy5XFy5uw1rCr4fuFyxGrg_yoW8CF13pa
	n8JF4rXr1Dtr47t397tw1kWF98Wws5WFy3KF9rGry0yrn3Gr1xWry8Ka1agr9ayr1kA3WY
	qF1qqrZ0k3yjvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbwIgUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5RqNS2p5mbqukQAA32

From: Yuan Chen <chenyuan@kylinos.cn>

The queue/stack map addresses elements[] with the product of a u32
head/tail index and value_size, but the storage itself is allocated in
64-bit arithmetic. When max_entries * value_size exceeds U32_MAX, the
product wraps and push/peek/pop operate on the wrong element, corrupting
map data and leaking stale values to user space.

The original bound check was removed by commit c85d69135a91 ("bpf: move
memory size checks to bpf_map_charge_init()"), which migrated only the
bytes-to-pages conversion and dropped the overflow guard, so oversized
queue/stack maps can be created again.

Restore the bound in queue_stack_map_alloc_check(): reject maps whose
element storage would exceed U32_MAX bytes, keeping the u32 index
multiplication overflow-free. Also reject max_entries == U32_MAX, which
would make the u32 capacity counter qs->size (max_entries + 1) wrap to
0 and permanently break the map.

Fixes: c85d69135a91 ("bpf: move memory size checks to bpf_map_charge_init()")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/queue_stack_maps.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index c1c9dee4dcdd..bb2453693b80 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -59,6 +59,16 @@ static int queue_stack_map_alloc_check(union bpf_attr *attr)
 		 */
 		return -E2BIG;
 
+	/*
+	 * The u32 head/tail index is multiplied by value_size to address
+	 * elements[], and qs->size (max_entries + 1) is stored in a u32.
+	 * Bound the map size so neither the product nor the capacity
+	 * counter can overflow.
+	 */
+	if ((u64)attr->max_entries * attr->value_size > U32_MAX ||
+	    attr->max_entries == U32_MAX)
+		return -E2BIG;
+
 	return 0;
 }
 
-- 
2.54.0

