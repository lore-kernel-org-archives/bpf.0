Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41731340DB8
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 20:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785874770; cv=none; b=iCDemqwR0qHxXDdoTD0Y6bT8HBJ0M8HfIpxWsJKAfkXxNPBQxiUbboYpRWf+mcvt4lpdDUZaXvzRl80KFqwciGwCutSVrQrcKxTUgszSQwK+J+MM1ylgU3dZWq1ghADMMqm3btb39gWZmVrF05NDd4GP4kTQ8Q4+lVluYyDIpSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785874770; c=relaxed/simple;
	bh=ecjIvngP3telFgZsaXxv4hfAntIXaaeNL67ThUgRsXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jjy6DVAx1/5HBERoEoOMKcgocmjSTjxYeZ8R0sNdrukqMdMxAK/8mTVu2afBbsDvBK3An17P9Xxqq54024mdQ1qE2NnNJ0wXe91aRf3UziYV+mbUjZnSVQInnT4Xik/BitwExNz6JSYtR2cxjwMIKzFDYM8+Qp9LsMhLGS6GInc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=LwA+gqt9; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="LwA+gqt9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=t/DGvHSMGfKHmADRnXsC6hWmPz4+CNRGqBFEGxfuqPM=; b=LwA+gqt9P1YXmxPfp6/sEd7NSw
	oqemRUzZ0x/fLsV7oPrkcIhFU98UpP7aFA+BQo2shJNFYTi62MDrvmm9+4/JhJ3nIL6dNFEPxwpCb
	IF0jty9fOXAXt3AignsxhuQ/5fkrdFWRJi37bGqjS3YeIUpOqvEHBHhyQyESnK378XVHRRcs+3D6q
	828AwpVUc+TwS0l6nCDgeJmU+9iJ8UtTqJicoLNrnpmoGj6DB3N7MsjQRP+RTG5VLNsfzG2Tb/1Z2
	d/voW8QXEJ6AHUJvTJ6tG3+0JyOz8TgrtiCPPh83UYYuu8fJK7iGdrlkAVo4zUCMiZoaRpeajuZwq
	CaQ8WqJA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wrLba-000Naz-1j;
	Tue, 04 Aug 2026 22:19:18 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: Check load-acquire src ptr type before the load
Date: Tue,  4 Aug 2026 22:19:16 +0200
Message-ID: <20260804201917.253491-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28082/Tue Aug  4 08:24:26 2026)

check_atomic_load() calls check_load_mem() before atomic_ptr_type_ok().
For a load-acquire that fetches into its own source register (dst_reg ==
src_reg), check_load_mem() overwrites src_reg's type with the type of the
loaded value, so the subsequent atomic_ptr_type_ok() no longer sees the
source pointer and fails to reject the disallowed types (ctx, pkt,
flow_keys, sock).

Since bpf_convert_ctx_accesses() does not rewrite atomic loads, the raw
access to the underlying kernel object is left in place. The destination
type is taken from the ctx access itself, so a load-acquire of the sk
field of struct __sk_buff for example leaves the register typed as
PTR_TO_SOCK_COMMON_OR_NULL, which type_is_sk_pointer() does not match
either, while it actually holds unconverted struct sk_buff bytes. Once
the NULL check has passed this is a type confusion, not just a leak of
kernel data.

Validate src_reg with check_reg_arg() and check the source pointer type
with atomic_ptr_type_ok() before the load again, mirroring
check_atomic_rmw(). Out-of-range register numbers are already rejected
earlier by check_and_resolve_insns() (commit 503d21ef8eac ("bpf: Do
register range validation early")), and the only exemption there,
is_stack_arg_ldx(), requires BPF_LDX | BPF_MEM | BPF_DW and thus never
matches a BPF_ATOMIC insn. atomic_ptr_type_ok() can therefore not
dereference register state out of bounds, that is, the out-of-bounds
read addressed by the Fixes commit below does not reappear (as proven
also via selftest).

Fixes: c03bb2fa327e ("bpf: Fix out-of-bounds read in check_atomic_load/store()")
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b274004fccfd..9513e18836c2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6616,7 +6616,7 @@ static int check_atomic_load(struct bpf_verifier_env *env,
 {
 	int err;
 
-	err = check_load_mem(env, insn, true, false, false, "atomic_load");
+	err = check_reg_arg(env, insn->src_reg, SRC_OP);
 	if (err)
 		return err;
 
@@ -6627,7 +6627,7 @@ static int check_atomic_load(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	return 0;
+	return check_load_mem(env, insn, true, false, false, "atomic_load");
 }
 
 static int check_atomic_store(struct bpf_verifier_env *env,
-- 
2.43.0

