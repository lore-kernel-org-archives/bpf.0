Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BD22F5313
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580949; cv=none; b=TGI6kMYePx/vdIpohxpKhzICGOuXx5+yw8TDYIsyqyr7SP5QBbqsaN2iO6g+lZkPimGuaVV4+6w/K/yuqJJlPfBR4VQFTSKIfOxhQNvSomM4ftVFVuQ6vya1zeNm5y1qNWW3TJ0kn1PjsTWcfKJ5icQ9bdkE+NvawxgG43vvlHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580949; c=relaxed/simple;
	bh=id8aaOBApNzFAlvMtqZtuplLt7NXDJHb+c2pmGHdE38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NuksLF0RWNJbUtrFrDvlHCiAdGYWmTihST7EPRSLsa+nqBg7Z3Txr+KpFcP5aZ2klvOXiE1SDW8JgLAr2E9AWCYXGhpHI1Q2X29A0CbZibf0AR/FjLMwWFnpHH/95Ybnv0mo9FmYsIDFdsVWXuPbXw5rEZwmCbATQFXbjYh0GTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+mvcwM2; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+mvcwM2"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso3645765b3a.1
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787580948; x=1788185748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dBI60On20/l+KZxVgc65ZDWskVOQQ+0+IeTrpO40fxU=;
        b=G+mvcwM2h2wzSUM8Y2XrfxWCDjjrPxrrTNH6KEV8UfUbP6KHteX7UWkVqUIwlnzad0
         SbSIr5+I2rf4+meTMgxIWOcZTBemsPU7Tq+7H2FE3k8KKfTHW28dsUbf0BX2YjavMTg9
         Zm8PI3SVDBx0HtWcA0RizIFsJDWSUFqRTkkCr5I0KCkB3N8EITYwDKiIsuw4FF5t4OmM
         kntl30FY3cVxRHVCnP28TsJ269uAdOj3JIVfwkYQqtXNiFLfvwPIgHLy5A/N1fFIUvzV
         gVAkIdDEPQ5EWC9MA5+tKB9vz/3mEmp3LnaGyYN2vBEdSzZIdXetBuyoqcoPtZvP/JDO
         l6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787580948; x=1788185748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dBI60On20/l+KZxVgc65ZDWskVOQQ+0+IeTrpO40fxU=;
        b=T2FHbX6/71NyQ6b93VHczykPsGXoHdOA4cAjY43d6YStLSAH6qq45MVv/bO+hYUj9Y
         eFMb3WgFeJBPy2V9Wjtz0u2at97gNJdVnMsj1xpW97XW9o41u7z8aCvgVtqFcWji+8yx
         NN7sAEYdHXWmWPfcVh/mbGxna8wstHuu1IaUtQnCm7Z9iIr4VkRRC7cYVir1khJq0PW/
         6+1Z78L3OEveFnyByMP7rEkI3Lyg1ZZcY6+OoGnzauBkxOnfIbcP2LcfJ9y5N2HJXT5Q
         4SpIZWKTG3f6iwMJ3rp5ehQ1BZbO1ZEwTIoXSCrBYcIOr0W/1XOAWgbDNNpV+T0XXNsh
         gpyQ==
X-Gm-Message-State: AFuF++niWQ2f+G38v/aN9JJd7qKKpXnmc2RRHFZnw4JS9YzQccbX6mHr
	3A7j3xxtMHfaqzCBgaPXnr1N+JzeqfPujEizUeWPSLKlmGqI7jhIPN1m264swZkPVyo=
X-Gm-Gg: AR+sD11pqrPVSmfESP/6Lzfo59cl3xF7P3ea5LD8Ya/dWpHe4Lv+bmHCIerMaCcBGUj
	ryWtPO+L2wNyWmrV9TLTQrx26zsZxMAbF7KYWJR82m1ivXrA1Gej4qoh4sCB0MuRMnECys3CwcW
	CzG7qkwScvYpTngpdvDdpP4hS7etaEOf320p8Anq2cW2QIuVmenAHB9zBSo+RyKxpJCJqd8UDUF
	+gubBRB+GUajDHneUMy3KXfNnkNsI4fBLAEeTHN0a3obVZF3xJqQ5xrL0AiT7gcoLXrx7+2drnT
	EWOsGxiwUygpr7c7ZLdDA/4hgUNXMV2k6AZSwElpCEXo8cgp82zj1eCs4R5I/ayUiIFA/tUMNXZ
	BZKIl2Ea/NfzFi3zm5vhwuL9tzE42fFgva1JkH80Ojpk+YHR4+z0bQe+J3gi9NFjy6O2b05iLWX
	DAvXUluFcGojrfy/pSBE2L2P7Stp+P7dOrWO1iLEockoK9YJxysN2PRB7hyjZMWE0=
X-Received: by 2002:a05:6a00:1d8f:b0:84f:a7bf:8fb9 with SMTP id d2e1a72fcca58-8520b9c6cfemr33696541b3a.3.1787580947799;
        Mon, 24 Aug 2026 07:15:47 -0700 (PDT)
Received: from void ([114.86.104.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f149e77sm2064253b3a.42.2026.08.24.07.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:15:45 -0700 (PDT)
From: Tw <tw19881113@gmail.com>
To: bpf@vger.kernel.org
Cc: Tw <tw19881113@gmail.com>
Subject: [PATCH] libpf: Fix for the compiler sanity checking
Date: Mon, 24 Aug 2026 22:15:27 +0800
Message-ID: <20260824141532.604269-1-tw19881113@gmail.com>
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
let's fix it by casting int to u32 before shifting.

Signed-off-by: Tan Wei <tw19881113@gmail.com>
---
 tools/lib/bpf/libbpf_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 4c46d34fc..222d2f1c0 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -259,7 +259,7 @@ static inline enum btf_func_linkage btf_func_linkage(const struct btf_type *t)
 
 static inline __u32 btf_type_info(int kind, int vlen, int kflag)
 {
-	return (kflag << 31) | (kind << 24) | vlen;
+	return ((__u32)kflag << 31) | (kind << 24) | vlen;
 }
 
 enum map_def_parts {
-- 
2.54.0

