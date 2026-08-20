Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8386B24B28
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 02:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787192923; cv=none; b=ULtip10CwuRfvOfYG1NEI0lxGAZ7ANerlImw0AmvRrDQxC37SXlfcC9tTZFs7LF7VpIIXrYT8eOEMe+hRQWD9fFXLTZ5qumSvUnCVAma9vrBV6hN3Cwj/ypQJ6Z4MdI44Wsy2hOCPGo6rOxdZSoMSLJPvscRxHmD/VcoK5N8S1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787192923; c=relaxed/simple;
	bh=aDMV4fWnry11sHOGeTDQBHl4BLjtm39QiepqMGViGF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZOF2avwJbQFvZTBPQKZFVXmeHKZX+h8c4uWCD/ORHxmiqmdXNw8OgUeFCv2a/fsoW3XpIOtSl5+rRLcESNSZ0wMQB5CpiSHmeRw2WYxPdXN6Q/hHt0WE/t2C4l4X3JfDDrg8ucR/1RHP7xTAPWjPMJqkQYbtL+pWmUPJgwDWsQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNb7KqWI; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNb7KqWI"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so1492299a91.2
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 19:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787192922; x=1787797722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2yzy1IkfQ00CUbnZFN+MDvkX8Z6/ZjHiaU67BweoYoY=;
        b=dNb7KqWIKV3OP7qoSWTba5BuweAgi0Ut5RbWo1RahhY2YwayGxBmhS4vgs1PCFMHKE
         3QCqfKDquTO9j7g5d394jrYVM1lp7elDzQlbi9JOwrKzN2eKvljDiiW9iBO3LS97AaAw
         oQuBwZbc3IVlU4ey22e1GoENaOAH9WDQY6Di8X0Es1ZfDJ07jzvizplqIEkZfpLsuVq+
         f7FBjgZATJmTfg8bv42J3tTses0lc2olGZaMw1N24BLa67JrcgWuWXnm/ZiN6EeTy++r
         wDPpTq1RT67rjgj3XVYTsRodcI8Vn9qyBceWANvSfseq9Q1Qhwh/xcFt03bmXQVXanJ2
         gCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787192922; x=1787797722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2yzy1IkfQ00CUbnZFN+MDvkX8Z6/ZjHiaU67BweoYoY=;
        b=KaStDK2YXA2At86282S+4YUrdlEVMjBqHxkb0klUUEZLaCBlcfuvL4DSJ2/aFktrB8
         NwoinxGR37di1j/ZASMOjYw9sZuC0/05pyh+itALtfBhqSREhDchXhAXlilqol7XqE0R
         usBH27fVsqoCuPRG/T2rV0JL8FGUZrxH8HFKBwqg+yEGRK1hDr8MQLyXrtWJhGOQOpFL
         Cr5um+vd4xHP1krrm7zldjMxCZ+ADFl2NmPc5ykq6wPLd4v8GwqA8Oa4wK7yuE2U5Q91
         MDcfDvQVnRqDDc/H6r1c53CWous82zeHj6RaAb93/sSV4ujTbYy0EZIck/mXZ610qBAi
         6/Cw==
X-Forwarded-Encrypted: i=1; AHgh+RpgLMvc+fQocFZ9u4DhOXRUs7eg1rkpOFpC8n2PQmiBAdv+FZoeiEERJtGMtFw6ydTCdMM=@vger.kernel.org
X-Gm-Message-State: AFuF++maV6pDXo7wbpu0RN9cb51IeW+pHmQ80UXV+Zg0C3hMjH05jY2n
	l6KvBE1LeOZTO8P33XY/+mm17C0eDRWgoaFVVA5pMtiLRxh4uCczMCu+xJx+gg==
