Return-Path: <SRS0=qFa8=AG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ECAC433E0
	for <bpf@archiver.kernel.org>; Thu, 25 Jun 2020 22:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F258E20781
	for <bpf@archiver.kernel.org>; Thu, 25 Jun 2020 22:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593123235;
	bh=57BJhYVuxmf8IGi1lhBrfVKSjsAPnyKrys3ZyfseoTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sDQuxlo6NKu/41XWS1Xs/BFQnz1w/Qk8qaSgo6w9fRci79YMZCcAQbMficUHSu6Ud
	 o0fqxiwaUkbbuIzuu1kgw7ww4SznWr7GQ2sibbEzFTvpRnv3wyNjXkqgvTxrCSzXwV
	 DUzYeQRBGs7zqpU1G/9jrKapVbCAYC64b6p1UptA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436637AbgFYWNy convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Thu, 25 Jun 2020 18:13:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32351 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2436601AbgFYWNy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Jun 2020 18:13:54 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-IlUWvR7iMS-ztPrC6map_Q-1; Thu, 25 Jun 2020 18:13:51 -0400
X-MC-Unique: IlUWvR7iMS-ztPrC6map_Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 169C9800C60;
        Thu, 25 Jun 2020 22:13:49 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EB2F7933A;
        Thu, 25 Jun 2020 22:13:45 +0000 (UTC)
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
Subject: [PATCH v4 bpf-next 09/14] bpf: Add info about .BTF.ids section to btf.rst
Date:   Fri, 26 Jun 2020 00:12:59 +0200
Message-Id: <20200625221304.2817194-10-jolsa@kernel.org>
In-Reply-To: <20200625221304.2817194-1-jolsa@kernel.org>
References: <20200625221304.2817194-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Updating btf.rst doc with info about .BTF.ids section

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 Documentation/bpf/btf.rst | 53 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 4d565d202ce3..60cfb3b06f34 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -691,6 +691,59 @@ kernel API, the ``insn_off`` is the instruction offset in the unit of ``struct
 bpf_insn``. For ELF API, the ``insn_off`` is the byte offset from the
 beginning of section (``btf_ext_info_sec->sec_name_off``).
 
+4.2 .BTF.ids section
+====================
+
+The .BTF.ids section encodes BTF ID values that are used within the kernel.
+
+This section is created during the kernel compilation with the help of
+macros defined in ``include/linux/btf_ids.h`` header file. Kernel code can
+use them to create lists and sets (sorted lists) of BTF ID values.
+
+The ``BTF_ID_LIST`` macro defines unsorted list of BTF ID values,
+with following syntax::
+
+  BTF_ID_LIST(list)
+  BTF_ID(type1, name1)
+  BTF_ID(type2, name2)
+
+resulting in following layout in .BTF.ids section::
+
+  __BTF_ID__type1__name1__1:
+  .zero 4
+  __BTF_ID__type2__name2__2:
+  .zero 4
+
+The ``int list[];`` variable is defined to access the list.
+
+The ``BTF_SET_START/END`` macros pair defines sorted list of BTF ID values
+and their count, with following syntax::
+
+  BTF_SET_START(set)
+  BTF_ID(type1, name1)
+  BTF_ID(type2, name2)
+  BTF_SET_END(set)
+
+resulting in following layout in .BTF.ids section::
+
+  __BTF_ID__set__set:
+  .zero 4
+  __BTF_ID__type1__name1__3:
+  .zero 4
+  __BTF_ID__type2__name2__4:
+  .zero 4
+
+The ``struct btf_id_set set;`` variable is defined to access the list.
+
+The ``typeX`` name can be one of following::
+
+   struct, union, typedef, func
+
+and is used as a filter whem resolving the BTF ID value.
+
+All the BTF ID lists and sets are compiled in the .BTF.ids section and
+resolved during the linking phase of kernel build by ``resolve_btfids`` tool.
+
 5. Using BTF
 ************
 
-- 
2.25.4

