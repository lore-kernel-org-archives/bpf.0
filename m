Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CD217D6
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 00:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783384380; cv=none; b=ODzIFomMAnqV3dDx21YB8/IgxmCX/pDLInomfitCr9BDmTIyDOfN3/X2Wi/+V4T/3hkbunY99saTVaiNWHibIcAcXQxHdtyjsJ4FX4WlVcOGwAlU/ko9cIOgHgRzNP+qlDu0tWJY7lHwGMnLiqWTfIq3xk3Q5FUhHrlFCUwwULg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783384380; c=relaxed/simple;
	bh=B0Z42UomWkwWYTkXbyk6jZ9SC66uEL3BvVR3LSqzwbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FUInZ8dMsNXfUG7QVwZdluOoxeow4oaCbYsEY2bwtHBHX/sVO+eMxh5BfzxPwv60vJ3PO//IjpNrYA3VAfiplZDFTVxlPVQoZel8a6jJ2SQreyT6lZNxUVqtkD8M9a6s4eDtTWf3LqA18tMiqD78PTOyhTnzWjZbRhgler5xQCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=AeTbaRTX; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="AeTbaRTX"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso2821183a91.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 17:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783384378; x=1783989178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UcRPZHQZPkRb2aTJgKBUGQ4QnxVrUzwyoZZD2qVUr4Y=;
        b=AeTbaRTX61mX7Sko863h1YOufEZWD3t2Y3KB74hGWPuaVR2I1GvQngbJIvAIUczdk4
         z8ZW2xnfgWnzAG2rvyrE3od9BXnKp1ZLyKkPoWUG/dqpRvo9ex2cu8/q+lvL0vGEO1PZ
         9Kneafoyw7nqLmz3efIC67CXaB9O6Qh+QyqDAx/Li3yXKPLr5oAto0BPivoly1KMY4BK
         NRWWnWR2+Rfafp/CULdybBOTNSKiV3t09khzFk9HdHyl1GSCw0s2Ho2DRWTxliH90JKJ
         V7ekp57ec/avoa0vwFsGPytF752klQcXxs8h1uDVqVnL+/Eh3S0DzIm5UGTSyIIbuhjK
         s/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783384378; x=1783989178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UcRPZHQZPkRb2aTJgKBUGQ4QnxVrUzwyoZZD2qVUr4Y=;
        b=iokaetsqNdFoiEwYL2pimIsHPRI+3xnf36C7I+yxrgzbUEbg5d3kwR0CbRleVmx98V
         qH9KVPO+KIEkfvthH1F/zo9JkvwVOVCs+c9Y+Vsp/BPXk4X0WemWciRhxO3Axs0oXC1B
         bnbXDe+bjy6KRGtPLWC0K/Uqrsj6fDQJHYPRz+7qGov6BXyzf2lA1yhaU9tVRq0qOMOt
         FDcmri3MeeUlSmAe7xtDfjoj52/m6XW8hrDvrmNC3dkO22UgJKETxhM43p8JYt6YC0Aw
         U6uekdd4FjO23PrGdiq66702Z8dDFAnj4Rfg93dD6IQTuh5ILwNZdfrY+aOazTAWFHrY
         t4jg==
X-Gm-Message-State: AOJu0YwUL0S4uI0vffLK2KZ2Rk6mJHD4jzDYp7eg5GNioNDK++/RsTB1
	ldzPxoZJXPrGJfvj3ra95REpQK3571QKgB1C5IUU8va42zBe8iHdsS+oA+7qKbZmcsX/IzX8ZQF
	oAsvbjUs=
X-Gm-Gg: AfdE7cmZI3Ylh2RVVL8eINVu4lUFuPHJxlrhwv4McFvSzwdV3fqwsPl3/zR3p6zqnDh
	zoUKXANyrdNY5xuJlq/+BX2B+FsNnVf4PzZ/wAkMxBwqlkRKlOO+ggj4IcF6wORfXVNFcYyPZWW
	XrfHuIvRF0IGkv9zOhRNxX90Ppbk4Ndfljpv9mGmIn4QQab6NqZ1UnKWQTV/X5/kcDZ8i09IMnJ
	E+ZeICGWAiJWTv+5J1OPGHa/AshTkZSY+lGwTVvDnPs4MEPedUg+/gUejLpcdJKIcjoA126PiQi
	EE+qiHgS0ofH5eSDwZNUAen0cfBEPecSkvV1eueK309I0UGFE2Q+w6iH37zYbKsqUOz5nWSUITC
	PTAz2KORV1T9GFL77RhqirbMyTCe0/zF7cm2EnGse4aJYW4sKrSwJxd8c62PUKlBo+YxQHgG2N+
	P9qFYvUlYRlGN0JDoNOTQ+rtF5xlA2ji0pbQpQRePVJwDkPXyQJNukrKaqFQ==
X-Received: by 2002:a17:90a:ec86:b0:37e:1bc4:b6ae with SMTP id 98e67ed59e1d1-387568fded7mr3185153a91.8.1783384378477;
        Mon, 06 Jul 2026 17:32:58 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9c21429sm2320685ad.37.2026.07.06.17.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 17:32:58 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2] selftests/bpf: veristat: Minimize map size during verification
Date: Mon,  6 Jul 2026 20:32:54 -0400
Message-ID: <20260707003254.41068-1-emil@etsalapatis.com>
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
------

- Removed unnecessary ARENA, LPM_TRIE, and RHASH handling (Sashiko)

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
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

