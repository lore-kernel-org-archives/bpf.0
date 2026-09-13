Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB11E1DF0
	for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311168; cv=none; b=H0DAPqMzTG0IlitQ5WrZVuZUclGMvUQMwmzoc9gt/wpVLgqb/SkPpDaEQT3tRRzIUQLD0kjPTU2tuj3Qv06tXr8RqFXFjZbD70NADmRB8wI1+3WVD/MW2NtQ2ciPy7jZltpMTQSMU4GioRN1fPJWyuKGDvFmX43Nz2hJWpCBY+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311168; c=relaxed/simple;
	bh=LuML2yyo/ZfDCTA9JOEEhE0MF4wk4NcvTft+OnKUDV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGgNQOCYXrYNI1fTniqlBXxN+I9Vt8Q2yWfbC9vP8655KlVsidqkv+QLW9QAvQ/bYc83GYTLPuBDIVuK37JtZc5eirDuFiR3xq9nWKajDAeNJJ676vdUREFTczfihnbUwRsSDmoRjDJEG3OGOWbr0m/VbGGF2HRn/BfQluivC6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvwulkDH; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvwulkDH"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso1381981a12.0
        for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 07:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311166; x=1789915966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vmbEy0MRqE4Rmw4bHzricM0cnrUUgNz4Z1oRU5QaZaU=;
        b=HvwulkDHZDxpZQ+igPp108H/sbFteuYhtuxh8FbRQKf9gfJZiUKEWxuJGF++t1+rj9
         r4IEhhH8IyDgB7SdDbzzqNDUtmMWIfqbJpo+Z3BYp7IzQ0JmfqzTl5ZDhWyijwdBvq0S
         yJsZHNcAaPu6Oh01dT40S7uqDNbP3ADNR0Ng2AwmG+SWfJdaX3e624RvT2SLzNWpppDp
         iB0jcbOORE0sQDji/UEnGKSYbqYmZ8Ydqe5AE8mwJV2ZCuLCvqshOsbI9TSo9WGDuSSw
         X1GzapE4XXS6J+5nmmA9YznCyUNpzQHERagocgvj+0egJi/zv8E4cTDCYJrY1hSdqzGS
         ehRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311166; x=1789915966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vmbEy0MRqE4Rmw4bHzricM0cnrUUgNz4Z1oRU5QaZaU=;
        b=C4bEyOs+2d9SJdKuud7P3gvL16qTjUMtAi9WYbh2c5/VEqkaTjrCyXcCHb+/AvL4oZ
         EqHyCqgIbUctdbiTds3DkJhOqIHDMNEsapTwSqS9XDZZ04WdSQ1eEa43LMvzQbLQ4pbS
         V3CiaBWey6kJpOMpR7OI5fQrDx7RO/txF97LP/eVSF6KO3HpclCTwFI4qO5KCtOItkFm
         v5U8cT7dS09FsxrxrQ21r4/lxanSGgP4BEvTM25g+zYQu4AakXdtTpAL1ZIOMclbM7/F
         A1o0+JAuTneDYKh3iKoYiPBNopv6585b7rinLxcuVEqD1SNFb6mcwRCMLj9eEyehdFZb
         vvWQ==
X-Gm-Message-State: AFuF++lHkd/2eNrmrfS6/xxChIsyPNbERbKZ5Enwm0s+Mk3JPL/brhwp
	jeZ43p8Lqi/TrwoDQT2/zYaH2XfPWTtXSg9pZaNbnDCEwxdalxID1BJ4B7RCR8Tr
X-Gm-Gg: AYBFou3FXoxsQM3kW32uO9EbF1Jyqmaj/gYFy1BggjSXruQ/1guRU2Wi3/LQnRsJ6HA
	FgHjJKC7ZG5iQkV4yVx1kp43TdtenVvIBLba+wEiTgvscOfsGGZisf+qoHzZy8vC4XQSoKDBfHr
	fRfmhHocp5ZRLyXj6PAF+tYzlqf8066Kt1Fj3OEjX1O1OKERDKcdE+44TC4V0/u9dQ/rl0tjR2Q
	Tq4bq01uN95kkQswZ2cjmFiaTQ6rSUnQPRChuJSr58T/PPrWpLN5GbX46hjmmWjaHPz/aSCQT6s
	khnqwDVWGdp42//lIb0iSJh4hkJL33ZWlvh60tL4LIMDlTEMU0pG7yeN6kcsYPp7Zv1f28MKefF
	GuEF5GZMmA5oZ2ckjAy6Mrh6rz+mbcez3c1XhjURXn8vCdbPqZU7oMST5kJO61CNl+3RYA11Od0
	Ux3L2mzeCuBPWKGhAwz50YCeLq5UqQSCz53uMvcnBEkpcIEw8cBDBQWaQraaRmtj9qymjNo8KC2
	d/g3M7ZQXcqevsxOfB7KASges/qiIRhfzTblvt0Y7BrKam+qCLCneo=
