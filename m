Return-Path: <SRS0=eV/F=6V=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B0CC38A24
	for <bpf@archiver.kernel.org>; Thu,  7 May 2020 12:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B900208E4
	for <bpf@archiver.kernel.org>; Thu,  7 May 2020 12:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDEpo5qz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEGMUU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 7 May 2020 08:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726792AbgEGMUT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 May 2020 08:20:19 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B1CC05BD43;
        Thu,  7 May 2020 05:20:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z8so6147627wrw.3;
        Thu, 07 May 2020 05:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=hwmbNEyOXecqf1sQXaRulabPe6vBkolg6IuHt5TdHTU=;
        b=dDEpo5qzjTDuan13RkxLtpTn8Inx853I6PSWjaaD4AX63ZsZSAq40CWM7R6utKw3zq
         Y8hfOpUoDjAFnLbepyEIOpcJgZ+d1s+5TAf4xaPcAQISdXdNqtoH0R6gXqFffw9px6vH
         26Ik3TYaDmvQJNxfpd8gxOpwRw5hHdP6m4yM7IFlcFJHlvH0rjyl2xvG1EA22S0fvzNU
         Mi+A+NC15tnf9QEDp+UbHbcKojAyHc7xEJxg5Sm49TbbX+fSMUR9TUJu4GfGcH2k1XRi
         HMlRv1sfmZqy7LjMjK3w31EEx3iCAM4/v42Y4+CfdYPqwGNyTV0m/J+Q3FFvNw9EG2CW
         ur9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=hwmbNEyOXecqf1sQXaRulabPe6vBkolg6IuHt5TdHTU=;
        b=setl7jqb4iCmXd5RKawCsrWT9D9L08oRT3eGfqODHPYwyaFFV9zZNFymVvg4orsq/6
         CZCfWCRFkKmDXodom3n2jvjTapQq1Rfk6XRYmbTjHJV9T9b0jynbnBxnwQ4w8e3x9QeS
         nFLNH2fwyyKmHkyaf4QuTPWcWceuTqqyDKvrlEgdgsjv9c42kiMEZKXW4V4oUk6V+lRT
         5B1hxntAm1VfFb8y7+BU0/WmID0DABMi0gvxgZD0aI5mimR1cynCKV12NLNITtt15msC
         1uPnLC1ALMZcaF/MQr3U0uxdpmhkU/sjkpemH7qG1KFof4W6DKjs0g927BLwgiHnJpjO
         TnWQ==
X-Gm-Message-State: AGi0PubyB2eQiWbZcgf3zuk22lZ/TdQ0Gs8c1+XfEI5Z3D3/a0YFhuA+
        5YFXnPoc7J50ZXfqewfMlpQG4VXTeoqgNilIcOLblG1Cu1bfvw==
X-Google-Smtp-Source: APiQypKS0G3RRdM+DuJDKJ4SmMErUIgMQYL9h1mPTXwYjhZjf3Ow6omNyyqG+hqlwo4cQY+F0vaWCi9mIj3hUH84+8c=
X-Received: by 2002:adf:decb:: with SMTP id i11mr15230905wrn.172.1588854017421;
 Thu, 07 May 2020 05:20:17 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Thu, 7 May 2020 14:20:06 +0200
Message-ID: <CAJ+HfNidbgwtLinLQohwocUmoYyRcAG454ggGkCbseQPSA1cpw@mail.gmail.com>
Subject: XDP bpf_tail_call_redirect(): yea or nay?
To:     bpf <bpf@vger.kernel.org>
Cc:     Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Before I start hacking on this, I might as well check with the XDP
folks if this considered a crappy idea or not. :-)

The XDP redirect flow for a packet is typical a dance of
bpf_redirect_map() that updates the bpf_redirect_info structure with
maps type/items, which is then followed by an xdp_do_redirect(). That
function takes an action based on the bpf_redirect_info content.

I'd like to get rid of the xdp_do_redirect() call, and the
bpf_redirect_info (per-cpu) lookup. The idea is to introduce a new
(oh-no!) XDP action, say, XDP_CONSUMED and a built-in helper with
tail-call semantics.

Something across the lines of:

--8<--

struct {
        __uint(type, BPF_MAP_TYPE_XSKMAP);
        __uint(max_entries, MAX_SOCKS);
        __uint(key_size, sizeof(int));
        __uint(value_size, sizeof(int));
} xsks_map SEC(".maps");

SEC("xdp1")
int xdp_prog1(struct xdp_md *ctx)
{
        bpf_tail_call_redirect(ctx, &xsks_map, 0);
        // Redirect the packet to an AF_XDP socket at entry 0 of the
        // map.
        //
        // After a successful call, ctx is said to be
        // consumed. XDP_CONSUMED will be returned by the program.
        // Note that if the call is not successful, the buffer is
        // still valid.
        //
        // XDP_CONSUMED in the driver means that the driver should not
        // issue an xdp_do_direct() call, but only xdp_flush().
        //
        // The verifier need to be taught that XDP_CONSUMED can only
        // be returned "indirectly", meaning a bpf_tail_call_XXX()
        // call. An explicit "return XDP_CONSUMED" should be
        // rejected. Can that be implemented?
        return XDP_PASS; // or any other valid action.
}

-->8--

The bpf_tail_call_redirect() would work with all redirectable maps.

Thoughts? Tomatoes? Pitchforks?


Bj=C3=B6rn
