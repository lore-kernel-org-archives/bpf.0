Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559975;
	b=cqH7fVOyu7DKRemBtWEwIiFZNi45bqz1/QiHo4h74m4Y5L9W0C6qzZC/clHBtKjeKYRn
	 wbwVkMcR0+ZTtdoBF/t6NvW20/wXalq5cqgOYMshIVMWko9ucKrtiAlW5mBeVmjrkjyDv
	 pfMaNCiGlKSUElT7r0AUbUdUoi9hCpQDH43L6SHpKPLd0fmyHaPsfNCFqSjqhZQEIBzu+
	 6scHCnXYZa7sUlc+74S3yCyT8A6Z6sRTyMbebP/c9NVRey0fFFR/TL4QlUGvKWdoQdF2P
	 cjOHRssbRykFdghTfMv9doLkbwG+xhRp7Ss2LA6vLrLvwjHyA93Gu75QpIBLlXngqFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559975;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0oloNdgdEUDNGLIKpNuIKcPdlbDJvtMjgAZ92YTAtiU=;
	b=wKyeNnOrnbGxWiw779DPMaCQ2weFOHJq3e0p/76JxNKmbNSqEYMvoksdoMe9LJ8lf+fY
	 JTkiehZeuCN8fB16vIdAsNs9bNzyfdod6+4Esvq2/NaFQwfJW1aBi8tsYGLmQ7YhCbsu0
	 rYqen+BmZrAsrwD/XMmrQE8cdlRSGl+ipD0aP5h2PEVvysGRe0gNGP299kPJjgAkJSc7U
	 oHjcVVKy+wcRIumUpx2k6V4xNiOjG5RkjIS+u3+CRuPFwP6EHJdYAzaM56OxxcyUkmwrA
	 Zny7J2rbjsoPnEBRDhBQSFjXF3J7xSSC3riegGnJ8Eufq6Afi21GxwSGqMDuIVBz97Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xwJPcrpe;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6A8606A331
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A6A8606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xwJPcrpe
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc147d86bebso1546697a12.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793559975; x=1794164775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0oloNdgdEUDNGLIKpNuIKcPdlbDJvtMjgAZ92YTAtiU=;
        b=xwJPcrpeAOyAZQOOS784j7Bg5cIvV7KCh00tVEbCkLb/0cOqjqoMWkFXFHsYR96xiz
         HPIgmrT/Ld6QYv0IX5AnYrmZqXwCQ7gog+MB3jbG1ndo2JJu3yLwk3WxVXsS0xG8OKlc
         hW8yvGDhgjo8/dFRzSXEcmgwPlr+zKSiQqUTOt+ZROfiqA121kA8et1eEkLogLy5MbNG
         DzdLcifWnnbIMTGfrOUJ/A09+FTXPiUC0bYz8A4O3o1DtF+02s2dewer+IkbXYNo1l/E
         NojmfkW58m+laWXCV+qmnoWAtV5s+Md0No6ZyWgtm79R2M2BK9klD6+XnegrrGOX4d+Z
         pa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793559975; x=1794164775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0oloNdgdEUDNGLIKpNuIKcPdlbDJvtMjgAZ92YTAtiU=;
        b=Lc8vs5IHpy5POHYZ7DhgGGIL3rCQF57vqXV1QzAd0tQUsAMH6bqPyevebfY5WlBHMF
         gKwLTv0j+UxkzIM4cpZW9V33mFD/+k1SaiMhO224anTxYrovTBEjmJYfl8G0Vz1RG/pt
         ZAoVsvc0yj2gdwiVNbpyiDCpa1ztfvEN+OHSnp0wS5cQpEmsqvQuFf4w8TQSMaBfQURu
         PECAsL6+5XBH9o1w7kPwdtHjJ0cJXyW+MCHqb5ZHgXQTvXEIa1lvScE/NLmeytz/S4OA
         NmFUd2gD62h2XKk2gtGx7HPU3A3HFCUKo9mkfpxo+19VFNCSMF/JRDlEzUFY2VzukXeQ
         JlPg==
