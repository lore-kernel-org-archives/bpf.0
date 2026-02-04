Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281742DECB2
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 06:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770185349; cv=none; b=jcrzT0R++iFUhyn8etnz0qL9yJ16iYzTapRptJdg1k7uqlaxa4VIa7nWFGTCxLuyXRh1wQTxc8UwAcPIWn7yy5KfH12rY/YTyC4Aukwnu6s7TAhRQ8kxzfjUI7iVCndUTTbOuFIU7CZD243AZFn8yG4dlgvfO6KVv0GPsrMBoWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770185349; c=relaxed/simple;
	bh=D4CbaGIqdLS6F0XkTidNogaQfilYrebEuHsA1EKV56I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dbQvIjU/YIS4y1nGPIWPogfiqmJyepw5b8ONkK+IF8zzShza5sBAEsQi494UJw5vwiEzIQRmu7ZaRRphfN8hlMrIggMZAj6VPkNNqZHHGLstFpWkdzNzDE/7P8DrHbrWmA+bD6RCACFoiRhKeGl742ucPbNIYcNRigMMv1mACUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=fail smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [112.32.2.84])
	by mtasvr (Coremail) with SMTP id _____wCXMc9j4oJpF817AA--.27997S3;
	Wed, 04 Feb 2026 14:08:36 +0800 (CST)
Received: from localhost.localdomain (unknown [112.32.2.84])
	by mail-app3 (Coremail) with SMTP id zS_KCgCXmWxh4oJpj88NBg--.58456S2;
	Wed, 04 Feb 2026 14:08:34 +0800 (CST)
From: Tianci Cao <ziye@zju.edu.cn>
To: eddyz87@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	shenghaoyuan0928@163.com,
	song@kernel.org,
	tangyazhou518@outlook.com,
	yonghong.song@linux.dev,
	ziye@zju.edu.cn
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for BPF_END bitwise tracking
Date: Wed,  4 Feb 2026 14:08:32 +0800
Message-Id: <20260204060832.12320-1-ziye@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cde3706275830169d289d664d425df1a47b50f31.camel@gmail.com>
References: <cde3706275830169d289d664d425df1a47b50f31.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgCXmWxh4oJpj88NBg--.58456S2
X-CM-SenderInfo: qtstiiaquyiko62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?VXvF7QXKKxbFmtjJiESix3B1w3tzYfmPt4q7bPP17nv9Zvsme7sPvU0377+RBBKdO8
	083r2keJFfieWsS/AIcxKcp+dSgxOzLlia/ADeuNduVGi4zFNSyn2u8pUsDmKuXdEehsJw
	72GhhVC7oKpUbPomxPZ9K3T7a2cnInZ2+jF0+Ozv
X-Coremail-Antispam: 1Uk129KBj93XoW7uF4xZw43Cr45Wr4xtryDXFc_yoW8ZF1xpr
	yrCF4rW3yxJryxZw13JF48JFyrCF4kZ3Z5Xw1DX34vv34FkFWUJr1DJrWvqry5Xa98Xry3
	AFW3u34ktw4kZabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU801v3UUUUU==

Hi Eduard,

Thank you for the suggestion!

On 2/4/26 7:16 AM, Eduard Zingerman wrote:

> Why not like this?
>
> #define BSWAP_RANGE_TEST(name, op, in_value, out_value) \
>         SEC("socket") \
>         __success __log_level(2) \
>         __msg("r0 &= {{.*}}; R0=scalar({{.*}},var_off=(0x0; " #in_value "))") \
>         __msg("r0 = " op " r0 {{.*}}; R0=scalar({{.*}},var_off=(0x0; " #out_value "))") \
>         __naked void name(void) \
>         { \
>                 asm volatile (                                  \
>                 "call %[bpf_get_prandom_u32];"                  \
>                 "r0 &= " #in_value ";"                          \
>                 "r0 =  " op " r0;"                              \
>                 "r2 =  " #out_value " ll;"                      \
>                 "if r0 > r2 goto trap_%=;"                      \
>                 "r0 = 0;"                                       \
>                 "exit;"                                         \
>         "trap_%=:"                                              \
>                 "r1 = 42;"                                      \
>                 "r0 = *(u64 *)(r1 + 0);"                        \
>                 "exit;"                                         \
>         :                                                       \
>         : __imm(bpf_get_prandom_u32)                            \
>         : __clobber_all);                                       \
>         }
>
> BSWAP_RANGE_TEST(bswap16_range, "bswap16", 0x3f00, 0x3f)
> BSWAP_RANGE_TEST(bswap32_range, "bswap32", 0x3f00, 0x3f0000)
> BSWAP_RANGE_TEST(bswap64_range, "bswap64", 0x3f00, 0x3f000000000000)
> #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> BSWAP_RANGE_TEST(be16_range, "be16", 0x3f00, 0x3f)
> BSWAP_RANGE_TEST(be32_range, "be32", 0x3f00, 0x3f0000)
> BSWAP_RANGE_TEST(be64_range, "be64", 0x3f00, 0x3f000000000000)
> BSWAP_RANGE_TEST(le16_range, "le16", 0x3f00, 0x3f00)
> BSWAP_RANGE_TEST(le32_range, "le32", 0x3f00, 0x3f00)
> BSWAP_RANGE_TEST(le64_range, "le64", 0x3f00, 0x3f00)
> #else
> BSWAP_RANGE_TEST(be16_range, "be16", 0x3f00, 0x3f00)
> BSWAP_RANGE_TEST(be32_range, "be32", 0x3f00, 0x3f00)
> BSWAP_RANGE_TEST(be64_range, "be64", 0x3f00, 0x3f00)
> BSWAP_RANGE_TEST(le16_range, "le16", 0x3f00, 0x3f)
> BSWAP_RANGE_TEST(le32_range, "le32", 0x3f00, 0x3f0000)
> BSWAP_RANGE_TEST(le64_range, "le64", 0x3f00, 0x3f000000000000)
> #endif

This is much cleaner! The unified macro approach with string parameters significantly
improves readability, and the test invocations are now very clear.

I'll adopt this approach in v2. Thanks for the better design!

Best,

Tianci

