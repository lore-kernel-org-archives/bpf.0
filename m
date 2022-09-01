Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B07ECAAD8
	for <bpf@archiver.kernel.org>; Thu,  1 Sep 2022 16:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbiIAQQl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 1 Sep 2022 12:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbiIAQQi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 12:16:38 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94FD4D827
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 09:16:36 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y29so13847622pfq.0
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 09:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=0fGyRfQR7wXSaL6USjScrGPvvIFh66CwdJrIvv58a5g=;
        b=moJ3QGwNSKtYu6wWQdRUAqn5vj/OGKF7dCZIO4PjfQTweG7WVmeKw0iOVyYrtXJiDx
         l9BwYgFNLwLHikDnkkSagE0/FIh2cyXKDA+EPfE+BEaD8B7kq4ahMptMml1suYP9ycH3
         HAzsZJhAf+DFN15Ykj/1O8MFENQrBh1KNA5N4AStyIOHaEYlOtwf3QJhqNdRbnagLlj4
         Mufw7a3+axZD0NZXcGG6Y+tlD7hjAw7hA0khvYK35msgOJXpFagZF6t1lMAZtEDEpF5Y
         qUr4/1Nvwb7kTr/M3DhZdxgalroISYL0M/ViOhOtkbpvi0bt0vsX5MY4s2TkDuEcHl9L
         WJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0fGyRfQR7wXSaL6USjScrGPvvIFh66CwdJrIvv58a5g=;
        b=QUWmcFaDf7v8D1K//xitdhmRDehatYAGMNmv4F6dFHpaSEw0iaZdE/DqusFvjnl+mq
         FHovsBfoC2P0JUjK305p6zgcvLntpF7Bom5R00k9lxWPwG1ApDclTsE84UI8Wxyxapk1
         PRPjO+ds/e/KSoIssNghXoEB8KRfbaNHKv/U8i142uXxBsTt11dY5NEf5sqVlyoi5o+F
         RRCwss4EBtlcTGagUP1bw8fGBzlBrcA+CepAHAdPNiY16k30xijADrz8r0OTFsHUXeuz
         qTgS5qbMvjKvFC/Unde9Avn+NVY04ccuI/KyFSoo82CIUG6VHpJxrfdha4HVFFEJK5D7
         hJQg==
X-Gm-Message-State: ACgBeo3GCbjCfZ4QzS5Vj6iJEOQvWphEQXSPxTWw78I46oTbsiqKLxRQ
        2TRV7oCAKu7BASPLg2b3FA0=
X-Google-Smtp-Source: AA6agR7LjjuE3wBIwKQp/cjDicVkre1L5Fbr8voVsdCnosFf0RhuKL47jGob3bHkfRIqJC/40s3vEw==
X-Received: by 2002:a63:450:0:b0:42b:c914:a0fc with SMTP id 77-20020a630450000000b0042bc914a0fcmr20695445pge.317.1662048996291;
        Thu, 01 Sep 2022 09:16:36 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::3:4dc5])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902f14200b00173368e9dedsm10798175plb.252.2022.09.01.09.16.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Sep 2022 09:16:35 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 12/15] bpf: Remove tracing program restriction on map types
Date:   Thu,  1 Sep 2022 09:15:44 -0700
Message-Id: <20220901161547.57722-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901161547.57722-1-alexei.starovoitov@gmail.com>
References: <20220901161547.57722-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

The hash map is now fully converted to bpf_mem_alloc. Its implementation is not
allocating synchronously and not calling call_rcu() directly. It's now safe to
use non-preallocated hash maps in all types of tracing programs including
BPF_PROG_TYPE_PERF_EVENT that runs out of NMI context.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 42 ------------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3dce3166855f..57ec06b1d09d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12623,48 +12623,6 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(prog);
-	/*
-	 * Validate that trace type programs use preallocated hash maps.
-	 *
-	 * For programs attached to PERF events this is mandatory as the
-	 * perf NMI can hit any arbitrary code sequence.
-	 *
-	 * All other trace types using non-preallocated per-cpu hash maps are
-	 * unsafe as well because tracepoint or kprobes can be inside locked
-	 * regions of the per-cpu memory allocator or at a place where a
-	 * recursion into the per-cpu memory allocator would see inconsistent
-	 * state. Non per-cpu hash maps are using bpf_mem_alloc-tor which is
-	 * safe to use from kprobe/fentry and in RT.
-	 *
-	 * On RT enabled kernels run-time allocation of all trace type
-	 * programs is strictly prohibited due to lock type constraints. On
-	 * !RT kernels it is allowed for backwards compatibility reasons for
-	 * now, but warnings are emitted so developers are made aware of
-	 * the unsafety and can fix their programs before this is enforced.
-	 */
-	if (is_tracing_prog_type(prog_type) && !is_preallocated_map(map)) {
-		if (prog_type == BPF_PROG_TYPE_PERF_EVENT) {
-			/* perf_event bpf progs have to use preallocated hash maps
-			 * because non-prealloc is still relying on call_rcu to free
-			 * elements.
-			 */
-			verbose(env, "perf_event programs can only use preallocated hash map\n");
-			return -EINVAL;
-		}
-		if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
-		    (map->inner_map_meta &&
-		     map->inner_map_meta->map_type == BPF_MAP_TYPE_PERCPU_HASH)) {
-			if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-				verbose(env,
-					"trace type programs can only use preallocated per-cpu hash map\n");
-				return -EINVAL;
-			}
-			WARN_ONCE(1, "trace type BPF program uses run-time allocation\n");
-			verbose(env,
-				"trace type programs with run-time allocated per-cpu hash maps are unsafe."
-				" Switch to preallocated hash maps.\n");
-		}
-	}
 
 	if (map_value_has_spin_lock(map)) {
 		if (prog_type == BPF_PROG_TYPE_SOCKET_FILTER) {
-- 
2.30.2

