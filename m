Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD366C10F0E
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 18:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9E320883
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 18:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="QL/sEwfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfDISky (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:40:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37382 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfDISkx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 14:40:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so10242186pfr.4
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2019 11:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RbNGt2ZJkssGV/9StlmHelzJVKPL+JsmimMIPGw+EXk=;
        b=QL/sEwfEHOhRigSPIGQf+pNSLXcO+Ow5awa/jy+D7y1BoPoigqoHAWjEemXwHMXyPa
         QXQravyW38g9IltkFqerTPHlngdMB4JGMCJ8a3yntOd9SfvTBIcRNXmdvGsgbvVHmwSw
         py1t5iSalb+TMMZOIwwK2ciMboafqMTUo7tWhuTIY5WxpyAAZKMOq8Fqj6YpWP7rA056
         LyVO6S9+hCH4Ft5quM1vXiNlyL6ZgwRFzuz/WvqbMvu24hATB2rBu89VOQhWPJHkEFLi
         pI4DODpm0/ZRzswdvxfwvjUaLFZaEObxpuxQbjCstx584rrXPzX4rh5G5AKV/mg5rRs8
         y3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RbNGt2ZJkssGV/9StlmHelzJVKPL+JsmimMIPGw+EXk=;
        b=olDfiStyXOy/Q/4hapghunBp3vPIvIBGvrUOXNpd82gwQVENNcVPp3hn3uL91VsYmR
         40JSILdEpV2O49x7HjBP2ogC92FA4kLyHa8b97iog1yLcBAsfO+c2DwYlaUZX8+/jiUA
         Hdl2nzr+VKI+T9EIWRw1CXOIci1PqgDLEVEwSiWywcq+otK31OAAeCTT0oBoD+jt4zR/
         0KSapVuyFeXQyg8AaI4MSUIaMTMNtN4wGkA/b/Hfp4+tLWD9Uuug+Xh78QQppAcvmJkm
         EiHfGq1eqxd99JrQLgx10eLc6BufBZHh6qNhTxjJbb+G2xrrXy8w8re5QGMAHa+CdBsZ
         N8Mg==
X-Gm-Message-State: APjAAAXVdzf+npDUn2BOi9P8L+65SYcuMx069LStFmnqepg/GdaY2zD7
        3fB9h+oxxWbmt5//PjNfaVW39A==
X-Google-Smtp-Source: APXvYqwi6Gy4UGIshzuxBcVtPtEZSQa6oyEZTwqZUjEI69iP+iv0xpVcvYnrKD8soXwoS1z4QCNJAg==
X-Received: by 2002:a65:408b:: with SMTP id t11mr34219438pgp.372.1554835252571;
        Tue, 09 Apr 2019 11:40:52 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id e7sm21254041pfc.132.2019.04.09.11.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 11:40:51 -0700 (PDT)
Date:   Tue, 9 Apr 2019 11:40:50 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Martin Lau <kafai@fb.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: support input __sk_buff context in
 BPF_PROG_TEST_RUN
Message-ID: <20190409184050.GM7431@mini-arch.hsd1.ca.comcast.net>
References: <20190409172739.242389-1-sdf@google.com>
 <20190409182500.ezvhvgfrcbdvhd6o@kafai-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409182500.ezvhvgfrcbdvhd6o@kafai-mbp>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/09, Martin Lau wrote:
