Received: from mx.der-flo.net (mx.der-flo.net [193.160.39.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9376E3F2114
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.160.39.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777652168; cv=none; b=f+Dt/Op0IIjwuqbxgWRqiYkmHWfE2XqgwYitKojZXjiMpDkudRWzaFSHvQpNEuF5GnRzmPTjn31MPE9aclM7huW8bKn9RA2LivqA8XzoTgN/TcJ1Efcrp27W5ujJ+0arc4hJh23XuUiGnTJeBn70ELHM9JII3rn2TkZGbH91V/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777652168; c=relaxed/simple;
	bh=wndAzVybXdecmRF6y5uRZdwAfuwbJxNPn9i+p8A/etU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gzWp/iMkeDPUD2l7+MJsPZflF/arNyjVjJvJJmLsbJjy5tyaCVyVQ3s0UZlOdZCudCm/hVf2ky+6cqOuh2tmoPQaxB1oFyJna+nqbWFIQcPxa4KkBknJHaJkH13JWoQIFV5lwc+Qm6wIRY2uNZXQJx5StPltTcwxolSkUt+4m3M=
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
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	sdf@fomichev.me,
	sun.jian.kdev@gmail.com,
	Florian Lehner <dev@der-flo.net>
Subject: [PATCH bpf-next 0/2 v3] bpf: Add LINK_DETACH for perf links
Date: Fri,  1 May 2026 18:08:59 +0200
Message-ID: <20260501160901.224134-1-dev@der-flo.net>
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

---

Change log:

v3:
 1. Introduce bpf_perf_link_mutex to guard against concurrent access 

v2: https://lore.kernel.org/bpf/20260304210212.235096-1-dev@der-flo.net/
 1. Drop LINK_DETACH support for iter
 2. Add test for LINK_DETACH for perf event links

v1: https://lore.kernel.org/bpf/aJOhPoTLdYnZmHYA@der-flo.net/

Florian Lehner (2):
  bpf: Add LINK_DETACH support for perf link
  selftests/bpf: Test LINK_DETACH for perf link

 kernel/bpf/syscall.c                          | 87 ++++++++++++++++---
 .../selftests/bpf/prog_tests/perf_link.c      | 79 ++++++++++++++---
 2 files changed, 140 insertions(+), 26 deletions(-)

-- 
2.53.0

