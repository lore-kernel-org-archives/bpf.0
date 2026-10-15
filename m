Received: from mail-oo2-f1.google.com (mail-oo2-f1.google.com [74.125.231.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE76503913
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107739; cv=none; b=kFRYsWKUVGEBYqACaEhUff71f4L1C3xGHoITLhytnU63CefxafefhTgXju7muYCC0n+Ay1dHXYXLFncmca0ZOucFJmf7i9K9rwCQFqYpYeYkYzkL6TJYwnOYfkLfcHaILxR0ByvEMOYwdAMX/xDsGlxS0E53qlF+kfWk8+jjLD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107739; c=relaxed/simple;
	bh=B283ZoQ46jXtPb1nErwk7HpiFi9Vg+W7a/Xv2uVS0Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwnNxgOkBwHiR5r7IKl/DPNq6oU3rev2CskWD9lGgtCMS26BRPYLlVgZW/YbQhVWPWfbsEie+5VzouNNu7w2T+s0OK8scEmdWf8kvn2W3CVGYzswaRt3ZwOp5+E1uPAv9Az3hPHKYOJzDN4Og54eO8nO8+3eR5+eYUW+Ts+dr/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6A5zwFI; arc=none smtp.client-ip=74.125.231.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6A5zwFI"
Received: by mail-oo2-f1.google.com with SMTP id 006d021491bc7-6fec2d3cc45so395567eaf.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 16:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792107736; x=1792712536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1H9q9Cb+06dGbmwf8nVRSRSWZ6oCNpSfX3dTjyQBe/M=;
        b=Z6A5zwFIOWo0M9/Jp5+dyERUTVInUnGp/68cyza+BBGx7QCYM/gk7H+xo2ODv6cagT
         3/mrb74SguZf32eimRP0KE8GFRZb1/Sidf15hJAtOSYv9upYWosW8pDyvx8n7NLCWESo
         ePdop/QYTfkZRz20c3w1Msf8uYcKccSexS5FzdTw1EtAKzhZYAlju0aLN7izPWWk0VxR
         mqcjoHAlBLTe3oCo/zAVP9YS7njQejgCS5Kaj7w/GLT9NMqCYh0peUdMWS5OxRNvfc9A
         s2ZQoFRVZDoTpSesZtNZ3KLNH2N6y6Kk5wQxzF3J0dbGcTdc/Dp7lKPZ3kEG7jFsfO5W
         1L8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107736; x=1792712536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1H9q9Cb+06dGbmwf8nVRSRSWZ6oCNpSfX3dTjyQBe/M=;
        b=iZPEcZSE++WIs+P37ziQD5fE6XLeMB9kxyipDMhKAU4/BGS0PBk048PP174/5zlhtQ
         57Cq9vjQpYci1bvYEhPT9AmDZIXm70Q6YQgo5QO7Nq1Wo+rh814kGVasdbQEOcHLKxBd
         orMmPgd1OqJv44qtyzPbvD7w18Eu/4vLHBLleNe64cGOSZf0Tn+DBn8NaZXxD0JkmClJ
         1CD7IiXbxZwpevwqTHVGihWFxiGNzg7XCglfwsQuYkQ2E7MLjmp0R3vaCcXOs3Xv63jR
         UlSenfRGQ0ZxPgGStfPip+rdrGF18Ox5xDf654kddTGvK5InTNlJo9pj/Owa/MaXy8zA
         +2ig==
X-Gm-Message-State: AFq9FYItvRGBtKwVX5RtMewAMyV0GKwiso9iTvN/nR2Zp8XJWm8c4rEN
	eVRa+abXO3f0nrhpooSx81nlehczb/9n67ifW3k7u/ct5umL8sC4Seh1E7bccmLDhSk=
X-Gm-Gg: AYBFou2BUcNkBo6Uucs+U9Q6KN0Co50Pf0ioRdkwI1bkrcIxvnUbKdJc0jpN87EFEAZ
	wddWvcyPtJFEKme0nPzO2dcmvYlsAyzNT901Q4Ez0/QhlLLEL4p1sHCi3G9E1Doci9QsYa9KbVr
	6J7F7NX3pBA8J3PFYoK5fA73goYfHWAc1f8wKlbEhZ5gp0spDBbW97LArEK8mbL5ufQlIvn5Fxs
	rHxYo+hAb/xPYyddaehVO5RZUHvoDWVqC8mhvzK6mZSns5qt+OvctfJgHXLWhUorShA6gtd2w2R
	SUcYMueCjspfK/XdjjUrdhzC4s86G8KdKZ3VUSn+Nihs74bhA6A0GQ790Cy88aEsY8q6kcNMgOT
	XkqOGi/xJ/YtiM/2aCsVIMOAJ1EOx6YqsCLtvLNnPeHJZKSvzpAM9amqTteSoR+xx3msVcE5xv1
	I6PMGNWez1lWYAL6ORCmqTCJxwAoyoCtT2/vg7eDYqXe34hAVsG/Jp3VD7hViQ981sZ0rGvvLzR
	DrlqTS/9HgYqWy1udpImu/xY3gf3KGPCuVtnTzhprZD3qFkcD4dXqWKyUH5L2sKioqGZrjUzGZm
	7U8r8A==
X-Received: by 2002:a05:6820:8187:b0:6da:4b62:b6b2 with SMTP id 006d021491bc7-6ef0e6e5a0cmr14690818eaf.40.1792107736289;
        Thu, 15 Oct 2026 16:42:16 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5c::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a7003d35sm417035a34.26.2026.10.15.16.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:42:15 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 15/15] selftests/bpf: Test an arena kfunc argument passed from a subprogram
Date: Fri, 16 Oct 2026 01:41:21 +0200
Message-ID: <20261015234125.3152346-16-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015234125.3152346-1-memxor@gmail.com>
References: <20261015234125.3152346-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1766; h=from:subject; bh=B283ZoQ46jXtPb1nErwk7HpiFi9Vg+W7a/Xv2uVS0Yw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeti3JvAhWkm91WDZR/9u7XghF703AAtQWF9u+YpTXy2QSfO aMl3lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCLWBowM1+6U7Vd7U85nkxq+48qdzZ OMZizXPuesv2fd1UiN4wVH4xj+2dvmX/IpfMzblu/xk1Pnlq7R4alLf5b53erRfy3/xusnEwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Call a kfunc with an __arena argument from a global subprogram that does
nothing else with the arena, the address arrives as a number and no cast
is involved. The subprogram needs the arena base set up by its own
prologue for the JIT to rebase the argument, which the BPF CI review
found was not recorded for it.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/progs/arena_kfunc.c | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/testing/selftests/bpf/progs/arena_kfunc.c
index a049d6371d09..168ae8d7e303 100644
--- a/tools/testing/selftests/bpf/progs/arena_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
@@ -192,6 +192,43 @@ int arena_arg_unpopulated(void *ctx)
 	return 0;
 }
 
+/*
+ * A subprogram whose only arena use is the argument of a kfunc needs the
+ * arena base too, the JIT rebases the argument on it. The address arrives
+ * as a number, so no cast marks the subprogram either.
+ */
+__noinline int arena_arg_from_subprog(unsigned long addr)
+{
+	return bpf_kfunc_arena_arg_test((u64 *)addr) != 41;
+}
+
+SEC("syscall")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+int arena_arg_subprog(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	u64 __arena *val;
+	int ret;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	*val = 41;
+	if (arena_arg_from_subprog((unsigned long)val))
+		ret = 2;
+	else
+		ret = *val != 42 ? 3 : 0;
+
+	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
+	return ret;
+#else
+	return 0;
+#endif
+}
+
 SEC("syscall")
 __arch_x86_64
 __arch_arm64
-- 
2.53.0-Meta