> On Tue, Apr 09, 2019 at 10:27:37AM -0700, Stanislav Fomichev wrote:
> > Add new set of arguments to bpf_attr for BPF_PROG_TEST_RUN:
> > * ctx_in/ctx_size_in - input context
> > * ctx_out/ctx_size_out - output context
> > 
> > The intended use case is to pass some meta data to the test runs that
> > operate on skb (this has being brought up on recent LPC).
> > 
> > For programs that use bpf_prog_test_run_skb, support __sk_buff input and
> > output. Initially, from input __sk_buff, copy _only_ cb and priority into
> > skb, all other non-zero fields are prohibited (with EINVAL).
> > If the user has set ctx_out/ctx_size_out, copy the potentially modified
> > __sk_buff back to the userspace.
> > 
> > We require all fields of input __sk_buff except the ones we explicitly
> > support to be set to zero. The expectation is that in the future we might
> > add support for more fields and we want to fail explicitly if the user
> > runs the program on the kernel where we don't yet support them.
> > 
> > The API is intentionally vague (i.e. we don't explicitly add __sk_buff
> > to bpf_attr, but ctx_in) to potentially let other test_run types use
> > this interface in the future (this can be xdp_md for xdp types for
> > example).
> > 
> > v3:
> >   * handle case where ctx_in is NULL, but ctx_out is not [Martin]
> >   * convert size==0 checks to ptr==NULL checks and add some extra ptr
> >     checks [Martin]
> > 
> > v2:
> >   * Addressed comments from Martin Lau
> > 
> > Cc: Martin Lau <kafai@fb.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  include/uapi/linux/bpf.h |   7 ++
> >  kernel/bpf/syscall.c     |  10 ++-
> >  net/bpf/test_run.c       | 142 ++++++++++++++++++++++++++++++++++++---
> >  3 files changed, 150 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 837024512baf..8e96f99cebf8 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -396,6 +396,13 @@ union bpf_attr {
> >  		__aligned_u64	data_out;
> >  		__u32		repeat;
> >  		__u32		duration;
> > +		__u32		ctx_size_in;	/* input: len of ctx_in */
> > +		__u32		ctx_size_out;	/* input/output: len of ctx_out
> > +						 *   returns ENOSPC if ctx_out
> > +						 *   is too small.
> > +						 */
> > +		__aligned_u64	ctx_in;
> > +		__aligned_u64	ctx_out;
> >  	} test;
> >  
> >  	struct { /* anonymous struct used by BPF_*_GET_*_ID */
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 1d65e56594db..5bb963e8f9b0 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -1949,7 +1949,7 @@ static int bpf_prog_query(const union bpf_attr *attr,
> >  	return cgroup_bpf_prog_query(attr, uattr);
> >  }
> >  
> > -#define BPF_PROG_TEST_RUN_LAST_FIELD test.duration
> > +#define BPF_PROG_TEST_RUN_LAST_FIELD test.ctx_out
> >  
> >  static int bpf_prog_test_run(const union bpf_attr *attr,
> >  			     union bpf_attr __user *uattr)
> > @@ -1962,6 +1962,14 @@ static int bpf_prog_test_run(const union bpf_attr *attr,
> >  	if (CHECK_ATTR(BPF_PROG_TEST_RUN))
> >  		return -EINVAL;
> >  
> > +	if ((attr->test.ctx_size_in && !attr->test.ctx_in) ||
> > +	    (!attr->test.ctx_size_in && attr->test.ctx_in))
> > +		return -EINVAL;
> > +
> > +	if ((attr->test.ctx_size_out && !attr->test.ctx_out) ||
> > +	    (!attr->test.ctx_size_out && attr->test.ctx_out))
> > +		return -EINVAL;
> > +
> >  	prog = bpf_prog_get(attr->test.prog_fd);
> >  	if (IS_ERR(prog))
> >  		return PTR_ERR(prog);
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index fab142b796ef..2023d8841c6d 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -123,12 +123,125 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 size,
> >  	return data;
> >  }
> >  
> > +static void *bpf_ctx_init(const union bpf_attr *kattr, u32 max_size)
> > +{
> > +	void __user *data_in = u64_to_user_ptr(kattr->test.ctx_in);
> > +	void __user *data_out = u64_to_user_ptr(kattr->test.ctx_out);
> > +	u32 size = kattr->test.ctx_size_in;
> > +	void *data;
> > +	int err;
> > +
> > +	if (!data_in && !data_out)
> > +		return NULL;
> > +
> > +	data = kzalloc(max_size, GFP_USER);
> > +	if (!data)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	if (data_in) {
> > +		err = bpf_check_uarg_tail_zero(data_in, max_size, size);
> > +		if (err) {
> > +			kfree(data);
> > +			return ERR_PTR(err);
> > +		}
> > +
> > +		if (copy_from_user(data, data_in, size)) {
> A min_t is needed:
> 		size = min_t(u32, max_size, size);
> 		if (copy_from_user(data, data_in, size)) {
Ah, sorry about that, good catch! Will respin shortly.

> Others lgtm,
> 
> Acked-by: Martin KaFai Lau <kafai@fb.com>
Thank you for a review!

> > +			kfree(data);
> > +			return ERR_PTR(-EFAULT);
> > +		}
> > +	}
> > +	return data;
> > +}
