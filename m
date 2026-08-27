Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101E82F8EAC
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 00:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787790310; cv=none; b=MCniivvLuTOlYqBrUbnkTIxH5ThOwOzwhr7DvG3yRUwHWIN2FRgkGjog6IMG+lfLmIoiu7Ed69VLJRT4aTD76Wtfxm08yxok0d6Iof+LbAjj4NEdF2vNsmDpAtTAC2gfENMpjfZn1TauAgN4B7EtNzQVJMxbF5nDr/wRNHxeNFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787790310; c=relaxed/simple;
	bh=aivOjsls9HNZ0BoK8wC1qhgCC9ZAYmq9DjTq4Fk74uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DuXRyUtcXdeTYqCVy1K3sKUJqLbFNgbl4Rj9uQWl0PQp1vEnBs1cm6RNFwMOQEQlUNYyEagL6K36PGfFl7oj2zdB/oGXSj+qYVPev5cIFeHyEBdM2iF6tAArZYrvrku6HKjPCzrfKEQOS4XFEpGzdpRau9OduAHKscMK8fz4fpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2lARvZn; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2lARvZn"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso2013509a91.3
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 17:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787790308; x=1788395108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EGu/OthjlhnLRh5x7pp+7Sx45nw8yRz6rkNCoV5rOrQ=;
        b=c2lARvZns7uDZ8bZ/9patXml93S+udEbQYGt7zqA9fjR/lkuzMA0Z95qMipGnwPZm9
         JSPRNpEZ0baRRLN2SADgoYHdjb4aDOMTmkd8aE4pkDgNr716drcqwbyd4y3i7+ahLWHP
         XmdD3QHDuvh9AVDjkQlROPCUvFHgaEXE77wFRZAFPj7LD1Noo9tBHJeYguoSTDY0rz1L
         +MUiTHvsYW8HV80UYz/XwP8y1gm66XG9CMFI5CQMGODeQXeaBMbEpkTKyvhlBCF4tSOA
         Ut2qEnsw1F5MS7J0AaOqbdZqXatTDwm7niB654L/+QqDrx1C9HZ0dMHI7LwSrMN8syMR
         UHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787790308; x=1788395108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EGu/OthjlhnLRh5x7pp+7Sx45nw8yRz6rkNCoV5rOrQ=;
        b=CKMaIf7/T7FwiTCewJtwu62Xx4ghbQiz4e5J3+JcmAYMsSKYOfY8bQTd/wUuOjRs2k
         eg3y/liHLHAiZ3wCaRbUiC7DMZ0ZfZZpNp1/8yMwGqfwrk9WJNV1YUtiD1YlWNdUWGtN
         hOqbKuHZo4h5BUOX7aE5JBRvVuC3BLipkIuNyloyCUORMklz+5Set9ua8NUcVJfgMGvm
         ECwSvMkEGAE0Xj4paJE/re/1CJjNwm9skb86XqX1Zzgxwgi2RDoNZuhbRffozD07ylcN
         unmRmZuvs8lnaoPQ48barZsn4AdrOVjKNZc8ysdnyCDwGgZr0gxyNLDH5qDcZykgdl0M
         GpJw==
X-Gm-Message-State: AFuF++mLQigm7lfOdHFBob8cw5eGQSgpfTxg9m4HANMFaMdou2P1ktuH
	VZPOIZNzNyDJPXm8RtRYcNVGeiveVqVk2uu+yFiFvuspDWy5cL7tYoiDCMBrvw==
X-Gm-Gg: AR+sD10Eb6px5BOpVgTHrm3/wfcgw5ye60aP8L/HPbGMd+Oszat0cghfjfQ4S6R9nqI
	aidlE4ggwyIFtnMD1y0KnBHc1rkyv2K8t8ZJ/ec4Bi+aOXjRcglhF2qpbwfSY0PHMZ/E/mOt7cB
	am5+APjnTcan1Yb2aQRl7mAozLJNVty0x4hLzSWH/xIGwjMOsmYb47e5T4GLGNqmVJG70EFkcbM
	fPW+hoynR3xZbk3dJV1zAiOUBhEHpPhmX8hSQbv4ZPSVMRwgsZZgXBWFLYPTJ30Qf9TAlMg3ukh
	4sqUuaRxj2IN6ujX69gVGwFi+aIiuYOgSbe4YU7nM446BvgHuJgsFqnMnxg5pQKcNcBxBMKv/us
	JtqzIEBea8DaePztlJrFL1HwhTLiH/Yez4udu5Qusg1+VFgt5/FHGaWL7Hu6AChhP6kzIjAxtlX
	afPHf9nAbUf3rxJ6UJTfzmhi6rcCqVrjbugEfruk/DVXIYxpe5C4uucXNsl35Eq5Y=
X-Received: by 2002:a17:90b:180d:b0:38e:4f41:83df with SMTP id 98e67ed59e1d1-3966d8e0f37mr20888236a91.15.1787790308243;
        Wed, 26 Aug 2026 17:25:08 -0700 (PDT)
Received: from void ([114.86.104.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396759bf3d6sm1569970a91.4.2026.08.26.17.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 17:25:07 -0700 (PDT)
From: Tw <tw19881113@gmail.com>
To: bpf@vger.kernel.org
Cc: Tw <tw19881113@gmail.com>
Subject: [PATCH v3] libpf: Fix for the potential undefined behavior due to shifting
Date: Thu, 27 Aug 2026 08:24:46 +0800
Message-ID: <20260827002503.1425820-1-tw19881113@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling libbpf with sanitation, ubsan will report the following:
```
left shift of 1 by 31 places cannot be represented in type 'int'
```
This may lead to undefined behavior according to the compiler implementation,
let's fix it by casting to unsigned counterpart before shifting.

Signed-off-by: Tan Wei <tw19881113@gmail.com>
---
v3:
 - Fix a bug in v2.

 tools/lib/bpf/libbpf.c          | 2 +-
 tools/lib/bpf/libbpf_internal.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b749c0174..f09cbfd8e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11738,7 +11738,7 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 				errstr(bit));
 			return bit;
 		}
-		attr.config |= 1 << bit;
+		attr.config |= 1ULL << bit;
 	}
 	attr.size = attr_sz;
 	attr.type = type;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 4c46d34fc..cb4d96233 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -77,7 +77,7 @@
 #define JUMPTABLES_SEC ".jumptables"
 
 #define BTF_INFO_ENC(kind, kind_flag, vlen) \
-	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
+	(((__u32)(!!(kind_flag)) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
 #define BTF_TYPE_ENC(name, info, size_or_type) (name), (info), (size_or_type)
 #define BTF_INT_ENC(encoding, bits_offset, nr_bits) \
 	((encoding) << 24 | (bits_offset) << 16 | (nr_bits))
@@ -259,7 +259,7 @@ static inline enum btf_func_linkage btf_func_linkage(const struct btf_type *t)
 
 static inline __u32 btf_type_info(int kind, int vlen, int kflag)
 {
-	return (kflag << 31) | (kind << 24) | vlen;
+	return ((__u32)kflag << 31) | (kind << 24) | vlen;
 }
 
 enum map_def_parts {
-- 
2.54.0

