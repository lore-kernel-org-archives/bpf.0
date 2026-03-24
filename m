Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E723FB045
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370329; cv=none; b=Ee1TSkg8c5jVud/jbz8hMm+r5bDA/bvD/iO7PTVsXpAAaFcdopJ+DZBiF8w54Xb8ynRfyCsA6NwyYtL7OG5RShgbYB3+0h99CZpTvu8ZOAOpKJjRtN0oLs2foKN0c4m94x3C2Fx2zPqrRC9d22NdW935j4jIDjGzfbIiCTP8aak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370329; c=relaxed/simple;
	bh=UOvR3XhovobpqynbHGCU0fQNnvU65IjeegMHC/thJIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ol9oml/C5vBExNj4kGqkxd8zTD21MTeumLrseoDcDN2HDQXtF13xe1wi8pjNJbZa0pb3MEmp0Qeix7PczAXj6GK0+e+DqDdIPcn1UZF1SVJuMZa/XsIBGcdBUjRPBB3LGf52qW7HeX7Jf5evurOR7kYLMYpWBWUXd38fGZTrlHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyqbS/l6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyqbS/l6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774370327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VbFekKwlwoU0LVMo/vSEonlhfTZg1THOxfIgQfbCYAg=;
	b=eyqbS/l6QNoPO2Ma/JC8xK2IXVva3D+cwh5o8QwVI2fQnpSxKb36WG983lKg318sDaZW/W
	PhOngD52l/SecV8Gc5EvdNY5DHTm12B0miTW63S2QuOgXioNyWqfKtBUCEeLSUw0UzrzGi
	toygcMP3ga3/KqeyKMS9W6uLFmpd4mA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-ySqUa4I0NWSbuQOfiAzPgg-1; Tue,
 24 Mar 2026 12:38:43 -0400
X-MC-Unique: ySqUa4I0NWSbuQOfiAzPgg-1
X-Mimecast-MFC-AGG-ID: ySqUa4I0NWSbuQOfiAzPgg_1774370322
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66BC1195608E;
	Tue, 24 Mar 2026 16:38:42 +0000 (UTC)
Received: from localhost (unknown [10.72.116.133])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 77E361955F21;
	Tue, 24 Mar 2026 16:38:41 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Akilesh Kailash <akailash@google.com>,
	bpf@vger.kernel.org,
	Xiao Ni <xni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 09/12] bpf: add bpf_uring_buf_dynptr to special_kfunc_list
Date: Wed, 25 Mar 2026 00:37:30 +0800
Message-ID: <20260324163753.1900977-10-ming.lei@redhat.com>
In-Reply-To: <20260324163753.1900977-1-ming.lei@redhat.com>
References: <20260324163753.1900977-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Register bpf_uring_buf_dynptr() and bpf_uring_buf_dynptr_rdwr() in the
verifier's special_kfunc_list so they can produce LOCAL dynptrs.
Without these entries, the verifier cannot determine the dynptr type
for the __uninit output parameter.

We cannot reuse the existing bpf_dynptr_from_mem() helper because
kfunc PTR_TO_MEM returns are always marked MEM_RDONLY by the verifier
(meta.r0_rdonly = true), but bpf_dynptr_from_mem() requires writable
memory (ARG_PTR_TO_UNINIT_MEM).  A dedicated kfunc with a
special_kfunc_list entry is the only way to produce a dynptr from
read-only kernel-provided memory.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/bpf/verifier.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 159b25f8269d..42d0672336e1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12531,6 +12531,8 @@ enum special_kfunc_type {
 	KF_bpf_session_is_return,
 	KF_bpf_stream_vprintk,
 	KF_bpf_stream_print_stack,
+	KF_bpf_uring_buf_dynptr,
+	KF_bpf_uring_buf_dynptr_rdwr,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12611,6 +12613,13 @@ BTF_ID(func, bpf_arena_reserve_pages)
 BTF_ID(func, bpf_session_is_return)
 BTF_ID(func, bpf_stream_vprintk)
 BTF_ID(func, bpf_stream_print_stack)
+#ifdef CONFIG_IO_URING_BPF_EXT
+BTF_ID(func, bpf_uring_buf_dynptr)
+BTF_ID(func, bpf_uring_buf_dynptr_rdwr)
+#else
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+#endif
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -13590,6 +13599,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				dynptr_arg_type |= DYNPTR_TYPE_SKB_META;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_file]) {
 				dynptr_arg_type |= DYNPTR_TYPE_FILE;
+			} else if (meta->func_id == special_kfunc_list[KF_bpf_uring_buf_dynptr] ||
+				   meta->func_id == special_kfunc_list[KF_bpf_uring_buf_dynptr_rdwr]) {
+				dynptr_arg_type |= DYNPTR_TYPE_LOCAL;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_file_discard]) {
 				dynptr_arg_type |= DYNPTR_TYPE_FILE;
 				meta->release_regno = regno;
-- 
2.53.0

