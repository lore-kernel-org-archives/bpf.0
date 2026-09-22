Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64C54E0204
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 07:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061573; cv=none; b=ZLsSCrdCRgf1aRk43fEDWUMU2Q6/5xGI/H/ruEmfp6rVZuw3nmmiYDFdNzVNo53coJcernAHCJJSqAJJCeKfHn22jMWa6x5L22p1ejQhhMkPlIjWvLOTO7i859OySO/ri2G7YdMFC8X7bD9p1nUd7UvK18EzbR5Jj7js+qE15+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061573; c=relaxed/simple;
	bh=ZE36flv7SFeQIO1srGg32Hj1xq5Go4DOxA5spijMqaw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gia0R8x0gELRZZGKRv/rCVHT7Tz949UkuI4ggKLiYNMosnpxjq7j4GRWQ22z3el36tnECOtuoewNWjMZtJM6z/3+ENQRlyuhudF+KsR0GzD1QpNcgoDN+DN3ja0wFlSq7D5X7t+zazEkyGXYA1Yj2We2R0L3VXTSpK0FkXHKofs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZNQIfuB; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZNQIfuB"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-8138dddb94bso1178481a34.2
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 00:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790061564; x=1790666364; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=haBT2kz37KwwcQLhGvbsljIjmz1ApnxFVrULbtyy47o=;
        b=nZNQIfuB1TniSg+FMthyXtbyByUkDonnC97vIHwLen+PGXU1/z7Z1TIXaDqN5svjtt
         39rUCRHn+S5eJ6yEAQJsASanDyvhnUwHeG0g98ydcQ1pFkeH0NZjfzN0fn/JsuyVC/eU
         KAHCjmkaT/SWVGifKoN1IvIomYmZ4jRm4WvoZGzD11l7mIazrkRrzv1X9DOqInCs8X1o
         igBQzooiicJy/u7Wik000qp6VGPLEPGa2pese1rFhPe8bBN6Gv02VaeKi+CyTeQnkPxd
         pQsC8dPJJ+RAo14M4pv42TKswEai2OiOj+lMLMDbMEhJQFf3+lABnioTi+ZPlU7mfTNC
         bsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790061564; x=1790666364;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=haBT2kz37KwwcQLhGvbsljIjmz1ApnxFVrULbtyy47o=;
        b=QzGdAD+9sjEgLD2BiwH6l8a0G8Mp9AWZReNXnwOMmR2q497z/E63F6ps70wQ9rDqHl
         MlTP6Z7F2d419POQAA5RNWEDhuSZ4anc0ClCW5N+RHxnJerdccWIXeW/gckJaqTprj1m
         nKxdwFpmNeTNuj4/S/0y/hdd2KosCYnL5kdXywuy03VQWftmSf/cXC43kVDpaeqnWua9
         OS8I9Q2Q4SuSuf4gCJME3lUVhncPAMQoZf50D/1WXVV110UmPU7XdyHIedJ6JI9kQoPk
         TggAOgJ87dCRQnPO2z3lmybOte9NWW/WlvHLR8fanatw6xi8g9SGJhRm3WZZKOO30Exc
         I0BQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPR6DVgcQBRnGmZXeKb1LaHu80R9Z9EkfJ1B1jCv5DnPzadxxguJfsmsamhf4xv7hNo0w=@vger.kernel.org
X-Gm-Message-State: AFuF++ltb2OLxj8B+IDYQB0JfIVYlgAuLHbAujWv6ZwFNpH1CZY2JWt2
	faXIpp4GNluGbkQzC5eYtO3QSV23wKC3KebC4TfEcHqteJ1FSUIBFe+q
X-Gm-Gg: AYBFou30qs6B3CU70ts5LcJBj9HfbMTN74jV5j4dEXBEfBP/1CeFYNFRc+DMmOaNV4F
	a5xVg53WcpUyrgBK3wBoacoZr+oLky4Q9OfhBhxvu7dKhQA+bcKzmGZ2Eic2ZXP93DAwpGRiMxH
	miSvkEL+wMuZPeKrY+I/HAZ82n0YkxiW7UyqgBRP0xpCWwaICipU5Bf6QBoKMK7rk+YdXTbGPK/
	qNYfVP8GQWPjhL2klBsMw6m+q8YrPkbWP4+zTWrzCZ13wWWK4olWbPck0lPaZX330r1+CeaMpnn
	aQ5OXu5/j+hu+BHxx7Oko5+R8ywimuWxKsEoVnGt3pWVpds6+eyD5iONe2kIIkmumJPqKxoXC7d
	hNHhi727BgXydp5ihum69tjSjwxgldixmK/7pIKiEo8V4FerpS8o6/P/qCEHr6VJEfuBH+SanUo
	Q8LnDpFY7NuoiQXSc8ef4K721+YAhkGPwI0K6EofbbXTCBVvL+lNUagtt/xKOdazHh1oERmcklc
	+3MDGr5VCNcPewViEDIFbmjjiy93u+c+zfceWEldI2LjB1UxtWHwT4aeTTWitSYnn+esIS0InAj
	e2cgWdoDm0sC+zGWKE4HpiqxAqa1mw==
X-Received: by 2002:a05:6830:6f84:b0:80c:d30f:978 with SMTP id 46e09a7af769-80de28e7c36mr13815606a34.25.1790061564103;
        Tue, 22 Sep 2026 00:19:24 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-814e598483esm1116801a34.5.2026.09.22.00.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 00:19:22 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 0/3] kallsyms: Accelerate symbol name lookups by ~19x
