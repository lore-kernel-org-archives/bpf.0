Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ABC34C128
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 18:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464960; cv=none; b=i+FvLHQJiSIN+ZYMtojkht7cOnJVskE4YINwyJW87thVlKYXit/6moSR9ac10xtKRPd8CTDRb3+8NMgXSUZpctwHKCwZgayeCQ6Jy2SI9SN2/YquirWWX47jzLZlgrv3Jg7du8nvtu+i8oNY8UW10B3xZWWEzO1kngn13H6vPLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464960; c=relaxed/simple;
	bh=xyMXLUnn3oey1DvgBvaNLVgG6Oj2Kj6izXThL7nKMNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PINK2fvqs6KFHa8mafyC6vJtWX6b5/VFpb4bZAhMzZRHt+FggrIW2qCNqk32ega8Yjmcyn5KtcK2+SUTra+nZ3orChBni0A04GX+pWeUdb26Tp0Pg+YFbfy5QH8NfT89evfFj5bOCy5wPKDyECeLn8wSME9lGstlkeWs4Qu2v78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHJVJZtV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHJVJZtV"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so85631f8f.3
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 11:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774464955; x=1775069755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0OWiG/iiYlVRF59EDvVNggOOPYIvLDgUOvQtyQbM1Yo=;
        b=WHJVJZtVKWyOcCGzl7Zf+1oC9MwTrQ6L0kMYjelind4zja/OQcBAxwo3oehfbHNDlx
         dbOdIlKS+C6vhunrzkCcZQOUU7e8yP7Wj76Nro8t66I0d87aniUv49/OsnnYVdXjPsPz
         zPWwvpfcIa7cgvdJwgU8uhek1cNfgaTqKcHjA4c0gsZCMzhTllNvoIam2tZ1Kchz3L4Z
         cDG6shYWBOtx3GKSGhjmhMjnywBivOt/rw3iMoeNYYLwmEhnCuKo+JKFvbpF2g/dZD39
         ESLMIbbec3QcI2wK9K7crDezA900gEE5ZL9UpakWxMgd21wuJlli42GpU2mCTJK/FVEE
         fgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774464955; x=1775069755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0OWiG/iiYlVRF59EDvVNggOOPYIvLDgUOvQtyQbM1Yo=;
        b=NJ3Ull5JExS0Su2gcHuHXfJToLxpq9amYljD6mLTkUgCvhgaIdy896Wmf4NQKfwOdJ
         m1ksMmzlhEzLGR0WyBZgfXomBbn4V0KI/EcWa+P0rkhcfWuH1yvJpp8U6tIS+oU3awp0
         hSFKkfaNxJsVzmiUC3M6v0Pd9XGHwgiQd9nrAmFX4GGbiKt9Y0Bc7Pyx6H09F8QLj/S8
         fBd2g+ucRuM3fzC6Ds9oR+tIdLRZVCzzH/WAoh58bT6ByMCYKtlHBbOYyT4ksqbQEjwQ
         Y6vCbHzy5DFUE0RwamESID2dMs7WUrA8vTJBEXdAJc+0DShrZdXy8NBHGgGfdYLdIAMM
         Rj9g==
X-Gm-Message-State: AOJu0YzAqOWPqOtcaUh67LIJilXlzD4AqM05tXe0oR7twUThZJDHe67J
	yqJs2uhj0Wz+aFQUWpAq08mUHwlb/BAD1nVKdGZmnZBC1e6lzLdAElBR/RUDfP5w
X-Gm-Gg: ATEYQzzNJKgIAtXMeT2th1SQmR7PZyrwfGQ2MdKUiZ035B4106KKdUoBZphISHEYlev
	IBzSyDS4n1rSO6aP92Exo6b730+cZ+FjDSIk90EVf2Lojaibo2ypN/V0Mxq9B7Ue4KIYxbsDF0K
	v6pARivYCSV83qG+PcQ5Jf8Iyl3Rv0OeNpBH5Ah2aVdM+SQMNLn6sX3YgVVbK//E37AhJRV1okY
	+Y8w7V8VgqgktwUpVaboStysFNLIOiDtDdqoe8EiVJjUassRIbIL12IefhUktI7oXR2trR77Wee
	JVVo8ukbE1mx8m69BNlGKo7M663AGZumcGGm5iRa+mGMQA6SU2IgNItaoLs9q4kYEQ6Y5SH8Q7Z
	8I6ktpJbdXkvfIXp+FduVvMDfL7Hq54NyL8rK0aNZwGdRDUjkJB3F3Qu16qWW14LpXCKmA3OzTi
	bNJ5yrN9S67tgv
X-Received: by 2002:a05:6000:2401:b0:43b:3d83:f04f with SMTP id ffacd0b85a97d-43b889993d7mr7038384f8f.9.1774464954668;
        Wed, 25 Mar 2026 11:55:54 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cf2c8sm1647277f8f.20.2026.03.25.11.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 11:55:54 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 25 Mar 2026 11:55:19 -0700
Subject: [PATCH bpf-next v6 2/6] bpf: Rename bpf_prog_run_array_uprobe() to
 bpf_prog_run_array_sleepable()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-sleepable_tracepoints-v6-2-2b182dacea13@meta.com>
References: <20260325-sleepable_tracepoints-v6-0-2b182dacea13@meta.com>
In-Reply-To: <20260325-sleepable_tracepoints-v6-0-2b182dacea13@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774464950; l=2110;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=cgqzZ+1POgtUhNyfR7lIu93bviGjw/19KcHF2jBu1cM=;
 b=QQ4jwmuJdGAPIDf8J7oB7qHGUD5WThYIIlyz9wifNOK45BzpyPfnE7mjQ8QmIfgdjmrnSbtWW
 hynlukd8XViD23yx7tkffEhooiwS0HHw1OASmO92y3k4Xl+l/Mhjxuv
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

bpf_prog_run_array_uprobe() will be used by both uprobes and faultable
classic tracepoints. Rename it to bpf_prog_run_array_sleepable()
to reflect its general purpose:
per-program RCU flavor selection for sleepable program support.

Add a bool is_uprobe parameter instead of hardcoding
run_ctx.is_uprobe = true. This flag controls bpf_get_func_ip_kprobe()
address resolution and should only be set for actual uprobe callers.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf.h         | 7 ++++---
 kernel/trace/trace_uprobe.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 05b34a6355b0..9fe19ab21cfc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2487,8 +2487,9 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
  * rcu-protected dynamically sized maps.
  */
 static __always_inline u32
-bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
-			  const void *ctx, bpf_prog_run_fn run_prog)
+bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
+			     const void *ctx, bpf_prog_run_fn run_prog,
+			     bool is_uprobe)
 {
 	const struct bpf_prog_array_item *item;
 	const struct bpf_prog *prog;
@@ -2504,7 +2505,7 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
 
 	migrate_disable();
 
-	run_ctx.is_uprobe = true;
+	run_ctx.is_uprobe = is_uprobe;
 
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 	item = &array->items[0];
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 2cabf8a23ec5..eb4d78e689ac 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1402,7 +1402,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 
 		rcu_read_lock_trace();
 		array = rcu_dereference_check(call->prog_array, rcu_read_lock_trace_held());
-		ret = bpf_prog_run_array_uprobe(array, regs, bpf_prog_run);
+		ret = bpf_prog_run_array_sleepable(array, regs, bpf_prog_run, true);
 		rcu_read_unlock_trace();
 		if (!ret)
 			return;

-- 
2.52.0

