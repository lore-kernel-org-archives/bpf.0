Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793152312;
	b=CeeB4i6ZMpw5OthoaYrLcekphu57FLJNUFD5+57tdnKhrKbLXXnaH51pd8DzQs+njrLq
	 ibS6lEIlJuvGTYoG/GL+L2mUBrOi9fTisDHoA1VB54Q0GzabJHgLzzBj664hNkpfXLxNa
	 lV+aaSq+MZgnwj+bI8cMT1lJq9puWkxDuhpKs5SLHYFanLJfmGLuMXdVMgbjDnAFyePv9
	 ywDiuCf8qrxEDNupThK9TAk+D0fX3gUkmZkxOojOEgUXjIck7QT8rGYayq7oerqd4MYh3
	 gy7Jm4/rCULlG03zaSEFrpqxxEFGSSVkMAP1f4iLJDgLYand72u+EHNcoq87mR2w4hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793152312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=XQQPYNXf0tNMrdObyhpHrjQkGiBSAD/f73ezD2RZGcA=;
	b=aAS58jGnacOcBpLsmkoPPbS9UOILuc7eTIxKF8K9RsBJ6kQIh2rovq5HROBvrKBg6UF0
	 bpffDJ172pSuTcYnGuqza+Q86os7daPq2AUbworqqt82bT1P1zqsCHRZwq/g8gvmexFNA
	 RjEnPh4tAhCrBItqtx/NhlBxV0ExtEf7WlWICoGhYNYQO6pKdnI2h9XAA2Cu0Ro47l2fU
	 XBaBliu9AIUcZ25GVj2FSUAkBBL554UxMKlaCXu/DnN+qlmvlMr5qXavU8DyXBJD7DJJU
	 nQNu1wPYJXf82cTyQiZL4S7JN5XEASGTy9Y/vkT8XYbb/D755MOgjqjnWOWjH6bWDKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=gme+16Lv;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5481E606A31D
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 01:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5481E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=gme+16Lv
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso326453f8f.2
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793152309; x=1793757109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XQQPYNXf0tNMrdObyhpHrjQkGiBSAD/f73ezD2RZGcA=;
        b=gme+16LvI9TTyKyOgiWAta8gJhjnXstWR5tYpGDlDKeGJsO3trl1HIHAvafKBR4smJ
         x/o1eIBiSD4z6pN14WMircz86Mu/+2nds1JRJWMAqeaNdEU4Fl+qpTPM/jNLaNPXAlhQ
         5tPtnD2RU6WmXqlfNEzb+aHg1fbaeBxqQNvmmoDoVQN6yf4+fN6JGBY9umUfj9DlEeFc
         4Ai0VvVoi/e3kt0fYRMCm6S+Wdxqak6SdoiqgQKXb0i/gweznKRN8xkf5HkgfSucu+U1
         4hOLtusGAt+omqvV7Phxlqo7eGdL5MC0KwyBO426+PGAjK4z2oARtRatvKSl+Gf6sKWP
         oS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793152309; x=1793757109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XQQPYNXf0tNMrdObyhpHrjQkGiBSAD/f73ezD2RZGcA=;
        b=WASVzJhEdYyLS+GU6LJnw6H8IUidlsjJNOmJvoZUydSNfYxRPoeXiFufomiQ36OHae
         JebbyTmF+4tbaiVXcpQi6qG5c+zepQKrYZYGDoU5TuvItruu6XTgtYoaH7poHIGS2uw7
         tU2JxRGIWT+AtyU5Z89S7pYRLJ4IrqzTlVggpNYMfLqI8wTxRf8LYvgxmAocAKCqiG0p
         ZremOPsviuw9NIKfsKfs+iyUK6fz8z2XhxuYaKEj+hfZQ8ISoDr55f8Ppy0L52/bS0DD
         wWxd1orRprHEs4aHUNZYe4HL79jr9mO2u7/7p6XJS34IxU3043wb+AeCnJpRyTlgPzmm
         wGlQ==
