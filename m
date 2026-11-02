Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604894;
	b=tpOZ+T+4hea4UKszwvgeBiUdr8CqTGdw03fcXm+H/JJRsDDRSfPMg2Ajx31kh7YAoZkH
	 xQyB37tVVo35GuumiTygDvm2o+B8IxfJKRz0/nTGR9QevmciF9GV8QOQwr69Alwj/R8e0
	 tK4TpNrrqZMUcnQZC4wHqy2f4BJ3XUHsfPqxvnnzsfQuqvoCRUKLuKtCcWI3lzIZ+pBOv
	 rQU8diVgo6M5V/XqxLHKZkteIJRVF5+AlAuaXnkThp+5mTvpCmMk9ol4ojKqtYPYebwOp
	 a95vL3S5LzX3+bZZ9NpJnXb9RbVPhDu21yidm7TP2VwGMbyMtrT6ifjTVVZ2qCaz2VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cvcs3Th7fdtrXMaIiPKlvnkqqJ1EyrXkjLhHDnhh7Es=;
	b=OFAanHlxYXKT/bTZnG1ChJIwicxmjSHIyjqCk11qfrb/Thls4jSQTKYL+DZv28++8WyM
	 1r2gOVFO6dG7JNi6jTEOGfSrJqiNLnzDN2RZaS81QK44L/KCYIYCd4gTzz1pB3e1dJL5L
	 PhdIFl/2OkO3nAmAdnPPgJ17eRpisE5FsB41ele9bU+lygkF6bbG0DIM5JrW9d7cn5Gzj
	 QqXXnD0E0Wo0qPiVyQHRaj9qLmk6Ckp+lkVGipobwW6qlw4B8YdTVfuiOoezPeBaOPlwH
	 gg3tL6q62sWQPvccFsNKNH8VH+IYxxqeWCwxWxbs4oDH9MwRn0+hHwDcCJgCd5A9LRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=vhKtFIKt;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0C1606A326
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 07:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC0C1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=vhKtFIKt
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e8246b13cbso22289405ad.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 23:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793604893; x=1794209693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cvcs3Th7fdtrXMaIiPKlvnkqqJ1EyrXkjLhHDnhh7Es=;
        b=vhKtFIKtadGDj2brSLwdZ4GlM05nw9FzkOcIXiQ171iha6J0COTKgafbLoV3e0b8Hi
         MFh2BjaalQJSZ64ARY1z5yDxBAlco335BZw3WRjTUFtBdR7JId+cMUgpB4+O8e6o2Auv
         fqbYl3TIamn1AEGMWQK0Oay0hEgWv3rKK1CZEid9XDGDiwhCO6TtBzQM0/sYadnCpA9D
         k5fn3Sn48CcM33g5kqnochCKr2orffyY+/vJ+wMenGSNsfF4s2SkNbtfj8kWjybqV0sC
         1xb5SoAiWFKRxsGLfM3wj7jNOOt91YojN/+0hySpr/1XJlqgHj2ipP1hXgk5uR9rwFh4
         XMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604893; x=1794209693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cvcs3Th7fdtrXMaIiPKlvnkqqJ1EyrXkjLhHDnhh7Es=;
        b=l+e+Koi2VyPQW28WCjIaG6AWy5hO6dP/jLGNsdByha7baZVJQVNHa3ZDNUAVvlv+2u
         sq+BTK4/Hhk/2n4bHaKQaymzgrYMl2a0KWR6gpeKHEK3KiN17yrE0CTfAZv8SazVJDng
         VwfqrdbLnqhbyotDiaMilqJdldZEg34wYLNCxT/FtrCC9Qys4Mrb0JRUivoYe5dO3YY0
         ulChL29YZstmEHuZ5vUwV5U8VgwdT/GgbCymEe2gYo7jjqAj3XgOGv3QCF2TUYQwQ5m7
         WktEH2K9ohYQYuNH9V6f+hZd1fFb6O6n7NJi+B3D/jR/q0GQ6W17S/yBQRH3BXbb6kas
         mOvA==
X-Gm-Message-State: APuU4Z+Jq4kn9ei9i/hhBchyGrJ7lxKq6x+Q0+GxHUaqiAIm56FP38Rz
	6iiyp2Di+POvRPvs3NlcLg9Pp7m50rkcpvunTWfcFDIve6C//Jq77FvPVKxXpRR9T3VMKKLLa6y
	MiU0rNOE=
