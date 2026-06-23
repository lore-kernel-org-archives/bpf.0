Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65213A4F2F
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 07:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782201252; cv=none; b=ZgY9SLhE8cHnVnNf7d4p+vFcqwarKH040JWC2+3z2peg09np5SaGHNGC5VBtD6BwScS2umx6X59G9Q47oBRrVS28bxga4F/j1gKYMsifHk1oGdPYSSol2Heind7W92jrLnmhg+CCrrL94fz4oWhzDdzLiJppeVfI5QQY5QTXMEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782201252; c=relaxed/simple;
	bh=CH3Kk+RE3zK+JE4ex1pQs1Am2dF4T9f6gymStnlzduQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=L6haUniIEJLMMhc1DfG4ZTm8q7dYMohoJR4DyMNXtZ+kOAA5b1O9wgbmiDwrpCA+VP3Idf71G+COyTvvMmxh9KOmftDEPAbDe2D+BAwXrlPkqBKlgzobMj1WIN0/wxVJ6NSl6mFe9wnIkQTJO8eJgZqgI72+CHuRwcFJjAmtmSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com; spf=pass smtp.mailfrom=digiscrypt.com; dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b=mnrQLCJ/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b="mnrQLCJ/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c77d52bec4so3856205ad.1
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 00:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digiscrypt.com; s=google; t=1782201250; x=1782806050; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7YfaQEDj+sWd4M7f7+/67tnUelacnVmKPVOLI4jLTSg=;
        b=mnrQLCJ/M1uUN/hWTIGPVrNgG+o6AioEuYdKmxGLzkzgsXTLzcnChJYTujqUqd9UcC
         HaGi7XjWWpBVvF80WxCnHdOlO2BYMjxhy9DJnZBFGhUHIax19MezQVaiyjSWT9YiJ3AS
         0du9GA56jtPpNbkPUCqIVFbDYbp9Td56xoiil+pBT6qpLXUGa9yJo7XINNRVLO/Y/Cwa
         44AiZ0g02Hj5TzxW2pqUtnF234MNzKwWs9USY8vBLK28rEZNXXWq6x/ynH/evabPTRb3
         3gLw6QIBzV+UGVyK37z+oV1dYFkR5J6K6wT3EVtKcN8YcCL8+71gFSWq7gpMLjwSs3Ru
         mJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782201250; x=1782806050;
        h=mime-version:content-transfer-encoding:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YfaQEDj+sWd4M7f7+/67tnUelacnVmKPVOLI4jLTSg=;
        b=lh6L0rWHyjJEC6uX1FMAg3RgZGRYE3EuoOVQ69BZdqb8LGqxXoN7oiDkKXqm5hzXlD
         bxJ35w8xY8QdKitol7Papeg3Vng934ZHraXHrxcTZinXXOzlJowSofXFGKC4ulGQXlR+
         jAn+2laJIVw09nD2hpUicwCqSjn/RdiJhQy9EgRwwsC3jfw+uLQdGbTaOD/Ud1rLKtxX
         ZY+tdjGoyxd6NSuGg2k/HElfNFxh6Ft/jKnGiti6fgWANoxmSlsMNY8kj4iU8+wTjIXa
         mZpCnvLzAAotDmY27/7r/BjJwWuM+w0qqoAbBO5VWpbfRnnKdShbz82QvRQFCbWSVpPT
         tTAQ==
X-Gm-Message-State: AOJu0Yycm/i3T+yYGSVgcFOmVTCH6DcrEEmZBGR00k2A8bMIRtbLnoO0
	+lzfbz1DVFuvrwjnL/5LNFdyC4+y9XDJE4TAJ47Yik6akG7T50G+XiiKFiLxx5qWa479xJ7dXyp
	R1i3dEj1rpXE=
X-Gm-Gg: AfdE7cnGA2iMar6ATfm2uEHt095VHHpKBn5wwWqTYSVx2a7hZQatoqLetfYY00RrAtz
	pKEg9u2A0YhwR+OlYbtKUZT3Bx/R0Ktoqu0daGCgtsvzyZImen4+df7aq3JzbZiWkrHnUILsvav
	yROniw4RdhsfoE59PNAeeNOxommwgr9jgxHJuV8J5mr6bllqVwlVt5NeHM4tIT0du6ONWsP74ik
	Pdj6eWKfpWmXHwVba0HPpSDy+Lkk1Rt9hdkgUbJaeSsfPryNfbjT0Vc9mfAbUvUv9XttMGMOVkF
	QDGUJWAEUTeDL7ZRjR1oZE83IeS/Dfe5C74JdtSAq/GTsoxswOPWVIO0nOpI6kSvF+x1dIyEwD4
	YCUJnR6IynhggKg8qKxhQ+KDsK81pbp7uxitk6vn0RcNKtMRYTSNpRsSgWgI6VI57/Pu1ytQdaj
	aF8up9VcFOieengfsnn/lVMtS5h1araMGxOH8u9TVN5nu/la+r+mQtCA1DP8E2A+EjzCXbvidmW
	ipJJysBg5j86Kc4kV+BUJ9PbKIAXS4o8kyJ+Nifhew5UFhU4c13/6+vTjFMiRdPOji0yF3dflqa
	pfcAWDM6UvK5NrfNos65+i6qWFMkDLs=
X-Received: by 2002:a17:903:1984:b0:2bd:2c3a:2a36 with SMTP id d9443c01a7336-2c7c3b98118mr23342005ad.0.1782201249709;
        Tue, 23 Jun 2026 00:54:09 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2401:4900:1c07:46d8:110b:11b8:fb24:5255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743bfe4fasm99531365ad.59.2026.06.23.00.54.08
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 00:54:09 -0700 (PDT)
From: Naveed Khan <naveed@digiscrypt.com>
To: bpf@vger.kernel.org
Subject: [PATCH] libbpf: bounds-check float size in btf_dump_float_data()
Date: Tue, 23 Jun 2026 13:24:05 +0530
Message-ID: <178220124597.31744.3595561672327420327@digiscrypt.com>
X-CodeOps-Marker: a5ec7c2c8fa640678803dfc5d3b179aa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

btf_dump_float_data() copies t->size bytes from the object being dumped
into a fixed-size 16-byte on-stack union float_data whenever the source
data is not naturally aligned:

	union float_data fl;
	int sz = t->size;
	...
	if (!ptr_is_aligned(d->btf, type_id, data)) {
		memcpy(&fl, data, sz);
		flp = &fl;
	}

sz comes straight from the BTF type and is never bounded. libbpf does not
validate the size of a BTF_KIND_FLOAT type while parsing BTF
(btf_validate_type() just breaks for it), and
btf_dump_type_data_check_overflow() accepts any size below INT_MAX. A BTF
blob describing a FLOAT larger than sizeof(union float_data) therefore
makes the memcpy() write past fl and smash the stack when such a value is
formatted via btf_dump__dump_type_data().

btf_dump_int_data() already rejects out-of-range sizes before its copy;
add the same check to the float path.

Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
---
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index cc1ba65bb6..922c8ce32c 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1983,6 +1983,11 @@ static int btf_dump_float_data(struct btf_dump *d,
 	union float_data fl;
 	int sz = t->size;
 
+	if (sz < 0 || sz > sizeof(fl)) {
+		pr_warn("unexpected size %d for id [%u]\n", sz, type_id);
+		return -EINVAL;
+	}
+
 	/* handle unaligned data; copy to local union */
 	if (!ptr_is_aligned(d->btf, type_id, data)) {
 		memcpy(&fl, data, sz);
-- 
2.52.0
