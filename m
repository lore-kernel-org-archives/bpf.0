Return-Path: <SRS0=rZCH=SH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356C9C282CE
	for <bpf@archiver.kernel.org>; Fri,  5 Apr 2019 21:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33A220663
	for <bpf@archiver.kernel.org>; Fri,  5 Apr 2019 21:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="HgYV66BM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfDEVsi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:48:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42375 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDEVsi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Apr 2019 17:48:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so3727094pgh.9
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2019 14:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KI4+bn0TOU6wK+igtB/J2NZGVsCfcU6zUmE+r3ENNG0=;
        b=HgYV66BMIiskl6sV+Ol1OqPmQ1JGZ+99MdcDrlTFDsfjBk4b5QzYvVZDaml/haihlI
         yYxD29eZJWhuYCdZwynzjnUZ3ZEIRBR27Vv/VXTTta55huZMj4E2yRidq9Isf11uQrN+
         PrCHPfz5ldOToOsKAlBTNHDu2b3trZg/OsGLW+QNhNtGDp1CaqgrmweoaPdzjFWZvOkz
         rBGv9oyPjzRuEDdfNmbmd3LIOslAhDKV+Z/zUZ7lVp1E7aK4MBJHrmR4mh0IVhS660Qc
         aR//zXQcxXi4AuzVeQQaw3NH7cD1rx1/iO6DnqyRYgKr4AoYlFpY9OH0/VMBnkAXK2v8
         VyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KI4+bn0TOU6wK+igtB/J2NZGVsCfcU6zUmE+r3ENNG0=;
        b=nkU/CWjYCoh2Kv4bZ8pma6VFWNhvo9IuqzctDKXzpaRZhg+syGbADkTBb0W8j3bHRV
         3+Y3sbaO5KbnKEgSUTLveY4y/qsLFB0nts2dmC+6d95fCgSHt219MbNjkimuo79fO6wW
         bNNJX47ZsRhu+H/U0XL7ivFwFGdLmhvlGza5po8Nzxl6njYje6nVKXgnM81om/lkwT6K
         eplTtCoxVgqq5CCXj+kagJB2STfHPtqahzHFdKGUQjYovPpEq8DlvHpk/TXeFHqxNn+Z
         UNkhcxGqI6le/s521J8LFoUStPZ5n6GX6FCNq2a0AySzsT2AzcxUMNRAZwR4tID91M8K
         7ZlA==
X-Gm-Message-State: APjAAAXRCT8e1HL9A5SI1RJmne/qppmvKcKxPM446+YBbA4n1NRIlmPP
        +5/3r5+gO6aZkx8yFwlZPvGJgA==
X-Google-Smtp-Source: APXvYqxIfxmOVoQS4iWpupWY3C58m3293AwRHsRd6FwRiDC0axozcxEsfbcTjabHIqEzDU+yBUaT3g==
X-Received: by 2002:a63:720c:: with SMTP id n12mr14497802pgc.348.1554500917431;
        Fri, 05 Apr 2019 14:48:37 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id x24sm30901139pfn.128.2019.04.05.14.48.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 14:48:36 -0700 (PDT)
Date:   Fri, 5 Apr 2019 14:48:35 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Martin Lau <kafai@fb.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 1/3] bpf: support input __sk_buff context in
 BPF_PROG_TEST_RUN
Message-ID: <20190405214835.GK7431@mini-arch.hsd1.ca.comcast.net>
References: <20190404185133.95071-1-sdf@google.com>
 <20190405200736.ba2mzz42y7pecpsm@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405200736.ba2mzz42y7pecpsm@kafai-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/05, Martin Lau wrote:
