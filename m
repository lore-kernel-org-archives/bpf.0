Return-Path: <SRS0=Rhtb=SI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAA9C282CE
	for <bpf@archiver.kernel.org>; Sat,  6 Apr 2019 01:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5BD2146F
	for <bpf@archiver.kernel.org>; Sat,  6 Apr 2019 01:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lezRaI4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfDFB41 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 5 Apr 2019 21:56:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34502 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfDFB40 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Apr 2019 21:56:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so4236775pfd.1;
        Fri, 05 Apr 2019 18:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HuTifu+DzLJLZ1sqf4f961WZhFuy2LPUTW36R7yvYG4=;
        b=lezRaI4BFIfu37wd/K3NN3DKweSnhhTgZf3GcBhLtd3wFZejiN0Ex+ePq7Er1pESMm
         lJxuyaGWXodScftLurxQoGvdROqfZAT/t5c9/Gxu1gDjbL+AQQj8tLjV+tc4eiOPrdBL
         uu44/uOfSgQWW121Hm1RdZN7f5QlH51FUCHDMdmZVGsFSAiudHy748ajvpSZBeAYogvo
         nYpxh4oAFPMuxwr+7yV+G9RUmN0qw/Du1pq14NC5wQRqN9k4/Jx9ytixrdbcpYt1A15E
         IeGQ3zsr1CnQEixsY4fODZUpT/oSgES8I9pp6TH6Oz9lNa/djgOmShZgmRP8EF6bzpK/
         GMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HuTifu+DzLJLZ1sqf4f961WZhFuy2LPUTW36R7yvYG4=;
        b=UpVBl+prDnxuzplsTFuZuMrD2yG2hbLHnEZ11vPMxIU4WE0skxfZK1J42dG/+3MXwW
         KZNxB9SOWrXaSMUYBcL8vXsM2vB0O7g7PlYnCHw+BVUHxEiWmFuid+oeGjRvwl39SH9X
         qyWh9WpGOre6SRaGw1PMtdOaNbmyrXpiZIqmwoIaBP3xXmIf6wPwm01308uInezTlIkZ
         skz64rS1BgxOtj6E3hrPd90o47gkEbiRQtnkARSGx1u9YEG7V7CRNloHCFdbyxH2zqC5
         +ajXLfZEQZSHSrabaDG6nJrWxfsJZaVrEzhqxN1RSxI+kGQ5hUonnRrhEZuUsR/wIqnJ
         C6zg==
X-Gm-Message-State: APjAAAXMfBk3OGZz+pP0xKVUb7YwWuB+jonZt3tQrZVPsshhpOYYeSNE
        mnCqWVEy2Xn5/1wY63YZAwM=
X-Google-Smtp-Source: APXvYqxxDwYTBzvuUQOVlYBJxoiYJIGaatECw0UB9NgotjUmSJabVfd976cg5Aqf8P7At7pUgfR1/A==
X-Received: by 2002:a65:4343:: with SMTP id k3mr15239995pgq.384.1554515785851;
        Fri, 05 Apr 2019 18:56:25 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::6bee])
        by smtp.gmail.com with ESMTPSA id s4sm26202870pgp.89.2019.04.05.18.56.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 18:56:25 -0700 (PDT)
Date:   Fri, 5 Apr 2019 18:56:23 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
        joe@wand.net.nz, yhs@fb.com, andrii.nakryiko@gmail.com,
        kafai@fb.com
Subject: Re: [PATCH bpf-next v4 01/16] bpf: implement lookup-free direct
 value access for maps
Message-ID: <20190406015621.4yrcolqkweg3c2xy@ast-mbp.dhcp.thefacebook.com>
References: <cover.1554497408.git.daniel@iogearbox.net>
 <777f5dda5ef99c1a1cb30dec46f64c1bc814552e.1554497408.git.daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <777f5dda5ef99c1a1cb30dec46f64c1bc814552e.1554497408.git.daniel@iogearbox.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 05, 2019 at 10:59:27PM +0200, Daniel Borkmann wrote:
>  
> -/* when bpf_ldimm64->src_reg == BPF_PSEUDO_MAP_FD, bpf_ldimm64->imm == fd */
> +/* When BPF ldimm64's insn[0].src_reg != 0 then this can have
> + * two extensions:
> + *
> + * insn[0].src_reg:  BPF_PSEUDO_MAP_FD   BPF_PSEUDO_MAP_VALUE
> + * insn[0].imm:      map fd              map fd
> + * insn[1].imm:      0                   offset into value
> + * insn[0].off:      0                   lower 16 bit of map index
> + * insn[1].off:      0                   higher 16 bit of map index
> + * ldimm64 rewrite:  address of map      address of map[index]+offset
> + * verifier type:    CONST_PTR_TO_MAP    PTR_TO_MAP_VALUE
...
> +	else if (insn->src_reg == BPF_PSEUDO_MAP_VALUE)
> +		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
> +			 "map[id:%u][%u]+%u", insn->imm,
> +			 ((__u32)(__u16)insn[0].off) |
> +			 ((__u32)(__u16)insn[1].off) << 16,
> +			 (insn + 1)->imm);

Hopefully one last nit...
Do we really need to allow this odd split index support?
Later patches enforce array of 1 element and libbpf only uses that.
This index feature feels too quirky and not really useful at this moment.
Can we enforce that insn[0|1].off == 0 instead ?
Later we can extend it to mean index without breaking anything.

