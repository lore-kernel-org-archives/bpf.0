Received: from mta1.migadu.com (out-242.mta1.migadu.com [95.215.58.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F3DF6C
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 00:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787184407; cv=none; b=K7mK3FBXXZz3+MadXOPP0U9TxI0xYETGE37H5TcTwhyDnNdvZA4KPkNKe1CqIRHSLdwyNuDaZiqhjmwWN6IV/AR+Ps2z8oAw4uK8L2i0dzaAMQmplwOlvg3kf81KomEZ5D+4kFv/0ppnUBvFaSoZI57hvS7KbKcFZq2QlgOvoHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787184407; c=relaxed/simple;
	bh=gR5lXPLc9vfaIbqC7fExLn+NcQM0QYa0WDm8PnbxO98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EaV2w4BxTnyKk1RT+pkGrhkl0ME3jzr+mLZLd7/MzE8rAZ7NeyD1TyUWyANXtz3IVx33sLXtN2HnQdwauglU53tbbxJPvlZaMjEK9uszFmQSonad1BEwmLqIZf55tMvgKzym1fDEC/rmd6GkcQ1ervnfnra/ZfeMNdbGwIzyaIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SiiNO0k/; arc=none smtp.client-ip=95.215.58.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SiiNO0k/"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gR5lXPLc9vfaIbqC7fExLn+NcQM0QYa0WDm8PnbxO98=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787184402; v=1; x=1787789202;
 b=SiiNO0k/26RO7uc5/e4aU3ij4v5hjmY41Hi5fUmRiSAygRKdfBJCoCeEMSBpqBKkSlihaVVM
 TCkoOdrRvgqxoFsCGLuwthw5fw7PUmW6SXKxFlJkMFVvV4Vn3cZxDZ1E64bz7wQJaB9L2l+ueqC
 sm3eC8yRriWwLR/VWAyxdfdU=
X-Envelope-To: bpf@vger.kernel.org
Received: from isolodrai-fedora-MJ0FVMD1.thefacebook.com (2620:10d:c090:500::5:942a)
	by mta11.migadu.com with ESMTPS id 05d2717b1b930804;
	Thu, 20 Aug 2026 00:06:42 +0000
X-Mizu-Trace-ID: 05d2717b1b930804
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next v1 1/4] selftests/bpf: NUL-terminate bpftool command output
Date: Wed, 19 Aug 2026 17:06:24 -0700
Message-ID: <20260820000627.3826188-2-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820000627.3826188-1-ihor.solodrai@linux.dev>
References: <20260820000627.3826188-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

run_command() writes a bpftool command's output into a caller-supplied
buffer, and every caller treats that buffer as a C string.

However fread() reports a byte count and doesn't terminate the
string. The helper does not terminate either, so callers have to zero
the buffer first. prog_tests/bpftool_metadata.c does not, for example.

Read one byte less and terminate in the helper.

Fixes: f21fae577446 ("selftests/bpf: Add a few helpers for bpftool testing")
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/bpftool_helpers.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpftool_helpers.c b/tools/testing/selftests/bpf/bpftool_helpers.c
index 0a2a4f0a2794..c49fdd90eb03 100644
--- a/tools/testing/selftests/bpf/bpftool_helpers.c
+++ b/tools/testing/selftests/bpf/bpftool_helpers.c
@@ -53,6 +53,7 @@ static int run_command(char *args, char *output_buf, size_t output_max_len)
 	static char bpftool_path[PATH_MAX] = {};
 	bool suppress_output = !(output_buf && output_max_len);
 	char command[BPFTOOL_FULL_CMD_MAX_LEN];
+	size_t n;
 	FILE *f;
 	int ret;
 
@@ -68,8 +69,10 @@ static int run_command(char *args, char *output_buf, size_t output_max_len)
 	if (!f)
 		return 1;
 
-	if (!suppress_output)
-		fread(output_buf, 1, output_max_len, f);
+	if (!suppress_output) {
+		n = fread(output_buf, 1, output_max_len - 1, f);
+		output_buf[n] = '\0';
+	}
 	ret = pclose(f);
 
 	return ret;
-- 
2.55.0

