Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10A5282F2C
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775629285; cv=none; b=dOyYL1Lul4lDQMVO45qAFy8z3eGf67/Zrdlzo7DYtxJqvOFnUkLV8AS0RvUGEJkboQidZH/BbulhDhFprCPs6FrAMXyzxcDM1btDEtY9xtLd6fSh2ueyeuMOz+9V8CoQFhscwmBd9oL5BayRFqcMZaSBN6sSUC75qiRaUdkfv04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775629285; c=relaxed/simple;
	bh=9czHdn3cQRCCZK2hq958VEPz7CMCsBt5sPas2u6WsZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EdWnr7laEcPHD0Aata6aWotB0HMAlaewucEyNDgxcwzeeefldxMSZDeqmh4BDhH3axHFKkesvB+zaCe9n8ei+9+BKbhigFv0ooqJprYmT3LEOsyFW3jNVSQTUd+5wemRikvXgRHoCUPqSjUvi+MWKLhlksXHarFnssdat1NQ0sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sy8LVyf6; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sy8LVyf6"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-82ce0a9b3f7so2487078b3a.0
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 23:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775629284; x=1776234084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XKKwPmDWX8cwG6H9VyOfMY/VvlpvKjpyHcnABmaPaUg=;
        b=Sy8LVyf68rTTaXkYxtx22RYvgHmV71g/Hff1znCb8qNzb6VsTMWdZRH/LREsqV3CWD
         tAQnG+P7vORe0PNrfn2whfphwgNRQkRAA0ayTGzWfjxn3oEPco7a3ToN8iTJL1rAYwu8
         ROTdWDInIlpib2wvtiaOLCB+OeJZxPZzpTjRU0TN3msmhiU4vkZkFW57qLqZQvaoZb48
         nVeqnp1p4IUpzNOqzuqDdM6AzIy6m2zXHmrdKxUPCvisJ9J45pDib25IsCFA+bbE9lMR
         i+vivPv+7nQFeadJxl+1V33i6RK1++j3QfVijMlCS6TobZpPZV/dorXynS3VCbWD7lnT
         mzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775629284; x=1776234084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKKwPmDWX8cwG6H9VyOfMY/VvlpvKjpyHcnABmaPaUg=;
        b=EjXjIk4gMCsEqj0JOCHw0EKiZ5W9N2/ndEECJxSLkZ864gqoF1DvLfp6E4zmf+IWe4
         X4JboaQ0dAFUgjMsd0NKlpDisqfsztwrTx8QzUgoMV7f+eRH3dTl0Or91XeG6wiQ7REy
         ypeDRV0nyJJVG08q1pKHUMXJjoIA/aRNT77AoLTQ/cgKjc2RLaPgDQ5y9qYDZwrRX/x3
         nM9OtTsdiMLQxmFUHTkEBzLBnwY6peQkXll/hoNdwRvcVkxmCUm5+HoohgjjO5CVvsQp
         sVLl1nWtqE3tnS5PWVCbChshdM38mA9fU6UHJklRr6+m7o/KHB5/y9vKgdwC9QvoxVdz
         XlJA==
X-Forwarded-Encrypted: i=1; AJvYcCUc4hhJ1z5cMMT9YV1zg5RyosusyS+PCISC9Yd8XeLWmq01Q7Z6HEkvor+mdpJ9jrN4wMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOsf/pgahxGsjRttcmObEHenKHvzg9Zxocd6DshtbZbgl+b0RX
	21uJC0Mm71KJdavdCoT0rkoFhaQH5mk59flrmX02K0m2jQQwyxGFM+KF
X-Gm-Gg: AeBDiesYXVd2dWm9QcEiptYfC1YWNU8AgK5ZTlRElQSpWCQmSrzWdZSS2EABJW544dz
	fAKg3Zl94Fa/u5fZx9IJTpjpiS3h+u5Rmm8Garh1Ro7FqfeEVZhYuPtLBqv4Siqq5vC35sJiXpn
	IL7K1VnA4h7JJH/RzRqnupwnoC4fGcb0sJPkPSr8U4H+qvIoIXGuLgtJN+DnoqWCpQmyGCIxH7l
	FxdD+/LsCW1h30sDgC97vbPQC8A/eXYar5ypb3E6ZH3t3vInkpyfRo03peaQ7/NQMziqEnoeN0T
	WGjlVerJZEwyP7UpK7lPq+YkjKmPmqjxvQ3ATuZAJEOt7zDkwZ+95jNwZRAUXOgrZBA4JPO694/
	hmglP2kX7ipuKDL5IOzxOsuhFaJLtQEecTfHYddKzEo9292VkCOYyvN0yrh6/+hmUjs6nWgV1NN
	upBZl/+EiL1Tb/osIEFjt+4CS5ROkkz04=
X-Received: by 2002:a05:6a00:450b:b0:823:786:1990 with SMTP id d2e1a72fcca58-82d0daa2136mr18833372b3a.21.1775629284173;
        Tue, 07 Apr 2026 23:21:24 -0700 (PDT)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b60199sm17827638b3a.25.2026.04.07.23.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 23:21:23 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	emil@etsalapatis.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 0/3] bpf: add the missing fsession
Date: Wed,  8 Apr 2026 14:21:06 +0800
Message-ID: <20260408062109.386083-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing fsession attach type to the BPF docs, verifier log and
bpftool.

Changes since v1:
- add a missing FSESSION in bpf_check_attach_target() in the 1st patch

Menglong Dong (3):
  bpf: add missing fsession to the verifier log
  docs/bpf: add missing fsession attach type to docs
  bpftool: add missing fsession to the usage and docs of bpftool

 Documentation/bpf/drgn.rst                          |  4 ++--
 Documentation/bpf/libbpf/program_types.rst          |  4 ++++
 kernel/bpf/verifier.c                               | 10 +++++-----
 tools/bpf/bpftool/Documentation/bpftool-prog.rst    |  2 +-
 tools/bpf/bpftool/bash-completion/bpftool           |  2 +-
 tools/bpf/bpftool/prog.c                            |  2 +-
 tools/testing/selftests/bpf/prog_tests/exceptions.c |  8 ++++----
 tools/testing/selftests/bpf/verifier/sleepable.c    |  2 +-
 8 files changed, 19 insertions(+), 15 deletions(-)

-- 
2.53.0

