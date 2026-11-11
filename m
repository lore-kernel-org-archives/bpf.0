Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=69.171.232.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435904;
	b=eKGmr7fyS4c25pRU3XrnQwpH48+AGpFrpMb4A6iMSv6ZtUuSTFW31NLeDZbd75UC3JaW
	 RrKCZXUFc53wkTPqophPhHwcgawPli/DGwGHuOM8uRvwZiz3AfxRNxgnxwoiLnxuSa5PO
	 ew4yMUobaXaivT7+WjDOifXTuogSwxc83d+mNqk3CPbB0pCjegi++dCFomphB3OROPaZj
	 b2YTeNuLKoK7Da+IQ7q/i6DOdE3KxSRQyI6iELTbnidWiLs4lFemfWF9+AjTqf+L5BLgQ
	 ILTjiL/GHRWt/+4bR2qzgQd/U/lCz5wFFj8oVxdadJoU0x1Y/sgWuvCO2CuhYCPtYlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435904;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EYAzxpAXkSep1aSgFztTSqWSbJMTFI9JEhF20reLYNs=;
	b=k7N02DRbbH3exDZFnw+3qSkhuQyqVGOXnETSpAEdvJLqpzQeM4K7DE6uOHMJHNHkeVRT
	 SGsjLOf2OwH+DEgPs2/5uTnl/0qqnz6NskVMuuOERuoBZ9Zk7QgPknydIY37SiPlr1q3Y
	 /UR5T6A9hNgjafHKePCeqhyd+FgPtEImfOLQ76r5egKWNIvsLzcxsYnV7VA1bUDjEL/oi
	 DqfSNyOcsyUZfucauwaaQm2QzTWSM4tB9rK7rN8Ve/5EA7melTpE8sTmy/5bgesp80OJQ
	 KVrxFRxaWvVP+A5XVVv/D+UFv/4sajXwGkB6NIauon4anU6FLM53w4FPYSCzzhP1U6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=69.171.232.180
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1A8606A326
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 22:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF1A8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id 2B3835824EE2C; Wed, 11 Nov 2026 14:24:47 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH dwarves] btf_encoder: Keep the source prototype of kfuncs
Date: Wed, 11 Nov 2026 14:24:47 -0800
Message-ID: <20261111222447.322978-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The location based checks can drop kfuncs from BTF even though their ABI
did not change. With the arm64 KCSAN setup in the report, resolve_btfids
fails with:

  WARN: resolve_btfids: no BTF func for kfunc bpf_tcp_ops_set_rcvlowat in=
 bpf_tcp_ops_set_rcvlowat_kfunc_set
  WARN: resolve_btfids: unresolved symbol bpf_tcp_ops_set_rcvlowat

The location list of 'rcvlowat' starts after the function entry, in a
callee-saved register, so the function is marked unexpected_reg and
skipped. scx_bpf_tid_to_task() hits the same skip through a
different DWARF pattern.

Kfuncs are defined with __bpf_kfunc ("__used __retain __noclone
noinline"), so the compiler keeps the calling convention of the C
prototype. Odd parameter locations of a kfunc are debug info artifacts,
not ABI changes.

For kfuncs, clear the location derived flags when saving the state,
keep all source parameters, and skip the location based checks, also in
btf_encoder__add_saved_funcs() where saved_functions_combine() can merge
the flags back in. The inconsistent prototype and ambiguous address
checks still apply.

Kfuncs were only collected with decl_tag_kfuncs, which the kernel no
longer passes since commit 692393104909 ("resolve_btfids: Emit bpf_kfunc
and bpf_fastcall decl tags"). Collect them whenever BTF is encoded; the
decl tags are still only emitted with decl_tag_kfuncs.

With this change, bpf_tcp_ops_set_rcvlowat() and scx_bpf_tid_to_task()
are encoded again, and no other function in vmlinux BTF changes.

Reported-by: Breno Leitao <leitao@debian.org>
Closes: https://lore.kernel.org/all/au27Y9m78_3EH2v1@gmail.com/
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 btf_encoder.c | 49 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 05ffe82..4269467 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1421,16 +1421,30 @@ static int32_t btf_encoder__save_func(struct btf_=
encoder *encoder, struct functi
 			}
 		}
 	}
