Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8827274B59
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 02:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769914471; cv=none; b=tXKbTGnM0UKQ62tejh8tUSH8a/0JmZeIrHPAOnjmNhxJ78lRBVQURAc9J3NtmO3GU5yODbGI7rbRontUfil1jEED04NYkIV0XC91eQxCoEWRc0THFsMiL6tMj9aCP6XaO0l0ehyRpd+okjKvbWFFh4qVj8h10vL57gldk7+6hjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769914471; c=relaxed/simple;
	bh=WxodeBsqPafDGPv6YmYEBiQomdd0VhaK6AmOUFpG6CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkvfmAFJsSBu/LW9TNQ+hoR8n77/guOm8WROW+STbTnYVpRZ4fzvTVr5Yt6krBflr1BSSoIbaU8229EPzf9AYFlr35rerjF3ScwVWaNI6hNXjdP2bI7sTRvF9gMzPtlG+OrK8lWDXUO1X+MvuAwfeexcgpOCUN0eZ9CoIxuyMjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H583DGzu; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H583DGzu"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81f4c0e2b42so1839800b3a.1
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 18:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769914469; x=1770519269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ATPsIUtIpI1XVVxm4Fkm9CYAM7VlvZEbcnkRmVLw5E=;
        b=H583DGzuQn7SjlB88PYuoAqdjzUanVE7SO/LRFhLmBOq7QV/KPdr+fw+sx6UJzNT1m
         kclY2ls8bcxCLY76bXuRKtoalApdOegTINi9+GIZMxDhU8jhZgKa0N6/2BVlh3O1IVtM
         oU7stna4PrfjvT3aIW/hDsT1qaoW0jpdvBgrCN0I8qeXtx1eZkxdUlED9v9hynEc1kQ5
         sjcXFlwH6dfwg7xHdukok2VqzjYoVJTP29ZBRJjJUL5pvzlF+PmPa03yNOWsrKMSmwPX
         QLdn73YO/b+p8K7UU6l9UHHf4Oibs3V+2SKRcD+vRIHk8YTMbeFuknvRfdTfjGs1zrq1
         uxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769914469; x=1770519269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+ATPsIUtIpI1XVVxm4Fkm9CYAM7VlvZEbcnkRmVLw5E=;
        b=f1rQ435Ny1DXfm0gFrpnmwgM4HJIOMDTvGRezrfUH/9fRRpCuMN0ZiQIX/4he2pk/u
         hd5uHASmfLT4Ie+tKfVvh5chrY3KS5kacU8IXFzOACURoIVRBPyLJSf0E1hoWVxdFBBd
         wEq6MiM8fMKO7XO48ZNXMGf+V1neif37OQiofECMXXRMRxc2kwn7rsGswNzBFdwGjZ6c
         QIe1VMXLPdLmGgPDUFJHMEB0i9Rj7SgHwt77uwHggV/WTMMG5qpX5IFCUCScvdQQykHe
         t41z35xsbm/AMugogeHioOIRudnly/CyP+D/nFe+06hOo0XYqn99M9pkWAUj6GAOlt1O
         08PQ==
X-Gm-Message-State: AOJu0Yxz2BJ5u/+dPxpQLHpfEaULQqOmuZgD9hrKxpe/295SWPo0rQs+
	qTPUjCR6+Y38qSNR5nbJpdsHneRBYvZjrUDrBKej/6zldinJpnVwbYZVadvWfg==
X-Gm-Gg: AZuq6aKZI0rxSlH+uJpKd3Ax0kO0aHp0LSFiaaE4O9tgZAIC2wrXiV8XIx5HSABrWHo
	U3GDUOWZf4GJ50SB37+x/G7/eR3M2FAb7jAGIPyJFD8xM24e/DIxiMqGeM5fFIFTnmexA1Yv3ya
	pV8mDE4hYJh203gmwgEvhwHzYjUgvm+e7Y5PRWZu8iKqCSt7BiXv9iiIKJKjzD3Dl9SI6B2HHBg
	boiRYUtpXm13BOPQrZZGmf2v5UiW3xdWXMHkRImFFVYuCkJfLsBuqNdMv5+xvrjyav0DrXw+QyP
	0l1GeKdkGLPX+0YLYTm1Yuvt2v+Zw9KXUzjXp0haom78wnADMcBCjTarNVGy9KTSrk+qxgepQEP
	eIsyccDYLAIE48NQ2vtYKs/4SyURZI4a+2DCvsox7tONTmSXUzqDLG+gtIqIDkkuED6ApKKfJVP
	u9OkQ0ooOFjyep8Tg50vrOv/8mlPER5a9ZaSOxPYr1GDJu8ql/46knPh4vl2tOZgHRwRcJEN0zE
	Oh4Is9sVm8R/yUgGe/Q8NwOtQxhXKOFYvK+DbuRmq6C9HzlZQ==
X-Received: by 2002:a05:6a00:e87:b0:820:2f9b:fe18 with SMTP id d2e1a72fcca58-823aa64d163mr7285207b3a.27.1769914468686;
        Sat, 31 Jan 2026 18:54:28 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b4a771sm11752390b3a.19.2026.01.31.18.54.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Jan 2026 18:54:28 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v9 bpf-next 8/9] selftests/bpf: Removed obsolete tests
