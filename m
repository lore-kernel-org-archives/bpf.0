Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE97366075
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 01:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787447374; cv=none; b=NoHzpCav3Ogn8AYhzn7u3P9S8Pcoi/uuPG2TVqGaCo0ZpeWnf5EEBqY9Bw3z5eUvSos88HnauGqjEWWIe6A4KLojiP1scdTDP5vh6nO5EbqBYFUPIxpO73zsW+MLxiVpbpZs1fTZJWSv1KuNx4EpJ6ikuvZGGREmTXWJLqDw7uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787447374; c=relaxed/simple;
	bh=+yqz6wwpJItpfxAE1IZ0k1HUNOmBF1RBdq+ePyJMMX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmkUe8bRsDKoZdpJXeX4zQWi0KXws0tw10yleQ7TXID0dbtCdI0PkzRNavQmpu8Ku5sa2h6Fm06hJ6CIi6kNvXNCg1d6qaF4n0WAlctyIYDjxfDogJe1NWWM91k/CetjOIPu+AlV2mGd5+DNzSX9R1YB3RrCESH/7JQn7fKhx3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHEoWun/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHEoWun/"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so3020184a91.0
        for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 18:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787447366; x=1788052166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XiuUJ2wWB8cbCMqy540b9XS0HZW4uhFOZpmD2jVetYo=;
        b=KHEoWun/njJACXpNBxxllIG3S8pYlYMah3pplKNiBllbj1WoNnRvX8pCOUhBPLZ3wY
         pLYcJCx09wFMukzHQCBvcvYk5mW067YE22Vb6LEE3x1LVWlB8UTIPqd2tnhgY2Jg1zJb
         1OH7+7cWt5kFE/hppBXy/F063OjF2bKLkx8Lss3cFMo/DfG+tCUt5nmHLl9CK9H8DPDV
         aNe1MN0TxofDClb8n3c1mksdVjW93Z4SY1oIeclE+/vlI3hV2DC06FQ42nlf0ePsAZFD
         lJ+0ZDBnsXihykPYg2WSxmxmspOdP6khrtZbkjcx4nDygTdr6HP3tVKmn+dO+5AfMSKf
         7kuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787447366; x=1788052166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XiuUJ2wWB8cbCMqy540b9XS0HZW4uhFOZpmD2jVetYo=;
        b=CWRuhELaV7hoVxvHpsHwPMEPFTvgNf7pU1+3vEzk/PipePh+yxvJTByRFDU6k/Prqc
         f02dko2FYeLVOpgDE5bhRFJOaIC8+zrwlZICHGTBAUQO7J/2xx1udHDrTFkdphfwohKE
         /3jdzcdbD5+BowPKnUXIEGiv0xzt9D5S64DfHm61B6mMsv2ZVL24ki3ddJ8OMcjPintz
         MlzvQSRZVvt/w2TFYJwfOg0XACcwqq1NBLRM0r3hIBvvGMBn6rfT1TfUDjCgtoil1tLv
         VMD5hPBmKpzz2lqTKu4cOFsq1+8rYOO0YP/rnKDroMVy5lMClNZIccqJdCRAg462+ZV+
         igkw==
X-Gm-Message-State: AFuF++lNnH7T0c7IxWwKzBiRKJsr1+Y8QMR1/ZRik6uiHu331q7pJ3CU
	ZFAiA5FNEP1xay09IrSJi3eu1lMXjXCdjkTsSuJtEGBSERZZsoM0h6OjMTp7TuuP
X-Gm-Gg: AR+sD13GOwmcylXM0aHLJpp8WT3YwHsUOB0gjawLYLVurLdA2SOSLUTMNRP+7j/ytaM
	3MLS5FagPiuErNA7BFcsZ+eEfEhfefjeranNe5k77DRtxteEE8h9st5C40G0Fpp4P1RIFrOqPQH
	9qVzbQmosdsNS6ls6rd113UbxArLEdHVpF+V0rEnhskKz7TDCpfm3h/3/y/2PgC2OTzpojs7uw8
	5zVj1+fldz2peofqtGsynLyeHDbJTBi8M3t+tmWVAnRWhfOmMn0BbSGaYcgusF1pY+T1aVQ09bq
	eCD8iPOjAimbXH1uL25Tz+mbVsKSIKkwsqeXs2CR1gM54XPfunp9IZEYzS+7sGmqpni6Zg1oqu0
	z3DRnVfUL4Q8nf16cKfDw2cfrwnZk38mugnLcugS1BaDq9de0c022ViC5z2iPv7fYIlhjR+Lo/l
	SHzZWfwvz3nYvOVIN52Ir/2/ATkwcCGOiXpgs1N15Y0PwZ7k37KG5tzJl1iAU8YkrPXU7rvLaA4
	QewzKLzHXnq117rLjh6pgr/vVyWM8M8JGAAmsNC4+AVhXJFxly5sDM=
X-Received: by 2002:a17:90b:6cc:b0:392:ca3b:370a with SMTP id 98e67ed59e1d1-395c33d786amr31820010a91.2.1787447365994;
        Sat, 22 Aug 2026 18:09:25 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b240e7sm4219994a91.13.2026.08.22.18.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 18:09:25 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 1/9] selftests/bpf: keep headers off the generic link command line
Date: Sat, 22 Aug 2026 18:08:52 -0700
Message-ID: <20260823010900.1730708-2-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823010900.1730708-1-nickolay.lysenko@gmail.com>
References: <20260823010900.1730708-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic '$(OUTPUT)/%:%.c' rule links with '$(LINK.c) $^', so
every prerequisite of such a binary lands on the compiler driver's
command line. That only works while none of them is a header: gcc
tolerates a stray .h argument on a link line, but clang treats it as
a request to precompile the header and fails with "cannot specify -o
when generating multiple output files".

Filter headers out of the recipe, with a comment: header
prerequisites on these targets are useful for dependency tracking -
the next patch declares one - and the constraint is easy to
rediscover the hard way.

Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 5f1a3bfc0569..118a7c356e26 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -258,9 +258,12 @@ $(OUTPUT)/%.o: %.c
 	$(call msg,CC,,$@)
 	$(Q)$(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
 
+# Headers may appear among the prerequisites for dependency tracking;
+# they must not reach the clang/gcc command line (clang treats a bare .h
+# argument as a precompiled-header job and refuses -o).
 $(OUTPUT)/%:%.c
 	$(call msg,BINARY,,$@)
-	$(Q)$(LINK.c) $^ $(LDLIBS) -o $@
+	$(Q)$(LINK.c) $(filter-out %.h,$^) $(LDLIBS) -o $@
 
 # LLVM's ld.lld doesn't support all the architectures, so use it only on x86
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
-- 
2.43.0

