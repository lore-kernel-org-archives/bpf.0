Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D723E3EA957;
	Wed, 22 Jul 2026 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706512; cv=none; b=YdGk1Nqxaqk3OC3q+6AnICw0mrd2GHYwcQyai1Ep5B5NFAjus7j9bQqJmno2G3dT0RYiK+8hH0wMEDFUDLUZSdI4Nf49sP6xekbK/ILQFJD4HWMTqkHHESz7wiExM2c8DvRn1Ynfbjy0gAfKhLz3kBMwmZXQTmHaTrBSTGGhfz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706512; c=relaxed/simple;
	bh=QvG+xwOUkOx5072NpzEiF7ViiGduh02bEXPwt1OcaEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e214o8l4nIEyHNbfqi5oThFXcXwFFGjCorj7aexoAIs4JA6Em/PHzW4IYZVni9j43+8Y7wElWlikAfkkmzblWNkH/3u6x6QDYummLYod43o/v25PoqIAS6GthxH2VH1/Aa0V23N45L4JKixIHu7mPHy8L7LK1jIEFkmHplTV1go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fwpw4UOB; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fwpw4UOB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=2N
	dblvZF4ElFANGxPOwhji3ZARePtW2qQbbW2BeIdmA=; b=fwpw4UOBcdJGibw9jV
	rYhlGcPKbJnmK+WTUUduJecMq24vuYOnY0P9Hjyp0WkabFpiheDHTK3wJ3BAAMl/
	Gex8BHKdvWHRmJ+CyXeFfVlpuJMpa//S/4Kp438E6V17RtQtZ4ZfV3HFQgVVKeBK
	9Cbv/6ZQ1wYL0pFAmdua2DNOg=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnrw+kdWBq8DkpJA--.55057S2;
	Wed, 22 Jul 2026 15:47:49 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 bpf-next 0/5] Fix several issues in test_progs.c
Date: Wed, 22 Jul 2026 15:47:43 +0800
Message-Id: <20260722074748.674080-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnrw+kdWBq8DkpJA--.55057S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF4rXr4DZF4xtF47Gry3Jwb_yoWxuwb_CF
	yrXFykJFWUCFy5Ga4kG3WxJF95K3y7tr4IqFnrtFy3Ja43ZF4DXFWkWrsYv34rWa1fArya
	qFn3AF97KrsI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8o7K3UUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8Qc5sWpgdae63wAA3D

From: Feng Yang <yangfeng@kylinos.cn>

Fix several issues in test_progs.c

v2: Fix several issues raised by sashiko-bot

v1: https://lore.kernel.org/all/20260721094404.593127-1-yangfeng59949@163.com/

Feng Yang (5):
  selftests/bpf: Fix double free of subtest_state->name
  selftests/bpf: Fix missing allocation null checks in test_progs.c
  selftests/bpf: Use calloc to allocate subtest_states
  selftests/bpf: Fix memory leak on subtest_states reallocation
  selftests/bpf: Fix potential NULL pointer dereference in strscpy call

 tools/testing/selftests/bpf/test_progs.c | 50 ++++++++++++++++++------
 1 file changed, 39 insertions(+), 11 deletions(-)

-- 
2.43.0

