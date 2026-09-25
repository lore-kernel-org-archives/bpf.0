Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15FA3CC7CC
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 04:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790312145; cv=none; b=GzZrn+04SUIW6tFols+qORvl3Wt78jjZiwlEJQZi4YuIvbrmtHmmMmmu6ElKqfxLjU/VL9OwyPzE+8EKsUuRPTvrxra0fUp/nIX0ibU+eQNjGPyFzNBZGkbqls44QXRQ3sL1N5+NVbVWwAygRWeWWhp6yF4Oac4GU7JMzqT3uZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790312145; c=relaxed/simple;
	bh=KILn4aSsrU8YEJ2Rf/yoidggV+FOG7tEApjS2G03ae8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3h62rWRC5kMr75K+cHxGn4RsWslr8ZNQc5bI0mwOYtXvTdEJgEyGXwbliYTFCUC8dXb/iwbT/y/KkYQw1mNEzR0+EIpUzQ7CWxOVEBPnxOHgjFChDRMBvfxZjOsSHsxlaA+XJ5O6JJiH15crRlgbpzyb3u9suiHCXP3IPJIHIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INvBAUJO; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INvBAUJO"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e7b06acb8so1930995e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 21:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790312142; x=1790916942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i9WAbMxakQQweqHqWLY6W+9nDinPsU7tYwAzpctRq8A=;
        b=INvBAUJOHypX1UaVR+p2uaEohqJjVF8K1dGKL2xMbvFXboOCy05ygBQhR3qPEDnawz
         PZF/bYOpwkwGCPOB7p9J1m8pJdBhYUlg45N4Y5ThWPHaJwQIPnfQddOfI5DnoQHqKDyq
         YKi278ervrXlnMp5lOg4MnABF7V1LHgyB5UJt/zScYWLiPRawpzeY9NbZdCl1bdcgBS1
         cZJ3ApvVWLwmuLQ8/Sv8qRREWndxBHoNXCHAC+yIiAA8avhZPkbIXS2cr4zB3j0RlT86
         JzKP7IR2zYhw6GRZs/tfdLiN+gAxZRb5ymSrKb2WhnwMlue0CRAb/JzActOr55VcH+fe
         PoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790312142; x=1790916942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i9WAbMxakQQweqHqWLY6W+9nDinPsU7tYwAzpctRq8A=;
        b=V6WKFycN7bXvd6qgylPtmx9UrnASgxTuDOkjW8Pgs8oqvzaosZ2JjuyKT20DBdm7rh
         I++lQlVvL/8Hf7HObPmHM18gmhTUouMS4yJT8ZvquFP/atG5BxY/trVbUmbHa860PiNX
         nf9DF+o7y2bsa59otClj5/ufsAezpVcisH+MhJCsr9sMsFhcZbN7RKZz9tMxTMkeNjRY
         E35FbjpHnIckL43NS0UwFflJu4iTwO1gXRFl46RfOnNOeuiFYtp07DNp7gBecIHNeqBH
         RlRm7gbpbbX9VcTjcxO1cYa0sBVCXBfi0zfw4d3WRDzzUkR1P5SjmtQLlJWyxgLybZhF
         Upmw==
X-Gm-Message-State: AFuF++nmY/mLiMLLim1KaF8evuAzUg/KA3CMv8TLoWIz/FByUuTRvEf8
	6jebHdmhKzg3BPHj1oMz553Qxht8zpyUEi09b4ZTX1P+Hq6MeMvnS/M0FJSOrp/xQCQ=
