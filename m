Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BA3C64E8A
	for <bpf@archiver.kernel.org>; Wed,  2 Dec 2020 15:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5819221D81
	for <bpf@archiver.kernel.org>; Wed,  2 Dec 2020 15:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbgLBPcf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 2 Dec 2020 10:32:35 -0500
Received: from m15112.mail.126.com ([220.181.15.112]:41677 "EHLO
        m15112.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgLBPce (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 10:32:34 -0500
X-Greylist: delayed 8887 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Dec 2020 10:32:24 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DCJIk
        vAsWl32sBJESY7hqaqP/My0N7n20xQa12jevA0=; b=U6Ucp+MtqE/fClO37yUoT
        IYaLuRoEhlOHjK6cbxEpUSbwehzTlW/plNURAXGwABUFGm80PKOBL9aFbfpn/ypW
        +0rXZay84LcYz9SUC7ptQJecAMXrLbhL5SWxkFnuRybk8FhcPClvqzr2tlUZZJtI
        GLSBGrKhaa3/Mjn0kn0udk=
Received: from localhost (unknown [117.136.120.114])
        by smtp2 (Coremail) with SMTP id DMmowABX1SGTQcdf_GBDJg--.61443S2;
        Wed, 02 Dec 2020 15:26:12 +0800 (CST)
From:   "xiao.ma" <max701@126.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, xiao.mx.ma@deltaww.com,
        jiajia.feng@deltaww.com
Cc:     Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] dt-bindings:<devicetree/bindings/trivial-devices.yaml>:Add compatible strings
Date:   Tue,  1 Dec 2020 21:26:10 -1000
Message-Id: <20201202072610.1666-1-max701@126.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowABX1SGTQcdf_GBDJg--.61443S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFWxJFyDWF15ZFyfAr4xJFb_yoWfXrb_X3
        WxCF1qyrykJFyFkw4qkF1ktr1UA3W29F4ku348J3Wku34a9rW5WFyvqw1avryxWrW7ury5
        urn3KrZFqrn8GjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8jNt7UUUUU==
X-Originating-IP: [117.136.120.114]
X-CM-SenderInfo: ppd0liar6rjloofrz/1tbi5RXuOFpD6KzEOAAAsH
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "xiao.ma" <xiao.mx.ma@deltaww.com>

Add delta,q54sj108a2 to trivial-devices.yaml.

Signed-off-by: xiao.ma <xiao.mx.ma@deltaww.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index ab623ba930d5..2aad4c86fb29 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -60,6 +60,8 @@ properties:
           - dallas,ds4510
             # Digital Thermometer and Thermostat
           - dallas,ds75
+            # 1/4 Brick DC/DC Regulated Power Module
+          - delta,q54sj108a2
             # Devantech SRF02 ultrasonic ranger in I2C mode
           - devantech,srf02
             # Devantech SRF08 ultrasonic ranger
-- 
2.25.1

