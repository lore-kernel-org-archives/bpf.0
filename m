Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD86492521
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784136093; cv=none; b=DKfmwx2FfDy66tIgSvm24P3RZFRk+zI2rTHM2U5QPukQ7MqQ8Xyq2q9CiAZFCUFIbYFS/0IusMpR/jbsgEo4JN5SsBXFGKQ8v+9+Yy3QweUGBy3Nl2qKVpqscrm3Rf+NNukrIaox1OvX23Kwk1SiQhEw7ryTIILW10+LjrMjNq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784136093; c=relaxed/simple;
	bh=n0n2MSniK9EDWUZOJ75RYhgtXl8pBDKo+sPcEBGTJLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BV4XPFZT5WYtns8OEwCOdATTHiZ7YuV1HI0MNHAgtXAZo1yVc2F0ZAimaEjDnJWZUHG3+l05bQr6/a3G6/YHVp4JyBblvK4k+yJbnsfBTDqm0aIGBLll85I30XkXPXG1lQ78Am5dpZp/b7kTFhvT+WPm4cp5v+PKYa889A7t6OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sflth1un; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sflth1un"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e9ef94c0e2so1032027a34.3
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 10:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784136090; x=1784740890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2qYtIY2DJE37Tib2Zk/+OUpynWDGn37w7qpN8GkIfPg=;
        b=Sflth1ungY0yzyw7H26NmsekStSIFy+1p9Cx7PsUDD1xg9BGZND0E4kgzbOsli1/gp
         wVYfEy1acpZY0U/85yCkmW+K64C/VnQub9jCf4Ow6WR2vtEQxNkXrrcUH8T1LAOr9eSq
         xVSVykymauy7F6RGxH8/cscC8jx1O1ZI8vfB8RPSNmFXXp0HH3HyG6t/AoRjnuSmG57G
         YUMIoqQpqupK7rRhOYcytbKGIQZURX7J1rwgwrGZiiDanYLh6GZmOVpZDnL+0eKv6zDE
         Jf/uziWvq56xf0rG5Rh1dyYH8N8VXnulH9c9fjT0Q1KjbiDK4ryurll9llXWgmetO/uS
         lSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784136090; x=1784740890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2qYtIY2DJE37Tib2Zk/+OUpynWDGn37w7qpN8GkIfPg=;
        b=lBETjjwZBWWAIpfGtR2mwMO3lSn9irCvSenE369SnKRtQD/d5BDKQKxVwOxXgaf8Fd
         KJCFTBjvNx/6CTl6fd8OLgWIqpM13ue70JOC304jrFBOR4jlzS1fFFcciD1xPMeYtdGN
         jFjHomaZKtJ4w9dP08frrRPuvg5RjKIh8oJ0VhagMtbyWp6g9zXZ39gFb1GccU/NI4UP
         RdV8/e7gqOBOnyfGMgdMPcLZdHRYt3BGC5XK/gIMHKnpsEwo75Pwo63FjWQGEf+NBKst
         c8pp6FStd52GN7CGE3q19w1YhC5KCcTqGwwDj1FgGtGnQar5pHHCOG7kFUGAgV0/GXU4
         Xhmg==
X-Gm-Message-State: AOJu0YxMzigM7mI2QJME1KvhxnhS52gSWeiCOrubyXSxKTngOQPuBYnm
	KroNgkHVWZCTz9odYy7YW21JbNxRsAQ8BTEDhJSKd4WATBO99tGBHFgY9AhM1Q==
X-Gm-Gg: AfdE7cnUGX37eeoBv0YbhzC0ZiiFx3focM1YAoPBgxuaY7VKucKpMVMts/qU2Sy67Lw
	qaP6YW4q1FFJ3Oezyj5XNaiZzngb399fn5ea3Z9gMG7b+f8cZ+04P04VEGKsBY/GskzfEMrvY+J
	sgzSrh94MQShdodjVsUMAlqTBcMPcNCcHI4iiGlKgZwzPA0QIqXtfElv72OnWpxe2hn9AfzyNko
	4dxSKukK2YV1NYX2FjUvu9JXr2c32Ptl/gnjyuYQaayMG1gPC4mICjR2LhG7kpkykdYKG2JM5LL
	i5H4jiO7LFwbWcJSzEjoD7njeu0pOVXl3Y2IaEYxKX/7ShqHMYM4TB082r5Y5LghsdTdxwRSEuM
	fvQM0VN0BxgiO1nazW8F5Wj9LD4ElTYYWY+cRck99YfvsNXZBOw3FihKySceyQguWIfGL4vQ96H
	Rcc+U=
X-Received: by 2002:a05:6830:3153:b0:7e9:b4d0:53a0 with SMTP id 46e09a7af769-7ec0983a668mr10997217a34.25.1784136090394;
        Wed, 15 Jul 2026 10:21:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2631dfsm17618336a34.13.2026.07.15.10.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 10:21:30 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/2] bpf: Disable raw mdoe for bloom filter map_peek
Date: Wed, 15 Jul 2026 10:21:26 -0700
Message-ID: <20260715172127.2416388-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260715172127.2416388-1-ameryhung@gmail.com>
References: <20260715172127.2416388-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a bloom filter, the value argument of bpf_map_peek_elem() is always
an input. Therefore, the verifier should not allow passing uninitialized
stack memory to it to avoid information leak.

bpf_map_peek_elem() tags its value argument ARG_PTR_TO_MAP_VALUE |
MEM_UNINIT, telling the verifier the callee fills the buffer. This holds
for queue/stack maps, but not for a bloom filter, which reads the buffer
as an input to test set membership and never writes it.

As a result, a program can pass an uninitialized stack buffer to
bpf_map_peek_elem() on a bloom filter. The verifier accepts it and marks
the buffer initialized on return, letting the program read back leftover
kernel stack memory. Bloom maps require CAP_BPF to create, so this is a
CAP_BPF-gated stack infoleak that bypasses the boundary CAP_BPF is meant
to enforce (arbitrary kernel reads are gated behind CAP_PERFMON).

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index de816063ae63..c87e5fec5a85 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8422,6 +8422,15 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			verifier_bug(env, "invalid map_ptr to access map->value");
 			return -EFAULT;
 		}
+
+		/*
+		 * Disable raw mode for bpf_map_peek_elem() on a bloom filter. The helper reads
+		 * the value buffer as an input rather than filling it.
+		 */
+		if (meta->func_id == BPF_FUNC_map_peek_elem &&
+		    meta->map.ptr->map_type == BPF_MAP_TYPE_BLOOM_FILTER)
+			meta->arg_raw_mem.regno = 0;
+
 		err = check_helper_mem_access(env, reg, argno, meta->map.ptr->value_size,
 					      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
 					      false, meta);
-- 
2.52.0

