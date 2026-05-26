Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D6F3C197F;
	Tue, 26 May 2026 20:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779829200; cv=none; b=LPBSEY3kM3fB6276PFGSaTfyPz1eKrITCo5V9a139B0KrDf12JYeu7BpgHkYQqgGWarTf97fkmIsOkhFsl0vyRqDyHAA1vdkzYoFOyxNK72+Xk5GODYBAB9/fdG7YbYvr72Z6dVWldVuJhKeFsxNMUhUSNxQ+Y5JM3Pl4liayzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779829200; c=relaxed/simple;
	bh=nmnXOS7eAb/+qx/rVlnbGfjDPGW6H6UyJnkkB6UAGn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3EQeoRyKwhEn1zKe7QMYyOsrAojajhdS+Y5k+UMELTV8gc6yrG5nHxPFr2z1zNwT0JTY03RSbg2ythG3NzM5SdZpGLAsxeE5rw8Z2kA59eN4oa0vgnp7n5oVBuLr4QK5s1j4o8xd+0we4nxsTllzKAcFAvxQ1/Lf3zczeJvYdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYATIZKb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYATIZKb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84D81F000E9;
	Tue, 26 May 2026 20:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779829199;
	bh=WBLw/3Dgjn1AFQz5j+xOU3Lx44NupKqGdqngWQoVYVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZYATIZKbbZVgLVTNirtw21H8HaVCHcsRi+ONOFRrtTsVrZEoZzcl8eMKgXZhShHDy
	 pgDDYRt7D2YQxToU0to9TjseEbTY8yWRP991Kb+YKkr4fnt5JR2h/ThzG+zg/WqZ63
	 Io9mxdPWSeno6bKdCbcJmESjcMleSTLSCxpddKsDJQBo2gLBQipwfbd5xsWBp+n/Nz
	 2tb+0yyv/UMXrkcQIOBUV4ikT+vWPA1u4CyOoD/OCzSXp0kCB67nxgWmv/ShCk3Sso
	 CkiKrpye41Rmz73h4DCQ3gq9MXi9p8Vne25612DL1Xo2mc8hy0qFkPtXReouxk+sl8
	 /16zXZ/elgVkQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv4 08/13] selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
Date: Tue, 26 May 2026 22:58:35 +0200
Message-ID: <20260526205840.173790-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526205840.173790-1-jolsa@kernel.org>
References: <20260526205840.173790-1-jolsa@kernel.org>
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

