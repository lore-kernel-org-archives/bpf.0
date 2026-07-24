Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D055B23395C
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784934947; cv=none; b=BwyHRyxi1FVviiEAHNzuPvSVp8aF5YrPvcQwMHT9ALL6r16jcs+pOz5Erj2NpiDtrUQEgYxDw6Ul75oGVkkcBGvzkQpsDFKTDBtPvqvtEwmbrz8OnHR3TesYOcj/IT5AjVA8eaxnnRkTWNpMFX4oKXmb4JkQoGN3dxI+LcEEGC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784934947; c=relaxed/simple;
	bh=c9IuCgiNEfrEPuntPaBoSRCiLCbOHsRDx49uRsHpdpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kDXhnIzy+++vqkjlcQayDap20xdDZ8uTZNZoDFiitL7xMp5bVzoFosg7CW6b0ZT6EiNzXZsrHbdRDZQhyzJLolZVTN4w/TFT2qeJ5sakP9UcTjfUoH+q/4NqxLCFGVUe3TBynNfSbBxnm7U/J1K35W7dQHUuLL7h72vI0Odx59w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=id/Ig/6k; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="id/Ig/6k"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cf52d15d88so10085585ad.2
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784934945; x=1785539745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0eDLIh2U1etlfzDqnzlCkQp4ETKNpYr6xSr3M4exe3E=;
        b=id/Ig/6kaLt+LmM0miRb4uvgtf851y1VE6eFg+5tQPtzkZcysXr0frUKOXop3gftLR
         5ssyLHty/evLe9Qsdu3oGCRAsMBc5L+zCBk9M/g55d61l8O0rXh39tslZLyp+4r45ru8
         eJiJ7vdCHx0RYmx60JbS5/YQ2WbQZrZzkNc+fjpit4Qe8Tn/wi67LeiMFmhjLgPIlGac
         EGKZGCXg8s5Go0T8zacwm2VOUxHyBSeR+kGz/TL5ZyDHI1eNwNGUBKOYFwf/8YIb06Fq
         v/xN+axlGgR+bL1OFW272ejgQ8RCd8ilXBTJoCCQPWygNGWROFwcY68rq6Z9XGMEg3BR
         oZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784934945; x=1785539745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0eDLIh2U1etlfzDqnzlCkQp4ETKNpYr6xSr3M4exe3E=;
        b=MNv2KSjX+lYUBf6KgLLXzo8u9RYsOjcarxP00GA4exXd1nbCZvOPPdbP9Q+kzF0QmM
         GW+RJbGJQ5A74JBZaWFCpIhCTeumw+Z7883H6WwX1moqjCxxfOUXGmaxO8y29i3JngHV
         0E82g5ivfED6Rdnttj1yYbJyDeZzWmKHeK3dSOkUGQ0AzTkUag6W/H5bAmXiy0RGImZW
         r/yuhJd0/HoBSldf7lvIRNHDEtGpsSwTSPf7wW1jb1L1/waeyzI+RpSK/nbnRzka27iV
         YeNmnYUJhKG58SsdOBpcdNycjMNmewTz/J1gCNiafhffa3KLdY07AHzotd21Vr0xwewf
         yCgQ==
X-Gm-Message-State: AOJu0YzxTztplEBXwqokt1PO5Vd6JJglP8ffUvqQ92d+I9cC/VPksP29
	svY1cueYGNwOgaxbXD1FXUNCUKalsHx9ToCNV0rzdE5O/jGpDBHOZ7e3
X-Gm-Gg: AR+sD11+rAx5c+2jA+uEwK+xLQ/koMDpCSDwwj7Z003gjz5TbV6lpJ80LLohQ347p75
	1gMOL8CUZ7zokGOS2qaMJGOZPRu5rbodKN4uhIXa/1FKfKjkBCtAbmrdGIWMGdNcQ/yrJ9ZrZfl
	+jcXpNqcNk+JJOQ2Hy0snrYonUypEjch1wZdsnnB7OUG3G9AKgbkydk0/r3TxAfZJ+4fXC7zjV1
	cllsm5W51scEvDQsHeDCHPC93m8v38VFPdzAXJfNAKLn/Lzj8EoHMWWh8kLst/hvmEW8VANbVRG
	h50EGu2QC+qpJYLL5sv0c2xeMub7rSyKKOQMTWbkb2OwurGmNdhAmt1zXXvzgcQ6ctGB8NnQ2DG
	z63xJfLXIefMT/h0tbDRKWVh9vEtojPTBuidaTE+6mGaF52v/HWT92RhK8SW8PvLfpBtZkoSCC2
	fWQVAz2YJx8I1ITZyHvQI=
X-Received: by 2002:a17:903:18b:b0:2cc:8267:31b5 with SMTP id d9443c01a7336-2cfde7adcbamr3820015ad.19.1784934945089;
        Fri, 24 Jul 2026 16:15:45 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7bbdebsm1369595ad.46.2026.07.24.16.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 16:15:44 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [GIT PULL] bpf for 7.2-rc5
Date: Fri, 24 Jul 2026 16:15:35 -0700
Message-ID: <20260724231535.854435-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 94515f3a7d4256a5062176b7d6ed0471938cd51a:

  Merge tag 'bpf-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2026-07-17 12:55:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 2d66a033864e27ab8d5e44cb36f31d9d2413bee4:

  bpf, sockmap: Fix cork use-after-free in tcp_bpf_sendmsg() (2026-07-24 15:04:11 -0700)

----------------------------------------------------------------
BPF fixes:

- Fix tcp_bpf_sendmsg() error path mistaking a concurrently-freed
  sk_psock->cork for the local temporary message and freeing it
  again. (Chengfeng Ye)

- Reject passing scalar NULL to nonnull arg of a global subprog.
  Previously the verifier did not account for the cases directly
  passing scalars to a global subprog, e.g.: 'global_func(0);'
  would pass even if 'global_func' argument was marked nonnull.
  (Amery Hung)

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

----------------------------------------------------------------
Amery Hung (2):
      bpf: Reject passing scalar NULL to nonnull arg of a global subprog
      selftests/bpf: Test passing scalar NULL to nonnull global subprog

Chengfeng Ye (1):
      bpf, sockmap: Fix cork use-after-free in tcp_bpf_sendmsg()

 kernel/bpf/verifier.c                                        |  3 ++-
 net/ipv4/tcp_bpf.c                                           |  2 +-
 tools/testing/selftests/bpf/progs/verifier_global_subprogs.c | 10 ++++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)
