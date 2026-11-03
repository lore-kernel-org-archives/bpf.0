Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749459;
	b=0UBPm+O3l8v1SAw5MSoOFNql3JGti7pj4lhc+ohagjBuhx+VbbLzZozus5eTjOLcHvaw
	 FoORCaetpZfh0AETxWh8N/rrPUrmamzLgpOnO9JT+1KYXMHvn+gl+8B6idW+1ztDR4Tu/
	 bQFx0VEL9htpf7SNCPdHMYiuh3QPhS1R/Pfo7Fz74IclDU0NVxW5JfK3Fo/LPIkMWYlfe
	 rEQ4o0R8Z8KA5Vhx2a6mVDH26BAAvHhhvtf3gDpSzjSUhgqo4UoQpZu7HjaKXS4Ri4HPe
	 wFeao+IeNRvzSWLiwl43l+W+KhkQzR7ZsCMcT8ATaMteZDo7fZZ+kahOWeX1h6lKxVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=803ZrwaW93py6bRHt2i/kqU/i7fQFSSZtSBHVNdvhdE=;
	b=UB1Esg6+874bMU55BKuddFSTKdBxYOv5hcWhkUsxMzJ+KHZwnfgUK1L9kYK2N1JL781s
	 Jbd0fm0p24Qr+lAJKGJt425BIBzDg307pi9svJr2ZHJVdM6/WbYjb5mqnrP5Ck2jvLwJp
	 SWYGE33TXNRHJur3eaErnT98HQlQftAg+AEoCT70ee0lavV13TlqUXMhUfoCTrjv1IV8/
	 S0OHPmD1dDeq5l36HZYqUCMCoNOJ82YK3H8iGGaHmAaT5exJFUeTFHZ7tq1xmJVw/jGWD
	 ZUBtmsNQ9gedAeq/ji6riwGLL+c7PFO71nlrTQ8fhPdn/ElohtrATg42dgyEAgnioKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bMAF3/VQ";
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130CD606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 130CD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bMAF3/VQ
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so120898a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749458; x=1794354258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=803ZrwaW93py6bRHt2i/kqU/i7fQFSSZtSBHVNdvhdE=;
        b=bMAF3/VQaH1+wthY6ltlBTPFqdcm0xL2jG0M7pqgbgLnYclxtqKP0S29TKgPpsl1DQ
         xSKM9T6O33p6e0cks5V32f625/b9Xr3ELco9X9pZRfSa3QjhDeOopv5vefjCzETDvrSh
         y5rJW0YluDEUEDM/5m5JJH3QijlHdUsT518ww6uIRvBlypLN43uIg3a860KQQrVZjSZx
         TqCPmHWqobkIy9P5/l4qO0pdlNB7odVbjhmRVpKyzcCxEvfsC1+iN8jmEO3L7kf5vPDD
         xVcnSWyM3xzBTZl/kFsPYXjAGyWGuGt1zjJsrfV6nC/tJtlEEtOYB6Vj9Ogt//Vv6+7A
         YdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749458; x=1794354258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=803ZrwaW93py6bRHt2i/kqU/i7fQFSSZtSBHVNdvhdE=;
        b=vzFv63gnrQ1zMDSVg9EMU4x4zoPrrDEbJ0D9pt5fwh/WqJYzThT0vr0FKxg7YMX62Q
         zoCB0Z6tXmuUc78cRyJFnXizUMq9Q+EwraJTAJ3+VNW20QIAI/8TD7jGkBzTvjgTNgbf
         C0R+EUjMqrISxqgk97fnCGk/FJMa7hptUtT5sXQytXkcN6yYhEi671H9G2LJ/akQsKB0
         lYPaZm40AgkM1vOhEUuXNaceJSvQOclbzCgYD472bAWGhVY3jUgO71s0ZMhLnfM9xMSj
         oFknrCGd64cJcGeevxIaWOINlPr40Lx0IXCTKa84Gou6s8zCPyB4oSTjVadrtjxiXyTR
         tYdA==
X-Gm-Message-State: APuU4Z+NJxEe+FUdRCItVQ5BHqIxQD4trwovfhs429WArO47PTE0yQlT
	9zRYtUXNXZklvFq+D73LRE4GyYo5lwFTnh9JfaTSptkWgm34Vjs/gJPPNvEP/A==
