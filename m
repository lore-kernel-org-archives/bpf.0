Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFC5C43219
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 20:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7213520717
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 20:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hi3UkVlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbfDYUqH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:46:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46621 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387769AbfDYUqH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 16:46:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so409182pgg.13;
        Thu, 25 Apr 2019 13:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cvn6Z3hqfahrf+vptDtU4UL+kpEKp7HX8ytTb4mmj7Y=;
        b=hi3UkVlhuTNDYLmBUQaKWywzdKrMkp2U4z6k5oADc5T+b5jUvbfP+7ngCeThkqZYec
         317SxHEabUsQqAzyFCpCRXxO0CcH4Xnd3wUcKkRTDhDSslhxyyT5Q0KloKThDBCidOeu
         86AKsSPAxuEYcyUPHTwMiEHOc70z1OYLKDYPyP0c+zcAEWsOphKpuxXTEpv4/n9b4nMh
         u4NXREJSX/TcXNlsvjPo81x/rg8q877cqLlXWWft6nttdGIkF8CKr2pF/Qhn+0ljjuyI
         wFloZO6ouk8wqkTpZQC84uH14D8aFtdN4V7f1TzEIAMyL01WE9FsttY82AtIexlfpnEy
         0iLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cvn6Z3hqfahrf+vptDtU4UL+kpEKp7HX8ytTb4mmj7Y=;
        b=GCM0QxNS+clpCsN2golMNmwKWSx9wHUv+cCTHQMsasnTqCatqKDC48azpYHGtP5Wnv
         UEPWe6WHnCCu8nOCpvfto+iZgvPBPwLbSu7QEomTHo9RZrtDfspN23ZssnLSz2oiXntd
         5xrz/MIEjYX27m0CS0CdXERVVWKS8MWxDuh6CWQqlSDkNrT2B2UYFelYwkIQjKD+7jTa
         Tiwo5O5Y5NTiQcUEUndcK1g4XZj5E0gGhrVy917o6hAO2YKdZhU41Vd9zEVFeBj2zciN
         Mag7B7Bvp6Ns0b47jhZCipJqx/r9RXjEhAPPbqXFP50rm5CR+C7bIN7Nt9wXwvammbD/
         7foA==
X-Gm-Message-State: APjAAAWNG1K1fKfaAESD9PFbbig2PbKUVy7LF24t4jR/GB95TXoCqp7h
        Zr+rXk5KhZkA5QEygKOTU+Q3YKKu
X-Google-Smtp-Source: APXvYqyz0egNsnuecNgEVZ0xRrmRgHvbhCwGrNn8KIBuq3KaeBd+hxhLpnxs6qvKAf350z3UlFAsKQ==
X-Received: by 2002:a63:5059:: with SMTP id q25mr32678040pgl.314.1556225166694;
        Thu, 25 Apr 2019 13:46:06 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::3cda])
        by smtp.gmail.com with ESMTPSA id e21sm5685365pgg.90.2019.04.25.13.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 13:46:05 -0700 (PDT)
Date:   Thu, 25 Apr 2019 13:46:03 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Paul Chaignon <paul.chaignon@orange.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Xiao Han <xiao.han@orange.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf v3 0/2] bpf: mark registers in all frames after
 pkt/null checks
Message-ID: <20190425204601.wbymvydzahiti4id@ast-mbp.dhcp.thefacebook.com>
References: <cover.1556127905.git.paul.chaignon@orange.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556127905.git.paul.chaignon@orange.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 24, 2019 at 09:49:58PM +0200, Paul Chaignon wrote:
> In case of a null check on a pointer inside a subprog, we should mark all
> registers with this pointer as either safe or unknown, in both the current
> and previous frames.  Currently, only spilled registers and registers in
> the current frame are marked.  Packet bound checks in subprogs have the
> same issue.  The first patch fixes it to mark registers in previous frames
> as well.
> 
> A good reproducer for null checks looks as follow:
> 
> 1: ptr = bpf_map_lookup_elem(map, &key);
> 2: ret = subprog(ptr) {
> 3:   return ptr != NULL;
> 4: }
> 5: if (ret)
> 6:   value = *ptr;
> 
> With the above, the verifier will complain on line 6 because it sees ptr
> as map_value_or_null despite the null check in subprog 1.  The second
> patch implements the above as a new test case.
> 
> Note that this patch fixes another resulting bug when using
> bpf_sk_release():
> 
> 1: sk = bpf_sk_lookup_tcp(...);
> 2: subprog(sk) {
> 3:   if (sk)
> 4:     bpf_sk_release(sk);
> 5: }
> 6: if (!sk)
> 7:   return 0;
> 8: return 1;
> 
> In the above, mark_ptr_or_null_regs will warn on line 6 because it will
> try to free the reference state, even though it was already freed on
> line 3.
> 
> Changelogs:
>   Changes in v3:
>     - Fix same issue in find_good_pkt_pointers().
>     - Add test case for find_good_pkt_pointers() issue.
>     - Change title to account for the above change. Old title was
>       "bpf: mark registers as safe or unknown in all frames".
>     - Refactor find_good_pkt_pointers and mark_ptr_or_null_regs.
>     - I did not keep Yonghong's ack because of the above changes.
>   Changes in v2:
>     - Fix example codes in commit message.

Applied to bpf tree, thanks!

