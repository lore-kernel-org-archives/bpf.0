Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B6F39E6DF;
	Thu, 26 Feb 2026 09:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099606; cv=none; b=K4ybx9vfHIQjpnnp6G9SSpoOovbU+bUoeo3QHlJm+H9OvrBGPnb2879TcqwPP76a892iXuX6s7wyXeiTQz6abJK6qZFEtqCh4kSEIy7ezsodLe5F0HxeIGqfGNwRVglXXdhEWWDGPoIucUBbfbUHUpSvkN+z0BVEvZIi5ZplHgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099606; c=relaxed/simple;
	bh=llCPO0uSJH2qWmykYfPuWbwVXy4JkcDIo/11S1mHjrw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S5nx2xHlzwYVQ+aoShfx6Gz2/osYGn7Wj8VSjCg58RhOxbEwEsrg+EKRI4AGPsGbj60hggTwOCjXi0P79FZkvlCbHknl4a3ANx9TLKzRHa+YvCzqMaf8zKKTSIMxroBbC551uv0N8XqONVWMDnwLvRIjQxSDWC21kubYAmtSPR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=X5S/hs3R; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="X5S/hs3R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Df
	L+rrYNUWM8BnAIFHzkE6xE4Bzm+X7I9UubBhiQMpY=; b=X5S/hs3RddBgmcyKWP
	7pM8+Ff33p5/vacWE/xzctrFN1/FfkMw82BjXgfm5MQBEiTDWR5HnReVxYZ2476K
	nbf0ttyMdQRX1GBBPy4EFXIgpz4oYoPBUbIe7AEZJKohALSuN/Bxh17Q7uWnv4BS
	vOuyWYwt4Vj6uINeGj7dV3W3I=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDHcY68F6Bpat7wMg--.59449S2;
	Thu, 26 Feb 2026 17:51:58 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	posk@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	yangfeng59949@163.com
Subject: [PATCH v7 bpf-next 0/2] Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
Date: Thu, 26 Feb 2026 17:51:54 +0800
Message-Id: <20260226095156.117996-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHcY68F6Bpat7wMg--.59449S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr4xAw45Jw43JrW8XFWUArb_yoW8JFWfpF
	WUXrs5Gw4rtw4xJFs3Ga13ZFyFga1rJw1Fgw17Aw1Yya1UZryUJw1Ikw4YgFnIqrZruw4U
	A3ZYqF17Ka4UZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRFoGQUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC0B5372mgF75bpAAA3J

From: Feng Yang <yangfeng@kylinos.cn>

Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap

Changes in v7:
- Use ip6_null_entry to avoid. Thanks, Martin KaFai Lau.
Changes in v6:
- Modify the bpf_lwt_xmit_push_encap function and add selftests for it.
  Thanks, Martin KaFai Lau.
- Link to v5: https://lore.kernel.org/all/20260210090657.86977-1-yangfeng59949@163.com/
Changes in v5:
- Refer to the bpf_lwt_xmit_reroute function to configure the dst parameter.
- Link to v4: https://lore.kernel.org/all/20260209015111.28144-1-yangfeng59949@163.com/
Changes in v4:
- add rcu lock
- Link to v3: https://lore.kernel.org/all/20260206055113.63476-1-yangfeng59949@163.com/
Changes in v3:
- use dst_init
- Link to v2: https://lore.kernel.org/all/20260205092227.126665-1-yangfeng59949@163.com/
Changes in v2:
- Link to v1: https://lore.kernel.org/all/20260127084520.13890-1-luyun_611@163.com/ 

Feng Yang (2):
  bpf: test_run: Fix the null pointer dereference issue in
    bpf_lwt_xmit_push_encap
  selftests/bpf: Add selftests for the invocation of
    bpf_lwt_xmit_push_encap

 net/bpf/test_run.c                            | 12 ++++++++++++
 .../selftests/bpf/progs/verifier_lwt.c        | 19 +++++++++++++++++++
 2 files changed, 31 insertions(+)

-- 
2.43.0

