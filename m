Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315063;
	b=OKafVUk0ubXAuCUfGmjqxzsWU7SepugHqizNLn1ic1vEnp3VT6rO7PWhl5F473ibp8mE
	 KUthOUgZAGvky0zXUYIFp2aMTybcMzdwGt6wXOE5UNQ/0IyFR/A4QvRkLUOuKFdmGMrLa
	 IVbe0oIbAilAxddrS9ucxm2weBmphw+5vDVMm6c3SXa6Z7o7+LmfqzvQwP3vCNLXWtmTe
	 VO7ZlEwevMYhhFt/W7MA+Ry/IXvGhtxqKlcciDIZLCu3u/C8re7E9BGdyPnxqf02YTppz
	 ZGYPJbf50j77YH6GY8yOJxX7EGBuKB4fdN/0LyGXCpK4tdYZOx2ev6AwQRBEiSKUC5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315063;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pHWIyoAzkRKGt/Ae6HP4k4i1zKiGCLCBeF2M5OsTr4k=;
	b=K2G3/nTCwrILJw+aojSPsZ6LUgC2vXjf+TX43An1B6StTxXIrnSH7HI+Z2TwqNYwFf67
	 vdp12AJCOHeKee5bipQiNCZBCyo0YvX0iNHXIuoWEh+MAXStxqTONhT4M6/mZBAc+GjpC
	 2D5miCFdWi+yCDwg1D7vRIlQkaYJa1i8MdZaQOouNwCNBfOVZo16whkZvn30h3cK70o3k
	 917OdGdmQhdwEfpofSq1B9txpTnm04P77Pnsro6mYg7R4zlH5otsdUxORuzRPsKugerD0
	 YqL8dfnXnA4EaLGv6JzK7M51i1kEwTvu18BDzru3gUVvwhOh8KHV1r/jHEq3Uw70ahw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="nnfwV/FY";
	arc=none smtp.remote-ip=95.215.58.105
Received: from mta1.migadu.com (out-105.mta1.migadu.com [95.215.58.105])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5379960A2606
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 12:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5379960A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nnfwV/FY
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DkQ2NcU3+tFcoDyU9HG1mfFsUe9Q7GZ8wrWu60m10JE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794315060; v=1; x=1794919860;
 b=nnfwV/FYx3qYdyug5kYFoaPZFnh3XlKO7fAIR0r/P8PEpWRwQvaN9fEHMV8PxsDcsqvvunx6
 kKCqScY5gD1sbMtF2rVkzyAa01VLI/5gNgLZ5zIttMDaueHFEn3P+7W7LZhPL0mUp0anFZbGQPn
 r/Pd82iqMfIkvg0Jo0fjJ7OM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 776503cc40e57f66;
	Tue, 10 Nov 2026 12:51:00 +0000
X-Mizu-Trace-ID: 776503cc40e57f66
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
Subject: [PATCH 3/9] tools/sched_ext: scx_pair: Don't abort when the dispatching cgroup goes away
Date: Tue, 10 Nov 2026 20:49:55 +0800
Message-ID: <20261110125001.4167503-4-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110125001.4167503-1-cui.tao@linux.dev>
References: <20261110125001.4167503-1-cui.tao@linux.dev>
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

try_dispatch() caches the cgroup id in pairc->cgid, drops pairc->lock
and then looks the cgroup back up in cgrp_q_idx_hash. pair_cgroup_exit()
deletes that hash entry when the cgroup is removed, so a plain rmdir of
the cgroup that is currently being dispatched, a normal event for
short-lived containers or cgroup churn, hits the lookup failure and
scx_bpf_error() takes the whole scheduler down.

The expiry path already knows how to re-pick a cgroup; make the fast
path tolerate the disappearance too. Mark the pair as drained on lookup
failure and return, letting the next dispatch expire the batch and pick
the next cgroup instead of aborting.

The enqueue side is left for a follow-up: a lookup miss is reachable
there in principle (css offline runs under the cgroup mutex alone,
and a sleeping-task migrate-out does not take the rq lock), but
handling it gracefully needs somewhere to put the task, which on the
enqueue path means a fallback queue; that is a larger change than
this fix scopes. The dispatch path, where the miss costs one skipped batch,
is the cheap half.

Fixes: f0262b102c7c ("tools/sched_ext: add scx_pair scheduler")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/sched_ext/scx_pair.bpf.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/sched_ext/scx_pair.bpf.c b/tools/sched_ext/scx_pair.bpf.c
index 0d61b7b812db..d38d3a078ade 100644
--- a/tools/sched_ext/scx_pair.bpf.c
+++ b/tools/sched_ext/scx_pair.bpf.c
@@ -478,8 +478,16 @@ static int try_dispatch(s32 cpu)
 	/* again, it'd be better to do all these with the lock held, oh well */
 	vptr = bpf_map_lookup_elem(&cgrp_q_idx_hash, &cgid);
 	if (!vptr) {
-		scx_bpf_error("failed to lookup q_idx for cgroup[%llu]", cgid);
-		return -ENOENT;
+		/*
+		 * @cgid can disappear from under us: pair_cgroup_exit()
+		 * drops the hash entry when the cgroup is going away.
+		 * Mark the pair as drained and let the next dispatch
+		 * expire it instead of taking the whole scheduler down.
+		 */
+		bpf_spin_lock(&pairc->lock);
+		pairc->draining = true;
+		bpf_spin_unlock(&pairc->lock);
+		goto out_maybe_kick;
 	}
 	q_idx = *vptr;
 
-- 
2.53.0

base-commit: 5b740a72b55c4267ba4d8010f17dde26b26f52d3
