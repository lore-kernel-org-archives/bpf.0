Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC9543934A
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121147; cv=none; b=MPRnbzhjYmI5RygzgsPaisSBmD2OsCLs6xm68atWnlf/Tvvj0FC5LGcua2lGDbHQ+LusZ0v4ZVnzbTAIpkzixn+nhhF3NZOA8ViQpU2m6G3v4uzXsnpeOSzONTixnFri1uR0kgs2+v5+wfjyjk+ne8v6uI9ynjKw2soMEjHteho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121147; c=relaxed/simple;
	bh=xLSnSBihvDrvW+A933Mf/K8RFNBxlYOR7AeDxV0fPw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DyWGwCizFOXgYTHZ4iENdku1ohZ1ztKAQ5D+i3Zq44Uq8LVReBPQijUysxYoGUeYoQ5AdwNJEhM27okrEBlXP0efk4PKbDZEDuQJCzurN35vqm7e1IWK7j8mvuGNRxjE2KXwvQ+DdVTtNrdfuN5WavCgGWc55zL0MSjlk8A4UX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aV2s/U/E; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aV2s/U/E"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso628075a12.3
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121146; x=1791725946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=93e/6hg8u2VtTkLEl/UGnhtZytP3HWPRSIhsV30hl8g=;
        b=aV2s/U/EyoBlPMii/cQ17evf9Z8W96Z07X+lkHcWn0U3+JCRwvhsd8xwn6vYk6Xj7L
         cy1P9pcn3UDiyOIsSBNK+SVQtRhTO86EkXnp78ghhlr2ot4lT0NcVNhY0b5Ikd/4dDCV
         z1HmM4D1eluyFQzodCW+LKMmHB3hhp6ZzaP/9b97nE7TzKibl6eN2qeyQuDO41EpE9t2
         RgV/I+NLkkK43vtV7HTByVs4S+VK3CSnsCl18/UAUXDLIpdWGszI1B53DSH+CBnAPq9n
         v3VZP1C+A2uTUdU9Hp98sgfmxBpGhS+1iLfzbtxg1MOSTa33QpL5VY8mkxTDKJAtg4SD
         RM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121146; x=1791725946;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=93e/6hg8u2VtTkLEl/UGnhtZytP3HWPRSIhsV30hl8g=;
        b=1uWWqhPDhLtqxw4grrexPIoDo3Zs/YGQGTOszZFOt5vJoHD32PVPFjppPtUPoVj0I2
         YP5CSwz48/Z6MK/nhTz4JRNdwFU6UIDiRbOzYNZ0JYlNfOBk/9JnOdoMiw5kTt7nehCW
         nL6lfEDEskMYHv2XwuM3NlF73fUJy+0MjAYCzMeCU44HcMICDyir03QmX17Zvk+Y3fzd
         qmZ0WMNrLICjloVv6kXKK14FtAi5FrLWlMMI2NVucTn9v0wDLUwQ0WgheSgwwsEpZdMz
         ir8uj+oWSbkYg5nNXPNcQBy+BJXCEb8Z7pHgF2h7REqrScuJO40EYnIcu+Xq7aWiRAgo
         fwog==
X-Gm-Message-State: AFuF++liQeGH8917BSKGBH4cVgFbre9gL5RVyOdb+dlZR2I7WKtbzkj6
	XeCL4aAVjkfNBgNSH3g7wdK83lQN0WdQYKlrgVx+XC4EVll8YWwjqeRJPzr4dQ==
