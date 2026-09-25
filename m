Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32F549DB8A
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358778; cv=none; b=VC8xdKOFlSWgL1rnuuFrVPPSGN6bZ28PyOpROHq8CfSItf7qyOh0Uj2+T/96eRfAkLEPK78iyTQQLQsMj2njimRcrvd6Lqkz0KGeN6X1+pGFwv8oNSAgog3kOMoNmD7aKDZeRGy5wQJWAwCnPk80FxqSsLrTBcgLHdVI8rhh8jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358778; c=relaxed/simple;
	bh=w+XHGAzlBPSVVbyIuPD4cbWyeUzapdJiWM1zQW6CP/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sg4/cbBACSI3OS9Xu6XnD95jV2iHtXLKkLs8W+ARDrM1zJ0NsioRGOnwVyKSsl1Bi13fShIYn4PQWn06+D7b6dSs0q26Ja1UrvCh3kgG9DOcsUlRyD5nFWCNvTEfRP9A1CA/Oh6m04MA49Fc3mG0bcOsFBAu6BsF9co8Y8Y+f8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=fHoYodj2; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="fHoYodj2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=V/viImFnRI1FfxOhA9RyN1ecz/tNzKlDHuqvJQaAViY=; b=fHoYodj2GKR8j4/PDCg1uYWAiB
	dbwb14TfXV2n55+2AG9xLZgXn/pYMOphPbeynXM6HEEIQqABOmVs9XNLJkcMWKImuUAFTbZ1qZkn2
	9zpVS3tRP8PilQvi3QuAY5w/vFXmjyZEQbJk+SwvBsEQsuwTh92Pb5LMnteW6pyU2RB+CxbzySbqz
	B4CUe3Ei3UfJBotmL2t3Z9Y0z8zt6d+jdECAZwT2rZ+tEPYHNOaEVBbckS9LDHuW0qhxDNyDnXnO2
	DOySmFBijrj2uFEieyLQNORmo+GZK2iJG+iFj91nBPPrpuJrddi6FaL23nUQ+G/d4Sqyx6uIhF9Ic
	xMRV+wHw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xAA6M-000JkN-23;
	Fri, 25 Sep 2026 19:52:50 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: eddyz87@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Sandipan Roy <saroy@redhat.com>,
	James Burton <jamesburton@meta.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next v3 08/16] bpf: Clear insn array jitted pointers on map reuse
Date: Fri, 25 Sep 2026 19:52:35 +0200
Message-ID: <20260925175244.1136329-9-daniel@iogearbox.net>
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

An insn array records, per entry, the xlated offset, the jitted offset and
a jitted target pointer in ips[]. bpf_insn_array_init() runs when the map
is bound to a program and resets only xlated_off; the jitted offset and the
ips[] pointer are left as the previous owner set them. A program can be
verified and JITed and only then fail to load (e.g. bpf_check_tail_call()).
By that point bpf_prog_update_insn_ptrs() has already filled ips[] with
pointers into that program's JIT image. Thus, the map is handed back for
reuse with the stale pointers intact. If the next program reuses the map,
the stale pointer survives in the now active program's jump table,
pointing into the previous, freed image. Fix by resetting the jitted offset
and the ips[] pointer alongside the xlated offset.

Fixes: b4ce5923e780 ("bpf, x86: add new map type: instructions array")
Reported-by: Sandipan Roy <saroy@redhat.com>
Reported-by: James Burton <jamesburton@meta.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/bpf_insn_array.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index a2f84afe6f7c..5874abd1f743 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -199,12 +199,16 @@ int bpf_insn_array_init(struct bpf_map *map, const struct bpf_prog *prog)
 		return -EBUSY;
 
 	/*
-	 * Reset all the map indexes to the original values.  This is needed,
-	 * e.g., when a replay of verification with different log level should
-	 * be performed.
+	 * Reset the map to its pre-verification state. The xlated and jitted
+	 * offsets and the jitted target pointers are recomputed by the verifier
+	 * and the JIT for this program, so any values left by a previous owner
+	 * must be cleared here.
 	 */
-	for (i = 0; i < map->max_entries; i++)
+	for (i = 0; i < map->max_entries; i++) {
 		values[i].xlated_off = values[i].orig_off;
+		values[i].jitted_off = 0;
+		insn_array->ips[i] = 0;
+	}
 
 	return 0;
 }
-- 
2.43.0

