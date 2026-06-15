Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFB8313546;
	Mon, 15 Jun 2026 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525241; cv=none; b=r1fMagszq1yyOG9I6rcsfsoMtK/6JIWMZ/qg14Sl2ko4hsZQ/XXg7esZHrzo36DfuCAQhl2oqtHp7yeIqizyqWlYzAx+1EFKvfwQQd9ghlT28AUDyH8edpf9FJKyHx99ApiwvnONsVHg9Jq/H2DpFDdOwsc4nNb48C+wKfyrNBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525241; c=relaxed/simple;
	bh=A49IaxbGzZVBNxFu8s+zBlZ4emBPLDy+yxux8zWbf+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XpycLdf1LqM7AcVemWtL0JSM2EWP1wLwVv71i1wzKUf4pnge4C9pmamrBwakVkLDMJtMaRpzwe73ZKmnRICywDSvotooyolVBV8wdaPnyrKExPOC3GqC6EPyKHWw8zPiUO7+WKy80Kgweb4STVoacmZLP7mBM7bOxlzx5905jz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=U21mDHDK; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="U21mDHDK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=0OK1d
	F+u9ommmMt0UEseuzZpFlk7Yclc2bHdgM7n/hQ=; b=U21mDHDKjuxQ7SNuMPqLe
	R80SJUU1ld62ceD7w0+Gkx+VLOna6biQ30tWxkS2TthpUL0I3bcjX2TUrRnL+MSC
	jktQFO9oZ7+E1egqCbNoSvBobQH5It599McxUbOvL+rMfsNqy7UeXQpIYmllQodk
	5tfohn0aIMSh1/9xfHUTcY=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web3 (Coremail) with SMTP id ygQGZQAHVpPi6i9qGQ10Ag--.50794S2;
	Mon, 15 Jun 2026 20:07:06 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: bpf@vger.kernel.org
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf 0/2] bpf: Fix packet pointer invalidation for skb dynptr writes
Date: Mon, 15 Jun 2026 12:06:37 +0000
Message-Id: <20260615120637.151095-1-chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQAHVpPi6i9qGQ10Ag--.50794S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW5Cr45ZF4rJFy5Kw4rKrg_yoW8Ww1Dpa
	yrGryYqrykZF13ZrnxJF40vr98Wa18WF43Gasrtry5Zwn8XryYqFyagr15Aas8KF4fXw4a
	vFy2v3s5Ca45CrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14
	v_Xr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRCGQ6UUUU
	U
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

skb-backed dynptr writer kfuncs can mutate skb packet data.
The verifier does not currently treat those kfuncs as packet-changing.
A direct packet pointer checked before the call can stay usable after the
write.

bpf_dynptr_write() already clears packet pointers through the helper path.
Teach kfunc argument checking to do the same for skb and skb-meta dynptr
destinations.
Keep source-only dynptr arguments unchanged.

Validation:

  Without this series:
    linux-stable-v7.0.12 accepts the three stale packet pointer cases;
    linux-mainline-v7.1-rc7 accepts the three stale packet pointer cases;
    the source-only bpf_dynptr_copy() control loads on both kernels.

  With this series applied:
    patched bpf-next rejects the three stale packet pointer cases with
    "invalid mem access 'scalar'";
    the source-only bpf_dynptr_copy() control still loads.

  Build and style checks:
    git diff --check: OK
    checkpatch.pl --strict --no-tree: OK
    make O=$BUILD kernel/bpf/verifier.o: OK
    make O=$BUILD -j$(nproc) bzImage: OK
    dynptr_fail.bpf.o build against patched vmlinux BTF: OK

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---

Yiyang Chen (2):
  bpf: Fix packet pointer invalidation for skb dynptr writes
  selftests/bpf: Add skb dynptr writer packet invalidation tests

 include/linux/bpf_verifier.h                  |  1 +
 kernel/bpf/verifier.c                         | 62 ++++++++++++-
 .../testing/selftests/bpf/progs/dynptr_fail.c | 89 +++++++++++++++++++
 3 files changed, 151 insertions(+), 1 deletion(-)


base-commit: e4287bf34f97a88c7d9322f5bde828724c073a6b
change-id: 20260615-bpf-skb-dynptr-pkt-inval

Best regards,
Yiyang Chen
-- 
2.34.1

