Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4C4657C2
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789921975; cv=none; b=YOyAUCwMd+zLXrQam1+FC2QAqg0WJfiJetXLScsO8vMCnCI7rPf4ZRH47ZD/eqH0dshEsYci1+gkX8rK3iJp2gk22sum96S5ZnRYy1N5Fr1VWCW7sHjzwf1xtOX+Az7LxOgg9VFA5hlV1QCNE9xFIlBpmb5sZiP2a6zkQVPi498=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789921975; c=relaxed/simple;
	bh=ISMr9k/4ayfp7cIsuOtuFI3mL3SoCez2K155WDMQWyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGHvwgoxDbDH9ZF4l4ZgsBhxs8WiYRETiW/mV2hSikX9JCgOqolhBKcM8k5XjV6XSykn/TBfn3S0toYKf/PJuJ7//qRrMXdQvtXAQubwrmh7wj2OIhaCpczwVXDumNUwGW9kGFOWVH9m9MPb/5LH85UTg0AjhmkK860OOG5Rv5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SB4EHrZy; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SB4EHrZy"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so19756525ad.0
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 09:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789921971; x=1790526771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VxrYw5XYqojCDttriJ4CNjE+Rxifl6ZmijYb7xfnw6E=;
        b=SB4EHrZydpEUlLfwAIrxMb/vSHzMILHeky8mJrePffr9xV/4uoNxd0IcWezRAtp6aI
         mp2KK8qQ6ud98djfGG8C2EpEDn2Dq2ClxMhmEb/NdpaZvjFw1SDgbtx5b6NiaM1ma7Q1
         YthFBhKJd9H7GrInfl4D6n0raeu89h7pOdGeQ2yhAi+yYxZ30f+QEaNwJH96gKBb9UeG
         izxgqDA+eu/plJfl9VPUI+GCCjJ4xK5Xtg9Gn+SrkELJSLDtrNYvXMRqwu8avXrpyFCi
         2urqYrT2e6/hkyjk7nu3j9t3N7n8HiYVKD+AksT6BMz15d8N05wbQtrn/5CDNtx+UgiQ
         NMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789921971; x=1790526771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VxrYw5XYqojCDttriJ4CNjE+Rxifl6ZmijYb7xfnw6E=;
        b=lE9MoiXXGzlhjZN7xFdyOrxhDd5EP348F6Tw5s98SAdeOPPPNU+MSUlEJA9Ruvlgol
         jdrDw1IHIoYRexPTngjeV6pXyeLUfkUU8cs1NN4NUJXSvMRLZF2XI8lQFxRie66zCtjA
         Gibs6XWEh/jhczJHyAaISZNZirJatjpY50cifDQu/xNTR+5hAnDDh3Oej0MusSA9WT7e
         vttnip+Us8u5C5IARlhisUtKBHg3FAa+wq1vuKT6EZQybd5gkYNWqHJ426UfW2b8n7Cy
         tuuOEV6JGIAOL/Hnu99BbDCnd3r2ZgULU3fIYAf9/8WReg0+ie88mQR/xapAztxSbx9I
         dmhg==
X-Forwarded-Encrypted: i=1; AKwUvByTDpvo5jEcM366/ih6RIca9G5bSZ+B4URMe6S+09q9k4Cs8nqeoo+eJOcX3m0k/VSUlM0=@vger.kernel.org
X-Gm-Message-State: AFuF++mZ3N4V7mcgUl2Mx1WowuaC3OvERvDafkzY4K3TRIU4BPzK+6Ya
	sexNveejax1rukfukc/MG8+XNre/NGoElf1WSc5DqU9EERABs23XlrPS
X-Gm-Gg: AYBFou08py43ypdpw/OirZ+7UBgFlwQ4TlLj6Dca/O9b9bsYYmqdq17uMoG4MTecWr0
	ssHoiUmJgVxtdnXmgERo4g9mA1PljrXxibUc13nLMzQNbAQt31RkwiEeH2wOtf6DxCGaKQfQ2Hu
	awdvvAR4qoYzqQOB4Oxb9c7pkqiy9yhg6LI4REE6/gfzqZKnxIPZs6mBK2K2Cb6DGoL5VGz/o+e
	RDIMqG8dZDnfHS/y+qyL09ppvO6s2abY4nzLG6rjHfTEMNZ0xB3x0Ml3dnFIJFNQs7IyEItLyHf
	hpZ+YksktrHyJxGVvtJeP8pnCwVBBMIWcz6HvUpcQKmZBv9qAzfB02IgEoq2s8PG27qjPmTi2Ju
	ex1c7jOk84W/wI8+0muMPxeTwueavzlPsFWZgLNztZRbZ7KzQEe24+BmBLkY0tF8taZSM9/WbNR
	hJwb0nSi2ICMFhEWcTmtRBQ1c376DMklMLx7gXxgyRJcEcf6bBdXSjdOMNJP0vOxTaEGjCDJwX+
	dV9yM5LaZHpZQ+KanSOtuULLPrM7KQQ
