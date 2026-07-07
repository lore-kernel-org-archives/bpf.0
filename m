Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C131ABED9
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441220; cv=none; b=k0YLv87pKRsqvleE6kZtumbwaP9pBm2S7yCuMfrkKXQpnNscH9QfwqvXoPYEHkswC0S70z/BqBapmlrKWDYeFoO8fuIT+yQ6eXvpX4IBWv0zg6Z9O4VDQB4vEtTDeJGHm9id+5viu8Y4v0m+0eedX4Y5mFIV+8MZOpyb83N+gIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441220; c=relaxed/simple;
	bh=aRZZGUHRio/TYw+vvhJ1BxsbwBeUYhu+4tca383WKOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K8p7WSFkXViVRFpzM1yWf9Jycanf6zXq62ITSel6E/y7nakTnflO/Kyy9Y61ExhLwt1bKca3W/2lZw70LY2R0oEFICVKwYhSdaZEgDusawH7FZkQqQ+IdgmIHprIZFSOhCA56BhRoTnUgegr7CU5tki6WNcptqyMX81A3BnYQ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=gIjTROzV; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="gIjTROzV"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-845e47133c9so570655b3a.0
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 09:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783441219; x=1784046019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D7KM6sD6ZAQha5LOrz/iJ4UB7nq3cKsvh78PnsLX2bE=;
        b=gIjTROzV1SKy+W6diXcLAsQ8pFgwq2InRZT+X7EIBzg7555JCKtLcUIJHm0xnO53Ru
         HjFjGihUInQ1CHfGSJT2eV1BlatzSIJ/sOQCE8IiKfJEbBU8sihSPxFabQeYBk5GjZbg
         DAa63GHBv0Hni66IsFjehw7bc8VLwi92C8u90SmKdA0bmtGl8b8ZUvQAt8jeyMjuIA8y
         iAOfbRQC5m63mp+xsrtVNyIgNB4J9vA/WVoDMb8taxXpFSUpnH6YMiooDwmep+OQp8hH
         dwJ3gu0pHIJ7buPTS/qSgYu3KlbhDr9GgNr9qKhABROSlRXzQ9zCWMiiyI/OQUzf/qCM
         +FEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783441219; x=1784046019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7KM6sD6ZAQha5LOrz/iJ4UB7nq3cKsvh78PnsLX2bE=;
        b=MCuWSzCRG6nnrWfPKikfJm3ylGXctKZn2o581UkkNChqk8Oz6CSOB8Z+3+SD1tOSXE
         k61hahWwuGB2o2fbY53To9/RKAGk4UfDxKPUNBZA4IG1i19l13mTE7mpzh0fkekTtRyg
         wHANqm5vibVN/Lr8wmKPHPxFalspUFt+07Ye9J4jxlO1OCqiGAxu9M4sawIOyoxp+ZA5
         a92/ANiYGFlbqGzYA+J5bKWZIvwpN4hVFf4SPwtJVnh0EPca1/74vF4ls1TAvFkrBSfJ
         mULcUG2mk+AYnSuOIGz5lTx9qjWJB3/KgoBPJBzLkSD0lECGvj6wlUvsRHQbviujRnP5
         7oWA==
X-Gm-Message-State: AOJu0YxEy2hiFasdzm1fC5Es3d1HXA71sfi7n9cC+z6G3yik0YLxDKF9
	SyojQF2fPjDolbKUZjIArKSpkpU950DMvqQF6lfZVqbGWe/XQdlryznhskgXOawdcYCN42tHJ+p
	FdT7Zygk=
X-Gm-Gg: AfdE7cnRlHOagac/Cz6+YtXiSN+AJx7ADHEdC9quycKDwwmcX4zge1v94CU39g+NIQh
	MOEeIFBwLXPzScjggoFSH4UQzp9S11GriumCyPPqEYFSrZtoI4vCj8ZETeHT51qatNkjgaInUy+
	WAF67Dw1C/WoI9EHV6oCG+mjD3mxs6R2IeqV8ijo4gsioUN5UITTRdSaVWR+31vznAYlTec9AEZ
	cw1I5NZ6JU6U5Ny1QjPp6fl3bR0dX0X61U1jcod4nq3maCIlaLgnQLgFIEkMfOCeP0r7fkM8Np0
	rQgmw13pD7f+J1DDPQ8+/DomensxgSK4VQR8Z3DvNZjUp+zc/C7pxeMzRgHLT2e1j2yUDjhZcxn
	W/1FX+PZgqW8s0DzSi1K4rJ1SpgL8Z5UMqlwfCqDg1GTK26uljh5i6vIbh6q6k7LQfjxHnHNBy5
	+s2CRg1b6IiXydLPGEvn5uZhSKVCmfmb/ptlbaDfYywxLx9V0=
X-Received: by 2002:a05:6a00:194d:b0:846:a04:acdc with SMTP id d2e1a72fcca58-8482f4b7b5cmr3314045b3a.26.1783441218770;
        Tue, 07 Jul 2026 09:20:18 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d82382sm5623567b3a.49.2026.07.07.09.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:20:18 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH RESEND bpf-next v2] selftests/bpf: veristat: Minimize map size during verification
Date: Tue,  7 Jul 2026 12:20:12 -0400
Message-ID: <20260707162012.8063-1-emil@etsalapatis.com>
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

CHANGELOG
=========

v1->v2

- Removed unnecessary ARENA, LPM_TRIE, and RHASH handling (Sashiko)

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---

Resending because the changelog's formatting was messing with the
patch's actual formatting.

 tools/testing/selftests/bpf/veristat.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index a7db6f04f7e1..a2a724c3893d 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1248,6 +1248,30 @@ static void fixup_obj_maps(struct bpf_object *obj)
 
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
+		case BPF_MAP_TYPE_HASH_OF_MAPS:
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