Date: Tue, 22 Sep 2026 01:19:18 -0600
Message-Id: <20260922-ksyms-tune-v2-0-a333ee31eac7@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23Myw6CMBCF4Vchs7amHbyAK9/DsJi0I0wUMB1sJ
 IR3t7J2+Z/kfAsoR2GFS7FA5CQq45ADdwX4joaWjYTcgBZPtna1eejcq5neAxtGpAOGikpHkA+
 vyHf5bNityd2JTmOcNzu53/qXSc5YE6qjr8+BHJV4bXuS596PPTTrun4BmVuIbKQAAAA=
X-Change-ID: 20260919-ksyms-tune-e22a42d8a31a
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Kees Cook <kees@kernel.org>, 
 David Laight <david.laight.linux@gmail.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790061561; l=4502;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ZE36flv7SFeQIO1srGg32Hj1xq5Go4DOxA5spijMqaw=;
 b=z0B0CmkdCcUyTfdhUlDbtL7NSh55eEFCIj+LI90IlpRRZvu76jz8rReKTDKhHaR4PWIMier1h
 COv4UKheabmCMfIvh84KfGNxcjEmqElLrwMDiPlNzPwa4YEYTpUb0Hk
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

kallsyms_lookup_names() resolves symbol names to addresses using a
17-step binary search over kallsyms_names[] (~184k symbols on x86_64).
At each step of the search, two bottlenecks compound to create
substantial lookup latency:

0. Marker scanning: get_symbol_offset() scans sequentially from the
   nearest 256-symbol marker, decoding an average of ~128 ULEB128 record
   headers per probe (~2,176 header decodes per lookup).

1. Redundant string expansion: kallsyms_expand_symbol() decompresses
   the entire candidate symbol into a 512-byte stack buffer (namebuf)
   before calling strcmp(), even though ~94% of binary search probes
   mismatch on the first 1-2 characters.

Together, these bottlenecks impose a ~3.8 us latency penalty per hit and
~3.6 us per miss.

This 3-patch series eliminates both overheads while keeping the
symbol table strictly in sequential address order and adding 0 bytes to
.rodata:

0. Patch 1 adds lib/test_kallsyms_perf.ko, a microbenchmark module to
   measure unindexed vs dynamic indexed name searches, address
   resolution, and table iteration latency, with built-in correctness
   validation and a sysfs trigger.

1. Patch 2 introduces a dynamic u32 lookup index bracketed by
   kallsyms_lookup_batch_start() and kallsyms_lookup_batch_end().
   It allocates ~736 KiB in transient RAM via kvmalloc_array() only
   while bulk workloads (BPF attach, module loading) run, resolves
   each probe in O(1) with 0 hops, and leaves .rodata bloat at exactly
   0 bytes while retaining kallsyms_markers[] as fallback.

2. Patch 3 introduces kallsyms_strcmp_symbol() to compare ASCII queries
   against compressed tokens incrementally on the fly, bailing out on
   the first mismatched character without expanding subsequent tokens.
   This drops the 512-byte namebuf buffer from the kernel stack.

Live Microbenchmark Results (via test_kallsyms_perf, 100k iters):

Metric                    Baseline      Patched       Speedup
-----------------------------------------------------------------
Name Search Hit           3,811 ns      246 ns        15.5x
Name Search Miss          3,625 ns      196 ns        18.5x
sprint_symbol               412 ns      412 ns        parity
sprint_symbol_no_offset     300 ns      300 ns        parity
Table Full Walk           13,626 us   13,626 us       parity

Address-to-name resolution (sprint_symbol) and sequential table walks
(/proc/kallsyms) remain completely unaffected, maintaining full L1/L2
hardware prefetching.

Memory footprint: +0 KiB .rodata added to kernel image.  Transient RAM
is ~736 KiB (184k * 4 bytes) allocated only during active batch
lookup sessions.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Changes in v2:
- Replaced static build-time 3-byte offset table with a dynamic u32
  index bracketed by kallsyms_lookup_batch_start() and
  kallsyms_lookup_batch_end().
- Dropped .rodata image footprint addition from +573 KiB to 0 KiB,
  addressing Kees Cook's memory footprint objection.
- Native u32 loads in transient RAM eliminate 24-bit big-endian shifts
  and unaligned loads, addressing David Laight's endianness critique.
- Direct O(1) table indexing provides 0 hops for all symbol lookups
  without remainder logic or odd/even branching.
- Restored scripts/kallsyms.c and kernel/kallsyms_internal.h to pristine
  state, leaving legacy kallsyms_markers[] as safety fallback.
- Rebased out Lorenzo Stoakes' kbuild series; this series is now
  completely decoupled and applies cleanly directly onto mainline.
- Updated test_kallsyms_perf to benchmark unindexed marker scans and
  dynamic index side by side in a single run.
- Link to v1: https://lore.kernel.org/r/20260919-ksyms-tune-v1-0-d85c97da1a32@gmail.com

---
Jim Cromie (3):
      kallsyms: Add test_kallsyms_perf module to benchmark lookup latency
      kallsyms: Add dynamic lookup index for batch resolution
      kallsyms: Match compressed tokens on the fly during binary search

 include/linux/kallsyms.h |  13 +++
 kernel/kallsyms.c        | 210 ++++++++++++++++++++++++++++--------
 lib/Kconfig.debug        |  10 ++
 lib/Makefile             |   1 +
 lib/test_kallsyms_perf.c | 269 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 457 insertions(+), 46 deletions(-)
---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260919-ksyms-tune-e22a42d8a31a

Best regards,
-- 
Jim Cromie <jim.cromie@gmail.com>