X-Gm-Message-State: AFq9FYK5WLZ7/NhFv7aQpu2Z7/ptlF3cgFDW20ko5FYx3dgUsEEPOjhs
	EorSOy5Jwxyo/gWkiM4npa1rXNTuZU9IiVpEoikolkyfYK7Hkuo0a08UgR+V+XoDWolTwrs9BK5
	ADy2rmA4Ijw==
X-Gm-Gg: AYBFou2+LczNfIsf58oxtK4ND9o2REoA0BCGhj8wXAIXzK8a3oWWjjkAJHRG85ITiBu
	NRsHMwZt7M6SmwT5cgHexbxuxbTThnuwQktrNAowBtRhab5YJ7NEqQkvwIAUrV6J0KVg/PH7BC9
	VIJDntlsxhz+hmKIBQgBqoeNFtvINY22SR5YhXNkeGKZ6J9EZdlBsCPFtaqroPr6l0txu+q3nOT
	G6ck5fDDt+BcP3WpNv1TUmPNAmgQd1Omm23bxO01vPuj1ng0/LN35RgLRl40/xSUUqJkNGczJxI
	9OBBnKpB1MnmPIdi+S6n8Trl4HCsDeLRMSTzbPBHvexSfxeM4e9RTlfXejKy+QAJC+tLT1HEMxO
	4cPnX8UbL/hAyZP7sT6DHQ/7HJwVqI3OoC2Rcnu7LhDVWJx+X2E4oVwpDAXIwyw0RxpxUTcKK9o
	RJk83Rucii74Hm66F3P9RFxig0wMOvrGl3jKZLYEzMl/JiU0/G7QRmVcGLPAjQV7LFxIbE1gZ2m
	aKJjpIV9ZQpeV5K6RgTVZA30xusm3NGKjFX7kzqJSDS8iVQCSDPno76iEM2pmxd3dG/HWV5Zmpd
	F8q1GyC8oeAsZkpiUw==
X-Received: by 2002:a05:6000:240b:b0:48d:f996:1814 with SMTP id ffacd0b85a97d-48e5d31aa6dmr2745481f8f.57.1793152309441;
        Tue, 27 Oct 2026 18:51:49 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c090:600::1:8dfd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb9cesm26852693f8f.27.2026.10.27.18.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 18:51:48 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 0/2] bpf: expand BPF arena kernel fault handling
Date: Wed, 28 Oct 2026 01:51:39 +0000
Message-ID: <20261028015141.10710-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
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

Currently, the BPF arena fault handler protects against
a misbehaving BPF program passing an arena pointer to a
kfunc then unmapping the backing pages, causing a kernel
fault. However, it does not handle errors where the now
unmapped arena address is instead accessed by a non-BPF
path, or by a BPF program that has a different arena.
The former case is already possible in sched-ext if a
BPF program removes from the arena pages allocated
from the genpool allocator.

Keep a list of all arenas in the system and attempt to match
the kernel fault to all of them. If the fault does fall in
an arena, handle it with the already established scratch
page technique and retry the access.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (2):
  bpf: recover page faults across all arenas
  selftests/bpf: add arena fault recovery tests

 kernel/bpf/arena.c                            | 54 +++++++----
 tools/testing/selftests/bpf/Makefile          |  2 +-
 .../selftests/bpf/prog_tests/arena_fault.c    | 91 +++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_fault.c | 55 +++++++++++
 .../selftests/bpf/progs/arena_fault_noarena.c | 17 ++++
 .../testing/selftests/bpf/test_kmods/Makefile |  2 +-
 .../bpf/test_kmods/bpf_test_arena_fault.c     | 55 +++++++++++
 .../bpf/test_kmods/bpf_test_arena_fault.h     | 10 ++
 8 files changed, 265 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_fault.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_fault.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_fault_noarena.c
 create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_test_arena_fault.c
 create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_test_arena_fault.h

-- 
2.54.0

