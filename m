Received: from mail-pz2-f32.google.com (mail-pz2-f32.google.com [74.125.228.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A11547884F
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432474; cv=none; b=i7CD2liNCUOLYeIMw+BOVmHRC2V1pD8MsudETuUdhmJjan2T3g6GeH4VYdNnrIVeysTbV/6g5opnLJUiHI2BKvqQMcUvFHK9cXmd2HPHzL2n3mfnKI73tKZl/v3cm58qypG4MZGwrCtqc4s/U4je3skyecVlOGw4SyBUL/qy5xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432474; c=relaxed/simple;
	bh=sc5b8lqwOyCjPhjuhrg3WjFNYtyMGROGSz5Bewjp6Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwR7xBUrpKyGosnBXIW3ZiDrL5sWpvtVdyUAD/9eVQMzhZOQhSy1lBoepCxmJ3E22hGzEo9HB1sZ5pqNMfHX24CdGM05hMIBdzOYjbM79e677m6NF906BB7c0UH1cGjqonNDk8KBHYYeBEqKsE+/Fl3aB/hbcmUZacE+s4oJn6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYYSdXv1; arc=none smtp.client-ip=74.125.228.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYYSdXv1"
Received: by mail-pz2-f32.google.com with SMTP id 41be03b00d2f7-cc4d04d73b8so632108a12.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432471; x=1791037271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x04WzFFRfKOHhAJjluyh9thnwTvvj0atcQS6e+hQHIA=;
        b=iYYSdXv11Fl93nVR7b/XRbm/OIY1wtosjNKqBRxHVHAEP5YEKUq/lToKqkz9M9TPwJ
         t+j4LE0ziDkWVxrR0SfCk1B8nZkkC4Ehastv5OH2xXZQrB9DzIT6ec6x7XRoQpoakXpo
         HmjuWlXMpV714PlwCDlotQ+bk8l9EsWRgg6Djzt3yqIbgNKahOfrZUtrlBkQamNx3Ocj
         W32sMKCbvA0mKLFR5BYBQy2rupsy2JctNY29eY57NC35HDWeoHeCDB7nRHJQndy8F7gb
         0ifDbF/ByZy5euzHK8Vgn6JamA4CL7W+s+kBf7zwcQ1TEZ46UjGLwR3dpAl9lgcLbpR6
         4ZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432471; x=1791037271;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x04WzFFRfKOHhAJjluyh9thnwTvvj0atcQS6e+hQHIA=;
        b=fxCJJmm/muMn0fLY3NO2NO2gwoHX23sQ+aXw8WJn0w/93i4XzoXdDxdkQa7Btn7iXw
         Frqu6vZ7Q0gB1JiXIha5bZOwP47zm1u2NjkoAWPbvpcJAmMnJS1rQC1Itje9I8zCTBNz
         XwbyLS+uda0G32TTShaZN13kVeMls4KwKzwdmOKF7NjSGFW4QLiYfoMl0sufhXiL34Da
         oYSNCwvzoaEpDz6/qqhhx95wsh1Yw4d8qyTN6GCkYx9NVgVYPBstqBxqJ17J/XnGdCHw
         AozlNOdxD5U4SSBQjtYxRBqYVvm3tWxPYKMRrhiimG7FRniKpgvg7DlSvUJMK4r/LFja
         dBnw==
X-Gm-Message-State: AFq9FYIKz4GTHONyyisXHTHh+5KHFK9hBlRnZbCceGEt0BW5s728jceV
	SfUhFxgArFle7E07ccrPmKT4xX2+lfrv2su+xTHrwmJUusUifFdVL2S0cH/1yXdwwtI=
X-Gm-Gg: AYBFou3stXu7HdwaRkq2jdot2dqN8lHCsGm+uYN/Cq9b0POYCqOD9z/ehJBFa8LFu61
	BoaCvA1cOqmcluKf/i3g1CIn09sEBhI+De6pAwGHPf0KAS3YVdY7E8bedDUXRwS0Tafeey97djN
	CkFrx12mKQJJjezi9qAUpTlXf5ca4kWN6CX/eL3XsyJa4mBbmSjlGgoqyC0Kfc/9Qh7kSKzA4x/
	53h7KaaNZhYT4cpmXk3uecRCqOu5Ecj9trktnpzUHvqZb92bpOxKCyvKxa9UhHIeX8IjJJl1VN4
	eac0FQ1fSeqjZuGcaAr/s5qS5W4wLZXAwbBf3NSFWfI7aOYkwO1O42u7cuPw8ci6nszM85cZilN
	CrNXHZ++loeNmqoJzu3FFwPAk+ZFy4mT11CAyEhILtr/8XeqLccFFk+26HPI8CKngqknNJ39XRr
	JNHcy1l2HEwqpdqYHaJOlwV63QUMzg+ZeTvoEF1OoaF/NOvxuto2D82HhSmA/Q7NuFmMFQcVxef
	BXO82UhqNWMgR1NtkpOyOPGvq4k8n0hI3tBN7pXaQ==
X-Received: by 2002:a17:90b:2b45:b0:3a0:8a03:2a2d with SMTP id 98e67ed59e1d1-3a098d35687mr7011388a91.29.1790432470886;
        Sat, 26 Sep 2026 07:21:10 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:21:10 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 27/36] selftests/bpf: __msg_next tag for matching messages on consecutive lines
Date: Sat, 26 Sep 2026 07:20:25 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-27-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
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
index 25eeb1c1248b..edeeb244e693 100644
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
2.55.0