X-Gm-Gg: AYBFou3myDydYSSZhsnaGa28a36aI5PVNjraJZHLjJD3xsq/xnLsGi84qR25f3RTW/w
	P2Z+FyHSlWv69sISPfben3wq2t/D+7mmDd+cePkDJpYsY63wknj22+iBKEKYR5SHgLka/NwZmpf
	Y5zNatTul25ZAHxHHL3xn+cIU/cBVJKLcYY57bSxbTvcDjnFAYSv5W3RnLK215QhTpKS9m4szSc
	XrKv3DybylgMpAHFJsZRdgYqViJdwBM4om5GS5p1XbyHoR80BS0nYRc69m23m4ZPQfGYpakVOY3
	1tcwYjRctSg+GnqjeF5ti50uWdnmMXbq6pbAoNlsI2FAPxJ36kabwGfGSRCB9PqfKi9xiEElj1L
	fVx/89cVZKCG41mNKxIPZd7+RcfO1Uj5BxSvXvHXzNxra8AIxZVXS+pbDqM7I1yn2bganC5PBIJ
	Dti59tgVFpe5hhy123vRd+Tip44iM+41x2tkLVMw1QDO4YzjVlHJX4o03m8PMtSUVSHi+VC49qI
	T3YB+qzq3qxOYTEPfme6O8KF6zO0v1eqSVZDpbIL+j0mvKnVCN7gENh80eQGhOwOSFELcQMiKOa
	PFD/LUKTU6de6fwDcO05Ac4TY7LhDLpYaJldpv1Aeorc2UiV
X-Received: by 2002:a05:600c:348a:b0:49d:1840:4fd2 with SMTP id 5b1f17b1804b1-49fe7bbaf83mr66213445e9.23.1790312141863;
        Thu, 24 Sep 2026 21:55:41 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5dfa6a7sm188048555e9.12.2026.09.24.21.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 21:55:40 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 1/5] bpf: Skip zero-length stream writes
Date: Fri, 25 Sep 2026 06:55:28 +0200
Message-ID: <20260925045536.1480933-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925045536.1480933-1-memxor@gmail.com>
References: <20260925045536.1480933-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1973; i=memxor@gmail.com; h=from:subject; bh=KILn4aSsrU8YEJ2Rf/yoidggV+FOG7tEApjS2G03ae8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvrvykPJrXFxs4S6xbgn5Edx7Ni6cW/X5427pW+f6Tzp 3omP+PJjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExkNScjwx45/juWF7dM/pKR wxywOGVJ5cM1Z2a/cY2Py2rMKGK8+oHhn+1dz5o/vloLxYLflZh8K/3YuNRwlsfL7dn/ZJ0MBAS LuQE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A stream write whose formatted output is empty still allocates a stream
element and links it into the stream log. Capacity accounting only counts
payload bytes, so such elements never count against the stream limit, and a
program that keeps producing empty output allocates elements without bound
until a reader drains them.

Return success without allocating anything when there is nothing to write,
for both bpf_stream_vprintk() and staged writes. Every element in a stream
log then carries at least one byte, which later changes rely on when they
derive read readiness from published byte counts.

Fixes: 5ab154f1463a ("bpf: Introduce BPF standard streams")
Suggested-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/stream.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 2b80a0599865..9829d1ebce70 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -75,8 +75,13 @@ static void bpf_stream_release_capacity(struct bpf_stream *stream, int len)
 
 static int bpf_stream_push_str(struct bpf_stream *stream, const char *str, int len)
 {
-	int ret = bpf_stream_consume_capacity(stream, len);
+	int ret;
+
+	/* Nothing to publish; do not allocate an element for it. */
+	if (!len)
+		return 0;
 
+	ret = bpf_stream_consume_capacity(stream, len);
 	if (ret)
 		return ret;
 
@@ -333,8 +338,8 @@ int bpf_stream_stage_printk(struct bpf_stream_stage *ss, const char *fmt, ...)
 	va_start(args, fmt);
 	len = vscnprintf(buf->buf, ARRAY_SIZE(buf->buf), fmt, args);
 	va_end(args);
-	/* Exclude NULL byte during push. */
-	ret = __bpf_stream_push_str(&ss->log, buf->buf, len);
+	/* Exclude NULL byte during push; skip empty output entirely. */
+	ret = len ? __bpf_stream_push_str(&ss->log, buf->buf, len) : 0;
 	if (!ret)
 		ss->len += len;
 	bpf_put_buffers();
-- 
2.53.0

