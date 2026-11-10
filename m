Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315087;
	b=Opb0XsNsi0VgnOaHRzguTjUutmULBwPdDfsyN/xfTmwn4C/+8RMETMp+IoRY+0tW0Jwg
	 boi9uWivVFgjdC9A84j4tvZLgf6NWEgBG3ez6sxcWA12hulBIxdZn2gBji2Jw6WHw6Gu3
	 K9fAv6Uxf+bBU2yjYCXpewqT3GkTfMwmweNW5ewjyXA2E1OZ+3DMWVAhVZHU0ae+U8Vno
	 htMloEySVhqoLLV//Yy1UTXrcEMS/xvKYILKmUppJV+shFIMrTVUaWqDOgozPtqKYEWaz
	 DuJvudJ65GxinyuZ3BlCLgiFnzqJpT2++/JxOW6iHAZZhJe30Z89xsNLlSFDj8JA3UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315087;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YtUog58RhMWjgehHF7aLMPWxr8semA4Q1u+XbhAMUSA=;
	b=C8YiyZ+vrDbkeVqG6YgK+eNjKZ8xopLrP7kDXbix2bzqZFqLhnPbbIp/aBueG5ScOXfT
	 MeuZX5MI0ORxgQ9v4ZoWJlXn677poWENHGDvv8CIS/vosNn07idg0Q61Tbwo9jz49klUZ
	 fdWkmaE+9W1jH31IZ58kfVAfW1qSRh4vlTQBC6kkNlh1ApVJpN7g6T2sxwOXkbN1yHgOI
	 BS9KSNRNkU8KOVE8I1shlLS8xthBGAYE61i5mjYBytaT7zZFsFPv6ss1dWDyd3louZdlQ
	 qRc1HoW1oIM4q7GTNwWJubcDZrEQr5nNASBQ6gVyXZBZhRPfnu3+hVhAwlh8X1ZegXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=P74bo2ZZ;
	arc=none smtp.remote-ip=91.218.175.150
Received: from mta0.migadu.com (out-150.mta0.migadu.com [91.218.175.150])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97EB60A2603
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 12:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B97EB60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=P74bo2ZZ
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=y+OXQ3R1bQ6Jl5nULn+5Yppe6hOkihdq++4CRdIcUFI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794315084; v=1; x=1794919884;
 b=P74bo2ZZMEAHqxp2P3Y0AU23JIQa0uaMINXltVUoYy7M6ILA94f7fpuJtESNSh+QxT5e1qaf
 cxDSnisjCkMvtQ8aTUTdOPWBsXGnStGg6QZR7HitLWUe7DGmfgi7Mk8Qr1SrBncipXpilmJJeSV
 EUJdb29gZ9Fq9hpltyV1EjtE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dc7b68f0a2315fc4;
	Tue, 10 Nov 2026 12:51:24 +0000
X-Mizu-Trace-ID: dc7b68f0a2315fc4
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
Subject: [PATCH 6/9] tools/sched_ext: scx_qmap: Add the missing options to the usage synopsis
Date: Tue, 10 Nov 2026 20:49:58 +0800
Message-ID: <20261110125001.4167503-7-cui.tao@linux.dev>
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

-C, -B and -q are described in the option list but missing from the
usage synopsis. Add them.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/sched_ext/scx_qmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index fe2f206f5c8a..f44802247069 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -47,7 +47,7 @@ const char help_fmt[] =
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
 "       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I] [-X]\n"
-"       [-F COUNT] [-i SEC] [-R MS] [-J MODE] [-v]\n"
+"       [-F COUNT] [-i SEC] [-R MS] [-C MODE] [-B PPT] [-q US] [-J MODE] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
-- 
2.53.0

base-commit: 5b740a72b55c4267ba4d8010f17dde26b26f52d3
