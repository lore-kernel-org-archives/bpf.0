Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD96C10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 23:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8742D218A3
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 23:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="e8LnnoWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfDLX5j (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 19:57:39 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34619 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfDLX5j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 19:57:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id k2so13286430qtm.1
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 16:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=zy5WW3coDUPdD9PzfYAKQ+RyYpRNumKsgaZNmQrITTQ=;
        b=e8LnnoWAzZ/pIy5ty+zNtsK04ZxrFd2DEOm3+tvuxwkPp/4iVPF295yxk00pdfEjsU
         HOVkAAWFJlpESvfxe9809Tm9SdPCWfyWe3gG/XB5jy9Gg/95bdyv0/MWIk7QYTrRVZGU
         4qcvWmZz5GYOG4ck1AsicFkxQz2CphG+i3FuLmOC8g7u6thqaBtrixoAADrP83l6Uqhk
         Kr+U4zPeuUWuahmYDppV9PaSTzaBDI9o3Osv3dW8ZYv7ywjM4v4r44X//U7soummkLIs
         JBbw+GJPZPkUZxVVexeOpcArd9QuGFZBq6sIcgtNvGWozf3TdDiW990MVcty6e1r+NyP
         pMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=zy5WW3coDUPdD9PzfYAKQ+RyYpRNumKsgaZNmQrITTQ=;
        b=t4vwZSdGO81z1OhPmS0YLmzkgW2Unt3FIURJTeOBv6unwADRAkkjl8LTl9uKY07g7q
         LnDCEv9w/O4ciTaY22gGRcYf1f1Dx19jNfDjvmruVAvNET6ixCOkBqAp7ptmvOAmCOmS
         G7sgP+ua65C9vCHszQkuzPscdIR6ay6ipGVYvMDVkOoUWP23vzSd/JGNFNjqIHZ8b/nq
         xqM+LtBlt/NmA/W0P5UsNIjiL9g5KdQ4k/fRRWVW/MCyyaVJStf9COSzTwe7NMoM2q7C
         YohECseXJco3Ceb+9fKJmYbRMEHX/L1FSgS6kczQrgqcfZDG3AaB83sVmc/yzLs9+Wi+
         T8/Q==
X-Gm-Message-State: APjAAAXyy9BiiVy3v/N0nN2N3B2Wx5SRg0U/G4XOg30cWZDbmvtgAO+U
        RuFKRXYZwrhRpsU04rQ4mc6OhA==
X-Google-Smtp-Source: APXvYqzzrpkPvBLcIxEESYXbDEmSepGGzt60Pr2X+cS/9um5EbeC//3yAk425WBdij6+mJROb3B54g==
X-Received: by 2002:a0c:949c:: with SMTP id j28mr50059369qvj.18.1555113458198;
        Fri, 12 Apr 2019 16:57:38 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id s41sm22591662qta.72.2019.04.12.16.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 16:57:38 -0700 (PDT)
Date:   Fri, 12 Apr 2019 16:57:34 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Benjamin Poirier <bpoirier@suse.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpftool: Use print_entry_error() in
 case of ENOENT when dumping
Message-ID: <20190412165725.6ad21acb@cakuba.netronome.com>
In-Reply-To: <20190412030322.15494-1-bpoirier@suse.com>
References: <20190411082700.26888-1-bpoirier@suse.com>
        <20190412030322.15494-1-bpoirier@suse.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 12 Apr 2019 12:03:21 +0900, Benjamin Poirier wrote:
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index e96903078991..71840faaeab5 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -261,20 +261,19 @@ static void print_entry_json(struct bpf_map_info *info, unsigned char *key,
>  }
>  
>  static void print_entry_error(struct bpf_map_info *info, unsigned char *key,
> -			      const char *value)
> +			      const char *value, bool single_line)
>  {
> -	int value_size = strlen(value);
> -	bool single_line, break_names;
> +	bool break_names;

I'd rather you kept the strlen() and 16 char limitation logic.

> -	break_names = info->key_size > 16 || value_size > 16;
> -	single_line = info->key_size + value_size <= 24 && !break_names;
> +	break_names = info->key_size > 16;
> +	single_line = single_line && !break_names;
>  
>  	printf("key:%c", break_names ? '\n' : ' ');
>  	fprint_hex(stdout, key, info->key_size, " ");
>  
>  	printf(single_line ? "  " : "\n");
>  
> -	printf("value:%c%s", break_names ? '\n' : ' ', value);
> +	printf("value:%c%s", single_line ? ' ' : '\n', value);
>  
>  	printf("\n");
>  }
