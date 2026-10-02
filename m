Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D56263F5D
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938345; cv=none; b=C35mZnJGMk/2XTfFchHM5KYlolHwAcC4VxrRkJ67xVWNKZBk8wZMxZrsSnxsJscepGaChEdlIpsIn2OGSSa8tfEwHRSWtcLKvjRGvnd3TgwbqpqyQTsn0B44Iz0038rHT70ao1vu8019hjft2DlBHvsy3YsMxiEUXBNbFJhVzfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938345; c=relaxed/simple;
	bh=VwoTqiJFg7JfNGLJyuv9Ewv2I9BpJw2BnyFO1pvYE8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WCm5DdQqT55/Xcb1J3qxIFtIrwdC1Eor9PTBjolOOgpaNYai8ztNRD3ycsY3ImWwLwqtlI/LUYyJPmA0ebwVEAVpEfPGdF/bXDEtPu04tswSgx+vDcsslxVFyHn+w5Os6ukVoWPyXV6/PyUDGfRG7B1cADO3t/h5S0wv9cEfDM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=lNruUH73; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="lNruUH73"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49fe8bf173aso39956415e9.3
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 03:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790938341; x=1791543141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LTEXbF5n/0Qag8DcfLtuvuY85PsxhBvYYcocrE265A4=;
        b=lNruUH73iG+I9ltE7+t3j90CGhZo0AJyKAn8SXVVrMfjh7+fB2Z88PsU1uM5VZDfjq
         v1aXJWxAnB9kP5nnkNXKjul/wy5dOEbg0mBBGxKs7FFGzff3uyItOG06Lak930phoHV/
         in3CLxu0WMsKaWuTdLMQUSGXqbFZACyKheS7xtt6z6zhwHyGThTSFAzlp/1wXa/81wJ3
         XwjdOu8+AgdqglNnFM+w2cPOwq9usR42bqZT6QVWZepYBxRshmUTitcK0W/VXvWjzKYO
         aCQsbxcwUbaUC+ZqWdaGz4xMIDyz1ywB3tZRuqWBVY9uM53ttOLkkkvCzKWEoLwE/4X1
         uuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790938341; x=1791543141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LTEXbF5n/0Qag8DcfLtuvuY85PsxhBvYYcocrE265A4=;
        b=24YAbO8zh+025x/k0+dzDv655eWamBQVVYAUq/er2f58XG5Hw73HgMBBlCL5HxPVTo
         MyrTAHSmYMSrTEEb89m4oSjrXTa5GC6AgA4bsevQx+eZB8f6cxdVBM27UmV59Nxw+Xbs
         y44PVCpFcd1wjNqpM/OqqlMC9zl9P3iLH0IodCt8izvYe8QrL2EVpsgjzxS5H2S7tJ54
         0mWmZ2LAvlBdTNkaGUi3VmiY9aTo2YW/2mlWihIxbVMNCeVMGryqFZK7QKwJx/SvEn0N
         mqOWICaKowZ0q9Bl8OFVKbqaWmY8sLVGNGl7wlH5pRUrBTZ8oOqX0FJwPnKVb/PzF//h
         q4NQ==
X-Gm-Message-State: AFuF++ki1Jg8pKaJIMcxZtsBfad7FLLY9uAGpcOW//xOs5U1jxyO2J0s
	BZGV5kayHg5gitoFF62TW452l5Jv29sPBOcagepOV47qTSB33KOG9KT96or9KVi4gIYXVVd7PmY
	PNhP8YeI=
X-Gm-Gg: AYBFou3l3pW6XiQ16eM89JxSTKLBtBuoOIu/CPCA59kD4xqw6iGL6xra6iJ3Q/I+L/m
	sxuA7fEFyNYAYVndA6WU6/4bUeKqsxo3n1pviw+KZWXCEc2ctHrtfUvUY4wujAE37GIiGq/3Nnr
	mFssoFoskx4V85GobRhhb9VACnjNPpyhgbS2CeRZTGBVvtwuKRxAoXH+JaS2yRHFnGf+y1RRp9a
	dwi8EvSUlumcP0nAikkAOlx2iN0vsnyzPVh+Kcin9SKuHf0vDaKoRl+Tyyu418yB/uAn6XOiGL4
	FNNyEih3b9VVFdjUS1viIwnN+Mwf5WrmDsA8Fy4haMgUa4TIB/CtQXKuknuXt9rtHBTWtoo2jlb
	0EiTVP8xttzfWsxiSLpuAqmTyElK86Y4qhF2OnWajYc37pu4CDLQ3vdPP77ROg8RzNzw3PwaeK5
	DXRxLCAy2rykCYVhArMcdmavkW2KW7YUnh2w5gGIw8ncgd1+HTG1WynyiDehA=
