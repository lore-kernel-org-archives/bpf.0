Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577617;
	b=Niq10fFCRlvihgJIUxY1pTmYv1wrp5rb7BW/+uw7MXc0GqYyZg5srJsfqa9hLxupefR+
	 4PrM1jCA8U+paC4/lNxNGvVH5mNrhZS7imHr5xjeVwj7iCaM9Mbq9brJ3cejEX/m5VgjF
	 u7r4q0tTTC7HWlTxa+w+kXbZlTAciD19qqRSUs84F2xCMCwXlZ7bpAqgDuJwZiMn3UDOH
	 thFg43UuKeRopNxhgUTehQ/Y+1sjSYnncyzaBQB4v0r5SnhL1AEe3iSuDjIHVsV3hYvul
	 EZAb/a+4QaJGOiJt96JopHRijMUk6twdz4vb2XpBV9KDO5RbtMU9PZHbGYNIZ/2IaiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DBjF90kJNnpORhJq8HbCjiQja6mtLYPpVYNkM8kR4Nc=;
	b=KQAji8LKcUUBIa5q9fxT0TX84H9nvtvbjkU7pZfFuTYocKQtnWH0Iam0HYCMeO408eJb
	 k31U6oE7dqFhn74vbyusTXv/nFO16Ksg6HAZPS21Dw+AVgOpshQ1B6qHMGWlb1ZX4cotk
	 7grgaDk/ib4G7Rc0/QSLlvoJ02yhrbZHUQYfQGxGQtwjhdd1f93AKOGS6AwrkLtmA5LSO
	 GAodvyQnHhHar8achKvGzTNLkxPY0xyqB+wdRJfSocBlzmW6iTCHiPa74MAfSDZP3H+j2
	 qm910zbhpqzyIl5lBgdHj2+jQlvff4ciAp4GQOpRrFxS3ZkdT+tUJHcJ7xIJCqdma2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w4jMLknP;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1D5606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F1D5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w4jMLknP
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2f020d0169eso25471885ad.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577617; x=1796182417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DBjF90kJNnpORhJq8HbCjiQja6mtLYPpVYNkM8kR4Nc=;
        b=w4jMLknPiFr3AH/l+E6Tvc5HrmN4D7EvQyXR3OikZrxjSyaTMykUFlO9G3txdcVpvT
         7hP3jDplAmf9IpMgg6aI8EuqcXy24G9NSwSBLxvozB1xiRP/JZn2LelJfkAkciXTVmTN
         saipfgBHhVweJ8bHkQTJkAgTdi6xxf186sth72fQNVKyc42b534xhzI6BSQA4cplH4iK
         fXQOv+wFszODtOZGLYvtD65hZ0RDUH0sj7hChYpJiEps5cffLwj3fUvY1SIRyKjZgbXj
         6V2edyUSY43m51Y0n4ZIWmJDhCVuoSBti+keuW6c8lqksmDHifJGMvNWACNevcUtai5X
         3rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577617; x=1796182417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DBjF90kJNnpORhJq8HbCjiQja6mtLYPpVYNkM8kR4Nc=;
        b=tHKdDZz+cXjMeKYz3brggN/1LRJOcMTk1grL/+0k/7u/mcpoM27S4rlfSNJA2T9dIw
         KDfOLbRcyxJ4ngFYCLN7bHD7Y65+IZ1aYhwJ+uRGqOB06ixFON60dNeptL+UBwM7rOwn
         6Qi05ehR1ezcpyJ1i/8qFtTJSiJsbfnDmvCH6vjckWxkV0CKGPWrEER9MVopoAnzEj+r
         x0Sr8RQFOQM/HwRKAghqkLLilmeEK5qkG7Rsg64XuvoOB3JP3ouj7OejR3IstFyYeClN
         zazZtMvHAVAxMkU/6kmjddTaBeJloHl+EUagZ8RSmqnJrSURL3dPexG4y/dW/X3IVjqS
         m14g==
X-Gm-Message-State: APuU4Z9um3/tH0e8aMYZmfH3gm3xgeT339swJyjvWvzLX1//Q39T9/uK
	vcxBUJEtuMla42idm4oKFemrR3n1AmvOuzCJ/Ph0s5bVktsi1afNbUnmwhgh10hc
