Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6091B43C063;
	Wed,  1 Jul 2026 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904511; cv=none; b=OJq4v87JoHGqgZl1H73gWQqENlCXHu1uHaW9uPnNCmTjtEscPQh9XlYs2zdi9mHYg0j70azWNMh5HV4un76JLtX3ybIRK8opCNWRT0A66lAISqIUQ9+ox36pEZz5zeBHlUcb6PTwl4s5NhAyg7ymkZejOdLE9fVA/VJhiCTfvZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904511; c=relaxed/simple;
	bh=nmnXOS7eAb/+qx/rVlnbGfjDPGW6H6UyJnkkB6UAGn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ey5ghuOxX9e2lKQtrMCgf5vwUB5x81+sUM0o+IRljFlA+7Tm9fdmSGmO79/RwASkqljRQVB+j4StOzFnbkWSDyMYqrF1lByF8V9vvSmWLXx+J5OVCSgKE9PknDeDnfrFLiMW8oXLbyhnZXxYPr7HE1elPSCkDfdG6q/GS9ewgho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLbADVTa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLbADVTa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0211F000E9;
	Wed,  1 Jul 2026 11:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782904510;
	bh=WBLw/3Dgjn1AFQz5j+xOU3Lx44NupKqGdqngWQoVYVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eLbADVTau70MV/vR39ai+ITgCcnuCmWOTdTkeOw2ZAea5u8XwAvc4V0aQ/rZk5tEE
	 Z43MPCtNDK9boxbwkcUOB0uEZ/2csy4vLLTszbNsg39wjZ6jiHOqu+JOxoUZa5TyOg
	 OjdX2MmgTF64RkHbaTeOdLgDZ6JLq+gdtcv62vuC3kXk1Om61C9RQH35NDptQ3qWSX
	 G5yj+yxHYNBnRjUWiY1IZhVeoi+1BgSqg3SiqatfBcqMoPl3o/kQmyc+yDtOHXi27a
	 XcmMJxH4PgGRmXNIsIwaHPmCCOBkAAWAHQduSHen5XajknCKbiJh9zwga4kMtUPAAp
	 rQEKd/fIDUY8A==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv5 08/13] selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
Date: Wed,  1 Jul 2026 13:13:32 +0200
Message-ID: <20260701111337.53943-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701111337.53943-1-jolsa@kernel.org>
References: <20260701111337.53943-1-jolsa@kernel.org>
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