X-Received: by 2002:a05:600c:c084:b0:4a0:2835:6fd3 with SMTP id 5b1f17b1804b1-4a028357000mr28660245e9.17.1790938341190;
        Fri, 02 Oct 2026 03:52:21 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c092:600::1:5543])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027da120bsm77866625e9.0.2026.10.02.03.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:52:20 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [RESEND PATCH bpf-next v6 0/7] Make sleepable arena paths use sleepable alloc_pages
Date: Fri,  2 Oct 2026 10:52:11 +0000
Message-ID: <20261002105218.6171-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arena_alloc_pages() call takes a sleepable argument based on whether
its caller is a sleepable BPF function. This flag, along with the context
the kfunc is called in, decides whether the call will try to fulfill the
allocation using the regular or the _nolock variant of the alloc_pages
API, by means of bpf_map_alloc_pages().

However, the arena_alloc_pages() call currently only makes allocations
inside an IRQ-disabled critical section. This forces all allocations to
use the _nolock() API, which may eagerly fail where the regular variant
would eventually succeed. There have been reports of this happening for
sched-ext schedulers.

Restructure arena_alloc_pages() to use the _nolock() page allocation API
only when necessary. This requires moving allocations outside of the 
spinlock critical section for sleepable calls, which in turn requires
slightly different logic in the allocation path. Replace the page list
allocation with logic that reuses pcp_llist to chain allocated pages
together, allowing us to merge the code paths for both sleepable and
nonsleepable arena allocations.

Also fix kfunc specialization to not unnecessarily force the nonsleepable version
of bpf_arena_alloc_pages() for call sites that do not need it. This requires
making specialization per-call site instead of overwriting the descriptor
during fixups. 

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

v1 -> v2 (https://lore.kernel.org/bpf/20260824082530.47553-1-emil@etsalapatis.com/)

- Keep the sleepable and non-sleepable allocation paths within
  arena_alloc_pages (Alexei)
- Incorporate bot feedback on selftests (bot-ci)

v2 -> v3 (https://lore.kernel.org/bpf/20260923191125.5311-1-emil@etsalapatis.com/)

- Remove the intermediate page array allocation in bpf_arena_alloc_pages() and
  use the pcp_llist pointer instead (Alexei)
- Fix function specialization to only specialize to the nonsleepable version
  when necessary

v3 -> v4 (https://lore.kernel.org/bpf/20260925203939.4105-1-emil@etsalapatis.com/)

- Remove in-flight pages tracking (Alexei)
- Remove stale split sleepable/nonsleepable error handling (Alexei)

v4 -> v5 (https://lore.kernel.org/bpf/20260925233538.5708-1-emil@etsalapatis.com/)

- Remove unnecessary imm-based sorting for kfunc desc table (Alexei)
- Skip all nonspecialized kfunc descs during the linear scan done by
  function specialization

v5 -> v6 (https://lore.kernel.org/bpf/20260928202643.9114-1-emil@etsalapatis.com/)

- Use verifier_bug() for diagnostics (bot)

Emil Tsalapatis (7):
  bpf: Use an llist for page allocations
  bpf: Add sleepable argument to bpf_alloc_pages()
  bpf: Add sleepable arena page allocation path
  selftests/bpf: Test large allocations for both sleepable/nonsleepable
    arena users
  bpf: Directly store kfunc desc index in instruction off field
  bpf: Support per-call-site kfunc specialization
  selftests/bpf: Test per-call site function specialization

 include/linux/bpf.h                           |  10 +-
 include/linux/bpf_verifier.h                  |  15 +-
 kernel/bpf/arena.c                            | 158 +++++++++---------
 kernel/bpf/fixups.c                           |  70 +-------
 kernel/bpf/syscall.c                          |  43 +++--
 kernel/bpf/verifier.c                         | 107 +++++++++++-
 .../selftests/bpf/prog_tests/file_reader.c    |  15 ++
 .../testing/selftests/bpf/progs/file_reader.c | 129 ++++++++++++++
 .../bpf/progs/verifier_arena_large.c          |  64 +++++--
 9 files changed, 423 insertions(+), 188 deletions(-)

-- 
2.52.0

