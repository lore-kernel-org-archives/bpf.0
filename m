Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B4A361971
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786781976; cv=none; b=THsy4gbixiZj/7kxgAkZTHmmcKD6cKawdEwrRY1cnVH5U1RdCE+UBc7BEDuqkiMuRGnPpi8KKWri2I8iQuuadiGpPpwVGKPdI2F78LtZo7fYeymjnWv2ixAliicCQ4Wcrq1MXqkfP0AoiHDiKjhqmaoVHNxR7lA67ST5qUoOD/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786781976; c=relaxed/simple;
	bh=avNhH9r4Gfj54sTyp2Y77ITIrNRfgB8N1uQL2Dd52So=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=FxSZIGv7VcQrZUgeQZyv+921hlpFcyutZRPYQx9ZnO+JOLBij+HOaqabqb6PeTZHOPIofA0Hx3thgrYIo1ihJ4Wcx3DN7r0yNQ4yT0ioVN1IMt+azhEiGTu19FwdRiBQ1OgJKKLH/LDd/dEwthZ7mZmKrUWWi/F9SyMcK99lmYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=PNmMbJe6; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="PNmMbJe6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1786781965;
	bh=rGVdAWBCMhVj9u39/OMHIMFCjpSZfc2/hW/u+SWZRdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PNmMbJe6UMl3grqbZ9+buAj/TKk2a8iGlFAO8kEi6jdwX3Y0MBhXkE6ZM/UFbhlM5
	 ti5EeKt3EAVKu2lWXaz8KxNck6YSg0ikIUXP/RxotjZYeEMuBfjjSxJhDV7DTxLzdy
	 AmucBUhhMI6fMzirFH6cV5llciRBuKM/WznTIDWo=
Received: from localhost.localdomain ([180.153.160.8])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 4D51223E; Sat, 15 Aug 2026 16:19:21 +0800
X-QQ-mid: xmsmtpt1786781961ts9kmeqzv
Message-ID: <tencent_F41459F70D99BAB2588A4E4D60FA63D44A05@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUABXEhIRpLVEJoqpP48ZEXHemMKICFy84uHUog06uKf5c2yZ/KFS
	 KGBlylBUBwZahQWHRNL3HFwTaUrxWnpBC0Pcs4mEo818nKu0ybiRskt+x5UDHKx6YSwtH5bzwj6c
	 kGhCDDbkRM4H0UdxI/RsNfs2gpJkspdXV5isW8HvOeJ6Xu+l5Zw0A8gGZw8oavAqQ1m/bZFP05YE
	 MpM3Ptf2QTPQSrJ4HNyEt9nNnRbBrvW5luNWfNmx9gkCoUs0WVPfp1aBs/lC4HAvWRn1p8h1+REe
	 G0KK5MHC21tZ2R8R+VLoYIBEvOwhdb86baJ7TSCz/4rDsXAz18iBTB96Igr/xWFWpNJcCRW1h4f7
	 1yVC0HfSUN4zy9J8fKDnxT13XZ9+nf1LRHFOeuJin9gOW6QinyxG51CslICgU8UUqrxxWKIkXeVK
	 MbBVfpQ4MXjMoT8v0BHXSC/zrSwJvzvA2Mfn4sCs/uyjG7bjteGQb0kQhBl/ZiL9bGpwBXWxtXt1
	 R0f7/4fpgB8khoA4kqRwActjDIj5PUhf3J72m7Zcn2gM5JvMVDf7LGqsOwN2Kw6JjXqfkrMJlZb1
	 IiXnzapVfgSV0+yA0FcwHAJ1MjQ/B8Dx8cC3F60CE5xZYhrclEEgrmYs3VgPEXHZFnhqNqyzXrht
	 WPf5rOLzfcsmcGto0Cnhw/Wf11R+eqD667LcpDz9xyDuBcK8HsjXhFAwDdKWq7Up3QvF59MNs+3L
	 5F6a3oOW5y/V7NOSX6D++wcThDgparZocQQsQDqto6tBDNtzhJ+5Sog6c6/QKrd5j2WN9g58b6O1
	 e7Bu5yMOn7ZEomwbK6e6LQ2/BXjb1XsXB7X3oQg2J4sZJxbnRnR6OqvZ3ykClPh6+rQcW11ACL6f
	 G8fxkjgTgONi4Uf3njlNYk6K+YAyyokOeADF+P/lgfeWNnq6vVpxrGJD28Npm62iXiGhHAdWClwC
	 zyAokY3DWlszNnmktCZSXA//ZhBt+B9A9PAiwKFVgIA3kBZY9GDIitRWyQdzpZfTmOoyuixTGhD+
	 7w5ItZ/IqqTMa9IMPUciOHJhQRe7SB5yZgFcVLWfgh/FmHHUlrJprtmAjk+kI=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Jianlin Shi <shijianlin11@foxmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	memxor@gmail.com,
	pulehui@huawei.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 0/5] bpf: fix stream capacity, read, and oversize handling
Date: Sat, 15 Aug 2026 16:19:15 +0800
X-OQ-MSGID: <20260815081920.609936-1-shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_C919BB32458A4DAD645A68F441345B971E05@qq.com>
References: <tencent_C919BB32458A4DAD645A68F441345B971E05@qq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2 of the capacity-rollback fix was correct for bpf_stream_push_str(),
but review asked to:

1. refactor bpf_stream_release_capacity() to take a length;
2. fix the staging-path capacity leak and use vscnprintf();
3. return partial bpf_stream_read() progress on copy_to_user() fault;
4. reject truncated bpf_stream_vprintk() output with -E2BIG before
   charging capacity;
5. add selftests for the oversize and straddling-buffer cases.

This series addresses those points.

Tested locally:
  stream_oversize and stream_partial_read (equivalent to
  ./test_progs -t stream_oversize,stream_partial_read).

v2: https://lore.kernel.org/bpf/tencent_C919BB32458A4DAD645A68F441345B971E05@qq.com/
v1: https://lore.kernel.org/bpf/tencent_E69EAE29327E25B3548A9AF3F4FA289A6806@qq.com/

Jianlin Shi (5):
  bpf: roll back stream capacity when allocation fails
  bpf: fix stream capacity leak in staging path
  bpf: return partial progress from bpf_stream_read on fault
  bpf: reject oversized bpf_stream_vprintk output with -E2BIG
  selftests/bpf: cover stream capacity and partial read edge cases

 kernel/bpf/stream.c                           | 54 ++++++++------
 .../testing/selftests/bpf/prog_tests/stream.c | 70 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/stream.c    | 12 ++++
 3 files changed, 116 insertions(+), 20 deletions(-)

-- 
2.43.0

