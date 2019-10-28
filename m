Return-Path: <SRS0=NgTr=YV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3450CCA9EC2
	for <bpf@archiver.kernel.org>; Mon, 28 Oct 2019 18:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1369620862
	for <bpf@archiver.kernel.org>; Mon, 28 Oct 2019 18:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="TxZ1dYYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404262AbfJ1SBG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 28 Oct 2019 14:01:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38290 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbfJ1SBC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Oct 2019 14:01:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3so7396015pgt.5
        for <bpf@vger.kernel.org>; Mon, 28 Oct 2019 11:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=mFR9DJBz4aaSJA6Lp+Gxf14PeSYZwISp0W0+RRJlLaY=;
        b=TxZ1dYYP5sCvuc/G/vsVQZeFEQV6aPYwbiShE+J0+/hTuDkChBkPUWKH31XeHoyFWP
         mp469jb3ziur13QTCBOSpZypO5WPKrylEZfGFg9Hn16P4v8b8UvpGAQUc91pN2g98Lrj
         vf4JYpxfR2GSy6o83cK2SCNr1rz2EslYifVV5pINWltfakM+8HrZReuL2N+RtebqO860
         oz7CQuGhAXI9o28TJ3u273/VuogvrvQ75DLMVjsppvgzU1PS48PrqX9FPQCiN8A2LXKR
         OuOvW+k1sIcQb63WjURoniXxXjf9YlAyBrNIV7S3Mq6w/1n9UzUxdkIK9wWjEFFlckXg
         G+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=mFR9DJBz4aaSJA6Lp+Gxf14PeSYZwISp0W0+RRJlLaY=;
        b=J9Tu8yw0OY2dSTaxMI/QVhqpzpudxqeYv5Veufajl4s9h9W9h10gO3i99Zbp4W64O/
         OFDyj+WA/VeCsahpU9Kgykfsd+Hkqn8zdHen7Mzy7hF/Z48YRSKEzXdTtZVUxqSEj3Ix
         d3xAeUR/VoS3O+zfGmdNpigJ1l6UDkjO5C9ZWPAeSOiua09D6O/tAYQ1QjJfuF/HQcAI
         nTaGggqL4ubwYEqr1c1Pftfa9uyfCZhAwMbKAPLUagF9vDSfnI91Kq65FTupJ5Zhc3f6
         DP2NkxaOqpmmdcMoiCqoNfMOdejaGnRxZoH+wq2GY5GgOc+/qrQOiCsxU5vMGbAotNnm
         edCA==
X-Gm-Message-State: APjAAAVFqS7Zk8AG9ltyqDNZ/b8E1oY6uyDruSqw8tNDi0MXz3+3ZDik
        XYGOrFP4eQnL7f5aHthIb9nLqg==
X-Google-Smtp-Source: APXvYqzPxwLVdq14TKHElmnIG+DCNhkQfxGivfW43j+TLX4y79TdDmbfnHUQXDTexo9uvgwpyylFvg==
X-Received: by 2002:a17:90a:741:: with SMTP id s1mr639682pje.113.1572285660180;
        Mon, 28 Oct 2019 11:01:00 -0700 (PDT)
Received: from cakuba.hsd1.ca.comcast.net ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id r19sm11312566pgj.43.2019.10.28.11.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 11:01:00 -0700 (PDT)
Date:   Mon, 28 Oct 2019 11:00:56 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf@vger.kernel.org, magnus.karlsson@gmail.com,
        magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        jonathan.lemon@gmail.com, toke@redhat.com
Subject: Re: [PATCH bpf-next v3 1/2] xsk: store struct xdp_sock as a
 flexible array member of the XSKMAP
Message-ID: <20191028110056.17eea9fb@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20191025093219.10290-2-bjorn.topel@gmail.com>
References: <20191025093219.10290-1-bjorn.topel@gmail.com>
        <20191025093219.10290-2-bjorn.topel@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 25 Oct 2019 11:32:18 +0200, Bj=C3=B6rn T=C3=B6pel wrote:
> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>=20
> Prior this commit, the array storing XDP socket instances were stored
> in a separate allocated array of the XSKMAP. Now, we store the sockets
> as a flexible array member in a similar fashion as the arraymap. Doing
> so, we do less pointer chasing in the lookup.
>=20
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>

Damn, looks like I managed to reply to v2.=20

I think the size maths may overflow on 32bit machines on the addition.
