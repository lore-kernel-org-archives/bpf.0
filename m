Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E78437646B;
	Sun, 28 Jun 2026 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782655213; cv=none; b=Hvpzs392M11qIAGkBHku8Up2M7cHSb0AKNuo+gGBfazobaAHxA4/K/j7pCZq08pKgNKBnxCyl+AL8X8DXpbi9wWz13aqfAKLzR9YV9k7wKYs/1xZdmaVz210dDpTie9FfaWMV+N6pv4omaeD76fP+3ozD3KuHiiKfFMnTqtUeSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782655213; c=relaxed/simple;
	bh=vo9ybfyuSUxqR0ad6xEzFIzNUgz0QG5Oy4idcIL5PPk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BQN6ftMTzJ514SFn/4jEW+1Pmc6bkey/0QRpkzxaWq9Fi5f7LLR/JD92dMn5icj5IU0IYZnvt3CqruSeTDB9cYumuma/TzpirUG8CpKR0WHdzNx8st9zlnvX1hRtrxSyIo9vT851PLEWG+CfMN6joUVL3cCXclaJwEhNtje6f7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=N8rim3n6; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="N8rim3n6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=CBrFd+his2LUHm8buFv6A/PEl93zuZ3UhFOq1LlRrkQ=; b=N8rim3
	n6AsLqR3WmGs5lJJplxt/0b/cGdkRqOWIoaJ8x8QVRKRx3GWpdff00vrWQvGGS1A
	3rP/i1/1OvzoCPCVT49AlRDJxSWeqxjsmvztWnzcVFTslht2GyUjqalArDubzxN6
	Br4VC09aRJe/AFFtSX6XewmmZ9DCZmBT+JA48=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQBnP5fdKEFqh1mYAg--.22544S2;
	Sun, 28 Jun 2026 21:59:57 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf-next v3 0/2] bpf: Enforce gotox targets against subprog
 bounds
Date: Sun, 28 Jun 2026 21:59:56 +0800
Message-Id: <20260628-f01-03-gotox-bpf-next-v3-0-b744432e1361@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANwoQWoC/zWMQQqDMBBFryKzdiAZwdpepbiIcWKni0SSKAHx7
 qYtXT7+f++AxFE4waM5IPIuSYKv0LUN2JfxC6PMlYEU9aqnAZ3SqDpcQg4Fp9Wh55JRm5txdz2
 THQiqu0Z2Ur7dJ/xfMP6WtE1vtvmThfO8AMBPYZCDAAAA
X-Change-ID: 20260628-f01-03-gotox-bpf-next-1a7af91d2c82
To: bpf@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Anton Protopopov <a.s.protopopov@gmail.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782655199; l=1942;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=vo9ybfyuSUxqR0ad6xEzFIzNUgz0QG5Oy4idcIL5PPk=;
 b=iBef9csVcJZ6nJbOKJn8oxzMR+l9yGFBxXsv4o74aQHcd7O8YuJaszP6WkBVC7hAZ+hNq2CSB
 YAYucnxrLHXD2Y5rEv1WzKq87KixA+i/JtBC5rN9RbaltrFhBHfYb2m
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:yQQGZQBnP5fdKEFqh1mYAg--.22544S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1kXFy7GrWxXr4Dtw1xGrg_yoW8Cw1fpF
	W8Xr4ayrWkJF4xKF13KF4UXw15urZ5Gw15u3Wxtw17A3ZxCFy8GrWIga43ZF9xZrW8urW8
	WFWIvFZxGr4DZrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xS
	Y4AK67AK6ry8MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdnY7UUUUU=
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQEMA2pATTHP5gAAsw

For gotox, CFG construction models the indirect-jump target set in
insn_aux_data->jt, while do_check() later follows targets from the runtime
PTR_TO_INSN register's own INSN_ARRAY map. If the same gotox can be
reached with PTR_TO_INSN values from different maps, do_check() can accept
a target outside the calling subprog.

The observed x86 JIT case can then enter another subprog without a matching
BPF call frame and crash when the program is run.

Fix this by rejecting gotox map targets outside the current gotox subprog.
Add a regression test covering the two-map cross-subprog case.

v1 -> v2:
  - Validate gotox runtime targets against the current subprog bounds instead
    of scanning the CFG jump table.
  - Fix the selftest expected error from -EACCES to -EINVAL.

v2 -> v3:
  - Drop the Validation section from the cover letter.
  - Clarify that the crash was observed through the x86 JIT path while the
    verifier invariant is generic.
  - Simplify the cover letter and commit message.
  - Remove the unused skel argument from the raw-insn selftest.
  - Move the raw-insn selftest to the end of test_bpf_gotox().

v1:
  https://lore.kernel.org/bpf/20260609-f01-03-gotox-bpf-next-v1-0-b441d63a1559@mails.tsinghua.edu.cn/

v2:
  https://lore.kernel.org/bpf/20260613-f01-03-gotox-bpf-next-v2-send-v2-0-7c883b43f3c3@mails.tsinghua.edu.cn/

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
Nuoqi Gui (2):
      bpf: Enforce gotox targets against subprog bounds
      selftests/bpf: Add cross-subprog gotox target coverage

 kernel/bpf/verifier.c                              | 19 ++++++
 tools/testing/selftests/bpf/prog_tests/bpf_gotox.c | 73 ++++++++++++++++++++++
 2 files changed, 92 insertions(+)
---
base-commit: 7bfb93e3475be9de894f1cecd3a727d3e1649b03
change-id: 20260628-f01-03-gotox-bpf-next-1a7af91d2c82

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

