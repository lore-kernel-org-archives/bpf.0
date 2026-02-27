Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AB93019D9;
	Fri, 27 Feb 2026 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180558; cv=none; b=ur/GGL/n2rgLU67+o/s6Oun7QE6OjYwTW6RaXZ7YGQe2Ey+hbmEmbzhTtT4Qr/qCjDDocAZTx0AIrO/O8wI53wXsJ4SypNNs0Lt4ghQmBrZCXGjNO4QDKB1ZrVTzNK6fKsYJEL6wubaRBqx7SBXmNWcBNO+qxmUjsuQaMy3rKGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180558; c=relaxed/simple;
	bh=n15ZVh+yuOZvVFW0tr5J935i5t6IIMxIk1tYWO4WMcA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PUqOgAhSYvbZ5BsS//4WZGvFZS++KCoqWEanyewXXqZ9xUdB9SNw8OPQdbMaScmvvQFXhXOPxegH6/bBTFGTYilJZpWn6lWYPdOcdCEU5uG/YlS0c79kafOFb2JYOWpw0A9qAaz26GGtvhwjgKOBI1i8PN44cfQpEM9vAVnJ1k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eLVRspse; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eLVRspse"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9E
	tGc7t4BhXs16wGg2NagQqwtRrEVw0UKxRfysY8Zvw=; b=eLVRspseSTlsXP4fvQ
	WH+UtVZbQlIxNHvXMC1/+iOKAzWzLtRMHuUeNdX7rMSlhWdLJtz0nI+jtuSVKH3p
	8VqJ8ehA2h98Mj8jQtaQpBiYP/dBiUQvgSfEJZSn9OXmNd493UWUsW1hfq+J7uDN
	xuddNXVAky5AxodCgcua4cNn4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDXP+oOVKFpNzWPNg--.30755S2;
	Fri, 27 Feb 2026 16:21:35 +0800 (CST)
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
Subject: [PATCH v8 bpf-next 0/2] Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
Date: Fri, 27 Feb 2026 16:21:31 +0800
Message-Id: <20260227082133.96951-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXP+oOVKFpNzWPNg--.30755S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFy3AFWkGr1rJFWDCrWxZwb_yoW8Xr1fpF
	WUXrZ5Ww4rtw17tFs3Ga13ZFyFga1rJw1Fgw1xAw1YyF4UZryUJw1I9w4YgFnIqrZruw48
	Z3ZYqF17Ka4jva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRFoGQUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC0BDbVGmhVBAP+gAA32

From: Feng Yang <yangfeng@kylinos.cn>

Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap

Changes in v8:
- set ret to an error code before goto out.
- Link to v7: https://lore.kernel.org/all/20260226095156.117996-1-yangfeng59949@163.com/
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

 net/bpf/test_run.c                            | 13 ++++++++++++
 .../selftests/bpf/progs/verifier_lwt.c        | 20 +++++++++++++++++++
 2 files changed, 33 insertions(+)

-- 
2.43.0

