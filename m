Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535B13B6348;
	Sat, 11 Apr 2026 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775925434; cv=none; b=J+/BCGhjZ0XmEM7Hwz9GMKwyl5uJ0wae9NAleogE/OCP+9dBFioonrNEv50MgWG0vU6adbKBkA9TmQV9jXLxkl53seSA0ZWYpSJP0nyjRMTZysn0FB8eHBs7Cw5JyHf5f3fMoCHAc1JtK6OSicDdNfl38yJN/Ff5I6HgOt3aAOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775925434; c=relaxed/simple;
	bh=iEYTN/i0ensRxHCR3PWp+UZvvmrgLHYp6XBloHadzyM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FXyLSLoCBNR7SqHg6E6K1bWJ9vo6/m9/FK3yeJ/mayNmqLlXWeL8TVXRDrowtAhHoe84RXhGE/x1moVqYM4mpm8x5reLSuPvDpgvIE1GD+XMI7JmKZMDKWxUJBWh9dRIJUrEiBRLj477BP3CG3MJJtgqGSExTJAg6xSFF23bSbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=i95X4gy1; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="i95X4gy1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=avNQzUN3cbjiD4n
	aA3fIjqUVtalOyi0zej3JABA4QTE=; b=i95X4gy1hl7F9820go7RdYE/qbcg23/
	uNVSJcO6nHrV/k9DitCE/ESb3iAs1ihza1g1Sa/TQiPy3eX8Mn8iEkZtcli1BSGK
	ErwXwCKzHiJioriEj6FTDOPKkmsINqfUYDcY6UMagaBBXmKm8lhnKlw7c4zhiDg0
	HKj8PUObvfok=
Received: from yang-Virtual-Machine.mshome.net (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAn3n9ueNppX_iUEg--.31671S2;
	Sun, 12 Apr 2026 00:35:59 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	jiayuan.chen@linux.dev,
	leon.hwang@linux.dev,
	menglong.dong@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Feng Yang <yangfeng@kylinos.cn>
Subject: [PATCH v3 bpf-next 0/2] bpf: Fix Null-Pointer Dereference in kernel_clone() via BPF fmod_ret on security_task_alloc
Date: Sun, 12 Apr 2026 00:35:54 +0800
Message-Id: <20260411163556.8567-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wAn3n9ueNppX_iUEg--.31671S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWDZry5KFWftw4fKr4fAFb_yoWkZrc_ur
	4Fq34rtrZ7tFn8CayakF47GrZ0yayfGr4fAasxta43XrnrXr1UKF4vqr95JFy8W3WfGrWa
	yF98Cas5trnF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8v_M3UUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8g9KwmnaeG-w3QAA38
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

From: Feng Yang <yangfeng@kylinos.cn>

This patch set adds return value validation for fmod_ret
to prevent system crashes caused by incorrect return values.

Changes in v3:
- Do not move the code, and make some formatting changes. Thanks, Leon
  Hwang.
- Error injection always ensures that 0 is a valid return value. Thanks,
  Menglong Dong.
- Link to v2: https://lore.kernel.org/all/20260410061037.149532-1-yangfeng59949@163.com/
Changes in v2:
- Add validation for fault injection and include selftests. Thanks, Jiri
  Olsa, Jiayuan Chen.
- Link to v1: https://lore.kernel.org/all/20260408094816.228322-1-yangfeng59949@163.com/

Feng Yang (2):
  bpf: Fix Null-Pointer Dereference in kernel_clone() via BPF fmod_ret
    on security_task_alloc
  selftests/bpf: Add selftests for verifying return values of fmod_ret.

 kernel/bpf/verifier.c                         | 114 +++++++++++++++++-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_fmod_ret_return.c      |  59 +++++++++
 3 files changed, 173 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_fmod_ret_return.c

-- 
2.43.0

