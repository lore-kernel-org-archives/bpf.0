Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C89C4332F
	for <bpf@archiver.kernel.org>; Sun, 20 Nov 2022 11:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiKTL02 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 20 Nov 2022 06:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiKTL0Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 06:26:24 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E824549B42
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 03:26:23 -0800 (PST)
Date:   Sun, 20 Nov 2022 11:26:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=industrialdiscipline.com; s=protonmail3; t=1668943582;
        x=1669202782; bh=oQDn+Jx1ovImdhDzdOE3ofAMPvtETwjjUpOfUxGeCdA=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=ALxhAklCskPKy+OmNI5FbgXWa/uR0J2mKF0MTXotJUN69ZDErb0i1sjdfSniBDWy/
         FRsnhdC+s3PP1al5QRgpob+GsykQ2N8h6JP5H8IGGDAdZhpS8q9tjysRzful6vfpeW
         feHDn1Et0cE5q57zdkcAceTddlBn+8ks9Bke9F7OWaD7JMp3wKhYeqOp7opXBFW+UF
         6DQ9+0cmFig2LOc63irIviaXoT6FDw3ITZvQS8YkLFX2eZiALh5sCa5+4tVdljZgYN
         dlbtzLMlhxN9dLaTiQ7u3JKcg5z5vO/EFHiPFtEHcHnE3lsZiJpnn3uMM0BBAnT+w6
         TtBt9wm7Ok9mw==
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com, yhs@fb.com
From:   Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org,
        Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Subject: [PATCH bpf-next v4 3/5] bpftool: fix error message when function can't register struct_ops
Message-ID: <20221120112515.38165-4-sahid.ferdjaoui@industrialdiscipline.com>
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
Suggested-by: Quentin Monnet <quentin@isovalent.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/struct_ops.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.=
c
index d3cfdfef9b58..ae9ad85f5cda 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -511,10 +511,9 @@ static int do_register(int argc, char **argv)
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


