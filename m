Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645B626CE2C
	for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311165; cv=none; b=qK+L9YYHptoRTCXX/9HH968kKOxlvd3nVx8GyovJIv2cLwfD/2Q5PFmlnA+2LonMZ5LRCprxeZp9cBn2h4bQzfXIBju3U+BuV73cybxCr/QXP5lraRErjFIF1I0NeWoi+EI7QOgsj5FB/YlxGvE9Isp+vSeQK7ix6G7ElFVX3a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311165; c=relaxed/simple;
	bh=7zixN8AiFmTSaePbzxrYSQzCag9QD7+v0iL81t2K4mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9FQXDs7kDFJJbAFGzblq3rUigou36kOtzhzUUK82h2+AWB4Ofc3ELZhS+FYNWDgjAf+05xM5voIdzRE/wjj/EghVe15kHLxmds8vQ/6gLJLxKINpP0X/jTflIkGVG3eGG/GbmoocXiUQJwuqYq35x91tkEUIGBiHuWuf3LRW60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnPEUSLw; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnPEUSLw"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-398e9698a70so2541146a91.0
        for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 07:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311164; x=1789915964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kGr9QDPlIvTLT1SRAzR/gGlIg313JBcPlWvQpex3ehQ=;
        b=dnPEUSLwCZO75Xt97ql1NMmtQhp4hmEInmLp6GxkajX/NnbCx8uzUYrIjoPAb66pG/
         Nl3zhTl5YrfFwTX2N+mN1grYwC0Sgbo5PrZcw0cnmHewNjfOQWK6ueJCMvlt0retBqOq
         On51OvS0ZzKV6LvQkWXX0stmAL618hmrndu9pSUURcZEUAJD1teJEaIxMi2P+NIwgCPd
         ED/qyyFJzorf3qbGuzI39w5pYQr57uP/BDb8aWoxwlWMhBIR+YDoOU1CVo2Uly8gi0sl
         9GnuSzd7VIrrDCUGO2zyEyaeR5W9P6jWqkND569+RQCjjNmuVNzXufyIyTNL4wYcSibd
         d9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311164; x=1789915964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kGr9QDPlIvTLT1SRAzR/gGlIg313JBcPlWvQpex3ehQ=;
        b=sLfTAzr+2GUv+tjdlY+tUf9MmWrIFTaO6kNgDyHoppzk5bP5d9YfTT/FjEZmZ1bO0d
         MGmvWuQtuBuF8z7qxbaRzKoIgARCqNCMJkYIaBdUZzAyl1d/lICD7KrPl6HTEQbKuNPb
         txRzjO/HX3uWIMJneC0XpS+itmTlrk/UDVfzpws1tisjZdmpd81+jc/yi8qE9+qlauez
         Xz6NuqtzaHj5NarEmiSu6xICz8HR8hpnrekV8mUlTuTthMo3s04cvjl5doOJqg54Zm0S
         CgxfPqfv9qd/fvbuOaUeWB/Wp5cCwyJ96AjUHuxy9/xcnBy1uSPbKQ/ftf2AWVW5alH8
         yyyQ==
X-Gm-Message-State: AFuF++mSkAewpCVrQu3rjFXXBF1UmJAyb2JdLIf8aILcDHwGxBP2jSYM
	Qtk5GPia3aLT+nI61qKAtM802yelbLku8TfdI+qX5d3abahCVNf6ll8S6dmnVTgs
X-Gm-Gg: AYBFou0SoWHbni25qwWdLLrXsf1YSUQGuOi0rDdLLZYAkIU4Nw1oz2LhKWk9OGGwJGJ
	kPiprjRKY+Uintu3CvFtqSKbW8zV4Z81zIMolZYiNHG2CPjvnCXqAdgs6ddc/a7Qud6wC+l0HtY
	NhdtVpexhkV4sFSb7pTyoWw6Tjp2pGE225F2jDlTNRr2s7LGga2s/Q5KojK7kovdLiWTmreeWLB
	7M6aapeKXfJT/NaUavhpWWISjqeoXYNF64HDZ1kMEQgN38INzhoR32802g4dcdbZc9wIgOE0AKL
	Baj5h9bAxhARHaSd+DPuWWkk1SFmJAh5/kMLRMDNIKju7Qy9/k5AKx/pf8K8qrPEs4CL+3odqQl
	pD/p2ls5wZ9RT2jUJtcWeY/vUuG9e4MiZZk9/xVNcSqReMvLfqkspvMWU31e6gZGCnt1CrPvdF9
	Ocsa9SXIwDUYFuRKzQ7eJj4lBUQFyie7nH5/EMOAM1HaCA05MfZpVuvakrA1ngDMOSDm5tHN0zM
	2/fOk0CDKUcttpiT7NQAGken21TM0jdhhU1AX+i1gfm0Q0dxjoxswE=
