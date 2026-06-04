Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DB637E301;
	Thu,  4 Jun 2026 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780542683; cv=none; b=Gt2+4lW0fYjqM7iDBFbTQlYUJX0shv3tCDM+gCV0isZoE+qmm5LZlvBWq4lcmDW+Gc9gJERNQjwuAPEsiCBHfhUXQPMG6EM112Txio+Tf4wlbC3f0Ug6v5plTi4KyaBXVW60FJaNWB5I7ap6+mU6PYKtnY/SzuFIByjhLKcjwoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780542683; c=relaxed/simple;
	bh=4u3P6eG5AlHDzcX5xWxnVzrjgKTxy3EUloB/JA8skOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7A8Zj7FBs/ZyezyT9+jGDmkUzhvcEkUlqRxLvM/8RlE3b/sYSbutz5XbXyM1qyWQvzSHsyXvlmPOEx5xvwSYKswS4xjP0BXJDx9xeLYz0/a8d3VQv20SyAYK1Qp+6sBWVpHEcXpaSatQFWsykPPGG4N8yErc5azwQGKtaC8g0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LVOZEvTl; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LVOZEvTl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=p9
	uIKlC4kSMx3kAAe9donaGNQUBxl9Xks7NRFbdcZwA=; b=LVOZEvTlw4owN7zu+D
	08bjsg4yc2GpGrTeShCgD/LAgcRnV5QDmhHTB9YDB+zRDjdHM0GTCqsdCFU711Ft
	8p8fWpmgj2W893qM1xq72ViJjCWi7X15RpsfZcRJvD44tCSJV9ZiWm7RwoNtVCvl
	zsrzvJddIVVafVj7psnzB+Mrg=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCnNjaz7CBq76U8BQ--.63531S2;
	Thu, 04 Jun 2026 11:10:44 +0800 (CST)
From: chenyuan_fl@163.com
To: chenyuan_fl@163.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	chenyuan@kylinos.cn,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: [PATCH bpf-next v2 0/3] libbpf: fix implicit BPF token handling in loading and feature probes
Date: Thu,  4 Jun 2026 11:10:30 +0800
Message-ID: <20260604031033.806727-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529031604.888137-1-chenyuan_fl@163.com>
References: <20260529031604.888137-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnNjaz7CBq76U8BQ--.63531S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1kXr4Dur48Zw1UGry5twb_yoW5Gr18pa
	93C34Yyr4DJFyIgws7XrW7u3yF9rn5Aa15GryYg347Aw4UKay7AF4fKa18ZFnxJrZYq3y5
	X3yYqrZ8Cw4DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pizBT8UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5RQLyGog7LTADQAA3t

From: Yuan Chen <chenyuan@kylinos.cn>

When BPF programs reference global variables (e.g., struct_ops
programs with global data), libbpf creates internal ARRAY maps to
back them.  This depends on FEAT_GLOBAL_DATA, which is gated by
feature probes that load test programs (SOCKET_FILTER, KPROBE, etc.)
into the kernel.

In a user namespace with an implicit BPF token, two problems arise:

 1. bpf_object__probe_loading() passes the token fd to test program
    loads.  When the token's allowed program type mask excludes the
    probe types, the kernel drops the token reference, causing
    subsequent struct_ops loads to fail because the token object
    has been released.

 2. The feature probe framework uses probe_fd() which returns 0 on
    BPF syscall failure, and feat_supported() interprets ret==0 as
    "feature absent".  The token rescue path only handles ret<0,
    so the probe failure is incorrectly cached as a missing feature,
    and internal maps for global data are never created.

Together, these cause struct_ops programs referencing global data
to fail verification with "fd X is not pointing to valid bpf_map".

This series fixes both issues:

  Patch 1: Skip bpf_object__probe_loading() entirely when a BPF
           token is present.  Token creation itself proves the
           kernel BPF subsystem works.

  Patch 2: Add BPF_MAP_TYPE_ARRAY to the token delegation mask for
           struct_ops selftests so global data maps can be created.

  Patch 3: Fix probe_fd() to return the actual error code instead
           of 0 on failure, and add a token-aware rescue path in
           feat_supported() for ret<0 cases.

Reproducible by running the implicit token tests with struct_ops in a
user namespace (tools/testing/selftests/bpf, test_progs -t token).

v2:
- Replace the workaround of granting SOCKET_FILTER/KPROBE permissions
  in the token with a proper fix at the feature probe level in libbpf.
- probe_fd() now returns the actual error code on failure instead of
  0, allowing feat_supported() to distinguish probe errors from
  genuine feature absence.
- Add token_fd rescue path in feat_supported() for ret<0 cases.

Yuan Chen (3):
  libbpf: Skip bpf_object__probe_loading() when BPF token is in use
  selftests/bpf: Add ARRAY map type to token tests that use struct_ops
    global data
  libbpf: fix feature probe failures for implicit BPF tokens

 tools/lib/bpf/features.c                      | 23 +++++++++++++++++--
 tools/lib/bpf/libbpf.c                        | 10 +++-----
 .../testing/selftests/bpf/prog_tests/token.c  |  6 ++---
 3 files changed, 27 insertions(+), 12 deletions(-)

-- 
2.54.0

