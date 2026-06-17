Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419F9481AA7;
	Wed, 17 Jun 2026 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709650; cv=none; b=Y8Ja8/vgczhQMzuMMYhD/e2hPFY89AHFEn9meR7tfJkCYNVTj3A1WIm+Z/UfkUX63W3osAcADoaEJM1eZFGsmhVS6Ek7dPB7y1iAdThFsnZ7Z/+Ze5eiGZNemTBVLy/Wi/VDMXPvjqWhtoCDFCwvPqHKrjtbb3uu6c/XCNNCVL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709650; c=relaxed/simple;
	bh=/3cT6/MhgGbgWHYHdGdJMSDotpdaCYD7/6XePN4Ag+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sD1K1OESU2og3Pn7yR/+DQd3TvXSSsPSKoDyCvCeAczBUIRTquBl6KC0/BCEsCa61OCZkAhoMkIMuEPJxbeJnwymCw8Dm2j+7KBZ3DTvO/tpBId680BreD9i/ECkMdWZ0vq0vxWee6R4uQ6XbbDHBtdRBuLk0+/jQclTOl7erA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=lQ/7TPrt; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="lQ/7TPrt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=YHIMrE00tiSeqczPY0zTpyedcE0Qcv4
	5NVyWz5XWQRU=; b=lQ/7TPrtXuO8TrGnJnLUY6MRVX7SNpmecszdoJHHK1WEakp
	sky9rQU+ChMdvgMx7EAQCQCaEI1Xg5CzaFV0B3bGoVgOesQAsf0CsChFLggRYyNA
	H9mbd2n4SMSxweyx3aJYP8kz2zc46Q6sWbopTGZElAWpyDli293ld1vkjJSE=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQCXcJg6uzJqVHJaAg--.59129S3;
	Wed, 17 Jun 2026 23:20:27 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Wed, 17 Jun 2026 23:20:20 +0800
Subject: [PATCH bpf-next v2 1/2] bpf: Preserve pointer spill metadata
 during half-slot cleanup
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-f01-06-half-slot-pointer-spill-v2-1-42b9cdc3cf64@mails.tsinghua.edu.cn>
References: <20260617-f01-06-half-slot-pointer-spill-v2-0-42b9cdc3cf64@mails.tsinghua.edu.cn>
In-Reply-To: <20260617-f01-06-half-slot-pointer-spill-v2-0-42b9cdc3cf64@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781709629; l=2233;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=/3cT6/MhgGbgWHYHdGdJMSDotpdaCYD7/6XePN4Ag+4=;
 b=hSIEumNL7QHykwy8dMHp+XuIVy5ye+vHx5QVoiz3kQ0FTjwMd49QcXsSxaa+vmKMzV2dZMDo3
 0A541bw+NoDB1ZGI1sWpd0jtxCE+Z9YPdhr4CmZ4SCYICq+rlpAJrVg
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:yQQGZQCXcJg6uzJqVHJaAg--.59129S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyxuFWfGw1UGr1Dur1ftFb_yoW8uFyDpr
	yDG3W7Gr4kJ3WI93ZFvF1kKr98GF4kJ3y8KF1UGryxWFyrGry2vFs09ay5Za1SqFWkA3yr
	Ar4FqrZ0k3WDCFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6ryrMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU4uc_DUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQMBA2oytN4IlQAAsv

__clean_func_state() cleans dead stack slots in 4-byte halves. When the
high half of a STACK_SPILL slot is dead and the low half remains live,
cleanup converts the live low half to STACK_MISC or STACK_ZERO and clears
the saved spilled_ptr metadata.

That conversion is safe only for scalar spills. For a pointer spill, this
metadata clear lets a later 32-bit fill from the still-live half avoid the
normal non-scalar register-fill check and be treated as an ordinary scalar
stack read.

Leave non-scalar spill slots intact in this half-live shape. This is
conservative for pruning and preserves the existing
check_stack_read_fixed_off() rejection path for partial fills from pointer
spills.

Fixes: be23266b4a08 ("bpf: 4-byte precise clean_verifier_state")
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 kernel/bpf/states.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 32f346ce3ffc..ea2153cf28d0 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -436,12 +436,10 @@ static void __clean_func_state(struct bpf_verifier_env *env,
 				continue;
 
 			/*
-			 * Only destroy spilled_ptr when hi half is dead.
-			 * If hi half is still live with STACK_SPILL, the
-			 * spilled_ptr metadata is needed for correct state
-			 * comparison in stacksafe().
-			 * is_spilled_reg() is using slot_type[7], but
-			 * is_spilled_scalar_after() check either slot_type[0] or [4]
+			 * Only scalar spills can be degraded to raw stack bytes
+			 * when their high half is dead. Pointer spills need the
+			 * saved spilled_ptr metadata so partial fills keep
+			 * rejecting as non-scalar register fills.
 			 */
 			if (!hi_live) {
 				struct bpf_reg_state *spill = &st->stack[i].spilled_ptr;
@@ -449,6 +447,9 @@ static void __clean_func_state(struct bpf_verifier_env *env,
 				if (lo_live && stype == STACK_SPILL) {
 					u8 val = STACK_MISC;
 
+					if (spill->type != SCALAR_VALUE)
+						continue;
+
 					/*
 					 * 8 byte spill of scalar 0 where half slot is dead
 					 * should become STACK_ZERO in lo 4 bytes.

-- 
2.34.1

