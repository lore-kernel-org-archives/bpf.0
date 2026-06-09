Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C499533F5A0;
	Tue,  9 Jun 2026 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016959; cv=none; b=jlYbwW3lDvd57Tr2+H9U8rbrDpNuug17Z6mHm3/CeAlS3ofI6VPNHZugYUoYVVn2rUq3Gey4c/D2PM3QhIlcWA+mZtLzZLaxqLCfJ+rQAPvrLVydg5TlFXlHqv+E3FRmQGUBWVhiK6AqsBjIRS0eARpWObrAW6QxJsnSWokeIgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016959; c=relaxed/simple;
	bh=OkWYuxTB9G6Mjp2u4ScYGrLXonSUh1c0jfaAzDcMuIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BHNDzMU5Yte5Ce/C/Sy2/1d03MLJFaDsRQpJSVfJxTf5Nlz5AuA7B5O78+uMztkeEhuIE6rBJxpogZpNp0eYz5Py54pNtQuVMQXdsQz6MuhhtirInSuSIrElDiF8g4Tu8Qj5uGvIjgTmwr3pBfZ3F6fmkx7tuV/HqcD1WzcoJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=VCaYB++S; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="VCaYB++S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=jL/9+s3Pr094UNG1PalCQW0wDlNELr8
	stMh7twBcJT0=; b=VCaYB++SpACJv2SmAtJj0R+ZxEmLEa8H12uOzOcyPHpGaQU
	2ekjwO6fuvP8jkb+iGFTJ4OC825NQXSCNCrVZzf4V5SE6DNEutTWqfP9u8XQhNqc
	Yx4zPWHAfFpkp2QXgXm+hsO0Ndtc/r2Wrc7aOr1PW7JyFkchBS6CAvWIYuMo=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQBXEMBqKShqQodBAg--.40025S3;
	Tue, 09 Jun 2026 22:55:39 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Tue, 09 Jun 2026 22:55:18 +0800
Subject: [PATCH bpf-next 1/2] bpf: Reject scalar addition from untrusted
 memory
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-f01-03-scalar-add-bpf-next-v1-1-e6212e274155@mails.tsinghua.edu.cn>
References: <20260609-f01-03-scalar-add-bpf-next-v1-0-e6212e274155@mails.tsinghua.edu.cn>
In-Reply-To: <20260609-f01-03-scalar-add-bpf-next-v1-0-e6212e274155@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781016941; l=1303;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=OkWYuxTB9G6Mjp2u4ScYGrLXonSUh1c0jfaAzDcMuIQ=;
 b=IKboBUhVYFvvszz9aYxo8sG+f5c7yqxBFIE8SsPan0HyMh9ajvSmk+kfztjbDMcHkzWV29kbG
 zaswRMCqsZYCIv9f6Qb1xwvtZz9epBtezwkbNK0R0aGBVVRF2PVcpSR
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:zAQGZQBXEMBqKShqQodBAg--.40025S3
X-Coremail-Antispam: 1UD129KBjvJXoWrZryxGw4rtFyrGr4UKw4kJFb_yoW8JrWkpr
	4kWr9Fqr4DAFW7uasrZF4jvFyYga1rtw4rCa15A34xt3WDJFy0qF47Ka47XrZ0yF40va18
	tFyYvayj9ay7AaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6ry5MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUIKZXDUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgINA2onzACdTQADsc

scalar += rdonly_untrusted_mem reaches adjust_ptr_min_max_vals() with the
pointer as the source register. The untrusted PTR_TO_MEM case returns there
without updating the scalar destination, leaving stale verifier state.

Reject that addition before the early return. Pointer += scalar remains
handled by the existing untrusted-memory rule.

Fixes: f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c8d980fdd709..c6b350f9585a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14823,6 +14823,14 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 				 * This is legal, but we have to reverse our
 				 * src/dest handling in computing the range
 				 */
+				if (opcode == BPF_ADD &&
+				    base_type(src_reg->type) == PTR_TO_MEM &&
+				    (src_reg->type & PTR_UNTRUSTED)) {
+					verbose(env, "R%d tried to add from %s to scalar\n",
+						insn->dst_reg,
+						reg_type_str(env, src_reg->type));
+					return -EACCES;
+				}
 				err = mark_chain_precision(env, insn->dst_reg);
 				if (err)
 					return err;

-- 
2.34.1

