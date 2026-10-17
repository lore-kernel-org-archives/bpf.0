Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9C43DB655
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278631; cv=none; b=eEU7TzKc7bMXyH9H0Z9ZF904QY8filLkcMnEn1FGyOVyUMLk06YEnvaFJwT2O/PLAfakta5ILf82UJVR7g9tJtRykXt7DST8iShcQkrQYeTyjE6BCgNqJ8n9Dhllbm8g79hL4EfLcFhzY6Lw31RknBvama6sgwJpaemI3Mv/7Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278631; c=relaxed/simple;
	bh=On30PjEO6J1ruL3q/hkvb5tuhhy8lM0xd8Kj4HfM0CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mL9momj7OhRaylNjXT9vZMdK03VeN8NNtedreclkzzmQpRWhUKhfLRXjhdfS9p1KrBw31y5jfU66agen53vTldGvbfAA1ikIdo4ZNcrtRynlsb3OtkJWwzQQpZBp9C3b2hnm6gsRRE3iJ8yXpzDMjXFjVjocvBEZcHAPM8rdQf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTDXsmQN; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTDXsmQN"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so918459a91.0
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792278629; x=1792883429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HIcM5wreYA6XtufTFK2gEH3CtqCVUiXfm+uw2U6jSRk=;
        b=lTDXsmQNtAyJYOUIurlO8MAk/yJnCL3Ibev+Khpk+q+D82GYmqFsO4CqW+5Lvd9m8f
         dIIRXUrHLGVPCxx0/R7h+UPEKMDZTupL9dK+Z25Wxk17WRKkGurIFPcVMIirsliecCEC
         ua9k4Jq/UFBIwY2gksH/Dc845Ery8Ywy+FaQADwm9omB/n/C35kuQifTf0r9l4ye+Ii4
         PJmY3eTy+FuWAF2ZJWrUwBzumEyMj60utLxz9Y3Voud3NuwSvTPzlpqeWQ2+S9nDn9MW
         BnRDJbtvxohtCpwIQu3RFyzj3EQSU17xm5SG9OEnwuWfKJu4+qHpae4JN37g7aPGbFn6
         7lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792278629; x=1792883429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HIcM5wreYA6XtufTFK2gEH3CtqCVUiXfm+uw2U6jSRk=;
        b=n1wx2UIFQXsz1Q+j9sZW0nkwoltgrhEv3iv6ohWe/PIk2HgYV/6KU3Go0QP5UDy0Oh
         LBlNh/qsXzoZxoQQwCsyu6B69kRizGRcs6E5kVxtBlyhi+Nfz5Czkg1eNMUlAWSjpGZA
         3iobohckOf4VjsXVVkMO/EBhnOyl1je+wpcPm8vQleY9UXqVVZxKfcWWjIoZcRVyoegm
         KF40U+UztF0DR2RHnK/ddDVRfONTTSOAimp5P9EcH6qByx+8PZGKNUlTz6FSAGFexQpH
         2pBuFViGNHIvpyzVUDZhrve0is5t+VvfWADyl0EujpcAnABEisncauMJ0x+bQVdCeUs1
         0ErQ==
X-Gm-Message-State: AFq9FYLVFDNR5C5+wSPFkdBr3cT7sICs6xXKNkRWtMO1X53AstaufrVJ
	25PhJ+W+QBXRaLH+Pg2wkM3ezkrENSVxdpKbOIefSjXMh68XlSA7oZBwqezvDw==
X-Gm-Gg: AYBFou02HjDAdvrhAQfIHIZYy0CmcjVP+2ejTNONRTDYLP9m/gEwR6HI9E49JmazkhU
	eaOMAl85nlVXsXwckbCyUAhrzNiV+jxXSOfqcKbx5+Y2ORXbpcX3yyhGKlSETGdIS3eVZsnOtVy
	x2bvGwZucWWlhLXkbkAiZSlPePdqQTq9RAnLKfnf7+4iGFLFEqIoYpd1uj+DTcU6sZcehfvI37B
	3Rm1fdDuee/S26CLYqXdYatgazYYavo+kUPOus5Pp+R/JuWsH46+9buSLqEOBb4AhfIQsJS8RTW
	M8+UX88C758g+SmF+2MIQQyLWqWgZOLA169u1qFxT3esx+dXdctRMZzUwr/dzyaDrM/Z6ANsgWy
	dRfVin9zIkDAxDohmWzTH85nrmemAEMmX9r4WEOSS9X+Os84mXTkSXQQOrxvwarwGe6Gdb6fD1O
	NAsUL7pGxxjJ/Ut0Xn/EA/Hf+Zn6Iex0K1VQ1MWTIUMjbM0HvloqGMBHRxJ4sB6nXPQuu3nafiC
	CTNWmzbX2Of2uw2Cd4ZwtEZja/7WgTODUIanKdTYctcNYdbsajf3F00KhEOCg5WeVXV/nzTUPrG
	IvK5sCpHgVQTgAVkGAtuNk1g4yyxQ+d7EYH1FIe4A9Q=
X-Received: by 2002:a17:90a:c10f:b0:3ac:6fcf:91d2 with SMTP id 98e67ed59e1d1-3aceec79addmr3313230a91.19.1792278629448;
        Sat, 17 Oct 2026 16:10:29 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94798212sm14697729a91.14.2026.10.17.16.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 16:10:29 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v3 06/16] bpf: Use the socket of a sk_lookup test run under RCU
Date: Sat, 17 Oct 2026 23:09:40 +0000
Message-ID: <20261017230950.802052-7-alexei.starovoitov@gmail.com>
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

From: Josef Bacik <josef@toxicpanda.com>

bpf_sk_lookup_assign() accepts only sockets which are freed by RCU, and
takes no reference. bpf_prog_test_run_sk_lookup() looks at sk_reuseport of
the selected socket and generates its cookie, which is a write, behind
bpf_test_timer_leave(), that is outside of the RCU read side critical
section in which the program ran. If the socket is closed in the meantime
it may be gone.

Do both before the section ends.

Fixes: 7c32e8f8bc33 ("bpf: Add PROG_TEST_RUN support for sk_lookup programs")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/bpf/test_run.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index d73cd247f8cd..3043a7393c29 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1656,20 +1656,19 @@ int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kat
 		ctx.selected_sk = NULL;
 		retval = BPF_PROG_SK_LOOKUP_RUN_ARRAY(progs, ctx, bpf_prog_run);
 	} while (bpf_test_timer_continue(&t, 1, repeat, &ret, &duration));
-	bpf_test_timer_leave(&t);
-
-	if (ret < 0)
-		goto out;
 
+	/* Nothing but RCU keeps the selected socket */
 	user_ctx->cookie = 0;
-	if (ctx.selected_sk) {
-		if (ctx.selected_sk->sk_reuseport && !ctx.no_reuseport) {
+	if (!ret && ctx.selected_sk) {
+		if (ctx.selected_sk->sk_reuseport && !ctx.no_reuseport)
 			ret = -EOPNOTSUPP;
-			goto out;
-		}
-
-		user_ctx->cookie = sock_gen_cookie(ctx.selected_sk);
+		else
+			user_ctx->cookie = sock_gen_cookie(ctx.selected_sk);
 	}
+	bpf_test_timer_leave(&t);
+
+	if (ret < 0)
+		goto out;
 
 	ret = bpf_test_finish(kattr, uattr, NULL, NULL, 0, 0, retval, duration);
 	if (!ret)
-- 
2.55.0

