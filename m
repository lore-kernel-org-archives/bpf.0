Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C028A374731;
	Fri, 17 Apr 2026 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411109; cv=none; b=VwlVZgD6nZinBCBKzondjcbDmksPeWagzb0Rbdof/g5r9IgCZ0x3q5Zbo4rBAbyd0ntEnedI52E3FZt3qZXpZmZ0o+/FvKeGaTDOp5QafOwzS7isQ1LvKUcAGo2HxO07FFAeYYMHkWNddZeNvCv5GQo/wJzfu4hbu9/PVtPvDC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411109; c=relaxed/simple;
	bh=Vy6i0ztIiBL4BIBnnzcQh/WXpG0AV/ZxLj6vFAIJrEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ah9Eysl1PnCsue2UbATsY5NKQfNVTRNrb8pXbeT0l3gc9jv7nnnNNdK/xkWYsxDA2WlmJ4AGRSH0x+G8MONLEQ5hDiMgKLyZ34VmLi24C315kpjVCcFZTt0G+GE9feVyTmnyf42BsX+56KAutBXjhlvAuBH7wQ/MNzR48tqlMgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowADXZQnS4eFp983XDQ--.39919S2;
	Fri, 17 Apr 2026 15:31:30 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] bpf: crypto: reject unterminated type and algorithm names
Date: Fri, 17 Apr 2026 15:31:28 +0800
Message-ID: <20260417073128.91029-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADXZQnS4eFp983XDQ--.39919S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyDCw4UAr4xurWrCw1rWFg_yoW8GryUpF
	yFg34Dtw4DJrs7CFyxWr48ZryrA34SvFy3GFZ5W34Fkrn0qr97WF1Ikryavr1Yqa1Ykr1F
	vrWkArWY9347ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjTRKE_MDUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

bpf_crypto_ctx_create() validates the overall size of
struct bpf_crypto_params, but it does not verify that the fixed-width
type[14] and algo[128] fields are NUL-terminated before passing them to
string consumers.

A caller can therefore fill either field without a terminator and cause
bpf_crypto_get_type(), has_algo(), or alloc_tfm() to read past the end
of the fixed buffer.

Reject parameter blocks whose type or algorithm name does not contain a
terminating NUL within the advertised field width.

Fixes: 3e1c6f35409f ("bpf: make common crypto API for TC/XDP programs")
Cc: stable@vger.kernel.org

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 kernel/bpf/crypto.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 51f89cecefb4..8732689803a6 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -155,6 +155,12 @@ bpf_crypto_ctx_create(const struct bpf_crypto_params *params, u32 params__sz,
 		return NULL;
 	}
 
+	if (strnlen(params->type, sizeof(params->type)) == sizeof(params->type) ||
+	    strnlen(params->algo, sizeof(params->algo)) == sizeof(params->algo)) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
 	type = bpf_crypto_get_type(params->type);
 	if (IS_ERR(type)) {
 		*err = PTR_ERR(type);
-- 
2.50.1 (Apple Git-155)

