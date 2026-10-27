Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793127856;
	b=q7488hMUsTVu80mf/YKiYRPsf93JMyyph+rv6oCjiWHBDoXnpj0wSJbMbtKEbTNIsrIM
	 nrdK/vi1UTAq0aIFXOkypvMNJ1UYOlQObgmp14EzYLDzOK3k/OMTqNsF+pM2u5ZZMAV9K
	 62xM58Pk7FtLR6SgEFpTuWNVisGdQAj+G9GeMbL/xw1oDxZbS0IOGXqycByk6m5EZnq0J
	 jLPeLUXeDJ5s/tb03EdAajg/gixOxZE8lp9YSbp6985DvVC6w4fcDR77MtKwWaW4CcP6l
	 03muChLpH3k7Yj2KX2c4kis87iozegZyoFJOt9BSRaCE4hqxE0vkAThX+FSp261jG+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4Bd7SBb/wIPJpDtgoXODBVAAsqVnwWRhD7f9lSm3ZIU=;
	b=3XB7hgXrvctbu2TDtiywxE+9kdp5pEzxIFd6zAetrOtHmZnY/qcpxWJAUxps4wd+44Kh
	 Jl1Zdr/KlWBBWUsfDMXAREapgeojVn3r66NyFk8g/DnQYYWCHAD7gWYAR59Swj79meFXY
	 uQpxpZ8RWrj2j1kR/XIZjUkyQjCfugnFfj1R+hKctUYPBKXbbeCd3B/MrmfgVYKsvNY3Q
	 0ewi5dJc1EPk0AJYS3vjn0EH2wINEeuziKnMR5q27oi2pTlQPhn4+XejLJ5nHXmNjylY8
	 2/MteUEHdXCzse539I+0fvLGRbkdEppn1cVjfzw9lNnD7PKbJLi7m/nMvfgH2ZQjNMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BKv5DFZA;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E313F606A326
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E313F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BKv5DFZA
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ae0852df46so164726a91.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793127855; x=1793732655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Bd7SBb/wIPJpDtgoXODBVAAsqVnwWRhD7f9lSm3ZIU=;
        b=BKv5DFZAuxmiM7dyeHHkRuOM7lcCThBlg9lywsbbBKsLdYQsqefBp2pKr5UoWvmGfM
         REaGnZZ2Zteh2C7Ywof6iN+FaugtxabFGRFFUI0JGa+ZMgWOtBOwPWZvQYboX5BclQft
         VtUrA8LZYmEHfBprMpf9zVOJwXu5MFsokN+QEkB4dBCO3oKUz/ntYAbPqM/k4VCO53lu
         UjI/L0GCw/yoGC5j82WXxyYgeCesCOxjMBP5U/vpFd57ZVsh/8xOe9VwUR8K9S2RJcl+
         cL9TDVhgOPCS+RGilljs6dtg/0Qy1E1PUDhUPWQTey33CSBJajsp92NBP6MMVUvKCjBt
         8a8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793127855; x=1793732655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Bd7SBb/wIPJpDtgoXODBVAAsqVnwWRhD7f9lSm3ZIU=;
        b=L6tdGzdnh7mwDC8CWsYmPJTHLqc/19BxebOjUk/252sAKX0WyOMXen7bFnC0WLK98R
         fDuU+bJ+Q3T1vIlmfoHRwMOCEzuYaw7TtWOkX1yEq6dHf+yAHRbaUcl6DVuSj5Y05ncF
         vi8xZ4mkY+F+So7X32TtEX4jJkNnr+pp4KRkHPupN0Rt3oW8uSGr7J++GU3jrfOHkgqG
         vvWsNOg7ZyN5XWpsJVYxDnQin2fSDWVjfBRbfj1beels51GhTlOsdJQbhTOuW5ZXVZg6
         peEqBdwTxUgtBEtJyR2E0/ZrymjAhcZmQ9g/Ud4dBX7Zwz93KZ+T4WscttiNJaXLWeEY
         b1tw==
X-Gm-Message-State: AFq9FYJRCTirFYyYGBdXbW6wqLo399UUrWAFCin+3su+qk7TxdPm5jCJ
	bLmACHItPoE/MPxNtq1icU+j10lsFF9K0PeaL9SPlKKwEZZmP506P27nUYw06Q==
