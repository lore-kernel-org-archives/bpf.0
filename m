Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A097337188B;
	Mon, 21 Sep 2026 06:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789972695; cv=none; b=YIJoqKB4ykfhKpCbByymoTnfxmfhkRig35TdipiHk9NXwlAzXCBA0bEVlJgQhAz5KQFk5LzosM5eHW6HEwlNYecnO3EqT+mIMY7+cmzwCX7OoZXP1HnHQZx7i8jVx5E+ib/dKAi2nHbV5TtjgpPEi9e9cY3cPAfZc8OFcBrNuJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789972695; c=relaxed/simple;
	bh=bMxzDIxiW8cOH1VnbzCdMyTeE+OjDPpHkWawxiDfxxY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IkIryliCy8rtwaA08J7sWAEe2lKvP3J6KuQ9OKRJfn8m6xLl7w5WL8sBN/4r4o9Hgf8/Cv2S/ReOtMJrZetfJQ2ZayYvBQhE2Zkzt5aAzm5GmpoFQJ3FMY7btaGffFYrP+Cc/tFBOFVfpURgJB3E07sfRnzWUxLAW4A4Tpt+i0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1oysJ+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1oysJ+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691781F00893;
	Mon, 21 Sep 2026 06:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789972693;
	bh=1JE51AbZAJCWb44yWHH5z+1HzSH3k7L3puE5z2Zm/68=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z1oysJ+qbtVY1VRA6wLJvZcrc9Jekm3KnztLIswEPsN8G7lKljUNB+NPAs2zrFbd+
	 yuX5HjyX0djcRSmDS1xpuaarsdqNt1CY/hbWbMmnKqw68siarC3htEyjr5yYWKU/Xp
	 9lUZnQHLFc7Qj27Uro7gTO3hQE9s3Ov9nHZGGJAdAGwbXCtgfU1ZaaKlEhnj7aPwQp
	 v81wKRL+9TLyybcX5W0MEDQUC189h1JfhXzLuiGy9OzVs619tWV0j2aDzF3p0n+tIS
	 vc31OWMlF843btRuNf1QePTxKN47BsV+Ayc5zOxNO1szDWPt9SYlyCCFZgUlz9EgID
	 N+pgvtB8WPjfg==
Subject: Re: [PATCH net-next 1/6] net: lwtunnel: change encap fill order
From: netdev-bot+sashiko@kernel.org
To: hangbin.liu@linux.dev
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, liuhangbin@kylinos.cn
Date: Mon, 21 Sep 2026 06:38:11 +0000
Message-ID: <178997269190.2160803.430062400277571051@kernel.org>
In-Reply-To: <20260917-ynl_rt_encap-v1-1-fbbe6e680571@kylinos.cn>
References: <20260917-ynl_rt_encap-v1-1-fbbe6e680571@kylinos.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Incomplete rollback in lwtunnel_fill_encap()
  (net/core/lwtunnel.c:229-268): the reorder commits the selector…
- [Low] Concern (assessed INVALID by baseline verification, retained only
  for policy combination): the commit message justifies the reorder by a…

--

net: lwtunnel: change encap fill order

This moves the encap-type attribute so it is written before the encap
nest in lwtunnel_fill_encap(), so that YNL can read the sub-message
selector before the payload it selects.  No other behaviour was
intended to change.

> diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
> index b01a395d9a966..f13dfa02e026e 100644
> --- a/net/core/lwtunnel.c
> +++ b/net/core/lwtunnel.c
> @@ -240,6 +240,10 @@ int lwtunnel_fill_encap(struct sk_buff *skb, struct lwtunnel_state *lwtstate,
>  	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
>  		return 0;
>  
> +	ret = nla_put_u16(skb, encap_type_attr, lwtstate->type);
> +	if (ret)
> +		return ret;
> +
>  	nest = nla_nest_start_noflag(skb, encap_attr);
>  	if (!nest)
>  		return -EMSGSIZE;

[Severity: Medium]
Now that the type attribute is committed to the skb before the nest is
opened, can the -EOPNOTSUPP path leave it behind?

In lwtunnel_fill_encap() the failure label only rewinds the nest, and
-EOPNOTSUPP is translated into a successful return:

net/core/lwtunnel.c:lwtunnel_fill_encap() {
	ret = -EOPNOTSUPP;
	rcu_read_lock();
	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
	if (likely(ops && ops->fill_encap))
		ret = ops->fill_encap(skb, lwtstate);
	rcu_read_unlock();

	if (ret)
		goto nla_put_failure;
	...
nla_put_failure:
	nla_nest_cancel(skb, nest);

	return (ret == -EOPNOTSUPP ? 0 : ret);
}

nla_nest_cancel() trims back only to the start of the nest, so the
encap_type_attr written just above it stays in the message.  Before this
change the type attribute was emitted only after ops->fill_encap()
succeeded, so this path left the skb unchanged.

All callers treat the 0 return as success and finish the message, for
example fib_nexthop_info():

	if (lwtunnel_fill_encap(skb, nhc->nhc_lwtstate,
				RTA_ENCAP, RTA_ENCAP_TYPE) < 0)
		goto nla_put_failure;

and the same "< 0" test appears in nh_fill_node(), rt_fill_info() and
rt6_fill_node().  Does that mean user space can now receive a route or
nexthop message carrying RTA_ENCAP_TYPE / NHA_ENCAP_TYPE with no encap
payload?

That shape is rejected by the kernel's own nexthop parser in
rtm_to_nh_config():

	} else if (tb[NHA_ENCAP_TYPE]) {
		NL_SET_ERR_MSG(extack, "LWT encapsulation attribute is missing");
		goto out;

so tools that dump and replay nexthops would see -EINVAL on restore.

Would it work to record the write position before emitting the selector
and nlmsg_trim() back to it on the failure and -EOPNOTSUPP paths, or to
reserve the selector attribute and fill it in only once the payload fill
has succeeded?

The trigger requires lwtun_encaps[lwtstate->type] to be NULL or an ops
without a ->fill_encap handler while an lwtstate of that type is still
live, which the module reference taken in lwtunnel_build_state() makes
hard to reach in normal operation, but the code explicitly tests
ops->fill_encap so the branch does not look impossible.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917-ynl_rt_encap-v1-0-fbbe6e680571%40kylinos.cn
