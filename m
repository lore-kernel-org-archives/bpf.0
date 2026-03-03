Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FB838CFE2
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530852; cv=none; b=XDNRwY45LZFWwfIDnIWqssuQDmCzCppuPr/pEt/PmV6i4GiTjhsBzvY51Q1s5evga7iHxpccN8Nzbi6WHDIuJNryo2MtJ0WeuUCY49NCgkAfsLLyDt/+IbZhafHoAf+bYk5rgxTbY0Kg0mGR1qxL6PH1Hd8GclnEp8elcdYaSUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530852; c=relaxed/simple;
	bh=55EE6THTcaftJRKKIAtIFsnWxe+nVnMo7evMy81DX8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mP/sytqqiOON9U/7Fw/xf6mkd3YFNzZqNC70fT4m4UalOALBvCRXGcuby/yVcy3cFAP0R3BSE2xikXwTuWxGJrdBKwdW9TjV/fMBXlnUffkqy0k8o3u8f7tkCRuVRXHgHOTECU6l1lpMiUpMAM6FWT+6m30pf/vM4AQcMI8sLF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wDXKESCrKZprjr+AA--.956S3;
	Tue, 03 Mar 2026 17:40:18 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app1 (Coremail) with SMTP id yy_KCgAnfNeArKZpdD9zBg--.47419S2;
	Tue, 03 Mar 2026 17:40:16 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn,
	glapt.pro@outlook.com
Subject: [PATCH bpf 1/2] bpf: Reset register ID for BPF_END value tracking
Date: Tue,  3 Mar 2026 17:39:55 +0800
Message-ID: <20260303093956.395076-2-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303093956.395076-1-tangyazhou@zju.edu.cn>
References: <20260303093956.395076-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgAnfNeArKZpdD9zBg--.47419S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgMTCmml6Akh0QAAsF
X-CM-DELIVERINFO: =?B?5kkU3wXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9LdbtO46Mr1SK3wce07WIS0wTOb25lByQQtB5iheJW9ZDvCykB0nABnAwXqJMiwiEwGG
	Sh0O33mDS+Ktbb5ZsSEljUQtJamXixNlbRSHgb4/V/1pB3UsDrbgEVzanqOPpQ==
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr4rCF4kAry5Kr13WrWDWrX_yoW8ZFWDpr
	4DGF98KFyvgw1j9a17uF4IkFyUW3ZxXw4xWrs8A34SyF1UJFyFv3y0gF1aqFWayrZ2g3yF
	vr12v39Iva1UZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Hq2tUUUUU==

From: Yazhou Tang <tangyazhou518@outlook.com>

When a register undergoes a BPF_END (byte swap) operation, its scalar
value is mutated in-place. If this register previously shared a scalar ID
with another register (e.g., after an `r1 = r0` assignment), this tie must
be broken.

Currently, the verifier misses resetting `dst_reg->id` to 0 for BPF_END.
Consequently, if a conditional jump checks the swapped register, the
verifier incorrectly propagates the learned bounds to the linked register,
leading to false confidence in the linked register's value and potentially
allowing out-of-bounds memory accesses.

Fix this by explicitly resetting `dst_reg->id` to 0 in the BPF_END case
to break the scalar tie, similar to how BPF_NEG handles it via
`__mark_reg_known`.

Fixes: 9d2119984224 ("bpf: Add bitwise tracking for BPF_END")
Closes: https://lore.kernel.org/bpf/AMBPR06MB108683CFEB1CB8D9E02FC95ECF17EA@AMBPR06MB10868.eurprd06.prod.outlook.com/
Link: https://lore.kernel.org/bpf/4be25f7442a52244d0dd1abb47bc6750e57984c9.camel@gmail.com/
Reported-by: Guillaume Laporte <glapt.pro@outlook.com>
Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 401d6c4960ec..366ba4757135 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16121,6 +16121,8 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 			scalar_min_max_arsh(dst_reg, &src_reg);
 		break;
 	case BPF_END:
+		/* manually reset register's id here to avoid mistaken register links */
+		dst_reg->id = 0;
 		scalar_byte_swap(dst_reg, insn);
 		break;
 	default:
-- 
2.53.0

