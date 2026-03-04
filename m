Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3557364EAD
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613198; cv=none; b=rLq/dCjxJrcUBcK1OWsy4xEj08Y7KLCzR7EEm6LU7q2KNHBVcvz1R7MPxqGdmi8X4pAKUTbqAjk6UEUGnIaNeqbM+kl60BSgliQpXCsLf5flVnRkR2xtHJEwK1/P5wKVNg/9OeQ45ZzyGlW4pD/XN+z+a4vj9g0Fg6yTrd4aLkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613198; c=relaxed/simple;
	bh=ew3iDrY6fawcRRAubjEnQa/QK3iFTGyZ74Y0XN+Ca/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lNrqzGMhWF7zNHGZRrfTVA13Obqtirv3D3ebZJXX62UW0SO/hafrw9KSq4b/Se+lGqj7e3bx2RfJfT3lvOYkuo5qPQB5r1+/p+LuA06tWW+JmHiEIsgBRVoJzWYUFNhr/SWY44GnqNuF1juYLWO1ARQ5BcfgOyB7/sqq4BaZ9EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [122.224.66.117])
	by mtasvr (Coremail) with SMTP id _____wBHP2Ym7qdpvssEAQ--.16642S3;
	Wed, 04 Mar 2026 16:32:39 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [122.224.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgAHhs4l7qdpAM12Bg--.161S2;
	Wed, 04 Mar 2026 16:32:37 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
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
	ziye@zju.edu.cn,
	glapt.pro@outlook.com
Subject: [PATCH bpf v2 0/2] bpf: Reset register ID for BPF_END value tracking
Date: Wed,  4 Mar 2026 16:32:26 +0800
Message-ID: <20260304083228.142016-1-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgAHhs4l7qdpAM12Bg--.161S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgQACmmnOYkbZwABsL
X-CM-DELIVERINFO: =?B?qXH/DgXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9H+6e/0XdEnku/cOG5HghNjUxtIMSarHAoNzYkFDbMNFRAePzpitA5jAjzL+HsjuXZ5n
	f2fZKYTMvLvJAFQkaSO8sMZvCfkO7ZOcGAPAnND4cX2ztE4GC796a+vZhPIwXg==
X-Coremail-Antispam: 1Uk129KBj9xXoWrKr48Kry8uF47WF4xtryDXFc_yoWxZFbEyw
	1IqFykWa9rG3ZruFyYvF1xZr9rCrW0gr13tFWUtFyDtry7Xrs0grZ5AryrZ34UXF4ftFZx
	Jw1Y9asYyF43uosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbTAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20x
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
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7ku4UUUUU

From: Yazhou Tang <tangyazhou518@outlook.com>

This patchset fixes a register's scalar ID issue for BPF_END operations
reported by Guillaume Laporte. Please see commit log of 1/2 for more details.

---

Changes v1 => v2:

1. Reset register ID inside scalar_byte_swap() conditionally. (Eduard)

v1: https://lore.kernel.org/bpf/20260303093956.395076-1-tangyazhou@zju.edu.cn/

Yazhou Tang (2):
  bpf: Reset register ID for BPF_END value tracking
  selftests/bpf: Add test for BPF_END register ID reset

 kernel/bpf/verifier.c                         |  7 ++++++
 .../selftests/bpf/progs/verifier_bswap.c      | 22 +++++++++++++++++++
 2 files changed, 29 insertions(+)

-- 
2.53.0

