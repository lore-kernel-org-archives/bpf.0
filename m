Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB49318B82
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 10:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114096; cv=none; b=RQ7oinhJJU6FRdPQy2X+3wdgEXa92RP/7eLzwKSBfW5hy/FKEjpg5mtTIa2r8ZxueGCZSTLePK4lQBYjaNHKRYceh9c/TwRsJzZC/RQz9Ayc66g5veHoGrnPnDu6pioeWYzkxD8Oz2L0V9Af6eQUCX/m2ux2P6uynkuuNqNV7PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114096; c=relaxed/simple;
	bh=NOFiUvLY89zwuuGAZXl447od8o4a6qCLz7lIs6yKV/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mHkLIsT76u7m3tkOK9fsnHElxe3u90FdbZ8vZ91uaTPKnwhMtZ7BRGKJicOdKf2fVczoUdKPDyOKGLzUyW7y2Gg/EzNkhqNDF1tK6xh+nSeuIxdy/uHM4EO7R6otJuua0CaiMFEeFV7ImTSFvaqW1luPwL3RRiZ5GfWsSh7Q9bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=fail smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [112.32.4.205])
	by mtasvr (Coremail) with SMTP id _____wB3YXP9y4Fp26t1AA--.13151S3;
	Tue, 03 Feb 2026 18:20:45 +0800 (CST)
Received: from localhost.localdomain (unknown [112.32.4.205])
	by mail-app2 (Coremail) with SMTP id zC_KCgCHoET5y4FpsnSoBQ--.60810S2;
	Tue, 03 Feb 2026 18:20:42 +0800 (CST)
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
Date: Tue,  3 Feb 2026 18:20:15 +0800
Message-Id: <20260203102015.5570-1-ziye@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b68a122d7a0b046a9ca5527bcf9f50dfea183ce9.camel@gmail.com>
References: <b68a122d7a0b046a9ca5527bcf9f50dfea183ce9.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgCHoET5y4FpsnSoBQ--.60810S2
X-CM-SenderInfo: qtstiiaquyiko62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?KU3CGQXKKxbFmtjJiESix3B1w3tzYfmPt4q7bPP17nv9Zvsme7sPvU0377+RBBKdO8
	083uYxgGwm4o3MkAMAFMbdSWjwkFRbqrwFahGCMpxhEzL0jBZNhjOgNXkhJp7zsWRRVGmA
	Ah9Gz3o1EOifTzwao2WXguWHTWSWDw9kjeBztpJ5
X-Coremail-Antispam: 1Uk129KBj93XoWxGF1ftFWDWF48JFy3Cw17Jwc_yoWrJr45pr
	yrGa13uFZ7JF1293WxXa1Iva45CFsY9FsxXr9Ivr40q3WxZw4UXr1jkr1Ykr4rJrZ5Z3WY
	vFyUAFyYgF1qqacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1iZ23UUUUU==

Hi Eduard,

Thank you for the review and suggestions.

On 2/3/26 4:23 AM, Eduard Zingerman wrote:
> Test cases themselves lgtm.
>
> Essentially you have two groups of tests that follow same template:
> - bswap16_port_routing, bswap32_ipv4_subnet_routing, bswap64_ipv6_subnet_routing
>   (why not just bswap16/32/64 as names, by the way?);
> - be16_network, be32_network, be64_network, le16_network, le32_network, le64_network.
>
> Maybe define two macros using bswap64_ipv6_subnet_routing and
> le64_network as templates to avoid the copy-paste?
> E.g. like DEFINE_BAD_OFFSET_TEST in verifier_value_illegal_alu.c.
> Also, could you please cut the amount of comments,
> test cases are quite self explaining.
>

I've refactored the tests using macros (DEFINE_BSWAP_TEST and DEFINE_ENDIAN_TEST) to
eliminate the code duplication, similar to DEFINE_BAD_OFFSET_TEST. I also simplified the
test names to bswap16/32/64 and be/le16/32/64, and reduced the comments significantly.

The code is as follows:

```
/* Macro for bswap tests */
#define DEFINE_BSWAP_TEST(bits, reg, mask, cmp_code, msg2) \
SEC("socket") \
__description("BSWAP" #bits " with tnum") \
__success __log_level(2) \
__msg(#reg " &= 16128 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=16128,var_off=(0x0; 0x3f00))") \
__msg("r0 = bswap" #bits " r0 {{.*}}; " msg2) \
__naked void bswap##bits(void) \
{ \
	asm volatile ("					\
	call %[bpf_get_prandom_u32];			\
	" #reg " &= " #mask ";				\
	r0 = bswap" #bits " r0;				\
	" cmp_code "					\
	r0 = 0;						\
	exit;						\
trap_%=:	r1 = 42;				\
	r0 = *(u64 *)(r1 + 0);				\
	exit;						\
"	: \
	: __imm(bpf_get_prandom_u32) \
	: __clobber_all); \
}

DEFINE_BSWAP_TEST(16, w0, 0x3f00, "if r0 > 0x3f goto trap_%=;",
		  "R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=63,var_off=(0x0; 0x3f))")
DEFINE_BSWAP_TEST(32, w0, 0x3f00, "if r0 > 0x3f0000 goto trap_%=;",
		  "R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=0x3f0000,var_off=(0x0; 0x3f0000))")
DEFINE_BSWAP_TEST(64, r0, 0x3f00, "r2 = 0x3f000000000000 ll; if r0 > r2 goto trap_%=;",
		  "R0=scalar(smin=smin32=0,smax=umax=0x3f000000000000,smax32=umax32=0,var_off=(0x0; 0x3f000000000000))")

/* Macro for be/le 16/32/64 tests*/
#define DEFINE_ENDIAN_TEST(op, bits, le_msg, be_msg, le_cmp, be_cmp) \
SEC("socket") \
__description(#op #bits " with tnum") \
__success __log_level(2) \
__msg("r0 &= 16128 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=16128,var_off=(0x0; 0x3f00))") \
__IF_LE(__msg("r0 = " #op #bits " r0 {{.*}}; " le_msg)) \
__IF_BE(__msg("r0 = " #op #bits " r0 {{.*}}; " be_msg)) \
__naked void op##bits(void) \
{ \
	asm volatile ("					\
	call %[bpf_get_prandom_u32];			\
	r0 &= 0x3f00;					\
	r0 = " #op #bits " r0;				\
	" \
	__IF_LE(le_cmp) \
	__IF_BE(be_cmp) \
	"r0 = 0;					\
	exit;						\
trap_%=:	r1 = 42;				\
	r0 = *(u64 *)(r1 + 0);				\
	exit;						\
"	: \
	: __imm(bpf_get_prandom_u32) \
	: __clobber_all); \
}

#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
#define __IF_LE(x) x
#define __IF_BE(x)
#else
#define __IF_LE(x)
#define __IF_BE(x) x
#endif

DEFINE_ENDIAN_TEST(be, 16,
	"R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=63,var_off=(0x0; 0x3f))",
	"R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=16128,var_off=(0x0; 0x3f00))",
	"if r0 > 0x3f goto trap_%=;\n",
	"if r0 > 0x3f00 goto trap_%=;\n")
... (and similar for be32, be64, le16, le32, le64)

```

However, I noticed that using macros does reduce readability somewhat - the test logic
is now more abstracted. Given that this is test code, do you think this trade-off is
acceptable, or would you prefer a middle ground?

Best,

Tianci

