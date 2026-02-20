Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7F02D130C;
	Fri, 20 Feb 2026 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584189; cv=none; b=lDqRoNVErGhCaUtpJVUFKK6VpdpeMEqOoUL8Nsvz17qCwBtMjr9KoGYMeJE+0TgbOWWSVz6eY/d9bhsfpW5jEKna1tLEzCOyPsYzPoK7zwBUvF8Hyk2FJeiHHLXAD1Wmj2NBCDpSAKuAiwQsypddiYfhtOD676j1wRdGCz9ecEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584189; c=relaxed/simple;
	bh=DQxx4sQpSRlmKFD8OqooGbohxZ8Wbb2yF5Xw1ruqRyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvZRigbvvI2JD8aWkNzDaaZB0QVHA2gIB8ZCDLf3hj/+gDx0/OrjpnQJ1mphlP5EZd2Bks+xYcG08jrsKrxn86gfWulR741oof7dx1w8lSpgad6aPDjIfqGY4eeOZiIpCKa7UiLZgeSg5RIZxtSWKP295FTIHZc4R9JctAWyDgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c17VmpJu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c17VmpJu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2749DC116C6;
	Fri, 20 Feb 2026 10:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771584189;
	bh=DQxx4sQpSRlmKFD8OqooGbohxZ8Wbb2yF5Xw1ruqRyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c17VmpJuz11GwbeiO26NDPg7IgheqQRKiXnsmr46h8QbVl6rPABErdqI7J1FOmlJY
	 ww545R3gFhNIfiupFxard4MzIsvM7Bv9oEsdAa55ArP70sBK1i+WbCptSlW6opQsrH
	 pn75GppporEs2rOnxiVvwa4LStcyG+66FiMDa8aWlksxkui0fkLkL4BN3oWG4Y2PRm
	 vcmuZDzS4grwZMbqsbEmkB0ibZwQoRmmNQu0UWfywvFwM2iY42baijV9Z9kbgLQgZj
	 NgPHn9vRaUMhP5C6kX+K/5t161LMnBkxFma+OMPPTkokw9MHvWupi8FedDD4RdS8IM
	 rgALCdjOJJb9g==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCHv4 bpf-next 3/5] selftests/bpf: Emit nop,nop5 instructions combo for x86_64 arch
Date: Fri, 20 Feb 2026 11:42:18 +0100
Message-ID: <20260220104220.634154-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220104220.634154-1-jolsa@kernel.org>
References: <20260220104220.634154-1-jolsa@kernel.org>
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

