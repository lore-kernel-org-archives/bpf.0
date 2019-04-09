Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5460EC10F0E
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 16:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCED2084F
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 16:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="uUWsqafH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfDIQIP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:08:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45359 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfDIQIP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 12:08:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id bf11so9650134plb.12
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2019 09:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9yYOKpGYJxUmWY3fvEnKFBL3CqlUbnhDg12Aht+nENY=;
        b=uUWsqafHw1NuNWJze2HFfffkaa4NdiRdpOMLoISPvvQBMksQgssoGRyaJoLt9g5Qxe
         S34fGJao/awuXH8aaGuJHSzuXgEa1JY106v72tp94GfCv8FsWUWDdEwW+8R8DbPt5aH9
         RAGLz+2Nd6IJ8s2+zJCelJW8So6OvHzitsGZVNmfQoogNxSFhSif2d8riW8HtCTsW08V
         BLJQkJfzItudsURXwMWkeUMvVVH/439bez61NO4paoMYFRDpQc+RZk6cAwGczCBaNAkt
         mBoaa80lqbfTmV+13VxxXOkWm46Q6+pH6XYNmZ/snZqfyTVMURMRBqCFoMEuA+mPITgJ
         h4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9yYOKpGYJxUmWY3fvEnKFBL3CqlUbnhDg12Aht+nENY=;
        b=eHqeH6mX/4sNrEH7sg2M+1QSC6yJ/dTB7Kh56g55U/qBAJl84G8ay+3qcgq7iyMDj/
         4QFdgVwHwwvNdjsy+/yOFZ9z7eTBW3OMhsc3paWxhhYTS7ZH9GskIU2jGSdlVFjFNrSr
         8i9bqlKRGKJIOKtNFFBQ6Lk/+GgWgWVQsQjvcgSNu7GpiBD7kEnEp5ptMwC5lCcQQobx
         M0Xw1yaZWx9dpbq8bK/fVUbrZp29Fa4HLmoTXDARP6owDLgOAsdk0GEywczEvkBR37kz
         bXwCCkYB/yh0soeoB6XdleH99K8wPyvwt1shWX/LzwpY3IADSyKTz3JI/CYtwL3NhV2q
         b03Q==
X-Gm-Message-State: APjAAAXDXMDR42haqZNqq32J053ixMC2LP9hO6Hz4s1+s+UtIFx8Mb2O
        RvJO/TMQOiOxSnL9oFauqS+sbg==
X-Google-Smtp-Source: APXvYqxL8ZOevauwSNMkYvimUUkEbv2nozAvx7qWAtX3aqD1/hylcOiWZnzooHBoUELGykMwTmZLDA==
X-Received: by 2002:a17:902:1e2:: with SMTP id b89mr38435208plb.278.1554826094343;
        Tue, 09 Apr 2019 09:08:14 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id b7sm98609461pfj.67.2019.04.09.09.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 09:08:13 -0700 (PDT)
Date:   Tue, 9 Apr 2019 09:08:12 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Martin Lau <kafai@fb.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: support input __sk_buff context in
 BPF_PROG_TEST_RUN
Message-ID: <20190409160812.GL7431@mini-arch.hsd1.ca.comcast.net>
References: <20190408160432.151478-1-sdf@google.com>
 <20190409052715.fwd3wmabo6yssjgv@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409052715.fwd3wmabo6yssjgv@kafai-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/09, Martin Lau wrote:
> On Mon, Apr 08, 2019 at 09:04:30AM -0700, Stanislav Fomichev wrote:
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
> > v2:
> >   * Addressed comments from Martin Lau
> > 
> > Cc: Martin Lau <kafai@fb.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  include/uapi/linux/bpf.h |   7 ++
> >  kernel/bpf/syscall.c     |  10 ++-
> >  net/bpf/test_run.c       | 135 ++++++++++++++++++++++++++++++++++++---
> >  3 files changed, 143 insertions(+), 9 deletions(-)
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
> > index fab142b796ef..3c6e3855c886 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -123,12 +123,118 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 size,
> >  	return data;
> >  }
> >  
> > +static void *bpf_ctx_init(const union bpf_attr *kattr, u32 max_size)
> > +{
> > +	void __user *data_in = u64_to_user_ptr(kattr->test.ctx_in);
> > +	u32 size = kattr->test.ctx_size_in;
> > +	void *data;
> > +
> > +	if (!size)
> > +		return NULL;
> A note for a later comment in bpf_prog_test_run_skb().
> This function may return NULL.
> 
> > +
> > +	if (size > max_size)
> If should be fine if the kernel unsupported bytes are zeros
> (i.e. tailing zeros in data_in).
> Please refer to the existing bpf_check_uarg_tail_zero() usages
> or also CHECK_ATTR() in syscall.c. Something like this if
> bpf_check_uarg_tail_zero() is used,
> 
> 	err = bpf_check_uarg_tail_zero(data_in, max_size, size));
> 	if (err)
> 		return ERR_PTR(err);
> 
Nice! Will use that instead.

