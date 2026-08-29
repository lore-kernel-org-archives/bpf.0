Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A1B3BAD93
	for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788017765; cv=none; b=VgXQQNcqkwbBkD/f6wUf9eIv9m9K7cOPvvmfLIywY5jNOCYj2BSCH/aMcUncHj0l9OP9HkaAsZelSr2guEjbjnp86s5wuy3BUCkqPuqdvs9LAN4THYKMa+HkyRVrI91IGUGcYmM3h9GEAHphBOAmibtMfVV9bjgevmgUaxI1tag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788017765; c=relaxed/simple;
	bh=kJbhkhtvAsoNE5ATxChF2IZw6XGGt9ETytt2kI3J8uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIa24UbO3KwgNuR+VGD44cVr9DMFxq+/F6psuAiVMCu5M7WjCcg9WPTXdIELqUma9ZWkwKMsXrrAIlyhduFm7pDD+ii+5KudOezGHf1ONlZZ5g1U2rN+a0V8iwwSdDV2axeovsKa/VTWygkvrVnkCZxRN38sOK4SDQxPaTM+cAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=jz7sCZtd; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="jz7sCZtd"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e041ea211so2002808a91.0
        for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 08:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788017763; x=1788622563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sZ+Lx2r0H8LV8uhVwObVvXE8DpSt3x6BvdBjHoYxPuw=;
        b=jz7sCZtdTDyODnSzvtK1YzjOn3y1R5H6ZA7dG9DeK87kT9MwHYJcbXuyFlQYXqqNze
         TtnJv3/u7hqiArENbEJ3XTFWYez7Z1PNtLFJ2+/JitwBsC988BG6V9kO+sSFEM0AGyJi
         jLVtA9Fp5Q4xYv1dNBVre3WcETtnlgKVpiknZUtSfNIFomboYHXjvHn0OPGlkbFuYsmY
         7eoF3Cl9EPVS7IT3hhi26vztWCQf4i3zOfMD6hXxNAF+lLzCZKkKQZB+XE7ppzQYw6G4
         Ddna/WmugsrMkKlJHe+QJJkJ1wia2QEa/A7y1aPlWeudAmSbNS+E54D5mWIn0yjXknWL
         RQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788017763; x=1788622563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sZ+Lx2r0H8LV8uhVwObVvXE8DpSt3x6BvdBjHoYxPuw=;
        b=sOB0KkOXo/tywvPoQbwEG54LT0Bg64V+OkRntFA0Jl8hVro7B/SSIJq+/+l/47urou
         VQUQvgL58b7QdEez5ptD0NLGEVmMI+xxtiJNq9kxE+OA6IFcktvDzfFrKpSq1+Sf/WYo
         RtXkJTG/eQA0EnmsU9382ZYuQx7/FpsI7GAavTfHxn1RP+DJG/5ftNTI5XtcS3rWfidm
         K3ZwNDm1SuUJf8eEmT389TgC24Ra+pv9fOoaMh8McbX6WL76MRpV2f2UwtXx5un9KYoL
         6PruF0ZwX/7JTLZhV6kzx4TUO1pPjlpUbQyvrXcRf2BEshETiVbWRn8W9HqsL3BQKUnX
         k6Gw==
X-Gm-Message-State: AFuF++k6xXGHVWJzeXFVCJqDyWIz/ws+vEE9A1perZ0UnhtEYeFFoQNk
	sGPzru/EwOdPn0VMRrPVF8rg+C/mk/rBFofcNUND9+l27AOWn1R9YMbtQlY2n0JTbih7D0I/h4e
	DFyXzpg==
