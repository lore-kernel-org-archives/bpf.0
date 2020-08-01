Return-Path: <SRS0=+7Cc=BL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3569EC433DF
	for <bpf@archiver.kernel.org>; Sat,  1 Aug 2020 17:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DF06206E9
	for <bpf@archiver.kernel.org>; Sat,  1 Aug 2020 17:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596301455;
	bh=TElq2iDLIWPnpZTsVRK7uTiZ+vQTXYN26Q6K19aA+1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KWp5+v2dyzJ1qvD7ELaZ6ozY8gn8+CLb4qtLf27DPPLCHoV5JDBLXYImRj6yHH1y9
	 TgcGyNiJrKLXfKO9j1/PFmZHUuG9nghxrDEPu/1Jzl90E5Drqk/XWuEeIKNlmnpgX2
	 cjHpMRz62AAfHtBkxbwyvXMd3i2ff8FkFqjL+uZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgHAREO convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sat, 1 Aug 2020 13:04:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34338 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728020AbgHAREO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 1 Aug 2020 13:04:14 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-YkLXQObwPdKdBFeOrHc6Qg-1; Sat, 01 Aug 2020 13:04:08 -0400
X-MC-Unique: YkLXQObwPdKdBFeOrHc6Qg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A49E418839E0;
        Sat,  1 Aug 2020 17:04:05 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E4C67C10C;
        Sat,  1 Aug 2020 17:04:02 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v9 bpf-next 11/14] bpf: Update .BTF_ids section in btf.rst with sets info
Date:   Sat,  1 Aug 2020 19:03:19 +0200
Message-Id: <20200801170322.75218-12-jolsa@kernel.org>
In-Reply-To: <20200801170322.75218-1-jolsa@kernel.org>
References: <20200801170322.75218-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Updating btf.rst doc with info about BTF_SET_START/END macros.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 Documentation/bpf/btf.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index b5361b8621c9..44dc789de2b4 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -724,6 +724,31 @@ want to define unused entry in BTF_ID_LIST, like::
       BTF_ID_UNUSED
       BTF_ID(struct, task_struct)
 
+The ``BTF_SET_START/END`` macros pair defines sorted list of BTF ID values
+and their count, with following syntax::
+
+  BTF_SET_START(set)
+  BTF_ID(type1, name1)
+  BTF_ID(type2, name2)
+  BTF_SET_END(set)
+
+resulting in following layout in .BTF_ids section::
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
+and is used as a filter when resolving the BTF ID value.
+
 All the BTF ID lists and sets are compiled in the .BTF_ids section and
 resolved during the linking phase of kernel build by ``resolve_btfids`` tool.
 
-- 
2.25.4