X-Received: by 2002:a17:90b:2741:b0:393:19a3:4f1 with SMTP id 98e67ed59e1d1-39d9bdbb0e4mr22552729a91.6.1789311166056;
        Sun, 13 Sep 2026 07:52:46 -0700 (PDT)
Received: from ubuntu2204.comp.polyu.edu.hk ([158.132.255.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994cc978sm15543544a91.9.2026.09.13.07.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:52:45 -0700 (PDT)
From: Mingpei CAO <caomingpei@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	qmo@kernel.org,
	Mingpei CAO <caomingpei@gmail.com>
Subject: [PATCH bpf v2 2/3] bpftool: Keep struct_ops field offsets when skipping bitfields
Date: Sun, 13 Sep 2026 14:52:32 +0000
Message-ID: <20260913145233.1446643-3-caomingpei@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913145233.1446643-1-caomingpei@gmail.com>
References: <20260913145233.1446643-1-caomingpei@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a bitfield, member->offset contains the bit position and field width.
The struct_ops skeleton generator used the full value as the bit position.
The generated C structure could contain excessive padding and place later
fields outside the map value.

Represent unsupported bitfield storage as padding in the generated
skeleton. This preserves the struct_ops map and keeps supported fields at
their declared BTF offsets. Validate every member range and alignment
before generating the C structure.

Fixes: a7b0fa352eaf ("bpftool: Generated shadow variables for struct_ops maps.")
Assisted-by: LLM
Signed-off-by: Mingpei CAO <caomingpei@gmail.com>
---
 tools/bpf/bpftool/gen.c | 147 ++++++++++++++++++++++++++--------------
 1 file changed, 97 insertions(+), 50 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index a50540ef6521c..d93073d5e7e32 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1044,62 +1044,79 @@ codegen_progs_skeleton(struct bpf_object *obj, size_t prog_cnt, bool populate_li
 }
 
 static int walk_st_ops_shadow_vars(struct btf *btf, const char *ident,
-				   const struct btf_type *map_type, __u32 map_type_id)
+				   const struct btf_type *map_type)
 {
+	enum st_ops_shadow_kind {
+		ST_OPS_SHADOW_SCALAR,
+		ST_OPS_SHADOW_FUNC_PTR,
+		ST_OPS_SHADOW_OPAQUE,
+	};
 	LIBBPF_OPTS(btf_dump_emit_type_decl_opts, opts, .indent_level = 3);
 	const struct btf_type *member_type;
-	__u32 offset, next_offset = 0;
+	__u64 bitfield_end = 0, map_bits;
+	__u32 bit_offset, bitfield_size;
+	__u32 map_size, offset, next_offset = 0;
 	const struct btf_member *m;
 	struct btf_dump *d = NULL;
 	const char *member_name;
 	__u32 member_type_id;
-	int i, err = 0, n;
-	int size;
+	int align, err = 0, i, max_align = 1, n, size;
+	enum st_ops_shadow_kind shadow_kind;
 
 	d = btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
 	if (!d)
 		return -errno;
 
+	map_size = map_type->size;
+	map_bits = (__u64)map_size * 8;
 	n = btf_vlen(map_type);
 	for (i = 0, m = btf_members(map_type); i < n; i++, m++) {
-		member_type = skip_mods_and_typedefs(btf, m->type, &member_type_id);
 		member_name = btf__name_by_offset(btf, m->name_off);
+		bit_offset = btf_member_bit_offset(map_type, i);
+		bitfield_size = btf_member_bitfield_size(map_type, i);
+		if (bitfield_size) {
+			if ((__u64)bit_offset < bitfield_end ||
+			    (__u64)bit_offset < (__u64)next_offset * 8 ||
+			    bit_offset > map_bits ||
+			    bitfield_size > map_bits - bit_offset) {
+				p_err("Invalid bitfield layout for struct_ops member %s",
+				      member_name);
+				err = -EINVAL;
+				goto out;
+			}
+			bitfield_end = (__u64)bit_offset + bitfield_size;
+			continue;
+		}
 
-		offset = m->offset / 8;
-		if (next_offset < offset)
-			printf("\t\t\tchar __padding_%d[%u];\n", i, offset - next_offset);
+		if (bit_offset % 8 || bit_offset < bitfield_end) {
+			p_err("Invalid offset for struct_ops member %s", member_name);
+			err = -EINVAL;
+			goto out;
+		}
+
+		offset = bit_offset / 8;
+		if (offset < next_offset || offset > map_size) {
+			p_err("Invalid offset for struct_ops member %s", member_name);
+			err = -EINVAL;
+			goto out;
+		}
 
+		member_type = skip_mods_and_typedefs(btf, m->type, &member_type_id);
 		switch (btf_kind(member_type)) {
 		case BTF_KIND_INT:
 		case BTF_KIND_FLOAT:
 		case BTF_KIND_ENUM:
 		case BTF_KIND_ENUM64:
-			/* scalar type */
-			printf("\t\t\t");
-			opts.field_name = member_name;
-			err = btf_dump__emit_type_decl(d, member_type_id, &opts);
-			if (err) {
-				p_err("Failed to emit type declaration for %s: %d", member_name, err);
-				goto out;
-			}
-			printf(";\n");
-
+			shadow_kind = ST_OPS_SHADOW_SCALAR;
 			size = btf__resolve_size(btf, member_type_id);
-			if (size < 0) {
-				p_err("Failed to resolve size of %s: %d\n", member_name, size);
-				err = size;
-				goto out;
-			}
-
-			next_offset = offset + size;
+			align = btf__align_of(btf, member_type_id);
 			break;
 
 		case BTF_KIND_PTR:
 			if (resolve_func_ptr(btf, m->type, NULL)) {
-				/* Function pointer */
-				printf("\t\t\tstruct bpf_program *%s;\n", member_name);
-
-				next_offset = offset + sizeof(void *);
+				shadow_kind = ST_OPS_SHADOW_FUNC_PTR;
+				size = sizeof(void *);
+				align = __alignof__(void *);
 				break;
 			}
 			/* All pointer types are unsupported except for
@@ -1108,34 +1125,64 @@ static int walk_st_ops_shadow_vars(struct btf *btf, const char *ident,
 			fallthrough;
 
 		default:
-			/* Unsupported types
-			 *
-			 * Types other than scalar types and function
-			 * pointers are currently not supported in order to
-			 * prevent conflicts in the generated code caused
-			 * by multiple definitions. For instance, if the
-			 * struct type FOO is used in a struct_ops map,
-			 * bpftool has to generate definitions for FOO,
-			 * which may result in conflicts if FOO is defined
-			 * in different skeleton files.
-			 */
+			shadow_kind = ST_OPS_SHADOW_OPAQUE;
 			size = btf__resolve_size(btf, member_type_id);
-			if (size < 0) {
-				p_err("Failed to resolve size of %s: %d\n", member_name, size);
-				err = size;
+			align = 1;
+			break;
+		}
+
+		if (size < 0 || align < 0) {
+			err = size < 0 ? size : align;
+			p_err("Failed to resolve layout of %s: %d", member_name, err);
+			goto out;
+		}
+		if ((__u32)size > map_size - offset ||
+		    (align > 1 && offset % align)) {
+			p_err("Invalid layout for struct_ops member %s", member_name);
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (next_offset < offset)
+			printf("\t\t\tchar __padding_%d[%u];\n", i, offset - next_offset);
+
+		switch (shadow_kind) {
+		case ST_OPS_SHADOW_SCALAR:
+			printf("\t\t\t");
+			opts.field_name = member_name;
+			err = btf_dump__emit_type_decl(d, member_type_id, &opts);
+			if (err) {
+				p_err("Failed to emit type declaration for %s: %d",
+				      member_name, err);
 				goto out;
 			}
+			printf(";\n");
+			break;
+		case ST_OPS_SHADOW_FUNC_PTR:
+			printf("\t\t\tstruct bpf_program *%s;\n", member_name);
+			break;
+		case ST_OPS_SHADOW_OPAQUE:
+			/* Avoid emitting named types that might conflict with
+			 * definitions from other skeletons.
+			 */
 			printf("\t\t\tchar __unsupported_%d[%d];\n", i, size);
-
-			next_offset = offset + size;
 			break;
+		default:
+			__builtin_unreachable();
 		}
+
+		next_offset = offset + size;
+		max_align = max(max_align, align);
+		bitfield_end = 0;
 	}
 
-	/* Cannot fail since it must be a struct type */
-	size = btf__resolve_size(btf, map_type_id);
-	if (next_offset < (__u32)size)
-		printf("\t\t\tchar __padding_end[%u];\n", size - next_offset);
+	if (map_size % max_align) {
+		p_err("Invalid size for struct_ops type %s", ident);
+		err = -EINVAL;
+		goto out;
+	}
+	if (next_offset < map_size)
+		printf("\t\t\tchar __padding_end[%u];\n", map_size - next_offset);
 
 out:
 	btf_dump__free(d);
@@ -1177,7 +1224,7 @@ static int gen_st_ops_shadow_type(const char *obj_name, struct btf *btf, const c
 
 	printf("\t\tstruct %s__%s__%s {\n", obj_name, ident, type_name);
 
-	err = walk_st_ops_shadow_vars(btf, ident, map_type, map_type_id);
+	err = walk_st_ops_shadow_vars(btf, ident, map_type);
 	if (err)
 		return err;
 
-- 
2.43.0
