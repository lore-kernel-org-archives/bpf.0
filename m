Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315055;
	b=Iee9sUJhlUaP3DLHEPH2bpVtm8IdQu4m+JFmGehyXvBnRkYaNzjdiuJ9FctjSpv3SiR+
	 oW4T+ZXZVdxhZ/4vqavR1m5S8iCcgCXajjNy/vlK4lSh1mqqPOaAlvmuRWfhg5456AvGn
	 Kvvaroni/eaXE4vaxdz+pYSjyR0AiBkXS4KE7i2VVhjAZNrhO82QmTjTGkIryWSGitlD4
	 oWV1eQyu/5lqVd/P1wLXm+4q/5lBgvUo/8e3PLvo0BrB8PcBi8s/u9ROzQ0WKDUQYE43S
	 1vsqorz7o6sgcusuaGzTAuy/P38hfHCnkiKE/Qe8sEOB5viAKo+GEoXBC3hIE+G4ZJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315055;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JqXiUKs5xunEl31xUYALni/1QyfIISL1eBxWiwiWH30=;
	b=umFl3rVBYmhe9X9xx8op5VBVzbpC6r7rPzJr2eLNBZbIVfPZeV8spSydwbObWNc3Wt3N
	 RTuE3i9rhb0ipg9LwVVOHO2bcnoqrnlaC/MohDnQHsRuuKKbxqyymrUB9EIrDmr2D5Bsh
	 N78wgNd1a64pBkr1leBY/JFqxLgnV/046klhRkDkFTpokKdmMyHPpuGJCBOTk36PY899P
	 gLlY/Oij/u39hsfv2/qfO9H66jvysTKCSZIVF4bxMUmh3i6t2qMGtCm2FyGnIUCdk5G3G
	 Fg+c4FKbdflLcLeOWASmTC1ySbyDy8pk76KU1VJWhsnD0lQ2j6QNUGVAf8qXwWPnPuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qcdZfq6E;
	arc=none smtp.remote-ip=91.218.175.123
Received: from mta0.migadu.com (out-123.mta0.migadu.com [91.218.175.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7487D60A2602
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 12:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7487D60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qcdZfq6E
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6hiWiOyIu+LHqUNivb0i4YRtYJKUmtW8lpp6XsqXing=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794315052; v=1; x=1794919852;
 b=qcdZfq6EG7aERpqoy4mpB94kLhY8jjW7FhLOil0+gCfBTz4IfjFK1lBSgpr75uSwqV2TheRr
 tR+I5FOR8krZ3PxdkuYsg/1JTFs01+vtgRLrTyJzHk2zbWkmQOw51Vu5UeG8yaDdxUTzqMYr07w
 SG8FWtWyEfC4lz1SLl71K04U=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 865760993d19670e;
	Tue, 10 Nov 2026 12:50:52 +0000
X-Mizu-Trace-ID: 865760993d19670e
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
Subject: [PATCH 2/9] tools/sched_ext: scx_flatcg: Validate the stats interval
Date: Tue, 10 Nov 2026 20:49:54 +0800
Message-ID: <20261110125001.4167503-3-cui.tao@linux.dev>
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

The interval is parsed with strtod() and split into a timespec with a
float cast in the middle: a negative value produces a negative tv_sec
or tv_nsec (for -0.5 the seconds truncate to zero and the nanoseconds
go negative), and any value that doesn't survive the float round-trip
(e.g. 2^24 + 1) produces tv_nsec >= 1e9. Either way nanosleep()
returns EINVAL, which is never checked, and the stats loop starts
busy-spinning at 100% CPU instead of sampling at the requested
interval.

Reject negative intervals up front and compute the nsec part from the
double rather than through a float so the rounding hole is gone.

Fixes: a4103eacc2ab ("sched_ext: Add a cgroup scheduler which uses flattened hierarchy")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/sched_ext/scx_flatcg.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_flatcg.c b/tools/sched_ext/scx_flatcg.c
index 4c3c2cca2b85..bac6535fa2f0 100644
--- a/tools/sched_ext/scx_flatcg.c
+++ b/tools/sched_ext/scx_flatcg.c
@@ -158,8 +158,12 @@ int main(int argc, char **argv)
 			break;
 		case 'i':
 			v = strtod(optarg, NULL);
+			if (!(v >= 0) || v >= 1e18) {
+				fprintf(stderr, "Invalid interval %f\n", v);
+				exit(1);
+			}
 			intv_ts.tv_sec = v;
-			intv_ts.tv_nsec = (v - (float)intv_ts.tv_sec) * 1000000000;
+			intv_ts.tv_nsec = (v - intv_ts.tv_sec) * 1000000000;
 			break;
 		case 'f':
 			skel->rodata->fifo_sched = true;
-- 
2.53.0

base-commit: 5b740a72b55c4267ba4d8010f17dde26b26f52d3
