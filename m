Return-Path: <SRS0=M/y+=AW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B679C433F2
	for <bpf@archiver.kernel.org>; Sat, 11 Jul 2020 21:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A0820725
	for <bpf@archiver.kernel.org>; Sat, 11 Jul 2020 21:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594504439;
	bh=f+d5PHm5rZexdsBQdiXMQNqMomfi2LA7JOjLyDTdN8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lvj0pd6lOk0xRAW+S/DJ5EVEekjxUF0euPsw6y12flKQYLcHiyE9F3s7uKE9uz0/E
	 a2oDNmRGLocCdba5rbTIm20lHiVI6sumq+xUYXIHVR4B9L05EGpPXF7+ubs8uXKw6R
	 zy/fMUQM0eptOhmQfmuNQOoaeXwIp6A8ZrgYQCF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgGKVx6 convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sat, 11 Jul 2020 17:53:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51366 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728211AbgGKVxv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 11 Jul 2020 17:53:51 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-wwaWyGBKMPutCB8ThLphvA-1; Sat, 11 Jul 2020 17:53:46 -0400
X-MC-Unique: wwaWyGBKMPutCB8ThLphvA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DC021083;
        Sat, 11 Jul 2020 21:53:45 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C85FE60BEC;
        Sat, 11 Jul 2020 21:53:43 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v7 bpf-next 7/9] bpf: Add info about .BTF_ids section to btf.rst
Date:   Sat, 11 Jul 2020 23:53:27 +0200
Message-Id: <20200711215329.41165-8-jolsa@kernel.org>
In-Reply-To: <20200711215329.41165-1-jolsa@kernel.org>
References: <20200711215329.41165-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Updating btf.rst doc with info about .BTF_ids section

Acked-by: Andrii Nakryiko <andriin@fb.com>
Tested-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 Documentation/bpf/btf.rst | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 4d565d202ce3..b5361b8621c9 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -691,6 +691,42 @@ kernel API, the ``insn_off`` is the instruction offset in the unit of ``struct
 bpf_insn``. For ELF API, the ``insn_off`` is the byte offset from the
 beginning of section (``btf_ext_info_sec->sec_name_off``).
 
+4.2 .BTF_ids section
+====================
+
+The .BTF_ids section encodes BTF ID values that are used within the kernel.
+
+This section is created during the kernel compilation with the help of
+macros defined in ``include/linux/btf_ids.h`` header file. Kernel code can
+use them to create lists and sets (sorted lists) of BTF ID values.
+
+The ``BTF_ID_LIST`` and ``BTF_ID`` macros define unsorted list of BTF ID values,
+with following syntax::
+
+  BTF_ID_LIST(list)
+  BTF_ID(type1, name1)
+  BTF_ID(type2, name2)
+
+resulting in following layout in .BTF_ids section::
+
+  __BTF_ID__type1__name1__1:
+  .zero 4
+  __BTF_ID__type2__name2__2:
+  .zero 4
+
+The ``u32 list[];`` variable is defined to access the list.
+
+The ``BTF_ID_UNUSED`` macro defines 4 zero bytes. It's used when we
+want to define unused entry in BTF_ID_LIST, like::
+
+      BTF_ID_LIST(bpf_skb_output_btf_ids)
+      BTF_ID(struct, sk_buff)
+      BTF_ID_UNUSED
+      BTF_ID(struct, task_struct)
+
+All the BTF ID lists and sets are compiled in the .BTF_ids section and
+resolved during the linking phase of kernel build by ``resolve_btfids`` tool.
+
 5. Using BTF
 ************
 
-- 
2.25.4

