Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4852C028F
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 07:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776325109; cv=none; b=fBn7zDZJo7P3rHie/I5ysS7gQWPHlMEbNXRLRAZOcb9cLP6lWNleheUhXwbx3b+vPLhCz0D6oAuLgIx6OmZuH8Y6kr8qTYJcDCtKgaDkHEFrwXODsshxhD1662hEcYuEfUCUGAFzH8Z0KytTDGa+A7dgm9sq40tay+/ULud9T+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776325109; c=relaxed/simple;
	bh=E/vR6hhbptD+MSDj1gn2JEJq0XiK28BUEhgrPVbh4G0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qoALG/lgAPAgDgC1iDj/tT1mGliaS7vjhvdvYKyTyK+zH67RGvVee9EXULJG5KIPFe1oHLGOFrfPaYCmMlW+PBop+P1cy1YmjoXJ387DM2hp3X1lIFVK6098iRFllxKlb7RR6aniuxGrQr4pGCGwSWy9hdsVRLu5+pqYqGxRX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUEkVDeS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUEkVDeS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F40C2BCAF;
	Thu, 16 Apr 2026 07:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776325109;
	bh=E/vR6hhbptD+MSDj1gn2JEJq0XiK28BUEhgrPVbh4G0=;
	h=From:To:Cc:Subject:Date:From;
	b=KUEkVDeSl0ncCaHbIacY1uNXI4eVzgugRHy9w5daVQ1BnDsPMDP1udsd1tGf+rERR
	 sAZdQAcLfWuVM4gqXNTKujzSWYlaFS2t31hNr86UDn3EEP3mgINVS8XOmLRm1/XKmq
	 sosNetuR7+HPqvOe6AFbSQpcWPn1QDd78yEtd9x5FBFlE3S4BssFqTWfPlFw5kTFDK
	 VMDJrgDnLq7V4khNzFDlRBSQp9l79Er8daYKB9rOJmAN/eERibv0XW7CC0D8wXyH/H
	 stBclRg4vMxgmcPNUo3eQ6J90S+r5a+Ymclx7HynaG+hmwqnc7lWZffV68pFsUaDFA
	 FRr0oRWt6795A==
From: Antoine Tenart <atenart@kernel.org>
To: andrii@kernel.org,
	eddyz87@gmail.com
Cc: Antoine Tenart <atenart@kernel.org>,
	bpf@vger.kernel.org,
	Paul Houssel <paulhoussel2@gmail.com>
Subject: [PATCH bpf] libbpf: fix deduplication of typedef with base definitions
Date: Thu, 16 Apr 2026 09:38:24 +0200
Message-ID: <20260416073826.142056-1-atenart@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When deduplicating definitions for a module, typedef defined in the base
are not removed. This is because the hash used for base types differs
from the one used in the deduplication logic in btf_dedup_struct_type.

This was introduced by the referenced commit when moving the typedef
deduplication logic handling from btf_dedup_ref_type to
btf_dedup_struct_type, as this also changed the hash logic
(btf_hash_common to btf_hash_typedef).

This also impacts other types referencing those typedef (e.g. const). In
my test, the BTF section size of the openvswitch module went from 31KB
to 45KB.

Cc: Paul Houssel <paulhoussel2@gmail.com>
Fixes: 3781413465df ("libbpf: Fix BTF dedup to support recursive typedef definitions").
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 tools/lib/bpf/btf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index ceb57b46a878..771aeaa0262b 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4578,12 +4578,14 @@ static int btf_dedup_prep(struct btf_dedup *d)
 		case BTF_KIND_RESTRICT:
 		case BTF_KIND_PTR:
 		case BTF_KIND_FWD:
-		case BTF_KIND_TYPEDEF:
 		case BTF_KIND_FUNC:
 		case BTF_KIND_FLOAT:
 		case BTF_KIND_TYPE_TAG:
 			h = btf_hash_common(t);
 			break;
+		case BTF_KIND_TYPEDEF:
+			h = btf_hash_typedef(t);
+			break;
 		case BTF_KIND_INT:
 		case BTF_KIND_DECL_TAG:
 			h = btf_hash_int_decl_tag(t);
-- 
2.53.0

