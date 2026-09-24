Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDFD4A6CFD
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269095; cv=none; b=sO8YOD7Yy4GdS267Ka6X+eerGLSVBfAww1G/4gF/8GqkrotB4k/rywCH1za8RpqHgZTlej159nwhepUgpQDq3EDqOaub054lDUvmzh6D3HlRhW5EmkgcQeos7yJxYixm4TOYmlfg1BbnJQGk2VbR+qOSWIv9qCLSF7ttKaG9jFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269095; c=relaxed/simple;
	bh=U/KQK+mGcwm15vmILO5grbzLv5vcM8YTr3KCsLA+QFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZzBsUj9ZqrmpI9A415Zs+AUmEp0zw4UP/8d5IipXw7ONv6F/yvFGCLrmLrdvaoGj0Vmh9/I0g35fFYs+wCN2PmFAclLZpMw3miezyUF2cTpqODvAVsRx1WsGXOy4ZekLC6+OecRe8uMbPSzFCej7U5CN4zoin/RJBsJPjqBUhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKmt2xLh; arc=none smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKmt2xLh"
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-4887965533eso6351f8f.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269092; x=1790873892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OUgiFIYiXSf0MuYa9e/7EinspObwu2xcWzkgjwvyfcQ=;
        b=lKmt2xLhV2z6D+OYcViJUGeFmIvvdAYu7SS7kZC1d7oWCLBSjk4G7si5xKRKRPU5Ab
         G0GplJ/RMOcB1ZBi8P+2dyBveR1EW6u7Oh606xQw6fvUzzQd3cHwq9o9L4wboMwPQ8pi
         DvEa9fAEexT123wZmSjsuYjb9RaHOvKADaclIpYJ4Igq5mq3rQWglM8zdx/sIj19T0Ju
         o/jT+gbNpVaoDVRUk3Viu5atvM9VwKGeNPzq2BcKw9L24OO8ymD+werxJPUqzMVS6r+r
         FDy5n08FY9ngS/cvAaO87thSKLUF05kQEIXoWaQ4W56iBSracDKz7002YxqKMJOeDvQ2
         5kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269092; x=1790873892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OUgiFIYiXSf0MuYa9e/7EinspObwu2xcWzkgjwvyfcQ=;
        b=gqi+qcV6vApoQo0i01VvdVSFhrvRac1WF04/M5B1jlsk2q7Y9tudUQ+wMfZO3zlym8
         wsqjPWQHNlrklsbMMC3YBgUhN5IQyfrJD2yfTLGZY/I6DjoeBbJEWlhmhAKG4jE1LJrx
         LZZo07m8LrOxpOlJ8WXZ+eosszqC8cPLfjXgmh85iZmfSG4ppGIFyeUCE0wGn9E/UGKt
         LDMTr/JveulDyUGafHEWB0Rd0WZqx/+rt8tuXjjhlvGbE4pS+ULy+/a9zQiaLYA8atST
         g64DO5lqmigSIxiZsWjpVnXxk+G8qc5lCOQwU1oIlrEfEYzjSpNagIyriEFy51HFB/N/
         nCKA==
X-Gm-Message-State: AFuF++kgyFnIFBcCSKHVic4BFxjyj2TCn88c3HFJDdqtrIm7UUdOVg6M
	+C+hx6l17ZRVw03m6/D7zYU09WG8/Xpy2ZSlxEEueOD/B1kFFGJH+5GMaPDQT63A
X-Gm-Gg: AYBFou0qCdSw17YOZRlDzXMJdMgq8fY0jKDzDXkA9x1biKm+HF+eeTBpKfQSXIKBEq2
	jxwhCmDKXvWwq8dWflatrs2xol+tQJ5cvPMyHRG2YTxSlFSeYdT90v4yc5cKJRVLhYVAjd5iyu7
	0SvJkEkQYmKkUB0dZgQQAcO0ibY7ODBGp5yWTOaExZYrvj4x2WgXvKr+0e7GDOA+2lkQ3t49/Uu
	SGWld6N8pL1pEsEFjlChmnW6XKUQiP1ssT/E2l3eqQgBQSGXIyAKKWb1C4g6jkUJ1PrB0Ef+pdF
	5dVIiYRyxpIGuS9+NDUDAZ4pIpyGRPw8VQudjEU5JYpM12mxjexUUrqxlA8PzilXnr22QtEGkwT
	DV+Qogun+EUESjorO58Eb8OICTWHgjUdUX/268U1QKepSE+g3Pei14A7HJrrWgNGGwuOFnViT6z
	y8csmKBEPoMkXqL8ywgWKxmbrjqk5VfDk404p506kKODlEg/A8mC4M0/wnZjc0QUFGAZ32x+GBB
	97Aj1xppNcWlFoj09zfdnsqRBjDW287IkHfUKoliPMKuTF5RK7ZdWCNC8LfiNdflkKr6pUclgfm
	ytT7zuNiOCTxu4RfFefrhS9nVuPmX+9ptDZZCw==
