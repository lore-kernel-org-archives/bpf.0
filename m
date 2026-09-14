Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A656494812
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405418; cv=none; b=gtKKu30F0k8ZMoZOHrlN5H+dXzp26fqloYKE3f2k2byqfE4cKY/izWy8zgNZFJ5DpIqOuiXN5YePGz4Y3R6FRL8EKPQxfS5lxJBejKB1Y6KrVzFk8NfPWcDXxTbZaTT3fMm6JwMiYM8w741ZuG0YwrKaH9DrlcJFDEHJDVdqvY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405418; c=relaxed/simple;
	bh=9IocgP8dCpDFsehasK0v8clcvjpNIgHxthilx3yNxdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWKXGyXlen0rXDEAOADsgTPBlcBQsApCthiRs1X+J07s5r8mGjIz8GDOdhgrhwGITojalWkb/KuIRlk41Vkb5VD79SkKGRs0PjMKc2JnKvhjb3h3RBUzKfeHj/tTejPPVg3IEXHvkyqT3NEH40t+DinLD/Mk3NHU6EZrPVEuBxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=MuQrpa5n; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="MuQrpa5n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ACqMDegPgUjeEpc5R88Nonq3vk35vHeDTjDsCIGA+Cs=; b=MuQrpa5nYABJpxPUscuEudDbqD
	T3W1/FX3Wlqr6dLYs6EB52HWbzGYJfXc/onelPEar6j9KPTJMzoyqgF3EYAf6UH6afPQuS6SjrdTv
	Py/ff+LL02jgSBxzuUWoF211NWEo0x00ZXyGtkm+rPcnuPd/pHWUebBXvulP8YjJ2swMS5VcrkYrC
	nM4mM5ITGu8CFtd8n0zUmZB2GFCO8S5V4luoEPjNXs2oR9MuHlzhOC46jZpbfCQ9BaWEMHoKikhFv
	bNHKa1dtaeGsODMeFPhjZaB4F1FErotcfNqMIDvyHIsTE9pZWLPwKDO1CAd1j+B7Y/u6EXxBCFAdf
	kvFv4C1Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x6A5b-000C94-1i;
	Mon, 14 Sep 2026 19:03:31 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	eddyz87@gmail.com,
	a.s.protopopov@gmail.com,
	info@starlabs.sg,
	bpf@vger.kernel.org,
	Sandipan Roy <saroy@redhat.com>,
	James Burton <jamesburton@meta.com>
Subject: [PATCH bpf v2 06/11] bpf: Clear insn array jitted pointers on map reuse
Date: Mon, 14 Sep 2026 19:03:21 +0200
Message-ID: <20260914170326.249953-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914170326.249953-1-daniel@iogearbox.net>
References: <20260914170326.249953-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28123/Mon Sep 14 08:24:19 2026)

An insn array records, per entry, the xlated offset, the jitted offset and
a jitted target pointer in ips[]. bpf_insn_array_init() runs when the map
is bound to a program and resets only xlated_off; the jitted offset and the
ips[] pointer are left as the previous owner set them. A program can be
verified and JITed and only then fail to load (e.g. bpf_check_tail_call()).
By that point bpf_prog_update_insn_ptrs() has already filled ips[] with
pointers into that program's JIT image. Thus, the map is handed back for
reuse with the stale pointers intact. If the next program reuses the map,
the stale pointer survived the now active program's jump table, pointing
into the previous, freed image. Fix by resetting the jitted offset and the
ips[] pointer alongside the xlated offset.

Fixes: b4ce5923e780 ("bpf, x86: add new map type: instructions array")
Reported-by: Sandipan Roy <saroy@redhat.com>
Reported-by: James Burton <jamesburton@meta.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
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

