Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317F03AA4EF;
	Sun,  7 Jun 2026 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780838686; cv=none; b=WXu7qbeYm96xxOIORrQo3w1UWjVaQByP0mE/TZGkr3RjvCkdNkuVXdZx+44y4Mlb411z3diiixi/Jh39nfx65PBsEFULU/e1zUfipP33+GAV9igka7q2nOXZbR0pPg7ufBCGgd0Ui8AWvaoL8LfBTEp1sEO07aZ7eDuNE82hgug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780838686; c=relaxed/simple;
	bh=4RinSwaXv4rpc98MH0aBM8Bs7FUeJ9WpV4P53jmeJ+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qh/BwkSQwuU84UqRHpOj8BI9QjKglIi7rjLd7Ot+/dWwkGAjxBnzxrsYtaOAyBfHhGf6pieSu1VKZxxlurI10jVuhP/WzCI0YXIdt5QYuC74cx9H3mer2LZ2wFSqqgdk6ykIWVwgOw1vWyA2OP1vVZ0jNrr8UtCXCz082Ym3AzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=lpqkIVsi; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="lpqkIVsi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=fKqo7DN6RfYgJnkv2y/r/zhTAK94Bu5
	2XHK8/3mBsRs=; b=lpqkIVsixvaSpz/Cx7rusWVYWIG0ZypD6wKo6aBbmEL9CNd
	J/TuqMsH/grSkf7Ax4mCFRGT2ZseUYbHIsaiI0h+PEn8/37PFX6Op7p4rDIe7/vN
	K8oDSYle+7h/+ji27FyOpD3fAMXSnGDJtVrV5FELC/egSjzJe3uAQAHzqCFQ=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web4 (Coremail) with SMTP id ywQGZQD3CJ4KcSVqdwgUAg--.41669S4;
	Sun, 07 Jun 2026 21:24:28 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Sun, 07 Jun 2026 21:24:14 +0800
Subject: [PATCH bpf v2 2/2] selftests/bpf: Cover dynamic inner array lookup
 nullability
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-f01-v2-v2-2-da48453146e8@mails.tsinghua.edu.cn>
References: <20260607-f01-v2-v2-0-da48453146e8@mails.tsinghua.edu.cn>
In-Reply-To: <20260607-f01-v2-v2-0-da48453146e8@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, Daniel Xu <dxu@dxuuu.xyz>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Ihor Solodrai <isolodrai@meta.com>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780838667; l=2220;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=4RinSwaXv4rpc98MH0aBM8Bs7FUeJ9WpV4P53jmeJ+c=;
 b=lcRpfjr2TzRgOS9sQf+nsFNxFUmzkBWe8W9+QYzCsgIJZMK0zxyGMMmHyxrld9iyr56HFt/Ta
 WwZazyAqb40DkQgMsZpKsnnXwKAa9dOMF0jhk9tTSKufH8lthMfDeEM
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ywQGZQD3CJ4KcSVqdwgUAg--.41669S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4DuFyxGw45Zr4xWF1fXrb_yoW8uw13pr
	ykWa43CFW8ZrnFg34fJay8uF4akF1vgry5A3ZYyw1YvF47uryxXr4xuFW7tr1ay340yrWF
	v3W7ta48Cay8AFDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBq1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXVWUAwAac4AC62xK8xCEY4
	vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VCjz48v1sIEY20_GrWkJr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxkIecxEwVAFwVW5GwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r4rKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb7KsUUUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgYLA2oknpuRggAAsU

Add a verifier regression test that looks up a constant key through a
dynamic inner array template and dereferences the result without a NULL
check.

The verifier must reject the program because BPF_F_INNER_MAP allows the
concrete runtime array to have fewer entries than the template.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_map_in_map.c      | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
index 16b761e510f0d..b606b5dca7340 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
@@ -18,6 +18,20 @@ struct {
 	});
 } map_in_map SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+	__array(values, struct {
+		__uint(type, BPF_MAP_TYPE_ARRAY);
+		__uint(map_flags, BPF_F_INNER_MAP);
+		__uint(max_entries, 8);
+		__type(key, int);
+		__type(value, long);
+	});
+} map_in_map_dyn SEC(".maps");
+
 SEC("socket")
 __description("map in map access")
 __success __success_unpriv __retval(0)
@@ -45,6 +59,32 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("map in map dynamic inner array lookup is nullable")
+__failure __msg("invalid mem access 'map_value_or_null'")
+__naked void map_in_map_dynamic_inner_array_lookup_is_nullable(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_in_map_dyn] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	*(u32*)(r10 - 8) = 4;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = r0;					\
+	call %[bpf_map_lookup_elem];			\
+	r0 = *(u64 *)(r0 + 0);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_in_map_dyn)
+	: __clobber_all);
+}
+
 SEC("xdp")
 __description("map in map state pruning")
 __success __msg("processed 15 insns")

-- 
2.34.1

