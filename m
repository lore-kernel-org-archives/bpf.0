Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A970397E6D
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776117496; cv=none; b=P4RqBy6WuqiAbTAzgDeYbrgUKtyvjDbhGSWIaoAYicOfXTcIqOjnN4+VQXehQDkMaRKyDIKB8KxMsXCp1r5G06C1zzc9iYzJg23/AsG8Ys8YaaG6NgutHGHYUy0CXNLQ9Jaf1AtjTpsApB5NlgYXwjiIew+RjtXlfUHhWnjE5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776117496; c=relaxed/simple;
	bh=HBEpbmaXajMmSZg+cRzS+fJgcH8jRxgJ4wfmixOhX2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WD7l9LmK+zGX8iXHDO5XnuETYhrijA908JL68n6E2qiYoGNFqXMhZMZpYdUmzVLmAAPN1ib5Qyc/ecWb3VXad643KmUvUa6Lc6/bQ1A3BqdFBe2bCgtpcTeaMnrRCAl4QbHZQj3K6MdYWmkWR7NhehsR1+vqktwpyg6BzD/+z80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBliW7zZ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBliW7zZ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ab077e3f32so23557785ad.3
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 14:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776117495; x=1776722295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zx0VEapc5C/N0ye6UT1dly+jri9VmTd2BNnEus4A0pA=;
        b=CBliW7zZJbPxvpnfsCh+6Be9te+cM+ETz+cT5Zi1A327M87DOEKt/DIpyTQOo41V89
         d54zYtYgPi4i+cXIM/iAp43l+ofN8J/k3jJ4LQwSAGE9tP0OUeEHDQjasr4RUIGI8XgX
         OUOaEh5Lyk+rHcmOAahE5clj92jZELcgVwt1xsC5Yl4JjeOHE3L943aDWW8LVaMiDJRK
         qCVkBnkQtC4IIqkSonWHkccJ9+gtDvKVVl8xH7njUa3tK6bQw/0aqEEkfnrCtfGaulaY
         veDpjavOVYccxYJxJV8vnWe5R6lYCH28pei4ZcIUp31NRqiZpcK2CjphhZF/TrKpMGkm
         rcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776117495; x=1776722295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zx0VEapc5C/N0ye6UT1dly+jri9VmTd2BNnEus4A0pA=;
        b=iZ0vlqrkWZgYkAdLiBKC68E/7KHe55++8hihQga+8gM4P7UtYIfsdZKoMno7kw7l3d
         qIzYpE2kCbPdK2Q7GwZyCOIBQ6IQAQ1T4X3fu9+Lnb0G7MlRGBcIXEDZRkqaMReYAxej
         xFKRE7k3ZKIDqX5r4keaXG5G/MQ3UmzNMMCQhjxrKy/r30Q2rztm0BETS2wrEA1CZC5t
         sxmB16R0e9zYZdbJfgFoN92XNLUN2dKBT4N7QewChQB89o+CQBEdEaIFvfzJMkcbaDUR
         96dNjaxRoSHQ5wEqeq8fWLaK8PNwq0Jsw/DzVi+WgCQtSDthPhWlMVT1t5ENotO8muuQ
         iSNQ==
X-Gm-Message-State: AOJu0YyIWWl0PMsshoIxSutNTMSPXl1b1X6JTB4ZCz4Cyz/kudIj+bYP
	3Gbq9V5WEOWj4LIok4FuzIyWf0yfHHTQE+Jj1ILRNEzGm12Bca3LeugIuNjPGw==
X-Gm-Gg: AeBDies0um/zFW7JuO2cIWVMmk6FtjHYwWPrBXce5LR3xDjUGFghCpggUJQ6bs29MmB
	UarC9JZvpqUJJZPSJ9/EmsV7OT7iQy6HYBIKrR0dB/b3pn0JbOF/9JfRRJafNC/BjDjcAMT0rQD
	ZOE7MzsgI24r9yuVxnaNhSD+Oo+ZHBIeZG9Stn7uABxH19/1SZE5MOA/WrTeikOrCxeSuIyCW1h
	gUwKXf5AfMeUP1J2ht7JWkO+mQC/1NA+NEPJwJyf6uBUtngWkIK2knXaqL87TaJLwp4of+y0qRF
	6kQSmT0OTCT32wftRvmaIqg/CcNk/8ACzV2W5KbzNtzN3wRJpLc4iTrbcla4nP5DwWncZId7B9l
	CyEf8U2df2p5cv+IAoN6tAiWoB7HNk0xZhHeX1K/kBzaaVMgH06lRaudVij+Ucp45dXaWZBAdZt
	HqBGLgWHsirdDCpsEnmfLI0w9ydA1Ey8aL/MwOnDRX3JJt6fITdODUoiVIUwBJcEgkh+8=
X-Received: by 2002:a17:903:124c:b0:2b2:ec31:25be with SMTP id d9443c01a7336-2b2ec312900mr72277855ad.24.1776117494523;
        Mon, 13 Apr 2026 14:58:14 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45d1ab540sm62421215ad.40.2026.04.13.14.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 14:58:13 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v2 0/2] bpf: arg tracking for imprecise/multi-offset BPF_ST/STX
Date: Mon, 13 Apr 2026 14:58:01 -0700
Message-ID: <20260413-stacklive-fixes-v2-0-ff91c4f8d273@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260413-stacklive-fixes-42e258cf0397
Content-Transfer-Encoding: 8bit

When the static arg tracking analysis encounters a store through a
pointer with imprecise or multi-offset destination, it must use weak
updates (join) instead of strong updates (overwrite) for the affected
at_stack slots. At runtime only one slot is actually written; the
others retain their old values.

Two cases are addressed:
- BPF_STX, handled by spill_to_stack(). It was gated on
  `dst_is_local_fp = (frame == depth)`, which missed ARG_IMPRECISE
  pointers entirely.
- BPF_ST, handled by clear_stack_for_all_offs(). It delegates to
  clear_overlapping_stack_slots() which unconditionally set
  `at_stack[i] = none`. Change to `at_stack[i] = join(old, none)`
  when multiple candidate slots exist (cnt != 1), so that untouched
  slots preserve their tracked values.

No veristat diff compared to current master when tested on selftests,
sched_ext, cilium and a set of Meta internal programs.

This addresses issues reported by sashiko for patch #7 in [1].

[1] https://sashiko.dev/#/patchset/20260410-patch-set-v4-0-5d4eecb343db%40gmail.com

Changelog:
v1 -> v2:
- Delete the OFF_IMPRECISE constant, always rely on
  arg_track->cnt == 0 as a marker the offset is imprecise.
  (Alexei).
- Squash all patches together to simplify backporting to
  'bpf' branch (Alexei).

v1: https://lore.kernel.org/bpf/20260413-stacklive-fixes-v1-0-9f48a9999d6e@gmail.com/T/#u
---
Eduard Zingerman (2):
      bpf: fix arg tracking for imprecise/multi-offset BPF_ST/STX
      selftests/bpf: arg tracking for imprecise/multi-offset BPF_ST/STX

 kernel/bpf/liveness.c                              | 110 ++++++------
 .../selftests/bpf/progs/verifier_live_stack.c      | 194 +++++++++++++++++++++
 2 files changed, 255 insertions(+), 49 deletions(-)
---
base-commit: 71b500afd2f7336f5b6c6026f2af546fc079be26
change-id: 20260413-stacklive-fixes-42e258cf0397
