Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD001C27
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 03:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709781155; cv=none; b=VfncmeaeQB9Ij5Hfcd7hOGffqfbL4VB5WO5l7DxpYSzc5mx5IptRwi20DLf7sDhADdbeA5+APlYkAgJHvBAUKivxRHONbJK9qRQotd6ZJDTNstdjnYUHvrdJh7RPEmioJOgSdxsl49qTPl1sD4wiVD3hrImfypLKt8iITD2KLqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709781155; c=relaxed/simple;
	bh=IgS2S5vb8V+VYxgYJ52kpoJu+dlAuAG5QnfZAkoC1YE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K4TqKihZWCSi2aW22Hb+sX4bFmQSb6eBwVqU5/QKMlN+xYn+DS1E5aKbBr6sU2trfejvloy7QhrHLTSaQSG4nJFzaYQgeUXeHmEtv3WuzlXO5xO6HDqbE1J9no4sKR0x6N1iMxW/mVOWATCEAqjNqwrO7cASgsxPc5Uee2RO7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOB6jSVj; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOB6jSVj"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e56da425b5so441919b3a.0
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 19:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709781153; x=1710385953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MbMb/cmqqu8//3ACZai0ueXgKQ5OarLX0+UhHc3GttM=;
        b=MOB6jSVjSwlfbHixWs9M9XszuaPI5VJQv83tkHWjBEtUfKHrs5kampgj7BhCBKfukM
         q62/EytZAGcB4/6BbBGOxAwvv3GsyMhvPkG4U7I/O+mhlFdzHy0gNg2yfpKAhzjd71ws
         gHBt73NjHE0n8NQqLYZGrjY52HnJ02lXgOqTmbxl8s5Fxo59pv4HjkdmULJleXE8lILe
         bUi81NdzvnQ0f54p0iEuymNPIxcKCHWzjCuCnIguFDociMfc11RdqsXZfw2jDAW9rsxG
         XExWHEjpPyMXrX+yzwaCxxsJnvKABWh+qLtp7PtSGlu19BWX/E/Y0TLtLtcVhq8+jz6U
         BNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709781153; x=1710385953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MbMb/cmqqu8//3ACZai0ueXgKQ5OarLX0+UhHc3GttM=;
        b=GF8iiG2qyjMew4zf6ugXdUQa4h+WCX83uhO2CMBLGbvCaXheCARxDH4sdMdHeo7MRq
         iMYfWt2zl7MrIGDqf4nFx4A7VlqrhLJzrDp92gYtXQxTMKyEcKjN5t4ciVi7qhGWYfsS
         U1LdzrWrY/B7W0l9opVO2jJLEImmEka0pIymRC1/X3nx+X01pw/yB2i7piespKkqd0dM
         2JhSFhQsJ26hSy2s5EcoZe5Ym5opMF44gySQqRAtrD25scSd20zQ1JBPAd5rveZBtxLe
         hEhueXg2eGkkKdRRdll4J1+7Jh1o/wz2o95rPjJ7bkUT29FCjLFG4/VtXoSAatKMBXei
         21Tw==
X-Gm-Message-State: AOJu0YwyrU4QNeXBvjjcwqRU8B3iYciBV/3UOEzUlhqn4GEeFeBd6PFt
	e47ObPXwKAivNu8IJSnsCSXniNuNHvlqpBgmEY6liqkafx9tT6IrGS/JBiYU
X-Google-Smtp-Source: AGHT+IG8Ca06Jp9pwaV93bmK3ciiug3BSR4hVDHX4SpPXO3rHTeIZFP1RMuGOA8XxuoUS0oOv8vdVw==
X-Received: by 2002:a05:6a00:93aa:b0:6e6:4679:fa8b with SMTP id ka42-20020a056a0093aa00b006e64679fa8bmr6927714pfb.4.1709781152838;
        Wed, 06 Mar 2024 19:12:32 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:dd40])
        by smtp.gmail.com with ESMTPSA id r16-20020a62e410000000b006e46047fe04sm11497444pfh.204.2024.03.06.19.12.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Mar 2024 19:12:32 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v4 bpf-next 0/6] bpf: arena prerequisites
Date: Wed,  6 Mar 2024 19:12:22 -0800
Message-Id: <20240307031228.42896-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

These are bpf_arena prerequisite patches.
Useful on its own.

Alexei Starovoitov (5):
  bpf: Allow kfuncs return 'void *'
  bpf: Recognize '__map' suffix in kfunc arguments
  bpf: Plumb get_unmapped_area() callback into bpf_map_ops
  libbpf: Allow specifying 64-bit integers in map BTF.
  bpf: Tell bpf programs kernel's PAGE_SIZE

Andrii Nakryiko (1):
  bpftool: rename is_internal_mmapable_map into is_mmapable_map

 include/linux/bpf.h         |  3 +++
 kernel/bpf/core.c           |  7 +++++-
 kernel/bpf/syscall.c        | 16 ++++++++++++++
 kernel/bpf/verifier.c       | 19 ++++++++++++++++
 tools/bpf/bpftool/gen.c     | 18 +++++++--------
 tools/lib/bpf/bpf_helpers.h |  1 +
 tools/lib/bpf/libbpf.c      | 44 +++++++++++++++++++++++++++++++++++--
 7 files changed, 96 insertions(+), 12 deletions(-)

-- 
2.43.0

