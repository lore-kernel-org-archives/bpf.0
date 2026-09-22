Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05449357D1E
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039621; cv=none; b=OJxHXpLT1dhpaE2ZFka0CPu8dCJsGuQfu68YE8A3qcR35om17l5MMexHEQtiKcE4cr4KjxwDd+clG4hoIabPaceRaUH5pOttSvSF9JiXwYx+VJerH0um/DoZ4kwQsU7OTQtSd31s0gIIJYkk7NxzxlupqkzRxPqLMiQS1ExYK3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039621; c=relaxed/simple;
	bh=6MPv1v8mFaJ7hWL4Erlfc2pkcb2aU7wQJUl4ghsFhFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z++W2WtKLZg6ai9j2jY9zeAxBdWiIgLrV2X3eV52CmNySmxBLQRu38l0A5uKW/Dwbcf5sRl+EAYL8n3k9iaCtpI0FXlUQnfWuHm1JETYJH97OPj4sMfHf3VVXiJGPYmP2qvpduef7q2AKqhpLGbaABV1ADcnE9WdosluHCLTaj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LB2PD3nO; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LB2PD3nO"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so2724148a91.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039619; x=1790644419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HOb30dgaSLoeeaRuzhX+9sNJPD8P8kM5wAZCsI/iShI=;
        b=LB2PD3nOSuxh10l7hNpG9D5SvLoR3GOaTdwJk9Toi7GumzObK3AxJp6yC53kkhhNkV
         Ls8J9OXXeSPScs6wNpA+OB9neDUK8WA+y1aZWexOb/amO4xXZ7rXkL9kOrO9hb3/ml7J
         A/0A3tgqZjjkU+dpWfpMMbY+Np93f9KXf6aNxQkGr6Ndqo3casiaP024Gs05sm9dX2pf
         82MezVoJJM3g5p5Sm6tn7/s0Rxpm2+mmPLn3spw1m6toeZjYNeU48fgE8/xr9WQcyFBi
         U7jqGq9W2vE4JzWFixRJWlrdAUc5WEY57rYAcSAW4ZwHmbThNEf9dM3v+Mi3NtUZ6jEk
         aBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039619; x=1790644419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HOb30dgaSLoeeaRuzhX+9sNJPD8P8kM5wAZCsI/iShI=;
        b=cT/OcP6m/9JLyVXFm4zvnT7jGYzXQq5+9D3rQ8GHcXtiEBf3N0KNSdEe2nj3kJvB05
         VQEBPmqfIxsHee7b7X0+yHg6TpEvUJdgtHK56g3e032jldWmwCyUdCx4ZrIT1/IOOXgg
         uKyX5M02FZyILvG8018cOVhPnk7NKnwb8Gtci6XGO3Wa3+WuNjoWa4UZqBdWkfjVySNv
         83DzZjw9Uz4JcTfp+TGQG+zYmr4dX4nEdvjF6q0YqApo/HJ3TjIzE/iClQEKQJzlJMy3
         +SvF6JMsy/3yLqasOBV/DgLq6j3hOEU7oOF6FwUVWaNkA/jEI+n/i+oKfE+BbN+N1Fjq
         HpMg==
X-Gm-Message-State: AFuF++kVZViPFt5rl0h05XDL0Uwa4FQ+1WrR1k6waATdE8Ipp98GhiE/
	KsKOSDIqECDifzaJguZ1AsEOnCaboHNwxISdGi+bGamqo1uLD9/MCqn87j9J2w==
X-Gm-Gg: AYBFou1bnK+hWnue3HBIikD8uQOzUnvB/jfR+UIxdDO0+xvJL6JY3GrQolDxHUzeE2a
	wusXNuoYxLTK7D9C0/IeqRsixfz3km+wpYAFtHBkfhXUT8fUG169X02ZREmEn9jA9mY3nKpkNyj
	l56aGeh42fe5SAd14jkKWKZovnK5z0CXK/zyviZ3Wmc78OjxThJiX7rSwNCjtcer5VGtSVbw9QB
	Y8B62BkudC0ihLSiRzmOF9hCk0agWh9mrrwdYDu/jE87MT5iCarQST0MMLoCk1ZkO/ZP4rBqIhI
	oVzMJx6e+Rr7pGcrqVwXOy11LYiYVwG3ZVYer6G+2ZwXp0Nx6UZsHWgO4n1CbrhMXNrf/PDymMl
	mXHsQi+CFyNfL2ZgbV3TGST570SFaTMVq0n/LQI29xV3Ap/Q0oMiHEBw6Wy6tFd8RnSt70umQwL
	NaBIrrI4iiV6xl/d2rQiN9fmyeAEY+IId7YUbatLhHgix0i3rbaq2iUvtIIjlG7mqj4wGj7y1cy
	f7YJFR/B+4R6NsXDcEWvFE/OVpbE6eCUKCPMxqXqmwNEe8Bq9LPs6YOXQOUt9ZS4YvAx99kP35v
	yqFYEVTajNRsp7vtP1hie7BRRkhktk90JQqR0zAMTco=
X-Received: by 2002:a17:90a:38c4:b0:3a0:3881:eabe with SMTP id 98e67ed59e1d1-3a03881eb2cmr5071204a91.5.1790039619079;
        Mon, 21 Sep 2026 18:13:39 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06e5cd2e4sm243947a91.16.2026.09.21.18.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:13:38 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH bpf-next 02/17] selftests/bpf: Test recursion through a global function and a callback
Date: Tue, 22 Sep 2026 01:13:08 +0000
Message-ID: <20260922011323.1298619-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add a test for recursion
callback -> static func -> global func -> bpf_loop() -> callback
that used to hang check_max_stack_depth().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/progs/verifier_global_subprogs.c      | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 966f49348787..27fbe54e8795 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -536,4 +536,35 @@ int return_from_void_global(struct __sk_buff *skb)
 	return 0;
 }
 
+int global_calls_loop(int x);
+
+static __noinline int static_calls_global(int x)
+{
+	return global_calls_loop(x);
+}
+
+static __noinline int loop_cb_calls_static(u32 i, void *ctx)
+{
+	return static_calls_global(i);
+}
+
+__noinline int global_calls_loop(int x)
+{
+	bpf_loop(1, loop_cb_calls_static, NULL, 0);
+	return 0;
+}
+
+/*
+ * loop_cb_calls_static() -> static_calls_global() -> global_calls_loop() ->
+ * bpf_loop() -> loop_cb_calls_static() is an unbounded recursion that the
+ * main verification pass can't see, because it doesn't follow calls of global
+ * functions. None of the functions use stack.
+ */
+SEC("?raw_tp")
+__failure __msg("recursive call from global_calls_loop() to loop_cb_calls_static()")
+int recursion_via_global_func_and_callback(const void *ctx)
+{
+	return loop_cb_calls_static(0, NULL);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

