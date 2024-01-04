Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F41125550
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id F161E2C4DBC49; Thu,  4 Jan 2024 08:57:44 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] bpf: Remove unnecessary cpu == 0 check in memalloc
Date: Thu,  4 Jan 2024 08:57:44 -0800
Message-Id: <20240104165744.702239-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After merging the patch set [1] to reduce memory usage
for bpf_global_percpu_ma, Alexei found a redundant check (cpu =3D=3D 0)
in function bpf_mem_alloc_percpu_unit_init() ([2]).
Indeed, the check is unnecessary since c->unit_size will
be all NULL or all non-NULL for all cpus before
for_each_possible_cpu() loop.
Removing the check makes code less confusing.

  [1] https://lore.kernel.org/all/20231222031729.1287957-1-yonghong.song@=
linux.dev/
  [2] https://lore.kernel.org/all/20231222031745.1289082-1-yonghong.song@=
linux.dev/

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/memalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 460c8f38fed6..550f02e2cb13 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -613,7 +613,7 @@ int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_all=
oc *ma, int size)
 	for_each_possible_cpu(cpu) {
 		cc =3D per_cpu_ptr(pcc, cpu);
 		c =3D &cc->cache[i];
-		if (cpu =3D=3D 0 && c->unit_size)
+		if (c->unit_size)
 			break;
=20
 		c->unit_size =3D unit_size;
--=20
2.34.1

