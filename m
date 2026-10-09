Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F184C9001
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542939; cv=none; b=u89t5YNfFiyvcJhqlmTx4uf/4DSgQSiv1YgcudkXPJP2RDpdltQJPETFosEgtrOkOf5BzXGVcIgb9jSnDW3+uly2wri3sHnrXfWCTaOh+igfhynLo+h9b+ics6RnPH/gkMR81fnEOzSrG0pvwk1S/3xJeXinl4eG47FCJIUf7kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542939; c=relaxed/simple;
	bh=zg9+1ICoiE1IU/xDkzARfILsF0H4Ph4VkeR6KqRd5g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWE4S12LEdrVQrOPjiXmt7o/rmWVKAfSf3+9imDlVgJORnxKHFYL5sZlm/nWnY15Bb/u3MPcr8nUfGBbINxYIv4ShoZW3X3TNwBvPwrOAml3uUnVEPbGptfRrY4Nr81BGPRrb4Ftr4hsV1wiPhGiF8lcln7cJVPNwLK1i6LQtJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faatfUOj; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faatfUOj"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3a813079a55so1037900a91.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542927; x=1792147727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rOQSbcfSZ2k6XJxvW79/agWIRahgHN3lVChbdd9N4Vg=;
        b=faatfUOjRdB0bwSDb8izeSNXKRSFotzsPPIGOdhhfOT53VwO/W5vZLxX9cweKyQRvY
         gt6RRnn+e57DFNgCELJ2q3CVFbOmmNKCSVFPRkDI3JrjwLiBmyAvkyvVzpglEky6HDEM
         irb2zanb4okqZ9FaGTpa7ehjgsneHiN8q+lu9NlINdMEgPvjHi2EbAOA5NiB8PD7eS7q
         4X/m/JXu9LCxwsx5uNujoc52aglYAziNXzaa/ZE9ZAuskKDhLNOT8OmkBq3ulP9rNfh2
         Wpe8rlzNvzFwsOG0ckDnFoMt69yRUkAnRHAaZSPkHlJq0bBoODpepEEyOEkdZGphA9Lf
         2W3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542927; x=1792147727;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rOQSbcfSZ2k6XJxvW79/agWIRahgHN3lVChbdd9N4Vg=;
        b=sfvGtp7jSdt4jg8evNYKq3OWGOnDYdnfSS2crPBvdJRLLgA5MT4elesyFhkS88S2DI
         fcneuLpuuhKN8D1qeG+AD/rCeIZg0orExkbylHh7wKZmVjTTMxvB3pvIHpfHUnrP6rXe
         eqHWZ9qnY/jnbne3HgXvpYWHatcbxyEXNU+TxN0lmjFEAMrlFRMYMBxIzPwdmKi2Gdtz
         X6gD9zDe6zHM8wgSMtoBagSOsD7fS1KJu1yww5bnos9hBumSOWieZ3M3qeXiNxZcL9Cg
         9Oe5Foe8YmFUVq35eqdptGVWe6s2QZE1i6u2EuGafo+2/z9k/SF0lC/f6KLRO8UE4qEm
         zNSQ==
X-Gm-Message-State: AFq9FYJgkQlqrKOa2xFTtM6YvkO/sLA8c9fx+lof/0NmKYO28oxTj1ze
	qRNqFtYyN9OhPPZR7JJIwHTsve7c54nkGHdKfg7KL0mAYWsM4SI9suDbvRm2QQ==
X-Gm-Gg: AYBFou0ukIs90GG4RQoQLJgrj0t68JGv74wBv532URl9c75HC33f1r040dacIcGXpjJ
	UcJzeHNAz0O6rbUUjWMJ6VUd7OpziWmA3VgQ7sqTaOOUd5NRSKFsxeaJjxpI1WPn0PUD+lgQl6H
	SKl+Hy1NOGrk29Yr78aNmGEGp7rNqTwIgoQhCV7vJypIVdV6mlkZOXWitT1V8XhQ18EIst88oU9
	coB4uZHtrmc55nZcgYiLeLhRp3d/NvM/ZcmpplWZGNAXl21wxqKHPHpl1YHHSNm8f50zTQAPg0P
	Ytc6mcgE9Q8+STF2y7iebF3TZszFF3ivCqHoXrecfN2TtSC6NCiWcg8T4ZOmqB+UnEmkjPg1wkQ
	OIBlN9/4IPAB+AboBN3O38d5EN3ByPHa0CjPII6rRTAoYyYGC/pe4BdM59Sf4vYI+hGbYt8lblM
	QwN21r+IT7HO8gEO1TaOCGzfWVeC6XA1uSvzuTw3QS2MXY+0IXTQUl0Af7pnXUJ/baWvT2nfRk1
	EX4vuhvTWKa4iU=
X-Received: by 2002:a17:90b:2d82:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3ab3acdc391mr821075a91.38.1791542927373;
        Fri, 09 Oct 2026 03:48:47 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:47 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 37/51] selftests/bpf: __msg_next tag for matching messages on consecutive lines
Date: Fri,  9 Oct 2026 03:47:55 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-37-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
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
 tools/testing/selftests/bpf/test_loader.c    | 11 +++++++++++
 2 files changed, 17 insertions(+)

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
index a89890cd56d8..18d47e925400 100644
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
@@ -998,6 +1008,7 @@ void validate_msgs(const char *log_buf, struct expected_msgs *msgs,
 
 		no_match   = !msg->negative && !match->start;
 		wrong_line = !msg->negative &&
+			     match->start &&
 			     msg->on_next_line &&
 			     prev_match && prev_match->line + 1 != match->line;
 		unexpected = msg->negative && match->start;

-- 
2.53.0
