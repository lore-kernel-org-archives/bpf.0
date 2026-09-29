Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327E035C1A1;
	Tue, 29 Sep 2026 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670949; cv=none; b=hAsRwW9uXIGge+9NxuK52fAhmHU30GEPfuuXsK1P+hFd7ixRXjjLaJ7mRT5MYhgpMd2jA9EPbTbKoK4DrdFnVT9e+6SgiGDbFWQyrj+n1aQexgJ8psDkdb2bLui/jAmKuxxyN6IhqNFhTnljfdri7XEkaK6KzGuqOF/2cVrgDkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670949; c=relaxed/simple;
	bh=ISprP6wPmA53c9jR3r5vxsxu0Q8W2yHrSj6Uko//BRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pjpia1Dukj+eV/NDr8CYbNe2Gz3WfR/Ars7d7j/Kc/4Re/hH4toxzkA/5zF+OH/RFcxlp9VIkAJXp+Imvl5ggUFxQaxZOJgcUKxrKkxGD4hYjqG5GtUwLH1m/FDKLDEu+2H8XX8yW58HbLJYvpJ1LUx6oSlHRTOkcDWS1MLBqwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=T/3UYNOe; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="T/3UYNOe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=5r
	TbC2FHmDTljqlS8nFI14Yj+FpGBOm/RrUDuhusgyY=; b=T/3UYNOeZPS65RadYd
	tEIeF8M9xQQp7xfSMpCf2cWYYwBnZraDtfZCG/FFL9d+en/GgEnlz6GXXW8VSp5K
	IHbiVaXZf+ET1sn5QzdD/Q3BvQSm4cCFi3nK2XoxvqNx1cLJgAxDvi/5Y2vazMd8
	ix0iiGhFOyWXWLqcgkImStupM=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3vx8seLtq177cBQ--.12081S2;
	Tue, 29 Sep 2026 16:34:54 +0800 (CST)
From: chenyuan_fl@163.com
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	daniel@iogearbox.net,
	ast@kernel.org,
	cong.wang@bytedance.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/2] bpf, sockmap: Fix udp_bpf_recvmsg() spinning on backlog-only ingress
Date: Tue, 29 Sep 2026 16:34:45 +0800
Message-ID: <20260929083447.558818-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vx8seLtq177cBQ--.12081S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury3Ary8GF48KryUWw1kGrg_yoWDGFX_uF
	W7tr97Jw4DJFn8KFWruFs5AFWFka1xKrZrKFWjvF17Wrs8trZ8ZF4vkr93Ja4rWayxJrW3
	Jws5X34xKrWfXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb66z5UUUUU==
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAg6ycGq7eC4quAAA3b

From: Yuan Chen <chenyuan@kylinos.cn>

udp_bpf_recvmsg() re-arms its receive loop on backlog-only skbs that
sk_msg_recvmsg() can never consume: whenever the backlog stays
populated, the loop re-arms on the same skb forever and recvmsg()
spins while holding the socket lock instead of sleeping.

Patch 1 aligns the re-arm condition with TCP and unix_bpf_recvmsg();
patch 2 adds a selftest that reproduces the hang.

Yuan Chen (2):
  bpf, sockmap: Fix udp_bpf_recvmsg() spinning on backlog-only ingress
  selftests/bpf: Add a test for udp_bpf_recvmsg() with a stuck backlog

 net/ipv4/udp_bpf.c                            |   2 +-
 .../bpf/prog_tests/sockmap_udp_backlog.c      | 141 ++++++++++++++++++
 .../bpf/progs/test_sockmap_udp_backlog.c      |  21 +++
 3 files changed, 163 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_udp_backlog.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_udp_backlog.c

-- 
2.54.0

