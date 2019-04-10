Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E5EC10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4212A20820
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="X5pYrw8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfDJTuz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:50:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44522 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfDJTuz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 15:50:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id y7so4331389wrn.11
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 12:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1CuzWmgTq2MAcAtGX/tvcBY53hTmNvJxVSfaUHWyquA=;
        b=X5pYrw8bOmRbRtiwaqQKbP3uewUhZW+C9qMqtZcZDcPKBa7ph4LTV2N2sIFpTyfojB
         ubh/mLd6ioG5muixOJnjV/0qKnsdDPqDcGeAHizToOGEcI1XDQeeuq1cbla9nalN1DVe
         oUsTd6tz2WOgWHMbUPm84O4XX/p0TIWnm4HXxd/B0oMGCtnUO9/oCahNkPHCnSNjUKcj
         am63XWbs5PYDymXsGaXgyJu//f+urYG8jfCSAwaiks7snbZS8laIrdpH9rsbm0IHKgYW
         QrkfJDn6pT3hfL0/AS6lG9FE2j8w92S1BJfTiewA2PWEYVUcd68Hmnz1nvtQRzmWYB4g
         rZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1CuzWmgTq2MAcAtGX/tvcBY53hTmNvJxVSfaUHWyquA=;
        b=GazQfr1/LlqJFSi/fHv/xxl60uaMNuZfCXr8yq4tGuWnxSqrEohV1wwIkBGZHEtO6C
         IIh5ILg6OII/mK681LqH+XMHUbdT0JrDhnpjxj/YWEsoTRSJ6nJ8VFfWCLMIsHmSeLbj
         lrAdxk4g3HsRHJu20c+WPutWSZI1zvxUl+EUqtWsziTZhw/I1GgxLg55pzl6v+cduZ+A
         jZyT926LoNcWoqI/IufLFjW2f925en7tfM2G1mYUcuUvuUoxza+2Dhe8emts+YDVRVff
         RqD/1jCOQ7BLSmr8RbzogqTtiGuw8E/eBHbUuJkeKR8IDC9iiszihMj2tzujS/MFC6IT
         MVsQ==
X-Gm-Message-State: APjAAAUfscGpTKN3FMP37bquu9T3V7VceIHPKkL2nsTHB1MgFsXUDwuU
        sjWT2wiIhZMkkXtsInFgA8bIfw==
X-Google-Smtp-Source: APXvYqzeB8oqBzQJrCYtGgUK14hRID04LPcswJ05fNfnJVKBRb5fL+4iIiHub3u0UNOBbVN8OoEC7A==
X-Received: by 2002:a5d:698b:: with SMTP id g11mr29304797wru.65.1554925853091;
        Wed, 10 Apr 2019 12:50:53 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id 4sm2288540wmg.12.2019.04.10.12.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Apr 2019 12:50:52 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH/RFC v2 bpf-next 12/19] selftests: enable hi32 randomization for "test_progs" and "test_verifier"
Date:   Wed, 10 Apr 2019 20:50:26 +0100
Message-Id: <1554925833-7333-13-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"test_progs" contains a couple of C based tests, so is a very good
assurance on the pass correctness for this patch set.

After this patch, BPF_F_TEST_RND_HI32 will be set for all of them and
high 32-bit are randomized when possible. This could deliver quite
stressful tests on x86_64.

hi32 randomized is enabled for "test_verifier" as well. But two testcases
needs adjustments due to 16-bit jump distance overflow.
  - "ld_abs: vlan + abs, test1"
    The function "bpf_fill_ld_abs_vlan_push_pop" inside test_verifier.c
    needs to use ALU64 to avoid insertion of hi32 randomization sequence
    that would overflow the sequence.
  - bpf_fill_jump_around_ld_abs needs to consider hi32 randomization to the
    load dst of ld_abs.

Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 tools/testing/selftests/bpf/test_progs.c    | 2 ++
 tools/testing/selftests/bpf/test_verifier.c | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index bf5c909..4249b5b 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -172,6 +172,8 @@ int main(int ac, char **av)
 	if (ac == 2 && strcmp(av[1], "-s") == 0)
 		verifier_stats = true;
 
+	libbpf_test_mode = true;
+
 #define CALL
 #include <prog_tests/tests.h>
 #undef CALL
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index e2ebcad..7d067e0 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -161,7 +161,7 @@ static void bpf_fill_ld_abs_vlan_push_pop(struct bpf_test *self)
 		goto loop;
 
 	for (; i < len - 1; i++)
-		insn[i] = BPF_ALU32_IMM(BPF_MOV, BPF_REG_0, 0xbef);
+		insn[i] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0xbef);
 	insn[len - 1] = BPF_EXIT_INSN();
 	self->prog_len = len;
 }
@@ -170,7 +170,7 @@ static void bpf_fill_jump_around_ld_abs(struct bpf_test *self)
 {
 	struct bpf_insn *insn = self->fill_insns;
 	/* jump range is limited to 16 bit. every ld_abs is replaced by 6 insns */
-	unsigned int len = (1 << 15) / 6;
+	unsigned int len = (1 << 15) / 9;
 	int i = 0;
 
 	insn[i++] = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
@@ -1014,5 +1014,8 @@ int main(int argc, char **argv)
 	}
 
 	bpf_semi_rand_init();
+
+	libbpf_test_mode = true;
+
 	return do_test(unpriv, from, to);
 }
-- 
2.7.4

