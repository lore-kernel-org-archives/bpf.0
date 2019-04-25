Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D508BC43219
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 21:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FA4216C4
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 21:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfDYVVg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:21:36 -0400
Received: from www62.your-server.de ([213.133.104.62]:52478 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfDYVVg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 17:21:36 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hJloA-0005lK-An; Thu, 25 Apr 2019 23:21:30 +0200
Received: from [178.199.41.31] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hJloA-0007O6-4n; Thu, 25 Apr 2019 23:21:30 +0200
Subject: Re: [PATCH bpf-next v4 1/2] bpf: support BPF_PROG_QUERY for
 BPF_FLOW_DISSECTOR attach_type
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, jakub.kicinski@netronome.com,
        quentin.monnet@netronome.com, Jann Horn <jannh@google.com>
References: <20190424213141.201134-1-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f85cf077-aa9e-775f-f3e7-1538354514cd@iogearbox.net>
Date:   Thu, 25 Apr 2019 23:21:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190424213141.201134-1-sdf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25430/Thu Apr 25 09:58:44 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/24/2019 11:31 PM, Stanislav Fomichev wrote:
> target_fd is target namespace. If there is a flow dissector BPF program
> attached to that namespace, its (single) id is returned.
> 
> v4:
> * add missing put_net (Jann Horn)
> 
> v3:
> * add missing inline to skb_flow_dissector_prog_query static def
>   (kbuild test robot <lkp@intel.com>)
> 
> v2:
> * don't sleep in rcu critical section (Jakub Kicinski)
> * check input prog_cnt (exit early)
> 
> Cc: Jann Horn <jannh@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  include/linux/skbuff.h    |  8 +++++++
>  kernel/bpf/syscall.c      |  2 ++
>  net/core/flow_dissector.c | 46 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 56 insertions(+)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 998256c2820b..6d58fa8a65fd 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1258,11 +1258,19 @@ void skb_flow_dissector_init(struct flow_dissector *flow_dissector,
>  			     unsigned int key_count);
>  
>  #ifdef CONFIG_NET
> +int skb_flow_dissector_prog_query(const union bpf_attr *attr,
> +				  union bpf_attr __user *uattr);
>  int skb_flow_dissector_bpf_prog_attach(const union bpf_attr *attr,
>  				       struct bpf_prog *prog);
>  
>  int skb_flow_dissector_bpf_prog_detach(const union bpf_attr *attr);
>  #else
> +static inline int skb_flow_dissector_prog_query(const union bpf_attr *attr,
> +						union bpf_attr __user *uattr)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline int skb_flow_dissector_bpf_prog_attach(const union bpf_attr *attr,
>  						     struct bpf_prog *prog)
>  {
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 92c9b8a32b50..b0de49598341 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2009,6 +2009,8 @@ static int bpf_prog_query(const union bpf_attr *attr,
>  		break;
>  	case BPF_LIRC_MODE2:
>  		return lirc_prog_query(attr, uattr);
> +	case BPF_FLOW_DISSECTOR:
> +		return skb_flow_dissector_prog_query(attr, uattr);
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index fac712cee9d5..27466e54ad3a 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -65,6 +65,52 @@ void skb_flow_dissector_init(struct flow_dissector *flow_dissector,
>  }
>  EXPORT_SYMBOL(skb_flow_dissector_init);
>  
> +int skb_flow_dissector_prog_query(const union bpf_attr *attr,
> +				  union bpf_attr __user *uattr)
> +{
> +	__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
> +	u32 prog_id, prog_cnt = 0, flags = 0;
> +	struct bpf_prog *attached;
> +	struct net *net;
> +	int ret = 0;
> +
> +	if (attr->query.query_flags)
> +		return -EINVAL;
> +
> +	net = get_net_ns_by_fd(attr->query.target_fd);
> +	if (IS_ERR(net))
> +		return PTR_ERR(net);
> +
> +	rcu_read_lock();
> +	attached = rcu_dereference(net->flow_dissector_prog);
> +	if (attached) {
> +		prog_cnt = 1;
> +		prog_id = attached->aux->id;
> +	}
> +	rcu_read_unlock();

Patch looks good to me, one small nit: is there any reason you didn't
do the put_net(net) right after the rcu_read_unlock() above? Below it's
not really needed anymore, so this would also simplify the error paths
by being able to directly return in error case, no?

> +	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags))) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +	if (copy_to_user(&uattr->query.prog_cnt, &prog_cnt, sizeof(prog_cnt))) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +	if (!attr->query.prog_cnt || !prog_ids || !prog_cnt)
> +		goto out;
> +
> +	if (copy_to_user(prog_ids, &prog_id, sizeof(u32))) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +out:
> +	put_net(net);
> +	return ret;
> +}
> +
>  int skb_flow_dissector_bpf_prog_attach(const union bpf_attr *attr,
>  				       struct bpf_prog *prog)
>  {
> 

