Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C98939FCAE
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414805; cv=none; b=CiO13YBqxeuZjzJjFQAj7byC9ODxXmxAR21NcZfkBAzNzs5cytIlwHRseTNT+b4Nm2KDKNsOAmiTsXeKGfdg8XL9+RzYNnN9r6wMiHynY/30G/daSsAUEL2EQSHTtiJ+21jq+GHAoVOPFGeu0/cUJmcRq3BCUBjI4NW90qff1xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414805; c=relaxed/simple;
	bh=LIxyIoIxkHKjzVXrmmfCh+40fQo4xN+LS87Aos2NtDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NX5mYTL4emOBBMRo9bKgiQglZrXzzNgjsFB+52MyT091o/aYRk7rd4HswUCgDGrgqWgRXrdwzGZAcnHTQL3VaIPc8BrRL0bmt0wrUmJWhDDJ+Z7XoHX04YZP8TlfMl19rwT1VSd3lc5epJr57wahv+3AfSETLeZjafKSS6JR0L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN/G8qdU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN/G8qdU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622BDC19425;
	Fri, 17 Apr 2026 08:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776414804;
	bh=LIxyIoIxkHKjzVXrmmfCh+40fQo4xN+LS87Aos2NtDQ=;
	h=From:To:Cc:Subject:Date:From;
	b=eN/G8qdUmLkzMD4cmOo+mJ5BFPRusDJenS2p5Kb7mgjH7nY0lL4Xb9LyGKQpHbwhJ
	 rg0EMzMrEZkV/k5746pL32Y+6SG3WvbQEn+mhTmJYIciWG+/IPhyWhJk5wTjMz69mL
	 iXmElqBhdrOXPEjzHWvXZvndbvEVJ9lq5ySzP/27j3LgNMrTsCGRn3G4e0RmXz5pz4
	 tVn/UCW+gAPFjuyE+4SlMmeL6qbRAvo7riQxWR+ZUy3LQg1C87UjkzyMaj4zirPUWt
	 phC177rwGVBP3qpR0Z1/S/OnnOiLEI4z5DInNaM7tPkVQZ2P1qhD0+KU9RukA2eJ7Z
	 QS3T6hoSSrzJQ==
From: Antoine Tenart <atenart@kernel.org>
To: andrii@kernel.org,
	eddyz87@gmail.com
Cc: Antoine Tenart <atenart@kernel.org>,
	bpf@vger.kernel.org,
	Paul Houssel <paulhoussel2@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf v2 1/2] libbpf: fix deduplication of typedef with base definitions
Date: Fri, 17 Apr 2026 10:33:17 +0200
Message-ID: <20260417083319.32716-1-atenart@kernel.org>
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
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
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

