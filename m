Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F6536495D
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 07:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773388410; cv=none; b=aHC7b1jEOOBfizdiATpfYJQQeZYPk+nrBLQvBmc0uV+u800uuXKNvVeiGzYotldDMjo2sBz/NFh0MtwEJI0iHJGB7rnJHfPib6/cxmbnLsBtKZeWX77T6s7yn5Mk4btixloMMMHBFBzZsfNtcW0PXtQHLA37fxJwA5DVtp9w6bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773388410; c=relaxed/simple;
	bh=52XFf5chrXDNY5U3llzFtLJreM20MkdWmhdcm5DKeVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IK3Cpfi9WvQLBjGJ8PDVhd3fjvqVilC6sZSzNrGQP/5z895EKSAnZwfB+81JpdFSy45/vgQibtp3yYpMKtyHHsCcBnBVRDmemjixtN0a/a25VbujhBqXDlCajdpLgge6tNLK+IISjt5Sov9H6l7cGWsBleE8AZfRb8JJCUPVp7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAifLZFG; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAifLZFG"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35a094cc3e9so1227513a91.3
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 00:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773388408; x=1773993208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKFA9wVMm/gNkMXJCmPLEZLzvioGyhhMxrE8OFRpUxU=;
        b=NAifLZFGC1MRjTwBtr+/wJOXRQIrRNkwlab6XxULEe8uOopnLqQt/O1tZsyuwnimvD
         x0cUmLjrj6d/q/7rLKuvqsHFjdXPr0xQBFPLD/5sQxYz0qzAH6WX1Qk8q5V/d6GJ7cIe
         uMrFR3vIPXcjdZfFCFagP3fF1g9zjE0vHpzQbn4Ax5xvUieoIsJ4qTn7FlrDfnKQar6+
         7zQRwJm9cXMiHtlbZ4drTA29Ck72SQtV+z4texCu8Q/mFpG6W7OEoyPpI15INDGq4O4N
         5XeMHxoTsy9+OG7RsG1nDV/eMLhCjqlJ1woDkyHk3Qk0m1pi0sj0HXmCYMqOL9by1wqH
         adwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773388408; x=1773993208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xKFA9wVMm/gNkMXJCmPLEZLzvioGyhhMxrE8OFRpUxU=;
        b=UaDFhtkPd3f7UaGW0sUlE5Sq9KI1AtXM0FSOqEdbR7z7CFIwL7hjrJObZ/3D/VXDuG
         B+P6wFUbM8fqkSqY6M9DHA6G8p8EeFgcqygKY8nkp+u7Vp0GZCePVtxa82NMpDrjm2Z6
         cvkzQnF26q52uRALqvfpIm+XhbMLVkaib4/A6PjYu72Ia3LjY/aPwGfDBLwxoJXOiv6g
         waxmumuCQ+tLNnXgfOMOPbkWzxjljoBTngo4pcRfxIuWVtFkOB89kjp7ox9rbf156Wcz
         jeT84ncf9MQ79nnfNOLIngvn8yNDbZuSRoLwZP3l+XtTQs1AfvAwsgHCXmYabNLzdfQy
         3NCA==
X-Gm-Message-State: AOJu0YysZugS6J1OOVzP68jjbLes0WQyrGfDXM+uLA3T3z/AeqLwqe+U
	XTN+V0NnVoqagi6Somk+E2f/uJsVRxsyM3h5tfYhugQ9rOTNR7yQ89NqDeZPQTTS2vk=
X-Gm-Gg: ATEYQzwwC0PQ/203do6++DWGoonOgbOLMP//sAsr3wZgfvZKtRIVr/D5RABv/6FvMoI
	VaQpArWdPHpyhgtjDPBOjFda6Bkn0bB8CogNuvvF3xwlQ80sM05eOh7rF0ZgbNazqw6aNmXA7Rp
	FkpXik6YBd+wjj4krEmIGXZoGvDpJeDQfb2V67hVCDKlC2U7BP6P1AKxTwJ2bNVtOJWMmb5SFrr
	UFBA1m4DKM8pVgbBNuh4rhIB/A/aeWU+wIpZKCJqlUt9rvRQ0K5yCtMrrdxARUxp/K4ZA7vqFNr
	tpcrt7oTfXKTe3+HK/cUi4w5+mHOQDCHPWmoEB90w1tL4N9q8K3tKu/WAjuRrMP+nGbgUzqXaqR
	S8QfKLEUTjuo4AUyKP5mKm8Ed6Y7Nj9DHR+zLwLf9hXSswEPiLRBLy+wW9S1XDd84qxXiurODDs
	XB8Np9pc67Qpquda/djJMhlEwBZQNiDXGgWApZ+O+rGS39CVtsqgAvjnk2THhuVYrrbGairOMgc
	guvC23S1Q==
X-Received: by 2002:a17:90b:1d49:b0:356:24f0:af0c with SMTP id 98e67ed59e1d1-35a22003a84mr2221316a91.17.1773388408465;
        Fri, 13 Mar 2026 00:53:28 -0700 (PDT)
Received: from kali-VMware-Virtual-Platform.. ([185.218.127.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02ffdfb7sm9774694a91.14.2026.03.13.00.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 00:53:28 -0700 (PDT)
From: Daniel Wade <danjwade95@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	ast@kernel.org,
	Daniel Wade <danjwade95@gmail.com>
Subject: [PATCH bpf v3 1/2] bpf: Fix unsound scalar forking in maybe_fork_scalars() for BPF_OR
Date: Fri, 13 Mar 2026 18:53:17 +1100
Message-ID: <20260313075318.11847-2-danjwade95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313075318.11847-1-danjwade95@gmail.com>
References: <20260313075318.11847-1-danjwade95@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

maybe_fork_scalars() is called for both BPF_AND and BPF_OR when the
source operand is a constant.  When dst has signed range [-1, 0], it
forks the verifier state: the pushed path gets dst = 0, the current
path gets dst = -1.

For BPF_AND this is correct: 0 & K == 0.
For BPF_OR this is wrong:    0 | K == K, not 0.

The pushed path therefore tracks dst as 0 when the runtime value is K,
producing an exploitable verifier/runtime divergence that allows
out-of-bounds map access.

Fix this by passing env->insn_idx (instead of env->insn_idx + 1) to
push_stack(), so the pushed path re-executes the ALU instruction with
dst = 0 and naturally computes the correct result for any opcode.

Fixes: bffacdb80b93 ("bpf: Recognize special arithmetic shift in the verifier")
Signed-off-by: Daniel Wade <danjwade95@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a9e2380327..68fa308520 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14206,7 +14206,7 @@ static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *ins
 	else
 		return 0;
 
-	branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
+	branch = push_stack(env, env->insn_idx, env->insn_idx, false);
 	if (IS_ERR(branch))
 		return PTR_ERR(branch);
 
-- 
2.43.0

