Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECB639B4A5
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 23:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278607; cv=none; b=hXl/+QaYGmuwIjX3WCuTE5pHc9Pw/vXUVZBZ1AIBWnIVIB7tKcM9MXxYP4Bw4LnML1kUqlfPgcaALauKaBmOSIVqiui9/FmCy1PSro38RWsLz1ZD7MG5v1hf4z8gvbd3rbMp4VKOqDe0WmgYeChlTFgZDrqOOZP0QL2AvYKQ7aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278607; c=relaxed/simple;
	bh=DMc0RVpnuU2H06Y2GRg7qiWHvRaATd+YWQG+lAI7WN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuiSln/qH5Ruuwj2tZE+F0U6KyRJp5B/N1h9AMAN45gjQNaSXdd+ZBALXbWyl5NgNJEKdQa/9aR2aWVvo6vUm5J9RBRc/WbqTz8SKSENieNgFsZvsX5tzP+pi9hui7u3Xqo9aCIbcjop5ib7UxB7Kgjs0CmxsqjvooKLYm7COS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSQcaBgU; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSQcaBgU"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so693257a91.2
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792278605; x=1792883405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AEaziWLJa1465NJrsvoPKDCyJh648feHJpVrNnTBjDU=;
        b=TSQcaBgUEgzNGIT4MuxDivsToteSemLn8t3ibl8phF36Ao36cb1o3bHfK6mz5XIiD4
         /jn0hCPyikhOkOVjBe0RLBFO3TUdvadfB7LsiconQ+yJL3bRvEAPMGZZILTYJWOfmC8l
         Vy8+bpI8TtZtH0NTYnPtjBbMGSgYpK12lw3yOyeOKIUddtdfqThaKs6MT4ZIWr7D1upN
         9Ja51H26Ef7ESrCUaOEXXSeV/Sk297Fb6VCymkgRHgvpbVWKAidqMzEGWATlREH0LM4M
         NmcgxkDHofrIUi9T1464xzkdkNx3o8E/weSQgpuzG+OwaJnSzmoBSNLU3WUvrRGN59IM
         xZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792278605; x=1792883405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AEaziWLJa1465NJrsvoPKDCyJh648feHJpVrNnTBjDU=;
        b=HgSbWgFIgNH68JFuEV+O+ymsbHFLXmQ+QTNxSk9OO2Q6AvnYJ16x6DuKWpL8nZdxnk
         0vWP3gunqLaxCG5pReiFULlip7jsVW0mLK/tYA0l5xJUYrSdvXnyIgzyCMpQLTIDQFyh
         hWFXLfKm35e8D2gD4pN2rHqKlyo9MXtVSzMLwSqKkLvNZBuGU+iHvVZ0EvcRQbp4P7g5
         iCTmBHqfJ4yz9Zi/a6Ma7FRjdtEwlT9Lqy6d/Ma7qL0InQH4JPEMqnSp+KhAxbJ/X9SB
         qFg5ZiC+p3zmu3GC4mljlaK1oYZz4gatnLRuLJVCFUtJEgT0GimyfrbKiwv+X++B1Qmr
         n70g==
X-Gm-Message-State: AFq9FYIb409Qjb7YuyZEbrr+6NkQyCxcQ7AgSFV4wzs4RGWD2sov/Wdk
	D/ycxU1Tu1HIuKygnpUganQ9kzoYfD4G80zP1Yj4cAEnonZYoYMIkcrRaN1O2A==
X-Gm-Gg: AYBFou05p4BmRGFjxAIgOiA39BGlKS3ILuyQhyv8HDy1tAWEP4MBtsVHeWE0IrqiM+0
	LjRxdmTB6npDbvaRrRcd5gVf6X76uceHfrmjCx8JL5CjC4Mf5DaD+gXSk72vQB8mY4wKkVkzzzE
	RRIPjFXXWsQBloNPCl7jdKkHpeqcFt2dv2oSD/1lZX68TlvMM8pQDSZ6o9vDaotTHpCWYk2gR25
	0nq+u/orjoUODK1FVoKW2qKE2Df2PqX7p5v9vgpmusy0dhY4M22C9fF5tHpd9cmoFViUO0PMxlA
	lPJJTb84fQ7nWfmshj5maB8yyLPTdalZSCC6fRuo/65TkBO8wM0dw+H63U4vMhsK9WX/eZACsUx
	K8wwxmUJfAEJ68tYIvNWPKI63gtpQ0Dh0hr2DTLRxa2ePKsMHF5TZohGbK6CsG5hPdNOgmkxMoW
	fcmdMq3cMfjqZ+qDMuJrGp9NM74j6iSVA28yEoi2OCYnlJF1R3UaZaG3l1cN8NMQGjGroWDp5mB
	46f4ZLe3E4vofJ9wYwpEMqWPvVlDjxtWSaB+LRht5Y7efv+TLfFprbWGK5uyY2bRF5eoTrhKtqP
	kZoubIQm/urWfHpzsHqOH76/R0PyQh1CN9NcEDhlQ7G8
X-Received: by 2002:a17:90b:5623:b0:3ac:9a54:e3ce with SMTP id 98e67ed59e1d1-3acef6391ecmr3324954a91.63.1792278604779;
        Sat, 17 Oct 2026 16:10:04 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc48e8646sm9268195a91.10.2026.10.17.16.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 16:10:04 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v3 02/16] bpf: Don't let an extension reach further into the context than its target
Date: Sat, 17 Oct 2026 23:09:36 +0000
Message-ID: <20261017230950.802052-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
References: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

How large the context of a raw tracepoint, tracepoint or syscall program
is depends on what the program is attached to, or is run with.
bpf_probe_register(), perf_event_set_bpf_prog() and the test runs compare
that with max_ctx_offset of the program.

An extension of the program, or of one of its global functions, gets the
same context.  How far it reaches is noted in its own max_ctx_offset, which
nobody looks at.  On a tracepoint with one argument it reads the stack
behind the arguments, in a test run the memory behind the context, or
from NULL if there is none:

  BUG: KASAN: stack-out-of-bounds in bpf_prog_954b5d2051843629_ts28_ext_far+0x7e/0x113
  Read of size 8 at addr ffffc90000def7b8 by task ts28/104

  BUG: KASAN: slab-out-of-bounds in bpf_prog_954b5d2051843629_ts28_ext_far+0x7e/0x113
  Read of size 8 at addr ffff88810712c3e8 by task ts28/104

Refuse to attach an extension that reaches further than the program which
it extends.  A program that leaves the context to its extensions has to
touch as much of it as they do.

Fixes: be8704ff07d2 ("bpf: Introduce dynamic program extensions")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/syscall.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c412bcd1903f..d026ab779ce8 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3851,6 +3851,19 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		err = -EINVAL;
 		goto out_unlock;
 	}
+	/*
+	 * The size of these contexts depends on what the program is attached
+	 * to, or run with. That is compared with max_ctx_offset of the program,
+	 * and nobody looks at the one of its extensions.
+	 */
+	if (prog->type == BPF_PROG_TYPE_EXT &&
+	    (tgt_prog->type == BPF_PROG_TYPE_RAW_TRACEPOINT ||
+	     tgt_prog->type == BPF_PROG_TYPE_TRACEPOINT ||
+	     tgt_prog->type == BPF_PROG_TYPE_SYSCALL) &&
+	    prog->aux->max_ctx_offset > tgt_prog->aux->max_ctx_offset) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
 
 	err = bpf_link_prime(&link->link.link, &link_primer);
 	if (err)
-- 
2.55.0

