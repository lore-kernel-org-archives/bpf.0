Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7C23CAE84;
	Fri,  3 Jul 2026 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079459; cv=none; b=acixCZ7yN6OIlPMvrfpKuRH/OM84SxhKsC8J8mOQ5wmR4tHweL4RWfP2ct8FEkVTYNXHZUb4KfaaI+XPIenI9IFA1176O3Ux6tAhVLVwtPyrILpXKUjGngF/Bd8JAevh5rq0tXEa7EcujM+umShBXGbxKCvis4nGQz0ebOeP5fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079459; c=relaxed/simple;
	bh=2anvF2MBrTUymTlDnJlX3XamEte6wqwKAid41DAzUMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBNN1aUlDSAvo4bnCNq2ryZayLdoP2NoPysAMh/R+Lpbfv8ne6Q5jMKsh1odPF14sWhfD1mwTz0Qd6CLmQpHArsNTgKaE65hFxASGxD79OVlOTrxT+jpbdnPxFkIM1bslMGJ2lmqCyK+d+LimL1fLWa0tkEjdoUQZF4lPK61oII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kv49Bx9p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kv49Bx9p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C4C1F000E9;
	Fri,  3 Jul 2026 11:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783079458;
	bh=lYP28YNEMlDsReRQ3Q75CDsMRCj7szHwFdbQSIaG2lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kv49Bx9pDoUYEAVpPTIoeGiz8OetWtMzvT61/wq9jSbP4S8Dhgh+zKW6bKvDkPbOf
	 Y3d2HILmE54yK2tuW7hxbtzjs7wRVVZSUD0t/5g408jkFUUYirCsuTuABdcfgGll/P
	 awaUj6FBcRrUBklVQcimsacqJRwjKjXihnqbCQ4c6cIeWIs04tXo2v+4FLlGlcbKf9
	 OhgtnR8SZBv56DlmyXsy22Hx5Z9OezgvNs4LZ4NpXzMPpHRBoMvF/DFfgxiDeNpo0G
	 ud7GTSUBmbbOhWcfRh3fxKj2cbqCpL77N0JIqJRb8YwnyO0Sgdd7CMzPjLhF/WmJfG
	 Jwa2cQXhBKwXg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv6 08/13] selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
Date: Fri,  3 Jul 2026 13:49:12 +0200
Message-ID: <20260703114917.238144-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703114917.238144-1-jolsa@kernel.org>
References: <20260703114917.238144-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syncing latest usdt.h change [1].

Now that we have nop10 optimization support in kernel, let's emit
nop,nop10 for usdt probe. We leave it up to the library to use
desirable nop instruction.

[1] https://github.com/libbpf/usdt/commit/9018f82577d1dad7ed628d9efdaffc09f8f2241b
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/usdt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/usdt.h b/tools/testing/selftests/bpf/usdt.h
index c71e21df38b3..75687f50f4e2 100644
--- a/tools/testing/selftests/bpf/usdt.h
+++ b/tools/testing/selftests/bpf/usdt.h
@@ -313,7 +313,7 @@ struct usdt_sema { volatile unsigned short active; };
 #if defined(__ia64__) || defined(__s390__) || defined(__s390x__)
 #define USDT_NOP			nop 0
 #elif defined(__x86_64__)
-#define USDT_NOP                       .byte 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x0 /* nop, nop5 */
+#define USDT_NOP                       .byte 0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 /* nop, nop10 */
 #else
 #define USDT_NOP			nop
 #endif
-- 
2.54.0

