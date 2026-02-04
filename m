Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F0D3E9F6B
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203742; cv=none; b=O45Anl+PBd9rOkA8etjrKRZieNT7qLhM5NJ4uka3cdFSxnTW5fr/MtdRKEtMU1AHzDjfHuLiaIXgIZyl9FBUFbaIZplghcQERc3eics1I6tCdkyN/TyE25xc9V49/TOwSmiWHy5JlvrzoVayw7qprlOOA5V1N0M1MakKSiPcfB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203742; c=relaxed/simple;
	bh=9qfCeHKKOTh4rJpS/fQMdrfNPlT4KMqp1QpexatfZQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pD2bz1yn6yF+2hI3UycTonK+Qrcz/TP5X6lC3qyBJ8OR3Z8dwvyI9fQIbGRo0RE3Zil0I481oquuS05yZrTXp8Nkyon2Mj0jRAJyHdMDmGqXGDOWIfsJyl5nIo2pMYJi7FWdW5XMNHU/inuxu77MRhaSHbq0cXKbKo8VeMziTkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=fail smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [112.32.2.84])
	by mtasvr (Coremail) with SMTP id _____wCXJVA_KoNpboV9AA--.2131S3;
	Wed, 04 Feb 2026 19:15:12 +0800 (CST)
Received: from localhost.localdomain (unknown [112.32.2.84])
	by mail-app1 (Coremail) with SMTP id yy_KCgBX2NA8KoNpkIIFBg--.8165S2;
	Wed, 04 Feb 2026 19:15:10 +0800 (CST)
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
Subject: [PATCH bpf-next v3 0/2] bpf: Add bitwise tracking for BPF_END
Date: Wed,  4 Feb 2026 19:15:01 +0800
Message-Id: <20260204111503.77871-1-ziye@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgBX2NA8KoNpkIIFBg--.8165S2
X-CM-SenderInfo: qtstiiaquyiko62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?C3MBlgXKKxbFmtjJiESix3B1w3tzYfmPt4q7bPP17nv9Zvsme7sPvU0377+RBBKdO8
	083m9YdTa8lQerqvWm+lkv19Dwykkpl/UOKhWznw/XkqluHSd9vT0mRTm+oiI6PCnSn2Pz
	YO+UOqYcX4FRia5O8QnN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj9xXoW7GrW3Jw4kXF1fGw4DCrW3urX_yoWkXwc_Cw
	45CFy8W3yqyF4vqa42qF1fXrWjk39rtF1fKFWDKrWavas7Ar45XF95Jr9aq3sxXa1YyrW2
	qasrW3yvvw1UZosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
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

Add bitwise tracking (tnum analysis) for BPF_END (`bswap(16|32|64)`,
`be(16|32|64)`, `le(16|32|64)`) operations. Please see commit log of
1/2 for more details.

---

Change log:

v3:
- Resend to fix a version control error in v2.
- The rest of the changes are identical to v2.

v2 (incorrect): https://lore.kernel.org/bpf/20260204091146.52447-1-ziye@zju.edu.cn/
- Refactored selftests using BSWAP_RANGE_TEST macro to eliminate code
  duplication and improve maintainability. (Eduard)
- Simplified test names. (Eduard)
- Reduced excessive comments in test cases. (Eduard)
- Added more comments to explain BPF_END's special handling of zext_32_to_64.

v1: https://lore.kernel.org/bpf/20260202133536.66207-1-ziye@zju.edu.cn/

Tianci Cao (2):
  bpf: Add bitwise tracking for BPF_END
  selftests/bpf: Add tests for BPF_END bitwise tracking

 include/linux/tnum.h                          |  5 ++
 kernel/bpf/tnum.c                             | 16 +++++
 kernel/bpf/verifier.c                         | 60 ++++++++++++++++++-
 .../selftests/bpf/progs/verifier_bswap.c      | 43 +++++++++++++
 4 files changed, 121 insertions(+), 3 deletions(-)

-- 
2.53.0

