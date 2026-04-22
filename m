Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06FB347BA9
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886953; cv=none; b=Jlp+1ao+CG25/pBQ3tYGhDrI9QKHA760+53DVasJe0v27EwU6i4bcJ5p9kZJvppWV46DtRND7LoLr1loOyLogfOdvy3FTuWnwwkh54r6NdTfBFdpdkG3vdpdAuZdy5U7TNk+60UHl0+nXnfRGiJ4MKQCs1pJvJen+sUt5EAHieg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886953; c=relaxed/simple;
	bh=VMtFsT+n5X6ar5kIS9YTKC5980+/W5waB/REB4IA5qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pv06GQ504CvvyzvWrAi32ToP3xlc2z5nsy9YrVKTJbTblGl11KmBywZrVL5dCMq7i7Y3AcVHMl6Z0NGjToGsvgC6Txg8dMBih19+CRgwHSe5FSrkeXbdSGg5MvOeZPz19C5LUHkOcsZx2ikzuXRGg4581DVx6TJf+u427S6bvHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+tg+ol/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+tg+ol/"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so4803705f8f.2
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 12:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776886950; x=1777491750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDDO98B8peT4kpTcd8nPt+peTSiWaJwm2AqPG2c7HzA=;
        b=F+tg+ol/d/DVasPHvYLo+S5wbtxFMawwRGmYq2kAroQ+VaI1cN5FTpTZhTnW53j/PR
         Kq+D0M/YIxCjgAPcww+a6bFYnYr5Y3ccDAkJWOm6nVdVjbBA4L916F/pvoLScUAQpw7v
         qfPB9T3r13J8iwAydrV+iAA2feA06T3nel3h6b92i5jlboDMz5MGXVvquTA6Wv2n+dfw
         rNvTjmq9qJKN++RoP/FItXms/+iuI976TGfPEAxvrr08MWbN2+IMdGUZebuo6oafvxhi
         /5TUEoE6GBxh2S05P/utz2hH7qD0UiqRABe6d+RV473hZexQ62gWEXYWOdM8S6LQFHnC
         NopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776886950; x=1777491750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lDDO98B8peT4kpTcd8nPt+peTSiWaJwm2AqPG2c7HzA=;
        b=pPlhQskvjcnzetxnNWoUahga0Q7XjHs4LW4CvCPIsQhCK3DNbCU/8xwTtpMQFlkSnq
         Ol+aukOuEPb5nRG2BBni8Efv2FZ/54O8x+LXphJvLqdd9NkXexxuXDvspR1jK9kBadd4
         cggEbSzBUG+WqAYKjfQAoL347IdwJ9KIiTnb1pMp/IeTmTKAjG4jPGKU2DibPvBDyA8j
         CLYnZHZDI62dXpRsqn1zbg73mHP5ZN51HIyHeGiachB3IJbHglrlch1A81F6Evu+2NPY
         LKoGQgxQVWtRo2M98EeX/bZU2TDVZxaSFtTNY+vq1cWcvqbx5G725T6pOR9ZVazc3buk
         pyJw==
X-Gm-Message-State: AOJu0YxU2/oFyYn9KhFt/fYsOawOp391YI5mnFEA15gx3CpX//cVrUsC
	mv/bqPiXayBcjcFVqEUUbr8p+CBphgwm63RzF3YM6yvBLjSOZIfuhBQf
X-Gm-Gg: AeBDiet3RyPMiTnp3XiSwHiwNBMO03uqhwJgvZkp6DveN1vfxPjt2xffgB68yQddlAZ
	3uVQdVSwHv5gJk+TkZAxNKy/ASlA49M0Y/Ld2VDwi7WrUitHNRU7w95Vz51xZLjWI7EAaX07tr7
	9zPNOw6k8ckOR3V7u/pgXhiA53ANqFG3n6L0jJZmmQysdg3wE9MuyvVITyVU3Frd8XQ5i+gVBH1
	66DlEiJw/M4xDr4czO8Rcq56m9KV7ZWtFzQXA13MNUP+qeMVm4zv3+5C37VErv9WuRXifQsv6EL
	nQEjt0lB9KZ1uy4K16cdFmnqCqRJAx0Z8KcVGlK2PXq9lDNQKiT69kcdHGaoLbmcP7refMGLLM3
	gwXW82Dwa0EzSHlb1psEzzT/lZxCE/6nKmRRRUxCkSvBttnsya+/tYBJjSs8aUhD4ftvsyq/mZX
	KXVFq3TLksBiq3iqn6VndJLBw=
