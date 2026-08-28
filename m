Received: from mta0.migadu.com (out-131.mta0.migadu.com [91.218.175.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085AD3955F7
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787953954; cv=none; b=MjQI9KzQgimBHCP8WO5xwOt8a7tUETit+QvOhP8gWN1zfzNhoHUi2wcjnTLgcrkkV0lCt836Su6i3XTKIWSyIYWd9KBPbWVjA0vE+tngdWaC3Z7/BSfFz0xeqr2bY6uq/WcHhCyfEcQ4b3Ok8yliO4CO/10Xss3cv4mHSQFPxG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787953954; c=relaxed/simple;
	bh=XhMNdur0mR9N7zXM4n4hm/ZvNoYiLMHCBkxWTgCP+nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ozxvy5KqMjdiSj07+07XflpCVZ6dnEZyGFmyVVkInUsipM30eKOCWbJubYQKMJ0Sx0Ceib4ud2vFi5ZQfAvRvS0u6hEXeuWPV0Zd5W3By71vJpHznGhK37gJYoQRHpMv02+K5iOB4Iknojvk9znjArNfD/XHH8Ao+xFTUbDbTEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EqRTeIoF; arc=none smtp.client-ip=91.218.175.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EqRTeIoF"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XhMNdur0mR9N7zXM4n4hm/ZvNoYiLMHCBkxWTgCP+nQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787953951; v=1; x=1788558751;
 b=EqRTeIoF/VZ9veszvQ6VDdGjgWAiWsi4qXuVzjawSZg4LlSse+L5w+oCDBwdWJdaoCFp1TC5
 +GgqEiCqdtwWWE1qAwd4P7f9ZBZzc9uAbLXfLxPUkhPV+T6OAq9FQF3SRSnAhl4oBfbqi0WCwbr
 RLT45gB1+o2huQb0z0xFO0h0=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id e83447fb8f14049f;
	Fri, 28 Aug 2026 21:52:31 +0000
X-Mizu-Trace-ID: e83447fb8f14049f
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 4/6] selftests/bpf: NUL-terminate bpftool command output
Date: Fri, 28 Aug 2026 14:52:05 -0700
Message-ID: <20260828215207.3105313-5-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828215207.3105313-1-ihor.solodrai@linux.dev>
References: <20260828215207.3105313-1-ihor.solodrai@linux.dev>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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