Date: Sat, 31 Jan 2026 18:54:02 -0800
Message-ID: <20260201025403.66625-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260201025403.66625-1-alexei.starovoitov@gmail.com>
References: <20260201025403.66625-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Now bpf_timer can be used in tracepoints, so these tests are no longer
relevant.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/progs/verifier_helper_restricted.c    | 111 ------------------
 1 file changed, 111 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c b/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
index 059aa716e3d0..889c9b78b912 100644
--- a/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
@@ -17,17 +17,6 @@ struct {
 	__type(value, struct val);
 } map_spin_lock SEC(".maps");
 
-struct timer {
-	struct bpf_timer t;
-};
-
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 1);
-	__type(key, int);
-	__type(value, struct timer);
-} map_timer SEC(".maps");
-
 SEC("kprobe")
 __description("bpf_ktime_get_coarse_ns is forbidden in BPF_PROG_TYPE_KPROBE")
 __failure __msg("program of this type cannot use helper bpf_ktime_get_coarse_ns")
@@ -84,106 +73,6 @@ __naked void bpf_prog_type_raw_tracepoint_1(void)
 	: __clobber_all);
 }
 
-SEC("kprobe")
-__description("bpf_timer_init isn restricted in BPF_PROG_TYPE_KPROBE")
-__failure __msg("tracing progs cannot use bpf_timer yet")
-__naked void in_bpf_prog_type_kprobe_2(void)
-{
-	asm volatile ("					\
-	r2 = r10;					\
-	r2 += -8;					\
-	r1 = 0;						\
-	*(u64*)(r2 + 0) = r1;				\
-	r1 = %[map_timer] ll;				\
-	call %[bpf_map_lookup_elem];			\
-	if r0 == 0 goto l0_%=;				\
-	r1 = r0;					\
-	r2 = %[map_timer] ll;				\
-	r3 = 1;						\
-l0_%=:	call %[bpf_timer_init];				\
-	exit;						\
-"	:
-	: __imm(bpf_map_lookup_elem),
-	  __imm(bpf_timer_init),
-	  __imm_addr(map_timer)
-	: __clobber_all);
-}
-
-SEC("perf_event")
-__description("bpf_timer_init is forbidden in BPF_PROG_TYPE_PERF_EVENT")
-__failure __msg("tracing progs cannot use bpf_timer yet")
-__naked void bpf_prog_type_perf_event_2(void)
-{
-	asm volatile ("					\
-	r2 = r10;					\
-	r2 += -8;					\
-	r1 = 0;						\
-	*(u64*)(r2 + 0) = r1;				\
-	r1 = %[map_timer] ll;				\
-	call %[bpf_map_lookup_elem];			\
-	if r0 == 0 goto l0_%=;				\
-	r1 = r0;					\
-	r2 = %[map_timer] ll;				\
-	r3 = 1;						\
-l0_%=:	call %[bpf_timer_init];				\
-	exit;						\
-"	:
-	: __imm(bpf_map_lookup_elem),
-	  __imm(bpf_timer_init),
-	  __imm_addr(map_timer)
-	: __clobber_all);
-}
-
-SEC("tracepoint")
-__description("bpf_timer_init is forbidden in BPF_PROG_TYPE_TRACEPOINT")
-__failure __msg("tracing progs cannot use bpf_timer yet")
-__naked void in_bpf_prog_type_tracepoint_2(void)
-{
-	asm volatile ("					\
-	r2 = r10;					\
-	r2 += -8;					\
-	r1 = 0;						\
-	*(u64*)(r2 + 0) = r1;				\
-	r1 = %[map_timer] ll;				\
-	call %[bpf_map_lookup_elem];			\
-	if r0 == 0 goto l0_%=;				\
-	r1 = r0;					\
-	r2 = %[map_timer] ll;				\
-	r3 = 1;						\
-l0_%=:	call %[bpf_timer_init];				\
-	exit;						\
-"	:
-	: __imm(bpf_map_lookup_elem),
-	  __imm(bpf_timer_init),
-	  __imm_addr(map_timer)
-	: __clobber_all);
-}
-
-SEC("raw_tracepoint")
-__description("bpf_timer_init is forbidden in BPF_PROG_TYPE_RAW_TRACEPOINT")
-__failure __msg("tracing progs cannot use bpf_timer yet")
-__naked void bpf_prog_type_raw_tracepoint_2(void)
-{
-	asm volatile ("					\
-	r2 = r10;					\
-	r2 += -8;					\
-	r1 = 0;						\
-	*(u64*)(r2 + 0) = r1;				\
-	r1 = %[map_timer] ll;				\
-	call %[bpf_map_lookup_elem];			\
-	if r0 == 0 goto l0_%=;				\
-	r1 = r0;					\
-	r2 = %[map_timer] ll;				\
-	r3 = 1;						\
-l0_%=:	call %[bpf_timer_init];				\
-	exit;						\
-"	:
-	: __imm(bpf_map_lookup_elem),
-	  __imm(bpf_timer_init),
-	  __imm_addr(map_timer)
-	: __clobber_all);
-}
-
 SEC("kprobe")
 __description("bpf_spin_lock is forbidden in BPF_PROG_TYPE_KPROBE")
 __failure __msg("tracing progs cannot use bpf_spin_lock yet")
-- 
2.47.3

