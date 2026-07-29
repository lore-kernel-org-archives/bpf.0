Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55377477E37;
	Wed, 29 Jul 2026 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338331; cv=none; b=O/evFyGOYRMaEA52KC9WnRzd+A49eltPHCrdYrjCaM3jbkYvohq0NHRKfOYofiG9uVQKoSVLBC/xRtiiaD0RLDVvoM5dOZNYAI92DlU9UC+wv/p3i02Gvgp0vm+pwSYFQcp7RdnWncR3Qp/s3ah50V2efv1UVMCIMA9FCOx0YvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338331; c=relaxed/simple;
	bh=83OsnUyFLkkaeftWae9dxD+gai1MFRbZsDBUZubfbZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h0BYaOUT67J+4P4sCyUmgNOxHoNtU8+DaZuqcXs+IlolVz+ZID2Czuu7J2mN2YvGumDzNA8d5MQbi+xk3uu5am8K4f1ywjTV30i8vnMSTerO8pEyqN/8hKCHt3PiSHo378A7GL7YFBP7Ij9NBbkiErKyF/j0c7ESad1YyOD6pb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWHfWc0/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWHfWc0/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7587EC2BCFA;
	Wed, 29 Jul 2026 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785338330;
	bh=83OsnUyFLkkaeftWae9dxD+gai1MFRbZsDBUZubfbZo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tWHfWc0/rTzh20LnlrV/J0mQZ1G/pQjRNUO/BdZ4OJ2NAAam45B8teKMFcdKOtsPG
	 CBMSxgiMoBmoqKMg28vRLRtt7PGr9EEuy1xY0sjK8J2ng0ADkPl16tCwJMBGn0zyxB
	 zaemXLLiztR0F4nT6w8uazhuTeqfrpNdMwJMJXUS685MIBEKja15Dmbjsn8bNWf63j
	 WM4VgYTQlL+7ianDD4syn+CO0SP+KtHGebcdjRO/QJTffwMfjgAu/RLjneYDnGsuXQ
	 Y6soDsfCAX9AVBDn62XbgTodEwvk5t1mCbbhj1Ti3E8VeZ/GpKWdEs+SfNX7fDgLxY
	 yaLoo4wCEs3Uw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589ADC53219;
	Wed, 29 Jul 2026 15:18:50 +0000 (UTC)
From: Yiyang Chen via B4 Relay <devnull+chenyy23.mails.tsinghua.edu.cn@kernel.org>
Date: Wed, 29 Jul 2026 15:18:29 +0000
Subject: [PATCH bpf v4 3/4] bpf: Propagate untrusted pointer state in
 commuted arithmetic
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-c3-035-public-bpf-v4-v4-3-8ee297e2346b@mails.tsinghua.edu.cn>
References: <20260729-c3-035-public-bpf-v4-v4-0-8ee297e2346b@mails.tsinghua.edu.cn>
In-Reply-To: <20260729-c3-035-public-bpf-v4-v4-0-8ee297e2346b@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Shung-Hsi Yu <shung-hsi.yu@suse.com>, Daniel Wade <danjwade95@gmail.com>, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785338329; l=1686;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=yHtvihk7t702xySyUdiUvbGV+eWJSYwJqVOt//qmgOo=;
 b=HhStsKrRvBd7Pihhg2P46Wa2u4MhI0EMthAi+rZJtSSRuhCycAkueJtXIHx6+vU3r4LLJPfj4
 9dVefgXLeklCHi/dBFXh2XV7VSlgHhQhvoSPUS/hFV0+0X6Pp7sxbkt
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-Endpoint-Received: by B4 Relay for chenyy23@mails.tsinghua.edu.cn/kernel
 with auth_id=900
X-Original-From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Reply-To: chenyy23@mails.tsinghua.edu.cn

From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

The untrusted PTR_TO_MEM early return skips pointer offset tracking
because accesses go through probe-read handling. Moving it after full
pointer-state propagation ensures scalar += untrusted_pointer leaves the
destination as PTR_TO_MEM instead of an unrelated scalar.

Fixes: f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")
Tested-by: Daniel Wade <danjwade95@gmail.com>
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cdb61fab84351..fdc5fbb1f78ca 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13707,13 +13707,6 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	/*
-	 * Accesses to untrusted PTR_TO_MEM are done through probe
-	 * instructions, hence no need to track offsets.
-	 */
-	if (base_type(ptr_reg->type) == PTR_TO_MEM && (ptr_reg->type & PTR_UNTRUSTED))
-		return 0;
-
 	switch (base_type(ptr_reg->type)) {
 	case PTR_TO_CTX:
 	case PTR_TO_MAP_VALUE:
@@ -13750,6 +13743,13 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	if (dst_reg != ptr_reg)
 		*dst_reg = *ptr_reg;
 
+	/*
+	 * Accesses to untrusted PTR_TO_MEM are done through probe
+	 * instructions, hence no need to track offsets.
+	 */
+	if (base_type(ptr_reg->type) == PTR_TO_MEM && (ptr_reg->type & PTR_UNTRUSTED))
+		return 0;
+
 	if (!check_reg_sane_offset_scalar(env, off_reg, ptr_reg->type) ||
 	    !check_reg_sane_offset_ptr(env, ptr_reg, ptr_reg->type))
 		return -EINVAL;

-- 
2.43.0


