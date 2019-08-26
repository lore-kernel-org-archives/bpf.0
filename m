Return-Path: <SRS0=TB1Z=WW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2D5C3A59F
	for <bpf@archiver.kernel.org>; Mon, 26 Aug 2019 21:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04A021881
	for <bpf@archiver.kernel.org>; Mon, 26 Aug 2019 21:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="axgBS9ni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfHZVc7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 26 Aug 2019 17:32:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43280 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbfHZVc7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Aug 2019 17:32:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id h13so28370180edq.10
        for <bpf@vger.kernel.org>; Mon, 26 Aug 2019 14:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=gBwDGsC6foYqXEPI47ZDhCrEWzYaPgLkTrUQJeVlEUI=;
        b=axgBS9niHQTJhaOHrQVs/D2379m7mRjRRp7N1UPdbqaCZiWXR3Vse9jTmhow2Jku5N
         j+jjfar6Dnw3/lU8toCSl/ZVoXiOyNUDafjN3UEhIzpExBk1mNyidPpfk03+k5DM1Ciq
         mqPeyWHxTLlrHCxTrXYLQ724ccQg4L5yCgIX1+LRRoCmOvS3AwYIfazHmf2VXgPup2r+
         1M39IHjlLvRS3cRHySK/29E6hnO4mUnZw3y10DVSVpPltPBRV15e6UbS2VSPkh/hcX6G
         pCAKeJ6C6RTBg0DzTMuGUwoitsT/VnzjMjKUwWkremtCLqPQ4PoX7ScYLVQHHkf/TrUz
         ODWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=gBwDGsC6foYqXEPI47ZDhCrEWzYaPgLkTrUQJeVlEUI=;
        b=l51CNJ+PEvmC8t/3mqB4rve4irsyzxquGWEWOGSjzb2IEzrdPwsOK8XovY5x4T3UC0
         XgRP1zBS4TJSv8I83UdUiWzDzOTblUN6emgUGoJLM5ByX3o0Yb7xDWzSyT/v/uRFegwJ
         /YZp2K2ACg5HvV64KMdj3KytVvcs6yX6e0clM7VtV1ZRofqBgSt2Z4VdZ2SZoWAHyseM
         aYwofu9t61wv8LesDOyPxN/PgyoEf6RfyS4Zsq0Oml+w/KFsLa0ZuSjYU5lOFaI8XfbJ
         phreTG2Hv/nJjmtYsTjbqqOihfqp7IAZywle3LgsduB/EzL2r3cN0P6Nd28roHwc8SVM
         A4ZQ==
X-Gm-Message-State: APjAAAXcMU2hQzKW1U7uJ2Ni7VpYjAthYgHsIrVRe1N60QuIHU9j4Zxe
        qsLCuvsF0E2X2mhesn88r+8m7A==
X-Google-Smtp-Source: APXvYqzquzVt14p3LLDL+d3Z5AzbHNSEdgfLktAqh2hV/Fjlt9aM1wW8rtmdqp+rQakkGhepRtZVXw==
X-Received: by 2002:a50:f70b:: with SMTP id g11mr2398581edn.263.1566855177482;
        Mon, 26 Aug 2019 14:32:57 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id oq26sm3058283ejb.66.2019.08.26.14.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 14:32:57 -0700 (PDT)
Date:   Mon, 26 Aug 2019 14:32:37 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Mallesham Jatharakonda <mallesh537@gmail.com>
Cc:     borisp@mellanox.com, davejwatson@fb.com, daniel@iogearbox.net,
        davem@davemloft.net, ast@kernel.org, kafai@fb.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: TLS record double free
Message-ID: <20190826143237.7dd91c62@cakuba.netronome.com>
In-Reply-To: <CADgrbRrtawBDAnk+E-PBUd2qiEd7Q3SrvF7F+HVjsE=6JAnvHg@mail.gmail.com>
References: <CADgrbRrtawBDAnk+E-PBUd2qiEd7Q3SrvF7F+HVjsE=6JAnvHg@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thank you for the report.

On Sun, 25 Aug 2019 22:21:50 +0530, Mallesham Jatharakonda wrote:
> Hi All,
> 
> Am facing one tls double while using the Nitrox(cavium) card and n5pf
> driver over the TLS module.
> 
> Please see the below details:
> 
> TLS module is crashing While running SSL record encryption using
> Klts_send_[file]
> 
> Precondition:
> 1) Installed 5.3-rc4.
> 2) Nitrox5 card pluggin.

Presumably this card contains a crypto accelerator? Does it have any
special characteristic which could help us narrow down the bug search?

Before we proceed - are you able to reproduce this issue with an
pure upstream kernel? It seems the kernel in the BUG report is tainted.

> Steps to produce the issue:
> 1) Install n5pf.ko.(drivers/crypto/cavium/nitrox)
> 2) Install tls.ko if not is installed by default(net/tls)
> 3) Taken uperf tool from git.
>    3.1) Modified uperf to use tls module by using setsocket.
>    3.2) Modified uperf tool to support sendfile with SSL.
> 
> 
> Test:
> 1) Running uperf with 4threads.
> 2) Each Thread send the data using sendfile over SSL protocol.
> 
> 
> After few seconds kernel is crashing because of record list corruption
> 
> 
> [  270.888952] ------------[ cut here ]------------
> [  270.890450] list_del corruption, ffff91cc3753a800->prev is
> LIST_POISON2 (dead000000000122)
> [  270.891194] WARNING: CPU: 1 PID: 7387 at lib/list_debug.c:50
> __list_del_entry_valid+0x62/0x90
> [  270.892037] Modules linked in: n5pf(OE) netconsole tls(OE) bonding
> intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal
> intel_powerclamp coretemp kvm_intel kvm iTCO_wdt iTCO_vendor_support
> irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
> aesni_intel crypto_simd mei_me cryptd glue_helper ipmi_si sg mei
> lpc_ich pcspkr joydev ioatdma i2c_i801 ipmi_devintf ipmi_msghandler
> wmi ip_tables xfs libcrc32c sd_mod mgag200 drm_vram_helper ttm
> drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm isci
> libsas ahci scsi_transport_sas libahci crc32c_intel serio_raw igb
> libata ptp pps_core dca i2c_algo_bit dm_mirror dm_region_hash dm_log
> dm_mod [last unloaded: nitrox_drv]
> [  270.896836] CPU: 1 PID: 7387 Comm: uperf Kdump: loaded Tainted: G
>         OE     5.3.0-rc4 #1
