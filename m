Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18613BB690
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255326; cv=none; b=pv+aIXtBPYGfOuv2l8dlT1DQfxCP6XFzTzYTu7bcENU1qCl7nkT0fEvGjxsgBwJHAJKdO38YSzCvtt0/QF98JugXvjO96mI6LqNkjop5sI9tDWb9ZncihdwoFeT4TvZVQZBObsJdniRG1Msa5uU50ZMIBTj6Jm39IhpTctvpOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255326; c=relaxed/simple;
	bh=uJWFQogm/k+VnArKWm1Oiq+0VdAnIUrLmIl1JTgGPIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4sncLrro85guhHDqxhoo6UaUh1kYAyIzr5DaSgxcxDvGjhwBleqIp7j+MmpJTYhaZCt7T+q39voHnsEo99SM7YSBDH0GSfQqCv9592+/0OoVP54ywd3tZ5Gp4iCv2aZkbNWSOS8qxnFAssTXQspNWh6UvgvNzhxUR4o1z+8xJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uj0KhZeY; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj0KhZeY"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so584606a91.2
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255325; x=1792860125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=erSNGXOexzpuTgq9LWuAw7nFMGwzuwSRg4vna02B63c=;
        b=Uj0KhZeYxdi7ouc+gIBvZfFBVh/s/APmc9fMv3ZwuAENYMezab47bnkkcn2etQSzuZ
         78fp9OmkB8GGq/do2YmK9Yx1sTASfMrpfDbEZziPKqpP8TvaIib5KnT8J+K6DO6KKEQ4
         Qk0Yn5YAoCFyHYX9nMVMZ57/0d8tYR5qgNFTz4oU6eYTj2wL2N6wCW1G3S7ADKqxcRbV
         VhM6dSBLy0rNDjN7GyEWGZpHeYTd/5MgRn45uBJHTYaq/xPqOeY7J4O9/qe4+Q6xa+48
         Tf/FZ7bCEPmzPm7PVf4pELoaOLoh3vZdv5jM1WtReB18YIcqo2IXqiXVI71ceQwPHCNA
         /DCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255325; x=1792860125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=erSNGXOexzpuTgq9LWuAw7nFMGwzuwSRg4vna02B63c=;
        b=2T6IzqFeUu++00gGzZ2CUSBe2jDLILeqTOgr8G/KJsSFKfG8k+EKzgnt9WIyenzuRF
         DPxvAq+Dqe9g9bkICqs9+XQZzYV8Ga+K1t37qK1XA2D1CfH97kt+YHBH+W8f7Jk7fzGy
         3+m4guEiWn2Ilu31GcaheSWDdwo68MYkJPkxysVlKgzBH8yLrRA0cJePzVnIQEhWoqnr
         AT7ExjhxWnVH1rDO+MZn1FI33eU17UYY7DvLVSuc/br7dQcBTslZ61nSQv0t+PxyYpBb
         t/B1iM67th0iWZmsveLEi1oxdNOiIAuPCWOQ1+if2+BZQeA124jySorJU2xZb9IrngcW
         E2VA==
X-Gm-Message-State: AFq9FYJHFjdKUhSc/BVflvAtnb0Hj3goZ2o+F6MP4Acj3vyeVu456J3T
	yNzJvu5HFLsDrbvr84stEz9Jb5Z3y0SA+knYXKBmrdr6nWaZKv225e+TUcsmAQ==
X-Gm-Gg: AYBFou39xA4UeMIot6ePGqYjDVEb/+8lU/vcTOaLxYToJIENez05w0UDRSh9gU8FpX8
	i3vibGB4K3pjojzRZIJVgGi2sChrNfC0PLiXqQE9jId25Xaq9rjRiwzJYnkGlJb7gXm7jgxZzli
	GaL7ms5ANL1kU3hKccYHWHh7FMvCsawzSyiwYLvFtDPatdQ1WNUTGZgKsO1C8sqz/jC/g6fWEbx
	wA+JsrA73ZkCRd9wuBZlVLkOKqlS0Ra8Aw24Dw7DMTCVUn68qNoGTU6VnMCa0dTM7q6YD0vQuYY
	Gd8vcNWc44IfRAMQbPQfQXm7xkmtUbS+bH6gLxpY8Gy2ZYbYgVj1p6BZo0Xa2kPU9OOOV9nw0sa
	MZjZCMacg/tSS6I65VecKpnxWeFiczJLk2+FuduHjsmRTAQXwTLpKtWlqWz7rnPPrbnhJp8Ta/I
	YwtRBc6SHnbqIBKhnUt5/YE6sf4yS94Y/Dcc9IxSgH9hgrel5c5CD8Z0ssGFBV93HljPaSMt0fI
	WyxvJUIYQPJX/+cR+1JuAXWvxIHowVTwY+ug5wpUmAhMUoJKa1G+IaJAyl5ESAJje6L22emmc/x
	EWPlRElKRy+FN4dt/kYFfWo/eU64pkHkpJAr9bbzJGA=
X-Received: by 2002:a17:90b:50c4:b0:3ac:9ed8:f310 with SMTP id 98e67ed59e1d1-3acef5960fbmr3173920a91.49.1792255324812;
        Sat, 17 Oct 2026 09:42:04 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947d2706sm13829980a91.16.2026.10.17.09.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:42:04 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 42/43] bpf: Use memmove() to store bytes in an skb
Date: Sat, 17 Oct 2026 16:37:44 +0000
Message-ID: <20261017163745.3341787-43-alexei.starovoitov@gmail.com>
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

Through bpf_dynptr_write() and bpf_dynptr_copy() the source of
bpf_skb_store_bytes() can be a slice of the same skb which overlaps the
destination. memcpy() then reads bytes which it has overwritten already. On
x86 with FSRM it repeats the first bytes of the source instead of copying
it. The other kinds of dynptr are written with memmove() for that reason.

Fixes: 2012c867c800 ("bpf: verifier: Accept dynptr mem as mem in helpers")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 12a5e530a81b..a9b641730f13 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1749,7 +1749,8 @@ BPF_CALL_5(bpf_skb_store_bytes, struct sk_buff *, skb, u32, offset,
 	if (flags & BPF_F_RECOMPUTE_CSUM)
 		__skb_postpull_rcsum(skb, ptr, len, offset);
 
-	memcpy(ptr, from, len);
+	/* through a dynptr the source may be an overlapping slice of the skb */
+	memmove(ptr, from, len);
 
 	if (flags & BPF_F_RECOMPUTE_CSUM)
 		__skb_postpush_rcsum(skb, ptr, len, offset);
-- 
2.55.0