> > +		return ERR_PTR(-E2BIG);
> > +
> > +	data = kzalloc(max_size, GFP_USER);
> > +	if (!data)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	if (copy_from_user(data, data_in, size)) {
> > +		kfree(data);
> > +		return ERR_PTR(-EFAULT);
> > +	}
> > +	return data;
> > +}
> > +
> > +static int bpf_ctx_finish(const union bpf_attr *kattr,
> > +			  union bpf_attr __user *uattr, const void *data,
> > +			  u32 size)
> > +{
> > +	void __user *data_out = u64_to_user_ptr(kattr->test.ctx_out);
> > +	int err = -EFAULT;
> > +	u32 copy_size = size;
> > +
> data is not checked for NULL here.
I do check kattr->test.ctx_size_out on the next line. And I've added
checks to the syscall.c that make sure that ctx_size_out and ctx_out
are consistent (i.e. if ctx_size_out is 0, ctx_out is NULL).

Let me instead check kattr->test.ctx_out, that should be more clear.

> > +	if (!kattr->test.ctx_size_out)
> > +		return 0;
> > +
> > +	if (copy_size > kattr->test.ctx_size_out) {
> > +		copy_size = kattr->test.ctx_size_out;
> > +		err = -ENOSPC;
> > +	}
> > +
> > +	if (copy_to_user(data_out, data, copy_size))
> > +		goto out;
> > +	if (copy_to_user(&uattr->test.ctx_size_out, &size, sizeof(size)))
> > +		goto out;
> > +	if (err != -ENOSPC)
> > +		err = 0;
> > +out:
> > +	return err;
> > +}
> 
> [ ... ]
> 
> >  int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
> >  			  union bpf_attr __user *uattr)
> >  {
> >  	bool is_l2 = false, is_direct_pkt_access = false;
> >  	u32 size = kattr->test.data_size_in;
> >  	u32 repeat = kattr->test.repeat;
> > +	struct __sk_buff *ctx = NULL;
> >  	u32 retval, duration;
> >  	int hh_len = ETH_HLEN;
> >  	struct sk_buff *skb;
> > @@ -141,6 +247,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
> >  	if (IS_ERR(data))
> >  		return PTR_ERR(data);
> >  
> > +	ctx = bpf_ctx_init(kattr, sizeof(struct __sk_buff));
> > +	if (IS_ERR(ctx)) {
> > +		kfree(data);
> > +		return PTR_ERR(ctx);
> > +	}
> > +
> >  	switch (prog->type) {
> >  	case BPF_PROG_TYPE_SCHED_CLS:
> >  	case BPF_PROG_TYPE_SCHED_ACT:
> > @@ -158,6 +270,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
> >  	sk = kzalloc(sizeof(struct sock), GFP_USER);
> >  	if (!sk) {
> >  		kfree(data);
> > +		kfree(ctx);
> >  		return -ENOMEM;
> >  	}
> >  	sock_net_set(sk, current->nsproxy->net_ns);
> > @@ -166,6 +279,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
> >  	skb = build_skb(data, 0);
> >  	if (!skb) {
> >  		kfree(data);
> > +		kfree(ctx);
> >  		kfree(sk);
> >  		return -ENOMEM;
> >  	}
> > @@ -180,32 +294,37 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
> >  		__skb_push(skb, hh_len);
> >  	if (is_direct_pkt_access)
> >  		bpf_compute_data_pointers(skb);
> > +	ret = convert___skb_to_skb(skb, ctx);
> > +	if (ret)
> > +		goto out;
> >  	ret = bpf_test_run(prog, skb, repeat, &retval, &duration);
> > -	if (ret) {
> > -		kfree_skb(skb);
> > -		kfree(sk);
> > -		return ret;
> > -	}
> > +	if (ret)
> > +		goto out;
> >  	if (!is_l2) {
> >  		if (skb_headroom(skb) < hh_len) {
> >  			int nhead = HH_DATA_ALIGN(hh_len - skb_headroom(skb));
> >  
> >  			if (pskb_expand_head(skb, nhead, 0, GFP_USER)) {
> > -				kfree_skb(skb);
> > -				kfree(sk);
> > -				return -ENOMEM;
> > +				ret = -ENOMEM;
> > +				goto out;
> >  			}
> >  		}
> >  		memset(__skb_push(skb, hh_len), 0, hh_len);
> >  	}
> > +	convert_skb_to___skb(skb, ctx);
> >  
> >  	size = skb->len;
> >  	/* bpf program can never convert linear skb to non-linear */
> >  	if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
> >  		size = skb_headlen(skb);
> >  	ret = bpf_test_finish(kattr, uattr, skb->data, size, retval, duration);
> > +	if (!ret)
> > +		ret = bpf_ctx_finish(kattr, uattr, ctx,
> ctx is not checked for NULL in here either.
Good catch, I didn't think about the case where ctx_in is not set,
but ctx_out is set. Let me handle that in the v3.

Thank you for a review!
> 
> > +				     sizeof(struct __sk_buff));
> > +out:
> >  	kfree_skb(skb);
> >  	kfree(sk);
> > +	kfree(ctx);
> >  	return ret;
> >  }
> >  
> > -- 
> > 2.21.0.392.gf8f6787159e-goog
> > 
