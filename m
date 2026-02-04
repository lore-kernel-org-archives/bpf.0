Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E776E31B812
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196375; cv=none; b=fMZBWGNcLkGpmf1I/j6r0xee6M6nHL3HEdHM5pahOCEVMXsIO0xMxkN5WFIjDO5hI3l6ivT20Lri8t406YGllIv3Qtno64xMGb6J7ranaOgBhj0oFXT11/MsHmF+OL9wbJb6R14e24BTdQDOK+E7cwxL8PWMY+is7D2+ve6eMxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196375; c=relaxed/simple;
	bh=uRmNT/2JYRJpZeh9j6U5iKdzdKp9C52cnmLidt9t7O8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZzYFl/9kERy7Mvw+XqVo1qPYyg6n/LQHGnLt4UxrPCl0LL/42Gty9IQ0Sk6U80pQPNbBmlVc1HzlN/oN0ceCiEN+IAawbg89sG8VGMFU48CjY62gcbpqWf9tp1GqyFnZnmb7JGHGNff6j0fLuJHZ16A/ko9txwvA4GWbrwxPzCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=fail smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [112.32.2.84])
	by mtasvr (Coremail) with SMTP id _____wA3FFh5DYNptOF8AA--.565S3;
	Wed, 04 Feb 2026 17:12:26 +0800 (CST)
Received: from localhost.localdomain (unknown [112.32.2.84])
	by mail-app1 (Coremail) with SMTP id yy_KCgAXItx1DYNpEjkFBg--.7911S2;
	Wed, 04 Feb 2026 17:12:23 +0800 (CST)
From: Tianci Cao <ziye@zju.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn
Subject: [PATCH bpf-next v2 0/2] bpf: Add bitwise tracking for BPF_END
Date: Wed,  4 Feb 2026 17:11:44 +0800
Message-Id: <20260204091146.52447-1-ziye@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgAXItx1DYNpEjkFBg--.7911S2
X-CM-SenderInfo: qtstiiaquyiko62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?aMVWAwXKKxbFmtjJiESix3B1w3tzYfmPt4q7bPP17nv9Zvsme7sPvU0377+RBBKdO8
	083m9YdTa8lQerqvWm+lkv19A05iTTdNT+H6CxvZa8dA1bZi/jjkKr90XKkhR1O7mpcycv
	SkVVMlpnZa7pLgMBAQHN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj9xXoW7GFWrWw4fXr4xZw13Ww1xZwc_yoW3Krc_u3
	yUAr98X34DAF1DtFyj9F1fXrWjkrW7tF1SkFWDKrW7X343Zr18AFZ3try8X3srW3Wjyr47
	XF1DJ34ktwnruosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbTAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7xwIDUUUU

Add bitwise tracking for BPF END (bswap16/32/64,be16/32/64, le16/32/64).
Please see commit log of 1/2 for more details.

Changes v1 => v2:
- Refactored selftests using BSWAP_RANGE_TEST macro to eliminate code
  duplication and improve maintainability. (Eduard)
- Simplified test names. (Eduard)
- Reduced excessive comments in test cases. (Eduard)

v1: https://lore.kernel.org/bpf/20260202133536.66207-1-ziye@zju.edu.cn/

ziyefbk (2):
  bpf: Add tnum tracking for byte swap operations
  selftests/bpf: Add tests for byte swap tnum tracking

 include/linux/tnum.h                          |  5 +++
 kernel/bpf/tnum.c                             | 40 +++++++++++++++++
 kernel/bpf/verifier.c                         | 43 ++++++++++++++++++-
 .../selftests/bpf/progs/verifier_bswap.c      | 43 +++++++++++++++++++
 4 files changed, 129 insertions(+), 2 deletions(-)

-- 
2.34.1

