Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7338D384242;
	Fri, 17 Jul 2026 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784282792; cv=none; b=b4x0fs6NymXKFnDVHCI3Hia3HvQ1OUuznUNmVxiUl3Z5v4h9bTolDKzIgXE5i5bpowG7cGQeFop4Nyxa8ArLzhqqI7sBy1pR7cyut8vq1Ni/0HuXQgRkIdoaBHVzuymUrWzpeq7me1/SSkHuKUM6zgjQF1tsZcjx/ugjYAZwxHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784282792; c=relaxed/simple;
	bh=rhyV2/zH8NG1ApY2JLFDEGUd/6iY+BYDnQ+iTorm8Wo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qeH+qtj0nZvBh+NqeKFyp2u0KMc4Vq47pUhSGjpwgoIdL+2JkU7HiGLiH8kenVLwkB8x4sbtbacOVe2+1/w0FIH0ycveN9eu6xRP0zNaZwikddJi+d3Rzu07Z5qmx+J8p2lTuEhzHP8pnY6MQ5mJ0xykd2pYUTasjhiWk9fZ4rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=XbTB3kiH; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="XbTB3kiH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=8TisMnL01GqO+HUkhMyk7JWt2gJFiDUOf4
	ea6D7y8P8=; b=XbTB3kiHYiJ+R4Nigqy4EGFNCar7tY2KaQ/4nDfooQDvn9raFk
	091eDIqkNxVWRDNKYPAXCQzG+vT5+WcwKs/GESbis/73YjkDDe33cVJUkwMYOMDn
	HhthKwLuE0p7YHYIALK5pImetgFn29PjA/R7BCiq01i2mlM3tYw7tSZOE=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web3 (Coremail) with SMTP id ygQGZQDXpRR7_llqNYAPAA--.22378S3;
	Fri, 17 Jul 2026 18:06:12 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/2] bpf: Check byte type when validating helper stack reads
Date: Fri, 17 Jul 2026 10:05:44 +0000
Message-Id: <aa470c883419417b06a7fcd63afc9f05eef29f5a.1784280493.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1784280493.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1784280493.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQDXpRR7_llqNYAPAA--.22378S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw45WrW5CF13Jw13KFWDCFg_yoW8Kry7p3
	W8Wasrtr48XFWxu3ZFvFn7ZFyUGFWDJr43uF18Wry5X345Wry2qFWYqFW5CF1avr4vq34r
	trWIv390q34DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vY
	z4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
	IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8twCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU20PDUUUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

check_stack_range_initialized() accepts a STACK_INVALID byte only when
allow_uninit_stack is set. It then has a separate path for spilled
registers: scalar spills are accepted directly, while pointer spills
require allow_ptr_leaks.

bpf_is_spilled_reg() tests slot_type[BPF_REG_SIZE - 1], the canonical top
byte of the slot. After a sub-register scalar spill, such as a one-byte
store to fp-8, save_register_state() marks only the covered byte
STACK_SPILL. mark_stack_slot_misc() leaves the untouched sibling bytes
STACK_INVALID. When the helper range reaches fp-7, the STACK_INVALID case
correctly declines it if allow_uninit_stack is false, but the following
scalar-spill path accepts it based on fp-8's slot-wide spill marker.

For a CAP_BPF load without CAP_PERFMON, allow_uninit_stack is false, so an
untouched sibling byte such as fp-7 should reach -EACCES. Instead, passing
fp-7 as the value to bpf_map_update_elem() after a one-byte spill to fp-8
is accepted, and the helper copies a byte the program never wrote. A direct
read of fp-7 rejects; only the helper-argument path is affected.

Require the current byte to be STACK_SPILL before taking the
spilled-register path. Full-width spills still mark every byte STACK_SPILL.
A permitted STACK_INVALID read is still handled by the preceding
allow_uninit_stack case. This mirrors the producer-side fix in
mark_stack_slot_misc(), which preserves STACK_INVALID siblings, and applies
the same invariant to helper arguments. The existing direct-read selftest
does not cover this path.

Fixes: 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a78cdabf85607..7c61ade27d2a6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6735,7 +6735,8 @@ static int check_stack_range_initialized(
 			goto mark;
 		}
 
-		if (bpf_is_spilled_reg(&state->stack[spi]) &&
+		if (*stype == STACK_SPILL &&
+		    bpf_is_spilled_reg(&state->stack[spi]) &&
 		    (state->stack[spi].spilled_ptr.type == SCALAR_VALUE ||
 		     env->allow_ptr_leaks)) {
 			if (clobber) {
-- 
2.34.1