X-Received: by 2002:a17:90b:3885:b0:398:c794:ca26 with SMTP id 98e67ed59e1d1-39d9c3944aamr22106646a91.25.1789311163400;
        Sun, 13 Sep 2026 07:52:43 -0700 (PDT)
Received: from ubuntu2204.comp.polyu.edu.hk ([158.132.255.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994cc978sm15543544a91.9.2026.09.13.07.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:52:43 -0700 (PDT)
From: Mingpei CAO <caomingpei@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	qmo@kernel.org,
	Mingpei CAO <caomingpei@gmail.com>
Subject: [PATCH bpf v2 1/3] libbpf: Validate struct_ops member offsets before data access
Date: Sun, 13 Sep 2026 14:52:31 +0000
Message-ID: <20260913145233.1446643-2-caomingpei@gmail.com>
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

A local struct_ops type can contain a bitfield absent from the
corresponding kernel BTF type. libbpf checks whether data for an absent
local member is zero.

For a bitfield, member->offset contains the bit position and field width.
bpf_map__init_kern_struct_ops() used the full value to create a data
pointer before checking the member range. libbpf_is_mem_zeroed() could
then read outside the local struct_ops data.
bpf_map__init_kern_struct_ops() also failed to check offsets for
non-bitfield members.

Reject local and kernel bitfields before reading member data. Check every
local and kernel member range before creating a data pointer.

Fixes: c911fc61a7ce ("libbpf: Skip zeroed or null fields if not found in the kernel type.")
Assisted-by: LLM
Signed-off-by: Mingpei CAO <caomingpei@gmail.com>
---
 tools/lib/bpf/libbpf.c | 80 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b749c01742ee0..2791b48585939 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1175,6 +1175,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 	const struct btf_member *member, *kern_member, *kern_data_member;
 	const struct btf_type *type, *kern_type, *kern_vtype;
 	__u32 i, kern_type_id, kern_vtype_id, kern_data_off;
+	__u32 kern_data_bit_off, kern_data_member_idx;
 	struct bpf_object *obj = map->obj;
 	const struct btf *btf = obj->btf;
 	struct bpf_struct_ops *st_ops;
@@ -1195,6 +1196,25 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 		return err;
 
 	kern_btf = mod_btf ? mod_btf->btf : obj->btf_vmlinux;
+	kern_data_member_idx = kern_data_member - btf_members(kern_vtype);
+	if (btf_member_bitfield_size(kern_vtype, kern_data_member_idx)) {
+		pr_warn("struct_ops init_kern %s: kernel data member is a bitfield\n",
+			map->name);
+		return -ENOTSUP;
+	}
+	kern_data_bit_off = btf_member_bit_offset(kern_vtype, kern_data_member_idx);
+	if (kern_data_bit_off % 8) {
+		pr_warn("struct_ops init_kern %s: kernel data member has a non-byte-aligned offset\n",
+			map->name);
+		return -EINVAL;
+	}
+	kern_data_off = kern_data_bit_off / 8;
+	if (kern_data_off > kern_vtype->size ||
+	    kern_type->size > kern_vtype->size - kern_data_off) {
+		pr_warn("struct_ops init_kern %s: kernel data member is outside the %u-byte kernel value type\n",
+			map->name, kern_vtype->size);
+		return -EINVAL;
+	}
 
 	pr_debug("struct_ops init_kern %s: type_id:%u kern_type_id:%u kern_vtype_id:%u\n",
 		 map->name, st_ops->type_id, kern_type_id, kern_vtype_id);
@@ -1208,29 +1228,50 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 		return -ENOMEM;
 
 	data = st_ops->data;
-	kern_data_off = kern_data_member->offset / 8;
 	kern_data = st_ops->kern_vdata + kern_data_off;
 
 	member = btf_members(type);
 	for (i = 0; i < btf_vlen(type); i++, member++) {
 		const struct btf_type *mtype, *kern_mtype;
-		__u32 mtype_id, kern_mtype_id;
+		__u32 bit_offset, mtype_id, kern_mtype_id;
 		void *mdata, *kern_mdata;
 		struct bpf_program *prog;
 		__s64 msize, kern_msize;
+		__u64 maccess_size;
 		__u32 moff, kern_moff;
 		__u32 kern_member_idx;
 		const char *mname;
 
 		mname = btf__name_by_offset(btf, member->name_off);
-		moff = member->offset / 8;
-		mdata = data + moff;
+		if (btf_member_bitfield_size(type, i)) {
+			pr_warn("struct_ops init_kern %s: local bitfield %s is not supported\n",
+				map->name, mname);
+			return -ENOTSUP;
+		}
+
 		msize = btf__resolve_size(btf, member->type);
 		if (msize < 0) {
 			pr_warn("struct_ops init_kern %s: failed to resolve the size of member %s\n",
 				map->name, mname);
 			return msize;
 		}
+		mtype = skip_mods_and_typedefs(btf, member->type, &mtype_id);
+		maccess_size = msize;
+		if (btf_is_ptr(mtype) && maccess_size < sizeof(prog))
+			maccess_size = sizeof(prog);
+		bit_offset = btf_member_bit_offset(type, i);
+		if (bit_offset % 8) {
+			pr_warn("struct_ops init_kern %s: member %s has a non-byte-aligned offset\n",
+				map->name, mname);
+			return -EINVAL;
+		}
+		moff = bit_offset / 8;
+		if (moff > type->size || maccess_size > type->size - moff) {
+			pr_warn("struct_ops init_kern %s: member %s is outside the %u-byte local struct_ops type\n",
+				map->name, mname, type->size);
+			return -EINVAL;
+		}
+		mdata = data + moff;
 
 		kern_member = find_member_by_name(kern_btf, kern_type, mname);
 		if (!kern_member) {
@@ -1259,17 +1300,33 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 		}
 
 		kern_member_idx = kern_member - btf_members(kern_type);
-		if (btf_member_bitfield_size(type, i) ||
-		    btf_member_bitfield_size(kern_type, kern_member_idx)) {
-			pr_warn("struct_ops init_kern %s: bitfield %s is not supported\n",
+		if (btf_member_bitfield_size(kern_type, kern_member_idx)) {
+			pr_warn("struct_ops init_kern %s: kernel bitfield %s is not supported\n",
 				map->name, mname);
 			return -ENOTSUP;
 		}
 
-		kern_moff = kern_member->offset / 8;
+		kern_msize = btf__resolve_size(kern_btf, kern_member->type);
+		if (kern_msize < 0) {
+			pr_warn("struct_ops init_kern %s: failed to resolve the kernel size of member %s\n",
+				map->name, mname);
+			return kern_msize;
+		}
+		bit_offset = btf_member_bit_offset(kern_type, kern_member_idx);
+		if (bit_offset % 8) {
+			pr_warn("struct_ops init_kern %s: kernel member %s has a non-byte-aligned offset\n",
+				map->name, mname);
+			return -EINVAL;
+		}
+		kern_moff = bit_offset / 8;
+		if (kern_moff > kern_type->size ||
+		    (__u64)kern_msize > kern_type->size - kern_moff) {
+			pr_warn("struct_ops init_kern %s: kernel member %s is outside the %u-byte kernel struct_ops type\n",
+				map->name, mname, kern_type->size);
+			return -EINVAL;
+		}
 		kern_mdata = kern_data + kern_moff;
 
-		mtype = skip_mods_and_typedefs(btf, member->type, &mtype_id);
 		kern_mtype = skip_mods_and_typedefs(kern_btf, kern_member->type,
 						    &kern_mtype_id);
 		if (BTF_INFO_KIND(mtype->info) !=
@@ -1281,7 +1338,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 		}
 
 		if (btf_is_ptr(mtype)) {
-			prog = *(void **)mdata;
+			memcpy(&prog, mdata, sizeof(prog));
 			/* just like for !kern_member case above, reset declaratively
 			 * set (at compile time) program's autload to false,
 			 * if user replaced it with another program or NULL
@@ -1352,8 +1409,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 			continue;
 		}
 
-		kern_msize = btf__resolve_size(kern_btf, kern_mtype_id);
-		if (kern_msize < 0 || msize != kern_msize) {
+		if (msize != kern_msize) {
 			pr_warn("struct_ops init_kern %s: Error in size of member %s: %zd != %zd(kernel)\n",
 				map->name, mname, (ssize_t)msize,
 				(ssize_t)kern_msize);
-- 
2.43.0