X-Gm-Gg: AZFdTZcnOFMXTaOTxy7mNIsjQ51NKvLTIO0tzUUIYCar8leWQlMsVMYRxmlrUwei9ny
	Ov81clfZPKutK5T0LLn+eWDZkGx4LFjHPnxG9MXeuLQYcQ0LP+gA5XJObjwucOVCuvJZyZkYl2C
	d0DZuA0HBVULYEE1fniR78fsTY4LhQeTAv8LlfcfojK/1RW5YnBz40ZVJQ9/4ZzOslJN/IriLYa
	/rsoWRiPOuL+4bdHYtsP0Hqz7oSqA6tqdSWZnnX0KI1mtwE1sNfhvO1tVQCKUuAem15+d5st00T
	waDU9eJjscU/lAF5hsfRhVWv6EWKj5V73i/m0SjQwFgE4kwcdYswGUEusq5SN88DEl0S+IQIyMX
	NB+xxyC2pNrywCXp+jyofXjDeGSzKIO8td1KHEmRqey635IdSYiBQ8w/K3+hceQVyY0EPKiIACP
	gIYoJZkEE3U/Kij2OISXBbMWOeYdDZyLBMAd9HIHNSequJovgPveuk7HFoyEB6kY0suPoaDatwc
	8hGQxlBs3dwBlG9HEyx3Lzbgb9XvjMicm9fYEd2ZY8vX4Uw5HgiR0nerOfgsz7E2xQrTy+kpOEt
	hxFbfEC5dif8rI+fjChNkmNO5eloOmtsthyzMYl9TJOkXDApxmZ/veZJHsXEXlszIvToO1ocxvi
	ZvxB9HbwxlgkC0oRKvBx6w/Lfnu1IDHGh94q/rwXhLPG+RtcQP9cTnjHQo+EBRB+Z2u2lbv8eAA
	==
X-Received: by 2002:a17:903:1ac8:b0:2f0:a586:81d9 with SMTP id d9443c01a7336-2f0a58682a8mr75426795ad.50.1795577616460;
        Tue, 24 Nov 2026 19:33:36 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f07d6d4bddsm49032745ad.62.2026.11.24.19.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:33:36 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 40/47] bpf: Fix slices behind the end of an XDP packet
Date: Wed, 25 Nov 2026 03:29:31 +0000
Message-ID: <20261125032938.670542-41-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

A dynptr keeps the size that the packet had at bpf_dynptr_from_xdp().
When the packet has shrunk since, bpf_dynptr_slice() takes the error of
bpf_xdp_pointer() for "not linear" and copies from the frags. A linear
packet has none, its skb_shared_info is what the buffer held before.

Return NULL. Don't look at the frags of a linear packet for a length of
0 at its end either.

Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/helpers.c | 4 +++-
 net/core/filter.c    | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a0fd6bdb3278..1b95fe795b4d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/uidgid.h>
 #include <linux/filter.h>
+#include <net/xdp.h>
 #include <linux/ctype.h>
 #include <linux/jiffies.h>
 #include <linux/pid_namespace.h>
@@ -3144,7 +3145,8 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u64 offset,
 		if (!IS_ERR_OR_NULL(xdp_ptr))
 			return xdp_ptr;
 
-		if (!buffer__nullable)
+		/* the packet may be shorter than it was for bpf_dynptr_from_xdp() */
+		if (!buffer__nullable || ptr->offset + offset + len > xdp_get_buff_len(ptr->data))
 			return NULL;
 		bpf_xdp_copy_buf(ptr->data, ptr->offset + offset, buffer__nullable, len, false);
 		return buffer__nullable;
diff --git a/net/core/filter.c b/net/core/filter.c
index 2415cd90ab5d..97f5d60ec817 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4326,7 +4326,7 @@ void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len)
 	if (unlikely(offset + len > xdp_get_buff_len(xdp)))
 		return ERR_PTR(-EINVAL);
 
-	if (likely(offset < size)) /* linear area */
+	if (likely(offset < size || !xdp_buff_has_frags(xdp))) /* linear area */
 		goto out;
 
 	sinfo = xdp_get_shared_info_from_buff(xdp);
-- 
2.55.0

