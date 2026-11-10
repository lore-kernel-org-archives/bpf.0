Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315044;
	b=G7EPZ9jwq0uIKDYsiXM4EG7/jPQpEHGVE1gKbFXHDsBpc+FEScRsIELeYAtpig2ZL2aP
	 RT18BUQPX7vdEnrOIgqoDL0tGcqMSu+vqrItDvPN6tof7daJN7uElTgZCUSQHwkvoqKtf
	 a+ksw67k4s+bTYfEw5G3HFBGQ3Lk/g+95ysfDsS1gTmCjyEQT1+dRzbvO2OKOXVuGVVi4
	 k7zZgQkWvqSC3GSZVf+B+b1cwmZEhJuyeI1cNfgfvVDeuRliL7Ui34WJaa1Y07sY5Cb50
	 J3cp9QfbSBw/PywTnmJ5qN4qF7CDQzVfwWv4pUkAi9hvXzyFw0CRDW7tOQuXnCMZ0Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315044;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JkzHOqNRmLLJHznW6kn+J0uH0vJmE5wO725J9WTQ31c=;
	b=Jvts6MR7R1HACLpk3iyyMl7Wv/ZCgOCLuYbOsfXKjrjWm6YCAGxrvkJTgcwcgwLmiCj6
	 NGWLpMLpOf4JPfi1dZtfEbbM0oq2e2+tdJ7jgb6XGwKbCfYtGf1Kh+WCOII/860Klw+vr
	 5wqaIdBgT/LuhcIDWeTympOL7F7fYg3PZ0nD6ov/iyvkE8biCbAKY4T3cq3YbgnOvn4OQ
	 qUwPPJehdGRc20MdkFdQVcxu+2BDW8wltsgz9Y+25pgBbZvOh/4Els2KJjD+i+SPf501i
	 yagAGtW5pQdAkhoaDgTCy7bL+AWLrnM9yINR8wVDtCo9/lizAQasFwJznhzVr1SRv0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=F9HvKvXX;
	arc=none smtp.remote-ip=95.215.58.70
Received: from mta1.migadu.com (out-70.mta1.migadu.com [95.215.58.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D482C606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 12:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D482C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=F9HvKvXX
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ogLChbToz8v2uGO8I5xWfeJmsMC5KE6fYOWugASNSTE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794315040; v=1; x=1794919840;
 b=F9HvKvXXxp6hhvX5pTI7BHLeTcH74VXsTuca+5AgwgtGZfYy4LMUAuufy/75HwDsQaVCZeVf
 JFDRrk8scvbEaPHtsGNn4lapk/uxttRpJNFboRSgMpreaETXJBAf4hIF+9bu58wWdi1cEA+hrLZ
 yPqlkXxVU9FOSu+mqqFbvrMw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1b6150941040aee2;
	Tue, 10 Nov 2026 12:50:19 +0000
X-Mizu-Trace-ID: 1b6150941040aee2
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	liwanwu@kylinos.cn,
	devnexen@gmail.com,
	zhaomengmeng@kylinos.cn,
	emil@etsalapatis.com,
	yphbchou0911@gmail.com,
	mingo@redhat.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 0/9] tools/sched_ext: robustness fixes from cold review
Date: Tue, 10 Nov 2026 20:49:52 +0800
Message-ID: <20261110125001.4167503-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

Hello,

This series fixes nine robustness issues in the example schedulers
scx_pair, scx_flatcg, scx_qmap and scx_userland.

scx_flatcg resets its stats baseline on restart (stale counters print
as u64 underflow garbage) and rejects a stats interval that puts
nanosleep in an error loop (a negative or non-finite -i busy-spins at
100% CPU). scx_pair stops aborting the scheduler when the dispatching
cgroup goes away mid-dispatch, gates attach on an interrupted
initialization instead of running with a half-built cgrp_q_arr, resets
pair_id on restart, and cleans up a dead busy-check whose fall-through
clears another cgroup's busy marker. scx_qmap documents the options it
actually accepts and resets its hier stats baseline on restart.
scx_userland bounds the batch against the dispatch buffer instead of
overflowing it 13ms in, and rejects batch size 0, which livelocks the
machine until the stall watchdog fires.

Verified in qemu on tj/sched_ext for-next (5b740a72b55c), same
kernel and config with and without each patch, comparing stock and
patched binaries: a scx_flatcg restart prints six
u64-underflow garbage counters on stock and zeros with patch 1; a
non-finite -i busy-spins ~17k EINVAL lines in 3s on stock and is
rejected at parse time with patch 2; SIGINT storms abort 20/30
interrupted inits on stock with the scheduler never loading and exit
30/30 clean with patch 4; a scx_pair restart aborts 7ms in with a
stale pair_id on stock and runs clean for its full window with patch
5; an oversized scx_userland batch aborts 13ms in with "dispatch
buffer overflow" on stock and survives 25s with patch 9; and batch
size 0, which livelocks the machine until the stall watchdog fires
(spinner progress collapses to ~1%), is rejected immediately with
patch 8. Beyond the A/B pairs: the scx_pair cgid-cache churn window
is too narrow to drive (40 rounds clean on both binaries; patch 3 is
graded by inspection), the qmap synopsis diff shows exactly the three
added options (patch 6), and the hier stats baseline was verified with
a clang-23.1.5-built scx_qmap run through restart cycles (patch 7,
hier stats clean throughout).

Based on sched_ext/for-next (5b740a72b55c).

Tao Cui (9):
  tools/sched_ext: scx_flatcg: Reset the stats baseline on restart
  tools/sched_ext: scx_flatcg: Validate the stats interval
  tools/sched_ext: scx_pair: Don't abort when the dispatching cgroup
    goes away
  tools/sched_ext: scx_pair: Don't attach after an interrupted
    initialization
  tools/sched_ext: scx_pair: Reset pair_id on restart
  tools/sched_ext: scx_qmap: Add the missing options to the usage
    synopsis
  tools/sched_ext: scx_qmap: Reset the hier stats baseline on restart
  tools/sched_ext: scx_userland: Check dispatch buffer slots before
    inserting
  tools/sched_ext: scx_userland: Reject batch size 0

 tools/sched_ext/scx_flatcg.c       |  7 ++++++-
 tools/sched_ext/scx_pair.bpf.c     | 12 ++++++++++--
 tools/sched_ext/scx_pair.c         | 14 ++++++++++++--
 tools/sched_ext/scx_qmap.c         |  3 ++-
 tools/sched_ext/scx_userland.bpf.c |  8 ++++++++
 tools/sched_ext/scx_userland.c     |  5 +++++
 6 files changed, 43 insertions(+), 6 deletions(-)

-- 
2.53.0

