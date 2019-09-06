Return-Path: <SRS0=IQzl=XB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC706C43331
	for <bpf@archiver.kernel.org>; Fri,  6 Sep 2019 07:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955732082C
	for <bpf@archiver.kernel.org>; Fri,  6 Sep 2019 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567755108;
	bh=bkr2q67zBXuqQWbr7vwJ+CWCErw0DFlWvdrIAV18m/Y=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Zt1/9czv7tDcs67MZBgM8h/pfdnGh4YP0rcDmamOovOeSoC4PYp2CFjIjWAmxGUcv
	 SOwy9Qh5jhDzZhmzcNB9sQtQ/xhfTPN3Rq4KHYvmfJHkcYRWwNss4oHRPXE+u0ptCU
	 OJnbY0CJisjzEhsMmbXpamqVhtA/xD0Jtnl6QSoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbfIFHbs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 6 Sep 2019 03:31:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732504AbfIFHbs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Sep 2019 03:31:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A017180041A;
        Fri,  6 Sep 2019 07:31:47 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.205.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B16D160126;
        Fri,  6 Sep 2019 07:31:45 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH 0/7] libbpf: Fix cast away const qualifiers in btf.h
Date:   Fri,  6 Sep 2019 09:31:37 +0200
Message-Id: <20190906073144.31068-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Fri, 06 Sep 2019 07:31:47 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
when including btf.h in bpftrace, I'm getting -Wcast-qual warnings like:

  bpf/btf.h: In function ‘btf_var_secinfo* btf_var_secinfos(const btf_type*)’:
  bpf/btf.h:302:41: warning: cast from type ‘const btf_type*’ to type
  ‘btf_var_secinfo*’ casts away qualifiers [-Wcast-qual]
    302 |  return (struct btf_var_secinfo *)(t + 1);
        |                                         ^

I changed the btf.h header to comply with -Wcast-qual checks
and used const cast away casting in libbpf objects, where it's
all related to deduplication code, so I believe loosing const
is fine there.

thanks,
jirka


---
Jiri Olsa (7):
      libbpf: Use const cast for btf_int_* functions
      libbpf: Return const btf_array from btf_array inline function
      libbpf: Return const btf_enum from btf_enum inline function
      libbpf: Return const btf_member from btf_members inline function
      libbpf: Return const btf_param from btf_params inline function
      libbpf: Return const btf_var from btf_var inline function
      libbpf: Return const struct btf_var_secinfo from btf_var_secinfos inline function

 tools/lib/bpf/btf.c    | 21 +++++++++++----------
 tools/lib/bpf/btf.h    | 30 +++++++++++++++---------------
 tools/lib/bpf/libbpf.c |  2 +-
 3 files changed, 27 insertions(+), 26 deletions(-)
