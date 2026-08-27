Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE48122FDE6
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787789414; cv=none; b=Nqmaw69VXj3Xv5MLTiWvp81/NZ/IaIGeXSabifMgS1F2yUj+2SoRcwr+KZJYLD5UTSjl0+WJPf4sw916RTSIsw3ceP0x48+bOQJ4KWfh1TFk6FkJSUzmuk2WqRah65j+xllPZuqlWGiD9slo0UDrDciuOO9ZD/dpNa93JC6eoaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787789414; c=relaxed/simple;
	bh=zPgomEzK2VVzx6dp/i8c/qse7X25KeUa2rzT9/eRgRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lFnPyHZKmIW2lQXgYh+FgEmBKxKXavowukSKVgf80aXCMZ9bQMLoOD1bKH3nJOIOt9V181W+/mODEOpjQG0CEGkQt4mLdxxlIzmwdQ4zwnwcIhzEJ6CrG04pfzl7QeCk6vHYD9xvYVimuBFGZwSnskgIDw1MbS3KFr4Q39LyoKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMaWAry6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMaWAry6"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2caea3f742bso2376295ad.0
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 17:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787789412; x=1788394212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ikKdJgcx2GZkYBvuOXkFl4OImejLWVOyFyJZbV0374o=;
        b=jMaWAry6xZa5jgwzbzWU8wp3HB+gibOZMwZclmzdFDFZCOG70a/ZCDcw7tZJnWTMh0
         hujk2ttJSWULY8Y7UtJxVVtU59x3mUebfXDseOAIh76lMjPKzixhp0JgGfbHOO0vCcYq
         OAOhGxNw3uSSQVjli0+HMkWWoHDkd9Ybb+nHzlaS/ozt8nXVPBrlJEZj9BcIS0x8QF3w
         XO2v4rjhD5Dw+hjDjPjbiA9uZzDPF64Ac3MSCahzZLrkr2fAlPMeMoQgmpYVaEBnvJXe
         FyiyMhGjq9yjIMNUpng++83LxORKklDl6mslxRc1AWo6v/+IEuYBymWueFxRKVwG6zzU
         Ynzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787789412; x=1788394212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ikKdJgcx2GZkYBvuOXkFl4OImejLWVOyFyJZbV0374o=;
        b=KHiML7eL/duY19870xBV8U4m4LeYA1TV/GiMfKPBAuRszPvWTkM/l03Evm45bCpXkX
         6ZcUtmrVRrE+Tllrhg+iDDvLPn1nKuzW5GTd3DcAM5WXgTd7AXjRXyo65Tvbwh6rFUav
         fFRT5AYL7kfSOYfH0Vlkx97vJKFQ1u9ozeGrrTzhNSofBanX02VgkS/yJH7MBz0+0ByX
         ATVnuoDpXbE49j7VQ0lgNptVyysF9w1G/Ntgkf7VznIvu2tDB/smFraEfuje0AGoeUe9
         i3gQr1om1TVuDBVguPTMZNoArFAF5Qx6nDDNpmsK/k+xOvlq4vWQIpKHHyACYO+7NOtW
         E69w==
X-Gm-Message-State: AFuF++mIdldWH21AZjZoUouS4x33TJgDo5KsfYpTfWj/9o3LIgxOmuyg
	oEFEagzx1tVqvSnF6TW/LyUVs+IkQXogP2ct2rmP6OsXlKqvmLmIn7QbPCnhYtvd
X-Gm-Gg: AR+sD100L7oXj89ZbJV5IeKnw6Sxx2jNWYWCpC9JzHVX3VVAnFCNB3JoQpdkRQ/UCJ7
	ZatFIXNCalRt96gIJvEtHf6DPL682IDDAQsHF/p1P5D/692tj9zHTVw7wnYEoadMFKrcDNwGrT2
	SJ6mQVHBTxOmtnh3deYlL/Jq+pYpYKRNCn+brG4e3R0l7ZqVsiyIihUGKlCE1XIM+hFeFDwquWQ
	k3BWh52Mk4HoEJAhFQ52iWuucLRGaUW49aFh3zrqIKpp089kWv/POG7bvLk0s7EGEMHf3D5+uwY
	ZlP+YKJa442BZvtUP+/nRkGl8rPuAzB898lVTfxq1L3ESt4D8pKA79nRSBAeQsc8L0NPVkbLsoF
	mvcBZDIT4ciLjSM5JeEhIqZHlMYXWhdaDtnhci2g8wIUKZunQ2z6sQzP5yegHXJmgy5pYx3ZXjD
	tWzsI6yR0oya1WA1CGSiw6I91wylANnPJKwrOs0s05YznEeM2qPq3yO/yFr/BbFtw=
X-Received: by 2002:a17:902:ebcb:b0:2d6:3c2f:6a5 with SMTP id d9443c01a7336-2d707b9cc29mr211244245ad.14.1787789412007;
        Wed, 26 Aug 2026 17:10:12 -0700 (PDT)
Received: from void ([114.86.104.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d70498b7a6sm11929065ad.25.2026.08.26.17.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 17:10:11 -0700 (PDT)
From: Tw <tw19881113@gmail.com>
To: bpf@vger.kernel.org
Cc: Tw <tw19881113@gmail.com>
Subject: [PATCH v2] libpf: Fix for the potential undefined behavior due to shifting
Date: Thu, 27 Aug 2026 08:08:53 +0800
Message-ID: <20260827001007.1420507-1-tw19881113@gmail.com>
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
v2:
 - Fix two more cases found by AI.
 - Refine the commit message a bit.

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
index 4c46d34fc..2df1df3f3 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -77,7 +77,7 @@
 #define JUMPTABLES_SEC ".jumptables"
 
 #define BTF_INFO_ENC(kind, kind_flag, vlen) \
-	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
+	((!!((__u32)kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
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