X-Gm-Gg: AR+sD12w96hxydeflne+z2OctHQzB2sBCsZgwAInDvJttmkM5QgmhV4cD3zm/mAQF9w
	PGG5Roqbd8R1cUkQuni4iOq47BrrBjq/ZKKSaGmyqx99ohs7i0hmwvscokT2G99OdLVAelIr5iN
	2G4QBeNsc+RFHUZml33otp4LyWxF1ffOvuWfME3Fp+LKMAVIQeFPbzkXPrReOqynkg7p/kAXCMW
	W7s4sxO72d5OD1GPfE937CPeCoxpphdO5nn/AvZyCzPOqiO6PcSRwjl2Q/ZVr5f0/09+tevRD/T
	+GoEHprQfRdrKWos/ci2jQv0/29xfKzHHyYhQX21w/is1k8C67AEOYIotwrTw/ZaDd5TWg0Hu0V
	cah6GBDCAxQCEwXhApmmSivOHkFFbrzaG2kiQKuvX9M0KfrPwRtasEGJoPg4VRUbfkcmAjmKjaU
	wXUyd68/rZW5K8JSrnNIhniieouQkdwwCq8sUkNPZxhfibi/p648xam5CS
X-Received: by 2002:a17:90b:258b:b0:38e:2e86:ed02 with SMTP id 98e67ed59e1d1-395810e9837mr18138079a91.14.1787192921760;
        Wed, 19 Aug 2026 19:28:41 -0700 (PDT)
Received: from omen-arch ([147.46.124.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb14bbfsm4641872a91.1.2026.08.19.19.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 19:28:40 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf v2] bpf: keep trampoline progs alive until image release
Date: Thu, 20 Aug 2026 11:28:31 +0900
Message-ID: <20260820022831.18601-1-zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch_prepare_bpf_trampoline() embeds program pointers in the generated
image and passes them to __bpf_prog_enter_recur(). After
bpf_trampoline_update() replaces the image, bpf_tramp_image_put() can keep
the old image executable past a normal RCU grace period.

A detached non-sleepable prog can therefore be freed before a preempted
task reaches rcu_read_lock_dont_migrate() in __bpf_prog_enter_recur(),
leading to a use-after-free.

Keep image-local prog refs and drop them from bpf_tramp_image_free().

Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
Reported-by: Sechang Lim <rhkrqnwk98@gmail.com>
Signed-off-by: Junseo Lim <zirajs7@gmail.com>
---
v1 -> v2:
- Factor prog ref get/put logic into helpers, per Leon Hwang's suggestion.

v1: https://lore.kernel.org/bpf/20260815071927.147049-1-zirajs7@gmail.com/T/

 include/linux/bpf.h     |  5 +++++
 kernel/bpf/trampoline.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7719f6528445..bacb6bc2e27b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1376,6 +1376,11 @@ struct bpf_tramp_image {
 		struct rcu_head rcu;
 		struct work_struct work;
 	};
+#ifdef CONFIG_PREEMPTION
+	/* Programs called from this image must outlive deferred image freeing. */
+	struct bpf_prog *progs[BPF_MAX_TRAMP_LINKS];
+	int nr_progs;
+#endif
 };
 
 struct bpf_trampoline {
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 1a721fc4bef5..33383d1dc1e0 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -529,8 +529,36 @@ bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_a
 	return tnodes;
 }
 
+static void bpf_tramp_image_get_progs(struct bpf_tramp_image *im,
+				      struct bpf_tramp_nodes *tnodes)
+{
+#ifdef CONFIG_PREEMPTION
+	int i, kind;
+
+	for (kind = 0; kind < BPF_TRAMP_MAX; kind++)
+		for (i = 0; i < tnodes[kind].nr_nodes; i++) {
+			struct bpf_prog *prog = tnodes[kind].nodes[i]->link->prog;
+
+			bpf_prog_inc(prog);
+			im->progs[im->nr_progs++] = prog;
+		}
+#endif
+}
+
+static void bpf_tramp_image_put_progs(struct bpf_tramp_image *im)
+{
+#ifdef CONFIG_PREEMPTION
+	int i;
+
+	for (i = 0; i < im->nr_progs; i++)
+		bpf_prog_put(im->progs[i]);
+#endif
+}
+
 static void bpf_tramp_image_free(struct bpf_tramp_image *im)
 {
+	bpf_tramp_image_put_progs(im);
+
 	bpf_image_ksym_del(&im->ksym);
 	arch_free_bpf_trampoline(im->image, im->size);
 	bpf_jit_uncharge_modmem(im->size);
@@ -740,6 +768,8 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		goto out;
 	}
 
+	bpf_tramp_image_get_progs(im, tnodes);
+
 	err = arch_prepare_bpf_trampoline(im, im->image, im->image + size,
 					  &tr->func.model, tr->flags, tnodes,
 					  tr->func.addr);
-- 
2.55.0

