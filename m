Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF50A449B1A
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 07:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977586; cv=none; b=ZZxMRyp19zpkjcS/39+7FmsoGInmx+/lfBYxhOsZiYhDLbPz/RMjNsAveiFdD6T9nNyHGVolnT3eBvfcwku7LiTJ0EXhkQ4nGjsQ11TXBAViWxTlVCMe/73SVATi/AOyaS4HknLjjv9skOlHNQHEdkNMqCH64v9T7MtN84Z4Kxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977586; c=relaxed/simple;
	bh=0WUrvWgR3dgAiab7SIYWPeAivNmq2XI2fvWaNkUtn/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PoXaQoUFwxsnKp5zoHzVllZkOJq4a9zGkUI/eOttCZvOu3zhGjydNCMsOqxJehW17JzGoBjroHMT5d7uxk9kxCCH3ZbTC7sQhUE8lyMGW7AJQu5WqrlSm3IE+pr79uxTaY0/Gc3ugzMpxboORKAaFzcyaWO4brxVWZsJ61QA9zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRZodoKF; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRZodoKF"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed1368so32157455ad.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 00:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789977584; x=1790582384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yT2MaGkiNqk2Zp19hZ3osqvIDm9Y0kvfXP4DN3U7yio=;
        b=kRZodoKFpzfPilfjURhg6q08cGyY4jAdviTiskqZHVijoAb+LLlBrxrdHoGdrr379l
         TZ64vNlngz15frOX/B5KwlgJfuzpsb7EMQIOHwEwEOzhzptDhAdOlevXq6KndKXGBseR
         214GnnkgFOXGnULlx7Vq8aI3wYGEIW0lZXOtR9ncbRMRXyDrcLoi9+RefCbEjX3RVGnK
         9p/HNRphCzrPECLJIawBgBTKpRoBHC7vhdJI5F7hXSW0TAEx+zfCz4LrdFcob0ZixzdE
         txoKJxxDE+ABKVvXL7Q49Utj7kMkD8X5/jzg058lnyEnNzNyP8WEkx8gtE0mCLyGUQv6
         9XKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789977584; x=1790582384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yT2MaGkiNqk2Zp19hZ3osqvIDm9Y0kvfXP4DN3U7yio=;
        b=Q2ujSHXRHvLWMIMJJLVHMJmYpHQFlZ/o2lu/a+5x7dcBxDZYA64RTI7E9fpZ00a2Cy
         v1QIOKicRgxac8qOavhec9ZOKykfjDnDsI+Yj2Fq1xCJQGmc+0XBfV7kO7y9hNwDHQDP
         b8lLte1yYStwIsfnSxc/epIy8wi7OjFjU9Hk3vrAvMGLO0YelUj0wIMbOkYORCHmWqB6
         422mRiJ96nV7RfFn7CRYTRLmcm3SzO5CeHl4HFSbI9K+v7VYtRubT0b2BfbFYCKl3CKS
         gTLYpsgWwcsWikX7aXUEB9jJ/zHEHLLBCGwpXygAILR0KHDlbNgzT3iLnlHxoe0ZJ78y
         hyhA==
X-Gm-Message-State: AFuF++lMvPvSuPWcQdOWkT6t5Y+T9S6j+GeaSs7UTlHdbEkaj6JfxKjF
	sttAEN+r9E1zGw8da49eSG50ypigzzCQCb6Sz5AS7O+6BecUYHWMHQb4zKJbgUDPP3Q=
X-Gm-Gg: AYBFou3/60cUYQigpybPWm6oTRKp1qukeYCfMS8SRNQnZ7IFnJGe8SzmtykUiLHwVDk
	dC/qfRK4lqU+LVPTTYSjKtMhxx+QunXomKd0I8/+4AMNYWpgEgWt30a5Wr36aQaEURpvIho53aT
	b4v99yxglrxW4uRBpydRVcOOjOMw4ir3fNiDJk90xFTTxuh0OrYWibIyVBx02NuJuAXKOQ4yriW
	Nep2Sjvzrc1jVtyZTkQQhUzrxDArRgqlkJ0OpOnA8135vtKxl25w4UR0FjSTT9v8l6XO7UYbNdg
	0zCOjadcDAOd74PPfb47RId/65RBKarFekRBxeimeoVnl2R+B+A3ZuJFk1s/wUeVrmyhA37KZ1b
	/Kxye4tm3rXyMjoM9E4cUx+bBQh/H43T7dttYWVPQD2mzI1en9pFnKFEeE8eqV6PNNLgcYCDzUB
	9Kn6hF3ma7gplXxqfXMIi3pbgbvGVPbNvEgeiQgYyKYfa4vAvRXxVLnUrzlZ1fZrBa478S8UmgM
	vvFAPyvjo+k8jcompkgq5GNoZpUDx+iW6AQqpnl99qgw2vXfNwxmMpPanQehVMbhA==
X-Received: by 2002:a17:90b:2d47:b0:39d:f4fd:8075 with SMTP id 98e67ed59e1d1-39e54c9c7b7mr15422768a91.19.1789977584241;
        Mon, 21 Sep 2026 00:59:44 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6f1835adsm12843830a91.6.2026.09.21.00.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:59:43 -0700 (PDT)
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	memxor@gmail.com,
	nickolay.lysenko@gmail.com
Subject: [PATCH bpf-next v8 5/9] selftests/bpf: generate verifier/tests.h in a regular recipe
Date: Mon, 21 Sep 2026 00:58:51 -0700
Message-ID: <20260921075855.2065871-6-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921075855.2065871-1-nickolay.lysenko@gmail.com>
References: <20260921075855.2065871-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier/tests.h recipe is a $(shell ...) expansion: the command
runs while make expands the recipe line - including under make -n - its
exit status is discarded, and the resulting (empty) expansion is what
make actually executes.

Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 5bcb762dc3fc..0e23cb506777 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -910,12 +910,12 @@ $(eval $(call DEFINE_TEST_RUNNER,test_maps))
 # them (e.g., test.h is using completely pattern), that it's worth just
 # explicitly defining all the rules explicitly.
 verifier/tests.h: verifier/*.c
-	$(shell ( cd verifier/; \
+	$(Q)( cd verifier/; \
 		  echo '/* Generated header, do not edit */'; \
 		  echo '#ifdef FILL_ARRAY'; \
 		  ls *.c 2> /dev/null | sed -e 's@\(.*\)@#include \"\1\"@'; \
 		  echo '#endif' \
-		) > verifier/tests.h)
+		) > verifier/tests.h
 $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
-- 
2.43.0

