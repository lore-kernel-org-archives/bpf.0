Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842811;
	b=zJ2X2td+qxrXRFSvaL6aHsEse9leaX89b3oNTsiOVLDh2848J0kdXwQjtJsXJCPaFoeb
	 mO/0SJRJUhb2qFisqW5sRe6NBedDnSYrMwb25b/FAtFpOaP/8/M7Xl6Jt6E6Fb6mn+g7I
	 NGuFjpFTc2yfqgi1QTpigoKgXiwznpR1x+SWDGuLbshd72/LLRM/F8PsLBHoX5o0eDgb2
	 mkOgxFUxlufELVwz2cU35Wbnty103wFA4rkoqKfvWvKiD6ERO0ZK8+pJ+9Nm/gLJmDygs
	 ynQadsD/yBFB4fLmOByNnOXZsC44BOIODa5/rJjfw0Q3YG5aJ+tBHPF6tKFi6/vCb+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8soXgHjoKC02lpqX/lqyTqwN/XEwXScvVdFV+nIPCqI=;
	b=hBfs2jrsjZjKx93hDTTZSpGgU4s0LwqNJ8IOshtP6aj7c6DEkvDiHhnzUQX39BLePHBM
	 cVSZArp3Z4E9cwIYVuDKi0ujXBg2UnNwMZPeyLnMux/QV987JXiCrjV6xEKHuoN+27L0m
	 91eu7anSbKEA9mxGMn+gtMXaBCX2ITePm2t1PrzSvNAKGv0QXR+nMD/3FH3gHvwyQ+ANh
	 ipC39nDMAR3V/luZ/Tlmc9KfJ/46b36uwa60+VbePqXQubYIdsJtRizGDrzhb07mNHPDF
	 r9361WItP0jP0sBEbu5SLYRdmg7gpJlBkRAxXjMncP82ZRItZjzTM6M33+4oOqY3StA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H+iJ0jxK;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED91606A322
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 15:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ED91606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H+iJ0jxK
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so3083736a91.3
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 07:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794842811; x=1795447611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8soXgHjoKC02lpqX/lqyTqwN/XEwXScvVdFV+nIPCqI=;
        b=H+iJ0jxK6kx0tB3DpKxZh/IAMsLek3BB20LvT8eFdk3wQBCKEBMWmOvuH0CsW7rL/D
         1fm5dLHYCW+HBp5EMtS+O3HL+iwFCyiKg1ehp7k/ujE4Lxg8ijJLrFw1d/Sv/trBwDrc
         PEuHNMWaq0S243bmrVuhB9y1RhF4DxhRApLlDMfbWnITSsiCnBZuxhQcAq+kg/ibFgdY
         zO3tDtdGBwnbl+F614NJnV15oXina2rjKTt+Sw0eO3HmJQ2eEGr5nUIabwcEY0K4K4BK
         vFkYrSqeJcHZSrFTDR4mxXCPMQsv0RtJBrTpV7oL9ZavP/rBbJySi5mUBYWM2svev0KW
         Zx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794842811; x=1795447611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8soXgHjoKC02lpqX/lqyTqwN/XEwXScvVdFV+nIPCqI=;
        b=ecnbPyd5mSSHZTjZTbb1FMsIItrIRDRibVF5a/LwC8/BvwOiZY1IOmpL6XgArZeHX/
         cu27fGoW8O2X0547Hlla2KAouTCAImhxo1Ui0pizrn5vM7ZZ6/Cfe4cAVT4C3dAS/FwB
         /T61JVimmcEi6PI4DW50/byInOtJdJA13nPT89OR5/HUcjmPpQXzfIptpcx/psyrH9ty
         sIWcaaZIUjmm2jIIc68YBhKzSdkPbGou4NWXlw++RAEvPgx8EmzbRsCuIfTd4YL23+XQ
         luzn/V6kh1fNXmgbZhwYtwJLnctiWVlq/qF4axH5hEb75LyJqDMoq4eweSxU+cdXUIav
         IVYg==
X-Gm-Message-State: APuU4Z/5QEcKeG/q7E/fgbBnFC/vVjV8jjMyRU9SqVasdhI4t5L1Y1Vt
	7XwSaMvFAlDbbXjU6ZjHjduIrDPi/gdb4jeTQ7yhGgr2yzKm8Fddit3sx8lM4A==
