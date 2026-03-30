Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3A23C3425
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868448; cv=none; b=Vu1Z0mKk1NJ1A/VkXzv4Pu3qj+MpmE1NjLB7M/+qzft97ve/01J+xsNGGn05tRwfFKbjrKFUeDsdrEaWHyhQntw5E95TK/CbJQfcNnk6/n7lTjys8liB4BBGK9x3yxTgzg/Pnv+UNwdjG8JA5IPqIST1Mioi8l1A8IcGkv0wbmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868448; c=relaxed/simple;
	bh=xu22hXxENG5+7ISZCZBZWaL0rePpZJvIa7gHYUby6qU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C+Nnkz7XsCl39QDAeYtW5zXJn4+59y4+O5pFRLT6PHGLcEx6wfamIar7EWwXOXZri02W8ls7EufpP+e/svkVkQqSl87QCtqFAd+QNTVYClK5UwrSn63JAGqU5oraPXT9Nsvv0Cqi7ERHU5Q2e/e22YnCjAHUH6XNioExc9jMyQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsWE6Tmp; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsWE6Tmp"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82a73593410so1660864b3a.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 04:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774868445; x=1775473245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5YJw5O4ITdQfRzqrBC8AtnB4A1sx6rS7Up8805z3lkg=;
        b=MsWE6Tmp78Q61gCXCSSsEmNVdMtH9b4+CxoUdx2ySf3jI4AXexxYHM8nO4EWtF+Eic
         9ZPyCaJQXoelxQxs5d5oaet/RaSssmq59W4n4ZEuww5iD/T8L4yOWAg88dMuIKtr9/c3
         iFdgaYG1TYxBKQFXX3zTBejwl++29YNYrdsDf1sbcus/INnaivOEU/7I+ItdQZAXI6Z4
         /RvbAYpBAKVL2cwW+KVgwq6Es3ijoq/GATswhzXKvFwA/M83IPi9ysIZEcoAMeh26Eew
         yL2euI4VyiNSN5ZLFC+BtnHeztdLzOFCcMc/guPR/CLXE5O8ApD6IJsPCg8ruRIAE0DA
         yhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774868445; x=1775473245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YJw5O4ITdQfRzqrBC8AtnB4A1sx6rS7Up8805z3lkg=;
        b=L/1JJnUBpx/z9fTWkzwMqfUCaX9w6pWgy1BPDyvpwgmrfumyZ71CeNGyUp+klw4FN3
         41WDMwox7Kre0kL8AT6w69U9KN2Wuq+qL9qX8sStqh/dvsCCXiZQPl6bqmAz7RlbNIEt
         sFHLVPZ/1kNtNyLVWDiRqSPdvX9lV6EcMQmavu7WlK8e92MlPPO+gBK1diBqq+idjaQk
         jwCGp8xOIT1FeEr5jE3S5nJiBy9vKQLB7rA60Xv8EF0Gm5mLHwPBvLxliNL3Gk2htF9/
         42y9WUwJI1fXwh3L7uvz2nxbomxKqbmZuknfV3axtjqBnmToCPQa/N9n5k49YwIYZ24O
         JwvA==
X-Forwarded-Encrypted: i=1; AJvYcCVhYL8LmFjfaYvN0lg9R53cwe4KPBpRAkDXf5DxSwAVU3Ngqki+8pPWMiWdyiRkkl1tO6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Nzw6OipCpUVUoC2ubcSWlpBXi+eNJmR2pgaUNKmruzVWQAaB
	wp6bGDRdpZn5SlBHHtZUceSfEXj4h+FQLU6zQctorEFxjTBAf7GbNX85
X-Gm-Gg: ATEYQzyeLPjSu+txv9KE5lZB8CyDd4dp3JMW86H41i/1Ei+RXYgxYWtV45GJTdGmpd5
	fEPFvgfgGqWIk4v3K8u9hWrQeGDEjKo8sL0EFExyYkHLv3TZDZg8/btDLU5I9jmtQG5/XCSA2DD
	1CBO23sKr8T85muj858tjxyAX+PZ8zPu5MsNwfJwQOeINuUwpDpwQ+4lq/ymNDqItFaZEZQ0uPP
	SHGpmRoIMaCIefbWXdblEMLaGpQcJD89qmLlWzn6Y10XzQr7HMtryJyh07Fn1RbvlXblFqrn15r
	yQiDlvzjEuIpnG2jdwJ+6EUpPsLZ5ft7ihD1+Xnr9XgtQRK2jsSbhYrK98652GDZLpsxS13Yt/T
	pZ6/T1DgtGFYA2x7WtE0h6dLGBASbyZy4kHlxOSy/B6hsZc+m3jBYTDdWibqt9+rXb9oIdHVYdZ
	Tdc+U9tG2pa6fbwcK0woKlJfyUll/HlnmvMnxiDooFefvLwYIpqkvPbRhWY8SKZGQUEeyfevDG7
	w==
