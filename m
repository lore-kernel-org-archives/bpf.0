Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE28E27C84E
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 00:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771374720; cv=none; b=rilxJn64IvbxYQXRw03xZhBzlQkyvhCusYNACJ6mTdfkK7IlRmCLX0FoqcHq8w3t8G0reynu7O4plNjmizeHkbr2VMxFmpv/HrgY2F5f3o8IL9Ul+6PXJDwHzo4723SR9ugBQkrFA1HxB8ZnmN4DwwcnyrszwkkPqqd2WFAvWEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771374720; c=relaxed/simple;
	bh=3wBy1oGQuqnsbe8/SZfR5pqp8AkWaIySqBSseQ1CCcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9C08qCKsGLe31RzpjOGJyIzVNyp4aADfL4cWIUFuvjai3c+v+87eRNDmoj/jlK/b6PNeQnu1SgRkx8aEbHhtM4Gta38jVgw1JaRIlYYG2r17ahvUXRSiQFoCWoVnhq/hG4HByHeh15SmQ66KH/fHhjhWOGXS1c1h0LbCQfoFfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kmzPTeal; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kmzPTeal"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771374717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2xLOSBsD98PduL0Z57WRWswEy89xF176xk/7vXpEbU=;
	b=kmzPTeal4Ua+OGrLudPBFFNT/ce25/v5qq+f465WSpgslD5outDfPX+GNWUj8DDrX7sRpK
	S3hbvjxBSt63Z7STPnl9GAJbdkrzfvDHgQVuH9UEgSbJIA0myZOUQ04KTry0F3CmyM3bbB
	ug4Y1Z3u71SEZe1MIJWSYLNLDAgzW2U=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v2 15/15] selftests/bpf: Don't override SIGSEGV handler with ASAN
Date: Tue, 17 Feb 2026 16:30:41 -0800
Message-ID: <20260218003041.1156774-16-ihor.solodrai@linux.dev>
In-Reply-To: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
References: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

test_progs has custom SIGSEGV handler, which interferes with the
address sanitizer [1]. Add an #ifndef to avoid this.

[1] https://lore.kernel.org/bpf/73d832948b01dbc0ebc60d85574bdf8537f3a810.camel@gmail.com/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/test_progs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 02a85dda30e6..b533cede933d 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1944,13 +1944,15 @@ int main(int argc, char **argv)
 		.parser = parse_arg,
 		.doc = argp_program_doc,
 	};
+	int err, i;
+
+#ifndef __SANITIZE_ADDRESS__
 	struct sigaction sigact = {
 		.sa_handler = crash_handler,
 		.sa_flags = SA_RESETHAND,
-		};
-	int err, i;
-
+	};
 	sigaction(SIGSEGV, &sigact, NULL);
+#endif
 
 	env.stdout_saved = stdout;
 	env.stderr_saved = stderr;
-- 
2.53.0

