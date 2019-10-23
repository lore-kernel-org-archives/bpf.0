Return-Path: <SRS0=hlnV=YQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF890CA9EB7
	for <bpf@archiver.kernel.org>; Wed, 23 Oct 2019 17:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14BE205ED
	for <bpf@archiver.kernel.org>; Wed, 23 Oct 2019 17:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhqkF6yp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfJWRQ4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:16:56 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46367 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfJWRQ4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Oct 2019 13:16:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so16714420lfc.13;
        Wed, 23 Oct 2019 10:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tAGIDyCvzaUQiVW8HnOQRjnGR59uwSAgLSNMCVSn8UA=;
        b=OhqkF6ypLpu3utPjOksqLUFkKqpf4D4fHwkkzrgBapLXEE7lY2EPN9UKtf7xErw7gh
         AcDbrAZ1z0y3wK3qMU1mNl4StouFrKZKmENJg662lKdGefiPyrjJf6aL3Qj7kHwgK8QX
         N0O1dURxeG1BrCZRdq42g1qV4HansrRBxQ1tgeNidcL7ukfspWAMfdvKfLzx2Ezv11df
         cHw/bIJyDEWvF9HZVwXJWcD0Qq92ICJ7FuiFrSIpp/9dtX+4hRqlSBGoQjbXpoCIMvHO
         WBBHLXhMVB+MqlC9QheCiNzdO9Dw3ipJTcbQH0fuCd63QsaHu4AgNPBNeQ7KzBpT5Cbj
         0jSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tAGIDyCvzaUQiVW8HnOQRjnGR59uwSAgLSNMCVSn8UA=;
        b=eoOyI9L/VnsFI3U0MUzI6PSXzHT/L1PFc42c9VT9FVRvl9FsDQi87b/rWWfPgPVIf+
         e31U1epG3lwygxWapLu7UCLhueP7MZvS0cwF58uBGTkCUwCZjVE8vt0gnZXqwrMtIouK
         H69hznnvbiJxSm9d679Anuofo9cH2/HquwF7uvottEDk4ZWb5aTj3UEhSNEjfMA4+fKW
         3xvLm7aJwtKdV6pmxEKrw2E4U43WsHXQY/DISabWhgD//90GquJyvRC+tP0hnr2zLCtS
         3TmhNNM7aVX/eQPK5NA/RTWGb1vqkyq8W58jjAzucPe9aqzK+qCCzEAjDwL7ysyrq0k6
         eIuA==
X-Gm-Message-State: APjAAAV/8WT/plpIN0eFn7p/Lb/IiR52MZmozHR2rmi+THfTogNoLUn4
        ZKpURgk3TxJcYa3QtK1MAxFtOLk8aaNniA3mKGQM1Q==
X-Google-Smtp-Source: APXvYqxt9kVx137WpFNyjdPBSpbAvxLxgBQI6+1rNHuGkIzw/VVLqUL4s20zRvafvbkA7l9FO5mRcMyX440b2H20+YM=
X-Received: by 2002:a19:ac48:: with SMTP id r8mr8077941lfc.181.1571851014154;
 Wed, 23 Oct 2019 10:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <1571648224-16889-1-git-send-email-magnus.karlsson@intel.com>
In-Reply-To: <1571648224-16889-1-git-send-email-magnus.karlsson@intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 23 Oct 2019 10:16:42 -0700
Message-ID: <CAADnVQKMJX1eADxgK8ixmUd7XFKOOjdhbCybFcLCLEaUXUSuAw@mail.gmail.com>
Subject: Re: [PATCH bpf v3] xsk: improve documentation for AF_XDP
To:     Magnus Karlsson <magnus.karlsson@intel.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 21, 2019 at 1:57 AM Magnus Karlsson
<magnus.karlsson@intel.com> wrote:
>
> Added sections on all the bind flags, libbpf, all the setsockopts and
> all the getsockopts. Also updated the document to reflect the latest
> features and to correct some spelling errors.
>
> v1 -> v2:
> * Updated XDP program with latest BTF map format
> * Added one more FAQ entry
> * Some minor edits and corrections
>
> v2 -> v3:
> * Simplified XDP_SHARED_UMEM example XDP program
>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
..
> +   struct xdp_statistics {
> +         __u64 rx_dropped; /* Dropped for reasons other than invalid desc */
> +         __u64 rx_invalid_descs; /* Dropped due to invalid descriptor */
> +         __u64 tx_invalid_descs; /* Dropped due to invalid descriptor */
> +   };

there was small space/tab damage in the above.
I fixed it up and applied to bpf-next.
Sounds like there could be tweaks to this doc in this release cycle
when you follow up with btf and libbpf additions.
