Return-Path: <SRS0=G29D=7V=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D2EC433DF
	for <bpf@archiver.kernel.org>; Mon,  8 Jun 2020 23:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BBA821532
	for <bpf@archiver.kernel.org>; Mon,  8 Jun 2020 23:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658106;
	bh=q+/YNJFG0GRlIcTN8/G1ReOa5iQS1CReUKZzJgxNyxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AyLX9IbvaKQcrgw/4XCkRFLWMtKuLM8gZZ2b15836eHk4sjB5Up4ac3c14+kD00my
	 m2mIz0zKPh7nZ9O6GHGwAazvverQ6MPVB9WM7Tj7wfq68yF1LiBkx1ZU2dgZ0AhCN8
	 paZ0L3HRLk+7gpYgyigUgkEbk6FA+ub51WgUmKlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbgFHXPE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729954AbgFHXPC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 19:15:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCAF621531;
        Mon,  8 Jun 2020 23:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658102;
        bh=q+/YNJFG0GRlIcTN8/G1ReOa5iQS1CReUKZzJgxNyxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qQJ90JEU4iRiJ+em6F+/ImFFSr293/GElhc8WCUPN+ZSbXQpNiABHCntFUjsbKtzh
         vMonIVwh/GDcokTYqNdDpF9Li+KnroJ1CNlkawHr9i3nTzxeFkIsSMs0g8x4R4r5WK
         lorJtJ0QAGPNJFQJ/iHzJMRLG7EkHUVrOoAk9Jig=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 142/606] bpf: Add bpf_probe_read_{user, kernel}_str() to do_refine_retval_range
Date:   Mon,  8 Jun 2020 19:04:27 -0400
Message-Id: <20200608231211.3363633-142-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

commit 47cc0ed574abcbbde0cf143ddb21a0baed1aa2df upstream.

Given bpf_probe_read{,str}() BPF helpers are now only available under
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE, we need to add the drop-in
replacements of bpf_probe_read_{kernel,user}_str() to do_refine_retval_range()
as well to avoid hitting the same issue as in 849fa50662fbc ("bpf/verifier:
refine retval R0 state for bpf_get_stack helper").

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20200515101118.6508-3-daniel@iogearbox.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c1bb5be530e9..775fca737909 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4113,7 +4113,9 @@ static int do_refine_retval_range(struct bpf_verifier_env *env,
 
 	if (ret_type != RET_INTEGER ||
 	    (func_id != BPF_FUNC_get_stack &&
-	     func_id != BPF_FUNC_probe_read_str))
+	     func_id != BPF_FUNC_probe_read_str &&
+	     func_id != BPF_FUNC_probe_read_kernel_str &&
+	     func_id != BPF_FUNC_probe_read_user_str))
 		return 0;
 
 	/* Error case where ret is in interval [S32MIN, -1]. */
-- 
2.25.1

