Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A8C364920
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 21:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697793; cv=none; b=Q+StRtFWbxLQGxYXjAQWNwfmcq3/XPhUPDqGQKbpWGwwsjZdDxAItw15u/RHRe5ZjAv68xdfRWpdYvMzhsWyju47i3GPGVFAuArVn3QnAZdvYSK1/PXwmSddQTcVO3tZmitNcIFerSuz5CLIouTCe5gIilljKDBZYcjx7/tHlps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697793; c=relaxed/simple;
	bh=mYNmIwniLqao1ePR6KB0lK6iVa80HZ7QSJyI2Naf3Sc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jtsR7faJGyb8OHyubRc4Rx9O7H7ntA1oNCtzHWtMBdOrS2B+omMSHiEnVmNgRLkzeUPuREsEQ0YL070cl5etJJtYHJ/tfpIfNO4yLid65Q09K5LaimXo9Zi3Ot/ziS3mEDBzZj+DG9nUBVyCovs/m2ygzul39NIlLvHqMLWzSGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTUiVxLI; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTUiVxLI"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439d8df7620so3698335f8f.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 14:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773697791; x=1774302591; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=knw0+nMIE5dRtGKPnj9FhaPZETzHPR1czsEjx0nBljE=;
        b=MTUiVxLIs5bibH/SgNeuAtSx9sixeJ6XQ3rrLXnB9hPXYX/B/vOAG+FaamHxoDSdX/
         9o/TltRR3oydbUQIa6lwp9lov/ELBzQDcstFR08J8IzLa8zd93xaXrGurqnqyBO30oMQ
         kmGSXtExXjO3JHEHEBtPxEXSB+F/72f+vLRPHOj46KLaULeIbng0hZGAxNtQFQhaeAa7
         VZ9SVea1ubzLxJft/FWxPNaZkCbqhC6Id3cjDvDACtxaD8jFYHNO5yFzYzrscOArZw52
         XzBFKKXV+eLlvZWaAJbm6fAJ9lAdTZLvWGNssrTnGSAn4836/I/EC7ObHmAckS67oip/
         SvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773697791; x=1774302591;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knw0+nMIE5dRtGKPnj9FhaPZETzHPR1czsEjx0nBljE=;
        b=I3m0ve8bBwd3GTAytbVzj8XNnhVRb33yNxlSdGoDxJAjE0T9xFthiWn6qH2LSHNL3r
         xBj9omQZxruGn4mTsd2EQ8B/vG/ezasplHWn2DO66H0RLzNoE9u9yghRQnCnKdEpGErm
         w++9AuMC32t2ZQzdeYz3JKK6Ps20P48DcsgEqK0BTff2OMIw++hUToQOQLBHLIGmmOip
         TrUTMV4JDHew9KjZh6bXjfvXvyLtwYtJaVswaHl2EyvxzZ7eRs+FbNWYl5UWnxB3b9VY
         GPdH0nN8s0USwnKiLC1bm0J11l2hJTA6CTfB93OBEgXLigxGbVPdBlEkqeke+hhD3f/i
         GyGg==
X-Gm-Message-State: AOJu0YysG18rPccZATWV46SUSqzU4/CJsmKTU+NWyqVA1PAnTt0DU3In
	1gS//RdBL5qu64KvXioYihPGWsahqRco7sp18i7bCHSjX+GI7bvPdgtq
X-Gm-Gg: ATEYQzzIykequS4wW+47vfOBFQF+cAVrNdTwogbh4E4532NGFkIlOg7phn8XzxsqIZZ
	gn8yoaQMVqpmgKWaWT1ChJD89Xr0LUlmcMHIqVDCcviUeLfA9ar634RUzuo6Dh12vOwmqwfVE2w
	8AVMAPY8WCDjwjgp6eOU4jCAfdaq9CIBlQMjnZp3PHJ8iEqAyHt92inlus3E8STPbd9zsdWwcW5
	lrqv3X20PhJCe9wy0Uxb5Zpj54B/3N6zL1kzP+kiLVQPw9pS6xcCPSlwuwbry5OQTbW0BPVvBLf
	fxH5WUlIxXjri78utEN+o+r1ACZ3JyhBmVpZotvcZTMtLP0/c7ruPs2EaGpG/Dip+fbANKKOB2S
	wHBYzctY65xcXAlJCUeDd35BrZ6rwvz5y5KMkcMfAoS0Slgu70a6+9/O4tUDhHoCqw71d4YwsFU
	CxT+c7YXP6zdk0kVXQ3Z5uy8c=
X-Received: by 2002:a05:6000:26d1:b0:439:d750:42e3 with SMTP id ffacd0b85a97d-43a04d98b99mr26090116f8f.25.1773697790633;
        Mon, 16 Mar 2026 14:49:50 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b45e5c233sm10703602f8f.33.2026.03.16.14.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:49:50 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v3 0/2] libbpf: Add bpf_program__clone() for
 individual program loading
Date: Mon, 16 Mar 2026 14:49:35 -0700
Message-Id: <20260316-veristat_prepare-v3-0-94e5691e0494@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAO96uGkC/22Nyw7CIBBFf6WZtRgY+lBX/ocxBhAsiz4ChNQ0/
 XcnuGmiyzv3njMrRBu8jXCpVgg2++inkYI8VGB6Nb4s80/KgBxbjrxlmfYxqfSYg51VsEzVitf
 i1EnTSCCM7s4vRXkDPTs22iXBnZqewCm8y68sSv/VCvzVZsE4M7IRHKXT/Kmvg03qaKahuDLue
 OR/eCReNNq5+kwL1e34bds+XDKnsvkAAAA=
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773697789; l=2966;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=mYNmIwniLqao1ePR6KB0lK6iVa80HZ7QSJyI2Naf3Sc=;
 b=yRgyC5zQ0votDfW/5lHjpTrBpmZyi9mnSgyVtuUf1R+jN6gsUKDyFUW8hrsikdMI+SYwnnDoL
 R9gYBkrSq8ABOWUDw8cx+cY07vdbSnqMLvYFmYq+NTTFzFjgBVr2l7j
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
caller. It resolves BTF attach targets, fills in func/line info,
fd_array, and other load parameters from the prepared object
automatically, while letting callers override any field via
bpf_prog_load_opts.

Patch 2 converts veristat to prepare the object once and clone each
program individually, eliminating redundant work.

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
Changes in v3:
- Replace OPTS_SET() with direct struct assignment for local
  bpf_prog_load_opts in bpf_program__clone() (libbpf.c)
- Remove unnecessary pattr pointer indirection (libbpf.c)
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
Mykyta Yatsenko (2):
      libbpf: Introduce bpf_program__clone()
      selftests/bpf: Use bpf_program__clone() in veristat

 tools/lib/bpf/libbpf.c                 |  61 ++++++++++++++++++++
 tools/lib/bpf/libbpf.h                 |  17 ++++++
 tools/lib/bpf/libbpf.map               |   1 +
 tools/testing/selftests/bpf/veristat.c | 102 ++++++++++++++-------------------
 4 files changed, 121 insertions(+), 60 deletions(-)
---
base-commit: 6c8e1a9eee0fec802b542dadf768c30c2a183b3c
change-id: 20260206-veristat_prepare-a4a041873c53

Best regards,
-- 
Mykyta Yatsenko <yatsenko@meta.com>

