Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DBD3D25AD
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392290; cv=none; b=uOEl6dQveF/396OCOTT3167H2kwRQhVCSaYUWZaL9fSakKMUcQZWy0Z9Dr4sVI4sG+hmkG67WorY+57isJeakxmUr9UmKGCxsrSEazENp+JXxML36xpspc7SX894ks/pnkUg8fo2ZMeucaQ1qb9h2yRzdpyuDrJTIS4lgzv7ehc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392290; c=relaxed/simple;
	bh=Iy0PZl74PjXByJ1SkaTw7PCNb0LdSnU+FId6dC8L2Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cDm/nOeszcsz62R/OqJdSbiDAhkU0PviHdm8un7Q/vzJFUYRfeCroL7Ez+opbb1NYqBGTarSMJcpvu2CqekRUvsrcs6jkGwwp3oT3l5BKcacgZXqJ1oOskfT4QgDg81cM6Dc6KlQ7x/BoaiehY2FV7gfS10rKiPExurD0Vfm6bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oQSkgNK7; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQSkgNK7"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-4843169420fso923613f8f.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 06:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789392286; x=1789997086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3lwpvLfLCrVyXRbX1BRjzQHO5qGMQgkA+vyYtsIvvLA=;
        b=oQSkgNK7Tt8pMi6tbzXYVoamAnJJFwJE4FP+VCW2RA3IMDUTcZebCvf+kJCcM08WRf
         15xdVcT8rbC01yJQgAMg9GO24NEr45EGymV/xkZHgnCTMY9gqfNwdD3R0wEwkjNgLW7c
         k2r6cAoQHyQWJm+jPmHrqvEqaIDM00j1Fl/6tLyDGQ4fhOL5rFXNp9hOngq+OV2u182x
         C/bZO3SPJodtwjKNW7CuGXkeh2HjqKGwT4oZgKBoKCcq/07/X+n2b5p6m+58v5L/bqiD
         rmkHB1aESFOgvX6cdLSaEYCP+Bu0XnSMqE10cd3MKfdIJnH0GKcJ3JqGz0+yL34T2MBT
         vd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789392286; x=1789997086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3lwpvLfLCrVyXRbX1BRjzQHO5qGMQgkA+vyYtsIvvLA=;
        b=XKG8p777BLL2zxOraJ9ehjvbcGUPmtRvHC6BZL1tBdOQuJ6n30pJedup63XGqG/XPD
         7RXMFoXQ85dBAUsMy1ay7PPFLF3A8LBZUxngH1txPhn/exeONTjWXWNv2NGuM5hRzbE1
         zXLII17ZY3bGwenzaHY2Nut+LwYxp2oYpwxg/8tSuAMdzCJrNIt8h6lNss2GX+M/9Mte
         wKQ4YdxdYnch0vgrZVW6sAQhLoya48MFyPCl9wITLoIfJiiuBC7RZsxr21wkmx6EyS7X
         9oNyEtj4u+xve0X+JrAy4w6j9pVXCu1jmOFV7Nyx0xm+hmrZHL3J6nxjiAF9+IYx5AGT
         GLDw==
X-Gm-Message-State: AFuF++kTOxEJuW28DBaz2s0cl5tS8Is19Rrh/tM6VFZnCWY8w7lsfRWw
	E1Uj5r3lvFUDZWnMZs5wSm7oKc5Bh+BpqtQrEC8liANGKMp67JNSstVUy3+LF6Tf
X-Gm-Gg: AYBFou34We2ayM4zGm9Q9qsSNv2UbsVfbpVHDr8tL2JufKCqb2Aut9Wv3K12/UEBeVr
	9MYpE46BRLwiS9JEDxZz2G5ALKhaxr3t5mCryrXF7EwOI7Uo2zf+UGm+6ELDJDL0JrtKr2vmfvx
	3/1SS/BoQksSucRf7x0C1GWFe3NxOluU7ov7alU3zgyc98doi+VxY4clQp5Q4cW0sZXcOJmi2gE
	bhtd5LyVGyN5oPZEsiV727PRymlMvojNgOH0fbNypisRD12pYRb8F2rGLAh/WGifBLKxeWy3Sls
	lMDq+9T2euFKXnEXV6Ol82ph+NGG1MU6xMYwCPrmuqGb/rOpTaUKC/hJnzftO3imBYZ4Z7P9agW
	XmWF6QxHQ+tBelau1IyHJx1IsoiK4wDEl/XW5sQuSnd+QiId9bWooHmgi7Jc9edmutBxVaBYDbr
	2vu9o+Cs11mTp6N/K+ebj68NYcJUbqSCwlQtKPUBNIruFj7JPZrsjKwQ980iWFwfWG6sX9lgNUD
	Dv6BfFK20Px/QRn4gKXPZLlVJzbED7ulQGI50aw4X/kbUvZaWzov6R6yEg5+f12UROKpHaBR+en
	gmh6ACWKj1y8pZfeFmhKMHnbaTn3NnfNrRIjuw==
X-Received: by 2002:a05:6000:41eb:b0:486:f455:403 with SMTP id ffacd0b85a97d-48702b3b606mr3164796f8f.57.1789392285920;
        Mon, 14 Sep 2026 06:24:45 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb357288sm27488972f8f.29.2026.09.14.06.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:24:45 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/2] Fix acyclic ownership checks
Date: Mon, 14 Sep 2026 15:24:41 +0200
Message-ID: <20260914132444.2564218-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1773; i=memxor@gmail.com; h=from:subject; bh=Iy0PZl74PjXByJ1SkaTw7PCNb0LdSnU+FId6dC8L2Rk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv518m7j9blC9RLy7Al1LMWRU32eXCza/+qJ1ss9BV// 9Ppe/e3o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABOxMGP4Z7u6NPRrzG9enZjH SjvdGj60MNTIBu343/aZXchy6ZzNvgz/s4WjMtg3bTRwbTEtD1l1+jjD0fVHa3WM8ib4TymWOiT OAgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Bound and ensure acyclic ownership graphs for native data structures to
fix a bug reported by Nicholas. See commit logs and tests for details.

The existing list/rbtree rule already rejects graph-only cycles and bounds
those chains conservatively. It misses ownership through local referenced
kptrs, which can produce unbounded synchronous field destruction. Validate
all local ownership edges together, with an explicit depth bound, and allow
longer acyclic graph-only layouts within that bound.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20260905090750.4064411-1-memxor@gmail.com/

 * Fold the graph-walk and local-kptr changes into one complete fix. (Alexei)
 * Explain why the original rule catches graph-only cycles, its three-type
   chain bound, and the missing local-kptr ownership edges. (Alexei)
 * Distinguish synchronous recursive field destruction from the deferred
   RCU freeing of object storage.
 * Add depth-boundary tests with child-first BTF ordering and a shared
   suffix reached with different remaining budgets.
 * Cover list and rbtree chains at the original three-type bound and at the
   new eight-type bound, including rejected over-limit cases.

Kumar Kartikeya Dwivedi (2):
  bpf: Bound ownership depth through local kptrs and graph roots
  selftests/bpf: Check local object ownership depth

 kernel/bpf/btf.c                              | 134 +++++---
 .../selftests/bpf/prog_tests/linked_list.c    |   4 +-
 .../bpf/prog_tests/local_kptr_ownership.c     | 296 ++++++++++++++++++
 3 files changed, 384 insertions(+), 50 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/local_kptr_ownership.c


base-commit: a41c69c6ea14596cfd95978483166d4eff52435e
-- 
2.53.0