X-Gm-Gg: AYBFou1TVMD0p1aelYGZpcV469wW5yoTmB1ydXKEgHWBXrTOcwU2pMtaovLOriaL+mj
	qALi7LUd0d6n3Pgf71sSpJsxLQ4it/BE3T64h7U7wijk1QWBiAg7PAj1LTTGaCHlrqORh9OV/+L
	zEDXNMJfTzYCdBDx0GinJDh0fGMg37edYcCDPn6PjvphDePDCPhFMO8RajYAKWp+MSZrXadgalr
	bW9gu4Gw1ZmAsM0wj1W1nfWO+ymZ7aCH7RNvmuOG3Uo1n/eon/kk9eTQRGSteSmpzCBa10A4zqb
	2XFB0EPdR3VzwEjmOtajBL3MIesRIHUcTJw+JgeyZev6gp+g1wOp6pZNiYG+0LatTp9SBEqhEyd
	F6GvfKUVXEgWwBNFy/2rXEc0T0ENuSUY21wuRKbM2FOXIrFVobX2c+FotYfv7r/3D+PXSMFrxsj
	G+0ao5JvSNGhmjNb6rcH/9smowxad/2SxD225Bnt9jrH1wVzEMQIL52ZQMXN2sKoAjlApb96ahI
	QZLToW4LJoFiRBsuefOabQh8GsrkfXJybKdwgHd8Lgs+FSZ5XqV7Rl609I2WJ23VgsjSnfrtXZk
	WxuBqkeAd3PsSBYDPxBYyoG1uSUXfmurlcOg2RK1xHN45psKi1Cut26ndDm7j8uTEj/vj1INNW4
	7E7AqUq/HXqlh8nFXC7H138OatyDCJDebZOBPGbhnwcayJxNd9/HYl8HvhImC7XzS9hupJJlha0
	o=
X-Received: by 2002:a17:90b:2891:b0:3ac:a11a:7c8d with SMTP id 98e67ed59e1d1-3ae897d5fb3mr10743485a91.59.1793749458180;
        Tue, 03 Nov 2026 15:44:18 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09445f7b3sm1048621a91.5.2026.11.03.15.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:44:17 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 32/37] bpf: Allow BPF_MAX_SUBPROGS targets of a read from a table of functions
Date: Tue,  3 Nov 2026 23:40:57 +0000
Message-ID: <20261103234104.208239-33-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

'tbl[i]()' loads a pointer from a table of functions in .rodata. When i is
not a constant, the verifier continues with one state for each pointer that
the load can give. It rejects a load that can give more than 64 pointers.

Rust needs more. In one prog of rust-bpf, fmt() of a trait object has 245
implementations.

The limit of 64 is arbitrary. Raise it to BPF_MAX_SUBPROGS. A table that
contains each function one time cannot have more entries. The array of
targets is now too large for the kernel stack, thus allocate it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 93ca0126a310..d503dc7cea1f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7068,7 +7068,7 @@ static void mark_reg_func_ptr(struct bpf_verifier_env *env, struct bpf_reg_state
 }
 
 /* a read from a table of functions branches into that many states at most */
-#define BPF_MAX_FUNC_PTR_TARGETS 64
+#define BPF_MAX_FUNC_PTR_TARGETS BPF_MAX_SUBPROGS
 /* and that many pointers at most are next to what is read at variable offset */
 #define BPF_MAX_FUNC_PTR_RANGE 4096
 
@@ -7114,17 +7114,20 @@ static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_stat
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_map *map = reg->map_ptr;
 	struct bpf_verifier_state *branch;
-	int subprog, targets[BPF_MAX_FUNC_PTR_TARGETS];
+	u16 *targets __free(kfree) = NULL;
 	struct bpf_func_ptr *ptrs;
 	u32 i, cnt, n = 0;
 	u64 o, lo, hi;
-	int err;
+	int err, subprog;
 
 	ptrs = bpf_map_range_func_ptrs(env, map, min_off, max_off - min_off + size, &cnt);
 	if (!ptrs)
 		return -ENOENT;
 	if (cnt > BPF_MAX_FUNC_PTR_RANGE)
 		goto overlap;
+	targets = kmalloc_array(BPF_MAX_FUNC_PTR_TARGETS, sizeof(*targets), GFP_KERNEL_ACCOUNT);
+	if (!targets)
+		return -ENOMEM;
 
 	for (i = 0; i < cnt; i++) {
 		/* the offsets at which the read overlaps with the pointer */
-- 
2.55.0

