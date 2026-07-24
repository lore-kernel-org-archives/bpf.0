Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1E0341ABB
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908346; cv=none; b=ag06sVqd0L4WNIqj0NXEXnjcUMo3vBhuDZisQYYJfhol8kZAiHc05B4zeFNYQUz1Y8q0bd6Z/pQiiIGfFAM9BVdYUVkFqzJKiY3y3wQaAVnkC85+chtUicY1i5JiO+L5pQ1l2U6uqMG5rvCzgzqGkdzFwvQjSDUktWdsesfGVLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908346; c=relaxed/simple;
	bh=0O5lQys1VgtGuCieKlKr8HLQ0rLqc7Hxw88ecJVSu6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b5Acvwcu9yQX5L02ZCVm29WN0Fo7CT/HgZYaFMSJS+SmH+YHUwOUa+PWmh8DcS12p68igzmsR0X4mHnubFZ7E0+2dGk9nvFHIoea9/bxTyVYfbcgEbRZ+9jncEySBcu2qBdgxCHpa4M1jH+Jxhm/+/+zDcu1wWtMCbHrheO4HMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUJOPUvj; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUJOPUvj"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4a4cb36ae00so305705b6e.0
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 08:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784908342; x=1785513142; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BBtduID+fBP7XAJrv9Rs1nFoXiwdwwnU4DK8CBqE53E=;
        b=hUJOPUvjKCDaIz6cEGKJMVx/6TN843ZqX0YykgIq+3Bf8xV7H2GEE8KhhdZHv8HNse
         +I0E1XZ4tMM0+mRJN3XJ+GAqfikzENllt0o5INTQ2HcFOSQp2k+nLBIdIkxAbllnCktY
         IqIRnAY+Ly2UxnvCNgLwU/yGMBUTPHt7vJGX7r0yduTxMuCihtnsnBjwAfCJPirBfusO
         fEx+0AJsTBYDpK1GhebwMBcGFDZl5LFmwQ+4zE9nj+MdO0Vzds5SyGF9Ie38tA/Fhkcc
         +y+0l98hCntZOdyhEmvO4KWcl+7vr6uqmpjimsCyFqR+kEiyI4jWk0Qrr4qTd6Nocjbx
         bZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784908342; x=1785513142;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BBtduID+fBP7XAJrv9Rs1nFoXiwdwwnU4DK8CBqE53E=;
        b=ARSp/DX42RlEMR8nzPEGB0n7yd1FsZTMlLtSInoxTknRSqzyQGWxsH/XEwUkYTSf/F
         drbsaq4u/5tBddDNtscCZLMt3ujNq4MvH1m6injaKCXMFQwzc3SZ0kQKUdC86H+spk43
         arDrSuanLrWJ6InCU2dHVtpnqIImoHb9yZ80NX6IOY3UKJFW73dqX+mDwAKKVs+vwied
         7fgIQoR0z3PD3G62fZ8FQNzHt8Ya0E/aM3+OLQB0sEQyS2Et3nXSz8wRv+X7SUrqdL6v
         6umsnHobKYE/8gkJx0qu74BtV+PXuXTM3UURj5CyGVuAM+PEm15ew/EXU3mFI6idi+ci
         aCDw==
X-Gm-Message-State: AOJu0YxW6T4gGNAZhWFlcaKlOgtd9B7lPMEmZS67diZDCmfnXyeWU9p0
	Mi17pGW8sudYlWh3PqqWRFxfnfuLbWed1dCT1Wgib7lMwj0OojVvFmlH
X-Gm-Gg: AR+sD10j0/tZiagAKhgoI3Cj5eFUTpECnZU3aUhG40CpAQqTA6NE7b2CxhXXoOGgG/1
	GQq9Bef1Wm+t6SDkSVc/TbsGwdcJyPxulFjBJmtCyrGDtJFrnuJagB3KpvuVx5NJ5KFxpnOwzf4
	vRY+Zax2AZhllx7NBlzBW9LWSqSN8qx1oU/TfXOljF1BQYWvEjo/DJhYQXsSfaXEKGj9kRoLpfM
	EyJz3kEnwdWFOSlumZXZu2bfoB8WBc3BUumN6r0ZTzlfKqh7EICIjMdPHlDR7fcCo4190oTRMvl
	ZQX4fuIkQphKNxBwJq/aN80Y1E7zl7Gc7RzIKFa3tqi2wuHKEYM/qxbBDH0ZJtOK9NpXBAMnGEZ
	O4WPimd3rBVwmCrLcSMRC4TfONTz1x5PcOSjQG/noWA82v8E6vL+e2+cl9Ox2FfJHaKY=
