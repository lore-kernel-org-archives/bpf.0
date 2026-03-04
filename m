Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF0E37F01B
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 20:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772657823; cv=none; b=ChZGqzDWmI4+t0bvhDaPKPxY3X4UcsrLwyQ/F/In1PjS+S3oQYK6qMlJbVjTNIG/g35SG4Rb16osyeZtqhU85lntFZeAHkJxa3EilmonJRJuOu0XucorY90EnYUgj53BwOAHPjR/7JVxa8dWK+KT+wdmslpsA31WywkZ3jqgAUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772657823; c=relaxed/simple;
	bh=0uIEWPN8jzEjIZykevH/eg1LwWCncnqBKDmLtzkNfGU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IRMjFGAWmr9qWnvl0m9nVyOoT4KszzF2jZHCrc/SKLr7GqeKZjaeXROdPOoU6yaBHUWXl70mBiTEsR+Hopq0/Ez089YdZpzDxqjiPJNN7clUGR0139+2yCJq5reorMFirjyoycc/kMnl94zcpQUlz8xokGUJIbo4WrtJwHfVLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=iptlkwLO; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="iptlkwLO"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5069b3e0c66so112748551cf.1
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 12:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1772657818; x=1773262618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+CQQTCp1ghPjnyJ3W1NJZBv1Ut1DN8YQMvzE38BBmLg=;
        b=iptlkwLOutEyFUbIPe/GlOJEkOSeb9U1YkOdzN8ATyBxnxKIQ6cvNe0Buyl/4CUXQz
         5gJSqMph2foQlFGXLR3eUi0sIkr1jtQ+3dYZFdOtFHHL02pHqiba8e0GVdEhqG08S/4L
         iHGCZN+479kTM8fSf5BGO6iPILM6tp67XXtNj41OnRTSo2yOIQlRpgbtRIhBatV78O+N
         zAph9y+cfedOnVfcH7/MvewrLe2QmH7fienbXJdCjIL/srnpEOHtHm8i7q2qvSNpP8Rw
         37TyFGYszRDgG/RRvB83P6d4UzRU2pJ7QS25cPZs+GxP3+nku4uIqruXR0Anx5fo4Ub1
         dvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772657818; x=1773262618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CQQTCp1ghPjnyJ3W1NJZBv1Ut1DN8YQMvzE38BBmLg=;
        b=hSqSqoLz2kdHCTdN9JdqRkriDDGysiEZ6nG5f9rLrYTDR18WmvF8z0KkUciXNIelB6
         Awt1wU3Frzjx3FDqbouiGj9x7euzlQqF2Rroqa6TZ4iQcrwlAzTJCckEc9bvMn3uBFV9
         0T8+3PlKzMjP/kh/i/HMw0D+j9z320lCO5eV0I/8BYUl/AjGtSg/UZISq4zDoMr0S3UX
         4VqY+WVC9Iue4GaMxe6w4nEHcS8V2YSPncQaJ3hjk1Wayt0Jafe6De8Dx+FZC2ogdYTs
         7VI5eZP6mnuhdVehcYyG3x3tbh32AOnScWW6OjQVvIeQO9EFfVxPmJjyS99JfhzZlYyS
         DWuQ==
X-Gm-Message-State: AOJu0Yyn9My6Tt8N5SRcGRwv5JhtN55VTFjncMMrw1J8zGcU4TAF4FmQ
	qHEhu/3S4LMNDWjvefksc46iXM47bnKUFbZq17uhxMFbuYKd4ksucdOgSvSHW36FkH5i55X3FHj
	oC6HFwssxew==
