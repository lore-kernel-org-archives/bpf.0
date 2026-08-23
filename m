Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AC11EFFA1
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787494662; cv=none; b=Q7eZwzC7/Af3QgBLAufCFTEvK9ig4a8uqbKW0eeDKgzHk7Rs/WD4pegO284YeS6Y5tm5seWY34si339v+ZgkeBydE8rqygcD7ihRHbFWxaB8uz2RvPJOsSlbfWuAHpH8O7g4Li6o4hMudJuVngX5G3aaFaucuYYz4KT1LKd5HQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787494662; c=relaxed/simple;
	bh=Vg7chm6Z3ZZ80kKMcLsPZtpP1r31vdvD6SHVm4f5dT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOdTsmeflUQrGPzB3Th0QhjhS2x4HxyvMSaghLPOxaDw/aZ5AxYX0ew9/MhUnviigNYcQbO3peGjGwNZioKt9FxGtGydS/S0d3iObu6Bc4G1eP4Ff0bSMFBxVp8MFuUpjMgOYAtjz9Cqxg1vEH6veK8gVFePg44+py0EdKf0H2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2cc2c6e0688so14505945ad.0
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 07:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787494660; x=1788099460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iW9TZy5t7X8VGYLC2u3VxtI7rFgsxhmuA9rnPKoznsM=;
        b=lOBzr3AUZ9wpqegmfY3JYyzDaNYlNUQxBXIwyqPQ7yfff+dR4J282WoakHTnFlw51r
         ErCq2sVl0bNt/goq5B/YpUKO3KPHlDVLbYKZz1Ima4Dcxn+F9lE0MHy0CxJ8TAVw5/lX
         B4D0Ce7HnwDK7TT05qycMH1Pl1+wEJmUYrFAXIcozXFETtwfOWCCTY9Ov/bcFwx9LXBL
         wDEX59H8MM9dCcG97CRnff4S97FghO0uC7zyGrw/fTqboIa1ofzILIYf6uzVpRFAJscX
         bMpMbb6pVfdHvcDS+w3gQ84d4ZPVtgaFS0wGmNfTPrxliY+dlElltDDr/t+0d1ouleL1
         m7UA==
X-Gm-Message-State: AFuF++nnJJIH0Tpej0KnT8w6ZetH51z6hTOEGCmPKMC1mn5Z2oMyf34q
	CGqUVysRJIbmswJw0wMVz9w0EE9AWTXIMoek7KpOddV5xfLIzJpey/0v0E0QsbSMVoF3Ds/3xdk
	=
X-Gm-Gg: AR+sD11A/TjCb5cP/uvfIqManbQw9ws83i0RVij3PsAwFmzc8GBkueRlO968i4wBKsV
	vaAdzaXZSbyxqt/rNttNdtB5ZrUg/HBrExYLhWTcAwn7+//0tO4oD6lf8cXWVhRlCvTwzlC9Mcy
	9jMy0F4R6YZYz0pab3ku7UxJ7fAdwqMyBGiPzMZ15mdGCxw1p9undTdta9xhD5lhfJ9wI2nc3Si
	q5Bf4iuj3ua25KeD5fBbwvym/Gs+fKjbPP0ZL0tnCrlPDmPTOcyvhqFVb+Y1paGm6P9emJjAY7V
	e7efS8dE5YsyXCUWZwX/k2yM9RmUXEu1N4KhDIcPjJnfB8NudUdhHF024y6+Dc19JrUiehej4eP
	PNnDZ3Eo6tBkNzN2/F9iSsRNlwI37xVptLrCp+l89Na8eFF4SkYNcP8gVAU9pEJA5fMtJGWFrAF
	/+6mX6zGwRus3yukib3cuFATU5PpHZQImQGMXsVOmHtvIhGcla260CajBhMRGVvNGHVBR4WF/od
	LsqNFu/AuFPvQifUw==
X-Received: by 2002:a17:902:fc43:b0:2d5:2f49:b3f4 with SMTP id d9443c01a7336-2d64ad9562dmr313282145ad.2.1787494659721;
        Sun, 23 Aug 2026 07:17:39 -0700 (PDT)
Received: from localhost.localdomain ([180.153.160.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676791d44sm9944575ad.24.2026.08.23.07.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 07:17:39 -0700 (PDT)
From: Jianlin Shi <shijianlin11@foxmail.com>
To: bpf@vger.kernel.org,
	memxor@gmail.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@chromium.org,
	sdf@falco.dk,
	haoluo@google.com,
	jolsa@kernel.org,
	emil@tsalapatis.com,
	pulehui@huawei.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 0/5] bpf: fix stream capacity, read, and oversize handling
Date: Sun, 23 Aug 2026 22:17:23 +0800
Message-ID: <cover.1787492521.git.shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_E69EAE29327E25B3548A9AF3F4FA289A6806@qq.com>
References: <tencent_E69EAE29327E25B3548A9AF3F4FA289A6806@qq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3 addressed Kartikeya's review on v2 and the related Sashiko findings.
v4 fixes the stream_oversize selftest to verify capacity rollback on the
same BPF program stream, since streams live on prog->aux and are not
shared across programs.

Tested locally:
  stream_oversize and stream_partial_read (equivalent to
  ./test_progs -t stream_oversize,stream_partial_read).

Changelog:
v3 -> v4:
  - In stream_oversize, perform the oversized bpf_stream_printk() and a
    subsequent successful "foo" push in the same program; read that
    program's stream in userspace instead of switching to stream_syscall.
  - Drop a redundant vscnprintf() comment in bpf_stream_stage_printk().

v2 -> v3:
  - Refactor bpf_stream_release_capacity() to take a length.
  - Fix staging-path capacity leak; use vscnprintf().
  - Return partial bpf_stream_read() progress on copy_to_user() fault.
  - Reject truncated bpf_stream_vprintk() output with -E2BIG.
  - Add selftests for oversize and straddling-buffer partial read.

v1 -> v2:
  - Retarget to bpf-next as suggested by Pu Lehui.

Links:
v3: https://lore.kernel.org/bpf/?q=%22PATCH+bpf-next+v3+0%2F5%22+fix+stream+capacity
v2: https://lore.kernel.org/bpf/tencent_C919BB32458A4DAD645A68F441345B971E05@qq.com/
v1: https://lore.kernel.org/bpf/tencent_E69EAE29327E25B3548A9AF3F4FA289A6806@qq.com/

Jianlin Shi (5):
  bpf: roll back stream capacity when allocation fails
  bpf: fix stream capacity leak in staging path
  bpf: return partial progress from bpf_stream_read on fault
  bpf: reject oversized bpf_stream_vprintk output with -E2BIG
  selftests/bpf: cover stream capacity and partial read edge cases

 kernel/bpf/stream.c                           | 53 +++++++++------
 .../testing/selftests/bpf/prog_tests/stream.c | 65 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/stream.c    | 18 +++++
 3 files changed, 116 insertions(+), 20 deletions(-)

-- 
2.43.0

