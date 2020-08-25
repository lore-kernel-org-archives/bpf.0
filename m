Return-Path: <SRS0=alw5=CD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C72EC433DF
	for <bpf@archiver.kernel.org>; Tue, 25 Aug 2020 19:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A282071E
	for <bpf@archiver.kernel.org>; Tue, 25 Aug 2020 19:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598383337;
	bh=DZgxDW+XQJ7FtxDWtY9WT+byFRhCVK8m1ISa71Id3D0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dmMGQXWQIfl5CnWkD7DswDogYp81fMbiZu0FDo7scpFUocMV+OBK5X9mHejyEjRPf
	 bREanP/2V0tRYifzC/vcpBndtqTSdC29Ull6t5l0hA4PT4RQQVVx7yddzt5tkE3WMB
	 JkIFk5OJ4TP4Yep6aKXw3tG/KKElHjjHwk+TYQ14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHYTWQ convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 25 Aug 2020 15:22:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38920 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726947AbgHYTWO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Aug 2020 15:22:14 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-L73Sk5FaPius9RJG_ddvOA-1; Tue, 25 Aug 2020 15:22:07 -0400
X-MC-Unique: L73Sk5FaPius9RJG_ddvOA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 869BD801AAD;
        Tue, 25 Aug 2020 19:22:05 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6731819C4F;
        Tue, 25 Aug 2020 19:22:02 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH v12 bpf-next 08/14] bpf: Add btf_struct_ids_match function
Date:   Tue, 25 Aug 2020 21:21:18 +0200
Message-Id: <20200825192124.710397-9-jolsa@kernel.org>
In-Reply-To: <20200825192124.710397-1-jolsa@kernel.org>
References: <20200825192124.710397-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding btf_struct_ids_match function to check if given address provided
by BTF object + offset is also address of another nested BTF object.

This allows to pass an argument to helper, which is defined via parent
BTF object + offset, like for bpf_d_path (added in following changes):

  SEC("fentry/filp_close")
  int BPF_PROG(prog_close, struct file *file, void *id)
  {
    ...
    ret = bpf_d_path(&file->f_path, ...

The first bpf_d_path argument is hold by verifier as BTF file object
plus offset of f_path member.

The btf_struct_ids_match function will walk the struct file object and
check if there's nested struct path object on the given offset.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h   |  2 ++
 kernel/bpf/btf.c      | 31 +++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c | 17 +++++++++++------
 3 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 81f38e2fda78..d6c356abcc0f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1350,6 +1350,8 @@ int btf_struct_access(struct bpf_verifier_log *log,
 		      const struct btf_type *t, int off, int size,
 		      enum bpf_access_type atype,
 		      u32 *next_btf_id);
+bool btf_struct_ids_match(struct bpf_verifier_log *log,
+			  int off, u32 id, u32 need_type_id);
 int btf_resolve_helper_id(struct bpf_verifier_log *log,
 			  const struct bpf_func_proto *fn, int);
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d8d64201c4e0..df966acaaeb1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4160,6 +4160,37 @@ int btf_struct_access(struct bpf_verifier_log *log,
 	return -EINVAL;
 }
 
+bool btf_struct_ids_match(struct bpf_verifier_log *log,
+			  int off, u32 id, u32 need_type_id)
+{
+	const struct btf_type *type;
+	int err;
+
+	/* Are we already done? */
+	if (need_type_id == id && off == 0)
+		return true;
+
+again:
+	type = btf_type_by_id(btf_vmlinux, id);
+	if (!type)
+		return false;
+	err = btf_struct_walk(log, type, off, 1, &id);
+	if (err != WALK_STRUCT)
+		return false;
+
+	/* We found nested struct object. If it matches
+	 * the requested ID, we're done. Otherwise let's
+	 * continue the search with offset 0 in the new
+	 * type.
+	 */
+	if (need_type_id != id) {
+		off = 0;
+		goto again;
+	}
+
+	return true;
+}
+
 int btf_resolve_helper_id(struct bpf_verifier_log *log,
 			  const struct bpf_func_proto *fn, int arg)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dd24503ab3d3..0689d6e66245 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3995,16 +3995,21 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 				goto err_type;
 		}
 	} else if (arg_type == ARG_PTR_TO_BTF_ID) {
+		bool ids_match = false;
+
 		expected_type = PTR_TO_BTF_ID;
 		if (type != expected_type)
 			goto err_type;
 		if (!fn->check_btf_id) {
 			if (reg->btf_id != meta->btf_id) {
-				verbose(env, "Helper has type %s got %s in R%d\n",
-					kernel_type_name(meta->btf_id),
-					kernel_type_name(reg->btf_id), regno);
-
-				return -EACCES;
+				ids_match = btf_struct_ids_match(&env->log, reg->off, reg->btf_id,
+								 meta->btf_id);
+				if (!ids_match) {
+					verbose(env, "Helper has type %s got %s in R%d\n",
+						kernel_type_name(meta->btf_id),
+						kernel_type_name(reg->btf_id), regno);
+					return -EACCES;
+				}
 			}
 		} else if (!fn->check_btf_id(reg->btf_id, arg)) {
 			verbose(env, "Helper does not support %s in R%d\n",
@@ -4012,7 +4017,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 
 			return -EACCES;
 		}
-		if (!tnum_is_const(reg->var_off) || reg->var_off.value || reg->off) {
+		if ((reg->off && !ids_match) || !tnum_is_const(reg->var_off) || reg->var_off.value) {
 			verbose(env, "R%d is a pointer to in-kernel struct with non-zero offset\n",
 				regno);
 			return -EACCES;
-- 
2.25.4

