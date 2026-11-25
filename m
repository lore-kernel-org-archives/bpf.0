Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579705;
	b=nHObKU6K1BIT+CADdzwl7hYEDzbfdVqe45Og8cK8WQPdoTEZPWZQEsDvXqruO7BRa9xf
	 Wz8tCI8pDsoJxTJ1zi9w1QLPQ+Tu6OHZ1jXdktwzvoWwaJIN4QiGzv0D99AHPNJSPm7E+
	 FvKTo8Lj2IKAsccQloHsZwKcoEN4bm099m9PviD/tin4wBn1rh8KDWBHVkWucN2+4Zqyl
	 sXLZ64ck55tQ2eKUxkU1/6FhL1tPYRXdYndV+AIcKerP4A8zoFYgZGZFJ4wNJ/bZbRUQ7
	 T9iW7OzLY0JJzuPUav1/9s97FoLLi/2TxrYl3J5/XaF11PIX90R3dvlgqNgm2+kQi5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=90sSLq3PtHo4RwsoDWC5eUvenirGrx+VFVGpu53GEaM=;
	b=Gn5QhU8+l8l6WmBrWnE30wkrr0bIKTEbCbEiNgWtuNOaUyDUZaN3fWDR+O7N24dxnbiN
	 PNDLL4my017KLCzG6Mj2zDcBhC93lDqItE1SdnwSCX/gET3ScgUTs8ptgVY6kfC3yREkw
	 i58/YDryMytmlWIlqyO4Nx1LFKsqEmvkrREUHR5IrgCnbZVywJx1kr3OvRLrj5q8Wc/Zo
	 kmMwQZn/HneOQtf2CmVGRYkQWnaMB7CfiEVfn3//UKob7G7GiMDESzTyjCFjVCfq6wMOy
	 Upx8Jl9SR2qxx0IZx0HAX3kFIcCN7JqeA2M1+mR46oYWnH+OLtxNbVHaRv/znk0brjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hsr3ZJKB;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE065606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE065606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hsr3ZJKB
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2f04ad2c46dso31615945ad.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795579704; x=1796184504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=90sSLq3PtHo4RwsoDWC5eUvenirGrx+VFVGpu53GEaM=;
        b=Hsr3ZJKBg7EDqGdG3FN+7/dX34lcXhNoDazAhI5njAg8t+Mez1LKxeoR7xWn3rLOkn
         AN5T5Xo6XB848ADyZMd3cE4ov01ckFlVnfempAGxWmfAN6mRRrrkfBgXTl8/dPGUjIFo
         JPMKXYGe44N6pUVJ8yWy6IzL/diX0C0MplpuGGC4klKS44EcAQHhkSnTUwREfBCP49Zo
         XTQPOsJ7KDZWc49o+wrbOXgdeH3UZ/CC6pqv6j4FMrzlrXE/cPHFeL53yptKnnCkfZb/
         KGSk2Cl9WkweD9wMnKRfGSUXJwlzwvXlwzNFUlJKsFai9aqcolv07o2oKAnANNGaKCsQ
         zYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795579704; x=1796184504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=90sSLq3PtHo4RwsoDWC5eUvenirGrx+VFVGpu53GEaM=;
        b=AIpWP2HJ2RT4x4bBhe2C3UjvbhdpvJqJQ3tYlQnl+2jB5cQKHRrEJBDZ6fiuv6kaHL
         kvjkALjeD83CE2dI8votSi+KW93aHrUF8gyBVMirbJNk0vIbd/UKB5anUdpb9aVSo+gQ
         528CIyyIQdFsZQkrOYg7A+nM0TlrnaHklqy7c8guy6qfIozbMRyGqufwKrOpseamZ2wS
         UFdXFvPPKCfghvPxmsuNGbqM/CbT35JrPrzVqToCfpj450SjmFI2he24ziKK1Jrl1hlm
         RzyFOa5SDbBMcvfsyUKXSaDgVkiI6m2UCqWlCTsiu1IYnNpZCug6GuazyhlhtpjyrfKR
         dosQ==
X-Gm-Message-State: APuU4Z9u9GJBsJb3lkMfcle96okRvt8TC0vXc3vpJhJWNGqjjSR+8uUv
	gr11eOCuy9MOeBqalIKHfqhgZtY4sVTm1sKQuHgVXX/aJtcr7Lmmwlp8poMUYDt8
X-Gm-Gg: AZFdTZc97AHnXt0cwYKtghVn9+q9L2DKMIeJmdpQv06EzQ8YLDkBsRfBQvFTRyu//0+
	FwSzZxca8DbFPAbFhga5jEHqwjKJ+3SQbFmm2P3ImjKUQQEKBjW8EGG9nx+x7/bM5c+CDroDhAC
	n2fJ4dLtLAhOkWbmaIXDf1TRfIfu19H4U9PGRFUMm1Xuelt60gSKPu9wFf0l4Js/gWQ/ZV4v5eU
	/7Nqe/thANQu5jKnkXowOFBWP78jswL4knq1XzAlHXkK5N6N/QFxh+n/rUcbJENwTYfstyGD5+x
	VA3PgT+IZBk0eVymJkOYP8l5mWNIDCbPvCXlCNlL/NM7+wVeSXDv+Knhc7jOwtMGpX+orZ3NCyz
	UgbyYPAu1QW/TmYh86dN3UPZQ8ysrMCtKCALuhURK+rkn0a5ZAlxS6LEbpsgTa1gQiYj6L2FsxR
	RAQWFScazvyp5EKK6HGMmNFZ1NQo12EnFA2Qj/xN5Ofez16qNirs++HiOtJMOrwEQc0inOs6WlR
	BH7/RjWRTvjdcI//eHPWQKb91es8wofLhaNh/Q6o0mOBCnKb+ziR4b/9cFh+wDQfbyWveiWL77K
	GhKL5m3yF7q5zHcPsSM2P3ShbVBfjK5rGfnkuv9eJCNA973H+x6m9LcxCbbQ8bbtfPWG5sGqN+b
	1lvzoBAHc3R8apBfHpB9dzVovYUNex5AzMazaIgZxSGxzjYXFhTyLq8uFvof0InupWduCaUMRaA
	==
X-Received: by 2002:a17:902:e542:b0:2e9:6b5b:3db6 with SMTP id d9443c01a7336-2f03f1a4967mr172959075ad.30.1795579704257;
        Tue, 24 Nov 2026 20:08:24 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120769sm78420735ad.57.2026.11.24.20.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:08:23 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	luis.gerhorst@fau.de
Subject: [PATCH bpf 0/5] bpf: Fixes for speculation barriers and constant reads
Date: Wed, 25 Nov 2026 04:08:15 +0000
Message-ID: <20261125040820.947816-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

These patches fix bugs in the verifier:

  patch  area
  -----  ------------------------------------------------------------------
  1      insn aux data after a failed check on a speculative path
  2      spills of invalid registers
  3      unaligned reads of read-only maps
  4-5    the barrier after a store to the stack: atomics, calls

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (5):
  bpf: Undo insn aux changes of a failed speculative path
  bpf: Treat NOT_INIT as a pointer in __is_pointer_value()
  bpf: Use get_unaligned() in bpf_map_direct_read()
  bpf: Emit nospec after BPF_ATOMIC stores to the stack
  bpf: Do not end a speculative path at a call

 kernel/bpf/fixups.c   |  4 ++++
 kernel/bpf/verifier.c | 28 +++++++++++++++++-----------
 2 files changed, 21 insertions(+), 11 deletions(-)


base-commit: 81c6c8c608b6075846d3bd5b6f57958300a56eda
-- 
2.55.0

