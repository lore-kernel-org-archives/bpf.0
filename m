Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C748135A925
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786785514; cv=none; b=WaedYTVcK4OcEm6oPixozDMPvbLsBx3/6Zw/zXk2yjZgn3MuO9fDggq1BbfqXC/SHZYgT0Tr3TBBL4ouHNT+4aw8tkCW0gkJ5AmV/nVdoTSL/jVh8xPn+WV7IElknyvY+2nCgb3J6e7Ibgp9mFf2qgiQRpbLjFvpzCfS/B64Rpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786785514; c=relaxed/simple;
	bh=5Tk26TZlY4MOjCWHoxMOQGtJ853fDrZtjs1HhWW1xrs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a9uT6h1WC5rLqEOckGCsjYV2xy3BgS7kfYvDIGq8lOY0EFqXdxCVANBXWzRufnI8S3FeZucDY5kDDhKJspZn8SxKdGMtNbnFx5buZtIOH49YbWoxbaOc4eZBTTe4or8LsXGqctnfIsEEEzijfUgO98bHFQrGgDcXQUZqSNIqMrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeOxmG1Y; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeOxmG1Y"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so1504013b3a.1
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 02:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786785511; x=1787390311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LXZKFyuDLY2DRqrs+BqA4wglyce4j9tGUwHMwcrD9yQ=;
        b=eeOxmG1Yv5n2ziL/1dL99m3xVHhDpZZp1Nxf4AkmTCP9/1DufHLD31EQK93p7FkwOm
         6oi2RPOKGK/2RXZjBMk9TsfqXbxSBOugu8VMflKirsAJw13U9vLBSZnSznzc/HcLefJX
         G1TXx06IzC51h1p6J/dZ6HC+lynor7u0bOkoH/G39C23G40X3n8S5Y1mKCp5ypgXbxh/
         GPU9pEm2KlA8YdCvrBXFTTCwjdVzkz4Qexe2SIC3VNrY4RDEeIq02oys9KlKtqYos4iL
         6TH9wcr/fb1uE/lvMVuHCWaYdNOX5uak+wJG4EDvHACEtEuRKumZGUEAHk3iUYeQCa/+
         pUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786785511; x=1787390311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LXZKFyuDLY2DRqrs+BqA4wglyce4j9tGUwHMwcrD9yQ=;
        b=ixuCFZMXziwFRLJMrYyXnkOI6mSsqyBsCqqGI9jeNtG76wVLRqmvQ4bmZmGLUBxZsL
         dM/piXG/N1Od0OeZ8JKLKYthE02TVsGBpBQ8DOZryiEcoQprzuo1AFSb1Z2Xr2J3J3sW
         NfFLUf92/fffQ4ynYHAePdzE4fkuyhUt3NK/N41Rxh8An/VpvjgSLKiVDcF6h/+JFtaa
         ie8Tbg9g7q0RNJ75mw9eqF043Rm/MpacGYa4dDMgCcClIUkbT2HxpGrqSBAR1+RrpP7E
         TBBjnoYQS1bwkyKoMuZYdoIwU9+smY1x6gcXAcRdsD5kI56CFbAv+TbfihY4/rVHyxlV
         rf2Q==
X-Forwarded-Encrypted: i=1; AHgh+RquJT39LkwONMGBA7eUisv9/I+iz7o0CM1nQbOru9hRgThfQDk8MHsIEVSZbpz25LEteo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbTrizG1swOT3xUq2oLR4YcW+OphWo4ivMMK9RjNBO0ygk+KUO
	Y1uUAyUredEmxpzgSa/CwSCIGzwJyDdkpqJNvtWhRFHuwD6j6KZ/kkbq
X-Gm-Gg: AR+sD12B871vuegCHevxCg8sFFR7aHPqxcqBzp2Q3W5JzM0zMt4HnhIv6rgQRCKpF3z
	c6YtdLHPO44Z4aQDWi+xAcsA4W9Mn1xDcMrq5PCPkcwbSRZ4NzVoejt2ObukyTM8z+EJkXyb8hu
	LPmbbjAgzfcQTYPwtkSr6j0cy0W3gVUAcTd3hyJF2oad8KJ4E2VlhQM17jPEG/UGdKwgC/Q1jdJ
	YlgEE22GM0MXxEB2mYIvQBe9Rq/ETfzZKeMOBA7ZVMrfkN4K4fO6RGhZ7ri6P7rkaILfL3+R2v6
	5cAmFqtF241ywfI2XGfBtNbj+XQHjoAJyI98/BIAXtD81H/37twnW1tnVxk0AnyiaP+7nWcmPfg
	PV5DPr3B66QlAgKdK1tW+KiHTy5iJRLd806Q0pK2YGsxuA7C1bGoZVlKlJGMqKFQ6adbKeLKAHC
	+2KxEfVoYWMi5mnGE52S+QsV7uFk64xUVUwcTl3Ke15J1I4zj269x8xvBuopxDYGKCr4AS+5zcg
	WbdhJ19w2GInyFqG9znonZQnao2
X-Received: by 2002:a05:6a00:3d88:b0:851:8084:133a with SMTP id d2e1a72fcca58-8518084471emr6698912b3a.29.1786785510477;
        Sat, 15 Aug 2026 02:18:30 -0700 (PDT)
Received: from bj-kjy-standalone-gaoxiang17.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d223f1bsm1274934b3a.38.2026.08.15.02.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 02:18:28 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
X-Google-Original-From: Xiang Gao <gaoxiang17@xiaomi.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	yinchuang1@xiaomi.com,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Gao <gaoxiang17@xiaomi.com>
Subject: [RFC] bpf: account ring buffer backing pages separately from Lost RAM
Date: Sat, 15 Aug 2026 17:18:19 +0800
Message-Id: <20260815091819.3651099-1-gaoxiang17@xiaomi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I would like to discuss accounting BPF ring buffer backing pages in
system-wide memory reports.

BPF ring buffers allocate their data and metadata as order-0 pages directly
from the buddy allocator, and then map those pages with vmap().

Because vmap() maps caller-owned pages, these backing pages are not counted
by VmallocUsed. They are also not slab pages. As a result, most BPF ring
buffer memory is not represented by an existing named /proc/meminfo category
and appears as Lost RAM in Android memory reports.

We measured this on an Android 6.18 kernel.

Test case:

  32 BPF ring buffer maps
  16 MiB data area per map
  512 MiB total data area

Observed changes:

  Lost RAM:       approximately +529 MiB
  VmallocUsed:      approximately +2 MiB
  Slab:        approximately unchanged

After destroying all maps, the values returned close to baseline.

The question is whether the kernel should expose the unique physical backing
pages of live BPF ring buffers through a dedicated global counter and a
/proc/meminfo entry, for example:

  BpfRingbuf: <value in kB>

The proposed counter would include:

  * ring buffer data pages;
  * metadata pages;
  * consumer and producer position pages.

It would exclude:

  * the second virtual mapping of data pages;
  * the pages[] pointer array;
  * map metadata allocations;
  * vmap page tables.

The goal is to account for the currently unclassified direct backing pages.
Slab- and vmalloc-backed auxiliary allocations are already represented by
existing memory categories and should not be counted again.

A possible implementation is an NR_BPF_RINGBUF vmstat counter maintained by
the ring buffer allocation and free paths, with the aggregate exposed through
/proc/meminfo.

Questions:

1. Is a dedicated BPF ring buffer counter appropriate?
2. Should this be represented as an NR_* vmstat counter?
3. Is /proc/meminfo an acceptable interface for this information?
4. Is counting only unique physical backing pages the correct accounting unit?

Thanks,

Xiang Gao
