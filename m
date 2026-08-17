Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF92235045
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002942; cv=none; b=TiUvy6n04ugd8S+vv56/f0eWs/T2q6T3XZ89u3R8GefKVzlWhcBzOut4MFbw+TWLKmkxZxr1EfOraeEeGrI3KZ8S8bVhHYIlTDNyWBP3Rjfbcdu7LWzyp2kIik8gEHl2pjqcsYJCrDb43YyzGgxK5ycfAU4fCKHugxtaLbgeMWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002942; c=relaxed/simple;
	bh=PCpGwbY4BrW2K7EHaYVaxP+3UwgpYAMPsqatWFu5N2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r+cQGrJ6o+HI9j9J8iXxWx0nVqTE7QXqnba3MAxzonNokGpFnsrDSkszb37ZDmH8ziR7uNEjOJocpLu9bw7rTejmi2rCN1zpX/RsxAx2EUIfMUJvPielLP4V+ltFrUf8ybbzeGu+lQRghmXF3hC18HLU4NWevGLxxu/0wou0g/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuU38USQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuU38USQ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d560775ca2so17811095ad.1
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 14:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787002940; x=1787607740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y+y60PoeOcJzJyhWvC9Eh/WUb1AnWEbvZFwtNlrzZtU=;
        b=HuU38USQmpE1GGeGsf2eFjCIwwTXNaq9l1Fy99LNeTlUAfNnzBk6EGKWqzJu/kgPQl
         QYXGWUV20owvYPadq7RN4tJbpIG0t3KNt7JMUMfWXNuIGJ5deimJQeDNnggPlbNqOF3U
         KPY1zeCN13g1yEaSw/IgCvG26+rbpJnpu+DfUXEBiE8VbS5eMrGy4014aJk+NfJeZUVs
         sHkDFTdOSsZJ9OCByg9qiYxfwqgsx64M3j3qS7TG0iIF1rxxH2UNcntZdPr+vz6pVGIF
         Un4uCScu+lWUBfKv7E+LbF31whvB1lPm8SPKzo1aF8BNY8yfXjgNXwzy5pZzlsyWT3Gw
         8jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787002940; x=1787607740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y+y60PoeOcJzJyhWvC9Eh/WUb1AnWEbvZFwtNlrzZtU=;
        b=EOdVPZcivCV9Tozn2qK9WOcXp/wrG+V1jXB60FtqDVppjCqDwVKtjZYn+H9FfVT/su
         ljdvaMEXCZXrF2rkOuaW61RI6xKvpmWthEl3aUNCmq2Hd2NrFZk9JYMFmSlW4R19bjJZ
         BDc9IIYR2RVSUNVD7iaWUmYXpP4zusDuvr0hswvnucZNKRs66dZhtIBAQws41h4X8EuC
         FwYgLRHWz2IjxdiXlLYJqhBbLeaU070LO1AQ0S5xmf6+M9Tjm8mEA7T+/N7w54cmTxXM
         C8F3KiLJ3LqK+q6lNjT6t2eUFGNFRNGFfEZFB9ioBsOu2xXkfXyMDhv+8KRkNFZytixf
         rjqA==
X-Forwarded-Encrypted: i=1; AHgh+Rq84WcU/lzwzeB1DPPwUf/UPcXNhD3kMzrBjqMc75XVj3wcHrvDWIzMik5mHYjh9Gb2q1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjj55k8ItM18BrdKOXheqvnELcu2NuIQtVPMktrepH+St5LRHy
	gUFNHqomi7HfBjx7hJrwIDoT8o4H4EpO0KYyExtAYCBxHrni+P6Enp9f
X-Gm-Gg: AR+sD10aneCZuEcqUT6+vKNkqFxe+h0C/xsOXZFZp5UwNMGINv9bQXiZ2o0NLoTy7pu
	SNp08R6giKEFQL2EIqvG33wAxBcLmF9uSKKSZoTcPhEFKePfHN+OrmeB5uBe9bB3Kpb9KIVUQv4
	AeL/TX92UnmkyIGvwu4og3e2TX5yVg0fGwcTvmXYYPdjBq6N1prMj7iHjlqcGbwWuiMWKim6xhS
	Jp/bQGQH5LxLqfmS6RZcnn/wPAFoaGfiDbNn/6LYAU0D29HBHBQ1651tFitWk3HUzQJ7R4QOvkI
	CXZUpMRk/SxJsbvDE0C3RjuoFcG9z2is6WEOjQwGJuLBtA/QfWtFgbcO8qTDT7b70HQAZBh/HJP
	1rzefJj0zhSJKxAME0gk3AglYr+uipByWgUWnM08CLL51KbD+Xi8hU25Neuz83UHSdRfQNmZBjf
	IsdfQAxez3SAi9slzT3AMIPchaYSVJSR0MC9S+RI2LTsXCsd8UZupfGxU=
X-Received: by 2002:a17:903:2c0f:b0:2c7:ebfb:618f with SMTP id d9443c01a7336-2d3b0eec2f6mr336847755ad.14.1787002940100;
        Mon, 17 Aug 2026 14:42:20 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:64::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32678dd08d6sm13507028eec.4.2026.08.17.14.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:42:19 -0700 (PDT)
From: Ziyang Men <ziyang.meme@gmail.com>
To: kernel-team@meta.com,
	Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	Mykola Lysenko <mykolal@meta.com>,
	Ziyang Men <ziyang.meme@gmail.com>,
	linux-block@vger.kernel.org,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] block: expose blkcg io.stat to BPF
Date: Mon, 17 Aug 2026 14:42:03 -0700
Message-ID: <20260817214205.723267-1-ziyang.meme@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Collecting cgroup statistics is expensive: the existing method is to
open and parse a cgroup file for every cgroup of interest. The memory
controller already has an efficient alternative through BPF; this series
extends that model to the block I/O controller's per-device io.stat.

Patch 1 adds the blkcg flush and per-device iterator.

Patch 2 adds a selftest that performs direct I/O on a private loop
device and compares every counter read by BPF with io.stat.

===
Changes since v1.

- Drop the blkcg acquire/release helpers. The program reads the io
  controller's css from cgroup->subsys[] under RCU instead.
- Remove the kfuncs that read the blkg device ID and counters; BPF
  programs can read those fields with BPF_CORE_READ().
- Keep the flush sleepable. It now takes a struct cgroup * and pins its
  CSS internally.
- Make the blkg iterator take an RCU-protected CSS.

Tested on VM with v7.2-rc5. 

Ziyang Men (2):
  block: add BPF kfuncs to read blkcg io.stat
  selftests/bpf: add test for blkcg io.stat BPF kfuncs

 MAINTAINERS                                   |   1 +
 block/Makefile                                |   3 +
 block/blk-cgroup.c                            |   2 +-
 block/blk-cgroup.h                            |   1 +
 block/bpf_blkcg.c                             | 154 ++++++++++
 tools/testing/selftests/bpf/cgroup_iter_io.h  |  17 ++
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/cgroup_iter_io.c | 277 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_iter_io.c      |  99 +++++++
 9 files changed, 554 insertions(+), 1 deletion(-)
 create mode 100644 block/bpf_blkcg.c
 create mode 100644 tools/testing/selftests/bpf/cgroup_iter_io.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_iter_io.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_iter_io.c

-- 
2.53.0-Meta

