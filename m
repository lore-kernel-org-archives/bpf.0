Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315115;
	b=e+7obEkHLA8L92iEUVCC3Mb1C8QIw5yGGpsS6sUTnkLq3KNXfYC8qfONfTb+K4e3wH03
	 bLd0b3ar8duvMJXWvFrewoIsBHdHMWCkwErhtIXapMGAbAxn140sqcplFJ4KU41EU2YBQ
	 jSH9uAA+ibXY1Z1R8ZSIuYhXtHuvCq5KQeH5ENEsd3dJlgnAEk3MwYW+WoPZhNt0YMZio
	 V0SbJC7E/KNyG4meKQY8i8JsaixusjNJpfwnl0+5j0o13icxRDpGXcSVyoHXQ24P07VLR
	 SJYY8yEdMo9GfVKqq/L12ocikX3etEx28Avk6zhG2hDlm3UQ7TXomGJQ1gz/Dz1rccA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315115;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NTyrgE/NhXynhM9E29qnV24j4tJQyNRVjWGGUarqaBw=;
	b=ptb2eTtEa+Yb3NnXtyBQQttORR+1NAzciVf7fshI65UVcBJC85uAhwNq22RisAFDUDvf
	 f/InZtHgcR41x8oND9ofWORo4s3MmZAhYMbL5XwLqvU1W5Vih7LsECmFmQG32elX5e3GK
	 dvBrhfH+eVKMRFNkl4Lf2M+umbmEQl6UMCiZBwUt2qYLIZDxhb+2tGoH2aVG91c8eDY3G
	 2tz3OCmP71GI1OasN0vaAMl2HW1/OPsc8B8xJcM1Ecwe8nJON/8pvpGGH/SsabSS8/h87
	 nwuuBG5+PuPbNIlJxvri4L/viRoOb68kFhfDUnCFDwnupTcPVorixlmT13U0BouYq8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hFpWf8yL;
	arc=none smtp.remote-ip=91.218.175.178
Received: from mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92E560A2603
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 12:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A92E560A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hFpWf8yL
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RSQqPLCzjXzhj+yupFqjdMSCPLeZDniTWxY3yX5md4k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794315112; v=1; x=1794919912;
 b=hFpWf8yL6oDW6NM8mtVSFMeRx7ackcDZIx2TXPgmfnP7JapwXw8H7ZJnu7sdJ3iMvZ9hGaAa
 7wkZMbsiH22HGm+8PcCw/yrkJWPxXtl1gI1mQ/FkTmK2abJ4JhAZW49r5eflssC9OL2SxaKYaIs
 1P5UA4418lmP3F0DfPoqZPLI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 47c838edafd7a544;
	Tue, 10 Nov 2026 12:51:52 +0000
X-Mizu-Trace-ID: 47c838edafd7a544
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
Subject: [PATCH 9/9] tools/sched_ext: scx_userland: Reject batch size 0
Date: Tue, 10 Nov 2026 20:50:01 +0800
Message-ID: <20261110125001.4167503-10-cui.tao@linux.dev>
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

-b 0 is accepted silently and leaves batch_size at zero, so
dispatch_batch() never moves a task out of the vruntime list into the
dispatched queue: tasks pile up on the vruntime list while
nr_scheduled stays positive and ops.update_idle() keeps kicking cpus;
the system-wide livelock ends when the stall watchdog kills the
scheduler.

Reject a zero batch size at option parsing.

Fixes: cc4448d0856d ("tools/sched_ext: add scx_userland scheduler")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/sched_ext/scx_userland.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/sched_ext/scx_userland.c b/tools/sched_ext/scx_userland.c
index b16b6db5f365..cbd511685449 100644
--- a/tools/sched_ext/scx_userland.c
+++ b/tools/sched_ext/scx_userland.c
@@ -364,6 +364,11 @@ static void pre_bootstrap(int argc, char **argv)
 		}
 	}
 
+	if (!batch_size) {
+		fprintf(stderr, "Invalid batch size %s\n", optarg);
+		exit(1);
+	}
+
 	/*
 	 * It's not always safe to allocate in a user space scheduler, as an
 	 * enqueued task could hold a lock that we require in order to be able
-- 
2.53.0

base-commit: 5b740a72b55c4267ba4d8010f17dde26b26f52d3
