Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793645924;
	b=JYMfDjik139VzuOx1g6QIqLDojiGVaFxQ8rtuhCHi8MTKd0/mN/pioy5Gfj0B/qhWQYC
	 aXIclxu5lX3o7N/vR02x88kS237FEDQAGnBh1SUYNFCcgewZVKn/ueHEtfd94iJIYKdce
	 OA527Gc+6UxlBFPXlwzsYMGZ8Zt6AZUCLw0uLytukyqxTJTQR0sU+ZANdRIlWkwNnMqOR
	 izM3k6P8wDaeUexRHGT9SPofl3Q6mqV2LS5ueidH4XETHPIt+0q9LIJx4A6EkxCM7z3CL
	 thf26BrkLKI6FH965S/RBapfPqsGEdm/vENvgeC+D3SHaCtRKrJww6PKNrXGEUKLgzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645924;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=am9gbO9t1laaBz+RQEep0XjQMIvSeDCOgIen9Lu53BI=;
	b=olTKl7DDMFssWONXNAotU/n+E5qOgCK1p+QX57mz2Kxryj011D/cQW7v1zL4/mn0Z2qK
	 4pDFNbRmwxEt9/WH4e77HpV3FcA2pB5bECncRUn6Tmd93luWXqSVAeUALZmBEr6TrCzEE
	 7V2Yqsghuy0AUUWVf23OSit2z1jhr3E+6H9xiHwaSHIvHt/Oo4HKr0u0ZFIrgXP3Jbws3
	 9aXWDOkF2tFhMJPPsbHRfrxfv0Q8O2ykbKm94lua4n/gafB88fGYh+PQskshEhR6qJ+jb
	 TFa68gohBESG70K7Qtk6zkJX34p5r2esofOc7Fp7PFawKa5zGuCZhO7Rg9cw0BtjQdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oB8Wzw8i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1158606A326
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oB8Wzw8i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257EF1F00A16;
	Mon,  2 Nov 2026 18:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793645924;
	bh=am9gbO9t1laaBz+RQEep0XjQMIvSeDCOgIen9Lu53BI=;
	h=From:To:Cc:Subject:Date;
	b=oB8Wzw8iIbN1dm4VbSQBAL9WqstKscMDnzrGEgEdDJDCXNC3gGCILel8TTZkayCgF
	 RI1K9xCbavMq7baEU/GKZMDmSSTLdPGZF5SMG6FCBBOW4tK6cZG4KLekDO/dQZB9Z+
	 hPiqYpiTd9Uj96jGxFhCExYCqsu3JWKBwG+nmTqXKfaUG1CuHC/ea/EXYPG55gWSpX
	 6YnnoOXbZIgVvebBE2bXpZBjWEMC23dCy8CuqPgns3gUp+gEMJ944UOt9IZceh4Ury
	 WVRv8AdL41oofcTd1jX+kTjvKqoBhljo+5EJDOvPv2j5qlG7MAzYy28ze6mratx/of
	 3urqYGgLNZWmQ==
From: Alan Maguire <almagui@kernel.org>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bpf@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Alan Maguire <almagui@kernel.org>
Subject: [PATCH bpf] libbpf: Fix use-after-free in btf__add_type
Date: Mon,  2 Nov 2026 18:58:39 +0000
Message-ID: <20261102185839.1190122-1-almagui@kernel.org>
X-Mailer: git-send-email 2.56.0
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

From: Alexei Starovoitov <ast@kernel.org>

For every string btf_rewrite_str() does:

  off = btf__add_str(p->dst, btf__str_by_offset(p->src, *str_off));

When the string belongs to the base, the pointer goes into the raw data
of the base. btf__add_str() looks the string up in the base first,
btf__find_str() calls btf_ensure_modifiable() on the base, and that
frees the raw data. Then strset__find_str() reads the freed string.

Make all the bases of dst modifiable before the pointer is taken.

This bug is triggered by the sharing of BTF bases between src
and dst, as introduced by the resolve_btfids changes to build
inline BTF.

Fixes: cf91a7db92c6 ("resolve_btfids: Build separate main and inline BTF objects")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alan Maguire <almagui@kernel.org>
Tested-by: Alan Maguire <almagui@kernel.org>
---
 tools/lib/bpf/btf.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index d2ff6f5d6d5b..95c31803e722 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2222,6 +2222,7 @@ struct btf_pipe {
 
 static int btf_rewrite_str(struct btf_pipe *p, __u32 *str_off)
 {
+	struct btf *base;
 	long mapped_off;
 	int off, err;
 
@@ -2234,6 +2235,19 @@ static int btf_rewrite_str(struct btf_pipe *p, __u32 *str_off)
 		return 0;
 	}
 
+	/*
+	 * btf__add_str() first looks the string up in the base BTFs of dst,
+	 * which makes each of them modifiable and frees its raw data. If src
+	 * shares a base with dst and the string lives in that base, the
+	 * pointer taken below would be left dangling. So make the bases
+	 * modifiable before the pointer is taken.
+	 */
+	for (base = p->dst->base_btf; base; base = base->base_btf) {
+		err = btf_ensure_modifiable(base);
+		if (err)
+			return err;
+	}
+
 	off = btf__add_str(p->dst, btf__str_by_offset(p->src, *str_off));
 	if (off < 0)
 		return off;
-- 
2.56.0

