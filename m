Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622C74B95A5;
	Wed,  7 Oct 2026 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.187.6.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791390358; cv=none; b=EhkI6ugCbqgWlnPfh+vHYvQY9cJAn92ORp5+4uPdA7ww60DTqnRlMS/5VPcGRxsz/1XtfLG60q/cTE74RpFHWgy9F5K6e74ISVxWuFf+XLyG0OlqPuHSN8mgQptxymUdz5njDWrZJQiBNYXoKtZk2It4uu9h/6d6h9DUsPEOUGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791390358; c=relaxed/simple;
	bh=CgR8XemSElZEZ0qupffsAPHdIhjfSl4qcoBESu8TXtg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MWvTuRNymcQ/+jkKkohFPhHGFWY8tb26aeCg5iPf86S3i7vmpUqqYeIEW/wTRuGV7kMk1AcSYUNKTkRs+I0PED8DExxx5cf0NezgjpDHBHqQ244NvIojPk9ReSMC5zsKwxb8WxrK+8Vl7g7E8WGZirQ99mlGDAbBNB4tFel82lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=jf7LUqQ+; arc=none smtp.client-ip=52.187.6.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="jf7LUqQ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=rLsprYscUkpGpvdA8iPgNXgU1PA3+Qr33ni7MNSvGbg=; b=jf7LUq
	Q+r1WDNlB2WkjvsjS/aP2Kxv08LC4evDg6jF389drSSkwh79JToS9ZvkeMK0Vki8
	/iseCT80HKCz7IYJF954ZPlnvp0jitItA+PGt8k+9eTRLyP1h6h7VBFA7JkToSvr
	vP2HBIoF3OFhhA+4HaSsg7BSJBEkGc8a2V8JI=
Received: from [172.17.0.2] (unknown [101.6.30.195])
	by web1 (Coremail) with SMTP id yAQGZQA3qzt6csZqskPbAA--.57300S2;
	Thu, 08 Oct 2026 00:25:33 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Subject: [PATCH bpf-next v4 0/2] bpf: Enforce trusted BTF ID argument
 provenance
Date: Wed, 07 Oct 2026 16:25:28 +0000
Message-Id: <20261007-a3-arg-trusted-v4-v4-0-253ef3a1a69a@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHlyxmoC/4XNyw7CIBAF0F9pWDsNz6a48j+MC4RpS6LYACUa0
 3+XdOXCx/Lmzj3zJAmjx0T2zZNELD75W6hB7hpiJxNGBO9qJpzyjlGqwAgwcYQcl5TRQZGgnXJ
 a9grV2ZC6myMO/r6ZR3KeBwh4z+RUm8mnfIuP7VlhW//DLQwoKIpYT/rBCX24Gn9JbU4+jNNiW
 nRLa8MmF/5X41UTTFvkWnRa/tTEu9Z90kTVZMe0M4OgyOw3bV3XF+C9auNkAQAA
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Amery Hung <ameryhung@gmail.com>, 
 Brahmajit Das <listout@listout.xyz>, 
 Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791390334; l=2733;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=CgR8XemSElZEZ0qupffsAPHdIhjfSl4qcoBESu8TXtg=;
 b=Hu/tTUWVf9UUVIgHtNvJsiygjXId6+j4C0tOQJyNw2W+WC2VFx8x7xXAuaSG3adPd0YCvyWyC
 v95uMohrunYBl7JR+HA5fGiNVSyTX/UyFQV0r3nCj3gguZy+MzdR3E4
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-CM-TRANSID:yAQGZQA3qzt6csZqskPbAA--.57300S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1xXrWrJr4kuF45Gr45ZFb_yoW5Wr1fpF
	4rJw1Yvr48Krn3Ja4ftF47ZF1Fg3s5J3yUC3Z8J34UAanxGFyxArySgayjgwn8ur98uw10
	qFyIqrn09F1fZ3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262
	IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx2
	6r4rKr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4
	CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY
	02Avz4vE14v_JwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUnwZcUUUUU
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

A global subprogram parameter tagged __arg_trusted is verified with
PTR_TRUSTED, but its call-site type check also accepts bare PTR_TO_BTF_ID and
MEM_RCU registers. This lets a callee use a pointer with weaker provenance
under the trusted-pointer contract, including passing it to a non-KF_RCU
kfunc.

Encode the trusted-pointer requirement in generated kfunc prototypes and
drive the shared provenance check from the argument contract. A KF_RCU
kfunc additionally permits MEM_RCU, while a global __arg_trusted argument
requires a referenced or trusted pointer. Normalize nullability when the
argument contract permits it.

Add rejection coverage for bare and RCU-protected global-subprogram arguments
and acceptance coverage for a nullable kfunc receiving a trusted nullable
pointer.

A separate scx_cake caller fix has been prepared but is not yet submitted.
The current veristat-scx pin still uses the old caller, which this series
rejects.

Changes in v4:
- Rebase onto bpf-next and use the shared argument checker.
- Reject MEM_RCU for global __arg_trusted arguments.
- Encode trusted and KF_RCU provenance in generated kfunc prototypes.
- Add nullable-kfunc coverage and use a 12-character Fixes SHA.
- Link to v3: https://lore.kernel.org/r/20261006-a3-arg-trusted-v4-v3-0-4619daf30e1c@mails.tsinghua.edu.cn

Changes in v3:
- Preserve RCU-protected arguments accepted by existing sched-ext programs.
- Make the MEM_RCU case a positive regression test.
- Use the preferred multi-line comment style.
- Link to v2: https://lore.kernel.org/r/20261005-a3-arg-trusted-v4-v2-0-319ce2936949@mails.tsinghua.edu.cn

Changes in v2:
- Retarget the fix to btf_check_func_arg_match(), where the subprogram
  argument check lives in this tree, instead of check_func_arg().
- Run the check after check_reg_type() and check_func_arg_reg_off() so type
  and offset diagnostics keep their wording.

v1: https://lore.kernel.org/bpf/20261005-a3-arg-trusted-v4-v1-0-50ee0268fd39@mails.tsinghua.edu.cn/

---
Yiyang Chen (2):
      bpf: Enforce trusted BTF ID argument provenance
      selftests/bpf: Cover trusted BTF ID argument provenance

 kernel/bpf/verifier.c                              | 27 ++++++++++++-----
 tools/testing/selftests/bpf/progs/iters_testmod.c  | 11 +++++++
 .../selftests/bpf/progs/verifier_global_ptr_args.c | 35 ++++++++++++++++++++++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c | 11 +++++++
 .../selftests/bpf/test_kmods/bpf_testmod_kfunc.h   |  2 ++
 5 files changed, 79 insertions(+), 7 deletions(-)

base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
change-id: 20261005-a3-arg-trusted-v4-9d5d9485e5ba
-- 
Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

