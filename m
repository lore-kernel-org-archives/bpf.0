Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87508C43381
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 13:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5D12075E
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 13:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ik3BZiqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfC0Nw2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:52:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36624 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfC0Nw1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Mar 2019 09:52:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id r124so9975792pgr.3;
        Wed, 27 Mar 2019 06:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fM5Eo8WMYIZveFGXjK1IONJkoNyC9dhs1YDrTapqH1w=;
        b=Ik3BZiqIQ8AIZ1AchML/ffjTGm3guggK7foDCDxJZyFcIqILHipiJQ3EOAI8DXlng0
         A/MHiqlGgdDWdx9ADEgl2V+GJ+RkyE95HpgTDZHCupcluDTlI7Ft06QaCt5hx84VJCbF
         DNbCQzLwY+C7abSJJpAN6kpentTReDfeNYl/7afrnFob9ML1jltOErmzw6DE3M2k/fPp
         KBdlGiEohzsMG8y1OacU4j07uElkleI7WvT780fRy3YeDjOEf0eyySf8o82sQmRr8zJV
         9oqhgEKVxQk6FlPLWEq5tuO4J/GkTbrp0ZfccZpytXiN9dsu46eTp8jtZ39VZgduBRxp
         DMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fM5Eo8WMYIZveFGXjK1IONJkoNyC9dhs1YDrTapqH1w=;
        b=diQHSzxhEfk2Nzxg3fCUa0SV/OSvhREMH/dGYkl8e1kBDdJ7pwV7NhIEYEp7+nJRu6
         HNc0pcagWCby+YY+z8b8vgV/YlmuI9v79MYgZ9QE9TevrXoGfb3aVO5E6hYGQA98PRsb
         w20uXYBFAuJi/4Gg9SHJq4JNG0d7AxqMlhw0/7AFpbdTzkb2xLzFacNyuSIo79HYEnRg
         vjUThFsf+UvLplRe3/MdB00ytFNcGHtO7njOehwHKheAKvCxHDF0uw4s4DnnMvXWCWdi
         insx7tYVV9/5EJmEWbQNRyUjGKq8PJcVFMtvVaiLHh/LncRUjE/d3I6gFD1i9vDCwiq/
         0+Ug==
X-Gm-Message-State: APjAAAXPFFdiPUWu/uPWiQJqSPyPuyXil0PF6E3/8ADt8ahOv9474Tdj
        wtgA6Rm17nkhcbvI2fkPIX8=
X-Google-Smtp-Source: APXvYqzr65h29HDnlZ4IY7/Pn/jcfZ8JGqMWH7Z5Hv0NhgPm+FuBO3Kn3LAegvfUsz/qTl7RwbW2qA==
X-Received: by 2002:a65:60c7:: with SMTP id r7mr35444314pgv.37.1553694747232;
        Wed, 27 Mar 2019 06:52:27 -0700 (PDT)
Received: from btopel-mobl.ger.intel.com ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id d15sm6823571pfo.34.2019.03.27.06.52.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 06:52:26 -0700 (PDT)
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        magnus.karlsson@intel.com, bpf@vger.kernel.org,
        xiaolong.ye@intel.com, qi.z.zhang@intel.com
Subject: [PATCH bpf 0/2] libbpf: minor packaging fixes
Date:   Wed, 27 Mar 2019 14:51:12 +0100
Message-Id: <20190327135114.17026-1-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The DPDK project is moving forward with its AF_XDP PMD, and during
that process some libbpf issues surfaced [1].

This series address two, minor, packaging issues for libbpf. The
header file xsk.h was missing from the instal_headers target and
libelf was not included in the libbpf.so (shared library) build.


Thanks,
Björn

[1] https://patches.dpdk.org/patch/50704/#93571

Björn Töpel (2):
  libbpf: add xsk.h to install_headers target
  libbpf: add libelf dependency to shared library build

 tools/lib/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.19.1

