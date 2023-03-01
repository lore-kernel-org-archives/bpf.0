Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E70C64EC7
	for <bpf@archiver.kernel.org>; Wed,  1 Mar 2023 08:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCAIzD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 1 Mar 2023 03:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCAIzC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 03:55:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16B82384C
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 00:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677660859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lvxFIGMJ1koscqITpLEtfsyWXIX3v2LDtKDq9jksTkw=;
        b=ciJTKsf6mLmGru9W3YPq6mZ2VJriwDRCI2gr4tuuRAl2X/cQ1egBUwIAL0er+lBdmLrO4g
        vmqqvINBDcwv9BvPfblJhf9gAKCIfLoUiX6iqeXYGAr9uu0KRJSXtezc3544B83Y29U9q/
        5XlRkwJZ41HeMPSn+PEy80WhygZwEHI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-LC9Pmk8wOe-svdJfDSxDdA-1; Wed, 01 Mar 2023 03:54:14 -0500
X-MC-Unique: LC9Pmk8wOe-svdJfDSxDdA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C310F884340;
        Wed,  1 Mar 2023 08:54:13 +0000 (UTC)
Received: from dhcph048.fit.vutbr.cz (unknown [10.45.224.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28C182026D4B;
        Wed,  1 Mar 2023 08:54:10 +0000 (UTC)
From:   Viktor Malik <vmalik@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next 1/3] libbpf: remove unnecessary ternary operator
Date:   Wed,  1 Mar 2023 09:53:53 +0100
Message-Id: <78a3702f2ea9f32a84faaae9b674c56269d330a7.1677658777.git.vmalik@redhat.com>
In-Reply-To: <cover.1677658777.git.vmalik@redhat.com>
References: <cover.1677658777.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Coverity reports that the first check of 'err' in bpf_object__init_maps
is always false as 'err' is initialized to 0 at that point. Remove the
unnecessary ternary operator.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 05c4db355f28..905193d98885 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2615,7 +2615,7 @@ static int bpf_object__init_maps(struct bpf_object *obj,
 	strict = !OPTS_GET(opts, relaxed_maps, false);
 	pin_root_path = OPTS_GET(opts, pin_root_path, NULL);
 
-	err = err ?: bpf_object__init_user_btf_maps(obj, strict, pin_root_path);
+	err = bpf_object__init_user_btf_maps(obj, strict, pin_root_path);
 	err = err ?: bpf_object__init_global_data_maps(obj);
 	err = err ?: bpf_object__init_kconfig_map(obj);
 	err = err ?: bpf_object__init_struct_ops_maps(obj);
-- 
2.39.1

