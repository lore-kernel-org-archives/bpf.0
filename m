Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F2D48CD50
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 21:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632194; cv=none; b=BLIA30uH1Xov7lF+j/9QmyWw/gVlnXv4myT9468qLXtcedQKzB8kQq5cHIVgnDqkwvgrq5o5vWVMCKhbzbXjqz0TF4SsbNxtKJoZ3I8JfYuR6RdjocPXYsLO2W/09+NexoViLiJe2dsNsBq3L2GeOhbMB1WxN1XBVoVB8GtGYz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632194; c=relaxed/simple;
	bh=ilQXaEciDmAvPZ2ZCD3kX6pyRzoHKCk42twk2gWnZPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CL8EZZEXSmB71P4GM+NyVBz3OPdVMR8Gii/9JMP+AGASlZ6OY4O51QyluKuGmFhHlYr+cQ+V8EweZqiu4ys9nD2V5hL9evbMdyer+WzG/8xGBNPUfY76JR1qlbnkB+vcq51ZC08KPFTN3J9zCUV6e3N5ln3E/f/yC0ratPsCkZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwfN01/v; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwfN01/v"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e66390995so19731395e9.2
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 14:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790632191; x=1791236991; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=81S92gRsTze5dEkVsqAlBNRD4h1XA9f5yyArW4yZOQA=;
        b=KwfN01/vdOTXCooUL3QRj7PoEWtCQInhwg0DWAKz8DUcdVRjG1Kf/sqwIOVteySWAx
         8ENRqsBYC70x30LY9gcuTm6pUZMjbT50ghUf60g+gKNx0Qe9kxwdxXWgwRAMVwY2jqJC
         E9iL7lY50N+4lEVAmkCFYFgI7+Or23IAFO6X89f+MwZlQH/p//aHZ6g/zvloIkklUHBa
         89fmsG6K2+BWXMzE2pVBwWbzMNE7BxrwARqBVP9zaoWbXq6jtsLufLB2J+AKIk160dYA
         tU8MrFtEe4SBwA54HdVKjS/zWrC1JriRoMdhwInyM7makGLXGE5r5uje2gAf8M+ulx1/
         Kd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790632191; x=1791236991;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=81S92gRsTze5dEkVsqAlBNRD4h1XA9f5yyArW4yZOQA=;
        b=W58Fy/qOyVJaeEzNHcrlASlsLHkLpQQBqN0x/Y08O3AfBmGyWLMwWLIN6vBVwA1hu4
         vdeOkcnhG2Pchczjy2ZRiQth3j8iBkVu0kcP7E5OvbZh4SXraKuUYCvX8KBICzFdEQjL
         5p3wvB1EiMJV7iLM4QlDdEvVKnxPRyT8cvBXef4aSF34cCz0xs63Y0zwfgJeCyeAtiYG
         wAsh15K+gi363XaAS6ytaf7bwbAI2PwpqvvtXh8x41nK6X0gac+3fmPeTDJSiUmyVk38
         W4Uw+/9kbqTkOYOeYPTOfQTBb5A2Y73mGnY2KtGmhlUVC8kCiJ3k0JBxY/4Q57pcvKq4
         4HnQ==
X-Forwarded-Encrypted: i=1; AKwUvBwFYTqgxNIo3ahLwPQzC1vZb5kmgMqgnvhdPDQ/h3wWwunELekko+P3lGQbUE5NnFniOx4=@vger.kernel.org
X-Gm-Message-State: AFuF++n9aQG+clsTjXB/OKZSCDalBTRPnQwF2aQ1owSdSrUXkO3P2XXg
	ak/r1fPJquEZNCyQ5Fy+NEZM7aAMuuQVqnYhUJXQsfW6wKN+YPyfEEIM
X-Gm-Gg: AYBFou0pXQ1StbdJV6Xb3X/YU+5Ns+1Iehj04/qVYyoH8ABwdumtu3E98jt4ap7NpNc
	Z+PsLwDjhk44K3wxBhXvGXXD8Yk8iRUalXY1bUXC8QOaLvF6ECtBRqMBmmU7ay5CdXyfkeHrmd8
	XovMqW2j7wwDwSN36yZvxxvIVTiKoah6KE05EyxtbL0TZoU4ArpJpK/6ahRwjsK8cbhaiU1bA92
	Lj3Q33IbT981hGZOst2xhIS6nhdsLgiE4c4j1Y7IjQd9tJ/3eRYrMSyRyvi2uAGG+CJQfyRuTDD
	iLLm2USL5oS5nYNahOfE9d4uIOw7ekcukhB19MPQE7ngwG8BTqvLx1jiY7SDqM3eo0g3paeNp//
	Yvq8fGmwL/7LJQsVySrV1rJ0UCTBjBUlIiFLvr1iE8Tvau9eKQrOUoVjYk4OUmOUaBqhnLvKbvc
	FfAgVE12Mj3us8s2cJ8A1mcXb/f/b7imUziimf6GTwxNBWMyh+FnDeyOTNi9jhN7Vd17HIDL7Lc
	gtd+j0=
X-Received: by 2002:a05:600c:698d:b0:49d:1df6:2592 with SMTP id 5b1f17b1804b1-49ff06e504dmr192580495e9.21.1790632190773;
        Mon, 28 Sep 2026 14:49:50 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfa57d7sm22704295e9.10.2026.09.28.14.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 14:49:50 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	leon.hwang@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
Subject: [PATCH bpf] bpf: Zero-fill non-target CPU slots on BPF_F_CPU insert of new per-CPU element
Date: Tue, 29 Sep 2026 00:47:29 +0300
Message-ID: <20260928214932.544124-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pcpu_copy_value() with BPF_F_CPU copies the value only to the target
CPU's slot and returns immediately, leaving all other CPUs untouched.
When inserting a *new* element, the backing per-CPU area may be reused
from bpf_mem_cache or a prealloc freelist without being zero-initialized,
so non-target CPUs retain stale contents of a previously-deleted
element in the same map — a same-map information disclosure.

pcpu_init_value() is used to initialize newly allocated elements, while
updates to existing elements call pcpu_copy_value() directly; non-target
CPU slots intentionally retain their previous values there.

The onallcpus=false path in pcpu_init_value() already handles new
element initialization correctly by explicitly zeroing non-current CPUs:

  if (cpu == current_cpu)
      copy_map_value(..., value);
  else
      zero_map_value(...);

Fix by adding a zero-fill pass in pcpu_init_value() after
pcpu_copy_value() returns, covering only the BPF_F_CPU new-element
path: iterate all CPUs and zero-fill every slot except the target.
This leaves pcpu_copy_value() unchanged so the update-existing-element
semantics are not affected.

Fixes: c6936161fd55 ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_hash and lru_percpu_hash maps")
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
Tested with a reproducer:
- Before the fix: CPU 1 retained 0xDEADBEEFCAFEBABE from the deleted
  element.
- After the fix: the non-target CPU read back zero.

 kernel/bpf/hashtab.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 8cc07e54daaa..dff4321f2828 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1099,6 +1099,16 @@ static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
 		}
 	} else {
 		pcpu_copy_value(htab, pptr, value, onallcpus, map_flags);
+		if (map_flags & BPF_F_CPU) {
+			int target = map_flags >> 32;
+			int cpu;
+
+			for_each_possible_cpu(cpu) {
+				if (cpu != target)
+					zero_map_value(&htab->map,
+						       per_cpu_ptr(pptr, cpu));
+			}
+		}
 	}
 }

--
2.55.0

