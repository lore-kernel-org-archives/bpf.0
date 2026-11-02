Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793601763;
	b=NF+sy16k1YB5tSN3D09yJW7ccjOGluQk7SOJG/MHNojjZXn+6GaevcnKJyNYjFqWdjBA
	 QodiGtlnMBebhzANkKlO5gU2BaZr9GOEeutlsuKV9irnqsFnmKObq8SGaK/TxoxfanXZN
	 P+LqcT6Mo2/chn2WNO3WTcq9mX5wReW6Cp9TZwPnKigLOcHjDdCWt8BOsgnu/+6NHQWe0
	 WB8mwUfH7sjfFrOXwh3Fo0Xx2Xb3x+tB/LBylW1ejKf5DxQ8vOg+Vb9xZHPUoFzticPIF
	 I3C/4uiRltDwbh+ioP28PgFtrtHosxrc8nOEOQNJov+SPunh4aEiIp52TfB2i4LazBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QoMI/FZCQa4u5nLEyUZ1q2lXAGyIWuDungF213DoDi0=;
	b=RyZ5vFg2fmiW6GrTOymmIuDZm+OEjAxDLUUizgd0LlamFiNgiWncDDdlkYb/79t9D7pD
	 W6Ic0oFBpkMpz5drNdLmahP2vcJwqPfdWMNIvLIH4/Fkhk+SGov/hIqMeA9wSsQRNAHck
	 5hGP5e3XERao3dSJj3c9qZ383QfqHLpeA1wa6QZwRPT6F4D7KScEuZhtiP69w2Ef5W97i
	 CZEdoa2VuW3rii/FDMgid2Ew4LzuSVjpVaA5lNK28kuxrRrXc9jSg0+x2DH2SdIrnvnOn
	 mBA527/M0ZeovuPXi5t0l2YGoZN0Q9o4accBsXQ9D2Lw0JnQzY1sCP11ZfAtwTno4Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VdlzR44r;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C859B606A326
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 06:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C859B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VdlzR44r
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e812e2b31bso15146585ad.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 22:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793601762; x=1794206562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QoMI/FZCQa4u5nLEyUZ1q2lXAGyIWuDungF213DoDi0=;
        b=VdlzR44ru3qY4hbviz5lFTzRLBOHK5oUb5cvoOFdqOTXbPXSNMyz6K/KAOyHPbXfik
         SB3gpYUQ2AUJtHJ6CxY4g76HkLJd/ur8nUNcYFeYXLKIqCht/MOcI0p3liqMwgW6Ijeu
         2vggItjzQVcCG+c1umrduULieHb4ovNK/uU9JT37+UcnWeDZmVK3cjT9Vd9oyK9tKBPv
         lbNFqHiFsW3GyJi5utMu02V4AlXOiVEwJXw3He5clT2uMQJkqe968ViJSwdO0cXtI6b3
         zY9XyR6vc7JKgvNnWd4h5wWaDD0hhrspTlMQ+sU/Ukl7qC1f6z7xUiJOgKus82pqPwdv
         ydng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793601762; x=1794206562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QoMI/FZCQa4u5nLEyUZ1q2lXAGyIWuDungF213DoDi0=;
        b=Vimru8VDs/8HoYdkSEsiVDcmVWRLYIgouVmS5kHC1Hl4JZ/Lta8Cjw4NgaMFyQeS3y
         h7h8+lbKUL8WWBvpPkHI7qjOoW34ox8J44k4+H95yOL8Y85/SQH32RXOrwaEpDH0s70M
         7uacCcYzQyVSWmzQ5BZmaN+Br5m3JIWbmWwFoINH2gqVk0nRkUNodR6jvh44USIM+NA5
         IKMk/MaiEuATmYADRku1g5w35ZS1SkWEbQTQg/fcYFklDkd6+pA5dKPmb7BVeK658fno
         45PgA0N9qM5yBXrjOCw01sB70913jaoutUTR3ZrWSq9xxIRqRvpzBZH5kx04Hm0m71l+
         /idA==
X-Gm-Message-State: APuU4Z9snA6jUj+YdGsaOA7SJHFQrKOd72zK3IzrYbnEyIahY3i0oq+c
	YLjpBihROlAVIU6mKGE42k9CMP2nnH2ezXxgoML6Qa6a6UbAjS1QdSIicgZmwQ==
X-Gm-Gg: AYBFou1tmo8AlJOE9ByljTAlBwCz2NdNevVSeyvbDIIij5bOWOb48CvmT9+sJ0BwS6t
	0P5tAy2ffpuSxNiw0Vr4nSKdeExPNirrBlYnoSfLkQVtZc9lblk8GhxbqEL1yBon9li7zmYlOAF
	hllQBg8xQEkcC20rTw6w+u5iWvmLYnZqTr5zbBeFeRV0T2v/xDb1wU8iOHv3jwiVVuI9ejnPqKO
	zVJl05l8j2qnQHZf+SJrfisW/Ro9nGrQI3s5t/jhS4evtA+aE+HXSALshV3ZcpOT6zGFk1EBWfp
	CfLpFsrQD8agHSgx9irbW8lW9VVKONp/t6T41KXt4xvbTR2TqAg1KeF3iahe4ATrvXXewbSLjVq
	m8F/wAHX2j0AVC/9tw34ZQTJtpQz7hzgOYh9z9SE+ixNrbkcG2UzRNJ+OkHzvN1DVAD6OXHwqu4
	iojlYqjBkFvV3s3gsQjoOOFfhGBnbbxFslpmB07TqOoyOf0+SA1Ywh5kMiLwpibb9hh4Y5QCLlB
	DK2bMMYqSZJsidSvhRaCR8A/nR99EnOKeo5Kt0pNbk+OGIvxSAhYQYxNJVRLyf6PckAvO19TD3p
	I+dmQmYN9V77CfhD151r9MlGJz57HcOx40BlRkCf1SYj3B2rqlJELF5sMFkbloGdhQiYzKhcMFk
	gMlY5RrXs/ehQKBXxGhGkELMUbTr+3eUPuGfHhoSlIdCxxiBZJy/JmssYVEYbT4knRu6wzi9x7A
	==
