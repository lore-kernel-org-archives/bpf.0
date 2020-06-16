Return-Path: <SRS0=otRl=75=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CC3C433E0
	for <bpf@archiver.kernel.org>; Tue, 16 Jun 2020 10:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E221920734
	for <bpf@archiver.kernel.org>; Tue, 16 Jun 2020 10:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592301957;
	bh=0ywlkednVggh9I7+TBEKsl++LHT7iCbm2pWBu5zCdGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F53EDwBPMY4bf5W4tQzdwD1iFe+pZGU8FI5c+NGmoTwA9TxjgIUi5D58eRgfJWNb1
	 CgkCfjHHFrKM72uCHKixUNv0JVRBTeWPShMdxvZ6AqytNFBY5xd3m/0ouwfwToqNXF
	 XefkkPIw3fT6OiwwmnfiOAhOjGYTKqXqNbIuIens=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgFPKF4 convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 16 Jun 2020 06:05:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41721 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728346AbgFPKF4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Jun 2020 06:05:56 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-pX9VizinNoG_56EMAEfUlQ-1; Tue, 16 Jun 2020 06:05:51 -0400
X-MC-Unique: pX9VizinNoG_56EMAEfUlQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DD1681EE58;
        Tue, 16 Jun 2020 10:05:49 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 805765D747;
        Tue, 16 Jun 2020 10:05:45 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 06/11] bpf: Do not pass enum bpf_access_type to btf_struct_access
Date:   Tue, 16 Jun 2020 12:05:07 +0200
Message-Id: <20200616100512.2168860-7-jolsa@kernel.org>
In-Reply-To: <20200616100512.2168860-1-jolsa@kernel.org>
References: <20200616100512.2168860-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There's no need for it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h   | 1 -
 kernel/bpf/btf.c      | 3 +--
 kernel/bpf/verifier.c | 2 +-
 net/ipv4/bpf_tcp_ca.c | 2 +-
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f18c23dcc858..b7d3b5f3dc09 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1282,7 +1282,6 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		    struct bpf_insn_access_aux *info);
 int btf_struct_access(struct bpf_verifier_log *log,
 		      const struct btf_type *t, int off, int size,
-		      enum bpf_access_type atype,
 		      u32 *next_btf_id);
 int btf_resolve_helper_id(struct bpf_verifier_log *log,
 			  const struct bpf_func_proto *fn, int);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index aea7b2cc8d26..304369a4c2e2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3831,7 +3831,6 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 
 int btf_struct_access(struct bpf_verifier_log *log,
 		      const struct btf_type *t, int off, int size,
-		      enum bpf_access_type atype,
 		      u32 *next_btf_id)
 {
 	u32 i, moff, mtrue_end, msize = 0, total_nelems = 0;
@@ -3880,7 +3879,7 @@ int btf_struct_access(struct bpf_verifier_log *log,
 			goto error;
 
 		off = (off - moff) % elem_type->size;
-		return btf_struct_access(log, elem_type, off, size, atype,
+		return btf_struct_access(log, elem_type, off, size,
 					 next_btf_id);
 
 error:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5c7bbaac81ef..b553e4523bd3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3175,7 +3175,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 			return -EACCES;
 		}
 
-		ret = btf_struct_access(&env->log, t, off, size, atype,
+		ret = btf_struct_access(&env->log, t, off, size,
 					&btf_id);
 	}
 
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index e3939f76b024..c6aab9389ac4 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -130,7 +130,7 @@ static int bpf_tcp_ca_btf_struct_access(struct bpf_verifier_log *log,
 	size_t end;
 
 	if (atype == BPF_READ)
-		return btf_struct_access(log, t, off, size, atype, next_btf_id);
+		return btf_struct_access(log, t, off, size, next_btf_id);
 
 	if (t != tcp_sock_type) {
 		bpf_log(log, "only read is supported\n");
-- 
2.25.4