X-Gm-Gg: AYBFou2puEWTlXB/rM9EAS+9IuTl6G2rS7hu22dWtlsBTUL3gG2+n6dhTxXiBP1MH1l
	mJQu4gi2904F0UYFjDxnewoOFUA33alIhtvxH1oncDkwKMllm3OG20JeySrx4t0YkO52U4mNTSf
	JzwtNWAAE7yijdyEHwnl2zshfVqdSddXweC0FAbQkaGos96GHalM6ihZX0YGvQaXJKx57T6f7yv
	OtNajfZemAqywp3EskkusjfN4RCXUU2co9QNy/WpwNGqZCn5tWGM0ToYWLrRQSxVYuZh7knBz6J
	8a3z4x+Kcmi0IbWwdgKFC8GKoK3WL1wlEVYNNxoC5J5LmKZmzw/xIcliUT3XLDKwvKqiWEX3fzA
	TxCCTF2/FM1HrozNpsNbyAF4fso7OhruZ2k1Dh+OiLYl67DJ7FqY4OuyHq0uHJ8EinXSEfeQ+er
	SZDEWWm8mY4qt/dz9ezf2GIkI+ilrGAjamVhFGTh3comLLJPKGiPuLg0V+/XykOIzIw/yEBsJls
	T627ggjyuNeSg8=
X-Received: by 2002:a05:6a20:6a24:b0:3da:1fc0:fb07 with SMTP id adf61e73a8af0-3e0d68c3908mr4653994637.6.1791121146101;
        Sun, 04 Oct 2026 06:39:06 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:39:05 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 32/43] selftests/bpf: __msg_next tag for matching messages on consecutive lines
Date: Sun,  4 Oct 2026 06:38:14 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-32-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Same as __msg, but expects the match on the line immediately after
the last match, not just any later line.
E.g.:

  __msg_next("a")
  __msg_next("c")

This would match consecutive output "a\n" "c\n",
but would not match output "a\n" "b\n" "c\n".

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  6 ++++++
 tools/testing/selftests/bpf/test_loader.c    | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index f3dbc3b59bff..d7f706c3bc4a 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -43,6 +43,10 @@
  * __msg_unpriv      Same as __msg but for unprivileged mode.
  * __not_msg_unpriv  Same as __not_msg but for unprivileged mode.
  *
+ * __msg_next        Same as __msg but expects the match to be on the next
+ * __msg_next_unpriv log line compared to the last match, not just some line
+ *                   after the last match.
+ *
  * __stderr          Message expected to be found in bpf stderr stream. The
  *                   same regex rules apply like __msg.
  * __stderr_unpriv   Same as __stderr but for unpriveleged mode.
@@ -145,6 +149,7 @@
 
 #define __msg(msg)		__test_tag("test_expect_msg=" msg)
 #define __not_msg(msg)		__test_tag("test_expect_not_msg=" msg)
+#define __msg_next(msg)		__test_tag("test_expect_msg_next=" msg)
 #define __xlated(msg)		__test_tag("test_expect_xlated=" msg)
 #define __jited(msg)		__test_tag("test_jited=" msg)
 #define __failure		__test_tag("test_expect_failure")
@@ -153,6 +158,7 @@
 #define __skip(reason)		__test_tag("test_skip=" reason)
 #define __msg_unpriv(msg)	__test_tag("test_expect_msg_unpriv=" msg)
 #define __not_msg_unpriv(msg)	__test_tag("test_expect_not_msg_unpriv=" msg)
+#define __msg_next_unpriv(msg)	__test_tag("test_expect_msg_next_unpriv=" msg)
 #define __xlated_unpriv(msg)	__test_tag("test_expect_xlated_unpriv=" msg)
 #define __jited_unpriv(msg)	__test_tag("test_jited_unpriv=" msg)
 #define __failure_unpriv	__test_tag("test_expect_failure_unpriv")
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index a89890cd56d8..6257bbedc4c0 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -508,6 +508,16 @@ static int parse_test_spec(struct test_loader *tester,
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
+		} else if ((msg = str_has_pfx(s, "test_expect_msg_next="))) {
+			err = __push_msg(msg, true, false, &spec->priv.expect_msgs);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= PRIV;
+		} else if ((msg = str_has_pfx(s, "test_expect_msg_next_unpriv="))) {
+			err = __push_msg(msg, true, false, &spec->unpriv.expect_msgs);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= UNPRIV;
 		} else if ((msg = str_has_pfx(s, "test_jited="))) {
 			if (arch_mask == 0) {
 				PRINT_FAIL("__jited used before __arch_*");

-- 
2.53.0
