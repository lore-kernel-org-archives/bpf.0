Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC60C2D73A6
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255161; cv=none; b=SMbORxumv1m9jraQz01/xysz8gR1sNtapsdg5PSonROVbw7kRqaQKQtvjUpFlGM1Rm8nUpRL3TpLbhDsf4V/Ggz2j9QB+jW2JwsBkWDRWFMm0eLZPxLqEAqIyaLw0r6RjpV+c8n/llhIL7JczTR4zaNTgWlbuQgSKcpNy/T/OsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255161; c=relaxed/simple;
	bh=zgAncej2VMKtRTstMEpHtZxGPB+wKyq/+2Fwhv76YLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpZWyHQlvOfkIr28Etskr3+a1q42knSyTNP6P5M+YlYpdh9Ho3yIvOvVNTPrZakNz98554Z6cciczHtmzxGhGpou/dzl7NpVqfhu8kufNWu9nXr/7r0f3w9hIljCWuvSzNkTBlr4k2aE/usAZcmly1HfCOltOBLO81ny7Okt2v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccQ8Xth2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccQ8Xth2"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e5fb79ce82so4041985ad.0
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255160; x=1792859960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2c71ftOjOMZN/elNUQWQLQS3OBsPaj6ABPEs543IIw4=;
        b=ccQ8Xth2tvbO6FAGHCSQJO/wPKr/t4JyzUeKx6RXeZn8u4KCGKRGgqkmB/2R5WTSBf
         hOFp9vEyQhctswgIGzPVzNklaWd+04ACGCK+W5tFQ9nwYNKpH+fOFsXfz69EGQqgQrbZ
         12nioGVcD00iZvzu4jZO1tzK/Xp//ia2SeYNcds6M+BMqbwZI7XcsIPaLK+uI4M64M3p
         bHWccqWZ8kHxf4UqlzYlZ6Zd3vNw4sUxS43+nSDeLDux+yuqgoiGBg58NIWGFfRL0n0b
         K4cvTyQR3zHafOJfgj2KGQTMXGyot823mt1tZgEiYv/MUNxGwVS10phXKRIStWqFB2d6
         tYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255160; x=1792859960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2c71ftOjOMZN/elNUQWQLQS3OBsPaj6ABPEs543IIw4=;
        b=ESuXlPu+mEOXVmQ5yUyWgb3ye48j+9IVPI7vLRO29iVMdsAKzWFfHqvMz1so08kBLS
         QFeC6FRSfdAg6OkfgQY1JjVLU6EUBYOu08xrGPpMjw+y5xbEzHQfvHxRZbVMSkhXmSux
         QyZNKhOnbM0bvDVbV6HpV7MInHQVPesc4Nz0N4lnelC41A+qlIoJXcRiYma2pcgzXxTr
         jOMCsFfygKrgD+TtBYUVUKmbb4hO118QP9w60Prxzz4+6MoWHuhP8NxC2vht+5BtUPD6
         WsZyfH6rgoLW1wFXNtFzDiEDp5kk1cOsDg5D7xfY9QhjHpNIIJ0mxPIVSSGKAaA02OqU
         x+bA==
X-Gm-Message-State: AFq9FYJVQev8ob6yJ7uqe7thIPTtdrU/rSjkbRPHeDXG9MQoo6TlhKkx
	4MdR0RjWhQHCzmRoqREkISyl4usCtWWHK/Glnh8fxkUVnJXsWJ3Cu3i2zqb7MA==
X-Gm-Gg: AYBFou3F4LRP6TXjdHTsADBdYTjI88y+7yj+LUgb3wjE/kDxCbh0wT0Ch1U94m+bQzU
	SjKn8CZr5X3H+G01/aOfr+AF1sImNz9pjnLDzvHpefDrhApWRDOHsbED3mXM+UsYS942R3uS+K+
	OBvwrKwp42SM+MdALBmo816pel0qjb/uYAcIL1yGkSC7d/RbWtw+QMIHflm6YJH9/XhtU0kAILG
	ZcmepMPnQY3sJBYhD+fYGQpfF+HuJiOB7RbKtiniLiRBY9sukiGs9zcTT6BF1cgwi2SoRf4K9rp
	dGhQ3V3I+ONkA58s9EmvnzVj2o++/g7NhWeJo+YDipUk4P+X/diAspxkqIVdOqqDQ07A0P61AHJ
	OBk6e9W8AFmn0+EgTbv7qtjH3UitE8oWDAR3mEAs0U8lrwyaeNYROOvBxTfkMrgKoNSQeM90oRC
	v3/XfWFk9jsluUlPiEB7LafdUiYwOZ2N6cVD1jZXpFOZbwf1ySllD3mJQBh8Dgz/5n3PA7Oe5pG
	E2CTdF9uDOUdghNtWPdMh/Qxm9sKJ6iF1Pfi8IFBI/e9JNaRx1fsVFqpYlWmr+OMLYpR7AgTD5b
	H21fJGJrEhZe+yOUyPYJ/xTTSwa4Pi0GQ8gUdc7VIZM=
X-Received: by 2002:a17:903:2a86:b0:2e9:69ef:ff38 with SMTP id d9443c01a7336-2e9a6d1d163mr28164385ad.55.1792255159958;
        Sat, 17 Oct 2026 09:39:19 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e5c311bsm22577835ad.10.2026.10.17.09.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:39:19 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 15/43] bpf: Fix NULL deref in the sk_storage map iterator
Date: Sat, 17 Oct 2026 16:37:17 +0000
Message-ID: <20261017163745.3341787-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

bpf_sk_storage_map_seq_find_next() hands out an element only if its
local_storage pointer is set. __bpf_sk_storage_map_seq_show() then reads
the pointer a second time and dereferences it without a test.

Since bpf_local_storage_destroy() unlinks the elements with
bpf_selem_unlink_nofail(), the pointer is reset to NULL when the socket
which owns the element is destroyed, so it can change between the two
reads. Reading the iterator while sockets with an element in the map are
closed ends in a NULL pointer dereference. The sockets need not belong to
the reader: where a program gives every new socket an element, an
unprivileged user who opens and closes sockets is enough.

Skip such an element, as the TCP and UDP iterators skip a socket which
has been unhashed.

Fixes: 0be08389c7f2 ("bpf: Switch to bpf_selem_unlink_nofail in bpf_local_storage_{map_free, destroy}")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/bpf_sk_storage.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index b5349bec5695..aea67b446c7c 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -813,6 +813,9 @@ static int __bpf_sk_storage_map_seq_show(struct seq_file *seq,
 		ctx.map = info->map;
 		if (selem) {
 			sk_storage = rcu_dereference(selem->local_storage);
+			/* reset since ->next() looked: the socket goes away */
+			if (!sk_storage)
+				return SEQ_SKIP;
 			ctx.sk = sk_storage->owner;
 			ctx.value = SDATA(selem)->data;
 		}
-- 
2.55.0

