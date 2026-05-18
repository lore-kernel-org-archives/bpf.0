Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725773DDDD0;
	Mon, 18 May 2026 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102060; cv=none; b=ehZe8msPER3w3cXiNGtAaCt4pEsaS4CAg9DGMGG/Pp0JHs36UE70xp3U8DMsjODqNb0fErXLEi0BmhrNCJClsggyJGH6J6y939Y9MTUTiNM/Nlbt3gBP2TAE9x4igUOmESJXA8TEyUGOQum1KaKcT2xHHC6+cwBez4U/u+XGpJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102060; c=relaxed/simple;
	bh=4e3RD7CJs5riTDF45sJ+aiTLvx8NWQ9y2KW8eoFGhcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmPu1FDyZRCUJCZLl2N0NyEmQdyhnkS1mt4RbZvn4diuHVE+T04/BqTxHAgRCt868PZ3Z9xULdKDFnX/Yf6k/+nfb9ZaYNvO2pxjgdowe4EcFCSrEe7N6HA6ED+gVFDu0XIilL2ENrNTP6VY/GrjPM+mFqbt4/F9HqsYoIgpgKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aq5x4iaE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aq5x4iaE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6621AC2BCB7;
	Mon, 18 May 2026 11:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779102059;
	bh=4e3RD7CJs5riTDF45sJ+aiTLvx8NWQ9y2KW8eoFGhcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aq5x4iaEb8JK1LLoV8YQtMH5tMI1CROfDNmj1mmS+OqP1foYiafr0MyVbusiXUez5
	 WWm6mtwahTG4/G/EAQxNE0Ci0eClxVzy4bztGEJcadlz23G/uVTgKxYziJBxdQ4xsv
	 j9rW1fVReLncXh/jW1Owpzfkdpg6hkAqcvrRPyPf5fLD9ytiMvakYV+gPzbnWuRAc8
	 Y5thu+D6iylQZ3JbblDDmpmG8ysb+fjrkrvrXMUSK8vHRpkj7HfRwS7PIgAIgmWsro
	 uoy+p73V72thdCZGPwVioFsDBIDDBITxOZNEgFsnWAFb5wm48K0J49AsATeX/SZB04
	 ORguIpZ3XGneA==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv2 06/11] selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
Date: Mon, 18 May 2026 12:59:52 +0200
Message-ID: <20260518105957.123445-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518105957.123445-1-jolsa@kernel.org>
References: <20260518105957.123445-1-jolsa@kernel.org>
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

[1] TBD
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/usdt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/usdt.h b/tools/testing/selftests/bpf/usdt.h
index c71e21df38b3..d359663b9c32 100644
--- a/tools/testing/selftests/bpf/usdt.h
+++ b/tools/testing/selftests/bpf/usdt.h
@@ -313,7 +313,7 @@ struct usdt_sema { volatile unsigned short active; };
 #if defined(__ia64__) || defined(__s390__) || defined(__s390x__)
 #define USDT_NOP			nop 0
 #elif defined(__x86_64__)
-#define USDT_NOP                       .byte 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x0 /* nop, nop5 */
+#define USDT_NOP                       .byte 0x90, 0x66, 0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 /* nop, nop10 */
 #else
 #define USDT_NOP			nop
 #endif
-- 
2.53.0