+
+	/*
+	 * A kfunc keeps the ABI of its C prototype, so reset the DWARF
+	 * location based flags: otherwise the kfunc may be treated as
+	 * optimized and skipped, or lose parameters in BTF.
+	 */
+	if (!loc && is_kfunc_state(state)) {
+		state->unexpected_reg =3D 0;
+		state->optimized_parms =3D 0;
+		state->uncertain_parm_loc =3D 0;
+		state->reordered_parm =3D 0;
+		state->signature_changed =3D 0;
+	}
+
 	ftype__for_each_parameter(ftype, param) {
 		const char *name;
 		char *final_name =3D NULL;
=20
 		/* No location info/optimized + reordered means optimized out. */
-		if (!loc && ftype->reordered_parm && (!param->has_loc || param->optimi=
zed)) {
+		if (!loc && state->reordered_parm && (!param->has_loc || param->optimi=
zed)) {
 			state->nr_parms--;
 			continue;
 		}
-		if (!loc && encoder->true_signature && ftype->signature_changed &&
+		if (!loc && encoder->true_signature && state->signature_changed &&
 		    param->optimized) {
 			state->nr_parms--;
 			continue;
@@ -1797,17 +1811,20 @@ static int btf_encoder__add_saved_funcs(struct bt=
f_encoder *encoder, bool skip_e
 		 * signature; true_signature can rewrite those signatures.
 		 * Also exclude functions with unexpected register use, multiple
 		 * inconsistent prototypes or uncertain parameter locations.
+		 * The location based checks do not apply to kfuncs.
 		 */
-		if (state->unexpected_reg)
-			skip_reason =3D "unexpected register usage for parameter\n";
+		if (!is_kfunc_state(state)) {
+			if (state->unexpected_reg)
+				skip_reason =3D "unexpected register usage for parameter\n";
+			if (state->uncertain_parm_loc)
+				skip_reason =3D "uncertain parameter location\n";
+			if (state->reordered_parm)
+				skip_reason =3D "reordered parameters\n";
+			if (btf_encoder_func_state__skip_optimized_parms(encoder, canonical_s=
tate))
+				skip_reason =3D "optimized parameters\n";
+		}
 		if (skip_encoding_inconsistent_proto && state->inconsistent_proto)
 			skip_reason =3D "inconsistet prototype\n";
-		if (state->uncertain_parm_loc)
-			skip_reason =3D "uncertain parameter location\n";
-		if (state->reordered_parm)
-			skip_reason =3D "reordered parameters\n";
-		if (btf_encoder_func_state__skip_optimized_parms(encoder, canonical_st=
ate))
-			skip_reason =3D "optimized parameters\n";
 		if (state->elf->ambiguous_addr)
 			skip_reason =3D "ambiguous address\n";
=20
@@ -3056,10 +3073,14 @@ struct btf_encoder *btf_encoder__new(struct cu *c=
u, const char *detached_filenam
 		if (!found_percpu && encoder->verbose)
 			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename=
, PERCPU_SECTION);
=20
-		if (encoder->tag_kfuncs) {
-			if (btf_encoder__collect_kfuncs(encoder))
-				goto out_delete;
-		}
+		/*
+		 * Mark kfuncs before any function state is saved, so
+		 * btf_encoder__save_func() keeps their source prototypes.
+		 * Needed even without decl_tag_kfuncs, which only controls
+		 * the decl tags.
+		 */
+		if (btf_encoder__collect_kfuncs(encoder))
+			goto out_delete;
=20
 		if (encoder->verbose)
 			printf("File %s:\n", cu->filename);
--=20
2.53.0-Meta

