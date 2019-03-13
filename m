Return-Path: <SRS0=IWuG=RQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F97C43381
	for <bpf@archiver.kernel.org>; Wed, 13 Mar 2019 10:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091582147C
	for <bpf@archiver.kernel.org>; Wed, 13 Mar 2019 10:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfCMKyT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:54:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfCMKyT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Mar 2019 06:54:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60DC8DBD8A;
        Wed, 13 Mar 2019 10:54:19 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-116-177.ams2.redhat.com [10.36.116.177])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 11B7718258;
        Wed, 13 Mar 2019 10:54:16 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>
Subject: bpf jit PPC64 (BE) test_verifier PTR_TO_STACK store/load failure
Date:   Wed, 13 Mar 2019 12:54:16 +0200
Message-ID: <xuny4l87qc2v.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 13 Mar 2019 10:54:19 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

I found a failure:

```
# ./test_verifier 722
#722/u PTR_TO_STACK store/load FAIL retval -1 != -87117812 
0: (bf) r1 = r10
1: (07) r1 += -10
2: (7a) *(u64 *)(r1 +2) = -87117812
3: (79) r0 = *(u64 *)(r1 +2)
4: (95) exit
processed 5 insns (limit 131072), stack depth 8
#722/p PTR_TO_STACK store/load FAIL retval -1 != -87117812 
0: (bf) r1 = r10
1: (07) r1 += -10
2: (7a) *(u64 *)(r1 +2) = -87117812
3: (79) r0 = *(u64 *)(r1 +2)
4: (95) exit
processed 5 insns (limit 131072), stack depth 8
Summary: 0 PASSED, 0 SKIPPED, 2 FAILED
```

The reason is in the JIT. The code is jitted into:

[...]
d00000000580e7f8:       f9 23 00 00     std     r9,0(r3)
d00000000580e7fc:       e9 03 00 02     lwa     r8,0(r3)
[...]

so, it stores DW to the location r3, but loads W, i.e. in BE it is:

saves
r3: FF FF FF FF FA CE B0 0C
loads
r3: FF FF FF FF

(in LE it works semicorretly, saves 0C B0 CE FA FF FF FF FF, loads 0C B0 CE FA)

This is because of the handling of the +2 offset. For stores it is:


#define PPC_STD(r, base, i)	EMIT(PPC_INST_STD | ___PPC_RS(r) |	      \
				     ___PPC_RA(base) | ((i) & 0xfffc))

and for loads
#define PPC_LD(r, base, i)	EMIT(PPC_INST_LD | ___PPC_RT(r) |	      \
				     ___PPC_RA(base) | IMM_L(i))
#define IMM_L(i)		((uintptr_t)(i) & 0xffff)

So, in the load case the offset +2 (immediate value) is not
masked and turns the instruction to lwa instead of ld.


Would it be correct to & 0xfffc the immediate value as well?

BTW, the full run on big endian:

Summary: 1190 PASSED, 125 SKIPPED, 4 FAILED

-- 
WBR,
Yauheni Kaliuta