X-Received: by 2002:a05:6000:25c4:b0:43b:8f56:1e1d with SMTP id ffacd0b85a97d-43fe3dc10demr37130558f8f.13.1776886949712;
        Wed, 22 Apr 2026 12:42:29 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm52941990f8f.37.2026.04.22.12.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 12:42:29 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 22 Apr 2026 12:41:07 -0700
Subject: [PATCH bpf-next v13 2/6] bpf: Add bpf_prog_run_array_sleepable()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-sleepable_tracepoints-v13-2-99005dff21ef@meta.com>
References: <20260422-sleepable_tracepoints-v13-0-99005dff21ef@meta.com>
In-Reply-To: <20260422-sleepable_tracepoints-v13-0-99005dff21ef@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776886944; l=2504;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=KzTwCQ0wWVgkeuW4DVHudpEBxw4vAcTGMbCDX8BSmEc=;
 b=ZyrNbBPNkDhSsh3zaDbyWIbbgmk7AI2NJ8H+Fw3ZvuOAOhUxI6mpIlKSrZe1pIE8OgKW6Ga5M
 qW859ch3xEiDXEffiTa3hom80+svDQce/+GdHK3TbN5Dmc4HCBiDrsk
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add bpf_prog_run_array_sleepable() for running BPF program arrays
on faultable tracepoints. Unlike bpf_prog_run_array_uprobe(), it
includes per-program recursion checking for private stack safety
and hardcodes is_uprobe to false.

Skip dummy_bpf_prog at the top of the loop. When
bpf_prog_array_delete_safe() replaces a detached program with
dummy_bpf_prog on allocation failure, the dummy is statically
allocated and has NULL active, stats, and aux fields. Identify
it by prog->len == 0, since every real program has at least one
instruction.

Keep bpf_prog_run_array_uprobe() unchanged for uprobe callers.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf.h | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3cb6b9e70080..d3aea3931b85 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3079,6 +3079,56 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
 void bpf_prog_report_arena_violation(bool write, unsigned long addr, unsigned long fault_ip);
 
+static __always_inline u32
+bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
+			     const void *ctx, bpf_prog_run_fn run_prog)
+{
+	const struct bpf_prog_array_item *item;
+	struct bpf_prog *prog;
+	struct bpf_run_ctx *old_run_ctx;
+	struct bpf_trace_run_ctx run_ctx;
+	u32 ret = 1;
+
+	if (unlikely(!array))
+		return ret;
+
+	migrate_disable();
+
+	run_ctx.is_uprobe = false;
+
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+	item = &array->items[0];
+	while ((prog = READ_ONCE(item->prog))) {
+		/* Skip dummy_bpf_prog placeholder (len == 0) */
+		if (unlikely(!prog->len)) {
+			item++;
+			continue;
+		}
+
+		if (unlikely(!bpf_prog_get_recursion_context(prog))) {
+			bpf_prog_inc_misses_counter(prog);
+			bpf_prog_put_recursion_context(prog);
+			item++;
+			continue;
+		}
+
+		run_ctx.bpf_cookie = item->bpf_cookie;
+
+		if (!prog->sleepable) {
+			guard(rcu)();
+			ret &= run_prog(prog, ctx);
+		} else {
+			ret &= run_prog(prog, ctx);
+		}
+
+		bpf_prog_put_recursion_context(prog);
+		item++;
+	}
+	bpf_reset_run_ctx(old_run_ctx);
+	migrate_enable();
+	return ret;
+}
+
 #else /* !CONFIG_BPF_SYSCALL */
 static inline struct bpf_prog *bpf_prog_get(u32 ufd)
 {

-- 
2.52.0

