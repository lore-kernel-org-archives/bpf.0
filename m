Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120E0472F65
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792020892; cv=none; b=RWFK/24uEYypQr0bYkYDlUPwdcSPPzIr7266i8yiCCTsyA8dDJl7zWVnzOdUy3zrqGrvOF+CNSL7+2zRSYdDE247ywUeIbLDN21GvC8WRrbcVqUiW4xBZBSpfzpnBjTSE07U60G9jMhB5cIYURBvVBwU/GZIHFDMIwn3mWDBHXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792020892; c=relaxed/simple;
	bh=PYJamuxtn2xVYmttCy33B69H0RS6KsyrSsM+H4dohbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kt7SAZFE2vnMxn2oyCBrD3DHrc1t7MI+vXZCB2THOkGI3xHInmgt5Nr+bkaD4w2wlgZSCIKP4erzx3Qfg/WYZZJABd4flE6oeSj3beLT4pNNp5lcYkx/u8NanibxZ8yQQ5Y//mXCAv9fK07/9SXtPUU++LaG63/mO/dGgzy0WPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=0de+KrJy; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="0de+KrJy"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ab868eb9cfso428131a91.0
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 16:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792020890; x=1792625690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U9AoC7VH4XdY5Fm26EtjzmVUERcO9RURIpDI2FJWiAs=;
        b=0de+KrJysFoGJ5a4BLlIo9WHc1nz56M+sl0RhXwEbKkAZUpjC3oEqjS73PYoHnOfAE
         FNPxjTv3NvNvofx3AjPJSOj3caU8msVvYUhNEZR6Ra+WMrHlymWBDgza+EU/P+VEqhwp
         on9jNShfQyfY/Ofy3WSK9q94e1+Si0evMrJ1J8EWsi+Xu7PX7Ol4kbDToeRj6Sar/1x+
         tUWjCzNzxfiuljdu/AsSebHinAuOTB0d/4Nes7NhLuT51rAKepaGu8AHroRqUtrUTnjL
         y7CLXuZ4XvMKZLsbRUxxJbbLCUqLAA5hWopyDg/oGTdmmd5iEtfgj1YUtcjD2mjR5ZkV
         X/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792020890; x=1792625690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U9AoC7VH4XdY5Fm26EtjzmVUERcO9RURIpDI2FJWiAs=;
        b=cK0tMPJnSa1QKILuF9/BKL3VKp2yWq4CSk7qk9mYismdm+erqA6xESnCZW6K6S8WNa
         4Gvvgp0vRfwM2RiIHq00vMF7ERNAo2U/pNh76oHhK0vLwd9Pzsmm5F8fdyPGqJQRfauR
         VRDHOb5cg8j53z2Yg9pWCGLk8PdJCiMzHoi1RmqtEwULomJknUiDviYSzlo0u5jsS6AB
         oDJp54R8T148jpu3bjYp6KYzAeWxcT3l8e24BwXGiwSPmNIgLg+FjcHQDJuz5NfPuPwn
         O2RVjZkGZN/QD6OnB7fT2swolctAjS7S52XPsPqT1Vd80LVmlBFu1kJGqSl1aMBZ0GGA
         ZZOA==
X-Gm-Message-State: AFq9FYJm4KAsiRHICAqy9NxyDEQclfhDg0AdDdvnV0whX4Z8I5JiqTbE
	ZIiqKNS32E1dyGEGwQCWEF7Mx6Lkx1OhdwleyeGs8NAUWAFoLSd6Uy4+Ueoqf3RjctLfK7ImN2e
	FJGNYWNY=
X-Gm-Gg: AYBFou0usR3pibznCHNYiJ6RRkTgyWS0Edlv7gRs1M0puUFJKh05ZuMWJMYnr3iJcY1
	6Z8iHJxq4kV2ZM9RY2fdL/b+fbwtzrr+vV0WIMXnaOZVejE40OykDhk7AALJYRxvcV/jgRZ+wT7
	GU9qotppA2grTeNfK7n2Y3ZncKfRCOaz1thqlkQJdAop8eNDLPKaGIL3mUuUyD3CBb18dMK4x/Q
	6rB9u5K8yhI+JRdAWP3YHXnB4PPmIeL1WUf9iGfQPxLlCFXMDLQPoggbjl/V2lidpsfKNDQXHFI
	21ndudJQDoyuZXeqGTCxWbcHrv/uoQsAk74Ks+bn5Feqylbh+QXfJZ2oqvOvYHuijDXqmQLf6fp
	hdoEy9X3TtsoWFD/YQySycJagSaKORr67mX/W4dG1oYZpJ+IgOvagVAmyMP3EZpe8nQHovPoetN
	AyKVifQurDrh5YHzlNpdVoYURfydBRf6/FMpd/H+VuqBrdj3tGPsTy8c2At8IwqygrYvJRCQU34
	iG+xXDaMEouu01NSldck4Fz01kxdHj7W2auaMffYcV1BrM=
X-Received: by 2002:a17:90b:3c8e:b0:3a0:abc3:afb5 with SMTP id 98e67ed59e1d1-3ab3a7a2437mr14609635a91.34.1792020890282;
        Wed, 14 Oct 2026 16:34:50 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e7a98sm1385177a91.6.2026.10.14.16.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 16:34:49 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 4/8] bpf: Update is_range_tree_set to work for consecutive ranges
Date: Wed, 14 Oct 2026 23:34:38 +0000
Message-ID: <20261014233442.8392-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261014233442.8392-1-emil@etsalapatis.com>
References: <20261014233442.8392-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arena range tree currently does not handle consecutive
ranges present in the tree. This is by design: Consecutive
ranges get merged into one by default. However, this design
only lets us track a single bit's worth of state for each
address range, encoded by whether the range is present in
the tree or not (i.e., is it allocated).

We require more fine-grained state tracking for each range.
This means possibly having in the tree consecutive ranges
that cannot be merged because they have different states.
However, existing code implicitly assumes that this scenario
is not possible in its logic.

Expand the logic of is_range_tree_set to handle consecutive
ranges in the tree. The logic change does not affect existing
users and amounts to a defensive check until we enable unmergeable
consecutive ranges in subsequent patches.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/range_tree.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
index 2460e78d6a55..46e2dd01a353 100644
--- a/kernel/bpf/range_tree.c
+++ b/kernel/bpf/range_tree.c
@@ -186,12 +186,22 @@ int range_tree_clear(struct range_tree *rt, u32 start, u32 len)
 int is_range_tree_set(struct range_tree *rt, u32 start, u32 len)
 {
 	u32 last = start + len - 1;
-	struct range_node *left;
+	struct range_node *rn;
 
-	/* Is this whole range set ? */
-	left = range_it_iter_first(rt, start, last);
-	if (left && left->rn_start <= start && left->rn_last >= last)
-		return 0;
+	for ((rn = range_it_iter_first(rt, start, last)); rn != NULL;
+		rn = __range_it_iter_next(rn, start, last)) {
+		/* Make sure the range covers the start */
+		if (rn->rn_start > start)
+			return -ESRCH;
+
+		/* If it covers the entire range we're done. */
+		if (rn->rn_last >= last)
+			return 0;
+
+		start = rn->rn_last + 1;
+	}
+
+	/* No range to cover [start, last] */
 	return -ESRCH;
 }
 
-- 
2.52.0

