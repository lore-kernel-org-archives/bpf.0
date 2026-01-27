Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E848C36EA8D
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542313; cv=none; b=XXgxD+c2tLer+JQPDptsPeJ+mAIwtNhSzCd1WVoRSpk6mJjZsI77uN43tk3+EULIJCL4Bk8zeTI8W7/n2eh1elFFHjkfwEpLjOwTeD+TgxwLc4EjaC67nybSi+6U+PHz786xdnRYgN+R10HfmD8tpUjZMl6/d0AB+wVYv3h4M0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542313; c=relaxed/simple;
	bh=Pvbn/H0HxPwAY0iOQShPTzQtYBQ2qs48aYfZQ1yavP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S5W+ODqTgAHBKfNqOejv1sTccTodWRvIE+Ik/nuOX+Z9N9Y17BOC9kqwviJyahniBdhFfaC6i+VKD3BBlS27wXe70HlGPbFLnXPgocQzJTAsutCWqR5/fny+t0WDslNg6eAhdgDr6FCWvy4ON8obAvqcR+bjkat3mQefSQVCKU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwfyNuMi; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwfyNuMi"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso2009405e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 11:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769542310; x=1770147110; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z10T6eY82oVWIG37satjQYoRKVTHV8sftRqPgVXJSSQ=;
        b=MwfyNuMil3gXRUemOVgX4IMR9wvkA5IvkGSxCxc1nGoMIucNpSCikmJ/GUYYgZfs2/
         lWBfCAzg//a4Rfon7JPkZFANBGCrJDW/ORTtgi/9Nn6SmPj6tZGzA5E3c2IX1UE8f/dJ
         3pw9S24pkzdic6hgREBeR330LTM/4zVfcmmPKazDhbIWcTdSpS+oqhoK8FqZDWq2/xI0
         qJdgjlOQvzDevOrXzdOtiOSIVUy2qEu8mNYCOApTfIJjYEXornvFxxWuQcmUoHc5asgL
         tUKSoJRZLFCzxuSbaFizV4V9bUMAFCX/o3uFh++PlTrk+0L/pM9DKS9tN+gLTphd/+ur
         lITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769542310; x=1770147110;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z10T6eY82oVWIG37satjQYoRKVTHV8sftRqPgVXJSSQ=;
        b=u09iyRkNbm2h3sJv2CtPKRZg8GLEiDtZqV2w8F6+HPupI19s2+QY4ySeqiqxGvJ/Kl
         PzFxXrBHWda/qgJKIypvo5XkHoKDgf9mF3nJ4HmEr3kaQPENYBsEMrsk0x/wPQx3n0Gh
         pxEUBkO3USgYvfDZFWuRhNnepZ4VCHlxPCHB1P2+J+ZwZbprkiVzQXFJmKRlrsEJtofZ
         /MpgFzAWdjj1ytiRnR9LDxo4RHFyivgmpmznY1RwXNahi/zmXhQ/uMIwwX6gtiwvQbZh
         aMtI20Ar767+hwHuBCyFlebZb0LOqe+XQWqXV0diF0fBkQWU/QvcMGHtI8K0wsNU5gMa
         87DQ==
X-Gm-Message-State: AOJu0YxXCRAtJ0BBzw/Ue52JRpgyWnLHKyKdlSrad48BKVfPa2HfDhdG
	gfTHwPrk/9/9lo1Yhqo/xifIUAZeht98JSKGy5gpOPFv+6DsSq50EHF2o0aPFi/f
X-Gm-Gg: AZuq6aIeCQri0zcjMVTPjFRF3RZ8fb64XyPK8I6DE04c6sGb2D+/Td7ZjvcOnJkXsxA
	YhgmM/r1hrSsZ36bdqTjALfiyx+/euJfN7peRPfeiXc7woCYx7E2IxYh9MjRlGP2bBDR77pTYyY
	Wcmua3yA6lvB8LF/MpK22kS5L2U0p1lLomZHr8CtoJi1SkMrCxDLOYxHBbs5fKCWdMH8/qh0ypx
	JMBglnigiMwxa8GFFOCcYDnRPj3fbDSgwRITnTrjQaUl6fxGTYK/FCRvRZRHuhHjIuwG+tgie0q
	gjer9MFoMve39WQ7+XVY7Ez+MmP+ue8zr30TjhQY+HOoljFOHlGrckUlbUeWQQGewWcnCc31WCg
	1H/FG2CeAakm82WN4CxjlkhXas1tkg7Ku4NhOg2cDUczq+FIuatyulM2dublqXIioIyolfNIOyw
	bwVAg0A6J1oLk+6JtZN4LBaxPD81XIYA==
X-Received: by 2002:a05:600c:a40e:b0:480:6ab1:ed0d with SMTP id 5b1f17b1804b1-4806ab1f166mr29197415e9.9.1769542310270;
        Tue, 27 Jan 2026 11:31:50 -0800 (PST)
Received: from localhost (i68975BB5.versanet.de. [104.151.91.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131cefdsm877763f8f.23.2026.01.27.11.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 11:31:49 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 27 Jan 2026 19:31:20 +0000
Subject: [PATCH bpf-next v8 3/8] bpf: Introduce bpf_timer_cancel_async()
 kfunc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-timer_nolock-v8-3-5a29a9571059@meta.com>
References: <20260127-timer_nolock-v8-0-5a29a9571059@meta.com>
In-Reply-To: <20260127-timer_nolock-v8-0-5a29a9571059@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769542292; l=1373;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=JnY3nZz/dbXWm5B5JIY0XpcpexHWJzOenJRzmtS/GF8=;
 b=bYC+dKYbgkgtyz9ASYtnVHRw9QZYOQul+rfZmicbC3hSN91DBo9bewmpgZj7m16mdBqldm1Yj
 5p21XE04l1rAcORyKdsz+WL9ISBf6/d1xESIQj2dglVP+yhnPWp2IQf
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

introducing bpf timer cancel kfunc that attempts canceling timer
asynchronously, hence, supports working in NMI context.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 0fddc11185b7990454585c753e78047fc7208c64..bebaca78b096f21a80e2dbf5e9535e8e7e2651d7 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4437,6 +4437,18 @@ __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
 	return 0;
 }
 
+__bpf_kfunc int bpf_timer_cancel_async(struct bpf_timer *timer)
+{
+	struct bpf_async_cb *cb;
+	struct bpf_async_kern *async = (void *)timer;
+
+	cb = READ_ONCE(async->cb);
+	if (!cb)
+		return -EINVAL;
+
+	return bpf_async_schedule_op(cb, BPF_ASYNC_CANCEL, 0, 0);
+}
+
 __bpf_kfunc_end_defs();
 
 static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
@@ -4618,6 +4630,7 @@ BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
+BTF_ID_FLAGS(func, bpf_timer_cancel_async)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {

-- 
2.52.0

