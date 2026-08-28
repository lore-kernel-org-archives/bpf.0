Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62EF233920
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 00:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787877295; cv=none; b=RaR5HF9p+MYwuf/3veiQQtmN4B/hUhzQT1IuTKSywK9GnpSVPzzEhP3G+WGNPG2pYr7TzjUqfu4Hr5Y6kQ/RzhMOODrW7+IpVmXEplvrHNHZnnPZhl3xFlyhnt2phxIT1i1S+utm1ugOwb5u8zouqMd6fn/U4Rg8JfWTpMjJKeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787877295; c=relaxed/simple;
	bh=356snT1jcj+p7V3KyhX9p0LFubtw0qaB7sACBeNRYfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ihMjyy6GdFt4y14OdvdCapuGFDDxovnOv3IGtZcL6/bbhPjJycvt542u+5VaQvEQ0Luh0G1aVWT4vAPm+F7ZtqB0Hz2/VIUrEPkY56t1ycX+d6Us85/jAVCr2fM59gaO5DqeSa6yJum0UUPJZsNZ+lCAkmpf8fz9q5qqu3KNCIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLuqBU9j; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLuqBU9j"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caced6038eso4813705ad.0
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 17:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787877293; x=1788482093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8yLMrhK23B8+a85bZcyHrbIIviD02rRWcwz/qHQuOIU=;
        b=LLuqBU9jEa75I4jxhkB+ekQRSOm3b9Eo8ZsvvhsJGCWNbK8ORdGmVyIqJs47h+PZ/v
         O81FPtPUT3TcqgKrkp10TCeGIriRDcujVQV0qWG75V6kl5S54FGA9QJFYvRLFdwClIAx
         O9wrGTfU6gcF1oqvFiilsotEV2xcIpRfBahi2g1u5AKrD4A1V/xuA6tr8P3UDRr+/ULA
         Q3O26OSrBMOlh7B1LgMYjzGzreHJkT3IqdVnJBdwPwlr4JPEKBkxqwFZFl+bF78MLc4E
         3Y0Lodd6mrydFoA5/tgl5SB8w0M1Bv9NzU1alUnGaQRaYv4ndbAmusvo2+e4/qabWaR7
         0yhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787877293; x=1788482093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8yLMrhK23B8+a85bZcyHrbIIviD02rRWcwz/qHQuOIU=;
        b=pEX3pGl919CtKamwM8OjRai9hBdvCq/P5PQ2y94oF1XGdZb439y7rWHLJPGgcJxoqn
         4o8+dU8ciud/TW5u3Ffy7OiGamKh7cBDLg6Yq+DF1Q5o7Hi3GreBF9QT71+xSPzU9LSQ
         AZaUOvsGkZwXhLapr+Fa6fXwwYw/hNDJaNZmkiIufnDx1MbmYdwyzon6Cgin/mV9D6Yu
         IZ6LfdGvspa4bv7TqQwelMzWN3EyTb0Y2y70xgFo3GSMWJBXZ+9zw9Snz8H1lo99vHna
         n3n3xwWpsjfF5G90Rw/cVhKHoPlBX2sV7bK/2Baehdv7bEDz6ATXhyCIlDq8atBKyJUL
         1dtA==
X-Gm-Message-State: AFuF++lJLjnH3qSYunxvQVo3QdhadBa6waUQy1LG/2zIrPYz6mBX4bJS
	C6p6iSYRYJnvNJq/QQJaLlAj2SjL+oZvxzG41eV1M9TCYag9zSe/HWj6cBhjn8h1
X-Gm-Gg: AR+sD13HkPrftEglaSea7KWX4W7qmE9PQCOx3ZiS5tAMztexVkDizX/lgIc7iisLvEY
	0MI6QmNyVO1anA1cPVwNYA1EocwOZzrYibVE7e9glcIY09lxfW9Ef1gvjB+bWEA/1D8qaAro9lM
	9fJdu1DZnKVXEePJGiQ4TUeLtyzmublYdXSoWjJGz0PVmIZwfmC5uSbE7I3ro+JS8o3lMuumfJO
	1rXAFdPtk670ocAMDm8C96DXrBQDyHON+09bzCBVt32O0hof2Xqq0TBXBdhoYUUbZSiYat68KwA
	BNOYFlBUdAz/FZSACHQBSNubF9nlAuwwynWEtai5jMnSyv3q6ekXv49VEDDIay8jHJ20dPrkjrm
	PBWLmVVOrqZx3ytWJAc2U9gUN+74RNeav8RKtTWYd3Y44H1i4h54xA/Jy7Hd5bvGObV/nrJyCG1
	/9hIgzPsGsmbZq+l+OL+69ht72qzI4gsE9y3eMcxseJtV/Rc1RDDR9Tgj47+suLL0=
X-Received: by 2002:a17:902:ffcf:b0:2d7:1b20:e98f with SMTP id d9443c01a7336-2d725df6dbcmr140435105ad.2.1787877293079;
        Thu, 27 Aug 2026 17:34:53 -0700 (PDT)
Received: from void ([114.86.104.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75952f3d9sm351925ad.25.2026.08.27.17.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 17:34:52 -0700 (PDT)
From: Tw <tw19881113@gmail.com>
To: bpf@vger.kernel.org
Cc: Tw <tw19881113@gmail.com>
Subject: [PATCH v4] libbpf: Fix for the potential undefined behavior due to shifting
Date: Fri, 28 Aug 2026 08:34:10 +0800
Message-ID: <20260828003448.1684064-1-tw19881113@gmail.com>
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
v4:
 - Fix macro redefined issue in test_btf.h
 - Fix a typo in commit message
 tools/lib/bpf/libbpf.c                 | 2 +-
 tools/lib/bpf/libbpf_internal.h        | 4 ++--
 tools/testing/selftests/bpf/test_btf.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

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
diff --git a/tools/testing/selftests/bpf/test_btf.h b/tools/testing/selftests/bpf/test_btf.h
index e65889ab4..e7bc78108 100644
--- a/tools/testing/selftests/bpf/test_btf.h
+++ b/tools/testing/selftests/bpf/test_btf.h
@@ -7,7 +7,7 @@
 #define BTF_END_RAW 0xdeadbeef
 
 #define BTF_INFO_ENC(kind, kind_flag, vlen)			\
-	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
+	(((__u32)(!!(kind_flag)) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
 
 #define BTF_TYPE_ENC(name, info, size_or_type)	\
 	(name), (info), (size_or_type)
-- 
2.54.0

