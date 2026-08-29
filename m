Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551F337A833
	for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 06:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787984147; cv=none; b=Rp4fo5sMFtXOzg2VPK7yFdmKn+ryAU1HDrXrCaRvYGwIeofecw7gwschATILb/pSTApCQWWq7QZE3EPXc7+EY9AyqZhymxs437BGZJk0dE7XjFnW4HD/0DbXwXWp5mQOkEiXjHO7wEPjzUBgJdLwlJIt0MWSx0QfJUCKDvvzChs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787984147; c=relaxed/simple;
	bh=76HfdJ6uiwl5ODrhCII34JxHpi0hxIUjqe26gFlMi18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxZBUPrX+PkIgcriIU+qJee1YyN/sWuLC9jjW/OcVchD0njH9hUQd/xVlrGB3o2l1c3GCctqMLQKvACctjn9wLsvoL6waPEECqQsRoMwMNJdb7vYAV58Gb1Qj/R7NHczQqw6EhxoiYpxfFXw7wWrQv/z6skbmybBjrjMBrj9z2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id DE295273BA2F70; Fri, 28 Aug 2026 23:15:39 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 05/12] bpf: Let a by-value struct nest arrays and structs freely
Date: Fri, 28 Aug 2026 23:15:39 -0700
Message-ID: <20260829061539.1695015-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260829061514.1690730-1-yonghong.song@linux.dev>
References: <20260829061514.1690730-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Go through nested array types until it reaches a non-array type. Later
code will check such non-array type based on current logic. A
zero-length array is still rejected, at whichever dimension it appears.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 90139f1b78d1..a377b1995b51 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11675,6 +11675,17 @@ static bool btf_struct_member_walk(struct bpf_ve=
rifier_env *env, const struct bt
 		const struct btf_array *array;
=20
 		member_type =3D btf_type_skip_modifiers(btf, member->type, NULL);
+		/*
+		 * Every element of an array is laid out in the value being
+		 * returned, so an array counts as its element type however many
+		 * dimensions deep that is.
+		 */
+		while (btf_type_is_array(member_type)) {
+			array =3D btf_array(member_type);
+			if (!array->nelems)
+				return false;
+			member_type =3D btf_type_skip_modifiers(btf, array->type, NULL);
+		}
 		if (btf_type_is_struct(member_type)) {
 			if (rec >=3D 3) {
 				verbose(env, "max struct nesting depth exceeded\n");
@@ -11684,12 +11695,6 @@ static bool btf_struct_member_walk(struct bpf_ve=
rifier_env *env, const struct bt
 				return false;
 			continue;
 		}
-		if (btf_type_is_array(member_type)) {
-			array =3D btf_array(member_type);
-			if (!array->nelems)
-				return false;
-			member_type =3D btf_type_skip_modifiers(btf, array->type, NULL);
-		}
 		if (!btf_member_kind_allowed(btf, member_type, member_kinds))
 			return false;
 	}
--=20
2.53.0-Meta

