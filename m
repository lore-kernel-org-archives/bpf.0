Return-Path: <SRS0=ErZJ=SV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DFFC282E0
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 21:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311AF21736
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 21:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="DdepZrJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfDSVdQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:33:16 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34943 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfDSVdP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Apr 2019 17:33:15 -0400
Received: by mail-qt1-f196.google.com with SMTP id h39so6697593qte.2
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2019 14:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=ZpQBvk7zCNUFbvz2C+GE7Q0Mns/KASImiLm7Gow9pps=;
        b=DdepZrJpfPvyPfKdOKa2vGSmqcIIS/2U7nQC7r150wf6w7p0xaYqIRQH7ix9Xz+KHo
         wyXgARKb79bD7uQrj9Sw5AeKUAgmYoN43CnYmINd0v8nLTzux925StP5AAdb2LBkoJ9+
         fjuAvmOvSSYKM2lQtUNFl4Xkgv0QLWEle7BMz/9LlKoHTYy8e7Bo9A3EO5JrZM59A9GT
         /VKIdyydtjPZjFOK8TLi0PQvhivVp9Za8x92g18X5uC90uMixHOwYzXgVzH25zSYbHlM
         fQxetJ3WYSNs5R5iQ6pSxtd5BWuQ/5jahRq/cSGzfke8rGLGg5uv5A0WMEi3G5yj+Ooz
         5Gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ZpQBvk7zCNUFbvz2C+GE7Q0Mns/KASImiLm7Gow9pps=;
        b=gm2d1DU6zBziiWkoT0IJRpTi61KJHmycAoUzSj8x40FzohWVHQbZqqBZXa779jG8Jo
         FRu7XxKSA87Y5Fj8U6AulHAZu1yL6vFKYcqhf5OYbkcMhXU1dXawnLbhmBEhnzsduJxz
         EJxm8a49YFZv0230HhAK3jERMlDeY4SMWgvergmMpcX5YBIGRfhTlKdrVlmud6KAkPeu
         p2R5xzYNVv1+g9TfmOawzxpAdtV2dTeVuXj6qbVyR+29u7J/U7PJMT0BKqHmBzBQRZuS
         qlCcXXb7NxDfrCE5hmrkOYZYYdULb1V+wVQV7Axs2gmnNXKwPapNZg5OaOfhM+f4SDKx
         GAPg==
X-Gm-Message-State: APjAAAUPSWTpUYsBUIpxl2cpeqet+OObNg2XDheHcuhyQFFXhZrPTnF9
        TSUYdFmwX6RZ32CZlgYGngRyymQal7A=
X-Google-Smtp-Source: APXvYqyEFKHwim6CfT6O8iP/RmjEjdj0bjbM8IV0oHS8V3KgWWY0mvJqih5pe+cJ4PD1Z3DYtU2oBA==
X-Received: by 2002:a0c:afb0:: with SMTP id s45mr5076253qvc.151.1555709594817;
        Fri, 19 Apr 2019 14:33:14 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id e128sm3159780qkd.79.2019.04.19.14.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 14:33:14 -0700 (PDT)
Date:   Fri, 19 Apr 2019 14:33:10 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiong Wang <jiong.wang@netronome.com>, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH v4 bpf-next 02/15] bpf: mark lo32 writes that should be
 zero extended into hi32
Message-ID: <20190419143310.6c749160@cakuba.netronome.com>
In-Reply-To: <20190419211403.6iovh26bu6cg2x36@ast-mbp.dhcp.thefacebook.com>
References: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
        <1555349185-12508-3-git-send-email-jiong.wang@netronome.com>
        <20190418235747.jv4yocuf6fgwahli@ast-mbp.dhcp.thefacebook.com>
        <20190419134051.71eeea08@cakuba.netronome.com>
        <20190419211403.6iovh26bu6cg2x36@ast-mbp.dhcp.thefacebook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 19 Apr 2019 14:14:05 -0700, Alexei Starovoitov wrote:
> > This reminds me, I'm not entirely clear on the need to propagate the
> > zext through stack slots...  Pointers are guaranteed to be 64bit, we
> > don't save parentage on scalars (AFAICT),  
> 
> scalars have parentage chain too.
> we don't track them precisely when they're spilled to stack.
> That actually caused an issue recently when valid program was rejected,
> so we might add a feature to track full contents of scalars in the stack.

Interesting..

> > why not pass REG_LIVE_READ
> > or READ64 to mark_reg_read() from stack_read?  
> 
> can we agree on only two states first ? ;)

Yess, the LIVE_READ was thought to be more of a mask for those accesses
that only care about "any read" being set, to be honest.  As you said
read64 is a strict superset of read32.  Keeping the name REG_LIVE_READ,
rather than REG_LIVE_READ_ANY or _MASK let us leave some of the
existing code untouched.

Jiong's original idea was to add a read32, and have read mean read64.

I think you said we should have read32 and read64 flags, but clear
read32 once read64 gets set?  SGTM!
