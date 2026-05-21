Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1F1357D13;
	Thu, 21 May 2026 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367525; cv=none; b=fVEzqLjhbeb46na84le6BfgOm+u+O+rbuuKbWCjZbHD4pq0tR/SiYPwGtP0bech294QDV49W5M5P42GtizShApsYNBt4XK2HlPy3ZKPcP2HMSyuPOwG3BfOmm17tRfQymrqqPg3MX4VW85qttNjWS5pyZIevTkZdpv01esx1SFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367525; c=relaxed/simple;
	bh=D3G8xqQjxulIMhM2HLMhWFuh6YROs9wTnoZSr7ZV0Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lG2ZZjNdnyeQem0BwYhXH1LHBJmFClvi+o+mxL3yHm2pdFKcw0C04NVmCDJBvW4XchUr5OFs5wWmTfEptUv6eHp/AEQyIryaDY8Oz08dwNFukpi2yodUtAm/29QS7cD9xRPKFI44ZNDjghUmQ7ziulwla5e0Pgr1IEurkBhnYkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HA2FOVyi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HA2FOVyi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16E71F000E9;
	Thu, 21 May 2026 12:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779367524;
	bh=muLeud3BLmSrMGFpiZkFDpvBuLSP8/hU5ItTta/mTbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HA2FOVyiTS/RsfjJQmdyYplBj+91XnkefMA7ziA2E51Z97lf4VbUcg0XqEcSj7oCc
	 HG5WdlY5VLAcA4qiwVacYFcK88030srSxqbEkgtrhyMOPT8phZPf6G/BrRcKlAEURd
	 4bh10Oyw7h3FBsHQtMVt94LzwqP0D2qzuqSmZjcH1e2GiON1C12Gj8XkMefO5qCGlo
	 rk0Tehg2dYWbtNznnZ2nRWG9dK2MOM3f1g+ySzSXAJS/1e8Yn1A9uWXWRDgrlKcnwp
	 1HzcoPEs3/9G86twZwtm67XVRid1UG8e2ciMn70EWnm8fSk27lnzS6b3Q9fXoRjPgN
	 ZYEn6ANfDVC6g==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv3 07/12] selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
Date: Thu, 21 May 2026 14:44:06 +0200
Message-ID: <20260521124411.31133-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521124411.31133-1-jolsa@kernel.org>
References: <20260521124411.31133-1-jolsa@kernel.org>
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
2.53.0