X-Received: by 2002:a05:6300:210c:b0:398:9b42:69f7 with SMTP id adf61e73a8af0-39c87b6167emr10810813637.39.1774868445136;
        Mon, 30 Mar 2026 04:00:45 -0700 (PDT)
Received: from eris-fedora.iitr.ac.in ([103.37.201.189])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917d843esm6806615a12.29.2026.03.30.04.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:00:44 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: andrii@kernel.org,
	alan.maguire@oracle.com,
	yonghong.song@linux.dev,
	song@kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	puranjay@kernel.org,
	bjorn@kernel.org,
	leon.hwang@linux.dev,
	varunrmallya@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next v2 0/3] Upgrading uprobe and kprobe to their `multi` counterparts.
Date: Mon, 30 Mar 2026 16:30:16 +0530
Message-ID: <20260330110019.549079-1-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This RFC patch explores auto-upgrading standard uprobes/kprobes to use the 
multi-uprobe/multi-kprobe infrastructure when applicable.

Background:
The BPF token concept allows privileged operations inside non-privileged 
user namespaces. However, attaching standard uprobes and kprobes 
currently relies on the perf_event_open() syscall, which is not BPF 
token-aware. Multi-uprobes and multi-kprobes bypass 
perf_event_open() entirely, attaching via the bpf() syscall instead, 
making them compatible with BPF tokens. 

To bridge this gap, the goal is to switch SEC("uprobe") and 
SEC("kprobe") to use multi-uprobe/kprobe under the hood. To maintain 
backward compatibility for cases where singular uprobes are explicitly 
desired, this patch also introduces SEC("uprobe.single") and 
SEC("kprobe.single").

Current Implementation:
The decision to upgrade is made in `bpf_object_prepare_progs()`
(According to the feedback received in [1].)
If the kernel supports FEAT_UPROBE_MULTI_LINK,
we intercept programs with section names matching "u[ret]probe" and change 
their `expected_attach_type` to BPF_TRACE_UPROBE_MULTI.

A similar thing is done with kprobes, but I had to add a new
FEAT_KPROBE_MULTI_LINK to the kern_feature_id struct along with it's
implementation similar to it's uprobe counterpart.

Just one selftest had to be changed for uprobe but quite a few had to be
changed for kprobe. The decision to change them have been explained in
the commit descriptions.

Some Observations:
- Earlier, I noted that uprobe and uprobe_multi are equivalent. I have
  found out that uprobe_multi does not support versioned symbols such as
  those in `tools/testing/selftests/bpf/progs/test_uprobe.c` like
  `SEC("uprobe/./liburandom_read.so:  \
   urandlib_api_sameoffset@LIBURANDOM_READ_1.0.0")`.
  I believe this is something I need to fix as well to be able to support
  versioned symbols. Right now, these have been excluded from
  upgradation.

My questions:
- I want know if the conditions I have placed for FEAT_KPROBE_MULTI_LINK
  to be true in `probe_kprobe_multi_link()` are correct. I feel like it's
  incomplete and would need some more things to say definitively that
  Kprobe-multi works on a particular kernel (especially with respect 
  to the error value like that in it's uprobe counterpart.). 
  I would really appreciate suggestions here.

- I had to exclude sleepable kprobes from being upgraded due to tests
  failing. I want to know if that was a good desicion.

- I had to change the `get_func_ip_test` selftest to `?kprobe.single` from
  `?kprobe` due to offsets that were added later (after prepare_progs
  ran). This means that anyone using `?kprobe` along with offsets will
  have to change things which is not ideal. Is it alright if I exclude
  this class of SEC_DEFs from getting upgraded ?

P.S : Sorry for the incredibly late v2 on the reviews for that patch, I
was unsure of the changes I had made and wanted to thoroughly verify
things before sending them out.

v1->v2 changes: All suggestions from Andrii's review on v1 were made as
well as support for kprobe upgrade was added.

[1]: https://lore.kernel.org/bpf/20260212152013.17351-1-varunrmallya@gmail.com/

Varun R Mallya (3):
  libbpf: Auto-upgrade uprobes to multi-uprobes when supported
  libbpf: Add FEAT_KPROBE_MULTI_LINK feature probe.
  libbpf: Auto-upgrade kprobes to multi-kprobes when supported

 tools/lib/bpf/features.c                      |  37 ++++++
 tools/lib/bpf/libbpf.c                        | 114 ++++++++++++++++--
 tools/lib/bpf/libbpf_internal.h               |   2 +
 .../selftests/bpf/progs/get_func_ip_test.c    |   2 +-
 .../selftests/bpf/progs/missed_kprobe.c       |   4 +-
 .../bpf/progs/test_attach_probe_manual.c      |   4 +-
 .../selftests/bpf/progs/test_fill_link_info.c |   4 +-
 7 files changed, 151 insertions(+), 16 deletions(-)

-- 
2.52.0