X-Received: by 2002:a05:6808:180b:b0:485:48da:133d with SMTP id 5614622812f47-4ab352f17f4mr4304248b6e.10.1784908342331;
        Fri, 24 Jul 2026 08:52:22 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ab0f2cb654sm5416433b6e.18.2026.07.24.08.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:52:22 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 24 Jul 2026 08:52:06 -0700
Subject: [PATCH bpf-next] bpf: Fix CFI mismatch in task work callback
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-task_work_cfi-v1-1-2616691781ed@meta.com>
X-B4-Tracking: v=1; b=H4sIACWKY2oC/x3MbQpAQBAG4KtM729bTD5qryJpMcuklnaFkrsrz
 wGeB0miSoKlB1FOTboFWCoywri4MIvRCZbAOdd5w6U5XFr7a4trP3o11TCVLI59zQ4ZYY/i9f6
 /FsPuTZD7QPe+H9eJrQJpAAAA
X-Change-ID: 20260724-task_work_cfi-5bd42ea2f62a
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, kernel-team@meta.com, 
 hca@linux.ibm.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784908340; l=2205;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=9kzLGdYv0TkKivlY7UR/RTu6gKjQFFcSuB4plPlM+HM=;
 b=sj+mH04dK3UyZaAwAeKtHO9sJ51diTtsV/SwWhXGLENQpmxN18WuIuxTG9DNLU/HtRbi1knCZ
 z3f+VgmNHAzBZbqOUIY1XeHP716sBg83xmZYgBcdZ7a/98Gb4dI03Ke
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

BPF subprograms use the bpf_callback_t ABI, but task work invokes the
callback through a three-argument function pointer. This trips kCFI.

Store and invoke the callback as bpf_callback_t.

Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
The unpatched task_work selftest triggers a kCFI failure and kernel panic.
With this patch, all task_work and task_work_stress subtests pass with
CONFIG_CFI=y.
---
 kernel/bpf/helpers.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c18f1e16edee..88b38db47de9 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4388,7 +4388,7 @@ struct bpf_task_work_ctx {
 	struct bpf_map *map;
 	void *map_val;
 	enum task_work_notify_mode mode;
-	bpf_task_work_callback_t callback_fn;
+	bpf_callback_t callback_fn;
 	struct rcu_head rcu;
 } __aligned(8);
 
@@ -4471,7 +4471,8 @@ static void bpf_task_work_callback(struct callback_head *cb)
 	key = (void *)map_key_from_value(ctx->map, ctx->map_val, &idx);
 
 	migrate_disable();
-	ctx->callback_fn(ctx->map, key, ctx->map_val);
+	ctx->callback_fn((u64)(long)ctx->map, (u64)(long)key,
+			 (u64)(long)ctx->map_val, 0, 0);
 	migrate_enable();
 
 	bpf_task_work_ctx_reset(ctx);
@@ -4594,7 +4595,7 @@ static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_task_work
 }
 
 static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work *tw,
-				  struct bpf_map *map, bpf_task_work_callback_t callback_fn,
+				  struct bpf_map *map, void *callback_fn,
 				  struct bpf_prog_aux *aux, enum task_work_notify_mode mode)
 {
 	struct bpf_prog *prog;
@@ -4619,7 +4620,7 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
 	}
 
 	ctx->task = task;
-	ctx->callback_fn = callback_fn;
+	ctx->callback_fn = (bpf_callback_t)callback_fn;
 	ctx->prog = prog;
 	ctx->mode = mode;
 	ctx->map = map;

---
base-commit: c21669db988c8f7cc525198dd33941eec7f092fa
change-id: 20260724-task_work_cfi-5bd42ea2f62a

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

