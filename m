Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166054;
	b=UgUPo+7s1g+ipb4gQXCAQyBEJBUlZ2rNG/DepuFNEXbiTnWC0VIvpAoT3KVf5UUUSrre
	 er15upDrY+otMSR4p45KwSVfG48Dru7Jmy/DjHXp9ACDMGCufdBkOKz1NY6uZvJ/CSRF1
	 aJLewSfp4mspdh1J6tiFrUpNrLN+zfz8+e3Tl1ns6FsZgGZwGwqHcrWA7wVkMw4Jbwbkg
	 m9NegftE06YX6PKvsVS6YINbrOBICMz+lfxUixU3CgxxZWcbhR6NRyMVjK9IgAKvJBFYQ
	 n9/eRZg7CoG9yEvM63pZRhJtoi3MlKGOhPPTDl5TlLPJ0LpQfVFpOjHbkabrHPSRPvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166054;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=BrjfaYsn8jGO/lX5TEsq7rFH6mIu6GGCV33oDhkiSfk=;
	b=db5xXsCo2fLPxvm+MJYQ1kaAEL15Q2RuvKN8K46mzUWBX3aIIY25z0gr+t4bYDit3SUK
	 xWWywBX4icTtKuPIsf5v+WXVX5nLPYQ5E36PKxKiNNKqALPsauFOjLxetXaNRvzMYSknM
	 Hhb/YQ7xJdmxrLMTGFpv49buZr4aMFlqfdfCy12DFzlvf5GAO6qOa0T/oCgn6cqnKjuU4
	 hZTvypjKgS3sQf7ZbS/m6+dXem7Fz42K0mrRjGnRyyuAyTD1mY+at0PqY3QAVzVDGW75K
	 321j5fRgzuYwGt7xF5rZ6eS7p3sdgx6ZWttCisrlUVrpOcWLucYHKhhS5iFDN9ln8Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=Sdd+ukRI;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F9F606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40F9F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=Sdd+ukRI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=BrjfaYsn8jGO/lX5TEsq7rFH6mIu6GGCV33oDhkiSfk=; b=Sdd+ukRIo646A3NTxqD2TceUr9
	qtVRcfTaHexxZ00QnqI0G6vGuHVWFr9LUN5GpL/9PkENtvsD8Ta6cUnbJSJc8X6KIK4JV9R4vY3/s
	cxv1nSeB8cAJGujh0A83I/UBYVh6MgPaTWZqHXBwLr9xJg9cutEOmsFN0TYl2Bw25pifWjUMEWLYt
	XR7RKPjOafHtR9DIEYdH5sHpKikXuqmv1m3iKuIQaZJd4XvqPZS1b4+v0fGPTQbT3qGhJ/4xPqyxk
	764bWPcOWOaawMuMAwVfrMZktsdM+3G8T68DDS8cO0CoCAJ6dlhdgIFKDL/ar+9Y10R8CP3iafNd+
	JRBsaXiA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8Y8-000Pjh-0F;
	Sun, 08 Nov 2026 20:27:32 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 07/24] bpf, arm64: Measure backward branches from the branch itself
Date: Sun,  8 Nov 2026 20:26:33 +0100
Message-ID: <88f0520fdea7ffdf1ccdc2d5867272b95e6d4c1f.1794165614.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794165614.git.daniel@iogearbox.net>
References: <cover.1794165614.git.daniel@iogearbox.net>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28177/Sun Nov  8 07:23:52 2026)

bpf2a64_offset() takes the position of a branch from the offset of the
next BPF instruction, which the current pass has not set yet:

  - In the sizing pass that offset is still 0, so a branch back gets
    the target's instruction index plus one as its offset. This exceeds
    the imm19 maximum of 2^18 - 1 instructions once the target is at
    index 2^18 - 1 or later, i.e. 4 bytes short of 1MB into the image,
    and check_imm19() fails the program.
  - In the second pass it still holds the value from the first pass,
    so a branch back is overestimated by however much the code in
    front of it shrank.

For a branch back, take ctx->idx instead, which is the position of the
branch in every pass.

Fixes: 2589726d12a1 ("bpf: introduce bounded loops")
Fixes: ddbe9ec55039 ("bpf, arm64: Jit BPF_CALL to direct call when possible")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit_comp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index fa57783d7014..3403f4327de8 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -267,6 +267,12 @@ static inline int bpf2a64_offset(int bpf_insn, int off,
 {
 	/* BPF JMP offset is relative to the next instruction */
 	bpf_insn++;
+	/*
+	 * A branch back counts from itself, as the offsets from the next
+	 * instruction on are not yet those of this pass.
+	 */
+	if (off < 0)
+		return ctx->offset[bpf_insn + off] - ctx->idx;
 	/*
 	 * Whereas arm64 branch instructions encode the offset
 	 * from the branch itself, so we must subtract 1 from the
-- 
2.43.0

