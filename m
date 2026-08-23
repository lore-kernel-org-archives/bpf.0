Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FC73AF668
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514192; cv=none; b=Nqf0xN7ant01wGKmqBSDgn8Fo3I/fw1n47u+9Izwv5i7iEIK5tQdno/LveDkRE5QsLxO7ZLtpkt+cg8PfRfutEXZAwa6Dk5DvfSGSSAyTUJd1tAnbHwgZEvbmBydAtn/++dXdL+6icY28jOzaJMc7vCxEXyjMc4BUEWofQJjw2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514192; c=relaxed/simple;
	bh=fGzqz5MqONp42Bll9gc6gU53bYy2dZe32RvzcXQj/EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKFX5buyAOu6HGSxRxWJK0wXqYbxiL0MUny4bnvMGchKBcO7OLSQRYfBNcOR5HHSRoxFcFQCMRvJwI4rhKKbuA7V2DO3lee4x49Sj5xmeIjkapE+pIxRrYkTl5NCmSLhBv41V/15Bsk+0rBUnvu1QDE9ElWjrOLFt4u2QQ/xv7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2q51dM9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2q51dM9"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so2163276a91.2
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 12:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787514190; x=1788118990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SUiLX+svcrxoH/cedX3LHiwxjjhja2i9u5PoF5+5iIE=;
        b=I2q51dM9pvBPUCzxIak2GbqKAwrJ3tD4MVVwxM5g4IanXouKnIWXyqnrbU4HFw7Lch
         5zRK0lgGznDxNzZ2CuXughLmnjLsQZsHhqqPuE007ubOkPPtK4gmnLujkxtD3w1qmjkW
         dvPaEYgRUB4zF0yAuEZl0DYsLn47DC9OMt82UZiYJV6d+s6Ytd1C2glzOx+iBnNEOGS7
         gNxQxyD6IDrWFVowLabT/AbKjbwNGKQkFFj7nte367/p5PmYR3nCPt8mlyvWwmUAg1bo
         s017VCUtg4XRXKqDATYsVNjU7VcmuSPTN1tHXRAM0PQZ+taHXJxyJQ9tr1Hc+Z739+oy
         I2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787514190; x=1788118990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SUiLX+svcrxoH/cedX3LHiwxjjhja2i9u5PoF5+5iIE=;
        b=Hs2MPFpmOk3MwOJGety66Dpg17Im7S2unQ11BLLMu4SaJHvlEfNmoX5pDpagMTUOHw
         GhKPVcWYSjLGalJOzlZK7pRnLnWlZ3z2eDKOYNno48D8w7q9EELz6ihzO4/3BMxUNbDw
         oP4cG5f9aaOxQRG7TSqXZm8jmqDoP1pH0bUTrDqto6tmw+CWV5xnlsd9ALsAeON9VMos
         yerTx4mUX4sgF8VHru8nsEOd7W3vc71qjJ9kt4wDTON70W6txhMFYavC/8FnotqppSoc
         Q4OpwRu1YGwqFMBIIfJDzbVJriKYF5DizihWr3wBEtxsE8N5iEG48dCUYEAKikm+HG9B
         KcIw==
X-Gm-Message-State: AFuF++mguaBqJFoAgM5/Q4J1z5d0B6efAsc2v1hw0OzlyXa8HlBNsjHP
	I+6SfvEaTQh8ezdsgr0n/Ycz4viIQhHLT1uzjeQqapJiOnD2hhcpyx8hcLfWYAMw
X-Gm-Gg: AR+sD12qqNEXepw3hxWFOr6fEjF22da0d2JfSkZWUZy7v3aIUZGcBPkF9HfGIEUwYQc
	rmFjz6xNVOeEAJ4fjei9H5H1afKW970+2O5dkyPWVvhFjXOshPOzvUTvrHDdeXNloe0nGWc3Gjx
	mvxscz+7u8wKC7TF07lK8pyaIr4rhfxSubzrXgTTLBJsa1MIw9fCKv7CDXByV2671AD0m49IrGB
	gywO/3dq4eCb35Ol0XvDiBYB5RUWCgm9WG0bF694Bju72EMGQhpc/LVNwysKxe0MQ9YWx6Sr1Ce
	Yr92NQJH4GYkzkVEA34QbBke8gx7Ndt9oaHJRmgdsCEbdhGcHpAGwEzi8bCT+UBDdOWlolnZVQ+
	J0Anrg/tw+w9NDeICBZskzfVxfXLnkWZCeBk+TGDyYoQJzXEFpFbCoIBGbfX4OV8nA0e2PY6HMk
	6ZOqTyMmiCtHbjcnQzB3JMeRTv2aG61NfTuBpZ6FOsZ9TEp+ZSddDBRZ7ikyPnk+gz2CAmGefK4
	KNBCKdw5WtWtmkwYQmDh4wNgP2u3LTyq7SKJzi2nJ8vuk6WsnbCNIs=
X-Received: by 2002:a17:90b:33c2:b0:38e:c232:9d3f with SMTP id 98e67ed59e1d1-395c3597c56mr34761711a91.5.1787514189896;
        Sun, 23 Aug 2026 12:43:09 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b2af01sm6839723a91.14.2026.08.23.12.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 12:43:09 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 5/9] selftests/bpf: generate verifier/tests.h in a regular recipe
Date: Sun, 23 Aug 2026 12:42:37 -0700
Message-ID: <20260823194241.3415152-6-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823194241.3415152-1-nickolay.lysenko@gmail.com>
References: <20260823194241.3415152-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier/tests.h recipe is a $(shell ...) expansion: the command
runs while make expands the recipe line - including under make -n -
its exit status is discarded, and the resulting (empty) expansion is
what make actually executes.

Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 7b80a1b1ef76..2070a07015ae 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -914,12 +914,12 @@ $(eval $(call DEFINE_TEST_RUNNER,test_maps))
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

