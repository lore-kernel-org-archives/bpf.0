Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD87369969
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770039385; cv=none; b=jB3DEW1XK0QeFzJmYrAEKqTDtXbzfG4aGduXJcs5XZwPDFU2EtMjSrEssLrCAg1DSvkVH3vPNxoAWp+k/YuYzELdATfE7MauvVyEI1EnpqnS+rnR93wkON/kit6JCG356nVjOf3DI/MU34Mv+f91Rth4dxEQ8YPa+P+ookrRjxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770039385; c=relaxed/simple;
	bh=h1Berd21/O9ey/Sev2JXrw+L31YXUXePZjoXDLkF844=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fj1fwQrIWwQdQtDg3kdKB/m0imoi8EeZCT0L5hssc86e7vtOb1VK9mxEI4vkWQQ5DRYQ4jH2BHBj7cT9CcTbrnCoVE/ydo+hoES7Q6iw4akYy4TMjOl5S7AAvqQ20rDq3+SmcB9ZvnxBP8odrXb/W/aJGEhnz3VVADZ9DFGJ/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=fail smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [112.32.4.235])
	by mtasvr (Coremail) with SMTP id _____wDXnM0vqIBp_UdvAA--.6688S3;
	Mon, 02 Feb 2026 21:35:44 +0800 (CST)
Received: from localhost.localdomain (unknown [112.32.4.235])
	by mail-app2 (Coremail) with SMTP id zC_KCgAXfT8tqIBpO8ekBQ--.13017S2;
	Mon, 02 Feb 2026 21:35:43 +0800 (CST)
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
Subject: [PATCH bpf-next 0/2] bpf: Add bitwise tracking for BPF_END
Date: Mon,  2 Feb 2026 21:35:34 +0800
Message-Id: <20260202133536.66207-1-ziye@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgAXfT8tqIBpO8ekBQ--.13017S2
X-CM-SenderInfo: qtstiiaquyiko62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?qMqnCAXKKxbFmtjJiESix3B1w3tzYfmPt4q7bPP17nv9Zvsme7sPvU0377+RBBKdO8
	083uYxgGwm4o3MkAMAFMbdSWgB/kQS6NdbFfRD9mmdFKa0sBhAXiyYeKIHDYBUfrDXjTLH
	1f7yRa9l9/84Qkawub1dUyKHqvPLYcUGaa3joYPu
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280
	aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48Icx
	kI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8jLvtUUUUU==

Add bitwise tracking (tnum analysis) for BPF_END.

Please see commit log of 1/2 for more details.

Tianci Cao (2):
  bpf: Add bitwise tracking for BPF_END
  selftests/bpf: Add tests for BPF_END bitwise tracking

 include/linux/tnum.h                          |   5 +
 kernel/bpf/tnum.c                             |  16 +
 kernel/bpf/verifier.c                         |  56 ++-
 .../selftests/bpf/progs/verifier_bswap.c      | 321 ++++++++++++++++++
 4 files changed, 395 insertions(+), 3 deletions(-)

-- 
2.52.0