X-Gm-Gg: AZFdTZfV+FfL6ziLhLFWq69P7i4Kfc6Lak0Mh9YOgTCl2uA9q9dcZLeI14nFuvtPy93
	sz4XEruBU58LAhXyfI4vApcPp7Q69azr8K6qco0vw42fnlliWmOtfr3B/t4C3JOZj69T+xK3lzn
	fUfuijlo+h58F9EFpI/nPKkpqMHFtAkElmB6p0wLMFLZuv9lsDORq1kYo7XtrTxrHQWLve+3wvT
	Qf7+bYgXWC2SIYhU4A7sDQXo/NzoUKXTENnMO2O6wxGNJn1jj6gRAzRwKHVE7zqoIaNcS1GgUKX
	wJtppCGO1uIWnf3Vuo6N3UtU1AqlZgMzJfO6FrmOLDlyUj8hOIrUTMJDsdAeZ7QJRoAxTW0hDdT
	43PeaQRc6WK0qdd2Up+7jKYrtDXAhuNF4gEfBKYC/IOtDtDbBfmYJsB2QRVPl9rkzM6OSXsVH5B
	rFyaiAsSm7sLJAh9If1Wu2weyOIB5xvOg45vMeZ4DNhRki3iqoIaQ0HMh2V3ww0NG4XjwOKYk5U
	e4x6quYImjyQxOlL3urXv1dZJN3aV3vLZQlCtPDp+doQClhqVWLNb2D7tx6Hj+BUYAH99AIXEGT
	Sxq2Rr7rri334gU4fLMHCPAzPch18hN8zqN//FMo2LrpBF2hh426dnjc7zV8lOGdKEpjh3Rjtj5
	k6LXuGFTuPm1PVonO2te72vpnh8Y/fCmlPjhZkJesP5ZSU1DITyhZUWgpxI6SBhNXQ/qTIyXEnw
	==
X-Received: by 2002:a17:90b:586c:b0:3b0:ab34:afc8 with SMTP id 98e67ed59e1d1-3b1b0b67f13mr9529493a91.20.1794842809639;
        Mon, 16 Nov 2026 07:26:49 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce556dsm22413174a91.6.2026.11.16.07.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:26:49 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 03/21] bpf: Give a syscall program the largest context when it does tail calls
Date: Mon, 16 Nov 2026 15:26:08 +0000
Message-ID: <20261116152626.4032587-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
References: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
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

BPF_PROG_RUN compares ctx_size_in with max_ctx_offset of the program that
it runs. The target of a tail call gets the same context:

  first:   bpf_tail_call(ctx, ...)      max_ctx_offset 0, ctx_size_in 8
  target:  r0 = *(u32 *)(ctx + 60000)   out of bounds

The target is not known before the run. Pad the copy of the context with
zeros up to U16_MAX, no program can use more. kern_sys_bpf() makes no
copy, so its caller has to pass that much. An extension cannot add tail
calls to a program that has none.

The copy is accounted now. It comes from kmalloc-cg or vmalloc, not from
the caches of memdup_user().

Fixes: 79a7f8bdb159 ("bpf: Introduce bpf_sys_bpf() helper and program type.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/syscall.c |  7 +++++++
 net/bpf/test_run.c   | 20 ++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index eda5d8ee8e3f..844b2c2951c6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3859,6 +3859,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		err = -EINVAL;
 		goto out_unlock;
 	}
+	/* The same for tail calls, see bpf_prog_test_run_syscall(). */
+	if (prog->type == BPF_PROG_TYPE_EXT && tgt_prog->type == BPF_PROG_TYPE_SYSCALL &&
+	    prog->aux->tail_call_reachable && !tgt_prog->aux->tail_call_reachable) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
 
 	err = bpf_link_prime(&link->link.link, &link_primer);
 	if (err)
@@ -6669,6 +6675,7 @@ int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size)
 			return PTR_ERR(prog);
 
 		if (attr->test.ctx_size_in < prog->aux->max_ctx_offset ||
+		    (prog->aux->tail_call_reachable && attr->test.ctx_size_in < U16_MAX) ||
 		    attr->test.ctx_size_in > U16_MAX) {
 			bpf_prog_put(prog);
 			return -EINVAL;
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index d6c9dc62182e..cc3236e3c0c4 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1687,8 +1687,8 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 {
 	void __user *ctx_in = u64_to_user_ptr(kattr->test.ctx_in);
 	__u32 ctx_size_in = kattr->test.ctx_size_in;
+	u32 retval, size = ctx_size_in;
 	void *ctx = NULL;
-	u32 retval;
 	int err = 0;
 
 	/* doesn't support data_in/out, ctx_out, duration, or repeat or flags */
@@ -1702,10 +1702,18 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 	    ctx_size_in > U16_MAX)
 		return -EINVAL;
 
-	if (ctx_size_in) {
-		ctx = memdup_user(ctx_in, ctx_size_in);
-		if (IS_ERR(ctx))
-			return PTR_ERR(ctx);
+	/* the target of a tail call can use that much */
+	if (prog->aux->tail_call_reachable)
+		size = max_t(u32, size, U16_MAX);
+
+	if (size) {
+		ctx = kvzalloc(size, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
+		if (!ctx)
+			return -ENOMEM;
+		if (copy_from_user(ctx, ctx_in, ctx_size_in)) {
+			err = -EFAULT;
+			goto out;
+		}
 	}
 
 	rcu_read_lock_trace();
@@ -1720,7 +1728,7 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 		if (copy_to_user(ctx_in, ctx, ctx_size_in))
 			err = -EFAULT;
 out:
-	kfree(ctx);
+	kvfree(ctx);
 	return err;
 }
 
-- 
2.55.0

