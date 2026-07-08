Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCD43D8125
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783539168; cv=none; b=AqN20FkkZ52GtqRiqH6SYvpA+Xhly1AIqK3RUljMvu459mv/jz2l9gbGW+21ZzhLKWgB1PeZChL4XQ7dduadubtOTeyw6q6/5JRyzmoZgH3Tb171CVSOM53rLBIuBiOxJOm/Qtmxh0e0YRmvAv89REktlyeXlz9GevPDXPGFlN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783539168; c=relaxed/simple;
	bh=ikFLPTxFKvQGC02wqe6LdRz2t1tBA2LlCfoyBgJN0AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tklcK0zNCr/hm9keJ7tAojTLmkzkvc81ytn/y9ZzKwXlar/znIpHoCwNPO3FZ6+m9ekiDUdIX66KL3VjbHM22hDGqLgkqhzXfFUvIOo+DWAz7lUvSNjnVEaxKYqsA7gQJwUzB4RWO4DlC1SxkyICq3mJd6hwskbtMZm65J80ug0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=YDuch/2w; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="YDuch/2w"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38759bcd877so913606a91.2
        for <bpf@vger.kernel.org>; Wed, 08 Jul 2026 12:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783539166; x=1784143966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/n1/r8KmoKDolZRio4fpfp6MCb/vG+AFFsARTOQOFjk=;
        b=YDuch/2wkFJ52QTQfAbeDDQYjnbysvxHv9uSibEoCR+cS5InK9cPpZ0J3rxLDVBa3r
         hEXyMbmQWVz7GaDHVmiydCdDkSTMtA6oVuMoZm/rvDVFTIRb9uOGTHmTL2QTiBt2VdXe
         vFTf0xy0c3v/o3vuBQbrEfvXov7AuvzZS4PjJExKftPzqvgMetx4oLaoH4rOVfGWPefY
         hGDLxRj4KC3PsCxCYs+pIDe2t9Z8qoaKVP2UP8lczhrM2bv+JzlAOaB4Y8sHIylYRyTj
         unPIA415EflzNR8hnUA6+jLw3edtNa/f3PD/HFYzwLuQY408w4WXEcFZ+WvdFq4WZ1C1
         OCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783539166; x=1784143966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/n1/r8KmoKDolZRio4fpfp6MCb/vG+AFFsARTOQOFjk=;
        b=ZVnzf2LQlA5I1rLKydbHBgQEcaZwVTjnu8t5udT2r2wHXG7Bhmowk04SNNuh/ykJ9m
         w0iOs4aI8ITHEYil3hFsDBzlNfRyNvQUERPyE1LANWLS7+NZYx86232BPcJh51lpbjb8
         TGH40h10WPaUblfJLeA9ACaPnEckTkVaR665KV5JAzuQLRe65RPHr8gAB+CbhYU0o15c
         XptPG5fdnzM5Pd4zrU5CUD7eRl1N2A7i8Li1yxVlvosC6oUuSvlTdRukhlSxoVyHMJGd
         EZ3bSBTIcnWEbKchhM3l/bpzsYbZm0qEiW16eEIhxSx/cSpqndsZ/ByAoJhHUCejObMn
         a+6g==
X-Gm-Message-State: AOJu0Yys3k4f+SwwrhG5yfezrBjWPP4jhxoqCGaDlYRmRMmnpnHbmtZm
	k/HjdPCk+jAEfJ0aZcUYr6FxSMFeF7uUjdWv4u5lFzETJqwE9u6cpSHThDHv7eAR7aseRLPXkZF
	ZIhodVkHdrQ==
