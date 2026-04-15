Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297F633F360
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776255260; cv=none; b=lERVbFfyG/a80eb3dcOyRQ7VEZHMPvo9CFVomLB7WWmTtIj12vduRXtUR5x/FDAmULb+RGmVEmbUhXzRd3aruoZ0fZcN1LC6qHDKrDHfHkyCJKF0140l3xBo8WFlUduUF+BFVIWAtMTdZjMpag8DoZWzVJ94XZHwdX9MO/1I7MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776255260; c=relaxed/simple;
	bh=OTbmcpPopF/q5WN3SxXQZ84EifcUWEqrEwadLM92nMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8e/fOeTBlmKN3tWXbKMNReKI6LiE/SDjEWQ00EgpOv0DdekKqBmfLyl6r9I+fuMZXoXStwg23zUsiG0PRfGPnBgCMoxLx6iIJ7+4QXxuLsEEWwXFWPG3IQnwkfJJeh7+8wi7bKfEl8pm+kXZVJRHw5DohhNhaw72o7acUaUtHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=CpQZEA7P; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="CpQZEA7P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=t/FjB81Wf4zBO51ZRqSfUlWpqnZy0bmS/Th+DC7btpc=; b=CpQZEA7PJg4058fHZZRDPYRo6g
	L1/hidXIXpxcuUOScPt00lr7+KkvMM83+q0torVjKOpZ+7I/SA6c2ZRqERJnIesbtOXGIDg0nYUZW
	178/Vze88zeNGFnrqiQPeRwKCLqso0p2MC0+8TBs2IBeU/GVpHbgPILchA7ufRvlLoVYqZl1SlzYk
	yezrD2BCRGxRod30tVEoQW79qptEj4zAPs+FEQJZncdpfKOYCrXA3EeTELq/3v3pd/Sej+IMNa5Ah
	oYs/47FqC68pqzhKq+ntmc93GYkVyETCcKfscXE/E5EijIbXhnjrSECiLDOagFMFIHyPYu8lrK7/j
	T/hETtiA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wCz89-000Os4-0T;
	Wed, 15 Apr 2026 14:14:05 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	puranjay@kernel.org,
	xukuohai@huaweicloud.com
Subject: [PATCH bpf 2/2] bpf, arm64: Fix off-by-one in check_imm signed range check
Date: Wed, 15 Apr 2026 14:14:03 +0200
Message-ID: <20260415121403.639619-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415121403.639619-1-daniel@iogearbox.net>
References: <20260415121403.639619-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27972/Wed Apr 15 08:24:27 2026)

check_imm(bits, imm) is used in the arm64 BPF JIT to verify that
a branch displacement (in arm64 instruction units) fits into the
signed N-bit immediate field of a B, B.cond or CBZ/CBNZ encoding
before it is handed to the encoder. The macro currently tests for
(imm > 0 && imm >> bits) || (imm < 0 && ~imm >> bits) which admits
values in [-2^N, 2^N) — effectively a signed (N+1)-bit range. A
signed N-bit field only holds [-2^(N-1), 2^(N-1)), so the check
admits one extra bit of range on each side.

In particular, for check_imm19(), values in [2^18, 2^19) slip past
the check but do not fit into the 19-bit signed imm19 field of
B.cond. aarch64_insn_encode_immediate() then masks the raw value
into the 19-bit field, setting bit 18 (the sign bit) and flipping
a forward branch into a backward one. Same class of issue exists
for check_imm26() and the B/BL encoding. Shift by (bits - 1)
instead of bits so the actual signed N-bit range is enforced.

Fixes: e54bcde3d69d ("arm64: eBPF JIT compiler")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index adf84962d579..4aad9483f8a5 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -35,8 +35,8 @@
 #define ARENA_VM_START (MAX_BPF_JIT_REG + 5)
 
 #define check_imm(bits, imm) do {				\
-	if ((((imm) > 0) && ((imm) >> (bits))) ||		\
-	    (((imm) < 0) && (~(imm) >> (bits)))) {		\
+	if ((((imm) > 0) && ((imm) >> ((bits) - 1))) ||		\
+	    (((imm) < 0) && (~(imm) >> ((bits) - 1)))) {	\
 		pr_info("[%2d] imm=%d(0x%x) out of range\n",	\
 			i, imm, imm);				\
 		return -EINVAL;					\
-- 
2.43.0

