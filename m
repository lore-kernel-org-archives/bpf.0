Return-Path: <SRS0=s9jd=3H=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C266DC33CB1
	for <bpf@archiver.kernel.org>; Sat, 18 Jan 2020 13:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA912469C
	for <bpf@archiver.kernel.org>; Sat, 18 Jan 2020 13:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579355401;
	bh=FiPwg4VgyfJjMCqafBzHOTSPg3CyFECALWrwBJ9z15E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gj0HG8M7k3sbbxcwnwCbUpgJqLZuMinTZZau88bAvGw4OGfkc247B5yhdPFE/tenH
	 R8y+BQj5p3eEZbo9Kov9i4b0DKU7EC1LVPGE1wuXruFPbKyQXo0k/UoppKdWQ2m/T7
	 oI3cDbGnoACJ1TFTVIbetxSAqHXDVGipe++UYKrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgARNuA convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sat, 18 Jan 2020 08:50:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53711 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726421AbgARNuA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Jan 2020 08:50:00 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-zyTBiEhNM0a2G4yer3wQUA-1; Sat, 18 Jan 2020 08:49:56 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 487D6800D48;
        Sat, 18 Jan 2020 13:49:54 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-18.brq.redhat.com [10.40.204.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E66284BC9;
        Sat, 18 Jan 2020 13:49:51 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        David Miller <davem@redhat.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>
Subject: [PATCH 1/6] bpf: Allow ctx access for pointers to scalar
Date:   Sat, 18 Jan 2020 14:49:40 +0100
Message-Id: <20200118134945.493811-2-jolsa@kernel.org>
In-Reply-To: <20200118134945.493811-1-jolsa@kernel.org>
References: <20200118134945.493811-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: zyTBiEhNM0a2G4yer3wQUA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When accessing the context we allow access to arguments with
scalar type and pointer to struct. But we omit pointer to scalar
type, which is the case for many functions and same case as
when accessing scalar.

Adding the check if the pointer is to scalar type and allow it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/btf.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 832b5d7fd892..207ae554e0ce 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3668,7 +3668,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		    const struct bpf_prog *prog,
 		    struct bpf_insn_access_aux *info)
 {
-	const struct btf_type *t = prog->aux->attach_func_proto;
+	const struct btf_type *tp, *t = prog->aux->attach_func_proto;
 	struct bpf_prog *tgt_prog = prog->aux->linked_prog;
 	struct btf *btf = bpf_prog_get_target_btf(prog);
 	const char *tname = prog->aux->attach_func_name;
@@ -3730,6 +3730,17 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		 */
 		return true;
 
+	tp = btf_type_by_id(btf, t->type);
+	/* skip modifiers */
+	while (btf_type_is_modifier(tp))
+		tp = btf_type_by_id(btf, tp->type);
+
+	if (btf_type_is_int(tp) || btf_type_is_enum(tp))
+		/* This is a pointer scalar.
+		 * It is the same as scalar from the verifier safety pov.
+		 */
+		return true;
+
 	/* this is a pointer to another type */
 	info->reg_type = PTR_TO_BTF_ID;
 
-- 
2.24.1

