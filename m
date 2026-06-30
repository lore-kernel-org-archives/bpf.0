Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CF13ECBD9;
	Tue, 30 Jun 2026 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814388; cv=none; b=S0NU0JcyB/sWR4sBPzIOjNZMdV4qzD4a974/12ayhxm2iBpR1Ok5+WDt0qmXeeIErpVpgxzyCl+JcdeRcShHMg70Xz1b34FDpZI9Z45G1WU0LBykeRnznYNE50ji7dsfNf4Tvzs2/ttPdq0ALknPC+DlcWal+ZGHFi+KdLSnoKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814388; c=relaxed/simple;
	bh=mj2IlGW1L25eKLh0oVc/6sDmr/yHUqPfl1cYzkfzL7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lfZWvHDQERQqSeSSnmK4ImclLm2dP7HCwy5RRSgNatqMa+DBtBDsxDY0N69G4Sqqndw5w0GURrdi49aWT8ERM6LIxguLXshlAUfdfaGLsTDPphL9iQUtzAbjw8p+ZB1DnlsKS3yujZP4s4a6FQYGiDXS57PyiWRrVcOM2WO81NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=BTfL3gLz; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="BTfL3gLz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=IXH0GgNR15OWbARJvGndbI7F9MF+Ij3FWw
	9UZWpOtMc=; b=BTfL3gLzNAlEocuArS35ybpc6yePH9+h2NkXNI/19bYLFISyTs
	xQr2npjC2yqlz5xNOkyoqNpK4S49ra3btScqO9tJWRLkPr0hXHwyICvR+oUCBsO/
	PpMxsSH0NunS52IFEnR1yLNSt1Vck3al7lzp8uDt1X+9jBQt2Y6dBsktc=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQD3z5eGlkNqxZukAg--.37667S3;
	Tue, 30 Jun 2026 18:12:48 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: Reject arena frees below the arena base
Date: Tue, 30 Jun 2026 10:12:19 +0000
Message-Id: <2a3747e64898cc7dda6578279cb5688f7029f658.1782813442.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782813442.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1782813442.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQD3z5eGlkNqxZukAg--.37667S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw47WF1ftrWfKr1UCrWDtwb_yoW8Gr1Upr
	48Xas0yrWYqr1UZ3yDJF1DCryrCFsayw45GF48C3sYkry5Zw12yr48WF1UWa4Y9r4kZrWa
	vr1SqayY93WYg37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gw1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU82-5UUUUU
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

bpf_arena_free_pages() accepts scalar arena addresses. The runtime
masks the address to the low 32 bits and reconstructs a full user
address from the arena base before returning the range to the arena
free tree.

When the scalar value is below the low 32 bits of the arena base,
full_uaddr falls below user_vm_start. The existing upper-end clipping
then turns this into an out-of-range free-tree offset. A later
allocation can reuse that offset and return an address below the arena
mapping.

Reject such frees before computing the clipped range.

Fixes: 317460317a02a ("bpf: Introduce bpf_arena.")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 kernel/bpf/arena.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 49a8f7b1beef5..e28e83bed8c51 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -693,6 +693,8 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
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

