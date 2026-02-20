Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576013064A0
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 22:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771627448; cv=none; b=Zj24t46RqthQCM1CrQcifU3hNb/2kBN4dOIgLZmovIblB+kgNAhN0bVeUP9zahMGKETCQaKmO6v2ZM3CX+7E8m4PC51Zb04wYNibqyA5Ev2zYL+eUHmRRmKhT7/z03GIEK/wHlb7GirfqiRS0R1mGhpvQvVxwqFcULD5z7FXUmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771627448; c=relaxed/simple;
	bh=S1E0087t99p95WNwjQXspddV7lztKT5zMRb1wyj71js=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pYDSG8qIE/VIRuXfo/737x8OJ2R7Aj21iELsNY0dbPeDoMMNZsXMV5qZ/5vvumV5rdxU6SKdEyR+XTEnvn9bD6ea49UoVbqvBGKG2PRPMpZAhdNf9ncCJ9EuAjbxRU/rWgZJlXhHXYcHjDDrxi+6TRAXOhb3234w6Xozog286/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=HkAkjQ/c; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="HkAkjQ/c"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-649b5f5570fso3219527d50.0
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 14:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1771627446; x=1772232246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DtKE80gtp9vrGL1FpV8sNa/5aSvK/Go76g+/LxqG4c0=;
        b=HkAkjQ/cid7vTFltgyZjYLrd2H4ObaZemBvboTjAAdasxJqQpqPG17RyeaJVb9wCnm
         4qakkj44uWH+uJxa0GIaajYQHmYpdtw9hpZzrupx7+HhdWyuobgf9qxn8XWsUlvpNDGz
         7SkWeBxbZnQj+CCnbVrCUAVV3/3d0owshJca/SzEXiPfIkN4y6tiDMXShrcb2kRXPP5j
         C1JxOXUqStiAYyql+19euQJ5E3XBhWCt1YRQgF/yf5IkyCGeqVzhOrc7/YKt9DyVIWnh
         efG6IW+XwjpDutiDvsjpyskXjRS7H2pmweV/U/fheJkzmjRiAZIBg0ubyNnrm4lXcebG
         ffQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771627446; x=1772232246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DtKE80gtp9vrGL1FpV8sNa/5aSvK/Go76g+/LxqG4c0=;
        b=Mhltb37IiFciinK3Ak8nkWrNvhkxj/nTXzELwIl13mAhCg7ouK3uZYWvHD2+eIYoTE
         4ayQf2hhqaxwp09wZvwPJnAHkDaCnISsBITd3BkKZ++4i/BX7lJTR/UVNA8klwxLw1vr
         A0ppl/HI4duK2GN2odeHighU1jNeiN+MpHEkzIKcwqSn+JNN1wKsEwD9fGl0wZdMiLUT
         qX5iMFqSLzUAtnjLtUDTfPswEHkQMyI/1Lrub4SsgU2j6f3i7rtd5nZ9t3hM4jxxhPPO
         Og+rV6wNaCHS/5QtQJMPPHxY3XaYfKHjir0C8GspNuBTssisy1XAZwWAdQ/INyohYqzC
         6rZA==
X-Gm-Message-State: AOJu0YxFyWQ+tVC3E8dGCFG7RHkgdpVl+9k4B//C46+yZLWYFbchJdLE
	qyC+fBGCu7cE/2tqvrH8uvrS3jMvG+Txd8+JCJsE9q99vr4ZgbyITt8ljpoVFeHqGLZ8bfhDJiO
	Lb0GXJlKnszT/
X-Gm-Gg: AZuq6aIe3099UYzSGWiVKOWpLymH8y2n/0TIsjiL4FtsR3439ENQGe9u24qp9VQ5SII
	8Qc+KxakemmfbRbf/Y3E1LwSPmZo+9wZlnpq5e4ggkx7As+os8HVrfroPP/wkSnfTCtqGzT6Oau
	lKvVWoDOG02ZY8WVDycE163xki7luaFAE1dcEspdUJlBTDQTGDHMx7alATc+9V4L8e2EEnyz/nL
	jxzC0PO2EJAHZd2tZduw1ouoyzaAyJvCT2KPdEvNfx9gohjnXKzjk+s0BgmkZL2Zw0721G8BWsu
	AgNynJEmwIuz9ThwaO7Sjm/4skv9Hyq9vOrT7eN85yGndOrU/wSb+9hVFD+CvYSAHa4VOi0uyKA
	/TE5/PgyEovn6Jq8FCApSUHPDNhzwk82ebSL7/80JhdZAA1bEb1B+3F4hArbAJafrfMjcWdxAc2
	LmlWrt7gQw6M1WpgiG+Umr78RDzQ==
X-Received: by 2002:a05:690e:14c1:b0:649:dc5c:1919 with SMTP id 956f58d0204a3-64c63fe7866mr5241047d50.10.1771627445971;
        Fri, 20 Feb 2026 14:44:05 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c7a252484sm289306d50.4.2026.02.20.14.44.05
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 14:44:05 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Subject: [PATCH v4 0/3] libbpf/bpftool: support merging split BTFs
Date: Fri, 20 Feb 2026 17:43:56 -0500
Message-ID: <cover.1771625484.git.josef@toxicpanda.com>
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

v1->v2:
- Added a btf__dedup() call to btf__add_btf() to ensure that we don't have
  duplicate types in the merged BTF.
v2->v3:
- AI review got confused about the UAF comment, so the comment was expanded to
  clarify the UAF potential.
- Fixed potential clobbering of errno in the error path.
v3->v4:
- Fixed a potential silent corruption pointed out by the AI review bot.

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

 tools/bpf/bpftool/btf.c                       | 135 ++++++++++++++++--
 tools/lib/bpf/btf.c                           |  44 ++++--
 .../selftests/bpf/prog_tests/btf_write.c      |  89 ++++++++++++
 3 files changed, 247 insertions(+), 21 deletions(-)

-- 
2.53.0