X-Gm-Gg: AYBFou3JeTpmL8nW5BvwAu9/jVK9CWthY8JNgt3T5ZencJkCql4O8cyoCfTdibN9mGe
	SN5cLwtZelD+Qe/oIPkqV4kri20ySq1/YxPIN/MOKgLhmpEQy31S2sOijev2aWih3/l4Fm4Fnm7
	/6vluAYBuTCrN7H5glMAT19uNEe7uHlzKH/7Y5VF0Ll2LAHj5Q7Xtm/vl0CnNlJSeMRuf6DVtkR
	FYMiuMz6QJjVv2ae2QOAyc8ifppqz184zh6Ol+kVRmL475FFFlQ6gzyYBqcB7vObSWEKXt8sko7
	Bkrp0xM5CbUNmrX8JgTs7yF6iQ8GInOblIydRVKnfOV/AcB47vTmp0yEUC/6Rvsyx0HK2Y7HU6V
	tNe4Pfv6m1bn+Ps0Fb+ifDutxllhDWPGtBS603HawRVnFqnYif3OTG1eZyIDiooU8kKHsCJ1Rtz
	ek2FmUbWk12KGX54tVFYvR/TpIIVOKmQyj7SWExTOYRs8XWXrjHAymHP7dqtzoXmt/qvetS5A=
X-Received: by 2002:a17:90b:1fcc:b0:395:4e0d:bc60 with SMTP id 98e67ed59e1d1-396d0f6efc0mr24239328a91.9.1788017763018;
        Sat, 29 Aug 2026 08:36:03 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b49c867f5sm2804628eec.2.2026.08.29.08.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 08:36:02 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	lmb@cloudflare.com,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH 1/1] bpf: Fix use-after-free in bpf_prog_test_run_sk_lookup()
Date: Sat, 29 Aug 2026 23:35:15 +0800
Message-ID: <35813d54d61b7b415adf002ef71087af6047da6e.1787897193.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787897193.git.rakukuip@gmail.com>
References: <cover.1787897193.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

In bpf_prog_test_run_sk_lookup(), bpf_test_timer_leave() is called
immediately after the repeat loop finishes, which drops RCU read-side
protection via rcu_read_unlock(). However, the subsequent code dereferences
ctx.selected_sk (checking sk_reuseport and generating cookie via
sock_gen_cookie()) outside the RCU read-side critical section.

bpf_sk_lookup_assign() explicitly allows selecting non-refcounted sockets
whose lifecycles rely on RCU grace periods. If the selected socket is
concurrently destroyed and reclaimed by RCU callbacks after the timer loop
leaves, accessing ctx.selected_sk results in a use-after-free (UAF).

Fix this by deferring the bpf_test_timer_leave() call until after
ctx.selected_sk has been accessed and processed. This ensures that
ctx.selected_sk remains protected by the RCU read lock held during the final
iteration, while preserving the cooperative scheduling and grace period
progress (via cond_resched()) within bpf_test_timer_continue().

Fixes: 7c32e8f8bc33 ("bpf: Add PROG_TEST_RUN support for sk_lookup programs")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/bpf/test_run.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 5d51f6cb7d15..e677ec3390e3 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1650,21 +1650,21 @@ int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kat
 		ctx.selected_sk = NULL;
 		retval = BPF_PROG_SK_LOOKUP_RUN_ARRAY(progs, ctx, bpf_prog_run);
 	} while (bpf_test_timer_continue(&t, 1, repeat, &ret, &duration));
+
+	if (ret >= 0) {
+		user_ctx->cookie = 0;
+		if (ctx.selected_sk) {
+			if (ctx.selected_sk->sk_reuseport && !ctx.no_reuseport)
+				ret = -EOPNOTSUPP;
+			else
+				user_ctx->cookie = sock_gen_cookie(ctx.selected_sk);
+		}
+	}
 	bpf_test_timer_leave(&t);
 
 	if (ret < 0)
 		goto out;
 
-	user_ctx->cookie = 0;
-	if (ctx.selected_sk) {
-		if (ctx.selected_sk->sk_reuseport && !ctx.no_reuseport) {
-			ret = -EOPNOTSUPP;
-			goto out;
-		}
-
-		user_ctx->cookie = sock_gen_cookie(ctx.selected_sk);
-	}
-
 	ret = bpf_test_finish(kattr, uattr, NULL, NULL, 0, 0, retval, duration);
 	if (!ret)
 		ret = bpf_ctx_finish(kattr, uattr, user_ctx, sizeof(*user_ctx));
-- 
2.43.0
