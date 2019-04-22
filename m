Return-Path: <SRS0=ACyN=SY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21A8C10F11
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 18:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EFA20896
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 18:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfDVSa1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Apr 2019 14:30:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41989 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDVSa1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Apr 2019 14:30:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so16772244wrx.9;
        Mon, 22 Apr 2019 11:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pC9DVWQMvWjvBqSkDXDa2nCNWZxPxTnQNeKyf6dSEh8=;
        b=MO9cMIt1Zd2r4yMePxHgJAZbHvODfZ+ZY3uEaCxdTn5UooM3BzRvZglAOt8W6+Avne
         2Rtq8DSCTvYz6LtE8mqvLbYGNktHOCpQ6upYblyOzImuR/taQcuIbxHCpei6XD9MsU61
         rzXVoGe9f2I3NUoinG3ygPrwhrPVz4y7zR7KKr7F6UznRA/3cyiV7Mb4iYJpvvWbO/oC
         EWPXTRDIl3Y6T9LDmYidaSIhq6A1c2uu0FaMAVs22zO7LTr++CjHrCpnsJZsnNzJPtDk
         ScgKrZionE4gOtp6YeJ+vuA8cRFaaAAYh5uibrLIRR9fOpXcYUtDYAFDwFOL+1Kzx5Lc
         7ssg==
X-Gm-Message-State: APjAAAVF12Aa3mtBoBl5+1N7c6mXPgBGYg/OsxLqGnp+mg9FHQnhy7z2
        Lws8ZcyZLs8Xt6O7aLj7uJ8=
X-Google-Smtp-Source: APXvYqyuSWlCiWFAglw7VGwmLTC0RQR/ywvaBk42/1Xsd7UpD38W4li1d34LZJnEmOrZSBXBsJeZDg==
X-Received: by 2002:adf:e28d:: with SMTP id v13mr658541wri.280.1555957825091;
        Mon, 22 Apr 2019 11:30:25 -0700 (PDT)
Received: from Nover ([161.105.209.130])
        by smtp.gmail.com with ESMTPSA id m13sm13913183wmg.42.2019.04.22.11.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 11:30:24 -0700 (PDT)
Date:   Mon, 22 Apr 2019 20:30:15 +0200
From:   Paul Chaignon <paul.chaignon@orange.com>
To:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Xiao Han <xiao.han@orange.com>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH bpf 0/2] bpf: mark registers as safe or unknown in all
 frames
Message-ID: <20190422183014.GA12006@Nover>
References: <cover.1555761008.git.paul.chaignon@orange.com>
 <83ac6441-526c-94bd-c818-3316809f25c3@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83ac6441-526c-94bd-c818-3316809f25c3@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 22, 2019 04:57PM, Yonghong Song wrote: 
> On 4/20/19 5:38 AM, Paul Chaignon wrote:
> > In case of a null check on a pointer inside a subprog, we should mark all
> > registers with this pointer as either safe or unknown, in both the current
> > and previous frames.  Currently, only spilled registers and registers in
> > the current frame are marked.  This first patch also marks registers in
> > previous frames.
> > 
> > A good reproducer looks as follow:
> > 
> > 1: ptr = bpf_map_lookup_elem(map, &key);
> > 2: ret = subprog(ptr) {
> > 3:   return ptr != NULL;
> > 4: }
> > 5: if (ret)
> > 6:   value = *ptr;
> > 
> > With the above, the verifier will complain on line 6 because it sees ptr
> > as map_value_or_null despite the null check in subprog 1.  The second
> > patch implements the above as a new test case.
> > 
> > Note that this patch fixes another resulting bug when using
> > bpf_sk_release():
> > 
> > 1: sk = bpf_sk_lookup_tcp();
> > 2: subprog(sk) {
> > 3:   if (sk)
> > 4:     bpf_sk_release(sk, 0);
> 
> The specification for bpf_sk_release() in uapi/linux/bpf.h is:
>   int bpf_sk_release(struct bpf_sock *sock)
> 
> Do you explain what is bpf_sk_release(sk, 0)?

Thanks for the review Yonghong.  I think I took this extra argument by
mistake from the description of the commit introducing bpf_sk_release
(6acc9b432 ("bpf: Add helper to retrieve socket in BPF")).  I'll send a v2
with a fixed commit message.  Of course, the helper on line 1 also takes
arguments, so it might be better to write it as bpf_sk_lookup_tcp(...).

> 
> > 5: }
> > 6: if (!sk)
> > 7:   return 0;
> > 8: return sk;
> 
> If sk has been released, the program should not really return sk, right?

I'll change in v2.  I don't think it matters to reproduce the warning
though.  The verifier won't complain as the return value won't be
dereferenced and the register holding sk is readable.

> 
> > 
> > In the above, mark_ptr_or_null_regs will warn on line 6 because it will
> > try to free the reference state, even though it was already freed on
> > line 3.
> > 
> > Paul Chaignon (2):
> >    bpf: mark registers as safe or unknown in all frames
> >    selftests/bpf: test case for pointer null check in subprog
> > 
> >   kernel/bpf/verifier.c                        |  6 ++---
> >   tools/testing/selftests/bpf/verifier/calls.c | 25 ++++++++++++++++++++
> >   2 files changed, 28 insertions(+), 3 deletions(-)
> > 
