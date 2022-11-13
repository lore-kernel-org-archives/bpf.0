Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FEAC433FE
	for <bpf@archiver.kernel.org>; Sun, 13 Nov 2022 10:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbiKMKPu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 13 Nov 2022 05:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbiKMKPt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 05:15:49 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E9C10043
        for <bpf@vger.kernel.org>; Sun, 13 Nov 2022 02:15:48 -0800 (PST)
Date:   Sun, 13 Nov 2022 10:15:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=industrialdiscipline.com; s=protonmail3; t=1668334547;
        x=1668593747; bh=8GSPHn4O53sTLod7/E+4CLpO/MNESJq9UAKPzvC9fXo=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=THhMIex/3rkkMF9rby9NN7cWllqKbSZY02VWJDL8k7P3Ljoy2QmZwhgas45k9doxi
         vXtxeh24R3eqRx8iiIMqjRmNhnKzmkJAa7eR39NlJWOOMcaA0+/MgXgZj8uXpzUJcZ
         ulA1nVujYa6uCSHsbLB59bZjujUjCAOEbVSDnigiP1+7+b23GALc9fle+itfWHbmvu
         1du3YqFEGkfIa8UUCWuF5dMDVotgMdklBy1ponIkQIYIrCBGPCi4I8O4XPjaAizjhA
         2s8PjrKwYJJojV7sCaoijFK32gy7YaXZs6QZidJGx27nIUN1YBIRlQMx1jTyK57KVD
         zEAi2FRzQEGJQ==
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com, yhs@fb.com
From:   Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org,
        Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Subject: [PATCH bpf-next v3 3/5] bpftool: fix error message when function can't register struct_ops
Message-ID: <20221113101438.30910-4-sahid.ferdjaoui@industrialdiscipline.com>
Feedback-ID: 39921202:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It is expected that errno be passed to strerror(). This also cleans
this part of code from using libbpf_get_error().

Signed-off-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@industrialdiscipli=
ne.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 tools/bpf/bpftool/struct_ops.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.=
c
index 1a235d0c6742..a6c6d5b9551e 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -510,10 +510,9 @@ static int do_register(int argc, char **argv)
 =09=09=09continue;

 =09=09link =3D bpf_map__attach_struct_ops(map);
-=09=09if (libbpf_get_error(link)) {
+=09=09if (!link) {
 =09=09=09p_err("can't register struct_ops %s: %s",
-=09=09=09      bpf_map__name(map),
-=09=09=09      strerror(-PTR_ERR(link)));
+=09=09=09      bpf_map__name(map), strerror(errno));
 =09=09=09nr_errs++;
 =09=09=09continue;
 =09=09}
--
2.34.1