X-Received: by 2002:a17:903:380d:b0:2dd:c100:b2ce with SMTP id d9443c01a7336-2ddc100b384mr67923315ad.57.1789921970736;
        Sun, 20 Sep 2026 09:32:50 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17e17e0sm21784355ad.70.2026.09.20.09.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 09:32:49 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Peter Oskolkov <posk@google.com>,
	Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] bpf: propagate cb_access from freplace programs
Date: Mon, 21 Sep 2026 00:32:09 +0800
Message-ID: <20260920163211.795547-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920163211.795547-1-bestswngs@gmail.com>
References: <20260920163211.795547-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_prog_run_save_cb() and bpf_prog_run_clear_cb() use the target
program's cb_access flag to decide whether skb->cb must be saved or
cleared.  An extension program can introduce ctx->cb[] access behind a
target which does not access it itself, leaving protocol-owned control
block contents visible to the replacement and preventing the wrapper
from restoring them.

Make cb_access independently addressable and propagate it to the target
before activating a replacement.  Wait for wrappers which observed the
old value, and snapshot the flag once per invocation so save and restore
decisions remain paired.

Cc: stable@vger.kernel.org
Fixes: be8704ff07d2 ("bpf: Introduce dynamic program extensions")
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 include/linux/bpf.h    | 2 +-
 include/linux/filter.h | 7 ++++---
 kernel/bpf/syscall.c   | 6 ++++++
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e57af902560c3..606e7cf397af2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1864,11 +1864,11 @@ struct bpf_prog_aux {
 
 struct bpf_prog {
 	u16			pages;		/* Number of allocated pages */
+	bool			cb_access;	/* Is control block accessed? */
 	u32			jited:1,	/* Is our filter JIT'ed? */
 				jit_requested:1,/* archs need to JIT the prog */
 				jit_required:1,	/* program strictly requires JIT compiler */
 				gpl_compatible:1, /* Is filter GPL compatible? */
-				cb_access:1,	/* Is control block accessed? */
 				dst_needed:1,	/* Do we need dst entry? */
 				blinding_requested:1, /* needs constant blinding */
 				blinded:1,	/* Was blinded */
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 39decde7fc730..788c2d625db4a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1047,16 +1047,17 @@ static inline u32 __bpf_prog_run_save_cb(const struct bpf_prog *prog,
 	const struct sk_buff *skb = ctx;
 	u8 *cb_data = bpf_skb_cb(skb);
 	u8 cb_saved[BPF_SKB_CB_LEN];
+	bool cb_access = READ_ONCE(prog->cb_access);
 	u32 res;
 
-	if (unlikely(prog->cb_access)) {
+	if (unlikely(cb_access)) {
 		memcpy(cb_saved, cb_data, sizeof(cb_saved));
 		memset(cb_data, 0, sizeof(cb_saved));
 	}
 
 	res = bpf_prog_run(prog, skb);
 
-	if (unlikely(prog->cb_access))
+	if (unlikely(cb_access))
 		memcpy(cb_data, cb_saved, sizeof(cb_saved));
 
 	return res;
@@ -1079,7 +1080,7 @@ static inline u32 bpf_prog_run_clear_cb(const struct bpf_prog *prog,
 	u8 *cb_data = bpf_skb_cb(skb);
 	u32 res;
 
-	if (unlikely(prog->cb_access))
+	if (unlikely(READ_ONCE(prog->cb_access)))
 		memset(cb_data, 0, BPF_SKB_CB_LEN);
 
 	res = bpf_prog_run_pin_on_cpu(prog, skb);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c7bc9ba9b331f..43a29e47c8d01 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3812,6 +3812,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	if (err)
 		goto out_unlock;
 
+	if (prog->type == BPF_PROG_TYPE_EXT && READ_ONCE(prog->cb_access)) {
+		WRITE_ONCE(tgt_prog->cb_access, true);
+		/* Drain runs that observed cb_access=false before enabling freplace. */
+		synchronize_rcu();
+	}
+
 	err = bpf_trampoline_link_prog(&link->link.node, tr, tgt_prog);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
-- 
2.55.0