X-Gm-Gg: AfdE7cl0zrjEqH9Xyc1qMYL01nlJ6f//vgPZnSc0SZnduL2gJU9LkZQl7UKS/zF74gR
	/cz8HmYvkScdH84rILrFetQkEUZ2nuMNDWBuTQU4LhnKyEjfxWC0fmgwPambDhO+F5qCxslFTxi
	ssozXYuCv9Z2E8AhGn0XqicB+BSOnhYef7MA17vRU1lqlkeiEgxgddHV9QWBtA8VZXMs+fE0VDW
	L3i1EQa44dau0b0e/TkdIMV22NNM9lBP/tZWvumuPgGndqrqztYK2Gzc2t6EhxdMr4fp8bGkabL
	VeG8MJdBRTNjpV0ObzlSbRs1T7nF13lDSN6rkad9S0do6RJC8Mx3Q+S9E9gNMG093I/v9zojces
	NUwkxsHhJPBKv+OlpfcVLwY2/il0gmdMMJ93IlUhLp5AsOUFj5CBjAhDewRtClP8gajqXc6fNsq
	cgdj5ATtxghdIF+8h1jiw=
X-Received: by 2002:a17:90a:dfc7:b0:37f:f8c5:93c2 with SMTP id 98e67ed59e1d1-38941acc3aamr3933066a91.21.1783539166009;
        Wed, 08 Jul 2026 12:32:46 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::9b3a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174892711sm23942827eec.13.2026.07.08.12.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 12:32:45 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3] selftests/bpf: veristat: Minimize map size during verification
Date: Wed,  8 Jul 2026 15:32:39 -0400
Message-ID: <20260708193239.5063-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The veristat tool verifies that BPF objects along with their
maps pass verification for a given kernel version. To do so,
veristat loads the objects and maps into the kernel in order
to pass them through the verifier.

Currently, veristat sizes the maps according to the max_entries
field provided by the program author. Depending on the map type
this field may be irrelevant to the verification process. However,
loading a large map can fail because of -ENOMEM errors.

This is a problem when the map is supposed to run on large machines,
but veristat tests it machines with significantly less RAM (e.g.,
CI). In that case veristat fails even if the program verifies.

Expand veristat to resize maps whose max_entries are not relevant
to verification. Set the max_entries value as low as possible to
avoid -ENOMEM errors.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

CHANGELOG
=========

v2->v3

- Do not resize HASH_OF_MAPS because it can be declaratively populated
from BPF at compile time (Sashiko)

v1->v2

- Removed unnecessary ARENA, LPM_TRIE, and RHASH handling (Sashiko)
---
 tools/testing/selftests/bpf/veristat.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index a7db6f04f7e1..c9c257784ee3 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1248,6 +1248,29 @@ static void fixup_obj_maps(struct bpf_object *obj)
 
 		/* fix up map size, if necessary */
 		switch (bpf_map__type(map)) {
+		/*
+		 * if the verifier doesn't use max_entries
+		 * then set to 1 to avoid -ENOMEM
+		 */
+		case BPF_MAP_TYPE_HASH:
+		case BPF_MAP_TYPE_PERCPU_HASH:
+		case BPF_MAP_TYPE_LRU_HASH:
+		case BPF_MAP_TYPE_LRU_PERCPU_HASH:
+		case BPF_MAP_TYPE_SOCKHASH:
+		case BPF_MAP_TYPE_DEVMAP_HASH:
+		case BPF_MAP_TYPE_QUEUE:
+		case BPF_MAP_TYPE_STACK:
+		case BPF_MAP_TYPE_BLOOM_FILTER:
+		case BPF_MAP_TYPE_STACK_TRACE:
+			bpf_map__set_max_entries(map, 1);
+			break;
+
+		/* ringbufs must be page-aligned */
+		case BPF_MAP_TYPE_RINGBUF:
+		case BPF_MAP_TYPE_USER_RINGBUF:
+			bpf_map__set_max_entries(map, sysconf(_SC_PAGESIZE));
+			break;
+
 		case BPF_MAP_TYPE_SK_STORAGE:
 		case BPF_MAP_TYPE_TASK_STORAGE:
 		case BPF_MAP_TYPE_INODE_STORAGE:
-- 
2.54.0

