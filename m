Return-Path: <SRS0=xnNa=S5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5526DC43219
	for <bpf@archiver.kernel.org>; Sat, 27 Apr 2019 03:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BF1206BF
	for <bpf@archiver.kernel.org>; Sat, 27 Apr 2019 03:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRSMbNSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfD0DL1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 23:11:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35246 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfD0DL1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Apr 2019 23:11:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so2421775plp.2;
        Fri, 26 Apr 2019 20:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hMRUnVsUcOhyMi8v6YKpNwjZxe1Fh5QfPWGrUy8geXc=;
        b=MRSMbNSo2+GKIhJZDOksjbdsK4ViDVddKpPoe+nNkOGd2Krsa8dyvYhSK6PgE500qH
         lmW1jdJKN7FUmbYaD8VjBCRaApgXrAaHhVyM/7UOPbiRCXnJhc5k4TDNN/EetJ+DrGc2
         l+JixZm/IewSTB0zX0fCo6s/RNwptACUfD1dARcMqqEEP2MndYw8XDpDKOC3mutKp1ZT
         FsrCLAySUDM8CHL3eiazsOxK5hR5KeloX2cNDnUT6bweGZOb9jhoN1SLvLdIziYtykHO
         v1/01BrJNdoA+0EL6gKcFt9hd2HYnKJ3CIdTIx/qDo0lm3auixddtTV6EBnbb8N1Lp65
         Wp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hMRUnVsUcOhyMi8v6YKpNwjZxe1Fh5QfPWGrUy8geXc=;
        b=Ds3udL16w3cX/tkcfZKWWlaCl9dFHmc/QtB+6iHsYvkn0mndk0iuToxYGL+0Q2gHIV
         jm9bbL/BliveOgwhbPCsZBd6WQzoVxqQv6c1kK71G1p1bTCuY4Box8TffHEKORAX6ykj
         A2NjlRSx7byn7W7AfOKpko+puXgZtIjFT7cZaBuUrTiPp09C5y2I2aWk13pRx8eJt7n9
         oJ+mXNCTnlCBOz4xQFgaIcuSOGMiUqskY6rEkRah8FtFk92UDRxhOpSAZmbkh1g79sjl
         lQyxassSJ9cEuJnn9Ul3pewAALfyfAUoUkHb85VMVCJ9Fg3lLsGRr7JzIc51jAtpJ1l8
         7Y6A==
X-Gm-Message-State: APjAAAWUqE6wr1z6aeI+YWgsnqAy0Vf2a79AX6Uas9i9Xb8Vj2kpOk8H
        ROOVAd0RieYE2A6qPT1jYfflX01x
X-Google-Smtp-Source: APXvYqyFOyoz8+ubnwnYlfgeBTF2G3TN7tPH2pJzzh1SL85gKoxMvx3TwV1pAuHkq8ec0yTt+c/2gA==
X-Received: by 2002:a17:902:e48b:: with SMTP id cj11mr7179874plb.223.1556334686628;
        Fri, 26 Apr 2019 20:11:26 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::3b7e])
        by smtp.gmail.com with ESMTPSA id y23sm39242112pfn.25.2019.04.26.20.11.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 20:11:25 -0700 (PDT)
Date:   Fri, 26 Apr 2019 20:11:23 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Edward Cree <ecree@solarflare.com>
Cc:     Jiong Wang <jiong.wang@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>
Subject: Re: 32-bit zext time complexity (Was Re: [PATCH bpf-next]
 selftests/bpf: two scale tests)
Message-ID: <20190427031122.dgnt4y4v6rnbawq2@ast-mbp>
References: <20190412214132.2726285-1-ast@kernel.org>
 <lyimv3hujp.fsf@netronome.com>
 <20190425043347.pxrz5ln4m7khebt6@ast-mbp.dhcp.thefacebook.com>
 <lylfzyeebr.fsf@netronome.com>
 <20190425221021.ov2jj4piann7wmid@ast-mbp.dhcp.thefacebook.com>
 <lyk1fgrk4m.fsf@netronome.com>
 <6757534d-4d0d-6698-7536-118fed7be977@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6757534d-4d0d-6698-7536-118fed7be977@solarflare.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 26, 2019 at 03:50:33PM +0100, Edward Cree wrote:
> On 26/04/2019 14:06, Jiong Wang wrote:
> > Alexei Starovoitov writes:
> >> Note that bpf_patch_insn_single() is calling bpf_adj_branches() twice too.
> >> And dead_code + convert_ctx + fixup_bpf_calls are calling
> >> bpf_patch_insn_single() a lot.
> >> How about before dead_code pass we convert the program into basic-block
> >> format, patch it all, and then convert from bb back to offsets.
> >> Patching will become very cheap, since no loop over program will be
> >> necessary. A jump from bb-N to bb-M will stay as-is regardless
> >> of amount of patching was done inside each bb.
> >> The loops inside these patching passes will be converted from:
> >> for (i = 0; i < insn_cnt; i++, insn++)
> >> into:
> >> for each bb
> >>   for each insn in bb
> > Interesting. If I am understanding correctly, BB then needs to support
> > dynamic insn buffer resize. And after all insn patching finished, all BBs
> > are finalized, we then linearized BBs (in a best order) to generate the
> > final bpf image.
> Does any verifier metadata ever take the index of an insn that was added by
>  patching?  If not, then we could have, instead of an array of insns, an
>  array of list_heads, each of which is a list of insns (plus aux data etc.).
> At entry the original program is converted into an array of 1-element lists.
> On patching we edit the list, which doesn't change the index of any insn.
> Then after all insn patching finishes, we linearise as above.

Interesting idea. It can be optimized further:
instead of converting all insns into lists of 1 before all patching
it can be done on demand:
convert from insn to list only when patching is needed.
Patched insn becomes a pointer to a block of new insns.
We have reserved opcodes to recognize such situation.
The question is how to linearise it once at the end?

