Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723F83D669A
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445872; cv=none; b=LXZhU9RMSYzN3TS5rVEQWIXI9Kzhl79AA3Ed3Y2A5QIxFe5+VfKLcak8nM3NJgxDFiZx5DrGIOW/PJqukDQXe4b5FAzNOzlqNGYOfnBjkoPgVlizTjq5wrxaDH1jItHBvopK88vY8Zzf61vvcGyyuEDnCvj3l5GN9tPhcplNZHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445872; c=relaxed/simple;
	bh=xW+u84kRJjHSNcy3VbdYTijBUnwkumDeDKkHsWRucsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSGGo2fCp/D7E7LnnCgam4vtcaFQLWggxHEmK7Oa+TBEtfj7J2/HbByLHIzP6QKqKe8rtZ2CQtUWxPEOYgtp/pCXMgY+laV7ubFI3TjIE2seiCPDKVU8F3q/OOxLIcX4ncfNKTsa53QgTwwSY3M9BBtGt+3v7nPwhrCBzf9pG4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 1C16F2FDA0C18A; Thu,  8 Oct 2026 00:51:01 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v9 12/23] bpf: Refuse a trampoline that calls a subprog that can unwind
Date: Thu,  8 Oct 2026 00:51:01 -0700
Message-ID: <20261008075101.3001371-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008074959.2993751-1-yonghong.song@linux.dev>
References: <20261008074959.2993751-1-yonghong.song@linux.dev>
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
program's frames: fentry leaves none, a trampoline on main is below the
walk, freplace is a program of its own whose unwind ends as a normal
return to its caller, a callback that can unwind is refused, kprobes
and fgraph cannot hook JIT code, and a tail call replaces a frame.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/fixups.c   |  1 +
 kernel/bpf/verifier.c | 16 ++++++++++++++++
 3 files changed, 18 insertions(+)

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
index 668d811d4e4c..3692d9b163d4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21600,6 +21600,22 @@ int bpf_check_attach_target(struct bpf_verifier_=
log *log,
 				prog_extension ? "Extension" : "Tracing");
 			return -EINVAL;
 		}
+		/*
+		 * A trampoline that calls its target stays as a frame between a
+		 * subprog and its caller, and bpf_unwind() cannot walk past it:
+		 * the frames below would return after their calls rather than at
+		 * their landing pads. fentry leaves no frame, and the main
+		 * program's caller is below where the walk stops.
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

