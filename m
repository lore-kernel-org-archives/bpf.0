Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC1C355F49
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255279; cv=none; b=Z2W0Y9ziwc1cs3/5Nmw/AkC/rA+P6QpHf8EhBH6Y5OjCOs9/fkUb2yVB/YM2dENo+bIvTXhiUk9gFVmFmhLB9EZRbrC10nATKbY9WJVJS6JDDL3BHlFDd6qw1YkIdCiAnEZOTW07YlfOayhefEY5vA4+zPYLOnedl5q3nLondXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255279; c=relaxed/simple;
	bh=On30PjEO6J1ruL3q/hkvb5tuhhy8lM0xd8Kj4HfM0CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWlwTu345dvc31M5v4ygmzZoynJJwRT6NecwK9WTINWb2h8/1uU17K9MkGTd04HbqfzbfB5SroBZOK2tClJZqnxukCeAcUzOGXNYObzJJjZPdv40+6UGPboJ6GrpujWHpek4Ourc2T6goX78KDYQvDC+rnIjqy2JxIutPSMpy68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCVPtB8l; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCVPtB8l"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc147d86bebso592347a12.0
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255277; x=1792860077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HIcM5wreYA6XtufTFK2gEH3CtqCVUiXfm+uw2U6jSRk=;
        b=eCVPtB8lsJsbdGPf+zUzh47kmPa939Zq11a3fLA8qz3T7IOLWj0MHUGF9zD1tgNqEK
         FQl0oWPYn7wlaIec8ysQtyuvAKcuibSI2ywRSYCEBBQCe6HIVLEVKX5YW1PUt0fqlDxH
         AddiVOYkwqRmajLCMXtCGS5xQdif9uy2IfIcaOidh7sl3w+E9AWjwADNleoh/w/Czkc3
         kk/KPFDySI1Kv4II3dwSfRsFqn3Tmc+Gd6bEdPAfQj9Ljf9LMwPbD/7hhO/EWbSlLv0Q
         QLXiu+jYEbKlWL980zkgQ8aRbCx0Tr/BrVOOBBGpThefmmdfRlQvaHayph2QafrgWMW8
         24sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255277; x=1792860077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HIcM5wreYA6XtufTFK2gEH3CtqCVUiXfm+uw2U6jSRk=;
        b=HCHIVuHwk4YbkX9svtoMLnSf/aiZ/hBtFWA9Ud0jmKO77uGrW5JUVH6OO17iviGft/
         rLYBuLz3Y1aQGE6LtV8v3pITb6tiFO6dYgTrv3CFCY+9E1cdh0SpWPCfytbMbySt1hZb
         1w+AwSaO/Z1zB0oCLLyvqoQ0YDkQv9VOC5891wV7p5h6tyJLBH6LnpmSBGGrp6DXkCnY
         JwjtbYRy6y0h58cbltkpaOypfZ44oc0pUGakuqZDbLRwcEC670DJRIJdoRJcueGXwN8n
         w1RfWAZBQTQiX5F7mC212JwLkPg/xojFADLeE4AKbMvh802F2lUPPi0iI1/8ZTLp17jO
         zu2g==
X-Gm-Message-State: AFq9FYJPEWfTO6IBdleala3zF3Bo0uGxeN/DG26vXfziuVOY5E3bjdBW
	pxOU9uFY0dN0x4z5EsxKOTYWRLalpvmxADM7z/RLaRByiuVgUyu8bzIG/SKKhQ==
X-Gm-Gg: AYBFou0WYBuRjZfAm3rXxM/NyzIFsFUBNPZKDOJLHD7YK5NzL6JMEJDrSIlUhQj3h5b
	/3HvrbUQ+290p9sz6W4hjNI5vlvUJYcmFtcHAUIA/NmdXnagvs6km6jGvB5qJpQbogKgzqqHDVh
	tCaxsoO1cUeP4t+tULchqwRLWR8rCn8ML9YeI3ObdzipZ7P8XgKle8Ob9IMS0uk50XpHkL1fXfr
	1sH04MkC/sGS7jmIEzwILw3Xa/G1XhT4/1/eNfjVlEUtTx1WcXiOH7nQdkE1M9OLmbW2884AAs9
	IhONzfHJL3wblQK3zScU/u5cxu5/33rougPcg42Jew9kVqlATY7HFKvAaUOICZuaP0ZXBaEiE3R
	pMvRsnScWCwtB8S8hKVL6kQoNPijMW2ln6yUOrlm4b7xkVwWOzSGHy6x/r8+ItKUJu+ol7Pz+Iz
	1W31GWTUnV58BuH8U0GRfinZ/MUJc4e8xoQq1VnaYGwW+Au8OLeeubzvVboGw3GKpgZQ1kxKX0s
	v4xbwxMDGt7gwDsAz94xOwaRJXTAWk0H4kWYcWl6vwCLLRdI8nhGGjvGzebHxTb2e/Ek//EEqIU
	s961pHm/VDmY8xBWy6oX320AYHCoBZMks/HKZmoy87o=
X-Received: by 2002:a17:90b:4d84:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3acef59b49emr1864932a91.38.1792255277196;
        Sat, 17 Oct 2026 09:41:17 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc46ecd32sm8979900a91.3.2026.10.17.09.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:41:16 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 34/43] bpf: Use the socket of a sk_lookup test run under RCU
Date: Sat, 17 Oct 2026 16:37:36 +0000
Message-ID: <20261017163745.3341787-35-alexei.starovoitov@gmail.com>
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

