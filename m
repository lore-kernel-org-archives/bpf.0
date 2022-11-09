Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CD4C4332F
	for <bpf@archiver.kernel.org>; Wed,  9 Nov 2022 07:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiKIHpk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 9 Nov 2022 02:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKIHpi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 02:45:38 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5D1186FE
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 23:45:38 -0800 (PST)
Date:   Wed, 09 Nov 2022 07:45:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=industrialdiscipline.com; s=protonmail3; t=1667979936;
        x=1668239136; bh=ua0gwJ84ZgAM1z3Mv8rulZXwDGWQPOQguVjegqF+/U8=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=Xv55qVhb59n2sWFmrJ9KsY781kuHbhGedzaVKRbPwxFEnc14Xtxt7dSWI4zPFiqHL
         miMDfgLvAPxNdZDxEMt1rZi4LSQLhdlvvbij2hOWFBZ1OjHl9FTHtzaq92CgDCoZJ0
         ejVsr9CcEOCL2svPUjsS2ZCPtIxDLhOxKIUjWT+X8h/XZTvWcxybNlsjH1s61S3bG9
         A5tB8hUFpieUY07fOmDTIYVcqJ0WzZ9vX0v5TCfu7bV+FVRsHx5jq8riOZEh2BO6NI
         ruedgVzpgxaOdQjmx/a3K+yNyHR+p73vR+Yw3b2VMNcPcKxAPJi+1oXhXjjdgjZkE8
         N/5SF+ItmN1Kg==
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com
From:   Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Subject: [PATCH bpf-next v2 3/5] bpftool: fix error message when function can't register struct_ops
Message-ID: <20221109074427.141751-4-sahid.ferdjaoui@industrialdiscipline.com>
Feedback-ID: 39921202:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It is expected that errno be passed to strerror().

Signed-off-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@industrialdiscipli=
ne.com>
---
 tools/bpf/bpftool/struct_ops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.=
c
index 68281f9b7a0e..e0927dbb837b 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -513,8 +513,7 @@ static int do_register(int argc, char **argv)
 =09=09link =3D bpf_map__attach_struct_ops(map);
 =09=09if (libbpf_get_error(link)) {
 =09=09=09p_err("can't register struct_ops %s: %s",
-=09=09=09      bpf_map__name(map),
-=09=09=09      strerror(-PTR_ERR(link)));
+=09=09=09      bpf_map__name(map), strerror(errno));
 =09=09=09nr_errs++;
 =09=09=09continue;
 =09=09}
--
2.34.1


