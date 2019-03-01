Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC31C43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 03:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D2220838
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 03:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="sNtt8t0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfCADvq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 22:51:46 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35977 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfCADvp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 22:51:45 -0500
Received: by mail-qt1-f196.google.com with SMTP id p25so26301826qtb.3
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 19:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=qoDm6V9aRS0MBpPSPy2M+34i3K1Swh0qPLMFSiXV8YE=;
        b=sNtt8t0Y748ISwORkbUP08f2cLX/w7d7cYy4+uqwZntq0dHW6DcM96+6OuY0jJ9ACO
         a04WMCGL6gkGcNCzczdR0OvF4BSro00nCKXlvgg00PPwcRmMX5NQV8qcQPkckfX/4Rkx
         3MpcIKpcuXO1Obp2k7euXw+hFeQRk6eClHt9pI/RQO5ByKe8fXLcds9oI7D0jVPOgnQs
         UIjBZi2riWIUdkdgsi1+1HKk571y8tdewRfyH/9tKL1xwrnv3BaWRP1fs8FBxQ4aefkC
         ktXF+fI/mBl2BXBD9a/w8JPS8kUBAtQYgPrVzq+l3xe5G7EATZOEcD0ZF5UQ+f6Ua8oY
         4CAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=qoDm6V9aRS0MBpPSPy2M+34i3K1Swh0qPLMFSiXV8YE=;
        b=mvhtFUpU6klCYWGIpbFZFV0xmYIryG2lbw3lh7kh8GksinZAo/R6OOoc1WyRYJcNeK
         FKjKXjIyd8cT2SbvlXF+BIHaq1CdBkNZ93NbKwITysuKdn7m3j27hFssde7gS0vjpOYc
         88vjRQ1oki90aGxORkI0uW9NDFUpn2dp3L3v09S5OakyfVqTvdWxHgBBglO2VS5Zdagp
         gJUhjFU/8yV6yA59ahNrmqU3QTulh5z3L5PHUfZThyXO08g8aGks56O0IJWrK/RyV5tC
         46m9HY7B9ya+dJ+np16vUSJQwcbquIOcBISYbAHhZ1tvU9BSpCyuMQSTcduXbjtANdrz
         0o8A==
X-Gm-Message-State: APjAAAViIS78BTLFZi1MV8DOtbMPqBs8oQrx791cdHUqUqnPV8B+GM1R
        QQwX4v1yn9cqX0h5G5NYyMgR2w==
X-Google-Smtp-Source: APXvYqwR2hYdQqLj2g26vvn34m2QMlnHO0Wbh/nqFn8p6D7mnRi/HcfoOV7rgzXXwcngeuGQ4GPUQA==
X-Received: by 2002:a0c:87b1:: with SMTP id 46mr2118021qvj.203.1551412304207;
        Thu, 28 Feb 2019 19:51:44 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id s16sm9555069qks.90.2019.02.28.19.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 19:51:43 -0800 (PST)
Date:   Thu, 28 Feb 2019 19:51:35 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        joe@wand.net.nz, john.fastabend@gmail.com, tgraf@suug.ch,
        yhs@fb.com, andriin@fb.com, lmb@cloudflare.com
Subject: Re: [PATCH bpf-next v2 2/7] bpf: add program side {rd,wr}only
 support
Message-ID: <20190228195135.2a5f3277@cakuba.netronome.com>
In-Reply-To: <20190228231829.11993-3-daniel@iogearbox.net>
References: <20190228231829.11993-1-daniel@iogearbox.net>
        <20190228231829.11993-3-daniel@iogearbox.net>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri,  1 Mar 2019 00:18:24 +0100, Daniel Borkmann wrote:
> This work adds two new map creation flags BPF_F_RDONLY_PROG
> and BPF_F_WRONLY_PROG in order to allow for read-only or
> write-only BPF maps from a BPF program side.
> 
> Today we have BPF_F_RDONLY and BPF_F_WRONLY, but this only
> applies to system call side, meaning the BPF program has full
> read/write access to the map as usual while bpf(2) calls with
> map fd can either only read or write into the map depending
> on the flags. BPF_F_RDONLY_PROG and BPF_F_WRONLY_PROG allows
> for the exact opposite such that verifier is going to reject
> program loads if write into a read-only map or a read into a
> write-only map is detected.
> 
> We've enabled this generic map extension to various non-special
> maps holding normal user data: array, hash, lru, lpm, local
> storage, queue and stack. Further map types could be followed
> up in future depending on use-case. Main use case here is to
> forbid writes into .rodata map values from verifier side.

This will also enable optimizing the accesses on system with rich
memory architecture :)

> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/linux/bpf.h           | 18 ++++++++++++++++++
>  include/uapi/linux/bpf.h      | 10 +++++++++-
>  kernel/bpf/arraymap.c         |  2 +-
>  kernel/bpf/hashtab.c          |  2 +-
>  kernel/bpf/local_storage.c    |  2 +-
>  kernel/bpf/lpm_trie.c         |  2 +-
>  kernel/bpf/queue_stack_maps.c |  3 +--
>  kernel/bpf/verifier.c         | 30 +++++++++++++++++++++++++++++-
>  8 files changed, 61 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index bdcc6e2a9977..3f74194dd4f6 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -427,6 +427,24 @@ struct bpf_array {
>  	};
>  };
>  
> +#define BPF_MAP_CAN_READ	BIT(0)
> +#define BPF_MAP_CAN_WRITE	BIT(1)
> +
> +static inline u32 bpf_map_flags_to_cap(struct bpf_map *map)
> +{
> +	u32 access_flags = map->map_flags & (BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG);
> +
> +	/* Combination of BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG is
> +	 * not possible.
> +	 */

minor nit: we do check that old RDONLY and WRONLY are not set at the
           same time, but here it's not done?

> +	if (access_flags & BPF_F_RDONLY_PROG)
> +		return BPF_MAP_CAN_READ;
> +	else if (access_flags & BPF_F_WRONLY_PROG)
> +		return BPF_MAP_CAN_WRITE;
> +	else
> +		return BPF_MAP_CAN_READ | BPF_MAP_CAN_WRITE;
> +}
