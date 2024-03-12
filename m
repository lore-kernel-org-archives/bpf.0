Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3A815BF
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 02:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710210787; cv=none; b=tOboNiK8M+QKS9VchFJjRbYEvd1xb0KvuFT0v4j7/b+2PIssk4pAhxV37gkJypfyVgVnavIvk7ADRDM++hpyplDW4CVGgTb4aa1S1ADBWXqWrNLAzgUpChrP7LxGbp/wop0zmOnva3V6v4dvxzFMl9HauaX6Dwiatb39bs6XW+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710210787; c=relaxed/simple;
	bh=9S860esa0PAf3noGWiQlxz6VQZZOQg59041k0pC6Jok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVOCuq0FNO4xI53bpDR8jvipgHmKWkUK9wflWzOIQNKFcKoBMMnesP97WkgX/xFYu+N8RaXX+bW4YNGDHardp7I5NEtLfmnS/jiPvewolDcJPpkmaLgNmnn2lxWLA7AaM5uFo6z6HHubi5d02zLEoQdQ7KdfNoMEXNmCKs5y6Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id B2F1B19D38C1; Mon, 11 Mar 2024 19:32:49 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2] bpftool: Fix missing pids during link show
Date: Mon, 11 Mar 2024 19:32:49 -0700
Message-ID: <20240312023249.3776718-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Current 'bpftool link' command does not show pids, e.g.,
  $ tools/build/bpftool/bpftool link
  ...
  4: tracing  prog 23
        prog_type lsm  attach_type lsm_mac
        target_obj_id 1  target_btf_id 31320

Hack the following change to enable normal libbpf debug output,
  --- a/tools/bpf/bpftool/pids.c
  +++ b/tools/bpf/bpftool/pids.c
  @@ -121,9 +121,9 @@ int build_obj_refs_table(struct hashmap **map, enum=
 bpf_obj_type type)
          /* we don't want output polluted with libbpf errors if bpf_iter=
 is not
           * supported
           */
  -       default_print =3D libbpf_set_print(libbpf_print_none);
  +       /* default_print =3D libbpf_set_print(libbpf_print_none); */
          err =3D pid_iter_bpf__load(skel);
  -       libbpf_set_print(default_print);
  +       /* libbpf_set_print(default_print); */

Rerun the above bpftool command:
  $ tools/build/bpftool/bpftool link
  libbpf: prog 'iter': BPF program load failed: Permission denied
  libbpf: prog 'iter': -- BEGIN PROG LOAD LOG --
  0: R1=3Dctx() R10=3Dfp0
  ; struct task_struct *task =3D ctx->task; @ pid_iter.bpf.c:69
  0: (79) r6 =3D *(u64 *)(r1 +8)          ; R1=3Dctx() R6_w=3Dptr_or_null=
_task_struct(id=3D1)
  ; struct file *file =3D ctx->file; @ pid_iter.bpf.c:68
  ...
  ; struct bpf_link *link =3D (struct bpf_link *) file->private_data; @ p=
id_iter.bpf.c:103
  80: (79) r3 =3D *(u64 *)(r8 +432)       ; R3_w=3Dscalar() R8=3Dptr_file=
()
  ; if (link->type =3D=3D bpf_core_enum_value(enum bpf_link_type___local,=
 @ pid_iter.bpf.c:105
  81: (61) r1 =3D *(u32 *)(r3 +12)
  R3 invalid mem access 'scalar'
  processed 39 insns (limit 1000000) max_states_per_insn 0 total_states 3=
 peak_states 3 mark_read 2
  -- END PROG LOAD LOG --
  libbpf: prog 'iter': failed to load: -13
  ...

The 'file->private_data' returns a 'void' type and this caused subsequent=
 'link->type'
(insn #81) failed in verification.

To fix the issue, restore the previous BPF_CORE_READ so old kernels can a=
lso work.
With this patch, the 'bpftool link' runs successfully with 'pids'.
  $ tools/build/bpftool/bpftool link
  ...
  4: tracing  prog 23
        prog_type lsm  attach_type lsm_mac
        target_obj_id 1  target_btf_id 31320
        pids systemd(1)

Fixes: 44ba7b30e84f ("bpftool: Use a local copy of BPF_LINK_TYPE_PERF_EVE=
NT in pid_iter.bpf.c")
Cc: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftoo=
l/skeleton/pid_iter.bpf.c
index 26004f0c5a6a..1eb756f8d02e 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
+++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
@@ -102,7 +102,7 @@ int iter(struct bpf_iter__task_file *ctx)
 				       BPF_LINK_TYPE_PERF_EVENT___local)) {
 		struct bpf_link *link =3D (struct bpf_link *) file->private_data;
=20
-		if (link->type =3D=3D bpf_core_enum_value(enum bpf_link_type___local,
+		if (BPF_CORE_READ(link, type) =3D=3D bpf_core_enum_value(enum bpf_link=
_type___local,
 						      BPF_LINK_TYPE_PERF_EVENT___local)) {
 			e.has_bpf_cookie =3D true;
 			e.bpf_cookie =3D get_bpf_cookie(link);
--=20
2.43.0

