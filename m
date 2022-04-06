Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0701AC433F5
	for <bpf@archiver.kernel.org>; Wed,  6 Apr 2022 17:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbiDFRHA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238505AbiDFRGu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 13:06:50 -0400
X-Greylist: delayed 425 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Apr 2022 07:46:01 PDT
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4063C33B031
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 07:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Subject:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID;
        bh=M+gQwr5UHy+fMPv7KTQBkKhZXL0NQ6ynmHWPYMxg8cw=; b=oFTiHw9mZrhit
        AfQVxd3SkqQ4cYIrrjRBct4YY3LNI//CiqYQH9szdmzzFvQ4Lqwu2Xy2lLnpPo6+
        k+Cyx6sB+NheQVJG1xr+AW96HzneaKGNLazCcT3bCIWU6mj6n+Ky+APSwBSAH8iT
        nck+3TcmMRxTH1wOZWW7GRflQcyJ/o=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Wed, 6 Apr
 2022 22:38:52 +0800 (GMT+08:00)
X-Originating-IP: [222.64.172.188]
Date:   Wed, 6 Apr 2022 22:38:52 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wuzongyo@mail.ustc.edu.cn
To:     bpf@vger.kernel.org
Subject: [Question] Failed to load ebpf program with BTF-defined map
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20210401(c5ff3689) Copyright (c) 2002-2022 www.mailtech.cn ustccn
X-SendMailWithSms: false
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <50b0dbb.2936.17fff506075.Coremail.wuzongyo@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygAHDtb8pU1iaNsDAA--.0W
X-CM-SenderInfo: pzx200xj1rqzxdloh3xvwfhvlgxou0/1tbiAQwICVQhoFZrBAAAsg
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I wrote a simple tc-bpf program like that:

    #include <linux/bpf.h>
    #include <linux/pkt_cls.h>
    #include <linx/types.h>
    #include <bpf/bpf_helpers.h>

    struct {
        __uint(type, BPF_MAP_TYPE_HASH);
        __uint(max_entries, 1);
        __type(key, int);
        __type(value, int);
    } hmap SEC(".maps");

    SEC("classifier")
    int _classifier(struct __sk_buff *skb)
    {
        int key = 0;
        int *val;

        val = bpf_map_lookup_elem(&hmap, &key);
        if (!val)
            return TC_ACT_OK;
        return TC_ACT_OK;
    }

    char __license[] SEC("license") = "GPL";

Then I tried to use tc to load the program:
    
    tc qdisc add dev eth0 clsact
    tc filter add dev eth0 egress bpf da obj test_bpf.o

But the program loading failed with error messages:
    Prog section 'classifier' rejected: Permission denied (13)!
    - Type:          3
    - Instructions:  9 (0 over limit
    - License:       GPL

    Verifier analysis:

    Error fetching program/map!
    Unable to load program

I tried to replace the map definition with the following code and the program is loaded successfully!

    struct bpf_map_def SEC("maps") hmap = {
        .type = BPF_MAP_TYPE_HASH,
        .key_size = sizeof(int),
        .value_size = sizeof(int),
        .max_entries = 1,
    };

With bpftrace, I can find that the errno -EACCES is returned by function do_check(). But I am still confused what's wrong with it.

Linux Version: 5.17.0-rc3+ with CONFIG_DEBUG_INFO_BTF=y
TC Version: 5.14.0

Any suggestion will be appreciated!

Thanks

