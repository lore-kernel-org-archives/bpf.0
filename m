Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576E631F9AB
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555482; cv=none; b=UKqfrxyMWyxZgiWkz9IYusTLCKe+Q0MgNtTeYEvUrYrZJlomjPZIc2KeraSr674OBn67Vxoo/Fu7uLRZDytcFnyPyjmK61Ik+gu8iaRgU6UoQTfCh8j/mrM3atMZ2MvsYU0oChdRHrPrkHR6aVfCZ/w7xM3MSljVSURMr8PYtGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555482; c=relaxed/simple;
	bh=RmRhhYj8VdD2cUjUXGlribS8f83VkYTyzjbsd4/77To=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gv0Ar0V3zjL+o9dMPzMbgPJBSxoeyA4vtnHelOShGaOTkxITkbaZqS7+G+o067hyEnZZTe5H6NGWsuVvj3ZaX8StuWohhLUjuZYLDMuVliB1zwNrLt/9eyUEaaNzu/LmJVQgjMwmPS4BJeHmgjzzWElI0J0eT+27ReYUlrznRbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 416F1EE901630; Sat, 23 May 2026 09:57:55 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v5 08/11] dwarf_loader: Check whether two-reg parameter actually use two regs or not
Date: Sat, 23 May 2026 09:57:55 -0700
Message-ID: <20260523165755.1229215-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260523165712.1225231-1-yonghong.song@linux.dev>
References: <20260523165712.1225231-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For a parameter whose type occuplies two registers, for x86_64 and aarch6=
4,
the parameter will actually use two registers. S390 is different
as it allocates on stack and pass a pointer to the function.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 11 +++++++++++
 dwarves.h      |  1 +
 2 files changed, 12 insertions(+)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 97f576a..b888783 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1100,6 +1100,16 @@ static void arch__set_register_params(const GElf_E=
hdr *ehdr, struct cu *cu)
 	}
 }
=20
+static bool arch__agg_use_two_regs(const GElf_Ehdr *ehdr)
+{
+	switch (ehdr->e_machine) {
+	case EM_S390:
+		return false;
+	default:
+		return true;
+	}
+}
+
 static struct template_type_param *template_type_param__new(Dwarf_Die *d=
ie, struct cu *cu, struct conf_load *conf)
 {
 	struct template_type_param *ttparm =3D tag__alloc(cu, sizeof(*ttparm));
@@ -3562,6 +3572,7 @@ static int cu__set_common(struct cu *cu, struct con=
f_load *conf,
=20
 	cu->little_endian =3D ehdr.e_ident[EI_DATA] =3D=3D ELFDATA2LSB;
 	cu->nr_register_params =3D arch__nr_register_params(&ehdr);
+	cu->agg_use_two_regs =3D arch__agg_use_two_regs(&ehdr);
 	arch__set_register_params(&ehdr, cu);
 	return 0;
 }
diff --git a/dwarves.h b/dwarves.h
index b49e651..2d94dff 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -307,6 +307,7 @@ struct cu {
 	uint8_t		 uses_global_strings:1;
 	uint8_t		 little_endian:1;
 	uint8_t		 producer_clang:1;
+	uint8_t		 agg_use_two_regs:1;	/* An aggregate like {long a; long b;} */
 	uint8_t		 nr_register_params;
 	int		 register_params[ARCH_MAX_REGISTER_PARAMS];
 	int		 functions_saved;
--=20
2.53.0-Meta

