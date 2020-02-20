Return-Path: <SRS0=tRXP=4I=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2393C11D05
	for <bpf@archiver.kernel.org>; Thu, 20 Feb 2020 13:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5B7208C4
	for <bpf@archiver.kernel.org>; Thu, 20 Feb 2020 13:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEdEFWmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgBTN07 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:26:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50905 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726959AbgBTN07 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Feb 2020 08:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582205218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ngeVrB3Tm8+XJ5G0I1wQIONd8/FUCOa1t00KU8I/VRI=;
        b=cEdEFWmOS5zCjtW/tMXFrsgyKInYb+2RJdu3HeCk1wBHHH+iSEPHe55KssIhqDArRmZh2H
        5VYU2v2hLUH08CoLuDK7tD/ndtWLI4D3w9jr9H7Hyb6kdRHMU6PteBsnaV+ekQz0aIsaGU
        Qzt9iQgw3AK3M5D3h3icsG4P0Do6SEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-fxTgFi99N4OvluUDg_PU0A-1; Thu, 20 Feb 2020 08:26:54 -0500
X-MC-Unique: fxTgFi99N4OvluUDg_PU0A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E38AB107ACC5;
        Thu, 20 Feb 2020 13:26:52 +0000 (UTC)
Received: from localhost.localdomain (wsfd-netdev76.ntdv.lab.eng.bos.redhat.com [10.19.188.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 247BC863A5;
        Thu, 20 Feb 2020 13:26:49 +0000 (UTC)
From:   Eelco Chaudron <echaudro@redhat.com>
To:     bpf@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, toke@redhat.com
Subject: [PATCH bpf-next v5 0/3] libbpf: Add support for dynamic program attach target
Date:   Thu, 20 Feb 2020 13:26:13 +0000
Message-Id: <158220517358.127661.1514720920408191215.stgit@xdp-tutorial>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently when you want to attach a trace program to a bpf program
the section name needs to match the tracepoint/function semantics.

However the addition of the bpf_program__set_attach_target() API
allows you to specify the tracepoint/function dynamically.

The call flow would look something like this:

  xdp_fd =3D bpf_prog_get_fd_by_id(id);
  trace_obj =3D bpf_object__open_file("func.o", NULL);
  prog =3D bpf_object__find_program_by_title(trace_obj,
                                           "fentry/myfunc");
  bpf_program__set_expected_attach_type(prog, BPF_TRACE_FENTRY);
  bpf_program__set_attach_target(prog, xdp_fd,
                                 "xdpfilt_blk_all");
  bpf_object__load(trace_obj)

Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

v1 -> v2: Remove requirement for attach type hint in API
v2 -> v3: Moved common warning to __find_vmlinux_btf_id, requested by And=
rii
          Updated the xdp_bpf2bpf test to use this new API
v3 -> v4: Split up patch, update libbpf.map version
v4 -> v5: Fix return code, and prog assignment in test case

