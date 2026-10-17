Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ED63AAF73
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255233; cv=none; b=tfkLUxSNOLazKD+Eb+sGquF3tz3bG9cz9GCLsE383SMaY129ihuXou1LXjggWmfrW0qtJiobAAhb+zAJf6eis0ryTkUeMjS20lvmvAGg0VT4VQx7ghT0W91AOsm8xsNp/tcB1MuD1V4HuykIvWZprv5LKRdQW1t8O+zNYV4K22Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255233; c=relaxed/simple;
	bh=4CNEN7wC8Pe/7XrtPhrG7zkTQrJox5iMYzUoLmJvEaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqqbph7uRQ8VoNI2yLRJsBvKABUNKrcq3K3ucqgZOn1+7lPdNR00/Q+gwkmMvRnJb7UuTqm8IuF9KD6pw9pABdtweuj4N/0y2mCpWQD3VmvfwsIimhDr2yMu9+3nbZ5MQGy/iH7AJEQL1u647nzS2MsXsvXUWQhH46dYW2B2Yug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEueKNrS; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEueKNrS"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so461055a91.1
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255232; x=1792860032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GNgrelxi6eEq7P7hlNUFtYxqdxmASU5JrfOLjioF/SE=;
        b=NEueKNrSy2vxjgPni7UZL4P2D4ZRa9Xpp/ieOeIKFsprEoCuMdXvERAKswT0vigjqH
         2U0Mgpbk2saaOJU8hRiOrJr9ao3ZAf3VkrVxsuZhmpo8Miy9ce0MjgGCIYBJxMqY4g9W
         /GJV6U0Jl7noJQEiek64X80J2j4xDPqK+E8Ignxa0R2rFnjj6f7oWyIM6P9ZZIvgNfZw
         AziffqLCZjcueIgc7lvfUPoRbf6N5OTIgaMZzhjsjUXXIaEGnU1xN7nsDNJiENa7O6r6
         zfLq3EfBJw3r1L5Gx4/in3QbzT4bSovSPlpHNUQ3qctZ1GzK7/kNBFd6S0cT3zjaw4LZ
         fD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255232; x=1792860032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GNgrelxi6eEq7P7hlNUFtYxqdxmASU5JrfOLjioF/SE=;
        b=MSZpk50qbdI/K3WCNJBHv065UXFi5czuTVO1CM/dKXwTbJmPWAX0GCz2GFqm+3jl+e
         PIyxTtMAd6Y+M3r9ppfaYYIAaFd+UtiOQ4ucjYUkhqZ7JqSzmX6SiudooCr/BQ8ur6zz
         Upnq+l11G0FIhH72POwa9+7RQB74NxcZT9uDZ3XobkwtpyMFykMpIvEBq5GQDhC6eInr
         Rh2dpqVtgKu5KBq1Daz+wkwt9Qcz89gmDiujqDhOrc6sbm4yo9RDx9yd56NPu1gmmLKp
         6947UHQ+AhzmuBSqnwLjagvrPmkB/GSxMB3ucleC14U1F3Pe2rajQH69ZVL1er4l3+id
         gyzA==
X-Gm-Message-State: AFq9FYJOCp7C9d788ELOVhi9X06vLMmZOWL/xJfcvunohb7khcI7P7Cz
	Bs5Ba5xiBFH4JMIZBJetVB3Rx8zVJUVUPjr9djIb0OLiyBo7HysF65fTyb/+aw==
X-Gm-Gg: AYBFou2aDs/qlsZrGlybkC30QHhoiDlzFNEhuUfr5ID7DZsAmaveJgt/F9N0gK2IrTZ
	vC6Azk7MDF3MF5aCJXFol6H25CkFbXmAQoZcRNXI5g5iZrzWjN7hVxruyrhMe2tqpr9JkxNDBOR
	YvtLP/Y/vWfnMf/xYSIbjAir5geCGbO5mQGeipZNm98DQKXRyxqFs3n3QZ6q1vJPajkd2brmJ4h
	ZQ0Tx1QeWWsZPYE8+ihuxw0Q0czFYsWnrcjQMuMedltpLxxHF8ZoNx2n7XfpjhA6rH9d9qU6tlM
	CRLrWMkecAxxw/7f8hAomtfQV2pJcRzm3ISXa54JXcoEQeDF67qTXSusCRtbfegtEy+RWYvHvxj
	0pvh4m3p7V6ESNtsZ7RYQFxpY2frKwP87yPyjNVnPynDaifEs7ekNeTAmf6LMUxGHnDnhNxMEHZ
	grw6M1AhI/3dC+vLatzkFvSTH6JVWcjPTO3fdpQo8tEkie7EdUBx9ZHRM3e/HZi5M02XhIuED13
	J+7qaRm74AiYIYlHdoIFpC/kFT9TuJLmQ3WLx4fCabHQ6mLiadf/FtFM0Lsp3UliJMquJ0bQoMM
	RwZi53jriLoE/OK/fa3TuL/bFulVnKGqkXEVgBsjFzmp
X-Received: by 2002:a17:90b:2247:b0:3ac:17c:6e74 with SMTP id 98e67ed59e1d1-3acef518d7fmr2516583a91.53.1792255231912;
        Sat, 17 Oct 2026 09:40:31 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd0aa3c24sm4682821a91.4.2026.10.17.09.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:40:31 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 27/43] bpf: Assume no bounds for a writable tp with tail calls
Date: Sat, 17 Oct 2026 16:37:29 +0000
Message-ID: <20261017163745.3341787-28-alexei.starovoitov@gmail.com>
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

From: Josef Bacik <josef@toxicpanda.com>

A writable raw tracepoint hands a buffer to the program.  The verifier
notes how far the program reaches into it, and bpf_probe_register() refuses
a program that reaches further than the tracepoint allows.  A program that
does not touch the buffer passes, and can tail-call one of its type that
reads and writes behind it.

Take a BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE program with a tail call to
reach as far as can be, as for the stack, the packet and the buffers of
iterators.  It cannot be attached any more.  Plain raw tracepoint programs,
for which the limit is zero, cannot get at the buffer, and a tail call
stays within one type: they are left alone.

Fixes: 9df1c28bb752 ("bpf: add writable context for raw tracepoints")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/fixups.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 002c3935a8eb..fe59e3114d82 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2153,6 +2153,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			prog->aux->max_pkt_offset = MAX_PACKET_OFF;
 			prog->aux->max_rdonly_access = U32_MAX;
 			prog->aux->max_rdwr_access = U32_MAX;
+			if (prog->type == BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE)
+				prog->aux->max_tp_access = U32_MAX;
 
 			/* mark bpf_tail_call as different opcode to avoid
 			 * conditional branch in the interpreter for every normal
-- 
2.55.0

