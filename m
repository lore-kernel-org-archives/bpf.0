Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FB2379EDC
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773769184; cv=none; b=usu+VLqNAIFPvbFevsQ0fD/yfH8P4uZ5SgMULXRyDTvHW0EBq8DiFBD2Ya61pb6gRVHOEX6cGiz4ZqUtJs43tFi53ru34enYUm0cpUPHCf4LLU7wDazfOvXBX2z7OnhoREvi4yZ6Geg6mebPNzzfuO1uYlEnPwI2lj/o4F//3pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773769184; c=relaxed/simple;
	bh=LkF3qT5LXwe262USVq2sdWiqazLeZHvuIpS2bf38Gro=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k/dd0v7ldOLAat/pc6LT5kJ84rMHeBQNhb3bP1omkrjooYnA5MAb2gCba4eYC6nGQ9/R3zjyW7UoJg582vT5XWRth15YZykhH6Z69RQkvGTgQpvJfukhgdb9kP7U4KHSLugnd8CcahMEjbiIaPVq3veRxlgQN7HGWorBWKFnaLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDT3MPFd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDT3MPFd"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48538c5956bso1247395e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 10:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773769181; x=1774373981; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PIuNcplP5Fgpjz6bmiUn9/jjGndnbjG/Xx6/NlkBHIY=;
        b=XDT3MPFdc2ocNaERC1Wl3JneMajuUntGN50/z2k6Dl4SP20hjz58QLilp6+Ki8QjuB
         iehGEBdBWo8yqhI+8p1n9j36UKqK2RGlFzFi+6RG10C/ZJb14cwNVMxnFH/z52w8IoiG
         O52UytB0ZKpf82A5IINZI+/eQhmVkLgmpEB1KR8Jjm/VxrHdbIaEQiQGCoeAgLZX22xr
         fNrMTpt2xIgJrYxKlF+GeZTy9zM9xysSzZvXD1VovwxddBwU/RwyU3lhbWv8ec+QtgnE
         EZqa+zBk0LS4yNZRu8eZeOS1obuDqK8spiNMwa5BWvJzuugOM7v2Bs5umsyhTaH/A9VM
         C0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773769181; x=1774373981;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIuNcplP5Fgpjz6bmiUn9/jjGndnbjG/Xx6/NlkBHIY=;
        b=SYiKZ7mRpslUe+fdcb+mGzJYZUDvvMX3UvTar+w/sCLF/3xIsvUmWzwqnXQKbgoaA/
         Tkh5yZa88kSD7du9aaGNRk7YTI4PHtwCUKgHM9tWH31GpZUl/R/9weSsHUr4+8iK8NjR
         u/KSTKBs1knVqsunhE+HcfBlXNkZFOMSrpRxruo5sCgpcsoI2XZl/YyISsp80iX18OqE
         FxOdbD52De/mcRJ0UEGl3iOspW1vUkJqfTePvI8iw/KZpAjv3VsT3XMJAi8E9g0SQ6gn
         3UdVyCsTQUUI6SjeC1laCsIsTH85LOS3lbInVukcEoXM3nXYBjpHhEEQwMsKb1kP9mFw
         9kOQ==
X-Gm-Message-State: AOJu0YzmxI/Om7WFpEF2FEIcs6CiVrnavrQ05L+6wOuF/WgVPDgAufo2
	JgZafVC9YliKysMZQLOzoyWCDBtBiCTZ7nDufLl/Gbc825PW/+8DRXUX
X-Gm-Gg: ATEYQzxGKEDNfkRKRvjojvYpkGlM3G+axEWAMK2czX1jpeoyQdAjAioS+nVH57kfP1k
	YzBxmlk4Oc1gxMlA3nLA61FSFbs0BvjNGWpLyo/m3jfF+6p1Yx5pjkE71DSbbk6e2j4YbMpMuJ1
	gTWDY/FZAjpp1jAM0HW8MER8+uzR94P0gpNKGOHlICz2SobzuCsmqPkLJK4fNk2YaQU/+bkLtTw
	KJalW4wi5+P95H66g3IZE4ip0FsLcQDNQnkvHPqUGJsLhBPw3JZoRoCmqGdaEp8kIWNs4cvAWjZ
	B5R6q3448w0+79dtVXLuNLNcxX4UYemUbPGUHwBb50iFxaidSuTixeSBlwq2yHqxw/oaa3k+t6e
	HayS7bYlesqB/huVZEid4T4TN5y0ADt7USH9w5W3QH1y+QlBRKDt7RHlMCfWtNKDiGR0PIazxL/
	vHJbUea6bxQbeb
X-Received: by 2002:a05:600c:8b18:b0:485:38f1:5cec with SMTP id 5b1f17b1804b1-486f40aca00mr8399665e9.7.1773769180600;
        Tue, 17 Mar 2026 10:39:40 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4857f224d5asm22250095e9.24.2026.03.17.10.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 10:39:40 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v4 0/3] libbpf: Add bpf_program__clone() for
 individual program loading
