Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED06D3AC0F8;
	Mon,  6 Jul 2026 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353156; cv=none; b=F4F7oHBTw7etJ0Bu7vjXm3rPQjKblmi5Q97UjZUZuFkEuw6xxDoHWT2X8+Z/8+NOAArX2E3l36YlnNQly4HqxFBk+bjvp6JcGZPbzMDMEVxou++N9zwLowN0NoDZTWOBpDcJXYE8mGr2jnKuMaCalaPKWjeqm9qoAWTEZRmZxGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353156; c=relaxed/simple;
	bh=lNmQTJpRqFjD9+cHnuUjqegGN5BYTDCre50nGYzm+DM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TEUvozFgRo49P/l9btw0MJZR4W1iQT7QxFnjUP+7UOD4kRRTTrqZWwtQsA1F2EA7HfW/1Q04bOGE7BD2/mTQHk7cxvGAUjGYRXAqQLbfI5THvxLIK5GL+gG5cDY8TpZTNnwvJTRp9ynNA2Y4ikHkHMAlBjOHbdMMygGBpapy6T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=OyQDDgaf; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="OyQDDgaf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=D0twh6MECjMf2CKI5tLP4DdD2BYfKv4ooXvTnqEDVTg=; b=OyQDDg
	afvkqb4lOjhaCbo+DdTDiUJGeOxOf+YUufT2tTsRfLSA+FetWr/ywxhyIXPsZCTb
	sc9SkhTjJGLnn0Y4up2X+vzWFisR+tiKC8EvJ8Q2xC8Q5+U1YmjacGn+pf4Ca9Ra
	yxfN1D7ztL1SCiMsMOHNnZO/lNi835nFjxBkc=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQC3bb0sz0tqPl8AAw--.17381S2;
	Mon, 06 Jul 2026 23:52:12 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf-next 0/2] bpf: Reject out-of-range arena free addresses
Date: Mon, 06 Jul 2026 23:52:09 +0800
Message-Id: <20260706-f01-31-arena-free-bpf-next-v1-0-3ad6e7384285@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACnPS2oC/zXMywrCMBCF4Vcps3YgiVovr1JcZNoTHRexTKoUS
 t/dqLj8OYdvoQJTFDo3CxleWvSRa/hNQ/0t5itYh9oUXGjdwbWcnOet52jIkZMBLGPijHniYxC
 RveAkw44qMBqSzl+8o/+LLr+lPOWOfvrYtK5v3XKExogAAAA=
X-Change-ID: 20260706-f01-31-arena-free-bpf-next-82bbb5be9bd4
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783353134; l=1173;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=lNmQTJpRqFjD9+cHnuUjqegGN5BYTDCre50nGYzm+DM=;
 b=mFehq9yQcGWr/da9WyVBj0OUu2cJ0xELBWSxwF/IGcHGvKI2Kc8qfh4/OIPvhWT3T4xIbgbUO
 3yr8GX4rd1PACMCtaVrXPuqq/hTfWjDKA6CtnHcbt2p/Oeyg2j7XPg2
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:zAQGZQC3bb0sz0tqPl8AAw--.17381S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF4DXr1Dur4xKr43WF4kZwb_yoWkCrg_Gr
	WvkF9rGr4DGF1xCFy7Cr1rZryfC3yxKry5ur1vvryxJryYqa1xGF4Sy3WrtF97Ga15tr95
	Cr4akwn7Cry3ZjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26rxl6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84AC
	jcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8Ww4U
	Jr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI
	8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK
	67AK6ryrMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ0edUUUUU=
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQIAA2pLXR+foQAAsd

bpf_arena_free_pages() accepts scalar arena addresses. The free path
masks the low 32 bits, computes the full user address, and clips only
against arena->user_vm_end before inserting the range into the arena
free range tree.

A scalar address below arena->user_vm_start can therefore produce an
out-of-domain page offset. A later allocation can consume that offset
from the free range tree and return an address outside the arena range.

Reject frees whose computed full address is below the arena start before
clipping the end of the range, and add a verifier selftest for the
out-of-range free case.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
Nuoqi Gui (2):
      bpf: Reject out-of-range arena free addresses
      selftests/bpf: Cover out-of-range arena free addresses

 kernel/bpf/arena.c                                 |  2 ++
 tools/testing/selftests/bpf/progs/verifier_arena.c | 26 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)
---
base-commit: 87bfe634b1193db90e5170e1ddbad04a63ef4501
change-id: 20260706-f01-31-arena-free-bpf-next-82bbb5be9bd4

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

