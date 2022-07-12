Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56895C43334
	for <bpf@archiver.kernel.org>; Tue, 12 Jul 2022 18:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbiGLS2W (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 12 Jul 2022 14:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiGLS2V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 14:28:21 -0400
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.6.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C32FBDB88
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 11:28:19 -0700 (PDT)
Received: from localhost.localdomain ([160.80.103.126])
        by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 26CHxCBr005871
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 Jul 2022 19:59:12 +0200
From:   Andrea Mayer <andrea.mayer@uniroma2.it>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        David Lebrun <david.lebrun@uclouvain.be>,
        Mathieu Xhonneux <m.xhonneux@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
        Anton Makarov <anton.makarov11235@gmail.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [net 0/3] seg6: fix skb checksum for SRH encapsulation/insertion 
Date:   Tue, 12 Jul 2022 19:58:34 +0200
Message-Id: <20220712175837.16267-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The Linux kernel supports Segment Routing Header (SRH)
encapsulation/insertion operations by providing the capability to: i)
encapsulate a packet in an outer IPv6 header with a specified SRH; ii)
insert a specified SRH directly after the IPv6 header of the packet.
Note that the insertion operation is also referred to as 'injection'.

The two operations are respectively supported by seg6_do_srh_encap() and
seg6_do_srh_inline(), which operate on the skb associated to the packet as
needed (e.g. adding the necessary headers and initializing them, while
taking care to recalculate the skb checksum).

seg6_do_srh_encap() and seg6_do_srh_inline() do not initialize the payload
length of the IPv6 header, which is carried out by the caller functions.
However, this approach causes the corruption of the skb checksum which
needs to be updated only after initialization of headers is completed
(thanks to Paolo Abeni for detecting this issue).

The patchset fixes the skb checksum corruption by moving the IPv6 header
payload length initialization from the callers of seg6_do_srh_encap() and
seg6_do_srh_inline() directly into these functions.

This patchset is organized as follows:
 - patch 1/3, seg6: fix skb checksum evaluation in SRH
   encapsulation/insertion;
    (* SRH encapsulation/insertion available since v4.10)
   
 - patch 2/3, seg6: fix skb checksum in SRv6 End.B6 and End.B6.Encaps
   behaviors;
    (* SRv6 End.B6 and End.B6.Encaps behaviors available since v4.14)

 - patch 3/3, seg6: bpf: fix skb checksum in bpf_push_seg6_encap();
    (* bpf IPv6 Segment Routing helpers available since v4.18)

Thank you all,
Andrea

Andrea Mayer (3):
  seg6: fix skb checksum evaluation in SRH encapsulation/insertion
  seg6: fix skb checksum in SRv6 End.B6 and End.B6.Encaps behaviors
  seg6: bpf: fix skb checksum in bpf_push_seg6_encap()

 net/core/filter.c        | 1 -
 net/ipv6/seg6_iptunnel.c | 5 ++++-
 net/ipv6/seg6_local.c    | 2 --
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.20.1

