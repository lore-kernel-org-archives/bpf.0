Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73635C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482442082F
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="XfSaf34Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbfCZSGt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:06:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36764 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732387AbfCZSGs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 14:06:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so14004148wml.1
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 11:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FyyxR9Iqk6cAH0oBjCaJb0bcVV0NGMOOW5Oun5gFHdM=;
        b=XfSaf34QG8CikR9x/GZqc+vAwaApH2d51JPwWZNYw3W9l72fGWeLbmRKKQnP1mMstf
         eNzP2skW0bzvIQF/RGAXbszctcB2lcL/GqOSi/gn4EBwpZdGm/uB6LSpwQEanhTEeX60
         neQ44wdAaE91+7++dId+zDrSYYWLraJ04in39ObNiUQ+tnIRhdtDzVS2tRacnaR/vUi8
         myhtkkaWoTYgdb0ckosOTUMdWbg8icoOupbo1QXjKmA44ROF7i1jhLg71Dy+a5GCp0XR
         1teWDDyRNldVuplwQCZP77E9QoeI4IWdnQX8b5BL2DWzzNHYpiAwePCY+Nu4GD/NbuUz
         3Q/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FyyxR9Iqk6cAH0oBjCaJb0bcVV0NGMOOW5Oun5gFHdM=;
        b=UOHXejqLVM820we+S/fK4TPvPuOVIFx+mdrZzFDNrLb5I1E6mKUPUXLH4dFqxRFv7o
         L4+8gUo6dWEyiSyybWD8QltPvJtzWQYkjZQ/FVO4gmiadISwpys0IKTWS3s8B8BQ88w1
         bo2dBa3MZN0axIYEcH6/sGbKmhOe0AEwwoszjBkS8oQVoFimUQobzzDrgF5BljUlrJ9F
         5VHSUNiFssvMn3BsmLMDGYrtZUvn/n/mm2Kyxaia6nIwEd43duZ+dvZfObPVp6WyQQTS
         Nvt4jVJ3noHRmhMGeaN9wyk4V5rp6DdPkpWXsyJRIey+DtXwBiyP8sLeM+GyK5ChmiLW
         6IxA==
X-Gm-Message-State: APjAAAXKhm7zG27C8MonZa9wsPiGk0529Ffs2Du2d//zgm0ApX2Ci9kg
        irotRU8mASgrgwrnUBLJOkWVNQ==
X-Google-Smtp-Source: APXvYqwvf0UBF6B5OEGKi/6bb/tefUxEWf7HgV/sCjas1VhJ0iAqDi9GZ/YSF59uu5uq4/7WwYpqWw==
X-Received: by 2002:a1c:eb14:: with SMTP id j20mr10489900wmh.32.1553623606349;
        Tue, 26 Mar 2019 11:06:46 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id i28sm36697534wrc.32.2019.03.26.11.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Mar 2019 11:06:45 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH/RFC bpf-next 09/16] powerpc: bpf: eliminate zero extension code-gen
Date:   Tue, 26 Mar 2019 18:05:32 +0000
Message-Id: <1553623539-15474-10-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 21a1dcd..d10621b 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -559,7 +559,7 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 
 bpf_alu32_trunc:
 		/* Truncate to 32-bits */
-		if (BPF_CLASS(code) == BPF_ALU)
+		if (BPF_CLASS(code) == BPF_ALU && fp->aux->no_verifier_zext)
 			PPC_RLWINM(dst_reg, dst_reg, 0, 0, 31);
 		break;
 
@@ -1046,6 +1046,11 @@ struct powerpc64_jit_data {
 	struct codegen_context ctx;
 };
 
+bool bpf_jit_hardware_zext(void)
+{
+	return false;
+}
+
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 {
 	u32 proglen;
-- 
2.7.4

