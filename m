Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74378C282CE
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 18:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9CC20652
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 18:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387641AbfDXSK4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:10:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41098 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388019AbfDXROM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 13:14:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id c12so20041222wrt.8;
        Wed, 24 Apr 2019 10:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eZT77CSDYSlIQJw37UITlIY7dlMgURZgZVKyDTZp4V4=;
        b=hubXPwXwlCXTW/CzmreuYmEdm/m4LhdJsBCAk7u/dqjwf+KI0EC2hnCFYTTuWfxrhV
         omk488uwtIdVhR1rHgn8FIKQG3gxK8Ebylu+tH5gjLiVHL0AHLusClfX1N7CyBKH4W47
         ra5NburdJ27cf7pQZxF1aQcitwtHkig0Wgcak/PV6gL8lc0MFPUrZPZOvhzkcQZU9Lvx
         I+QoBin0TRDEt0H8ztkONf/ge9RJS8Saka68ZuvUkhT+Ucrwvl+L6lKft6sCEgSDse6X
         55yXwrmIw8FjulFT14Q6RIlU+os+iKEYFC3Iz9HqPiyQ7ETHsY5G4QHNmjYep7rZYQz3
         9eCw==
X-Gm-Message-State: APjAAAUcvtUWYHLWzIu3gqGeZrZzk5q/C4WD6ORvGSDevN62kxKtf4kW
        OOWIoLQBMVbVgwSVuFn+2hg=
X-Google-Smtp-Source: APXvYqzaGBGvZsBHVmrBUREcprOuj+AMmWEbxhlvlHvRMvByhj7hY1nOGub3nUb2A2XqhHVUkmCwwg==
X-Received: by 2002:a5d:4d42:: with SMTP id a2mr3075809wru.130.1556126050156;
        Wed, 24 Apr 2019 10:14:10 -0700 (PDT)
Received: from Nover ([161.105.209.130])
        by smtp.gmail.com with ESMTPSA id d6sm11062171wrf.63.2019.04.24.10.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 10:14:09 -0700 (PDT)
Date:   Wed, 24 Apr 2019 19:13:56 +0200
From:   Paul Chaignon <paul.chaignon@orange.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Xiao Han <xiao.han@orange.com>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: mark registers as safe or unknown in all
 frames
Message-ID: <20190424171354.GA4827@Nover>
References: <cover.1555957346.git.paul.chaignon@orange.com>
 <d2c281e7a9a8011d5890103c15be5fdd2d2c7864.1555957346.git.paul.chaignon@orange.com>
 <6eb840f9-edd6-5bab-b824-75f35b5bca3b@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eb840f9-edd6-5bab-b824-75f35b5bca3b@iogearbox.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 23, 2019 01:47AM, Daniel Borkmann wrote:
> On 04/22/2019 08:34 PM, Paul Chaignon wrote:
> > In case of a null check on a pointer inside a subprog, we should mark all
> > registers with this pointer as either safe or unknown, in both the current
> > and previous frames.  Currently, only spilled registers and registers in
> > the current frame are marked.  This patch also marks registers in previous
> > frames.
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
> > as map_value_or_null despite the null check in subprog 1.
> > 
> > Note that this patch fixes another resulting bug when using
> > bpf_sk_release():
> > 
> > 1: sk = bpf_sk_lookup_tcp(...);
> > 2: subprog(sk) {
> > 3:   if (sk)
> > 4:     bpf_sk_release(sk);
> > 5: }
> > 6: if (!sk)
> > 7:   return 0;
> > 8: return 1;
> > 
> > In the above, mark_ptr_or_null_regs will warn on line 6 because it will
> > try to free the reference state, even though it was already freed on
> > line 3.
> > 
> > Fixes: f4d7e40a5b71 ("bpf: introduce function calls (verification)")
> > Signed-off-by: Paul Chaignon <paul.chaignon@orange.com>
> > ---
> >  kernel/bpf/verifier.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index db301e9b5295..777970d8c245 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -4876,11 +4876,11 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
> >  		 */
> >  		WARN_ON_ONCE(release_reference_state(state, id));
> >  
> > -	for (i = 0; i < MAX_BPF_REG; i++)
> > -		mark_ptr_or_null_reg(state, &regs[i], id, is_null);
> > -
> >  	for (j = 0; j <= vstate->curframe; j++) {
> >  		state = vstate->frame[j];
> > +		for (i = 0; i < MAX_BPF_REG; i++)
> > +			mark_ptr_or_null_reg(state, &state->regs[i], id,
> > +					     is_null);
> 
> Small nit: I think it would be good to follow practice from clear_all_pkt_pointers()
> and release_reg_references() to move handling of a singe frame into its own function.

Will do.

> 
> >  		bpf_for_each_spilled_reg(i, state, reg) {
> >  			if (!reg)
> >  				continue;
> > 
> 
> What about semantics in other, similar functions like find_good_pkt_pointers()?
> Should this also consider all frames instead?

Looks like the same is needed in find_good_pkt_pointers().  It's the only
similar function I could find though.  Did you have others in mind?

I'll add a second test case for the find_good_pkt_pointers() change in v3.

> 
> Thanks,
> Daniel
