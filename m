Received: from out-zbxj-a65.jellyfish.systems (out-zbxj-a65.jellyfish.systems [198.54.127.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8CA30C631
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710080; cv=none; b=GVrb/CPSVBWJMHinI/MyfAaM9pidNbVvaqBroCZKXae+soAV3aDqWwprFnAdPqtXskODjJwFFdDNhKMoPe2DBwy5QANFyHxwTSTcLc7aoK0k8CClDGj4n24/ymctEEJeDTK3bOHq49oWqMvbF8tXu9eMemIuZfADk6KhSIU2Y/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710080; c=relaxed/simple;
	bh=RTbslgCzA8AjVE3C6qCMc9s8cp5BuQ+k3k2tEpWYDUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GegU3vPZKi/aen5mL6tR68RSn44Sg7tTwfX2nF3giSW1/Lxtx0uZ2eoXamf2MPomNGFTiD8slM7911T13mzXY2YZSTm8adx7+lWqm1gpj3+/oli8G4fzFGDUexvDdkEadEvajHHbPzxCf/RvbUd+CDwCZ+kda7scaALw29b+vq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=gQUu3Lg1; arc=none smtp.client-ip=198.54.127.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="gQUu3Lg1"
Received: from fedora (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdFBY1BZvz8sWR;
	Sun, 06 Sep 2026 15:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788710074;
	bh=RTbslgCzA8AjVE3C6qCMc9s8cp5BuQ+k3k2tEpWYDUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQUu3Lg1s5ZP1UsbTToG9HPwTfs/lg3rFH567tnEDNC2zCaOGpzcguo/FX9mEaiL7
	 jfOtb+/7l5VfC1ohAU4kNuQQhWSxgvlqaikvqn22ngtcm1YFEBBujFskpHusdQlQbM
	 pk5Lfvj62l2z2I87x+JXA9cK1mDlpF83OPds1Yj82KtSjZendLB5e92M6SNw5ICw46
	 Xwv+lbO8CV4312rOw2owHnLRBotwHQQuQO3x7gHtmPeAJfiHnAHDGpoog/lfjWZHgH
	 5SZRb1SkFDWrZpPZdVMq3Vu2Frj3zprGIZfCsBp/5p7Ob0eTQbPpqiM0EG6qGUKw9K
	 QX5t/wwaQNBlw==
From: Tianyi Chen <hi@tychen.cc>
To: bot+bpf-ci@kernel.org,
	qmo@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com
Cc: Tianyi Chen <hi@tychen.cc>,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	mason@kernel.org,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 1/2] bpftool: Add recursive map dumping
Date: Sun,  6 Sep 2026 23:54:19 +0800
Message-ID: <178870998583.979169.16759811603821704437@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <c7c61d154f13c45ee2007e3162e9b36a4886e624d5bfb19fdd0793a100347d30@mail.kernel.org>
References: <20260906143950.848769-1-hi@tychen.cc> <c7c61d154f13c45ee2007e3162e9b36a4886e624d5bfb19fdd0793a100347d30@mail.kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Thanks for the review. Both issues are fixed in v2:

https://lore.kernel.org/bpf/178870998583.979169.16526173782819097354@tychen.cc/

Per-entry lookup errors now retain the existing error markers and do
not abort the dump. This covers PERF_EVENT_ARRAY, including when it is
an inner map, where element lookup is unsupported.

Traversal now queues deduplicated inner-map IDs and opens, dumps and
closes each inner map in turn. It keeps the selected root FDs open and
requires only one additional map FD. Unchanged outer entries retain
their inner maps. The documentation explains that IDs are resolved when
visited and that concurrent updates mean the dump is not an atomic
snapshot. Failure to open a queued ID still returns an error and closes
the JSON containers.

The series adds four regression subtests: ordinary and nested perf event
arrays, plus JSON and plain dumps of 64 distinct inner maps under
RLIMIT_NOFILE=32. All four fail with v1. All 12 subtests pass with v2 in
a matching-kernel VM, with zero skips. An injected ENOENT at the deferred
inner-map FD lookup also returns failure with parseable JSON.

Best regards,
Tianyi