X-Received: by 2002:a17:902:db0f:b0:2e9:87a1:98b5 with SMTP id d9443c01a7336-2eb3649b22amr89248675ad.14.1793601761891;
        Sun, 01 Nov 2026 22:42:41 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392b15f0sm23755825ad.73.2026.11.01.22.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 22:42:41 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 1/2] bpf: Don't move a MAP_FIXED address in arena_get_unmapped_area()
Date: Mon,  2 Nov 2026 06:42:30 +0000
Message-ID: <20261102064231.2153879-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102064231.2153879-1-alexei.starovoitov@gmail.com>
References: <20261102064231.2153879-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The user range of an arena must not cross a 4 GiB boundary. Thus
arena_get_unmapped_area() asks the mm for 2 * len bytes and rounds the
result up if necessary. This is correct only if the mm finds a free range.
With MAP_FIXED the mm does no search and returns addr. For
MAP_FIXED_NOREPLACE, do_mmap() also sets MAP_FIXED.

With MAP_FIXED the arena is not at addr after round_up(). Thus mmap()
removes mappings outside the range from addr to addr + len. It keeps a part
of those in this range. Also, round_up() can wrap to address 0, and the
test for address 0 is before it.

The arch code gets twice the length of the mapping. Thus it can refuse a
valid MAP_FIXED range. On s390 the arch code also grows the page table for
the range. With the double length it can omit this step for a valid range.

The test for a crossing is not exact. Because ret is a long, ret >> 32
extends the sign, but the other side is unsigned. The sides are never equal
for an address with bit 63 set, and round_up() always runs. Such user
addresses exist on s390. arena_map_alloc() does the same test with a u64.

With MAP_FIXED, pass len to the mm. Return -EINVAL if the range crosses a
boundary, as for address 0. Make ret unsigned, so that only these ranges
get the error. On x86-64, if round_up() gives address 0 today, mmap() now
fails with -EINVAL or with -ENOMEM from the mm. Today mmap() can also fail
for the address after round_up(), for example with -ENOMEM, -EEXIST, -EPERM
or -EBUSY.

Without MAP_FIXED the mm must still find a free range of 2 * len bytes
inside the address space of the task. The range after round_up() is inside
it, and round_up() cannot wrap. An address with bit 63 set now moves only
if its range crosses a boundary.

For an arena, libbpf uses MAP_FIXED only with map_extra, and
arena_map_alloc() refuses a map_extra range that crosses a boundary. A
subsequent mmap() must use the range of the first mmap(). For mmap() of the
map fd, this range comes from arena_get_unmapped_area(), thus it crosses no
boundary. arena_map_alloc() still accepts a map_extra above TASK_SIZE, and
mmap() of such an arena fails.

Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/arena.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 0b1ec3306ea4..ec2bda1a6ebf 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -7,6 +7,7 @@
 #include <linux/irq_work.h>
 #include "linux/filter.h"
 #include <linux/llist.h>
+#include <linux/mman.h>
 #include <linux/btf_ids.h>
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
@@ -630,7 +631,7 @@ static unsigned long arena_get_unmapped_area(struct file *filp, unsigned long ad
 {
 	struct bpf_map *map = filp->private_data;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
-	long ret;
+	unsigned long ret;
 
 	if (pgoff)
 		return -EINVAL;
@@ -647,7 +648,13 @@ static unsigned long arena_get_unmapped_area(struct file *filp, unsigned long ad
 			return -EINVAL;
 	}
 
-	ret = mm_get_unmapped_area(filp, addr, len * 2, 0, flags);
+	/*
+	 * Without MAP_FIXED the mm finds a free range. Ask for twice the
+	 * length, so that there is room for round_up(). With MAP_FIXED the mm
+	 * does no search, and the caller wants this address. Thus the range
+	 * cannot move.
+	 */
+	ret = mm_get_unmapped_area(filp, addr, flags & MAP_FIXED ? len : len * 2, 0, flags);
 	if (IS_ERR_VALUE(ret))
 		return ret;
 	if (!ret)
@@ -655,6 +662,8 @@ static unsigned long arena_get_unmapped_area(struct file *filp, unsigned long ad
 		return -EINVAL;
 	if ((ret >> 32) == ((ret + len - 1) >> 32))
 		return ret;
+	if (flags & MAP_FIXED)
+		return -EINVAL;
 	return round_up(ret, SZ_4G);
 }
 
-- 
2.55.0

