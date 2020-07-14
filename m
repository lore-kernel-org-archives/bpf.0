Return-Path: <SRS0=I/LR=AZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE4BC433E7
	for <bpf@archiver.kernel.org>; Tue, 14 Jul 2020 14:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B0222409
	for <bpf@archiver.kernel.org>; Tue, 14 Jul 2020 14:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594737941;
	bh=Iwpq0K3LI/457THLc5GqV5NyV/1EOMMNxj0I7YNH3+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fwCvKo+IZoQ0hBEKYvAEpv5F0VazpwMLkCctrXD/ENV2AoZd9MoVueRUhFPHV+l60
	 PHBzfOTU2RUkdPVixC5XpOqN9GXKvvXzkdij0rt5kVv4+pbzBW/j20GzWkpCg5fj5F
	 Iday3U9i258RcJlP54rsBG4sIBnTQtG/qqd8sleU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgGNOpf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:45:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728455AbgGNOi5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jul 2020 10:38:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3926222C8;
        Tue, 14 Jul 2020 14:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594737536;
        bh=Iwpq0K3LI/457THLc5GqV5NyV/1EOMMNxj0I7YNH3+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w5jEPgTezU+byQQVS1Me13LKRT5bEOqTVr8LKj2MrZ9V38keHKA89xU8JtYHaSTOw
         Xyq/5wZnlTG5peDEXtGIotlJEoWudWWKDVhZ2wm3zNlZ1VKoVpaEpdcH/HTfdjPVnA
         Y5dd7mYhAy53fn2RbF580BeNebw3qJ3JTRHLpyjk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 05/19] bpf: Set the number of exception entries properly for subprograms
Date:   Tue, 14 Jul 2020 10:38:35 -0400
Message-Id: <20200714143849.4035283-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714143849.4035283-1-sashal@kernel.org>
References: <20200714143849.4035283-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

[ Upstream commit c4c0bdc0d2d084ed847c7066bdf59fe2cd25aa17 ]

Currently, if a bpf program has more than one subprograms, each program will be
jitted separately. For programs with bpf-to-bpf calls the
prog->aux->num_exentries is not setup properly. For example, with
bpf_iter_netlink.c modified to force one function to be not inlined and with
CONFIG_BPF_JIT_ALWAYS_ON the following error is seen:
   $ ./test_progs -n 3/3
   ...
   libbpf: failed to load program 'iter/netlink'
   libbpf: failed to load object 'bpf_iter_netlink'
   libbpf: failed to load BPF skeleton 'bpf_iter_netlink': -4007
   test_netlink:FAIL:bpf_iter_netlink__open_and_load skeleton open_and_load failed
   #3/3 netlink:FAIL
The dmesg shows the following errors:
   ex gen bug
which is triggered by the following code in arch/x86/net/bpf_jit_comp.c:
   if (excnt >= bpf_prog->aux->num_exentries) {
     pr_err("ex gen bug\n");
     return -EFAULT;
   }

This patch fixes the issue by computing proper num_exentries for each
subprogram before calling JIT.

Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 739d9ba3ba6b7..eebdd5307713b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9613,7 +9613,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	int i, j, subprog_start, subprog_end = 0, len, subprog;
 	struct bpf_insn *insn;
 	void *old_bpf_func;
-	int err;
+	int err, num_exentries;
 
 	if (env->subprog_cnt <= 1)
 		return 0;
@@ -9688,6 +9688,14 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->nr_linfo = prog->aux->nr_linfo;
 		func[i]->aux->jited_linfo = prog->aux->jited_linfo;
 		func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
+		num_exentries = 0;
+		insn = func[i]->insnsi;
+		for (j = 0; j < func[i]->len; j++, insn++) {
+			if (BPF_CLASS(insn->code) == BPF_LDX &&
+			    BPF_MODE(insn->code) == BPF_PROBE_MEM)
+				num_exentries++;
+		}
+		func[i]->aux->num_exentries = num_exentries;
 		func[i] = bpf_int_jit_compile(func[i]);
 		if (!func[i]->jited) {
 			err = -ENOTSUPP;
-- 
2.25.1

