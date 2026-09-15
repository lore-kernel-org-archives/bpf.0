Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94783DFC7B
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484874; cv=none; b=qS5M5HKgfxmJPcE3pxqyYL2ZAj2nhs629tZeZda3IxUUCVwFPtWgTxmcY9uAuVCI1TDlcYS+WIV9Fi+OQvQuyCAy8dHchmq5JgBTyYi2o1P13Alp73Bm1vixsVoTdeKMzkpawV0p1m8S+yuhpuvjdPVBRghL3ujNBkotLbnRWMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484874; c=relaxed/simple;
	bh=Vs81Pu2DHU+baAdt5MAF2w2pLumwRVnDcyx3Ae7KfXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqyO/C39lcepbGYk2RMBr+MX2frByxlL4k5f14iTVbM1BTl/C+8eowMtFh17nmmZ7F1KyFbUoz7NlmuYXq9bCjNKQiXf1ywOiTN2SwpSWhiyd2E0HNosmdGgxnspIDoA6gul+xDKOZ93YNE43zvrEYryGW7ZnG5B8nZybw+CS4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=rNIVvq0T; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="rNIVvq0T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=gwTcjvm+MhrLWIHKZpjnwxdid3hWVcCCLsT0cEtwTg4=; b=rNIVvq0TjbImqVXw3ydgmjVWHt
	TBosCyD9ciabWegHiAOdQwcN9RWk8htBbJV6OMTkPVySRH9vdhqDhTYw8KLo5/oAy21DISDf3TbuL
	udfviXMs9isO3ey1dhtNM6wrRlM7PY59YiXOcFzgedSexZiodomFsLxofxLzWIm1OBvi32ZVlD501
	OjpbIYvSwVFaCVxSsMKCK6Sf5ahlynY/NFyqrdKXgDHnKBh5odqSbF0/TpbjWE6t7ioLwiq+0SqB2
	5IzLb3xpd0Di+noofNr6mVN0wmX7oizTBIoRHCiHajDUDgAj2+3QaRRAvqjyXHFI2DggcPENRw1Ah
	cMpv4n6w==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x6Ul4-0007KA-1x;
	Tue, 15 Sep 2026 17:07:42 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: brauner@kernel.org,
	dwindsor@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 2/8] bpf, lsm: Reject writes into the BPF LSM program context
Date: Tue, 15 Sep 2026 17:07:33 +0200
Message-ID: <20260915150739.284189-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915150739.284189-1-daniel@iogearbox.net>
References: <20260915150739.284189-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28124/Tue Sep 15 08:27:28 2026)

The verifier types a load from a tracing-style context by its offset
alone: btf_ctx_access() looks the offset up in the attach hook's
prototype, and check_mem_access() stamps the resulting type onto the
destination register. Nothing tracks what the slot actually holds.
That is sound only as long as the context is read-only, and for BPF LSM
it is not. lsm_verifier_ops wires ->is_valid_access() straight to
btf_ctx_access(), which never looks at enum bpf_access_type, so a store
into the context passes verification. Every other user of the helper
either goes through bpf_tracing_btf_ctx_access() or open-codes the same
type != BPF_READ test first; BPF LSM is the only one that does neither.

A program can therefore store a scalar of its choosing into a context
slot, read the slot back, and get a register the verifier believes is a
trusted pointer of the hook's argument type. Handing that to a kfunc or
helper which dereferences a trusted argument turns it into an arbitrary
kernel access. Route BPF LSM through bpf_tracing_btf_ctx_access() like
everyone else.

Fixes: fc611f47f218 ("bpf: Introduce BPF_PROG_TYPE_LSM")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/bpf_lsm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 82c5988417a0..2660a89fc8d7 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -414,8 +414,8 @@ const struct bpf_prog_ops lsm_prog_ops = {
 };
 
 const struct bpf_verifier_ops lsm_verifier_ops = {
-	.get_func_proto = bpf_lsm_func_proto,
-	.is_valid_access = btf_ctx_access,
+	.get_func_proto		= bpf_lsm_func_proto,
+	.is_valid_access	= bpf_tracing_btf_ctx_access,
 };
 
 /* hooks return 0 or 1 */
-- 
2.43.0

