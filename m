Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5203C4332F
	for <bpf@archiver.kernel.org>; Sun, 13 Nov 2022 10:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbiKMKPc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 13 Nov 2022 05:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbiKMKPa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 05:15:30 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B16B10043
        for <bpf@vger.kernel.org>; Sun, 13 Nov 2022 02:15:29 -0800 (PST)
Date:   Sun, 13 Nov 2022 10:15:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=industrialdiscipline.com; s=protonmail3; t=1668334528;
        x=1668593728; bh=h1IACGtxa6jlM9vgCUlf5uLix6QeRIlMWBO4zTtcMLk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=YfVN6aHLCaTY/0iLukZlZ8SBDMFiIT9/uawcvA+OvOt7yJ6FFx6jlgPp2whrLFUQ7
         KlIxaORdJyHLQkW5PaLVweDCm9ANd6Gbx3CLTDHVG1gNhOmmTNbhRYCvsNpMO/LPkS
         8Qfvs1outulfZWyiAi22ACt7Sjd/E4sB04ikrvpgeqmZnMX6jMD2kjpLX4yMDbCvk5
         B8qFUfMZknl77jMDZQQAaeGGOLTzp5ulok+ZWn1h0cOV2b0LQHFZQ2Yo3dPpwJD+VV
         1nIhsACWVsMt1IldQkY0SJVcPycFi0jRe/jjOWFN7ZNN6g4AnyH7KVnenmXJRFujVL
         R02tjePCGfAIg==
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com, yhs@fb.com
From:   Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org,
        Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Subject: [PATCH bpf-next v3 2/5] bpftool: replace return value PTR_ERR(NULL) with 0
Message-ID: <20221113101438.30910-3-sahid.ferdjaoui@industrialdiscipline.com>
In-Reply-To: <20221113101438.30910-1-sahid.ferdjaoui@industrialdiscipline.com>
References: <20221113101438.30910-1-sahid.ferdjaoui@industrialdiscipline.com>
Feedback-ID: 39921202:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is no reasons to keep PTR_ERR() when kern_btf=3DNULL, let's just
return 0.
This also cleans this part of code from using libbpf_get_error().

Signed-off-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@industrialdiscipli=
ne.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 tools/bpf/bpftool/struct_ops.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.=
c
index e08a6ff2866c..1a235d0c6742 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -62,11 +62,8 @@ static __s32 get_map_info_type_id(void)
 =09if (map_info_type_id)
 =09=09return map_info_type_id;

-=09kern_btf =3D get_btf_vmlinux();
-=09if (libbpf_get_error(kern_btf)) {
-=09=09map_info_type_id =3D PTR_ERR(kern_btf);
-=09=09return map_info_type_id;
-=09}
+=09if (!kern_btf)
+=09=09return 0;

 =09map_info_type_id =3D btf__find_by_name_kind(kern_btf, "bpf_map_info",
 =09=09=09=09=09=09  BTF_KIND_STRUCT);
--
2.34.1


