Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725DE40A95E;
	Mon,  6 Jul 2026 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353155; cv=none; b=EJnEsFQCXfF/dORog4F+P/uLkYTvXImoiuf6xSCc/+jr6vgxcjT0xC/P6rpVlzjaREUjdDkian5Cz+M18gZp37WpxNpgIp5PmLFlC3HKkQuG8UGV6+cIjdSL4rZ/soyDm7+hqBOpxJNd+0RJbwG+d5go0hCs3HY3gsifnBETKb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353155; c=relaxed/simple;
	bh=bsJ6/26m6TnMosc6QWSRKlVDSLuO3umBnysrF5flyyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZSNFn9RZtYWmsBKKJtVazBkjl9ydTVcEXDHsv6pANuMbGhlmey6/5gn15TjIyJdhfpnCVg+ie9KuoJQngaz9sT+r8SGD6KBIIRQ8ayqiwF1T5YlojVbDpESel/4nKrH87bWrUrLPe0C59tpv+zNT6eC8QM9vKU0xXf7lAFUtCws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=kT/mG3SX; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="kT/mG3SX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=bnSJy5sA5SQAOUnSrFUVIVqBLF1rB2X
	Kh+i7wgS1UyE=; b=kT/mG3SXe5AicZ1XQCq+duja0Uw4x2F58X12KUgx6/ziP4c
	3pXNONf0XkBN4/7/23xJN2T+KXDq1JUnzG+ufOEBjex1dqT8GtZepxMF6JnCMy4J
	58APxsm+RnS2Qt1Bc+qD5WS7LlTxm/VREyEv0x462UUaKv6NkuFTX1P3V8ik=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQC3bb0sz0tqPl8AAw--.17381S3;
	Mon, 06 Jul 2026 23:52:12 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Mon, 06 Jul 2026 23:52:10 +0800
Subject: [PATCH bpf-next 1/2] bpf: Reject out-of-range arena free addresses
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-f01-31-arena-free-bpf-next-v1-1-3ad6e7384285@mails.tsinghua.edu.cn>
References: <20260706-f01-31-arena-free-bpf-next-v1-0-3ad6e7384285@mails.tsinghua.edu.cn>
In-Reply-To: <20260706-f01-31-arena-free-bpf-next-v1-0-3ad6e7384285@mails.tsinghua.edu.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783353134; l=1308;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=bsJ6/26m6TnMosc6QWSRKlVDSLuO3umBnysrF5flyyY=;
 b=FhAw8NwNWRH416bxTFgThMoQbxlojGswz5dYzWrflgZq/T0bqjuEdpFUS+///spYTgsUtHv/V
 4DEDB37mR3/AoMcgVakotouTnSFNlwfmntxUx3//U8qP6Him4lbg2AD
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:zAQGZQC3bb0sz0tqPl8AAw--.17381S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AryDCF45ZF17Zr13Gw4fuFg_yoW8Jw48pr
	4rtFyYyr4rtw15A3yDJr1kCryFkFs3Aw45GFW0kwnYkryYvrnF9r48uF17Wa4Y9rs7Z34a
	9r4Iv3yY9an8Za7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9q1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28E
	F7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_GrWk
	Jr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5c
	I20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxE
	wVAFwVW5WwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjfUOq2MUUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQEAA2pLXR+fogAAsd

bpf_arena_free_pages() accepts scalar arena addresses. The free path
masks the low 32 bits, computes the full user address, and clips only
against arena->user_vm_end before inserting the range into the arena
free range tree.

A scalar address below arena->user_vm_start can therefore produce an
out-of-domain page offset. A later allocation can consume that offset
from the free range tree and return an address outside the arena range.

Reject frees whose computed full address is below the arena start before
clipping the end of the range.

Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 kernel/bpf/arena.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 80b7b8a69446..97a5d8d21295 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -853,6 +853,8 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	uaddr &= PAGE_MASK;
 	kaddr = bpf_arena_get_kern_vm_start(arena) + uaddr;
 	full_uaddr = clear_lo32(arena->user_vm_start) + uaddr;
+	if (full_uaddr < arena->user_vm_start)
+		return;
 	uaddr_end = min(arena->user_vm_end, full_uaddr + (page_cnt << PAGE_SHIFT));
 	if (full_uaddr >= uaddr_end)
 		return;

-- 
2.34.1