X-Gm-Gg: ATEYQzx3nN7YIjsXOvjcoLANeiPKUr2q/xuRqmYkTsp0Lle0WgSIdtZd3z1DPHN7Max
	y/gETYYx3DqltIvZsBOvggFo2wM+HGTnCTcFMvcBVR0V5o3j3u3khWek8eFh9nK27IgLHGrc69r
	BFsdSfFnDMX7vKQ7F6bbZF/MvkBS578yb/CoPY2mnWFfe6Vc5KAfRivl+s9ROusmSn1MNB/X8Ol
	UZZVuepokWszGGKzCFMr3BHi+P+92DBx+OzHsn48LaYPWPA6gZ43IHfOAqjC53qk4Tata4Bkh0I
	F8P+g+5KqVyoETbt2JSdSb8s5Czm+RoGg8zi88/tIrLmuksJOyRdDBbBfDWjz8L6T/iU/GGXjfe
	plK0B2AuNOyR/vH9FL2YwLtBfFWhS4ruQz4lmG9BWJh1oTQLAI9ZGTnFjHlsMP3bq58okRwADeP
	LVeXnYaeaDfoEtgXSLS+kCuTZ/fw==
X-Received: by 2002:ac8:588c:0:b0:4ee:26e9:98ac with SMTP id d75a77b69052e-508dbd36a68mr41245101cf.16.1772657818519;
        Wed, 04 Mar 2026 12:56:58 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744afa7d7sm162716051cf.32.2026.03.04.12.56.57
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 12:56:57 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Subject: [PATCH v6 0/3] libbpf/bpftool: support merging split BTFs
Date: Wed,  4 Mar 2026 15:56:49 -0500
Message-ID: <cover.1772657690.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/bpf/cover.1771605821.git.josef@toxicpanda.com/
v2: https://lore.kernel.org/bpf/cover.1771616227.git.josef@toxicpanda.com/
v3: https://lore.kernel.org/bpf/cover.1771622266.git.josef@toxicpanda.com/
v4: https://lore.kernel.org/bpf/cover.1771625484.git.josef@toxicpanda.com/
v5: https://lore.kernel.org/bpf/cover.1771950922.git.josef@toxicpanda.com/

v1->v2:
- Added a btf__dedup() call to btf__add_btf() to ensure that we don't have
  duplicate types in the merged BTF.
v2->v3:
- AI review got confused about the UAF comment, so the comment was expanded to
  clarify the UAF potential.
- Fixed potential clobbering of errno in the error path.
v3->v4:
- Fixed a potential silent corruption pointed out by the AI review bot.
v4->v5:
- Addressed Andrii's comments for 1/3.
- Addressed Alan and Quentin's comments for 2/3.
- Addressed Alan's comments for 3/3.
- Added my Signed-off-by for the third patch.
- Made sure to validate everything still worked.
v5->v6:
- Fixed the missed is_prefix comment.
- Fixed the removed warning about skipping vmlinux.

--- Original email ---

Hello,

I'm extending systing to do introspection on vfio devices, which requires having
the structs I need from the kernel available in userspace. Normally these are
loadable modules, but in the case of vfio there's multiple structs across
multiple modules. Normally you'd do the following to generate your vmlinux.h
with a module

bpftool btf dump file /sys/kernel/btf/<module> format c \
	--base /sys/kernel/btf/vmlinux > vmlinux.h

but if you need multiple modules you have to hack together multiple dumps and
merge them together. This patch series adds support for merging multiple BTF
sources together, so you can do

bpftool btf dump file /sys/kernel/btf/<module1> \
	file /sys/kernel/btf/<module2> format c \
	--base /sys/kernel/btf/vmlinux > vmlinux.h

I tested this with my usecase and it works. Thanks,

Josef

Josef Bacik (3):
  libbpf: support appending split BTF in btf__add_btf()
  bpftool: support merging multiple module BTFs in btf dump
  selftests/bpf: add test for btf__add_btf() with split BTF sources

 .../bpf/bpftool/Documentation/bpftool-btf.rst |  11 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   6 +-
 tools/bpf/bpftool/btf.c                       | 132 ++++++++++++++++--
 tools/lib/bpf/btf.c                           |  37 +++--
 .../selftests/bpf/prog_tests/btf_write.c      | 111 +++++++++++++++
 5 files changed, 272 insertions(+), 25 deletions(-)

-- 
2.53.0

