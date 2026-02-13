Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C65E2206AC;
	Fri, 13 Feb 2026 02:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770950779; cv=none; b=kvSZVpHi+NNE1lG3PobzD7fPsH8IpF9u51M1GiWehGPd2iEF6z/uy6VXsUbLtAJfeXSE2eaCvzgXC3/xgLc/qWM2d+JqgR7dSTI/DNe14lf1jZOhHmH6SyPYuaZi/51jr9NQU2VahG7GAYwCt8AXfN9ydodeKcWqNOZDeJFrl+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770950779; c=relaxed/simple;
	bh=/rCKtZu4uT+a7bxC/0dAzdSZHaz5X9coZL7XHuDvdb4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fgcBJrlj/4mSm68bCr6KupTcCom9fSnzJVa4pAuZ3xZOTrzTdvjEVejitTrSF0svYXRjaWy8/le2Eg+ql3ZG9k/GgUI9phtDaPD5TUlEJO5nfqH0RTCkuoueHNP3tZkrdo4UVAS6GABE4HrMNtzPLi3p/O+VUq0tGPndy87UH9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nnxI8R8c; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nnxI8R8c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Gh
	+bNkrUmdUhkkCUMlDs6LepAgG9fyimpNq3kzowW54=; b=nnxI8R8cPdFdUTi7qt
	0RIatyw560LGGdNf0MYhXvyj/DWQoB053kxkgWrOce1TLWetAu55EHeW/1wPC/SA
	00JeMkqHmws0zldDAz+6MQq4Y2PlwILwyrJANddscdJA3LADpZxfJhJM7kCbGg+N
	bNzUN58o5q0I4gLPNN4r5gE44=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAnZNoNkI5pvhZSLw--.1343S2;
	Fri, 13 Feb 2026 10:44:30 +0800 (CST)
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
Subject: [PATCH v6 bpf-next 0/2] Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
Date: Fri, 13 Feb 2026 10:44:27 +0800
Message-Id: <20260213024429.39972-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnZNoNkI5pvhZSLw--.1343S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7GF47CF1xCw4fWw4kAw4xZwb_yoW8Jr43pF
	4UXrZ5Kw1rtw1xJFs3Ga1fZryFga1fJw1Fgwn7Aw1YyF4UZryUJw1Ikw4agFsIvrZruw4U
	X3WvqF17Ka40ya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRFoGQUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC0A8lnWmOkA8yKwAA3G

From: Feng Yang <yangfeng@kylinos.cn>

Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap

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
  bpf: Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
  selftests/bpf: Add selftests for the invocation of
    bpf_lwt_xmit_push_encap

 net/core/lwt_bpf.c                            |  7 +++++--
 .../selftests/bpf/progs/verifier_lwt.c        | 20 +++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.43.0