X-Gm-Gg: AYBFou2mdPlY/ZI2qOCEf4hW+CGXFU3mkteJIs2Xi9xOx7NBYY54XRDjft2CW02L4EN
	Hvb6razhiG3TwCeltdkTpTuf2mM4ngVfgb0YiRx4dcUTP0ZinyABPlrhhJQx4aIpK15xvbaNLb7
	TGVfR++QYSVPTJYPnlSmS+giAMHu2zqnZUte/IpM7dcaJW8Bnc4wvZAGGM83EDdTTv0E4EJA8GE
	Fv8cwTXe/0Vs5Y8xgrDSBI+vOXTjb5eNZe9Hen4dFyHVjVYGiLzCRRM3uVR7lAF1RO8/YPMS0PV
	dxVY/xxv3dj4m7puCtkZ9sheZyVhF1uvDn7v0IyQKGLJ98dF+QznOvQ9K1DxSRKjPL9KFKGWTFI
	rnD5ETXMyDSt5aXokNJJ6psnQEE5u2TEnYMaafqbIZAzjGBgw0fPlBPN+wQ5KSCnlcPAaieHZz3
	CQYJybyXGJFaYWyzvaC2twX11VdwBSrKMO6dcLFUNtOdP+hVfWnTNC6esiDShX3fydzd1BCjZr5
	ozAq1U7kBg8hxZZBfVqluJI7p7uzTeUEaYcIismefCCsu5E2H6DhrJR/H+qTE91hG0Srxg0DkCj
	Vf9BckYoOfDriR7M2cp07ZK3K4VT4fLcY2PbLHC/YIlBHpwY9qBrvsUzWTfTmBbIgcKe0PcSZvv
	ZYZMJGngXE7mTnO/qBRzv7tVt
X-Received: by 2002:a17:90b:3ec9:b0:3ab:d26b:c2df with SMTP id 98e67ed59e1d1-3ae5812a404mr2113a91.27.1793127855156;
        Tue, 27 Oct 2026 12:04:15 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae579db47fsm37929a91.3.2026.10.27.12.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:04:14 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf 10/19] selftests/bpf: Avoid a page fault in rcu_reentry while the handler is armed
Date: Tue, 27 Oct 2026 19:03:05 +0000
Message-ID: <20261027190314.1440199-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
References: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The test arms a handler at rcu_segcblist_enqueue() for its thread. Then it
deletes an element of a task storage map. The delete gets to
rcu_segcblist_enqueue(), and the handler does a nested delete there.

The handler fires at the first rcu_segcblist_enqueue() in the thread. A
page fault can be the first:

  skel->bss->target_pid = tid      the handler is armed
  the next insn                    is in a page that is not in memory
    asm_exc_page_fault
      filemap_fault
        v9fs_issue_read
          p9_req_put
            irq_work_run
              rcu_defer_drain
                rcu_segcblist_enqueue
                  the handler deletes the element
  bpf_map_delete_elem()            -ENOENT

  test_rcu_reentry:FAIL:boot_delete unexpected error: -2 (errno 2)

The result depends on the layout of test_progs. In the binary that failed,
test_rcu_reentry() crosses the end of a page immediately after the store.
This binary fails each time when it is on 9p. A copy of the same file on
ext4 passes.

Move the store and the delete to a function. Call it one time without a pid
and with a bad fd. This call brings the text and .bss into memory, and it
does not arm the handler.

Fixes: 0464f587c61a ("selftests/bpf: Add a call_srcu() re-entry reproducer")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/rcu_reentry.c    | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_reentry.c b/tools/testing/selftests/bpf/prog_tests/rcu_reentry.c
index de23a14b3d40..10b4ea913921 100644
--- a/tools/testing/selftests/bpf/prog_tests/rcu_reentry.c
+++ b/tools/testing/selftests/bpf/prog_tests/rcu_reentry.c
@@ -23,10 +23,17 @@ static bool have_tree_srcu(void)
 	return kallsyms_find("srcu_expedite_current", &addr) == 0;
 }
 
+/* Arm the handler for this thread, then trigger call_rcu_tasks_trace(). */
+static noinline int arm_and_delete(struct rcu_reentry *skel, int pid, int map_fd, int *pidfd)
+{
+	skel->bss->target_pid = pid;
+	return bpf_map_delete_elem(map_fd, pidfd);
+}
+
 void test_rcu_reentry(void)
 {
 	struct rcu_reentry *skel;
-	int err, pidfd = -1, map_fd;
+	int err, pidfd = -1, bad_fd = -1, map_fd;
 	cpu_set_t set, old_set;
 	bool affinity_saved;
 	__u64 val = 1;
@@ -63,9 +70,13 @@ void test_rcu_reentry(void)
 	if (!ASSERT_OK(err, "boot_create"))
 		goto restore;
 
-	/* Arm the handler for this thread, then trigger call_rcu_tasks_trace(). */
-	skel->bss->target_pid = syscall(__NR_gettid);
-	err = bpf_map_delete_elem(map_fd, &pidfd);
+	/*
+	 * The handler fires at the first rcu_segcblist_enqueue() in this thread, and it deletes
+	 * the element. A page fault can get there too, when the file system reads the page.
+	 * Go through the same code first, without a pid, to bring its text and .bss in.
+	 */
+	arm_and_delete(skel, 0, map_fd, &bad_fd);
+	err = arm_and_delete(skel, syscall(__NR_gettid), map_fd, &pidfd);
 	if (!ASSERT_OK(err, "boot_delete"))
 		goto restore;
 
-- 
2.55.0

