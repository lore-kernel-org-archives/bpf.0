Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B0D258CCC;
	Sat,  6 Jun 2026 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780743066; cv=none; b=CYDYZCDDO2NNLQw3zhAuOLbpJyi55bwqgiozOZYg3gVCJ+l3KRoQPkPQP6k3Uatv2wgYTX/zcF5wj1a5MJpMG/y2GdPlhq/oJiLKGbRePUkFuwSkn1Gt8oOkgRYOS6oZ7FaxHSJ36jcllyzXBCXMZzllZ0Iq2emstuLn1ty5Au4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780743066; c=relaxed/simple;
	bh=P5eScJCAFBLi0VYTPoFoB0Nuj57+F12/tyG+PtVt91A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BPQyNcE1GXGoawzkCMB+Q+DUYQ2NLAPGbt4F2fw6Lmt11BKixztXQ7XB8z9sk1RyTOv9t1RbNM2Ec5dfCORSLGTmqLyyAWjbUwWhYYzmRJ4JFUOZOsXgMkN9mtqhQlHeyies1JnyKNqiJnUO9ZKTyG62iN5kKikTEYwP3sQRxBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=cZPhOgPi; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="cZPhOgPi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=4Tm6sdLZy4ENCtgBqNG+uJ3ZHD5c4bUO94mg4LmNqZc=; b=cZPhOg
	PicGYAI10yP2JZDmAMG2mPNfTo3JP9QIdCXehD3X6naOmEsWpyOKtDYQhAH2HcgM
	vGOBYHkKME1HaqUF8u9FRNg1GuCDNg4BvgmxoNx1pJG5Wbc/N1uEZYQFbX0/YrLu
	wlzzm35W2qxen9+g/MoGE9ihMAWweKjv6LAug=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQC3cMB++yNqENcwAg--.58351S2;
	Sat, 06 Jun 2026 18:50:38 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf-next v3 0/2] bpf, verifier: fix PTR_TO_FLOW_KEYS
 constant-offset OOB
Date: Sat, 06 Jun 2026 18:50:36 +0800
Message-Id: <20260606-c3-01-v3-v3-0-97c51f592f15@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHz7I2oC/yWMQQqDMBBFryJ/3YE0kVS8SulCx7GdLqIkKoJ4d
 6PyV4//eBuSRJWEutgQZdGkQ8jgHgX414SvkHaZYY31Jo/YkXnS4shW7CtT+rJ5MbI+Rul1vVJ
 vtGNPQdYJn/tJc/sXns4S9v0A3nTrB3YAAAA=
X-Change-ID: 20260606-c3-01-v3-28c680464a7c
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>
Cc: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780743040; l=3426;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=P5eScJCAFBLi0VYTPoFoB0Nuj57+F12/tyG+PtVt91A=;
 b=vRqL465pJg47zVlkMUX5qMWgL+fO55j4a0PAcf2xfTd9jzk4MgQLY59uun15WDIHmUhnTgS3l
 k2OqMrZSwusCNGGq+ocZE0g6bwMdfZRyd5JtSdatceJDEIdXxvmw93y
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:zAQGZQC3cMB++yNqENcwAg--.58351S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyfury5Cw4DtFyfAw13urg_yoW5tw4rpF
	s5AF13ZF4DJry3Xa12yFWI9FyYk398Wr45Cr1UJ34rAas8Xa48Wrya9rsI9ryak3s8Cw4a
	yry8Wr929ayDAaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPq1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r1Y6r17M2vYz4IE04k24VAvwV
	AKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6x8ErcxFaVAv8VW8Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrw
	ACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wrylc2xSY4AK67AK6r4DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_GrWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
	v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	0JUCdgAUUUUU=
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgAKA2ojTRugSwABs+

A constant offset added to a PTR_TO_FLOW_KEYS register lands in
reg->var_off, but check_flow_keys_access() bounds-checks only insn->off
and never folds reg->var_off.value.  A BPF_PROG_TYPE_FLOW_DISSECTOR
program can therefore do "flow_keys += 0x1000; *(flow_keys + 0)" and have
it accepted, then read/write kernel stack past struct bpf_flow_keys at
runtime.  Patch 1 folds reg->var_off.value into the offset (and rejects
non-constant offsets), mirroring check_ctx_access(); patch 2 adds verifier
selftests.

This is a regression introduced in the 7.1 development cycle by commit
022ac0750883 ("bpf: use reg->var_off instead of reg->off for pointers"),
which moved the constant offset from reg->off (folded generically before
022ac0750883) into reg->var_off without updating the flow_keys path.  No
released kernel is affected: v7.0.x rejects the program above, and the bug
reproduces only on v7.1-rc1..rc5, so no stable backport is needed.

It was first reported privately to security@kernel.org; per their guidance
it is handled in the open as a normal regression fix.  Found by manual
verifier audit and confirmed dynamically in a disposable QEMU/KVM guest:
the load above is accepted, a runtime read leaked a kernel-stack pointer
0x1000 past bpf_flow_keys, and a runtime write of a marker faulted the
guest in net_rx_action.

An alternative -- forbidding pointer arithmetic on PTR_TO_FLOW_KEYS
outright by dropping "if (known) break;" in adjust_ptr_min_max_vals() --
was rejected because v7.0.x accepted (and correctly bounds-checked)
constant arithmetic on the keys pointer; restoring the fold preserves that
behaviour while closing the divergence.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
v2 -> v3:
 - Pass existing reg/argno context into check_flow_keys_access(), avoiding
   a stale regno reference in check_mem_access().
 - Add a variable-offset selftest using bpf_get_prandom_u32().

v1 -> v2:
 - Target bpf-next instead of bpf (per reviewer feedback).
 - Base-commit updated to bpf-next/master.

v2: https://lore.kernel.org/bpf/20260604180730.2518088-1-gnq25@mails.tsinghua.edu.cn/
v1: https://lore.kernel.org/bpf/20260604150755.2487555-1-gnq25@mails.tsinghua.edu.cn/

To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org

---
Nuoqi Gui (2):
      bpf, verifier: fold reg->var_off into PTR_TO_FLOW_KEYS bounds check
      selftests/bpf: add tests for PTR_TO_FLOW_KEYS offset bounds

 kernel/bpf/verifier.c                              | 18 +++-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |  2 +
 .../selftests/bpf/progs/verifier_flow_keys.c       | 97 ++++++++++++++++++++++
 3 files changed, 114 insertions(+), 3 deletions(-)
---
base-commit: 8ddce416797b7454ba1df855821b02c6e43b5a0e
change-id: 20260606-c3-01-v3-28c680464a7c

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

