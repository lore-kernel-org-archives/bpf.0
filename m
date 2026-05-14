Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5823F65F9;
	Thu, 14 May 2026 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766857; cv=none; b=JB/ngSMQf/i9kSBtdXKpnroWss4IgTUAT/4Bz4Dt4BXbSFkXEzRZ7m+tgbIW8jzaAgN98ZrVlwQKEpBjcLJKvGBfTEWv4jYfOhSWugJf87u/eIGgDSLE5ayRajixehiRP5Rua70wO0Ba5wuYAh2C3ITdJJ9sveriACAEBNqT3tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766857; c=relaxed/simple;
	bh=4e3RD7CJs5riTDF45sJ+aiTLvx8NWQ9y2KW8eoFGhcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYg0nkKl1yZhESv7HtyO5Xeesp1Y2GBJo/fx+z9mr/HskIF6zwR7Rhr43nNP5Fgp5td5Bj6EKKNdoVXipZn5C9ptGaf5ZsikcECaTgpgbYRhZ6sWmpBXfHGwFrCSA1fXTmgpv6mHs0BAmziXMhB3RddcajKy+0r3WJRE+pfbczQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQ1oKxki; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQ1oKxki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9162FC2BCC7;
	Thu, 14 May 2026 13:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778766857;
	bh=4e3RD7CJs5riTDF45sJ+aiTLvx8NWQ9y2KW8eoFGhcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQ1oKxkiJRR8hbpDljToaf7kmV8VAqewUMOE2ZsBhOrVajCmMibJQB9pRYhI9SrD6
	 BoF1mrKZH6Akz2CUzuSgoe0FGxtX8Q/TbjxXtJaLqPjNXF5ML8KQgGevuhVKvOh8Gf
	 iqcd3tNWsqw7DvPiUoE3so2WANAlqV4PtuGC4d87NitZJW1Ai9DX/LJNIRRJlhiX0a
	 1dtD6VHZouqGke1lvC4516ZKMdz+nUs4bGb9r/iOTcb4JXqAtTPY8GPhrFyX9ZR/LC
	 N76YLFwZJup5goSxVwM2Fqv5JfPMoyb332qWIWDnc5JkFJ8TzZS5qlCMbL+QpDyeDJ
	 fYmfKa+uqozAg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 3/7] selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
Date: Thu, 14 May 2026 15:53:38 +0200
Message-ID: <20260514135342.22130-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514135342.22130-1-jolsa@kernel.org>
References: <20260514135342.22130-1-jolsa@kernel.org>
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