> On Thu, Apr 04, 2019 at 11:51:31AM -0700, Stanislav Fomichev wrote:
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
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  include/uapi/linux/bpf.h |   7 +++
> >  kernel/bpf/syscall.c     |   2 +-
> >  net/bpf/test_run.c       | 133 +++++++++++++++++++++++++++++++++++++--
> >  3 files changed, 136 insertions(+), 6 deletions(-)
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
> > index 1d65e56594db..4ad754e2943a 100644
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
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index fab142b796ef..593912a66d64 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -123,12 +123,121 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 size,
> >  	return data;
> >  }
> >  
> > +static void *bpf_ctx_init(const union bpf_attr *kattr, u32 max_size)
> > +{
> > +	void __user *data_in = u64_to_user_ptr(kattr->test.ctx_in);
> > +	u32 size = kattr->test.ctx_size_in;
> > +	void *data;
> > +
> > +	if ((kattr->test.ctx_size_in && !kattr->test.ctx_in) ||
> > +	    (!kattr->test.ctx_size_in && kattr->test.ctx_in))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if ((kattr->test.ctx_size_out && !kattr->test.ctx_out) ||
> > +	    (!kattr->test.ctx_size_out && kattr->test.ctx_out))
> > +		return ERR_PTR(-EINVAL);
> These attr checks belong to bpf_prog_test_run() in syscall.c.
Ack, will move.

> > +
> > +	if (!size)
> > +		return NULL;
> > +
> > +	if (size > max_size)
> Not allowed even the tailing (size - max_size) bytes are zero?
We can do that if you think it makes sense. My intention was
not to unnecessarily complicate it because it's for testing only.

> > +		return ERR_PTR(-EINVAL);
> The convention should be -E2BIG if the userspace passed in something bigger
> with tailing non-zero that the kernel cannot understand.
SGTM.

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
> > +	u32 copy_size = size;
> Is the "u32 copy_size = size;" needed?
> I don't see "size" is changed.
> 
> > +
> > +	if (!kattr->test.ctx_size_out)
> > +		return 0;
> > +
> > +	if (copy_size > kattr->test.ctx_size_out)
> If I read both bpf_ctx_init() and btf_ctx_finish() correctly,
> the kattr->test.ctx_size_in (input) can be smaller than
> sizeof(struct __sk_buff) but the kattr->test.ctx_size_out (output)
> cannot be smaller than sizeof(struct __sk_buff)?
Yeah, you read that correct. Let me actually do the same as we do in
bpf_test_finish - clamp to the user's requested size (and return
-ENOSPC). That will address you comment about copy_size as well.

> > +		return -ENOSPC;
> > +
> > +	if (data_out && copy_to_user(data_out, data, copy_size))
> "data_out" check is not needed.
Agreed.
> 
> > +		return -EFAULT;
> > +	if (copy_to_user(&uattr->test.ctx_size_out, &size, sizeof(size)))
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * range_is_zero - test whether buffer is initialized
> > + * @buf: buffer to check
> > + * @from: check from this position
> > + * @to: check up until (excluding) this position
> > + *
> > + * This function returns true if the there is a non-zero byte
> > + * in the buf in the range [from,to).
> > + */
> > +static inline bool range_is_zero(void *buf, size_t from, size_t to)
> > +{
> > +	return !memchr_inv((u8 *)buf + from, 0, to - from);
> > +}
> > +
> > +static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
> > +{
> > +	struct qdisc_skb_cb *cb = (struct qdisc_skb_cb *)skb->cb;
> > +
> > +	if (!__skb)
> > +		return 0;
> > +
> > +	/* make sure the fields we don't use are zeroed */
> > +	if (!range_is_zero(__skb, 0, offsetof(struct __sk_buff, priority)))
> > +		return -EINVAL;
> > +
> > +	/* priority is allowed */
> > +
> > +	if (!range_is_zero(__skb, offsetof(struct __sk_buff, priority) +
> > +			   FIELD_SIZEOF(struct __sk_buff, priority),
> > +			   offsetof(struct __sk_buff, cb)))
> > +		return -EINVAL;
> > +
> > +	/* cb is allowed */
> > +
> > +	if (!range_is_zero(__skb, offsetof(struct __sk_buff, cb) +
> > +			   FIELD_SIZEOF(struct __sk_buff, cb),
> > +			   sizeof(struct __sk_buff)))
> > +		return -EINVAL;
> > +
> > +	skb->priority = __skb->priority;
> > +	memcpy(&cb->data, __skb->cb, QDISC_CB_PRIV_LEN);
> > +
> > +	return 0;
> > +}
> > +
> > +static void convert_skb_to___skb(struct sk_buff *skb, struct __sk_buff *__skb)
> > +{
> > +	struct qdisc_skb_cb *cb = (struct qdisc_skb_cb *)skb->cb;
> > +
> > +	if (!__skb)
> > +		return;
> > +
> > +	__skb->priority = skb->priority;
> > +	memcpy(__skb->cb, &cb->data, QDISC_CB_PRIV_LEN);
> > +}
> > +
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
> > @@ -141,6 +250,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
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
> > @@ -158,6 +273,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
> >  	sk = kzalloc(sizeof(struct sock), GFP_USER);
> >  	if (!sk) {
> >  		kfree(data);
> > +		kfree(ctx);
> >  		return -ENOMEM;
> >  	}
> >  	sock_net_set(sk, current->nsproxy->net_ns);
> > @@ -166,6 +282,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
> >  	skb = build_skb(data, 0);
> >  	if (!skb) {
> >  		kfree(data);
> > +		kfree(ctx);
> >  		kfree(sk);
> >  		return -ENOMEM;
> >  	}
> > @@ -180,12 +297,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
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
> I think the following needs kfree(ctx) also (or goto out).
> Copying the context here:
> 
> 			if (pskb_expand_head(skb, nhead, 0, GFP_USER)) {
> 				kfree_skb(skb);
> 				kfree(sk);
> 				return -ENOMEM;
> 			}
> 
Ah, good catch, not sure how I missed that :-(

Thank you for a review, will follow up with a v2!
> > @@ -198,14 +315,20 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
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
