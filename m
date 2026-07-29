Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549BC4779BE;
	Wed, 29 Jul 2026 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338331; cv=none; b=fXF5RLYePzV8bwpNFOqwmOniXtSQEQWmt3GXcBKOrWt+f2eTUorhOCmfI2v+tiIEO9YJfagf2BU6aX7b+rR1IL4xXBokYpha+4xRqK1kfebrSHm/Oy0qct2yUU1dBkQ0B6AAo0//IqvZKbSSop+yImKN3T3UOvRQ+6ZvfvbghOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338331; c=relaxed/simple;
	bh=FNSgpAJxGHg9kFdUUUaqzA9CuGsLlkZNV9gqbnU20jU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JQsOaBKEWl1dI0Vtvw2Wyf8UP0ew0B6f/+U3YJK7Pzo2eSO+7sy2++ntijPNvw7U/Ta+nw3Oh8+bdqdYVdftUrT9z5b9eZP10l/B5WNDbDilO5ivcbOachb1JUPt7Z8mLkDyUPwNHmYgj6hIxghtZCdsGlPzTIC2LtpiY5EE3BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6T84YBf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6T84YBf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A8D6C2BCF5;
	Wed, 29 Jul 2026 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785338330;
	bh=FNSgpAJxGHg9kFdUUUaqzA9CuGsLlkZNV9gqbnU20jU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Y6T84YBfHqz3KSm6wajSLuM0qkXSbUYAFhLdrxR5LLq1LnGZvSESekp7ozbBjgyYZ
	 Czi/O6NSOmtIzfGO9AlRe1FEtkwaEXKETo9r3FQbnU1k/KLiiBVHt2GxuTZDM7ZsP5
	 /5l6Xs6o6uONYus8/GiJ2ncfCl3M9OlRGOQOMDYIxzqhTx0rsrFTQqFRSZQuUhsth5
	 c2nVLSO6gVdJKSV9pB2zNF2G8IWXcNisls5pXt+OqqE8BQ1GgrqJLcyR/8q/AivgEL
	 +DyOtv6u5J+yPgZB4g0CVS+mdEYra2gmlvAsjKn/TWirhpr9l4iXkK2NUkPbGXmqXR
	 X5CW0bpu4AluA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A18BC54F55;
	Wed, 29 Jul 2026 15:18:50 +0000 (UTC)
From: Yiyang Chen via B4 Relay <devnull+chenyy23.mails.tsinghua.edu.cn@kernel.org>
Date: Wed, 29 Jul 2026 15:18:28 +0000
Subject: [PATCH bpf v4 2/4] bpf: Preserve pointer state for commuted
 arithmetic
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-c3-035-public-bpf-v4-v4-2-8ee297e2346b@mails.tsinghua.edu.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785338329; l=2493;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=XQur2Ha7xVzrdNs8jsFFaIPeEzwoqH2YGARgnVjxXF0=;
 b=PkxU4TzQv9tc7Z5GVBpbuzm28zweJinwkAo1/rrjSr2Wg/+x/bCU6DJ7RPpDtMBeXl92WZ97/
 u/iF6TdrvLyC41l/thi2GguN1lZOrSe6lpqHyrvIo1zJORmCuwzYiT6
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-Endpoint-Received: by B4 Relay for chenyy23@mails.tsinghua.edu.cn/kernel
 with auth_id=900
X-Original-From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Reply-To: chenyy23@mails.tsinghua.edu.cn

From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

When scalar += pointer is handled in adjust_ptr_min_max_vals(), the
destination register inherits the pointer state from the source pointer.
Copying only selected fields is fragile because pointer provenance is
tracked by several bpf_reg_state fields.

Use the caller's temporary offset register to preserve the scalar operand
while replacing the destination with the full pointer state. This preserves
the frame number for PTR_TO_STACK registers and keeps parent identity
fields consistent.

Fixes: f4d7e40a5b71 ("bpf: introduce function calls (verification)")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Tested-by: Daniel Wade <danjwade95@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9792d6622ffd6..cdb61fab84351 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13743,11 +13743,12 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	/* In case of 'scalar += pointer', dst_reg inherits pointer type and id.
-	 * The id may be overwritten later if we create a new variable offset.
+	/* For 'scalar += pointer', dst_reg inherits the complete pointer
+	 * register state. Individual fields may be adjusted later by pointer
+	 * arithmetic. Callers guarantee that below does not overwrite off_reg.
 	 */
-	dst_reg->type = ptr_reg->type;
-	dst_reg->id = ptr_reg->id;
+	if (dst_reg != ptr_reg)
+		*dst_reg = *ptr_reg;
 
 	if (!check_reg_sane_offset_scalar(env, off_reg, ptr_reg->type) ||
 	    !check_reg_sane_offset_ptr(env, ptr_reg, ptr_reg->type))
@@ -13790,7 +13791,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		}
 		break;
 	case BPF_SUB:
-		if (dst_reg == off_reg) {
+		if (dst_reg != ptr_reg) {
 			/* scalar -= pointer.  Creates an unknown scalar */
 			verbose(env, "R%d tried to subtract pointer from scalar\n",
 				dst);
@@ -14808,8 +14809,8 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 				err = mark_chain_precision(env, insn->dst_reg);
 				if (err)
 					return err;
-				return adjust_ptr_min_max_vals(env, insn,
-							       src_reg, dst_reg);
+				off_reg = *dst_reg;
+				return adjust_ptr_min_max_vals(env, insn, src_reg, &off_reg);
 			}
 		} else if (ptr_reg) {
 			/* pointer += scalar */

-- 
2.43.0


