Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0832939150B;
	Sun, 16 Aug 2026 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786877824; cv=none; b=pjd+HZXdOrMwGF9TL1yJh+WyL45zXALzHGuIqnsgLbjCMJvHLGPWFl305/fzldczHAaH4k5gPjreaSSgwjMzuClDw4GFdm0IpVTPQTouXs2NiXyaF8zwWsPhQ08hgy5nSUuywftu7emuHd7kIkjEvlIJymClgoNezW/3sL/P1gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786877824; c=relaxed/simple;
	bh=2waN7egFf4zHp8cjqjJvAhm9wI2J1lCCDSCOGqZjUNY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F39CR4lNK8w/sWUBmx7wBHJWI4didTZINnlnGEpQENlc1Ufh/FxDUDxGSX2TVUnsSumQoEB6syiWc7P5LUNYgGM52dMJJS3Q/Kw/KBUjFEzAPNqBRgM0/phYUPMlZv8ovywOCUrLa/bBFCaEMO6pg1OwimrCF/TB06FRAVxL36w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=cKbuWVVo; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="cKbuWVVo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=FOjahohnfx6SB52oCyuMAZao61uyB8uroSsqjtOq+Dw=; b=cKbuWV
	VocuAOQuPL41osv3Egzi8FBFQ3zIgLUUJuic0TcFc+uSiirkf41baqbJR1NTkzkW
	4zG4tUxsLg1ZdgVWrP7taUmXn5U4Z5o2hbZEY0l/rwBY19csU6PNJLbP+jqJxlLX
	dmBLlwv3fWrX5MhUV0lppbm7duOOy1EvWgGQk=
Received: from [172.17.0.4] (unknown [101.6.30.195])
	by web1 (Coremail) with SMTP id yAQGZQB3Gclkl4FqEsoEAg--.40530S2;
	Sun, 16 Aug 2026 18:56:44 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Subject: [PATCH bpf-next v2 0/2] bpf: Reject mixed arena and ordinary
 atomic paths
Date: Sun, 16 Aug 2026 10:56:32 +0000
Message-Id: <20260816-bpf-next-038-mixed-atomic-v1-v2-0-4644c1886dbc@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGCXgWoC/42NywqDMBBFf6XMuiPx0dR21f8oLkYz6kCNkkSxi
 P/eVOi+cDeX+zgbeHbCHu6nDRwv4mW00WTnEzQ92Y5RTPSQqUyrMs2xnlq0vAZUeYmDrGyQwjh
 Ig0uKl8LUDWmdp1kL8WJy3MbK9/4JvyVUMenFh9G9D+6SHvl/iCiFfL0RmbrQVNJjIHn5JHixX
 T9TwmZOGgvVvu8fi3Pjft4AAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786877805; l=1544;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=2waN7egFf4zHp8cjqjJvAhm9wI2J1lCCDSCOGqZjUNY=;
 b=SufQphGnSUxU791ZpZ3QricatJwnikw+Zdgmwe8OlLoSRbx3hLJd/xIlDXIAZdKvUyrzBqZhj
 q3J2cvvLQNkDG28XeCipmOYEouhS2GIt9dhgycXR6DfSPvsH6vT3MnN
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-CM-TRANSID:yAQGZQB3Gclkl4FqEsoEAg--.40530S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4rZw1Uury5uFW8CFWruFg_yoW8XF45pF
	Wru3ZxtayvqF17uas3AF47Zr13KFZ3ZrW3ur17G34rA3Z8tr10qF4xKa1UAr98CryUXw13
	KFyjqr90gF1DAaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Av
	z4vE14v_Gw1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1Z2-7UUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Atomic RMW instructions use a single aux pointer type to select their final
instruction encoding. The verifier currently records that type only for
PTR_TO_ARENA, allowing a second path with an ordinary pointer to reach the
same instruction before fixups rewrite it to BPF_PROBE_ATOMIC.

Patch 1 records the destination type for every atomic RMW path so the existing
pointer mismatch check rejects incompatible uses of one instruction.

Patch 2 adds a verifier regression test with PTR_TO_ARENA and
PTR_TO_STACK paths converging on one atomic add.

Yiyang Chen (2):
  bpf: Check pointer type for all atomic RMW paths
  selftests/bpf: Cover mixed arena and stack atomics

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
Changes in v2:
- Remove the arena global and extra map from the selftest; reuse the existing
  arena map and a stack destination.
- Construct the arena pointer from a scalar and encode the cast with
  __imm_insn.
- Rebase onto bpf-next commit c93cbdb13f99.
- Link to v1: https://lore.kernel.org/r/20260813-bpf-next-038-mixed-atomic-v1-v1-0-e79aadb46a8a@mails.tsinghua.edu.cn

---
Yiyang Chen (2):
      bpf: Check pointer type for all atomic RMW paths
      selftests/bpf: Cover mixed arena and stack atomics

 kernel/bpf/verifier.c                              |  8 ++---
 tools/testing/selftests/bpf/progs/verifier_arena.c | 39 ++++++++++++++++++++++
 2 files changed, 42 insertions(+), 5 deletions(-)
---
base-commit: c93cbdb13f995f87b5356329b3fe551c80bb482d
-- 
2.43.0

