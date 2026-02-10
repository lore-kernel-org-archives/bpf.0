Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297DE1DC198;
	Tue, 10 Feb 2026 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770730647; cv=none; b=YJ4WcQ9ULLtMmE2VzLUGkRI1y880eAR2OPCNClDpoZu84+8zY3HSxjbIIIInz0JGSu19ujW6MnpO28DVynLPv+y7WNiks8hbY9ttKoy62lPqAnrCvVo1e57XwDE+0NBvKpk/Ki0FeebRlk7/PaHyDULXlZiuPhqjquEW1upc1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770730647; c=relaxed/simple;
	bh=3n+AbcvciHPQzsJ1Ve5hHZjrNk7frJapa91/WlvFxa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmdDBHtJDq19KPS5CCYx9RBvRIihk2apA8y4V8QymXcJWB/zg7Oc/h6Xw5oLkaBl5zUF2p5P9wBxiI2adQBHYfuolRrLek5yin17woL+9bvFo/5U/cqm9y8ceAS5+yu9b5xoQNGPzll0yqE7y9ezy/DnIZsra4kCwzwE/fYn5B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3FVRcqI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3FVRcqI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DF7C116C6;
	Tue, 10 Feb 2026 13:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770730646;
	bh=3n+AbcvciHPQzsJ1Ve5hHZjrNk7frJapa91/WlvFxa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H3FVRcqIj97228QakmaZNDZiaCsXs7j3fjfHudfOMRU0BfuyFGhovp0gKnKpd0Jpy
	 TPMquBR8nOuPzEYkogyQuHrYWCnIBKdVchws8zRgc5q8rnDwSKctCNZAIviNKj7l6k
	 uesO7z3gCqp9pAGjikfGolFDKrK9N4ug65VvQCKZYw+gDLOJ6TGdUFfPoo6bt7w/Rl
	 OkWLy4XJNfObss/MmDalxGUyl3iK2GVAc1X1wfSE3x/5AP6PwQucsPf0jGlXrjLFXq
	 comwfq5I4/wGB3OTaYhVKy3O2cdwFhghQ+Yf1vyU4nbaL2y099ljXTgFLQqydZPV7R
	 DuFmOfoO5Pqog==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCHv2 bpf-next 3/5] selftests/bpf: Emit nop,no5 instructions combo for x86_64 arch
Date: Tue, 10 Feb 2026 14:36:47 +0100
Message-ID: <20260210133649.524292-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260210133649.524292-1-jolsa@kernel.org>
References: <20260210133649.524292-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syncing latest usdt.h change [1].

Now that we have no5 optimization support in kernel, let's emit
nop,nop5 for usdt probe. We leave it up to the library to use
desirable nop instruction.

[1] https://github.com/libbpf/usdt/commit/c9865d158984fb2b73e3cbbdcdfb4f583ad36a73
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/usdt.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/usdt.h b/tools/testing/selftests/bpf/usdt.h
index 549d1f774810..c71e21df38b3 100644
--- a/tools/testing/selftests/bpf/usdt.h
+++ b/tools/testing/selftests/bpf/usdt.h
@@ -312,6 +312,8 @@ struct usdt_sema { volatile unsigned short active; };
 #ifndef USDT_NOP
 #if defined(__ia64__) || defined(__s390__) || defined(__s390x__)
 #define USDT_NOP			nop 0
+#elif defined(__x86_64__)
+#define USDT_NOP                       .byte 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x0 /* nop, nop5 */
 #else
 #define USDT_NOP			nop
 #endif
-- 
2.53.0

