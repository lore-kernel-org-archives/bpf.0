Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDFE3A6405
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179382; cv=none; b=fY2QZQ37yxeqEpizLqeSnX6TqkrTeCsCxfA0rr36Qn6g2hB2BYQmvcb128E4UW3zsMzfjHmv0GiI0Z9WdTWBeXH7fqcFhYZXbgHCff3Bf+wibf90IvurceNlrEVUYvpPpRCdxg388lgZJhOWBsBs7RbAvodxeK0+BtdrP+5UXvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179382; c=relaxed/simple;
	bh=9UQ+mAHCmbD62qh1Ueqz3O7wcF6smtpul/ayAHwOJMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0RK5UuyLSKiHeC1fGCN1NLMpTvmD+pL3tLOqgHPBes/+GgFmW8TUkT5MZ/Qg4pPc6mnoNo9Kf/k2eKRbzkeHyxs39XL1I4x8n+SnpRHpdbYF7P2QCIwG/4JXZ5fwIduaEFAdVknbnuxwwt2P7f0/WqwZLzZZheCuE5c61NHPdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Es2XzhIf; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es2XzhIf"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3660ab73adbso657028a91.1
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778179381; x=1778784181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bVOb7teSak4fsMnBroKa4foxmdWIqg6Zao3WbzrfFc=;
        b=Es2XzhIfjeA8WNz4XdGDeiYF+Z1GRBXlBkk9vTNPwpIO0X9kdXrBGoEK1yTPU5u56Q
         TOODIngp8koO9S7/Md+NPzRqSDxTVExQawRz/v3s5nlod52PrpKtYSfVhxT+RxIxuEW7
         aKdPY/xG0TdzHhFdEHN5fOPhl2NQkqOC9Ea/9A54mtr82+EMcmrpREI+7XKUSnk8nvpS
         HZlJl4vDfZ+CvW14af0jkbhkZimETek+uN4Dm4gkMmUT6etxu8HFqDkNWbZQ7LrgaRXU
         q/hiSawb1qMudyz0RuB579l18276rAXgzjYdZJAG7KpcIyGw4Ge0jQa8rz3CfOvRhZTc
         qvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778179381; x=1778784181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7bVOb7teSak4fsMnBroKa4foxmdWIqg6Zao3WbzrfFc=;
        b=Yljyit67tPC8C89OWc2ERrBRbBCXrWIEKOxjo1rJV31mlokpyWsyBrCRLQ2teZS/fc
         rxkGaEnBTJBlQ/IU4SMyD3Chc6SPUaGJfeou0gz7JTWp7EPZqOrswtF8a4FKrv0tLPyS
         qQdB14O8WRdLwt9eiesSJFdQ/ARLU427whFit5ZWOFNqV5rt+Nb/cykfoWeKch39Z/hW
         jQJx3Ddqo04BqQSEPV6cnT5b/EeUyqu2VQxty8B9mRnat3BSpQ/mvNxALHhHf4yGRH0r
         jP81JGr1Z+dLSlcjWLD2lCMWPkMkTQVRoD7fA9mvYiC+/lqtdMuVfSwtFCglVskQY07w
         IABA==
X-Forwarded-Encrypted: i=1; AFNElJ/TxMUJVeORncroAc/B8keVnzpfShCnTFBFXKgv6rHFr0O2pIpWCfsqZRHQW/DTzhE6Gaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP4XU9gGtmPkNGFoy6iw3Fe83CeU7P1wB0GpQR4oV1xEvT4D+e
	L4ZM3Us73GB+DFPmMJ1fOqYAHJv0lPLQMxTkcceZziIuVmcA+uwYSwly
X-Gm-Gg: Acq92OEcTPeV3sPtQTlDiii187LPX1UVnWkFFCtQ4AHv8iWTf4RNRYGF+VinsGHtQTr
	XhRNylPeAJM26R4D51rqiU3qk314at2TQpA7nIGzaqwc4dG5LT3Ej0MRC2y04uRWz0qOP+flna3
	+RnbiANW0NfBj4Vflw5bgH1E9mhjzMSuBthF+tYfLAkn1DZcvKtbyGKEwkjKH8HBI48tk7pFE43
	WlIpX+K/MYBWXy3VLigDvbsekkJQlikW7KD8930aqwc8093Ieg5Do/JVfuQgOSLx7TSEO1MXiMH
	N3OVZBnbEw1nilPbnQzkvstBQnvcXCmBdiYYleEISvahWFTspIJl2JSTHVUoDmdb+02EtoGIByF
	kcPxZYH4S2Lv7n6KPelVgqjz96h/Y2ZbkbHM4/qmjCRu00FlkQHwSlmiRZHPkjRoTCNSNKZ5fKY
	SnVhOeev+NgkZm2e52eh5bCzfPY9dNpc++RBlokzcP6g==
X-Received: by 2002:a17:90b:4fcd:b0:35d:a31e:6b04 with SMTP id 98e67ed59e1d1-366052d08cbmr3516766a91.3.1778179380759;
        Thu, 07 May 2026 11:43:00 -0700 (PDT)
Received: from archlinux ([205.254.163.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-366478fb189sm118708a91.16.2026.05.07.11.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:43:00 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH 2/2] perf build: compile BPF skeletons with -mcpu=v3
Date: Fri,  8 May 2026 00:12:38 +0530
Message-ID: <20260507184238.65280-2-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507184238.65280-1-suchitkarunakaran@gmail.com>
References: <20260507184238.65280-1-suchitkarunakaran@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lock_contention BPF program uses __sync_val_compare_and_swap()
to atomically update the max_time and min_time fields in
contention_data. This builtin lowers to the BPF_CMPXCHG instruction,
which is only available in BPF ISA v3. Without an explicit -mcpu flag,
Clang targets BPF v1/v2 by default on older toolchains (Clang < 18),
causing build errors when v3 instructions are emitted.

Add -mcpu=v3 to CLANG_OPTIONS, which is used exclusively in the BPF
skeleton compilation rule.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index cee19c923c06..a9a8c84b6b00 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1195,7 +1195,7 @@ ifneq ($(CROSS_COMPILE),)
 CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
 endif
 
-CLANG_OPTIONS = -Wall
+CLANG_OPTIONS = -Wall -mcpu=v3
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
 BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES)
 TOOLS_UAPI_INCLUDE := -I$(srctree)/tools/include/uapi
-- 
2.54.0

