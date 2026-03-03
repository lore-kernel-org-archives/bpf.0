Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1662E19ADB0;
	Tue,  3 Mar 2026 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772523953; cv=none; b=CJhQX6LqHYds4KRvNsNlqBHQ1PgW3pg92azsy1BjhSWLmY8FdXuqV5xuEpUoCLdE/0lTUHEk5VUiMSFsYN7l9b57pjLYguxTbAGOFCkmkLYZddoI/D2mDyikzlWdCPIHjdyixjIPL5Ze/8V4aT5iqgta5qoveTvDEFAklQ5Eaw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772523953; c=relaxed/simple;
	bh=JcT6Vuk6IBGItqFne+4NFBnVHG8Z6IL092qFr+CzfS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dNSSU9HyydLRABcdiPZxmbdUW5MJJZzdVNSw5I72tyf34rYs7hu805WZQtay1dy2BDMtZbB05XULAlVi4x2CG7ykl66DvEv4bcriwuXiQivW4KvVdiOPb7vxk/a/vIMAYEVj9AdKh2aOUJC/z+vGUsbmBnGH3m0lLHylGnwvcBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QzeRMdh1; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QzeRMdh1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=eY
	+B3cDhG8+rNSI1GO8l6hlD+TscEQKdG7eXyN6EK/Q=; b=QzeRMdh1AXSDS+TjIM
	jei4T5BYtrc24YmoTjQsEvRguTajnAa4z4dGNopy8LONY1wN+TkQccvRyR0NfglE
	3Is5Z5kqWyAWQeO+KbW2RHryYIuVwNpW6d0dI+Fqy2/lfUiOIE2tYOVqur4TG6mi
	TtE1wQQ3zKX3mF7gli3fs189Q=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAXXjhXkaZpm2IBPA--.46718S2;
	Tue, 03 Mar 2026 15:44:25 +0800 (CST)
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
Subject: [PATCH v9 bpf-next 0/2] Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
Date: Tue,  3 Mar 2026 15:44:21 +0800
Message-Id: <20260303074423.172680-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXXjhXkaZpm2IBPA--.46718S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrWkAw17KFWrtF4UtF4kCrg_yoW8Cr17pF
	WjqrZ5Gw4rtw12gFs3Ga13XFyFga1rJw1Ygw1xAw15AF4UZryUJ34Ikw4YgFnIgrZru3yr
	J3ZaqF17Ka4jva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRY-eOUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8hp+9mmmkVpYRgAA36

From: Feng Yang <yangfeng@kylinos.cn>

Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap

Changes in v9:
- Use dst_hold() and skb_dst_set().
  !skb_dst skip.
  Move all changes into the IS_ENABLED(CONFIG_IPV6).
  Use #if IS_ENABLED(CONFIG_IPV6); otherwise, a compilation error will occur when ipv6 is not enabled.
  Thanks, Martin KaFai Lau.
- Link to v8: https://lore.kernel.org/all/20260227082133.96951-1-yangfeng59949@163.com/
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

 net/bpf/test_run.c                            | 17 ++++++++++++++++
 .../selftests/bpf/progs/verifier_lwt.c        | 20 +++++++++++++++++++
 2 files changed, 37 insertions(+)

-- 
2.43.0

