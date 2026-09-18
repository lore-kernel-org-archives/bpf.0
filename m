Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04F54F68D8
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737516; cv=none; b=jN/FYt7wDPzCdx/LhkRY5JWYIqgWGNopyeBFS+aAesqLYyKnDU7CdjvhLWUNIBNAyLuRaRStJxDJhxpeVqWqJ/eILbiitdmG7llM6UDkrKdJjQmKXXVQs9aH31VsoYi94jZbRE5Mws8MyOiq3EafPgEQ9F8756QGB43mrsUtZqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737516; c=relaxed/simple;
	bh=FiRsDZdzGXAipkwSasDiwYJgNjGQw/oWZmESPlkGMAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9fWlJwbUN3ZKi8QP5AQ4AKXKRW1bOAQTtnxCCY8fcAgQPBrJ3XwyY3/Ggx71eyVD/yNdl6cItXG6THxM7naUH90953pk5oOBuFsKZMGVXAypjTwxktogwGuaORHVg98WWLlCF+b7TfIftEUK22GWqUYHXBaOmMAp/Yok+R+iCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pwtcHEJh; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwtcHEJh"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350faaso412565f8f.0
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 06:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789737510; x=1790342310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lk08SIy6DJ+jXcktdOiUfMwYrHwPBwEtrnZT5485SRQ=;
        b=pwtcHEJhy+AqkJEIPvt6KoFIXebSr8frclgIJqi4kD2b5Qsb6sOogjqKgfQ5wMMh6l
         z00HjFNr+bWexwi2bknLqaCBXGepxzkl+FoEincelLSgFI6/DwUmW2+GxIxbuNyy2yN6
         x+WirGt+AC2cmvPA2IbZs9DlQRIdGp8xTtvrUfXaKdzB9XPoAGNoKIPF/R9Y7cWU2uo6
         RI6rTE4MfIoNbuZkPgYx+nEAXMWMp/siRkXMEc5v5BNqkm8mINgcqEcM/nx3H/3hptz0
         PJjT8F/e1OawwEc7NE1n2Xii5LUJsgsDowML8Z1ATPMQafT7UCd315UjO0bo3GonCdQ1
         XyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789737510; x=1790342310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lk08SIy6DJ+jXcktdOiUfMwYrHwPBwEtrnZT5485SRQ=;
        b=uzuY/DQHtYeMjeyKKMmxaQ7lDtipelFqxns/jZEfsE+UUOtIJq+NKaugKZigXR8Pqq
         LIy4Xik9FDoxHDb5OCaB02JYQRIhqkREFswSYD1YQUuwlJF+5pFrYVW+QVKTg+JG9+LF
         ssr3cqpVCEqhGykDoUmKeDxlGCQS30qYg7qsIizQAeiUgkD6rNvtgJRQ8dQKBJCs90YV
         UR/Scj+gbPv3cWr4UFM1+49YuDuc/Tsptw1My+5FVdy1kSrqJWFC0iBfzdBPLI7ZAHl0
         LHMznT6/P01z1ITZwIcXAfqs266O3y03/La4GLyRctfVswQP5/vUNbqk04ddf+UAuCo8
         aEBQ==
X-Gm-Message-State: AFuF++nMV1t1B574KcJ3F+N0D1yoJGa7igMMGUltR3k6iWE4FUvW1QmV
	3N5qUYbV25wcWblatstQVo2pOESfVlV6zZ+0Gq5zzm604DscMfwzCAwQlc4IRlkU
X-Gm-Gg: AYBFou1eeJLV/g/ckWlsni9RmoVtL5r44qHVwaM21h6oSu7kZTujR74X+2sw3XqyiCS
	6ECXF/cGsrLHhXxUTik9Y8PozsRMQ2R+qpKsSucURQu/sPTESX418r6raGx0u8BwA+gZoaMGMhH
	3Z3gxb9lr4N8V2cBy87mK7+/l6iwG2tFnUtmyv/xjuPcQbOjupKkTs7wNbkF5CvKO8yH6KTFN0A
	kUo8MleyKnReRIc5oYhCIw7dtFK/Dwk6wwha6XM9bCUmsxwEdldD/kZlMO1BvDF/A14Sx03xJu7
	h1n887l1/fW2vBVOrLaatC5dn4AwFT/u22YvGwxfRyY9luAyC6tsD7LyE+yyE5/IHxHn+EAvoGq
	5MfA6eqAv/22h3SV3S7c+SqNKsdWuveaoG0ICfIpJseuf+1ZIf0yECYei+hu3pRJ+kxoE/lf72Z
	Y2IHOd1QFN/O9LzSjb2HSqtiGFDINjrs2b86NgBqB6WPD2B72lwRUa3nkAD4OlqN+mLGAguUbeJ
	PlzrrLjPsch0RyWSpi50fE0SQ==
X-Received: by 2002:a05:6000:491e:b0:487:84:96d7 with SMTP id ffacd0b85a97d-4871e373189mr3667759f8f.53.1789737510446;
        Fri, 18 Sep 2026 06:18:30 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871feb5de3sm4424549f8f.1.2026.09.18.06.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:18:29 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	david@kernel.org,
	akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	ljs@kernel.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	sun.jian.kdev@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v9 4/5] bpf: Mark linux_binprm->mm as trusted-or-null
Date: Fri, 18 Sep 2026 16:17:56 +0300
Message-ID: <20260918131757.42802-5-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918131757.42802-1-tasos.papagiannnis@gmail.com>
References: <20260918131757.42802-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark linux_binprm->mm as a trusted-or-null nested pointer so BPF programs
can pass it to kfuncs after a NULL check.

The field is either NULL or points to a live mm_struct whenever BPF can
access a linux_binprm. On successful exec, exec_mmap() installs the new
address space before begin_new_exec() clears bprm->mm. The bprm_mm_init()
error path clears the field before mmdrop(), and free_bprm() clears it
before mmput(), as ensured by an earlier patch in this series.

Update the existing LSM selftest to check bprm->mm for NULL before
dereferencing it, as required for trusted-or-null pointers.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
Reviewed-by: Matt Bobrowski <matt@bobrowski.net>
---
 kernel/bpf/verifier.c                   | 5 +++++
 tools/testing/selftests/bpf/progs/lsm.c | 5 ++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6c6b8d8520cd..3539a768b921 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5997,6 +5997,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry) {
 	struct inode *d_inode;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm) {
+	struct mm_struct *mm;
+};
+
 BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
 	struct sock *sk;
 };
@@ -6051,6 +6055,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 {
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
index 7de173daf27b..7441d66c080c 100644
--- a/tools/testing/selftests/bpf/progs/lsm.c
+++ b/tools/testing/selftests/bpf/progs/lsm.c
@@ -113,6 +113,7 @@ int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
 	struct inner_map *inner_map;
+	struct mm_struct *mm;
 	char args[64];
 	__u32 key = 0;
 	__u64 *value;
@@ -121,7 +122,9 @@ int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
 		bprm_count++;
 
 	bpf_copy_from_user(args, sizeof(args), (void *)bprm->vma->vm_mm->arg_start);
-	bpf_copy_from_user(args, sizeof(args), (void *)bprm->mm->arg_start);
+	mm = bprm->mm;
+	if (mm)
+		bpf_copy_from_user(args, sizeof(args), (void *)mm->arg_start);
 
 	value = bpf_map_lookup_elem(&array, &key);
 	if (value)
-- 
2.55.0

