Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD025C10F11
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 19:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9405F20674
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 19:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfDXTuO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:50:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51225 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDXTuO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 15:50:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so6139983wmf.1;
        Wed, 24 Apr 2019 12:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8vIPW03wrW+htwPmdib/gQQ/jqW9LSd/8lCwKtlTu4Y=;
        b=KUl4m6nKRUKqfX505WWj3jZ/cQSIPOg/7cJlSYf8Mv+WDaBnGN39eQdUED5AU1/Xzl
         OsoayoJHzGrgpOKnH73k2aGPPBpLxR04avSS76WMNI6Iak72F26XuZ8uPpRZhLaypHhc
         9IGmmxnBjRirsF07E1v1GOL0KX5sKLPLJ7MdvITvCyAdmMSQFQd33ympnsqX5bqVY67q
         8BSad2vm6aZKiTsTh6ZBZzeQ9r52Iv5Wv0D20m1As/JCViDRb4zATeM91oAYAJoCP4NX
         cSK2IrXWC6RL9yf8Is1ythbSE+TjJ6EAUMKgVmfUN7CD5c80zgQzSHSaNb8frXJJOdKI
         AZiA==
X-Gm-Message-State: APjAAAUZlH9gpPFLpkZy/+pQ7kwhQ9VibeqoCmU7VPCmv3JPL87/WSkt
        4MTxCc4+e8y+Pbdeuh6MJ5o=
X-Google-Smtp-Source: APXvYqxy/RqIiFmppHspuDdIrVWT6kikAXKShBlWF+CH2v5M/Vqh2G5pmd3WEmyI/OrHv/djc0OmrA==
X-Received: by 2002:a1c:ed12:: with SMTP id l18mr606259wmh.13.1556135412301;
        Wed, 24 Apr 2019 12:50:12 -0700 (PDT)
Received: from Nover ([161.105.209.130])
        by smtp.gmail.com with ESMTPSA id h84sm21339882wmf.15.2019.04.24.12.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 12:50:12 -0700 (PDT)
Date:   Wed, 24 Apr 2019 21:49:58 +0200
From:   Paul Chaignon <paul.chaignon@orange.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Xiao Han <xiao.han@orange.com>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf v3 0/2] bpf: mark registers in all frames after pkt/null
 checks
Message-ID: <cover.1556127905.git.paul.chaignon@orange.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In case of a null check on a pointer inside a subprog, we should mark all
registers with this pointer as either safe or unknown, in both the current
and previous frames.  Currently, only spilled registers and registers in
the current frame are marked.  Packet bound checks in subprogs have the
same issue.  The first patch fixes it to mark registers in previous frames
as well.

A good reproducer for null checks looks as follow:

1: ptr = bpf_map_lookup_elem(map, &key);
2: ret = subprog(ptr) {
3:   return ptr != NULL;
4: }
5: if (ret)
6:   value = *ptr;

With the above, the verifier will complain on line 6 because it sees ptr
as map_value_or_null despite the null check in subprog 1.  The second
patch implements the above as a new test case.

Note that this patch fixes another resulting bug when using
bpf_sk_release():

1: sk = bpf_sk_lookup_tcp(...);
2: subprog(sk) {
3:   if (sk)
4:     bpf_sk_release(sk);
5: }
6: if (!sk)
7:   return 0;
8: return 1;

In the above, mark_ptr_or_null_regs will warn on line 6 because it will
try to free the reference state, even though it was already freed on
line 3.

Changelogs:
  Changes in v3:
    - Fix same issue in find_good_pkt_pointers().
    - Add test case for find_good_pkt_pointers() issue.
    - Change title to account for the above change. Old title was
      "bpf: mark registers as safe or unknown in all frames".
    - Refactor find_good_pkt_pointers and mark_ptr_or_null_regs.
    - I did not keep Yonghong's ack because of the above changes.
  Changes in v2:
    - Fix example codes in commit message.

Paul Chaignon (2):
  bpf: mark registers in all frames after pkt/null checks
  selftests/bpf: test cases for pkt/null checks in subprogs

 kernel/bpf/verifier.c                         | 76 +++++++++++--------
 tools/testing/selftests/bpf/verifier/calls.c  | 25 ++++++
 .../bpf/verifier/direct_packet_access.c       | 22 ++++++
 3 files changed, 93 insertions(+), 30 deletions(-)

-- 
2.17.1