Date: Tue, 17 Mar 2026 10:39:20 -0700
Message-Id: <20260317-veristat_prepare-v4-0-74193d4cc9d9@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMmRuWkC/22Nyw7CIBBFf6VhLWYYaKuu/A9jDCBYFn0EGlLT9
 N+d4KaJLu/ce86sLLkYXGKXamXR5ZDCOFBQh4rZTg8vx8OTMkPABhAanmmfZj0/pugmHR3XSoM
 Sp1baWjLC6O7DUpQ3ZibPB7fM7E5NR+AY3+VXFqX/agX+arPgwK2sBaD0Bp7m2rtZH+3YF1fGH
 Y/wh0fiRW28V2da6HbHb9v2AXqT6VH5AAAA
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773769178; l=4340;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=LkF3qT5LXwe262USVq2sdWiqazLeZHvuIpS2bf38Gro=;
 b=vEnJMAZ7EHEONzodarrWRkIuRn5WZrNXm4mnXbB0BUu0j1uD7XKkInwsMx1q+Hp3FNPwuvmtL
 LWk4e1GaHvgCb9y2VkFioGoVz40JAJimgnxcsy45SJ6dn+zDsS3UWa4
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

This series adds bpf_program__clone() to libbpf and converts veristat to
use it, replacing the costly per-program object re-opening pattern.

veristat needs to load each BPF program in isolation to collect
per-program verification statistics. Previously it achieved this by
opening a fresh bpf_object for every program, disabling autoload on all
but the target, and loading the whole object. For object files with many
programs this meant repeating ELF parsing and BTF processing N times.

Patch 1 introduces bpf_program__clone(), which loads a single program
from a prepared object into the kernel and returns an fd owned by the
caller. It populates load parameters from the prepared object and lets
callers override any field via bpf_prog_load_opts. Fields written by the
prog_prepare_load_fn callback (expected_attach_type, attach_btf_id,
attach_btf_obj_fd) are seeded from prog/obj defaults before the
callback, then overridden with caller opts after, so explicit values
always win.

Patch 2 converts veristat to prepare the object once and clone each
program individually, eliminating redundant work.

Patch 3 adds a selftest verifying that caller-provided attach_btf_id
overrides are respected by bpf_program__clone().

Performance
Tested on selftests: 918 objects, ~4270 programs:
 - Wall time:   36.88s -> 23.18s (37% faster)
 - User time:   20.80s -> 16.07s (23% faster)
 - Kernel time: 12.07s ->  6.06s (50% faster)

Per-program loading also improves coverage: 83 programs that previously
failed now succeed.

Known regression:
 - Program-containing maps (PROG_ARRAY, DEVMAP, CPUMAP) track owner
   program type. Programs with incompatible attributes loaded against
   a shared map will be rejected. This is expected kernel behavior.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Changes in v5:
- Fix overriding of the attach_btf_id, attach_btf_fd, etc: the override
provided by the caller is applied after prog_prepare_load_fn().
- Added selftest to verify attach_btf_id override works as expected.
- Link to v4: https://lore.kernel.org/all/20260316-veristat_prepare-v3-0-94e5691e0494@meta.com/

Changes in v4:
- Replace OPTS_SET() with direct struct assignment for local
  bpf_prog_load_opts in bpf_program__clone() (libbpf.c)
- Remove unnecessary pattr pointer indirection (libbpf.c)
- Separate input and output fields in bpf_program__clone(): input
  fields (prog_flags, fd_array, etc.) are merged from caller opts
  before the callback; output fields (expected_attach_type,
  attach_btf_id, attach_btf_obj_fd) are initialized from prog/obj
  defaults for the callback, then overridden with caller opts after,
  so explicit caller values always win (libbpf.c)
- Add selftest for attach_btf_id override
- Link to v3: https://lore.kernel.org/r/20260206-veristat_prepare-a4a041873c53-v3@meta.com

Changes in v3:
- Clone fd_array_cnt in bpf_object__clone()
- In veristat do not fail if bpf_object__prepare() fails,
continue per-program processing to produce per program output
- Link to v2: https://lore.kernel.org/r/20260220-veristat_prepare-v2-0-15bff49022a7@meta.com

Changes in v2:
 - Removed map cloning entirely (libbpf.c)
 - Renamed bpf_prog_clone() -> bpf_program__clone()
 - Removed unnecessary obj NULL check (libbpf.c)
 - Fixed opts handling — no longer mutates caller's opts (libbpf.c)
 - Link to v1: https://lore.kernel.org/all/20260212-veristat_prepare-v1-0-c351023fb0db@meta.com/

---
Mykyta Yatsenko (3):
      libbpf: Introduce bpf_program__clone()
      selftests/bpf: Use bpf_program__clone() in veristat
      selftests/bpf: Test bpf_program__clone() attach_btf_id override

 tools/lib/bpf/libbpf.c                             |  78 ++++++++++++++++
 tools/lib/bpf/libbpf.h                             |  17 ++++
 tools/lib/bpf/libbpf.map                           |   1 +
 .../selftests/bpf/prog_tests/clone_attach_btf_id.c |  78 ++++++++++++++++
 .../selftests/bpf/progs/clone_attach_btf_id.c      |  13 +++
 tools/testing/selftests/bpf/veristat.c             | 102 +++++++++------------
 6 files changed, 229 insertions(+), 60 deletions(-)
---
base-commit: 6c8e1a9eee0fec802b542dadf768c30c2a183b3c
change-id: 20260206-veristat_prepare-a4a041873c53

Best regards,
-- 
Mykyta Yatsenko <yatsenko@meta.com>

