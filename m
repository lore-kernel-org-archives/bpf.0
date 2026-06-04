Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F8D330D43;
	Thu,  4 Jun 2026 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585943; cv=none; b=OpPenVheoBjJhTRStZzTkIvx1dDCNbmKJ3ThYLs9Ak/4XBSprPzBWB5R8032w1crEL3h87uSGkKZZlias2LTj+fZRce4xcm28pllOzTPvNCc0ngsA47HvkORsUMksjsyYvF2aX5FhuiSIfT+SLoxsFxAOXBgAMOrfGVVNlBwat4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585943; c=relaxed/simple;
	bh=HeX5k4pnGPPviIUMfkIjZGk3TsOAm8TvZMX1sxRcuMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ELdz+fwKoRThyD8CyxQmuvBaxxJ9EUX1iG0qO6/aui8vB4l5TKaXU8q9EpFeNmekYV6OqmjffwVfPHImG0U78Zq2Z2FP3tf3VMUa8l3O6FVBDc2gVbKHepsmzji6JR7ykVpmMusTlurBDr5oeu5rYcTBJUw4yYqPzi/xdzjhsKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=h1IUetbA; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="h1IUetbA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=JQMTdjRgDQqlF/lm6SBARFq5841IfBBAuL
	WPUUDsrk0=; b=h1IUetbAK0MofjuE1IvgOf8nUFUKZIwpMBGyUNkN5l2aiHbnqd
	ZnodWiyxc3LoEmBbeL2c0RMdUdulkAFIrEYzriZr6N3nIp9b2wZrRRhypNmlberd
	MqOxCcGOdz6jziIzsBwburtoqaV4SlkL3gf/ln1wvW6XHSD4Th7gE6PoU=
Received: from dumpling.. (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQDnnr65lSFqvf8mAg--.4748S4;
	Thu, 04 Jun 2026 23:11:59 +0800 (CST)
From: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: dxu@dxuuu.xyz,
	Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Ihor Solodrai <isolodrai@meta.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf 2/2] selftests/bpf: Cover dynamic inner array lookup nullability
Date: Thu,  4 Jun 2026 23:11:53 +0800
Message-Id: <20260604151153.2488051-3-gnq25@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604151153.2488051-1-gnq25@mails.tsinghua.edu.cn>
References: <20260604151153.2488051-1-gnq25@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQDnnr65lSFqvf8mAg--.4748S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4DuFyxKryUXw45Gw1xZrb_yoW8uF1Upr
	ykWa43CFW8ur12g34fJay8uF4akF1vgry5A3WFyw1YvFsrWryxXr4xuFW7tr1ayw18ArWF
	vF17ta48Cay8JFDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xS
	Y4AK67AK6ryrMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOq2MUUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgQIA2ohcoE9RAABsN

Add a verifier regression test that looks up a constant key through a
dynamic inner array template and dereferences the result without a NULL
check.

The verifier must reject the program because BPF_F_INNER_MAP allows the
concrete runtime array to have fewer entries than the template.

Signed-off-by: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 .../selftests/bpf/progs/verifier_map_in_map.c | 40 +++++++++++++++++++
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

