Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A673BBA03
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358776; cv=none; b=Fx402MTrq6el+l5um12mOAhu9AsZr6XSWlzjR0I6xlbTMghzc1AZqtJ4p4sigS808rdT3xks1FcL5vXWNuKdNUNVL7ODemS2co7mRZNEhZ0pCDyffGWRwiOCd2eWW3P1Lv8w7qNCmsnNDsb1IAwtcnJpzZBG9DS+GCbv1Xuczyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358776; c=relaxed/simple;
	bh=wVoK5fTqpuPaa7DgJBgo2MlKRv1ZOFxoGpE+MLJFejs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTh0/caQC4b3Z0g7yoy5lM5BuZWbJwLvS5icJAF2pcXf7K1UJtUAS385bH/bhIQA4sD5gxfjRfikVwRGflHX1IKcY3fu3lwEu4b0EmzXSFapNJv/X97URAx2fjGipg8eRje3wYhjF4U4Y3rxv5ezYsy/qc9m9p9OhRkrdbVvxhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=TmQPeSeL; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="TmQPeSeL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=MgBRl+AfKtJG9ub4T5qSfrzcN7hQoNLjBNJcCg9UYHA=; b=TmQPeSeLSkvGgGa3f4Q60HZ5Bt
	DqoG6NnPjJNPnk+OamkGJ0RJN+e1jL3N/McS6vpCh7xxzSUXn/HnErXWV2UX9D3V4hzOwCu49HipI
	X6W36xcbJLCbeDuYtH2BlKht0W8h0SvwrQdcGs732JzFxR7pPIFA6jt58M3CxOu7WtweR0HY3tptf
	3o9dooZrvvS53RyuKheKsir1EQJ6voif6doLl+WDkdz/6EU9G7yZ1DM5vHKyHMQFBuweCzrjbJtTH
	N+GV4JWyCZUEzTXpdKnZenQcOXIqgzFeoZG4oLxDMAgIXM4OMGujESyj2grvVRbze4RwHm8m/pqX8
	dN+6R4DQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xAA6N-000JkZ-0j;
	Fri, 25 Sep 2026 19:52:51 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: eddyz87@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 09/16] bpf: Clear the insn array used flag with release semantics
Date: Fri, 25 Sep 2026 19:52:36 +0200
Message-ID: <20260925175244.1136329-10-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925175244.1136329-1-daniel@iogearbox.net>
References: <20260925175244.1136329-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28134/Fri Sep 25 08:25:58 2026)

A program that fails after the JIT ran, for example in bpf_check_tail_call(),
has already stored its jitted offsets and target pointers into the insn array
maps it uses through bpf_prog_update_insn_ptrs() when release_insn_arrays()
hands them back by clearing the used flag with a plain atomic_set(). Nothing
orders those stores before the flag, so on a weakly ordered architecture they
can still be in flight when the next program takes the map: it is acquired
with atomic_xchg() in bpf_insn_array_init() and reset there, and the late
stores then land on top of whatever the new owner has written since, be it
that reset or the pointers its own JIT stored, leaving entries that point
into an image which is about to be freed.

Clear the flag with atomic_set_release() instead, so that everything the
releasing program stored is visible before the map can be acquired again.
This pairs with the fully ordered atomic_xchg() on the acquire side.

Fixes: b4ce5923e780 ("bpf, x86: add new map type: instructions array")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/bpf_insn_array.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index 5874abd1f743..61d6a076dfdb 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -232,7 +232,8 @@ void bpf_insn_array_release(struct bpf_map *map)
 {
 	struct bpf_insn_array *insn_array = cast_insn_array(map);
 
-	atomic_set(&insn_array->used, 0);
+	/* Paired with atomic_xchg() in bpf_insn_array_init(). */
+	atomic_set_release(&insn_array->used, 0);
 }
 
 void bpf_insn_array_adjust(struct bpf_map *map, u32 off, u32 len)
-- 
2.43.0

