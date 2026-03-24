Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AF33101A2
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379035; cv=none; b=mWOSHMUkvQ17kF9jpQc5ELuu1DgymKeu0CGF96sexvejQNr/Mr4K6hRzI6rvJKCRFW+UlFTEuCfneXeZVrfBWLQkzlUUgQs2pmrPQeUCW7nqtSXMLUtKheA74n+ppl6V6aVPlJ0iaNBp8On2Bf9U/GUD+4WHEjhl72d5ERl1sY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379035; c=relaxed/simple;
	bh=xyMXLUnn3oey1DvgBvaNLVgG6Oj2Kj6izXThL7nKMNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rV4iSmGYZD4dSunjL/FYVBl8p4RbPq7GYRAGDJq4VYaLGWxrO4h6FUpq653AF4Uxc7aXc7avwFAOP5eKhYf7JO/HDDKpXmyIw5HMHFtglUAcoUn9WDe02ftMZkxy1YngK6ZlixbakfC4kIskWNp51ajFEVXPujnjlQXp4+jN0Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JG2WUPAQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG2WUPAQ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439b9b190easo1314838f8f.2
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 12:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774379033; x=1774983833; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0OWiG/iiYlVRF59EDvVNggOOPYIvLDgUOvQtyQbM1Yo=;
        b=JG2WUPAQBITbM6fBpsjhWZqTX3x9noZgRn/01Cpw1ZhTb1wYPzOeVs5eHNdGX1Rhnj
         e6TrO/IkXG02XmHZSo1mjHwTi+Vk7PeEGuAk88miSFgKEzYhLbRY17NlvEgA4D2EvhhB
         2absuw+qxHtLMMNmxo+dJSLyN92X/GtKWsC4Wum9UVdQGGnDbM5LUG2N8LmLWoD8Rqrb
         JErZ/k6JdFX7VSUwTryiSgNC96aKgHli20MLi8mwObdby1R53CRoylSlOvFXY4zfKVad
         aCW2+kWlGyz6ui3GudCZ/x7dpDfUUcpBPVO8qs97Dty3lyvM7m18OaZtdmxPuhfsEyvd
         gSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774379033; x=1774983833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0OWiG/iiYlVRF59EDvVNggOOPYIvLDgUOvQtyQbM1Yo=;
        b=IO7lwbGA7BY+CGdYqI6O2gj5m0i9utGlFpEJXtcJdvaT25D3JkhVNL+2S0NkGfTjMt
         qy2TXmyD+qJPalrqK8Q5qrhY3aRFLrzV3nsb1rFXoQNQprOjiqcBpmOx/ZPV46jsqBdp
         aO9lmwB8ufQsF25K9PxdW8nIoXq6gBUVpBJDvf5Z/m92IEf5dBSNSDxSIiH0DRd/GpaW
         B7Yt4aXNCaEm4aP4Cq/Sjs8Yz3B5cB9t0VyqpVVCHW72cAmSALo9MBdOZO6uSz7f1fju
         hnDVuvAyixt4GifJlJ2s8twxWaD9w4Upa1Iuu0pDNtldpcxletFGc6bCjRrTMe46wv/x
         CY0g==
X-Gm-Message-State: AOJu0Yz0JMh1dA8tgmVpG94N1mJWfdDFZ4dnjhYLVI4tynMNaPBRy8eY
	duQQH3iph3vNlDFx2DPRXzLDK6h3LBX6ctpWgL8K/Hs8ORhzqVoC8C3A
X-Gm-Gg: ATEYQzylG6E0l37C8M5juhJ02Cyf+jeOrrkKYrhv+p10wkJKok2rgpCSqoSfso2/ed7
	HzUg0U8wyYyI0aBBFrPfyFs33fhuB0DKr+qdR6/sqarrVHYghTD6nOcnIKrUcxo/iiAH9sZLHd6
	mOh7iJIU6h6o/FRaROSSki82p0txpRJgJszETpH8VH6/DVFgujxosGDBPwt9J/LmFE7j7N24B54
	0/KKKIuD/IZ0cr0XYZF4dRt/fSkkvLUDSEeJdSmIa9+O3reghJzaAoZsHs9zNhapV/T+59Q93P9
	GA5cbIgrfrraWZZfhYSl54KI/eWWXbieVQDO1swZMbZqHNCIVaUsR1QHwWl88e/CmyRTdXwx79t
	WvqoaEJhrWG1wznyDJPI1Kam2D5Voak38jabnijgkIbwoqLtaGY6W8GRzG7OWQPa4YOi7pjvl/q
	myf2Mnbl3j/cEyoORJZTVCuL8=
X-Received: by 2002:a05:6000:2892:b0:43b:492c:8349 with SMTP id ffacd0b85a97d-43b8899d26amr910827f8f.3.1774379032482;
        Tue, 24 Mar 2026 12:03:52 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b85082842sm5469072f8f.20.2026.03.24.12.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:03:51 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 24 Mar 2026 12:03:40 -0700
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
Message-Id: <20260324-sleepable_tracepoints-v6-2-81bab3a43f25@meta.com>
References: <20260324-sleepable_tracepoints-v6-0-81bab3a43f25@meta.com>
In-Reply-To: <20260324-sleepable_tracepoints-v6-0-81bab3a43f25@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774379027; l=2110;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=cgqzZ+1POgtUhNyfR7lIu93bviGjw/19KcHF2jBu1cM=;
 b=B27mJDueg9XPI8iMRBy8d9x90dbPXYQ/AYJbNWGpK8iEzg1+yqf90hFtmlOfoY4qveHhiazsC
 4Y1+fEI1cwdCDWsh06H37qmQ2lCIVa9Aat5hcmtdZk0kaw8KTBtLlu/
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

