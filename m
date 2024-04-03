Received: from smtp5.epfl.ch (smtp5.epfl.ch [128.178.224.8])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CC7155720
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 20:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.178.224.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175873; cv=none; b=tfBlkf2Cj5Ho9XP2WTmJqJVBJw6fyM/5tTJiKwhHTx5JqoXIYaq8BS2lVCY2zsUg7gzRXP7paED2R2B4J+BqcXpex9egeZuOSzNyNn7xZV16e1He+5rSx3zVz+pNbHDtArIZNaNPRFXrsWHbhr/RmVllZ2EGnKrnS8wQ8T/biv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175873; c=relaxed/simple;
	bh=lu4FdED6eu2h6JkIoCmHYAYfoNNabPDmQD171tm77Uw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QQ2P7+7i7j+NgYWBkV4n9R2kDVGqywwTBVJRr9PNFK93ah3POSMLMc60wWS+jpMcrZb/+0lFhF6kEjHp9R4B2S23AnUo9LqQ7LWv1sggEARLEWh/28/+W3qCUCOWHnozGc/svvkABhWqZXfR3Wuxb6Xgf0SERhBWk5HzUV4eCwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch; spf=pass smtp.mailfrom=epfl.ch; dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b=fQTgilWQ; arc=none smtp.client-ip=128.178.224.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epfl.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="fQTgilWQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1712175861;
      h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Content-Type;
      bh=lu4FdED6eu2h6JkIoCmHYAYfoNNabPDmQD171tm77Uw=;
      b=fQTgilWQ8ZX8XHCAub+GEgK66OO60t2uJtDebzKiYnjmCA139QDbjUl4Z41XeP+hH
        ih8xhFTOm9DZPf0fBpPdp8HQUlGuH0+FMEjsU6MHebwUHsHQcCefQ/qhnubHfI8yV
        Wun96ZFkshlnOUxlTc/L1fyHtuSY6/hpaZu7Dpgx8=
Received: (qmail 16817 invoked by uid 107); 3 Apr 2024 20:24:21 -0000
Received: from ax-snat-224-178.epfl.ch (HELO ewa07.intranet.epfl.ch) (192.168.224.178) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (P-256 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Wed, 03 Apr 2024 22:24:21 +0200
X-EPFL-Auth: 45zYhocep5rbeW+zLyH4JSTOawYeqiNA2wtqWKld77HYWHtmxus=
Received: from rs3labsrv2.iccluster.epfl.ch (10.90.46.62) by
 ewa07.intranet.epfl.ch (128.178.224.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 22:24:21 +0200
From: Tao Lyu <tao.lyu@epfl.ch>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <sanidhya.kashyap@epfl.ch>,
	<mathias.payer@nebelwelt.net>, <meng.xu.cs@uwaterloo.ca>, Tao Lyu
	<tao.lyu@epfl.ch>
Subject: [PATCH bpf-next] bpf: Fix verifier error due to narrower scalar spill onto 64-bit spilled scalar slots
Date: Wed, 3 Apr 2024 22:24:09 +0200
Message-ID: <20240403202409.2615469-1-tao.lyu@epfl.ch>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ewa09.intranet.epfl.ch (128.178.224.180) To
 ewa07.intranet.epfl.ch (128.178.224.178)

The verifier previously aimed to reject partial overwrite on an 8-byte stack slot
that contains a spilled pointer.
However, it rejects all partial stack overwrites
as long as the targeted stack slot is a spilled register,
because it does not check if the stack slot is a spilled pointer.

Finally, incomplete checks will result in the rejection of valid programs,
which spill narrower scalar values onto scalar slots, as shown below.

0: R1=ctx() R10=fp0
; asm volatile ( @ repro.bpf.c:679
0: (7a) *(u64 *)(r10 -8) = 1          ; R10=fp0 fp-8_w=1
1: (62) *(u32 *)(r10 -8) = 1
attempt to corrupt spilled pointer on stack
processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0.

The issue is fixed by adding a check on the spilled register type of targeted slots.

Fixes: ab125ed3ec1c ("bpf: fix check for attempt to corrupt spilled pointer")
Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 17c06f1505e4..3064ba7c140f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4493,6 +4493,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	 */
 	if (!env->allow_ptr_leaks &&
 	    is_spilled_reg(&state->stack[spi]) &&
+	    state->stack[spi].spilled_ptr.type != SCALAR_VALUE &&
 	    size != BPF_REG_SIZE) {
 		verbose(env, "attempt to corrupt spilled pointer on stack\n");
 		return -EACCES;
-- 
2.25.1

