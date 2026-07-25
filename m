Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BC1377A9F;
	Sat, 25 Jul 2026 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784974557; cv=none; b=PGFDp9YOoZTs7EGXbWt9NfWZvzvzYt2kjV6g8FRoKMRUVP91sHXuB8PlKt0cp2LU93tjDnbFyC8FyF/MKfcZLDgaZIKUiPasE/Df6eQuu3prawtZFMK/fvx4Eb7P0i1YzDOwtp8uYChl46W66uyPoLxXYM1MTVoC3L10253lBrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784974557; c=relaxed/simple;
	bh=uRaESl7B3O7XwDovdYFML9UgHUX/pHGcQdb4rp+GK0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lxQ520RXfLp5+3iOe3UucvoPVqHYdXgzpZ04q60Y8uFpxs/6j2hx4gKBuMdKzxwfOo3pJ4HNCtIINEEG2ILsADXWRF2yVmHRQggq4lnivqxtdG0e02GkXpBYkb+8rToUkkZ69fFRFe5HdPRflYckuyvTStfwOCnTVJ5rDTLH1wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h6ghx3JfKzYQtyw;
	Sat, 25 Jul 2026 18:15:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 74D3340596;
	Sat, 25 Jul 2026 18:15:47 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgAnOHTRjGRqlDL6CQ--.33326S4;
	Sat, 25 Jul 2026 18:15:47 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Shahab Vahedi <list+bpf@vahedi.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next v2 2/7] s390/bpf: Fix memory leak in bpf_jit_free
Date: Sat, 25 Jul 2026 10:20:15 +0000
Message-Id: <20260725102020.2287770-3-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260725102020.2287770-1-pulehui@huaweicloud.com>
References: <20260725102020.2287770-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAnOHTRjGRqlDL6CQ--.33326S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1kWw1xAw1UuFyDZr17GFg_yoW8Jw4fpa
	4DAw13Cr1vgwn7tFsxGa18ZF45Grs5Ww4UGFy7u3y093WjgFs7uFySka4rGFZ0yry7Xw1r
	WryDKrnxuFykJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7sRipB-tUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

If a subprogram fails to JIT in jit_subprogs(), previously JITed
subprograms are freed. However, the generic bpf_jit_free() fails to
free their leftover jit_data, causing a memory leak.

Implement a custom bpf_jit_free() to free this data.

Fixes: 1c8f9b91c456 ("bpf: s390: add JIT support for multi-function programs")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/s390/net/bpf_jit_comp.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index b60877478b45..d9fdb32b7a96 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -3106,3 +3106,22 @@ bool bpf_jit_inlines_helper_call(s32 imm)
 		return false;
 	}
 }
+
+void bpf_jit_free(struct bpf_prog *fp)
+{
+	if (fp->jited) {
+		struct bpf_jit_data *jit_data = fp->aux->jit_data;
+		struct bpf_binary_header *hdr = bpf_jit_binary_hdr(fp);
+
+		/* Cleanup for earlier subprogs if jit_subprogs() aborts */
+		if (jit_data) {
+			kvfree(jit_data->ctx.addrs);
+			kfree(jit_data);
+		}
+
+		bpf_jit_binary_free(hdr);
+		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
+	}
+
+	bpf_prog_unlock_free(fp);
+}
-- 
2.34.1

