Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B774438DC44
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255239; cv=none; b=CJXJIUpTmYwWp6Du0mPzobXvNEaRApT2A44FvI9ASjpH/Xh/AQnxMWf9QuqaAwNjAhE+mVDZ0vKZ3dLVXb2c2w6/qUnljHPweu+ecHu67KTtOQ1esIUTECTdECFOPx3K+hrEs+TPrTtrOHU1qy4PTmRDaIYhFpFYZkxOz/rO0Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255239; c=relaxed/simple;
	bh=LInPVHvbYU0TGNIozpTFRcFgntOfFRp+YJGP5QIZIwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqwtAYClocwHNKsfG71fTBA6utLIzxPy8TsSFiiZsJk+yC3IKJsKcp5A2TkWBNFlxYW8TjAEs98WsksMAFV+lYXPgyvW9vhCBxPiyKaEJHbHHMU10OlvMXze6I0Tgyc9RHQwgX51kKWcaqWc0a4hSaWsJzi2u8EH8s7YY9TKuds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQSgQkPH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQSgQkPH"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e987a2ba0cso6135325ad.3
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255238; x=1792860038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ycFcAXAF2bqJk9ipDiEaIXiHZnKOU+kSnggBV2CR5LE=;
        b=QQSgQkPHy0cm9fqE3+bJrU2wI53iQWZdFkzgGvF9cvblk9A1NV6OK+aJYrJitioyrW
         NqwKGFY5OOgQjpcrZQwICp6M94CXa8IHzZzw4YbKVbCh5FGYpR8a5Qh+a23IlMCAZHWI
         7Bl0EGOSxG617kmtV/vxxp2+N3lgVk1ZGp8HXe5Ypeqtt563b4YArSzXkEkFpRMYcu5y
         mdUy4Ch7Cx0tkdCmbRHnmSPZweYQ4X8DJ177bd9wUpQMB5zRzxyh5Bx+98JQfZwGrWU5
         9/dzkMsP0tji+QW8+9tGqB2HrKzDBD8RBFz9mJbk43hU6ti30tdA4E1uoblKHjANM9el
         DRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255238; x=1792860038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ycFcAXAF2bqJk9ipDiEaIXiHZnKOU+kSnggBV2CR5LE=;
        b=Moj1ACCE7/Vq0yBJ1L/4POuanjjznLAw1jwKbkcoezYwGyq8Th6DNzRcyJn+FIa4Kk
         2tqziuzrN1ERAPumreQ7OM5EZj2u97MfnuXUPtdHNkldGTRVO9Tes7r/3h8VQnLgNOrQ
         XEpX40UoHC7C6OzWkdJB4tF2PUPSgo71yjiHd/lB2E88Z3cWWHytNnmzVfRq5LU6vMgU
         Iv5PSLKzTN968VqEW4vdKA3I9NwkKZVB1vQOQJ9/4K7IDvCXQOdF9PkOsRim24gV/fNS
         YGzBoapwtnSNpDf1AJEAHQKvWYWCjwB/SnMYDmE/issgyMrhND2lEFbUaJPC7Wx09UH8
         ubyQ==
X-Gm-Message-State: AFq9FYKT2hSiyxx2yYKd+ec9N+vv+CwRa+FdJL5N67TviVY2/HgbydcN
	/yeA1Z7X8/2qXXGNt275/vdWOI50ZHIDvv+J+Lv0xs6zjTrga6dfupGApUQAIw==
X-Gm-Gg: AYBFou3T/gaNmRYE51totoAMw0wtIVLJSmwZqFTty1cf8C2a31lUsHSafCJbaGEZmUC
	9hRxi/Rlbv2kSMCZk7XWckCQyFwW4kzpb4lVQ0pf8mzjCDw601hHxusTOl059k4R6qSJBwVEDyF
	zh/J1J3YLcTGuILhbMGKk/PM5YlVqDRb1seD/gPaki242ZwC8THeZCSF4cH29fVeajnw52F6Odh
	ibK5HwvGPlkxJfi8uN0f6gLBzMQnwGw86ys4/+Q4UENNydC6WZu6nipO2oh8TSaLZK6Zcae4Xcy
	th1NjwTuJpnZGWReUgVUz8b6SrKycNKYS4udPzmnS2TFKZRauSADd3iiQAkoDLpmEdAw4qtjcqD
	nT6pDd+O+2p0zicOKr1b/7mN5UGgwG+nQbwxPQHWqMNwMceXwGtyO0l44JjgQPUWgDDtU8PWYuj
	AZ7vl754XaCp/L3f5IT4NT9StByySf7Lbqy8QW6akwanlI/i4J4saehVTEEvVRexbOWCvPDDjjy
	d+tFD+4E+0l8Yil8+SP4e1CqHsry34orUx9biufXgn0b8bnNIFWG+C6cac2bD8Qzi8u88g+HUWG
	ybadwftnJ0PVM+uV36gh3bDXOh26P1KYQ7SMWF++qXY=
X-Received: by 2002:a17:903:19ef:b0:2e2:bfe8:aa7e with SMTP id d9443c01a7336-2e9a68347e4mr29692205ad.7.1792255237949;
        Sat, 17 Oct 2026 09:40:37 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804becsm22336215ad.21.2026.10.17.09.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:40:37 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 28/43] bpf: Don't take an extension for a writable raw tracepoint program
Date: Sat, 17 Oct 2026 16:37:30 +0000
Message-ID: <20261017163745.3341787-29-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

bpf_probe_register() compares max_tp_access of the program that is
attached with the size of the buffer that the tracepoint lets programs
write to.  An extension of that program, or of one of its global
functions, gets the same context and the same pointer to the buffer.  What
it accesses is noted in its own max_tp_access, which nobody looks at.  So
it reads and writes behind the buffer, of a tracepoint that may have none:

  BUG: KASAN: stack-out-of-bounds in bpf_prog_5843f2b820eb4929_tr26_ext_far+0xf4/0x10c
  Write of size 4 at addr ffffc90000d8f894 by task wext/103

Refuse such extensions.

Fixes: be8704ff07d2 ("bpf: Introduce dynamic program extensions")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 81660ffce99a..0d1b729989d6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22232,6 +22232,15 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 					"Extension programs should be JITed\n");
 				return -EINVAL;
 			}
+			/*
+			 * How much of the buffer of the tracepoint is used
+			 * is checked for the program that is attached to it.
+			 */
+			if (tgt_prog->type == BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE) {
+				bpf_log(log,
+					"Cannot extend a writable raw tracepoint program\n");
+				return -EINVAL;
+			}
 			tgt_changes_pkt_data = aux->func
 					       ? aux->func[subprog]->aux->changes_pkt_data
 					       : aux->changes_pkt_data;
-- 
2.55.0

