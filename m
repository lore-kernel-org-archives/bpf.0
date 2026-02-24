Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8271C37882B;
	Tue, 24 Feb 2026 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929596; cv=none; b=Wwekm8NWNiGaohWpe61fogWs7g17TrO4YY1ELbLMXTZ/etma1meAipTyF1AeOZIg9GL/fCC7fQ7pI6VgOQDyc5RFw2G6hQr5OUfl0MDkBZL+Rmln5VPvflYTZwnwSnNvxAvyzi+karTIxglZymPHVHgdQSxSq3pnFP9+uh1X2Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929596; c=relaxed/simple;
	bh=DQxx4sQpSRlmKFD8OqooGbohxZ8Wbb2yF5Xw1ruqRyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMkysObCkxelkN2wG/t03aSmy+26H09HH0uti2B9klC7D2HqNfh+xkNw/iei4EnbiNcBD9rAl9ELWLJUQC6NdN6xQqeYMB8vSokgY3vjtIoFE5jR1N98g6uuVZRY9qngL7Q0+RIKUVfI8bcjPAuAghfiwAM4eAhHFj8igX+fIKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yr/DDsM0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yr/DDsM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C8AC116D0;
	Tue, 24 Feb 2026 10:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771929596;
	bh=DQxx4sQpSRlmKFD8OqooGbohxZ8Wbb2yF5Xw1ruqRyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yr/DDsM0i418Upb3pxpIfPelvII4Jxm9HoJwsghNv/ewikzEZoBRsLrGSK6AyYQPG
	 +NovTIJgTVwuOZ7keeANqUWpA/x76K1NozwTw9uh6ZM2T7/8YpxDGJUjae9ALUCc0A
	 oA1kWrl55G9IFX54h3fvZ+3dGg/7f+3mO6RDU9LaSwSWrlfHAFPzCbO9Np+QibyGyH
	 eAqPg+zcTauOfxp6i1gjQSCUizsZt1HvSP4obldMq6FS+wrowPBPaAAsf/MUAUsqon
	 XVeXoqrmJfD683x6Dbd5mpHQC5HzaCVbmYV4Kf0+B4bhZCg4wzOZH5vaV/1WyLyv1m
	 rHqwlwoKV5EOA==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCHv5 bpf-next 3/5] selftests/bpf: Emit nop,nop5 instructions combo for x86_64 arch
Date: Tue, 24 Feb 2026 11:39:13 +0100
Message-ID: <20260224103915.1369690-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224103915.1369690-1-jolsa@kernel.org>
References: <20260224103915.1369690-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syncing latest usdt.h change [1].

Now that we have nop5 optimization support in kernel, let's emit
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

