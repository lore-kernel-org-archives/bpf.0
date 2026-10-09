Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9373B3B3BE7
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 04:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791519368; cv=none; b=WzE1Pi7lIq2+2HqdunABBImHgcADe6svhBeeS0A1bfuswIWPoQxonMJbu49S7E4K5pfUJofGa/TgpnrbDpajXhFOZg55I0emAgf3vmNVz9qrzNwb/BVYmFZv/xDaImZ7epzTmID+giCdkw3cXU9HqpIt8kyFJrSQoAg3ypzF/38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791519368; c=relaxed/simple;
	bh=EoqsV42M08Aw9ZFGGxFTLyNMTn48vCUh3sMN9JG0fEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9PYlQo9zTjrNRyDdjqaveWIBVLEmO7Q6MZyCKf2gMJXuAAhpSYeEAbcxsCcNtPuV371Syjh+4yukNZo3ncAJI0kDPH09uhVPpobPe37yJ+h9wt2bz0t6JTtQB47lkzBTPF/4UnFAao6uOTh2VsDbblhU+a5Rf8JGVPuvth2baE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id D81253008C7487; Thu,  8 Oct 2026 21:15:54 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v10 13/24] bpf: Refuse a trampoline that calls a subprog that can unwind
Date: Thu,  8 Oct 2026 21:15:54 -0700
Message-ID: <20261009041554.30730-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009041447.17092-1-yonghong.song@linux.dev>
References: <20261009041447.17092-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

bpf_unwind() walks up the stack rewriting return addresses. It expects
every frame up to the main function to be one of the program's own BPF
functions, and stops at the first frame that is not. A trampoline
attached to a subprog with fexit, fmod_ret or fsession is such a frame:
it calls the subprog, so it sits between the subprog and its caller:

  main -> A -> trampoline -> B -> C          C calls bpf_unwind()

The walk rewrites the return into B but stops at the trampoline, so B
returns through it to A after its call, instead of to A's pad or
epilogue: a path the verifier never walked for an unwind.

Refuse such an attachment to a subprog marked might_unwind, now copied
into each function's aux. Nothing else puts a frame between two of a
program's frames: fentry leaves none, a trampoline on main is above
where the walk stops, freplace is a program of its own whose unwind ends
as a normal return to its caller, a callback that can unwind is refused,
kprobes and fgraph cannot hook JIT code, and a tail call replaces a
frame.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/fixups.c   |  1 +
 kernel/bpf/verifier.c | 17 +++++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7f23f4efde01..1b3b6ee05c09 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1910,6 +1910,7 @@ struct bpf_prog_aux {
 	bool priv_stack_requested;
 	bool changes_pkt_data;
 	bool might_sleep;
+	bool might_unwind;
 	bool kprobe_write_ctx;
 	struct {
 		s32 keyring_serial;
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index c29e14ffc475..6f719e1b083e 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1462,6 +1462,7 @@ static int jit_subprogs(struct bpf_verifier_env *en=
v)
 		func[i]->aux->exception_cb =3D env->subprog_info[i].is_exception_cb;
 		func[i]->aux->changes_pkt_data =3D env->subprog_info[i].changes_pkt_da=
ta;
 		func[i]->aux->might_sleep =3D env->subprog_info[i].might_sleep;
+		func[i]->aux->might_unwind =3D env->subprog_info[i].might_unwind;
 		func[i]->aux->token =3D prog->aux->token;
 		if (!i)
 			func[i]->aux->exception_boundary =3D env->seen_exception;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3d9ed6cb15e0..7354b8cc8b36 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21600,6 +21600,23 @@ int bpf_check_attach_target(struct bpf_verifier_=
log *log,
 				prog_extension ? "Extension" : "Tracing");
 			return -EINVAL;
 		}
+		/*
+		 * A trampoline that calls its target stays as a frame between a
+		 * subprog and its caller, and bpf_unwind() cannot walk past it:
+		 * the frames above it would carry on after their calls rather
+		 * than at their landing pads or epilogues. fentry leaves no
+		 * frame, and the main program's caller is above where the walk
+		 * stops.
+		 */
+		if (aux->func && subprog && aux->func[subprog]->aux->might_unwind &&
+		    (prog->expected_attach_type =3D=3D BPF_TRACE_FEXIT ||
+		     prog->expected_attach_type =3D=3D BPF_MODIFY_RETURN ||
+		     prog->expected_attach_type =3D=3D BPF_TRACE_FSESSION)) {
+			bpf_log(log,
+				"Cannot attach fexit, fmod_ret or fsession to %s, which can unwind\n=
",
+				tname);
+			return -EINVAL;
+		}
 		conservative =3D aux->func_info_aux[subprog].unreliable;
 		if (prog_extension) {
 			if (conservative) {
--=20
2.53.0-Meta

