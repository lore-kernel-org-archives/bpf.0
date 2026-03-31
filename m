Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F32D405AB6
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970722; cv=none; b=OglBGfoA3K30G3+LjuF+624XxjxcQzA3yqIXWdAxQESCaqojkjKSCAO2x47EjkXrsZ9EuiBg6ndCJBZJlsTEVxAMeLdRjn984yxUnecSfGC9mNZYZPb7hrmLTsKqsgSRnXrASpPw6ZVxVgP8YnQcYgU+zvxAZDFt69Ky8YYNto0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970722; c=relaxed/simple;
	bh=mdj+JZHtkLBhk+fcPzmcDizZkZVrlPDkUqbVOyoytxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KBYgjNrVxqtPgt0mSIhIAer/4wXnzEzcy6wvsU7NDwD3A/hcOGBPmETRUyDVISWy47oY9El46NftCYVScyS4i5w46l+krJm9qaik0jrIn3NzLBJJ8sRq3uaFhb9isBbm/tticLYEcRq9ZeX3zpNpRkww+5MaRXX0LoMFUwYHstU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TNDazeUQ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TNDazeUQ"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-661d20c9787so7809620a12.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774970715; x=1775575515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ro62eebBDFoVJdcd3sYnIMKDqKbb3O6Im7sU1GaKrA=;
        b=TNDazeUQ/rTX/qyE2C7OACicq2evhj4gvT7V3j00yWf0zX1YT9JlmLpYSp0iPWij3F
         Ay0vSjHyzrRmYMrBcsla2OftrpcP+J27bNbBbeZ+ytHAXmNtnBJEwOQmWZh4M0MmydgB
         8pWXj4tfVkSF83hOqgbtyg4o2Ej2JDO2/0j81x+E2lghwhKm748QODOCt6XteZYlcbjz
         BxWs6rrlDWfSpln4GGPXkZT9aAc2cM7qCmnb4n2EFBFq/3Q8UlDL1u0aF+/gyld3g264
         ISPCURl6H6CvOvOrJn5nneODXZp2yrOb7Zz54gzt15GZnb2OajTpCwJKh0eBNaz7U4DQ
         qpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774970715; x=1775575515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ro62eebBDFoVJdcd3sYnIMKDqKbb3O6Im7sU1GaKrA=;
        b=kgV6CcV5csnGtwVqjA4KQcg18E1PNZ+rCvvNU/Nd95lT2fVRb1B2Xg9+nRbVBEIzDA
         iWkcWqKc37KTU9ukuD2FQRPFR2KN4TjpkrGwnTz4OeyEn/Cag0syzxMR4AWNID2pBFIw
         j1nFZn58myX3q1ioBN5JQplX3ox+7Zoi8igjWLNAYYrndIeu4KDCXsPPBmXBxrVNVxGp
         Jj1BHJNMWO0L5IVbn7zQYhxaJOgJgrbeu4m9TPjyb+40rB1ARZ9prBqw3wnJLpByBP/r
         jvHEe9a/PQJNaZ5rJlR3YLqxBaT4bFpSMfq5BjO+PDhqPwZYdBAzx0RiUfyafdTbUPfU
         /nTw==
X-Gm-Message-State: AOJu0YwwSERGccPm/5Rv1F6HQ06nkxu3w5XUUEu9VFUS5xIyr9/bnunU
	wgcmVg6ZpDQIYw4n5wVS7oPL0wZFMPNF5WS7I82OPcm06nJ9c9MNez0YHI/o8vqQUg/tJXl4v/S
	VOMmLs0o=
X-Gm-Gg: ATEYQzzR8ZPBccZDAFZWvjoSs5HcE4C0obdFU/aNOy2k8TBCeBP/4MuIFXOmmhl2eP5
	A7QjN16t0pmSmDorJjekOfHsIgSS/mFY/VDSGLEJpdetZiB3wTaek6LxL5X+LJQELkIoLyk0pCb
	8XZK/nhkvXcVAch2DUFIm2CQPXKhPQ3EhyiJ9kK+yf9oQSo5IJuogQEwi/8kopZuP6SMVxmelDX
	fkfZGqtJiuEYxgBtT8Klq3FFeieIya3xNleXM2T24tFpj0bxzrsxXe9j5tnnkiy0Ss5yuPPjUzs
	7o93y0IKRniBrOyYeAX0EX8aMZqQu4Ki3JV1xJJRvRYezKK/nMVXZP1N9ZsG6Ft5vWuPlsa36cq
	Td/L4YofX4cmjNwkiZ8Wqc5kKkvT2LAjwNH6k6X1xGJVhewyoYYG/ApMR9NG44hx8WmiB2Wy9ln
	jOtN1DR566MTLsuCO00IS8oPl6CVg/eE1USFkkzjQIqdfDxER5Y2DqxWd/FAWT0g==
X-Received: by 2002:a05:6402:50c8:b0:66c:36a2:73be with SMTP id 4fb4d7f45d1cf-66c36a2742dmr1829709a12.8.1774970715241;
        Tue, 31 Mar 2026 08:25:15 -0700 (PDT)
Received: from f16.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dba558226sm1264003a91.2.2026.03.31.08.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:25:14 -0700 (PDT)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 0/2] libbpf: clarify raw-address single kprobe attach behavior
Date: Wed,  1 Apr 2026 00:24:34 +0900
Message-ID: <20260331152509.70468-1-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Today libbpf documents single-kprobe attach through func_name, with an
optional offset. For the PMU-based non-legacy path, func_name = NULL
with an absolute address in offset already works as well, but that is
not described in the API.

This patchset clarifies this behavior. The first commit clarifies that,
for the PMU-based path, callers can use func_name = NULL with an
absolute address in offset for raw-address attach, and makes legacy
tracefs/debugfs kprobes reject that form. The second commit adds PERF
and LINK selftests for the raw-address form, and checks that LEGACY
rejects it.

---
Changes in v4:
- Inline raw-address error formatting and remove the probe_target buffer

Changes in v3:
- Drop bpf_kprobe_opts.addr and reuse offset when func_name is NULL
- Make legacy tracefs/debugfs kprobes reject the raw-address form
- Update selftests to cover PERF/LINK raw-address attach and LEGACY reject

Changes in v2:
- Fix line wrapping and indentation

Hoyeon Lee (2):
  libbpf: clarify raw-address single kprobe attach behavior
  selftests/bpf: add test for raw-address single kprobe attach

 tools/lib/bpf/libbpf.c                        | 21 +++--
 tools/lib/bpf/libbpf.h                        |  3 +-
 .../selftests/bpf/prog_tests/attach_probe.c   | 82 +++++++++++++++++++
 3 files changed, 96 insertions(+), 10 deletions(-)

-- 
2.52.0
