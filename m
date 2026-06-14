Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F831242D65
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 05:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781415588; cv=none; b=sU7cF3q7EXr60WHw08qO42iQ9QU1xAwQVdsC2NN+DiJjAd5g6yq/6jB7DmD6zhRGV0fHMtxmftCOSZFXzpnlV5RXD9qt7hZVoMFRuEbX5zXCPVSkJkkv51Yoo6eN+9i2XJhuAGiBC6gj8YubAnJDNMaeXFJSEZXs6NZBbRxnWjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781415588; c=relaxed/simple;
	bh=9kbwiMAQqD/ZLgHbcz+rU3ewKuxGRikpRtLFDnpflQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kMQPhxcHIQMgIm7cdye+AepKzooEHfSDk7O6gNZGv4dLR//wmppWhZDpPAva8QNNcJJe9OXfvqRrQP4Exnf7e9/wBnfUw+SbZpsvVrTsWQSIycSMgzr+nRTiDtzyClNzvThK259SkOqa7H0y9RApNxFesKBNSM70CWoyylKPoNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHiFBYcy; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHiFBYcy"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-842848fd613so2128108b3a.3
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 22:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781415585; x=1782020385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4tgM+z2iyzMGP1zVK/SY9fes3/obYg8+/vIlbcStyS0=;
        b=FHiFBYcyUlhFQ2oW5HFKmGDEwofi5tGB6Sb6brDrz4qffhxDSN48n8B6R6mSqffUBP
         xpYHb/pI72q4QvzXJ+63W+2VWcED01N4aGFY3DRtnCwSHts/VkjKnWWHWOrgOg31VQZj
         pWZKLjWShEhpY1OKTYFffpxNB2q+R6OWcYDJedsksJNJtNfOo97zazLGtnfpqheKGbP1
         muYKJBfa6EAptTgfraIUR7XCPOcqcWrYsesjjHsMta1hiayMDGW9r3ZfkCsqlVV3PrR0
         yU8R26F8vqCvP5V2Ch/EBIk60cYHV562Z/3mRqqvWgKUzN8M8uvUYt+Uhg8bNYTCr591
         B8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781415585; x=1782020385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tgM+z2iyzMGP1zVK/SY9fes3/obYg8+/vIlbcStyS0=;
        b=Vg+1YJY9QG512zQ6Y61z8QrSWMnxpvEJ0fpXBBkAysG6On6ZRx4uIKXfqYDk1yfMXf
         oRWuAPqrk/48DZ0j1eYToRWV6wtWdZ8Gj5vIds1Z6EkrrORAYZ3vP7XILzMRGjOcexnR
         HSKOWJjKtksb12McTvfqm/OSYcng2znhh1df1+cFZXW4SWKhyr4MJ78PoyHYVAzZ5d4a
         QJr0MgoruVeyFbe5H+0uz3S7aAb7/XAkBe3CqQFi1AP6+UCsvJy9fr4ryLLRpQZ+CWEU
         7jiK+J7pQaQ3QAFHO+sKNRXoUGxEh4bLzBpDMnbuCq/ywunbRCxx5dDiwxzw1dQT7yiP
         5SeA==
X-Forwarded-Encrypted: i=1; AFNElJ+YZbSLlhgeqwfqEV7/Fh1kCOXjBOD66qj+0owgcTK+JI0aZIwa+jX2FKt9dLBrv+VIuAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzohzWyTsMXFG7gmjVlPheOT3banjG5cfvZrCX3nc/wxcuk3sZ3
	r28NFuQH9hz9nyQ3ErmmM88xiw6T2ln7yOYzFLSF4hL/bZGZXVSCtwgl
X-Gm-Gg: Acq92OF6P9UiTE/PnldU56VpXNS1xMOr+mmiVVU3EAmRW3qaroFse/SiCoimgBIQWE7
	EiI7b9fl31Gi5RwbubjFp+CMBMQkHTixbq3b+RdkZLNBwXTIAq2q+Q4P7aqbEz7xZ96mfaYy+sl
	3xrMPjiv4f+7r+eL6xMZiEoMJpRGzkpUfqd1F6UYVCkrYMgPqe2syulu11F+iHDcOxvJ8HXi7s+
	BKxDO7g7Jm4JaFzOVN4751KDmFct6ZODDI29XRP8CkCwMtOY5kQTOBeYhDezXYmcNNIEZoKsX7x
	8HK26eKB/Ie84TBbg6NXvk0RTkOBoMqpSGqd1Yo9ADIRfHDM9sRIqHL2E0FA3Md8eWkn6Dh/pBG
	6+KE1i1SxRDurvf2rkH9JmQovRsoonAMG7XOGMT3LSFU/dCK02FHgvPr9FNk2c73qcDJbunss07
	LWD2JGDQ2W06MGpyah5QSbmLhADh7a+2CeCnZvp2p7pbfe9XtDjs8+Y5/KgTsd88VyycLzkKZ/M
	TmUQh30xLqzOH8j
X-Received: by 2002:a05:6a00:1813:b0:842:7838:61c3 with SMTP id d2e1a72fcca58-8434d07bb66mr9712669b3a.22.1781415585382;
        Sat, 13 Jun 2026 22:39:45 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acffd04sm6387078b3a.26.2026.06.13.22.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 22:39:44 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH bpf 0/2] libbpf: Reject out-of-range linker relocation offsets
Date: Sun, 14 Jun 2026 14:39:25 +0900
Message-ID: <20260614053927.160566-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The libbpf static linker validates relocation type, symbol index and
instruction alignment in linker_sanity_check_elf_relos(), but does not
check that the relocation offset is inside the relocated section.  A
malformed BPF object processed by the static linker (e.g. via
"bpftool gen object") can therefore carry an out-of-range r_offset that
linker_append_elf_relos() then uses to index the section data, reading
and writing past the buffer.

The normal object-loading path already rejects such offsets (libbpf.c,
rel->r_offset >= scn_data->d_size); the static linker path is the
missing sibling.  Patch 1 adds the same bound.  Patch 2 adds a selftest
that builds a tiny object with an out-of-range relocation offset and
checks that the linker now rejects it, with a valid relocation as a
positive control.

Reproduced with ASAN: before patch 1 the out-of-range relocation is
accepted (and triggers a heap-buffer-overflow); after, it is rejected
with -EINVAL.

HyeongJun An (2):
  libbpf: Reject out-of-range linker relocation offsets
  selftests/bpf: Test linker rejects out-of-range relocation offset

 tools/lib/bpf/linker.c                        |   6 +
 .../selftests/bpf/prog_tests/libbpf_linker.c  | 212 ++++++++++++++++++
 2 files changed, 218 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libbpf_linker.c

-- 
2.43.0

