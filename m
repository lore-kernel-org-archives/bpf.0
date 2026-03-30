Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5C040DFB4
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 03:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774840889; cv=none; b=TUhXa2HwHnZTwYlN3YjdwBPjSe57g/7S+O5S1bxQzNTbuuJ3Aub2rVrqcypWlXg11ztYEB6YOkNtQklqnVqwhsZkXROmIxN61szsGGQnkh2AMOQwIlEQjKAeNjt454MIjPIVuBvnBHSR0Z4Xju5IY7GhMEwCb/fSbBYtsM8dWK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774840889; c=relaxed/simple;
	bh=GuTd4SRv8M3QGnccT/n6noay5kjQ/Y0ziO7lhZo8fsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=smbly1asE7rqici/FNgBqY0d0UarKqiwKA/MRfa2UFEjFehn6/rn/4IVWUEccjEJ42r5qbSxap0C69MTY/d+s7ELLxyqZLfxq9+x9MpnwxyvzhiEge/1YJj3TP4r6itKz2GKTWbzlCtfl/edlcbJN5ELkgHWFyGjorul45+MSHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5JZE2/u; arc=none smtp.client-ip=209.85.161.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5JZE2/u"
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-67c641dfaceso1281576eaf.3
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 20:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774840887; x=1775445687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ASstvuVCZrE796IcgYJRgSOC2UHZFW57/0chrQoWC8g=;
        b=M5JZE2/uC89qy6X75NmJ0Cbc0BsSFsew8/hKbc1+LFFOnNsLaH8tNVhhj1HmbHtUvA
         dLw8C/pBMipa0jsn8afupWssQJMaLYP+eIo5ACrS6ZdPeQFrojF2yE7d4RQu3m9CXB3a
         ftwwFLQQvjAYb+NHaw4ia/Wd8MjdYGvfS5V3ZypRfItpGBiqXLNL7aTMglz0+rIcftcT
         mH/Cxr1WgLbDsmvI4YI/lDRTYGTXxxV/crToDZkTyaiYquA5PdcBlUgfm2kAu/FkmAD9
         VeKvW9QG/1HjJg91Ti3Cf9MenBky6wESArzVVKD2AexsISuO389CH07AWkQsuJoPspl4
         VNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774840887; x=1775445687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASstvuVCZrE796IcgYJRgSOC2UHZFW57/0chrQoWC8g=;
        b=ckneeqNGc3LoCFwrvF2WND41gn7VQyav1DUPZpHidNG2/9LnKD8CZePg6VwIjQ7MQH
         JadeEgEhk9aJy1lWD71CUfrHYvZG15M2RgH/nBfR8oUcV4pq+HiiYKI8DOgDhpYwDtFQ
         +PO8K6GLW5SP1/vaQ1XRvdwmoQQbnXTS0RJhnALZjPDXIXKOcU7A4LgzmzWMQ1DvAe6g
         dEaN0Uru/8Q5ijXsmiwfp9DVAl4X70htVZl7GHo3xqtjNHpHVCLPB5ECM8VLCm9T0sQu
         sqGYVxnxR1NXpamoQmNTWExSGehlginJsEOAN2Sh+OCEaHSkZm3avaHrlW0wz8tmNyMd
         v1pg==
X-Gm-Message-State: AOJu0YzXf64u7g/9y6Jyma+BFsuMKZt10iBQdB5PMDTht8DZpDVaZPK2
	uqZxaxA9NRQZKMQ3me4GX90ShTr1jV0ez7y+s0teTZqSmii4YJLcdYUa/SsDZdGKm54=
X-Gm-Gg: ATEYQzwBCRPkQLJshSiSBgq3zMVmy1JabFWkcESK2yfEbpfM02qJ6nQeABgjmdxFz3V
	2Jq+NNGB5zFvt5e13bG3kHeTvTsFeKWSyYBHR/sCMpU3pqOP82e55iK5IgdSVwZjHYrgerT20gy
	zyUN62BFm6FMp4C+rVA4PkL5Q+IWgUzPQcFK1Fl3M7jhyYyEdOGfc3prkrqkhWUK037hfL+tCxj
	FxGFFKwRiSeb/Pz1WGgE1UHtwkUdPxUvO2jdz6+y0xWT3X7GtQMw72F3QU5lMW2pXkyFm5czxOE
	qKFbaU7m5+ZK87kpEisNEM/ZUueYNOokGuP66umfjOf2BND/uPKLeGAil3JSCgqmu1BQDMJ1MBU
	eYh4SmIgtgGK+gYu6nd9EFX0MIe6arlqYZURitBfJRAwvCKpBawqNBSQS3uUX6Y7M6MZu+PJHfY
	R1DYXHQErB2kZve0xUWqiliEgx0kFMPGNypQpQn7m2hkrE
X-Received: by 2002:a05:6820:4c0d:b0:67e:160c:36a8 with SMTP id 006d021491bc7-67e185f74f3mr5706434eaf.1.1774840887026;
        Sun, 29 Mar 2026 20:21:27 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e2d510bd0sm2321381eaf.8.2026.03.29.20.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 20:21:25 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 0/2] Fix bpf_link grace period wait for tracepoints
Date: Mon, 30 Mar 2026 05:21:21 +0200
Message-ID: <20260330032124.3141001-1-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=812; h=from:subject; bh=GuTd4SRv8M3QGnccT/n6noay5kjQ/Y0ziO7lhZo8fsc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfPkG86Js3TqfFl01Df5fnwh/E6j9aD8vO8er20fTDGYdjOy XLy4o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNRZGD4n8Gw8vnvpsNsj/q+zRI1qR PKiIuZq6BWU7Ax9UTknqXTkxkZVk3mbmC3Krkms2VKxJIrtrNmfmXluOWx9GVizKpPexm3MwAA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A recent change to non-faultable tracepoints switched from
preempt-disabled critical sections to SRCU-fast, which breaks
assumptions in the bpf_link_free() path. Use call_srcu() to fix the
breakage. While at it, retire rcu_trace_implies_rcu_gp() and clean up
all in-tree users.

Kumar Kartikeya Dwivedi (2):
  bpf: Fix grace period wait for tracepoint bpf_link
  bpf: Retire rcu_trace_implies_rcu_gp()

 include/linux/rcupdate.h   | 12 ------------
 include/linux/tracepoint.h |  8 ++++++++
 kernel/bpf/core.c          | 10 ++++------
 kernel/bpf/memalloc.c      | 33 ++++++++++---------------------
 kernel/bpf/syscall.c       | 40 ++++++++++++++++++++++----------------
 5 files changed, 45 insertions(+), 58 deletions(-)


base-commit: c369299895a591d96745d6492d4888259b004a9e
-- 
2.52.0

