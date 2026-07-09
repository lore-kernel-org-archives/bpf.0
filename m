Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEF62DB78B
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611097; cv=none; b=lsQD4ek8GZ+g5JIXE80xM3rsbX3gtBI3NKEVQTbwTwRbFEvOooWrYWdsKeAPOn7M4jiscwLud0amC0wuew27UOImjZ6efA5khISLnqzVcCWTUoBedAW4kcADzR/8eTNUvN7LYmKxujS7Sl9/UWBPnpcVKQhKh4DY5tWTlEfPy1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611097; c=relaxed/simple;
	bh=ffYKnvNMgDILkQQ6R2JzR3raRnZZ/rTOBb6FYmGpSYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q4LdAW9cMkJCufoj4iHqu9EgMJSdhFBoqXcsPxpQtUbMyJpoNLddaYZTpHqeqE+H/WkklOcmXRdXd0VNW0LbClkikFJNE+/lCroGtvsQ8pFrzvkUCXhXzwpoIghF7JGpwTZp+Z29tT8na9cksCKKQGLNx4X3GfU/guRUDENEHdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=GCeSx9RK; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="GCeSx9RK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=ph0D6DVrkT0iq0ujgtBEyoUZhLb+P7+h7gdkGkD3pIs=; b=GCeSx9RK3h5j2R3M14KJJZKHTo
	XyTWh3XCatv4OVYpZthl1dkdlarUe0nAtEU4UiuqJBAgzl7hcx5li+8WGo5F0yWerIHXEz7nF8jBw
	O4BkIKqR+MSU+x3tl8fvmoHfgR1njKPymET8zRX82K8Gd8YTekQOIintGmANQ4y28ZFebRiUvNJoU
	UBJVa7IYB0kDO7vTXCJCg56PtAQ79LQy+QiVY3klXaw1zeidLZ/Bl6JQpgBXknhIwcZpircAyVdPM
	F+X+pN5weXsiAKcyIj9Ah0xHVVnGY/C4b2s9557EzBT20RGgKfRCV8OFbS4X5u7pf0RJWD2Pg1Kmo
	VlrpKjkg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1whqiq-0007da-0G;
	Thu, 09 Jul 2026 17:31:32 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: eddyz87@gmail.com
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: Drop scalar id on sign-extending narrowing stack fills
Date: Thu,  9 Jul 2026 17:31:30 +0200
Message-ID: <20260709153131.386599-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28055/Thu Jul  9 08:25:20 2026)

When a spilled scalar is filled back with a sign-extending narrowing load
(BPF_MEMSX), check_stack_read_fixed_off() copies the spilled register
including its scalar id, but coerce_reg_to_size_sx() then sign-extends the
filled register's value. If the same slot is also filled with a plain
zero-extending load (BPF_MEM), both destination registers share the id yet
hold different values. A later 'if <zext-reg> == const' then refines the
sign-extended register through sync_linked_regs() to a value it does not
have at runtime (e.g. the verifier believes 0x80000000 while the register
is 0xffffffff80000000), which can be turned into an out-of-bounds access.

Drop the shared scalar id at the sign-extension site in check_mem_access()
when sign extension actually changes the value, mirroring the BPF_MOVSX
handling in check_alu_op() (no_sext = reg_umax < 2^(size*8-1)).

Fixes: 3cd5c890652b ("bpf: Let the verifier assign ids on stack fills")
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Puranjay Mohan <puranjay@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 233472a871be..a0830ad6bebb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6394,11 +6394,23 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 
 	if (!err && size < BPF_REG_SIZE && value_regno >= 0 && t == BPF_READ &&
 	    regs[value_regno].type == SCALAR_VALUE) {
-		if (!is_ldsx)
+		if (!is_ldsx) {
 			/* b/h/w load zero-extends, mark upper bits as known 0 */
 			coerce_reg_to_size(&regs[value_regno], size);
-		else
+		} else {
+			/*
+			 * Sign-extension can change the register value relative
+			 * to a scalar it is linked with by id (e.g. a zero-
+			 * extending fill of the same spilled stack slot), thus
+			 * drop the shared id in that case.
+			 */
+			bool no_sext = reg_umax(&regs[value_regno]) <
+					(1ULL << (size * BITS_PER_BYTE - 1));
+
 			coerce_reg_to_size_sx(&regs[value_regno], size);
+			if (!no_sext)
+				clear_scalar_id(&regs[value_regno]);
+		}
 	}
 	return err;
 }
-- 
2.43.0

