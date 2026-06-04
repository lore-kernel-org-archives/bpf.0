Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09513164C3
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 22:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780610961; cv=none; b=qQXBij+lHiyNIdh1HpgguWyeIbMvC686Sl1rTdeHBXhFXRAh8FTfklVVHwjkqtMGmtTnTbc7LmBGp+EnJFUOHuO3KSchAM5XZqm7P11En/X5r2rkVDdfgTXfJot7IWCdiQviogd1AEf0dBkorGns6Daf7KJvXQdK7fbyRh33qn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780610961; c=relaxed/simple;
	bh=mEvyukhAhdQcXVildxDzfDWhPWDo3cluDvmrIumRn2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrSRinF59nySiSsrqHjQWNxgYiKKt/+GQ/Y4dNC/K0y+MRPvepTrC8IFkt+6X6plT7uvXrKpguLRiWSi/4hLv3fO7nj4IPqZLxZ4GA4VUaNaK7HloWkJ+VSMlezdPgSYKCQ6Wu+bDCdTyQPruTDXhucO7JMLveGC6acfDRR9EtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mh+UK77U; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mh+UK77U"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c32f6ce1so8566585ad.2
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 15:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780610949; x=1781215749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WskOQGo0lDwUWYHDxbKfENWvvFNug6jys3p8dhOE0vs=;
        b=Mh+UK77UV2a/xlyjl9xhuM/3TYq9Gk4J8HY45nIGfsCx3Dss6e5TpDtXFgUUHuh3O0
         jjNX6lWIvDXTUAEd5ln8+I+xTSlbUtv9GZLZRfam3CUIo/91SipSwYwyCXu4Yz/NkCrn
         sNJbt2qu7RrZjK6vN2uFxAanbGt7L2i02LpHXtsuvKRz6BGUtfup4tS+ZrJVvWNG0qph
         9q1wWTS0bJx7BNafUGUjbDTyLdFnlTDSJ0EVsdwmT7s7z1kPCRpfn5XrP9isEW1/DEL5
         1vruvK18qngje3EvCpQBDDKGeXzUg1Do99RM4gfm5LU81ZRfCkKnF2HP2mSNKDmI7SJL
         aO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780610949; x=1781215749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WskOQGo0lDwUWYHDxbKfENWvvFNug6jys3p8dhOE0vs=;
        b=LSenCr2LqJek0xQX2PzNQD8ITQx20X+QkhcGCgFu0E3l41wFTY1OoSZA3BCxFpE4xx
         jelw38GmwVp6lQ/HgnBJAJoB1tocEhkBTICuACAJ3SI2OKdI7eYut/4vySBwnur9PLJy
         2JB3iKBdfmKHy0dUYZXE6JczSeIZ1Du78x04xvxoWM05LZDBqb0RQglwrV6fX/4h80/5
         phpSblmUkHK6nLsas8ZkdQmHOeF20A7MSieTt8dFK8C8fXhbUmdxGbillTAuhnp3WoGJ
         kkMtzfoR1bghISAIGNK3/W5iBwYI1a7lFkxSgJawIJwIJ6e/AGaV1pNbbwyHjQcVGZd8
         yGQQ==
X-Gm-Message-State: AOJu0Yxqgg03/sKhwl/2sr4yReJl5rSOyAzl2brE3FMIJt6K3Tll2Xgm
	mL2BffJ15WY6PLGGIiwS6QIRcKTtnhcJffjUktCoJvYMa7uaG5gEfkhpJE69Uw==
X-Gm-Gg: Acq92OGqZvo/Ccp7aF1MTAEaxSDW4K4KPnPoktc102bh9v1MAiQJLA4GkPuVX1lj+o4
	xuGsHXl2BDYQFANRWFM2FBD8PamsQQ/xr2vG/+1IpFpgZ5LSOpx9OxLYxYEq3DyqDzpyOQI+YIv
	OdhS9/eQwLZEENkJcr+Tdm1yMfmNJWFQp9yIPZ8b8KLd013fVNrTWyVscWNfCCqKQ3HCQ+rKVCI
	m+XoQu980fz1wYTcNX801ihlIdvJN1hhEes6MMF8Wok+wosUdB2uJucyFcPvHRKwO0olAMPRgoy
	R0OA9rKlxwR40syRNUARJcsDA2s9wrOnZ/p1qveaa5IyU9/t/gXQP39O9T7I4B3xWJTCpDNQZMH
	i2fAOcy81h+MmkLJXNO0lID86EwcKY9EXX/Uro5BfNnGO2ypTQU2e6JdiIbuEJlQuzLieT/ypx7
	Mx2yWIl5yhzrHDljkHUq57zMk=
X-Received: by 2002:a17:902:c949:b0:2c0:cb90:1e08 with SMTP id d9443c01a7336-2c1e77754d7mr4997365ad.0.1780610949014;
        Thu, 04 Jun 2026 15:09:09 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629c08bsm70177595ad.61.2026.06.04.15.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 15:09:08 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: Use bpf_dynptr_slice() to read file dynptr in leak test
Date: Thu,  4 Jun 2026 15:09:04 -0700
Message-ID: <20260604220904.1032145-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604220904.1032145-1-ameryhung@gmail.com>
References: <20260604220904.1032145-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

use_file_dynptr_slice_after_put_file() reads the dynptr via
bpf_dynptr_data(), which always returns NULL for a read-only file
dynptr, making the example confusing. Switch to bpf_dynptr_slice(), the
correct read API for file dynptrs, and read (rather than write) the slice
since it is read-only. The test still fails as expected.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/progs/file_reader_fail.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
index d5fae5e4cf9a..3bb9e2612f8f 100644
--- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
+++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
@@ -87,7 +87,8 @@ int use_file_dynptr_slice_after_put_file(void *ctx)
 	struct task_struct *task = bpf_get_current_task_btf();
 	struct file *file = bpf_get_task_exe_file(task);
 	struct bpf_dynptr dynptr;
-	char *data;
+	char buf[1];
+	const char *data;
 
 	if (!file)
 		return 0;
@@ -95,15 +96,14 @@ int use_file_dynptr_slice_after_put_file(void *ctx)
 	if (bpf_dynptr_from_file(file, 0, &dynptr))
 		goto out;
 
-	data = bpf_dynptr_data(&dynptr, 0, 1);
+	data = bpf_dynptr_slice(&dynptr, 0, buf, sizeof(buf));
 	if (!data)
 		goto out;
 
 	/* this should fail - file dynptr should be discarded first to prevent resource leak */
 	bpf_put_file(file);
 
-	*data = 'x';
-	return 0;
+	return data[0];
 
 out:
 	bpf_dynptr_file_discard(&dynptr);
-- 
2.53.0-Meta

