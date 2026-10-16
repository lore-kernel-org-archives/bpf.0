Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28A22264A9
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166163; cv=none; b=O1Gi8M33IPchXFGqT7IUwpLid/BZRBMAnoDUcpudK58Osd/1nWzAI2wPGNxHpdWntjbWfEZuthLm80f1xjos7XUJShiD24gaddF9aqxIbgqckZXMlMHwSiwdvLtHwIkHvlXv41qQu4RM+KGcaW93T7t0DNk9XH8mXit0ziX6sV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166163; c=relaxed/simple;
	bh=L1UNh1CI6R3T/6CmY6f+YrNaXNBVD1eETVbYGlI9Sys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NMp2dLc8BgdEVssLpO0RTqqoPofQSshd6JZBhEAIInSzh1V/AiOc5QjDGpkhwi3EDyKwuroor6OXo6MLt1TTZQgDJtDsbHp/o906AVjtXUYicy0KUaJS46TZtwc7htZGYs/FeVHzeNVyojelIFmoMbb+vn6txtdTgdB1XHqQJr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=mHVYhtGK; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="mHVYhtGK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=/Nh1/Nd3rpMQ6ZQ1sf2Yn/VVM399ec7jKkIdv26W5Hs=; b=mHVYhtGKf4yolffiCSNpa34g7f
	6s+XFN3NyfC1KpubBvo+FFQlYrMmq2gRqu53sp9G9P3/gjWq8FC0Fy5pZBjnVFRyLU0uYH2PTX4Mz
	vfg018JYosnEu9+oWPvM4caOsQ6JiE8eT0z5pigh93IEsirQ3ZIX0qU+R23AG1T0jGmcoD4hXhicr
	uw4aCVgUgZD9iUj0y/4vStuRAAgLZ197o72EloxQDjWmDen8eR+BcBhT5DxJzR4fCydXukD+rhwr/
	oofhy7PokMaJEAgal9PFkX4G7nxNQvtc05DXKuoxJfBWhCF7TMkSQrTzZqNU7mJ8QYArVGhrrZ84R
	1xvYQJ9g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHkHn-000AbH-2H;
	Fri, 16 Oct 2026 17:55:59 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next] bpf: Free the subprog jump tables once the CFG passes are done
Date: Fri, 16 Oct 2026 17:55:59 +0200
Message-ID: <20261016155559.652461-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28155/Fri Oct 16 08:24:17 2026)

The jump tables which compute_subprog_jts() builds are only read through
bpf_insn_successors() once CFG discovery is done. Its last caller is
bpf_compute_scev(), which runs after bpf_compute_live_registers(), so
free the tables right after it instead of keeping them until the verifier
environment is torn down. With large insn_array maps, this also drops them
before do_check() starts to allocate states.

Dead code removal runs after do_check(), so a removed subprogram no longer
owns a table and adjust_subprog_starts_after_remove() can go back to not
caring about the table pointers.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 [ This was feedback to follow-up from a while back, forgot about it. ]

 kernel/bpf/fixups.c   | 9 +--------
 kernel/bpf/verifier.c | 2 ++
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index b2fa7e8bedf3..608621d7f225 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -477,11 +477,7 @@ static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
 
 	if (j > i) {
 		struct bpf_prog_aux *aux = env->prog->aux;
-		int move, k;
-
-		/* The removed subprogs own their jump tables. */
-		for (k = i; k < j; k++)
-			kvfree(env->subprog_info[k].jt);
+		int move;
 
 		/* move fake 'exit' subprog as well */
 		move = env->subprog_cnt + 1 - j;
@@ -489,9 +485,6 @@ static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
 		memmove(env->subprog_info + i,
 			env->subprog_info + j,
 			sizeof(*env->subprog_info) * move);
-		/* The vacated tail still holds copies of the moved entries. */
-		memset(env->subprog_info + i + move, 0,
-		       sizeof(*env->subprog_info) * (j - i));
 		env->subprog_cnt -= j - i;
 
 		/* remove func_info and its aux */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ec136cf377c1..62f8951126ba 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23487,6 +23487,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	bpf_free_subprog_jts(env);
+
 	ret = mark_fastcall_patterns(env);
 	if (ret < 0)
 		goto skip_full_check;
-- 
2.43.0