X-Gm-Message-State: APuU4Z8OUdajSRrvChaBKgF6UMAebSN1w9TJ4pVkcYdsbW9tN3vINWL8
	x6sunVvPoIhy4u6qtOyglD92Xb+2OOlbVE7/tHJa8fsjTFziZ72Mq6u/xumSWQ==
X-Gm-Gg: AYBFou1P13odd/ZeiO7ihUFXeVz9gFBOF0h+Bsh9I4cjEMnT422Oo9Tz52NAWlm8CDJ
	4NAGcWdIj1P6tu2ArgF+NWAxdxubNnaCLhBnniHjgPw/gNJiVaaT4oGKYl1mMmuhRMCbMYqFXMi
	8KiIvmWkdI/rv1GKFupt5PvJs+KwLiu3p34WNtLEkcCei8tf9S8O62/r2VcApaV1Z9r1VxKZzDG
	FqdO0Cy+KecdYLW1nPvuF6bim6+7AwrIreZJPJGFDIxoqxxm96bp2UIkDA81A1q4mK02skM/fzF
	xLdjxwmxyBOJ8z8+qbcvHqaY9f4FTH5YIwbDiNThHVXcieuNg4WI2VrMLF5BYtFDNkTFhefMEn1
	pH5RHFjib1aHgSNcCLtckSOsDF28rCaMRAdNyuKwDNw+cPS5s11j6d2rf/2v4tLhS8RCoTB+d8d
	jgMcTXO53mfK2IDldXEspqve7ftjjsWAAjpspObDBEHjGzAMIHOFOnyOAOxhCL0MV6h1xBteRt6
	IKfgpLq3A7o1PFjIduAJX6DfDXJnlTRZKwReV8hyYJPgD+ypehqspv9YzJkLumehodXi8UUAuUg
	PyCZ7E11venkYQj1mGkMQ/JqXpfcCOr2hz85I/yrPDPtN4bqJxnXG4KuwmrH79CMZAZ5iwkW3d6
	dWbUbeSSf1Q94ZD0JQIWLZmczPI0JYVAfEwoVIaooGuFhpczYNEguGZa2R/YbkQyrc/OFcfH1XQ
	==
X-Received: by 2002:a17:90b:3a4c:b0:3a4:7195:ecba with SMTP id 98e67ed59e1d1-3ae8972d1d8mr3696947a91.20.1793559974596;
        Sun, 01 Nov 2026 11:06:14 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87f5dcc3sm6552905a91.3.2026.11.01.11.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:06:14 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 06/27] bpf: Remove the WARN from arena_get_unmapped_area()
Date: Sun,  1 Nov 2026 19:05:14 +0000
Message-ID: <20261101190535.1454146-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The user range of an arena must not cross a 4 GiB boundary. Thus
arena_get_unmapped_area() asks the mm for 2 * len bytes and rounds the
result up if necessary. If user_vm_start is not 0, addr must be equal to
it. A WARN_ON_ONCE() assumes that the mm returns addr. But addr is only a
hint without MAP_FIXED, and the mm can return a different range that
crosses a boundary. This is not a kernel bug.

Remove the WARN_ON_ONCE() and its -EFAULT. arena_map_mmap() already
compares vm_start with user_vm_start under arena->lock. If the rounded
result is user_vm_start, mmap() succeeds. If not, it returns -EBUSY.

Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/arena.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index c35b82f44f66..0b1ec3306ea4 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -655,9 +655,6 @@ static unsigned long arena_get_unmapped_area(struct file *filp, unsigned long ad
 		return -EINVAL;
 	if ((ret >> 32) == ((ret + len - 1) >> 32))
 		return ret;
-	if (WARN_ON_ONCE(arena->user_vm_start))
-		/* checks at map creation time should prevent this */
-		return -EFAULT;
 	return round_up(ret, SZ_4G);
 }
 
-- 
2.55.0

