Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650B146A61D;
	Thu, 13 Aug 2026 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622496; cv=none; b=bvaOwJjBC72cF+ZLJJjEkPxvfdCDVv1lVmVPRkp1EjKDgbRb5V9i9/WFdcz684ZY9aekGS5wDahn88aFsrX4V/WwNDvfhBkWeQcYil6LQ/4INDFXV688+qNHR6vYhTPYdRvZVhizn7EHDBw0RgyKGgv1G2k1dCr7M1pSn3dAm5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622496; c=relaxed/simple;
	bh=5Fr1Ljw9kcgK0zRaXkouH6HhR/QZOS9HEQZsw64+cj0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NpCPh/Bp5Vps0gYF7gRUjmoY425JaaQgLgErhHpJe900090Md5XQsVFHJoGp34oDIzcB4vuxYVMOicwkXeggMzSRznJfLt2T+nO72K+CcS7dwbEO2kE3LRvvSKoa1v9IxwxxuZ8XR5n2JW3dpdNPv4nHMAhbFuZZOAHM//zVn4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=TnIFuEGO; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="TnIFuEGO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=qNY4fAJG7zop/4yASkWHba7fNtmrLwcN3dp0zb2N5dc=; b=TnIFuE
	GOV3dIQ49k7IZmQs2aN1N/Ajy2oMvdbTEJXDO4lqMnVayU18LM9AHRexOyxNM2X2
	irFxmRs8aXFqxLNJvituLUzJ30WLxLHVypG4/m7v8NZhleF7o2XwcezRbgh6PX35
	L2m04DDKRhyhgFk05wMl6+K686GCs5xGDX9ns=
Received: from [172.17.0.4] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQCXlLYLsn1qPyv_AA--.41218S2;
	Thu, 13 Aug 2026 20:01:20 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Subject: [PATCH bpf-next 0/2] bpf: Reject mixed arena and ordinary atomic
 paths
Date: Thu, 13 Aug 2026 12:01:02 +0000
Message-Id: <20260813-bpf-next-038-mixed-atomic-v1-v1-0-e79aadb46a8a@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP6xfWoC/zWMywqAIBAAfyX23IKPkuhXooPpWnvIQiOC6N+zQ
 8eBmbkhU2LK0Fc3JDo58xYLyLoCt9g4E7IvDEooIzqpcdoDRroOFLrDlS/yaI9tZYenxLbxk7P
 GaKkClMWeKBTl2w/wlzA+zwvEkT9ceAAAAA==
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786622482; l=1166;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=5Fr1Ljw9kcgK0zRaXkouH6HhR/QZOS9HEQZsw64+cj0=;
 b=SSTXqiIQVU/PJUTSNNRfXcjbl9vkkd8ADBoyaYEunsz7UT0zpADarVItVgMcy8pjVF1bACqui
 /GTWBOaXgp/By2fIj6WYlfm/gn1e0n5tH08X9jCG3ULNnl3u81isJF8
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-CM-TRANSID:yQQGZQCXlLYLsn1qPyv_AA--.41218S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF4kKry3Xr48CrWktr47Arb_yoWkWFX_ur
	WSya4kWrs0yF1fta4UCF43XFyDCFW3WFy8JF15XrW7A34DJrs8CF4kAr1UAryxJFn8tF9r
	Zrn8X39Yy3W7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-kFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28E
	F7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_GrWk
	Jr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5c
	I20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxE
	wVAFwVW5JwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1eWlPUUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Atomic RMW instructions use a single aux pointer type to select their final
instruction encoding. The verifier currently records that type only for
PTR_TO_ARENA, allowing a second path with an ordinary pointer to reach the
same instruction before fixups rewrite it to BPF_PROBE_ATOMIC.

Patch 1 records the destination type for every atomic RMW path so the existing
pointer mismatch check rejects incompatible uses of one instruction.

Patch 2 adds a verifier regression test with PTR_TO_ARENA and
PTR_TO_MAP_VALUE paths converging on one atomic add.

Yiyang Chen (2):
  bpf: Check pointer type for all atomic RMW paths
  selftests/bpf: Cover mixed arena and map-value atomics

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
Yiyang Chen (2):
      bpf: Check pointer type for all atomic RMW paths
      selftests/bpf: Cover mixed arena and map-value atomics

 kernel/bpf/verifier.c                              |  8 ++--
 tools/testing/selftests/bpf/progs/verifier_arena.c | 44 ++++++++++++++++++++++
 2 files changed, 47 insertions(+), 5 deletions(-)
---
base-commit: 6f033615ef8fb2374daa7e50a8ff68616bc850d2
-- 
2.43.0

