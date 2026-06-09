Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EA23AA1A9
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023205; cv=none; b=C4fonJLNZEn0lmUJaujaT9VOK+dGnUw5SpFfrs1P615WxVERK01xCDIiJH+1FEGKbmesP0jEh+jqAuM8i+7RRLUqOrvzBnWC5LRxUwpOUETfDMnlTvQFMFreb6xMjNsYUmjxuz4J5KYku054h7/w7vEAsByiGUC0NoeuhsZyL1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023205; c=relaxed/simple;
	bh=uCGb2Vf1xqjIHcirDX9+DKWr0c/Yj3HdHKTEeKmBNIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7cUDyUUZ7IuoTS+G0yWeTiEPP+9zaJJvybi0Q8TRqV53YpHPspu6TM/+Rf1r3OG4pTD4jQ/9EUkcz95hdNRBT3LjcSzQuJ96uJBofyRiIJxATNEFbu+SfuRUqcHmc1slplS3W0BuEirjlBwnMY5h2RnNX6mMcu/eEV88ZTBCQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 68DCC14982C4AB; Tue,  9 Jun 2026 09:39:52 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 1/3] selftests/bpf: Keep int return type for tailcall subprogs with maps
Date: Tue,  9 Jun 2026 09:39:52 -0700
Message-ID: <20260609163952.1718472-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260609163947.1717694-1-yonghong.song@linux.dev>
References: <20260609163947.1717694-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

LLVM23 ([1]) supports 'true' function signature in BTF. The return type
of the caller of a tailcall must be an 'int'. Otherwise, verification wil=
l
fail (see check_btf_func() in check_btf.c). So with llvm23, it is possibl=
e
that the compiler may change the caller's return type from 'int' to 'void=
'.
To prevent this, barrier_var() is used to avoid returning a constant pron=
e
to be optimized.

Use Array map to store the subprog return values. Otherwise, due to

        data_map =3D bpf_object__find_map_by_name(fentry_obj, ".bss");
        if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
                          "find data_map"))
                goto out;

in prog_tests/tailcalls.c test_tailcall_hierarchy_count(),
the test result will be different from the original one.

  [1] https://github.com/llvm/llvm-project/pull/198426

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c   | 21 +++++++++++++++----
 .../progs/tailcall_bpf2bpf_hierarchy_fentry.c | 20 +++++++++++++++---
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy=
1.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
index d556b19413d7..13b0ee9475a8 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
@@ -11,25 +11,38 @@ struct {
 	__uint(value_size, sizeof(__u32));
 } jmp_table SEC(".maps");
=20
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, int);
+	__type(value, __u64);
+} array SEC(".maps");
+
 int count =3D 0;
=20
 static __noinline
 int subprog_tail(struct __sk_buff *skb)
 {
+	int ret =3D 0;
+
 	bpf_tail_call_static(skb, &jmp_table, 0);
-	return 0;
+	barrier_var(ret);
+	return ret;
 }
=20
 SEC("tc")
 int entry(struct __sk_buff *skb)
 {
-	int ret =3D 1;
+	int ret =3D 1, ret1, ret2, key1 =3D 0, key2 =3D 1;
=20
 	clobber_regs_stack();
=20
 	count++;
-	subprog_tail(skb);
-	subprog_tail(skb);
+	ret1 =3D subprog_tail(skb);
+	ret2 =3D subprog_tail(skb);
+
+	bpf_map_update_elem(&array, &key1, &ret1, 0);
+	bpf_map_update_elem(&array, &key2, &ret2, 0);
=20
 	return ret;
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy=
_fentry.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_=
fentry.c
index 5261395713cd..97ba7c446013 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry=
.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry=
.c
@@ -13,23 +13,37 @@ struct {
 	__uint(value_size, sizeof(__u32));
 } jmp_table SEC(".maps");
=20
+struct {
+        __uint(type, BPF_MAP_TYPE_ARRAY);
+        __uint(max_entries, 2);
+        __type(key, int);
+        __type(value, __u64);
+} array SEC(".maps");
+
 int count =3D 0;
=20
 static __noinline
 int subprog_tail(void *ctx)
 {
+	int ret =3D 0;
+
 	bpf_tail_call_static(ctx, &jmp_table, 0);
-	return 0;
+	barrier_var(ret);
+	return ret;
 }
=20
 SEC("fentry/dummy")
 int BPF_PROG(fentry, struct sk_buff *skb)
 {
+	int key1 =3D 0, key2 =3D 1, ret1, ret2;
+
 	clobber_regs_stack();
=20
 	count++;
-	subprog_tail(ctx);
-	subprog_tail(ctx);
+	ret1 =3D subprog_tail(ctx);
+	ret2 =3D subprog_tail(ctx);
+	bpf_map_update_elem(&array, &key1, &ret1, 0);
+	bpf_map_update_elem(&array, &key2, &ret2, 0);
=20
 	return 0;
 }
--=20
2.53.0-Meta