X-Received: by 2002:a05:6000:1a8b:b0:487:cd:f1ad with SMTP id ffacd0b85a97d-488716a79acmr5353711f8f.45.1790269092363;
        Thu, 24 Sep 2026 09:58:12 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm370351f8f.12.2026.09.24.09.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:58:11 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 17/18] bpf, arm64: Allow programs 2 KiB of stack
Date: Thu, 24 Sep 2026 18:57:18 +0200
Message-ID: <20260924165740.2146806-18-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924165740.2146806-1-memxor@gmail.com>
References: <20260924165740.2146806-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2964; i=memxor@gmail.com; h=from:subject; bh=U/KQK+mGcwm15vmILO5grbzLv5vcM8YTr3KCsLA+QFM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtraEnyPkGTaWs6ezoYjTcr2RWXKGs1HRbJFzm+aBfX3 2s/5zF2lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCIrKhgZelJmW+xbIh92KVFP bpEyY0XP7Ti7HxZcpd73bavVnQR2M/xinrB5W4r6r4uaYe3xIYJHPh+4nCaWtN51qucp+Uvzbpa yAAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The arm64 JIT sets up a frame with an add/sub immediate, which encodes
up to 4 KiB directly, addresses the BPF stack relative to SP or the
private stack pointer with offsets that fall back to a scratch register
when they do not fit the load/store immediate, and a tail call pops the
current frame and lands in the target's prologue before the target
sets up its own. The exception callback reuses the frame record of the
main program and does not depend on its size. Report
bpf_jit_supports_large_stack() to give JITed programs the same 2 KiB
budget as on x86-64.

Tested on an emulated arm64 guest with programs loaded and run through
the raw bpf() syscall: a 2 KiB frame, a 2 KiB frame with may_goto, a
chain of four 512-byte frames, and a tail call from a program with a
2 KiB frame into another one; a 2056-byte frame and five 512-byte frames
are rejected. The selftest suite was not run on arm64.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/bpf_design_QA.rst | 11 ++++++-----
 arch/arm64/net/bpf_jit_comp.c       |  5 +++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
index be5fc4ac00d6..98d70b8a2533 100644
--- a/Documentation/bpf/bpf_design_QA.rst
+++ b/Documentation/bpf/bpf_design_QA.rst
@@ -223,11 +223,12 @@ Q: How much stack space a BPF program uses?
 -------------------------------------------
 A: A program may use up to 2 KiB of stack, combined over its call
 chain, when the JIT of the architecture reports support for large
-stacks (currently x86-64); a single function may use all of it, and
-every frame of a program running on a private stack gets the whole
-amount. Elsewhere, and whenever the interpreter is used, the limit is
-512 bytes. The verifier computes the actual amount of stack used and
-both interpreter and most JITed code consume necessary amount.
+stacks (currently x86-64 and arm64); a single function may use all of
+it, and every frame of a program running on a private stack gets the
+whole amount. Elsewhere, and for programs verified for the interpreter,
+the limit is 512 bytes; the interpreter itself never runs a frame
+larger than that. The verifier computes the actual amount of stack
+used and both interpreter and most JITed code consume necessary amount.
 
 Q: Can BPF be offloaded to HW?
 ------------------------------
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 44e3a9e683e8..475e70653454 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2503,6 +2503,11 @@ bool bpf_jit_supports_callx(void)
 	return true;
 }
 
+bool bpf_jit_supports_large_stack(void)
+{
+	return true;
+}
+
 static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_node *node,
 			    int bargs_off, int retval_off, int run_ctx_off,
 			    bool save_ret)
-- 
2.53.0

