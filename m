Received: from mx.der-flo.net (mx.der-flo.net [193.160.39.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FBB37C934
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 21:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.160.39.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772658757; cv=none; b=ny6l/JJOlPtpmkGqNZTQHalnxNjgrH8EZgB9u268rWaAM96CtMHX/xgS2Vj4Ke6b1lLR602DVbOxttaTcs6GvCiI3nxF2e/VqLFzsyQcf0ml0/rlpiTuJnpd0v92fegtcOo2tpTN0LOKnEFECqPox0QLRQxeIR20Fka1gGzt0vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772658757; c=relaxed/simple;
	bh=TBnht2ASL/gC993wfs2dH26zhksReK3fb8ecvvb7hn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U7FT3f1OPoM4ct3Y7pimmQukBiEmi9b5qUIopkya0nIAxXoPXz3xLwOUGRSQuRcCSbiT8BlfpI//BTPOEpuv56wmJ1nX/SnP7BAerNCzDun3rnwrLcqTXtGg8mzRCoEfL9MCNbi0oZgWmTKmj7oIlBUb+y0CTrCi4SV7yA6IUfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net; spf=pass smtp.mailfrom=der-flo.net; arc=none smtp.client-ip=193.160.39.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=der-flo.net
From: Florian Lehner <dev@der-flo.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	Florian Lehner <dev@der-flo.net>
Subject: [PATCH bpf-next v2 0/2] bpf: Add LINK_DETACH for perf links
Date: Wed,  4 Mar 2026 22:02:10 +0100
Message-ID: <20260304210212.235096-1-dev@der-flo.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

73b11c2a introduced LINK_DETACH and implemented it for some link types,
like xdp, netns and others.

This patch implements LINK_DETACH for perf links, re-using existing link
release handling code.

Changes since initial approach [1]:
 - drop LINK_DETACH support for iter
 - add test for LINK_DETACH for perf event links

[1] https://lore.kernel.org/bpf/aJOhPoTLdYnZmHYA@der-flo.net/

Florian Lehner (2):
  bpf: Add LINK_DETACH support for perf link
  selftests/bpf: Test LINK_DETACH for perf link

 kernel/bpf/syscall.c                          | 30 ++++++-
 .../selftests/bpf/prog_tests/perf_link.c      | 81 ++++++++++++++++---
 2 files changed, 94 insertions(+), 17 deletions(-)

-- 
2.53.0