X-Gm-Gg: AYBFou13ixP+x01SCmg3p3D9A6XGPQkt0jJcMAo6xq/WRvP+ZiJYjK0OJtFwST+rpf2
	4uBLOVgN+wO+nmdHsvowJUpg3FjfblZNIgNRGS62WPNe7MavBahTrr+XjzQhQDLEAvIzPdqcnGO
	+Q8UAp4qNt3ZKlYs3nyiBK+Z0o3yJ1JBQgBZjuPBKggFRHXR3TGmzfosOlIxJKdJqtA9jQTvQLr
	E9gdrxzB0qcWvKb43dsfjZjpa9MCGoa0ww5sXUEei57v6bcMp1MXkVzcJK32BWZ4RePRPmOrOCt
	D79TgpORqzWUYsLYs/DInySOQu/VO/U7zaWwee3xwIrTcGJvWGgZfEb3JppwKmO5S8RE2SB97/S
	obVF7kkBvLbxr7VStArBtapCilgVD2Q7vhNs65Yrnj1PptLMEVyQONP6627/nDtdFUK0OJHixnT
	+Gam2xPEpjEO18SPJAwED2T1u0x61Qfv0P8KZxirhndBgLsZFZWXFGFHUnbof1AIs5XzVMCqYWQ
	2k0UWoIta/ea1hKrmWJY/zs2xXYzbBj1aun+wcp1xGRKRf84sJtRoJ4aGs6ZFa+g1r/BH5csJy7
	ljzWxCHzKVE17jV3hZK9NJYGJvKty3/qO985rBCAVISv9fftRmhIRSlyHAQOUNVHx1o=
X-Received: by 2002:a17:90b:33ca:b0:3ac:97e3:7389 with SMTP id 98e67ed59e1d1-3ae897acbf3mr7358888a91.44.1793604892940;
        Sun, 01 Nov 2026 23:34:52 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9db612sm17551965a91.17.2026.11.01.23.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:34:52 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf 1/2] bpf: Use dedicated workqueue for freeing BPF programs
Date: Mon,  2 Nov 2026 07:34:38 +0000
Message-ID: <20261102073439.6822-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102073439.6822-1-emil@etsalapatis.com>
References: <20261102073439.6822-1-emil@etsalapatis.com>
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

Move deferred BPF program frees to a dedicated workqueue.

BPF free workers can exhaust a CPU's system workqueue active slots while
waiting for pack_mutex. The worker holding pack_mutex then waits for a
vmalloc purge helper on that same queue, which cannot run until a slot
is freed.

Fixes: 6b88aaec81db ("x86/bpf: Enable EXECMEM_ROX_CACHE for BPF allocations")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/core.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7f11555a5070..a4994438a8af 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -23,6 +23,7 @@
 #include <linux/skbuff.h>
 #include <linux/static_call.h>
 #include <linux/vmalloc.h>
+#include <linux/workqueue.h>
 #include <linux/prandom.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
@@ -3073,6 +3074,17 @@ static void bpf_free_used_btfs(struct bpf_prog_aux *aux)
 	kfree(aux->used_btfs);
 }
 
+static struct workqueue_struct *bpf_prog_free_wq __ro_after_init;
+
+static int __init bpf_prog_free_wq_init(void)
+{
+	bpf_prog_free_wq = alloc_workqueue("bpf_prog_free", WQ_UNBOUND, 0);
+	if (!bpf_prog_free_wq)
+		panic("Failed to allocate BPF program free workqueue\n");
+	return 0;
+}
+early_initcall(bpf_prog_free_wq_init);
+
 static void bpf_prog_free_deferred(struct work_struct *work)
 {
 	struct bpf_prog_aux *aux;
@@ -3122,7 +3134,12 @@ void bpf_prog_free(struct bpf_prog *fp)
 		bpf_prog_put(aux->dst_prog);
 	bpf_token_put(aux->token);
 	INIT_WORK(&aux->work, bpf_prog_free_deferred);
-	schedule_work(&aux->work);
+	/*
+	 * A pack_mutex holder may wait for vmalloc work on system_percpu_wq.
+	 * Keep program frees off that queue so mutex waiters cannot exhaust
+	 * the active slots needed by the vmalloc work.
+	 */
+	queue_work(bpf_prog_free_wq, &aux->work);
 }
 EXPORT_SYMBOL_GPL(bpf_prog_free);
 
-- 
2.52.0

