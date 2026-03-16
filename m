Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFEB3E5EE7
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773687791; cv=none; b=EWoQtGpCAefEB2Mpo93YV1XeTSLAZsB7UOaq+2Zi+SEgBfVS0iDw5Xl/MBcaZBQgTSnx0d3366uFmqrXBI5bTfTBcMeO2JdjuIsNAyY4KxjKQomf97SrwmoE9ikqo/ilkFRMzd0D4y+37X085df6eh3uv8cbyqSgBOM4EZY3Hzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773687791; c=relaxed/simple;
	bh=VkH8JM5tPno8FgDDcwht9ug+vAlubh0EKOZYS78OPkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I1EHrLN7qoNlrW2ptGO76KYYfI+n3JuTvLCUxaK4DuZGUAjObIHCWbZSKlAVxuqxiM4rbDQE0E8tOIgn3pfKiLVj9LLnbQN1UYjxUIR2qq/GY7dEcy1AoHN4JPkoMVgB3mkdH8JDMJMkDdEpyX3yyhRFg+45Udvu+j6Z3c/EdCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.192.132])
	by mtasvr (Coremail) with SMTP id _____wAn423IU7hpOtgfAA--.5294S3;
	Tue, 17 Mar 2026 03:02:33 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [10.162.192.132])
	by mail-app3 (Coremail) with SMTP id zS_KCgBnam3IU7hpd_q4Bg--.11418S2;
	Tue, 17 Mar 2026 03:02:32 +0800 (CST)
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
	ziye@zju.edu.cn
Subject: [PATCH bpf 0/2] bpf: reject bpf-to-bpf call with large offset in interpreter
Date: Tue, 17 Mar 2026 03:02:18 +0800
Message-ID: <20260316190220.113417-1-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgBnam3IU7hpd_q4Bg--.11418S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBhILCmm1ugoVzwACsh
X-CM-DELIVERINFO: =?B?XXdHrQXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9Ed38ain3iGL/cGOK3OqJ6ZB9RSPFdhMb6JNyl26hNiIu5/Z3FGN9WAorkwgLuC2XQ61
	bmYJniVrW7FZsSdvBpGar/Wcl5v2XWx+A/p9AC+oZo2HK6vegEHkw4xN5ZqLGA==
X-Coremail-Antispam: 1Uk129KBj9xXoWrKr48Kryftr4UXry5XFyfKrX_yoWfGFcEvw
	4jqFykZFWku3ZFyFyjk3WfJrWvyw45Wr1IyFWDX347JryUJr1UGa1kZry3Xay8XFW7JrW3
	Z3WDZ34rtr4UZosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbTAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7xwIDUUUU

From: Yazhou Tang <tangyazhou518@outlook.com>

This patchset addresses a silent truncation bug in the BPF verifier that
occurs when a bpf-to-bpf call involves a massive relative offset, specifically
in the context of the BPF interpreter (when JIT is disabled or fails).

Please see commit log of 1/2 for more details.

Yazhou Tang (2):
  bpf: reject bpf-to-bpf call with large offset in interpreter
  selftests/bpf: Add test for large offset bpf-to-bpf call

 kernel/bpf/verifier.c                         |  6 +++
 .../selftests/bpf/prog_tests/call_large_imm.c | 49 +++++++++++++++++++
 .../selftests/bpf/progs/call_large_imm.c      | 38 ++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/call_large_imm.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_large_imm.c

-- 
2.53.0

