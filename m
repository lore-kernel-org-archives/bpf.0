Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DF4C433FE
	for <bpf@archiver.kernel.org>; Tue,  4 Oct 2022 02:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJDCFv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 3 Oct 2022 22:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJDCFt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Oct 2022 22:05:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4838A33A2C;
        Mon,  3 Oct 2022 19:05:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0E1AB818EA;
        Tue,  4 Oct 2022 02:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D939C433C1;
        Tue,  4 Oct 2022 02:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664849146;
        bh=6nH59HLyuE3Ew8wmDJblotLdc3le23mr8aMxQV4u9yA=;
        h=Date:From:To:Cc:Subject:From;
        b=SR6kMcEenQsAyVAZIsFE2YHWHqpSbMqyKdKRSSKbFkq8HzzYnEM2uruNGjJao4txJ
         5JYI9JKdQe3r7wO8Se/GJ+Sdu3QP57saZx6muQnVjOjKF7Lrh6i0S/hX0n/S2FSOiI
         SsROICXi8qv/ZlMZ/VpTF2tSvZBeYzx2BesRepzenW9mMbRXUpg9aEw06wIiyllj2k
         akwr1e4itL9bYVl0RvomQoZfZ1B0DHnIje3QQRrXV+JuNcek6pI8ajuh2AvUealD+X
         7UCjZxtgoDK977zmes+0DshQ/2fLFoCK5AXG1cpS4v9Lpl8HiVglOtQF5nfE7BUqFr
         o7vhBgqzuU4qA==
Date:   Mon, 3 Oct 2022 19:05:45 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     bpf@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: objtool: bpf_dispatcher_xdp+0xa0: data relocation to !ENDBR:
Message-ID: <20221003190545.6b7c7aba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jiri,

I get the following warning after merging up all the trees:

vmlinux.o: warning: objtool: ___ksymtab+bpf_dispatcher_xdp_func+0x0: data relocation to !ENDBR: bpf_dispatcher_xdp_func+0x0
vmlinux.o: warning: objtool: bpf_dispatcher_xdp+0xa0: data relocation to !ENDBR: bpf_dispatcher_xdp_func+0x0

$ gcc --version
gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-15)


Is this known?
