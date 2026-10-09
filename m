Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4BE4BE44E
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542921; cv=none; b=pR0GxreTVvdSoGJOxX+cjg5T70nKnufWhDqkkjHCm73yQksAUSk+mXcVLmj8JYSsZKBmK99UIiFMjb6EXELTMjasi/eqbitW7EFQYLZy+yjx1HKpgjnXzTL1cQKmT36h9/7RtlaI5LthfMxGMrJVMm0x30xpic6Sepn93fSUDdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542921; c=relaxed/simple;
	bh=b+d2xVLVvNQ/m2pSoHTpLRBqVDd3PasakBp4l1JxC+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPqolgMbROQwH2jcIkzXopFBZNgSE2ENa59GNEuXCcEjPw9OR6QsMc1HMrOiNJXPTCNljO7l+w1PVP/1kF0aQzk8kqfmS/pA8rddkMF9FXDeIyXv064UhIKAIwvQ4OSylIDUwuceUdzG9d/3+7tQLudIt9YKolP01/daHimvsGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwKtNSef; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwKtNSef"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab2bf5e75bso576814a91.3
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542907; x=1792147707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iZ26yyVTjktNd1GjbvBiX0vBeTQt/nL6+4U5zZp+AhQ=;
        b=OwKtNSef71bZ6f2ZC9Sb6pBynLeWKU3glRPWtFa2Xx1Nm0fGs9UG6leZ/zE3Z/kAqW
         +oVej+BYcGdikUXYD6DkNk6KnGbEWdhNnnlw7hlZAPSVwXTu9fOSOKcAO3WHS4pqNwlO
         ZfSGThFocUT8FleaBZnER+Dw5ryA1JwdZoifE1NQURxdxs5fQjFIpBL9ME3ZT8PZmbEm
         U6T8MdiHeEue0iSV4bA1mJHIGGXDE/6oeLQz2u1et678eTE/uFh/99WBQaYGu/Dl9oil
         /cCTsvcIeY7sSmx52/U5AKoJ1lwbfEhF8BKrS9WQZnnC/UczfEwxBG5cQX/Hr5jT2qLa
         AIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542907; x=1792147707;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iZ26yyVTjktNd1GjbvBiX0vBeTQt/nL6+4U5zZp+AhQ=;
        b=Bi5ObJyx7jqRLtHChVj+3XlFmu2cITWQ+u1Q0oqcM4EbiWQVIoKg6aM1WbtAJsVSWq
         j6LNzirjGQcq8qXWqzXb76Mmkv1M2wtHcaa3N6wJKStGJ1caAWirh36jjs1PrlSNFDMS
         E9y0509SK1M+JKEEkjfv28gg+CpdLULP+bQL9MDEAZ15MTOwmLKi34gROVwsYNmcrOtm
         w9nKQhQOh6cZs5scetGCYRjWt4nBFM+THqcvVYNMRVcDyDbo5VI+fCVC5OviAS+P59sf
         Fg5l/XXU2JAtNUeuLzR29yjdor0Pd4GcTccF4GnP1smQbfXHMMaI883fNpkkF5AxO2nB
         Gyew==
X-Gm-Message-State: AFq9FYIGZzWaoa0qspaWlkDPqLJLM1BDaAdUCaGK4VgR8H4bYAqLiUqL
	FUXKhC6vOpEXXRMe6mYExh2cmUntFNaWNZwtdW1mBLwVKyTk/l8KwoxKJVPuRg==
X-Gm-Gg: AYBFou0uicQkTKx5VkyEcVtuYPYC+ke8XOp1gqFSzQwYnd8pSSGi58+Wgp5ZaG7HkCC
	8czoJ0n3AsHbqLjX9Pn+p8YOABBjOdDxeJh+v8huM1wEbCs7klSp5b6QA9Jt4o8SYScM+0GDjss
	D8OPzpLafzUtxQEqZOEdiEFfyALmf3KsxlJDv/AAFCKcUSqE8WcNZCfb7VuoouX43uuPJoYzz8l
	p93+bmuqrLB+wq1SzciNcg5RSHehLiq08z3cA8ICNByno4694lvsmyPnrpTadukS6oE3zEzLT97
	95ugZq0bcNKVK/ICwnf+eNtejOZjlAt8rUJUNjgtOuV8YW9sfF/h5TKtPjx9my/8Pi2J+DG3lCE
	Vr6VxIF5OkU5xGAeaZb4G+qZBF5rcKWwPGXBD4W/AV56fjRt3rQsltvDnkE2lBV9+0k64jIgB+G
	mAVm2lyilTAoax0ZIjfYFwdh/SxYmSqCUUX1LqQsf4tR13QLQwQjFbtIcJ/SvVUGI9MuGQxa2UK
	3O8pPtrtcfVEhg=
X-Received: by 2002:a17:90b:4fd1:b0:3a8:5fd6:cb6 with SMTP id 98e67ed59e1d1-3ab39feaf19mr1339504a91.0.1791542906696;
        Fri, 09 Oct 2026 03:48:26 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:26 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 12/51] bpf: add tnum_alignment()
Date: Fri,  9 Oct 2026 03:47:30 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-12-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Used by the SCEV widening logic later in the series.
The verifier checks alignment for some memory accesses.
When SCEV widens a pointer or an index variable, it must retain
alignment information in order to allow array access.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/tnum.h |  2 ++
 kernel/bpf/tnum.c    | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/tnum.h b/include/linux/tnum.h
index ca2cfec8de08..16682248f963 100644
--- a/include/linux/tnum.h
+++ b/include/linux/tnum.h
@@ -134,4 +134,6 @@ static inline bool tnum_subreg_is_const(struct tnum a)
 /* Returns the smallest member of t larger than z */
 u64 tnum_step(struct tnum t, u64 z);
 
+u32 tnum_alignment(struct tnum a);
+
 #endif /* _LINUX_TNUM_H */
diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index ec9c310cf5d7..1f620facd1b7 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -317,3 +317,14 @@ u64 tnum_step(struct tnum t, u64 z)
 	inc = (filled + 1) & t.mask;
 	return t.value | inc;
 }
+
+/*
+ * Return the number of trailing bits known to be zero in a tnum.
+ * Return 64 for a tnum representing zero.
+ */
+u32 tnum_alignment(struct tnum a)
+{
+	u64 v = a.value | a.mask;
+
+	return v ? __ffs64(v) : 64;
+}

-- 
2.53.0
