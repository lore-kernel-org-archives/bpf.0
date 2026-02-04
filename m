Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C953009E4
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 04:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770178131; cv=none; b=S7a168kqXdla5DZfQXw081FiuPWgmEvl8Ky5KciArO9URZCEzFbugZQc4LkGTVb8lCM4Sq2EVmVv6AcCxtYsvmpH8A0MyzoLu1NJW5m3j5vZAfAckJM7n4jCeuWmfigKkOkmoKWzgOPqelecBIW20ZKAMeufKwnGLyiI9bevGbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770178131; c=relaxed/simple;
	bh=/S+etfuorB4JOg8c64Eam5cYiK78H2/ahYAQYzDaMmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2BvSF/wwKO8ZRvcVZ8DzqIxjo0M4kU0NQq53DKfh35r6ymqKPEl4kjZp560J7vu1wVqDtalzfx6EZfUmSu8yKvrN3XVHbH0t0c7ucWvF0wdAnNk9w7frrg1rg6/jhqGxNEBfonv+cvkeLorfHhLyuYyFKRxJHBtdYMiJJq12b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mC1KlQjm; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC1KlQjm"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-352e3d18fa7so206687a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 20:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770178127; x=1770782927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jy96ccwe/DIbob0XU38YOrX4Z8oK6cPORd0GBiVrrfg=;
        b=mC1KlQjmsTvUDEGrob5c+sxXnK4lUfm7iyUjxx7JAW/S10R8Z0J5I7B3hDfzVjmbsT
         pfZfhyyifA1kNdFKvfqypRSo0Kcv5z7bLiQnHt3jYDFsjNyGJgic0kkJNHWEOBAHyWLP
         7mKgqSHeM3pWhRTd4aDN/Bbza0SEsxQUiS8QiuWtyV3+ZX3COfKfhsJZGO9nme4P9OJ4
         vC19qWA/UusfaS4okcOSEEdcSQa9ERNnWbjJIatmcwi4n4V2VvOzLNtIP95OJQLy3Qgt
         k+r6Bni28sBNzZ6N0Rnf+x7BXIVT0xmftYC3LGitp/vnMzN3O30ywin/dxBa3hYXUAJu
         FXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770178127; x=1770782927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jy96ccwe/DIbob0XU38YOrX4Z8oK6cPORd0GBiVrrfg=;
        b=HkbYRuBhKU9iU58nHudULdgwAZ+1gnz+mPiAjrSp3nyg2c3Fsd3fT6gLBy6Y51JnrQ
         jNxDlOk1dkKAxNAIkVkWVUzIMATL3OF+yy4hZ4JfdgMbJpFHIn3HF6Q+5KUKPYJT0bmT
         fnOWanS/NgGsZKgPFU0dfX8TE6kzB0Y/JBs4qor4J4Q+afE5xoNryv51mT/srjLKUROX
         Rtf7+WECreau6cNI5tQbudsXf5lLOrAx0ohXVNaXNH+edOvnweaxcHJRy9IfszEVicTm
         Ym22g1B+vuBdEFcQtzvfw6tE7qMmxiMjkG5MJDG0G3MDY+2no8hDofEJhpWD6nfg8zEY
         OCjg==
X-Gm-Message-State: AOJu0Yxvcmhz1HAIgjUB2NWSma4+xBhdvVJmhJaT6/2tp6eQNNgDU6kf
	u/6A1GGN4p+mOKSAu+ztFK7olEH+z0h+ryXHJTBjldVAdypy2NsSmvCBFOCncA==
X-Gm-Gg: AZuq6aK7MyTvC95hfbaax7z9Os7vOOptzo5W5obUnPevxEhXBjEPp2yDGR6lumj4fWf
	4Dvi8SSqqRvYmDXjrZNDgypCthgyOvqhbK2H1XPtZ71x7kq8ihgDIlr6qXKUGMbtdCli8PEabwF
	FfoF/M5FTe7X9oB8o0c8bA9eZ71xXWRi6CrEjyp7FcM1FzF4AM3s/9UtU6uF9+z5xwy8PE7v8dG
	nOyfCAuPLU4BSl2h1elpn9hS7rwvOaFbYaETbcoTSTxfTAHj70oiz82LEcGJFLD30hW9RCCzK/+
	tmik8yIGHEXNA0i/J5g3XBp4Ao2VGnZ8HXwB4RFVyVIt8NRk3857Teq17fyizTxF3HPpen0qcAQ
	Ak2VwBw+RtxqEnrWrzIC7ddDSb+Ibm3F6PAgf8VwBSxgypWH1isLIvs9aK3AZIjSoiZ7M2uVBJa
	HqCBIF6S1AnFsYmzUTTg32MEI2/QY5jxdkiIVyC29iI9ZDtJrMSyBcqCVEgV0HOq6eL0Db6KAkY
	rVBHvNR8fW7JSruZFCW3MGVKHmAOucSHtnilOV0i4IYZZp4bA==
X-Received: by 2002:a17:90b:3c49:b0:353:356c:6821 with SMTP id 98e67ed59e1d1-354870b1dd8mr1324283a91.8.1770178126603;
        Tue, 03 Feb 2026 20:08:46 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35485edfdc2sm1009961a91.15.2026.02.03.20.08.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Feb 2026 20:08:46 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com
Subject: [PATCH v2 bpf-next 4/4] selftests/bpf: Strengthen timer_start_deadlock test
Date: Tue,  3 Feb 2026 20:08:33 -0800
Message-ID: <20260204040834.22263-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260204040834.22263-1-alexei.starovoitov@gmail.com>
References: <20260204040834.22263-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Strengthen timer_start_deadlock test and check for recursion now

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/timer_start_deadlock.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/timer_start_deadlock.c b/tools/testing/selftests/bpf/progs/timer_start_deadlock.c
index 368563747a46..019518ee18cd 100644
--- a/tools/testing/selftests/bpf/progs/timer_start_deadlock.c
+++ b/tools/testing/selftests/bpf/progs/timer_start_deadlock.c
@@ -31,7 +31,6 @@ SEC("tp_btf/hrtimer_cancel")
 int BPF_PROG(tp_hrtimer_cancel, struct hrtimer *hrtimer)
 {
 	struct bpf_timer *timer;
-	static bool called = false;
 	int key = 0;
 
 	if (!in_timer_start)
@@ -42,13 +41,9 @@ int BPF_PROG(tp_hrtimer_cancel, struct hrtimer *hrtimer)
 
 	/*
 	 * Call bpf_timer_start() from the tracepoint within hrtimer logic
-	 * on the same timer to make sure it doesn't deadlock,
-	 * and do it once.
+	 * on the same timer to make sure it doesn't deadlock.
 	 */
-	if (!called) {
-		called = true;
-		bpf_timer_start(timer, 1000000000, 0);
-	}
+	bpf_timer_start(timer, 1000000000, 0);
 	return 0;
 }
 
-- 
2.47.3

