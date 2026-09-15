Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CE533939D;
	Tue, 15 Sep 2026 21:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789507890; cv=none; b=rV1Mr9RP0IxtcVy5C/CqBcLsGVj2lhFkV0U1YWBdO3DBIdoE26ywEcTixK2n0rKisViWJzVmwHRiunmICOXjHmtpdjRHQLBMjVC6HXN7Gy732ao99oct3UJ49lXJGmDILz9J5PJ0nEBIGmusDQEnRvJ35pi0c2g1kxr+maDRgz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789507890; c=relaxed/simple;
	bh=OJxsMQ6ZQJ7SWYYumh/4DErQLfAJldrNlpcb+KRcM8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NjP0FaFrGiPPPINC+wmZs5vPHiu3Aagh/IPLayf5N9e7WKbp0ELlP7JlDjXEjFlacnliCE3uSTd9jFqT1YI0MGAKOL4YB/lN3FMOxZ+wVXFFX7b+c1x0blX/znDfbBgoVsqzQdY9B/9Ah83WqYvHi30eBUBn9FMC11FKlXGdCoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuYydP5d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuYydP5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A741F000FF;
	Tue, 15 Sep 2026 21:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789507889;
	bh=5cIpGXQyOMZGECfn29f1JMi/DHmgaBMS8g9WpnNR+Jc=;
	h=From:To:Cc:Subject:Date;
	b=WuYydP5d0foxHqDA29SBJcAPtcwy8onZt5AqWPXb+H2VzQTgpKo7/k3G7sEqaWIhu
	 M38ztV87AoSCKAnJy/Tsgpng27Ce1DOIocLZgHV/seAfdH0rMQ+eXY1NN3vJU+TB5D
	 QlcEEfhPyqdl4rrpDnaoHbecszx7/ji5a3pnly/kt7dE+QD6jBV+FzstuuXLPGVdCC
	 Aj4vEawLG9fZglPppl8Vuvz+qBSKWv8lqq1kH+ZsTfAM5h2J3qL9IawKgblX+54wob
	 R0geyaCR90mDpxL5fSoTSSZQO2suiR1Q9Ed9kAbeJKP9ZpBPV6av+z9oRom4ZCsEzq
	 mD0cACV3E+4Ag==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	Kees Cook <kees+treewide@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] bpf: add printf attributes
Date: Tue, 15 Sep 2026 23:30:09 +0200
Message-ID: <20260915213123.2361066-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Building with extra warnings enabled shows a missing printf attribute:

kernel/bpf/diagnostics.c: In function 'bpf_diag_source':
kernel/bpf/diagnostics.c:828:9: error: function 'bpf_diag_source' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
  828 |         msg = bpf_diag_vfmt(env, fmt, args);

Add these to shut up the warning and allow the compiler to check the
format strings.

Fixes: b9c5d822f677 ("bpf: Add source and instruction diagnostic context")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2 changes:
 - only change the one function that needs it
 - fix line wrapping
 - use correct Fixes tag
---
 kernel/bpf/diagnostics.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index a2cac59c6639..48ea3ac23b63 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -794,8 +794,9 @@ static void diag_print_insn_context(struct bpf_verifier_env *env, u32 insn_idx,
 	}
 }
 
-static void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const char *label,
-			    const char *fmt, ...)
+static __printf(4, 5) void bpf_diag_source(struct bpf_verifier_env *env,
+					   u32 insn_idx, const char *label,
+					   const char *fmt, ...)
 {
 	struct bpf_diag_scratch *scratch;
 	struct bpf_linfo_source *source_lines;
-- 
2.53.0

