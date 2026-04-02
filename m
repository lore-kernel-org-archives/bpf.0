Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED793306B11;
	Thu,  2 Apr 2026 07:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115646; cv=none; b=Yb8yO5s2jGelCTsqKywgQkg56tr74Hsbs9pomCLGJULXVND6t/SJl9c47NA75MG5YUSI9x5vds5aPcYoi5NE7/MGqy3tl6zFfAbK9MohQkf//Q/Q3M9G+Mx4AfA/HpQPN8h/Bi5GrkXumuLu88FfEAxDOHogCIGe/Y11FoBuVNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115646; c=relaxed/simple;
	bh=0lCzQp6niGBy7colx4e/ViCzKrp1vVHd1c81NwN7hUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LUKLGZcNi1gbX3nYZMNWwBkIwrCXsz9MvYOXMAXNHRryomfXPb8O47ryyrf3NyRRXbO7QeyqmCQT9vzpQ1ygtaWpn7F1C3/xVjNNPlWuzd5sXKTWcl0rV0q0/o8RcB8jsZcjJ5WPjPyxxRvdtnvrZQStJbiIttmfn7D8Ma1BDwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=mEikXSEV; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="mEikXSEV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1775115599;
	bh=rCmcley++ZBsrjpLqmXWkY5sgQ+kprY+bHo8jpImpuo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=mEikXSEVO4TyUQMD0yFCQsvxONJd7AlgWtVIcXceJQgpSnnSFqjeYebG3V1EFuyQl
	 Msbw87SONNw5VVRIZ8CzogIxwjngFQ3wVb1PTP+6e7WPHPpdP7b/zBGEZmd4p7EgGc
	 pyxSrsfz5EW2BMfDG0JMlTDcAfCBtngyY2mR4Qd8=
X-QQ-mid: zesmtpip3t1775115591t74f5a71b
X-QQ-Originating-IP: Wn8l/2x0rbbOsdryhQZVsWEY4kgeuu7ghaZv4ptW1so=
Received: from xulang-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Apr 2026 15:39:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2220135083028208239
EX-QQ-RecipientCnt: 20
From: xulang <xulang@uniontech.com>
To: martin.lau@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dzm91@hust.edu.cn,
	eddyz87@gmail.com,
	haoluo@google.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kaiyanm@hust.edu.cn,
	kernel@uniontech.com,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	paul.chaignon@gmail.com,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev,
	Lang Xu <xulang@uniontech.com>
Subject: [PATCH bpf v5 0/2] bpf: Fix OOB in pcpu_init_value and add a test
Date: Thu,  2 Apr 2026 15:39:48 +0800
Message-ID: <7653EEEC2BAB17DF+20260402073948.2185396-1-xulang@uniontech.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N6lOBJ3JrlaTr+eiskIaB0qMFOM3Vjyp8DbnaLXvpD6oi7+ISp3ZKz0D
	0l9mXBtr5Z7lNjBMvVr7pk79XiyllBw4pO6AJNNyDN9Y6NoP8jZZTp7Ufrr0oTVmUGn41Nz
	x0w6MeZw/n7yxcFErdGE273lokdz/MPWaBt6esg1peY8GOUpzb/QuLMvrw5yde0GVLt0iga
	L3OYsBUP+QYYX3a5W5/gNOdjhcED9lxZ1E3RQnCzowmySSsMsoECn/vQnHTdxzs68GUK41h
	52595ogBTOqGADuk0SRVQ3e866DmX3Prd7MdWuNPvm/yF4F0OTVHmsyDRkXcrji1XVTvGxF
	ddLSekbPGzoMfxniCQ9F3tn/jLKIoqOjk33pGCL7H8l4KFFzxqAxEtcF0AXs4bk3n9OQIaR
	MlSJpQFi46pUxKAdpuS8MOgIp5dDb20HSiFjNpwOkQdpJl6jSlWzkbSvzqPa90uI6K4Nsbo
	sMPwsixObp1puH7LgQdG1Q0f3GLk2juNVP1GZi2g8U78EzGruBvgywYq/osO22xQiw8ERVI
	gXwsQNjB297TDE5DkEEibFebClObKx2uDpZu1DiZcZQdvv7Syxw9eCUIKphZ3OR5IPKzxsb
	NOAJD1jYZoN8JdPeR1oYb35j8bT7VuBpzXR60w8hyBgyTuuDPccteH3pgaSNWPFWokNsKWj
	agxNWigMqnWMiK463wJgFZhzJtbCcdQkwm/jEqNLR2CPesTEicD0LceXV1cSBW1k9f4CIrP
	/T/eEfw8oQoYvAanoB3m1X2VlP9ws5HAFv6ULUuxqeapLsaI2t6FvmWOJsyxJVFEwp7q6UH
	x9JiK6AjAaL7VIykZBMPA6SRuqhJsvtzZ4vUOOXPf+M8n6my8CR3Cfp7D7+OuKCuryLCTo+
	DQG0HnR+rusNzifP579OcKCKuEn1UQiNmZL6rqBPtHsUK4SkTYM1QIGJ5bjH2lxeP++I2C3
	FoZybhrbWranfaaGZ8qqpCFX1KmHYL45D3Wtmf7YpE7giBtSE5Bsyf0S7TeixS4XKFDL5Qu
	DO/HCCaxze9t60BzLlp11ELi64ZbWcwiIooIvUqWYIYCtwEPLjP+wKO/hXYGhJANVaFgiob
	LORgrL4l1kwvr+BWbEe2UKoFcE/yzcmie81+zS4QbaSgUIJsa/vX78=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

From: Lang Xu <xulang@uniontech.com>

Fix OOB read when copying element from a BPF_MAP_TYPE_CGROUP_STORAGE
map to another pcpu map with the same value_size that is not rounded
up to 8 bytes, and add a test case to reproduce the issue.

The root cause is that pcpu_init_value() uses copy_map_value_long() which
rounds up the copy size to 8 bytes, but CGROUP_STORAGE map values are not
8-byte aligned (e.g., 4-byte). This causes a 4-byte OOB read when
the copy is performed.

Lang Xu (2):
  bpf: Fix OOB in pcpu_init_value
  selftests/bpf: Add test for cgroup storage OOB read

Signed-off-by: Lang Xu <xulang@uniontech.com>
---
Changes since v4:
- Make the summary phrase of the cover different from patch 1
- Fix patch series format issues

Changes since v3:
- nothing changed, just resend the patch series manually.
  There is something wrong with my email server(Message-ID overrided).

Changes since v2:
- Fix patch series format issues
- Instead of aligning CGROUP_STORAGE allocation,
  fix it by replacing copy_map_value_long with copy_map_value in
  pcpu_init_value

Changes since v1:
- Add self-test program to reproduce the issue

base-commit: 7aaa8047eafd ("Linux 7.0-rc6")

 kernel/bpf/hashtab.c                               |  2 +-
 tools/testing/selftests/bpf/prog_tests/cgroup_storage.c | 42 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/cgroup_storage.c      | 43 ++++++++++++++++++++++
 3 files changed, 86 insertions(+), 1 deletion(-)

--
2.51.0
