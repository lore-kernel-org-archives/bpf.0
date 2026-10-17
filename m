Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC28F36A350
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200770; cv=none; b=A+yKCED17h3WfH+uj6SaM7irp+l5e2aWBWQ6u6SYbmrUrjbmFrIq1ZjASnJDNlQa0y2seSrtmsCsO+g4n0usLr60IgP3Vhz7ez/PPerak0XxQly/pkBsHEpYaH5SWA4QwYKCyXohuDXkQgM3X+ssfGRX1ytKNpt90n0V4VreqrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200770; c=relaxed/simple;
	bh=On30PjEO6J1ruL3q/hkvb5tuhhy8lM0xd8Kj4HfM0CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOVEAiQMC6keEQBTCyx2BLkahwHxQmbW6H7lc8WVWBHu9vdN9c9XusXi/V6u/cxRakalGszRc9PnphSUg1EDVKCeHY6p52I/hIlNwLjMGbKUrUKWUxv4an+ux+r+OW81YJXuaZeuF7rDrCFk+UxWNBJc3VsJRY5N466VB6BEwE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqIl4yrL; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqIl4yrL"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so244332a12.3
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200769; x=1792805569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HIcM5wreYA6XtufTFK2gEH3CtqCVUiXfm+uw2U6jSRk=;
        b=JqIl4yrLmFLyG05DFf/Ntw6JquMcgZqDS1X6eVJhg/VNpwXE2OJ33rU1LVkrvNF93e
         TxJtNp4sV2hufv5zPLWf6PKG3elRooPygGUaNmYbh+Bz8ogc9eKv8Q37j0AqEeiTy7gN
         HUOtT0uLtLrvio88iNzAZJclFBKOd49/3hy2ZxP4BCd5ABhK4wqVf6ZGSiiPQpWwtZ+k
         PAlPnwNKQ1ryO93xW3y3qgU/RQNP25Aa66WQ7bWseyA14O8KaotJOmHIVT57Xl8I6/Rm
         9uVvOSkujTS9LadORk3zn/UZfjLZ3c/70SEbuUaPXiAb9/g4Wx+/uw8pD/CROJxq9h1M
         UELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200769; x=1792805569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HIcM5wreYA6XtufTFK2gEH3CtqCVUiXfm+uw2U6jSRk=;
        b=nPd6QiGixlKoDos4SPD4fIoF1mQ+O8Z/mlsMkM8kAljx7p80rQToXHHu4hr8jEJ1Oy
         6LdqZbiFePgQxyKYcwLKoALNMlLBenM2RE/dHrPtRRrjFNBA5ZjiqRhQaTihVG16Y3L5
         2JHK/WFcJ4+9hlVo1OoRoBlg9HSG5r/uJhGemPsGEOHICwxpZAqA1fEFfs9/Sqij9Qu/
         EoLaMkRq0+MwUbb9gdpoD+sbwc94EqyWP5JTbad7JSK786CYZ/vIsFRFz/41FX/V+5Z2
         PsxJ1trTJEQAomMitTmozyaU1UOMtinPWNO7/wQGXWF4/p0p5FpM8+tu9yKIJ7CPGoWm
         O0ZQ==
X-Gm-Message-State: AFq9FYLInpATQdEWylIRV6R/evhYFag0qelkRbBguo1KD5G4f7kNk9Cc
	AphQZzhiPh8yp2gpF/VJl7ZShJlzSMJQT2f7GZdbi7Ia+o7VDpYOUufNlN6JV39c
X-Gm-Gg: AYBFou3EtObxUDXQJr3YDtp7pEB6kI2nn8a46cBgvAFQFaWv36/9i+T3NqX1DsSQMdE
	zukdrdPxWUpQ3czXO6huQmFEs2+4ceawZ23gu1syOFcyBmtN0Nj81wvibh7WMgFtptGf8etoA3R
	eykMtu+cXCuwAwHiAKZC74vVLsPc7wgL7oGKt5tjwJw95aow7Dy30mBxM4YkHKMsJpPiK3YQRsX
	T8kNwNPvMQxwrMtxwa2CRRx1FW3IxDMgNFUTpeRA8yRK2GIoU+6tWrHfghGW92vHDpNLXKzoUKW
	EqpD3xZ/mcJgflCTzd42mgF1aYiu6OYfyacTRymedgDcj4+M83IvVeFj9JEWuBBtOTOX5avhpbM
	uvMnGeWUKYg5MBlyhTplpnEci4ADfD8WBc435DLdCv3ra3TMtQSXbdtYPU2r0j9LrGVJofXnaFr
	S/eLgsXCpM5CFLQcjXk2Cq1OPYsyX2IRu4sd6HpzEQYRDPa1+PvLwwlVyCpcnBSjVNj7mP43nWc
	Jmutxlqs8K/Xec1WD08rxGt9O1zm/P1ML6wtPhu6bWrTgFXtXj9oeyW/O4ASC52Q6TGsKtzHH2C
	VgK/pk15XYmciL0pkRR8k9JVuw6pQ+QchG/cvTV9wpRh
X-Received: by 2002:a17:90b:3d87:b0:3ac:9599:a689 with SMTP id 98e67ed59e1d1-3acef154517mr1174222a91.34.1792200769146;
        Fri, 16 Oct 2026 18:32:49 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd05fb680sm3578215a91.2.2026.10.16.18.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:32:48 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 31/38] bpf: Use the socket of a sk_lookup test run under RCU
Date: Sat, 17 Oct 2026 01:24:44 +0000
Message-ID: <20261017012451.364800-23-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
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

