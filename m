Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744463A9017
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951265; cv=none; b=GKd+/+F7aLjswv8VHlDEODAn9pkB8INdOh5+JPD58N+tSy0wVMGNT2KJ+A8uHD8laGU12vHb90yIrRpROAPXg842Hgt3Lke8zY8/KA2hOsPCJZ2UIihRvNpN6n5ASnXQExr3hiSIHa7lbfW2hJ/5xT/CXhM6AEkSzwRxCb67XCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951265; c=relaxed/simple;
	bh=BZ9lfO6U4ma9U2uVlRs0Zw6UyLWQ1toiQA7yQFJuSxU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kGxoSa+dZpWXk5dbNzPbH9ME4fpbgLf/oEFHBv6+yzSB7acYam9Sj+jkT5NBbz3NsuGuzvwHCE6ts2p9NmjbieAqg75bFZTjCyCro1iYQtLwzJpfDc1C+UIM17YkgzL1+zLuIUGQnKfqAiXra8YKhZOiFw01UUPi+Ju93GGN/+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=XnyrpHM4; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="XnyrpHM4"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506a67282a0so51783081cf.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 08:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1771951262; x=1772556062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DGNzLuVf9K7qCwo4M0rcgEP0M+Rz7a7R1W2RX06SmpE=;
        b=XnyrpHM4FrXSYFpyY4jzljm0/dQepiSPln0VowQhYtKLZhocV9ykK6o3aXcA+wbJJf
         H7FjQ4oIVrj7gOY/gsaH/RoytRFXFsH7KpOm8DG8k0hgGA3JvsrbQF4PkPW3dIJFEdlA
         UKuHnKEV+W9A06+PYfP+bTv4P3kh5UHdguOtukHCtPaKPILWrfJF8OICkc13LXnH9rV2
         1+zrUpnV8GGYaEkryDF1x3aqPoC9D7sIgImRFdE8fJYyqa/bwOwzwp3u/Zd1SXowT9iS
         WwMXiZiEAdG9H/zmFSRbPB9QqgoB4wkW5YtQgsRsfuR1hARBlnNUslIcDBfoHOi17+DE
         ct8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771951262; x=1772556062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGNzLuVf9K7qCwo4M0rcgEP0M+Rz7a7R1W2RX06SmpE=;
        b=CHLBBdKQPzdg1ALZX2YBolwjcNkIdYWbrA0geKPnWWxwcIZ9JNPSW7zLkGccHi1y5Q
         pjtwSnadIszTARKh8tbBv3h5BKxuBKpKQSOFhLQnxdFrUEZnXKa8ZsCxJeyiEg25/5oV
         buxZPS80CKnXD2vtBQGqX4S+WNENH7/zKBvE5NK+0nN7sD0EFAXuF3kEQ8dkfQIYmmZE
         3LG14kENYJ+4oZSMpkFyQ3XvCyhXVmWKgGpTsQiSFKtDV0Lw+5TBsoxhfvVwz55dCB0u
         vVSW2Q7/lZyrARTzjleoedIR4Obw9o+FwUHLpK5ZYi5I8ZxRSSWKHyCmfRalVOOA9iBR
         hHdA==
X-Gm-Message-State: AOJu0YzHBAP1owSJN69MIQR2Kd9seCoAqahnzykasgni+MwLeNvKmMEZ
	PSmxyV4wLzXvhV99Zg7v36dqUHql7xnB8G+QzUDAUGr0hIOBOd3xhlspcZFbONuS6ZB9a2cSHcY
	GmAi6+9BFkDmA
X-Gm-Gg: AZuq6aISa5uISSRhXK18u85KnHJMt1bSW/J0SOdibd++u6NxG+IGb5S/emk9sY3sGuz
	bm3dkjZ1Z43SrPlDVM45+4adokT/43orrImYY2NBs5Z782FMKDMzHBdflIUcsPXVdtT1ZSExRQ5
	wXnWJy37YARtZZr/MatA8usnjHzwq0Q7CNqJEOg0q/IcNep5qOUBcSDwSMxs/3UZl/YvZj5KpOS
	0Y1T4pPUHUyLw4waCfHtBYLiFP6IAx/klqAfJ18SwjdshrhhMolRiTSlm0Uaf+EHV6dMZBdfFTJ
	xkXu6NMdEdZZ2kWeAaFGm3vUCFd/WNjAp0puSaHdml2Y9Fnl6H0xYPuFKB7FA39gbMopfDszM56
	N6hGMyBDoiZmOw+dLlMH0bD0Q5biZ3txcgobqwtJPFebyQIaeSK//0AEDLR4cHdKu7Stfzyccbt
	uNIKCGF4ZrP5iMiPL6bf5BdQN+Vsf7U6sSp7tQ
X-Received: by 2002:a05:622a:241:b0:506:9944:8cfa with SMTP id d75a77b69052e-5070bbe0e70mr168875911cf.17.1771951261721;
        Tue, 24 Feb 2026 08:41:01 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0eb32dsm1169874985a.31.2026.02.24.08.41.00
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:41:00 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Subject: [PATCH v5 0/3] libbpf/bpftool: support merging split BTFs
Date: Tue, 24 Feb 2026 11:40:51 -0500
Message-ID: <cover.1771950922.git.josef@toxicpanda.com>
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
 tools/bpf/bpftool/btf.c                       | 128 ++++++++++++++++--
 tools/lib/bpf/btf.c                           |  37 +++--
 .../selftests/bpf/prog_tests/btf_write.c      | 111 +++++++++++++++
 5 files changed, 267 insertions(+), 26 deletions(-)

-- 
2.53.0

