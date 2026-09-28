Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0070F3B05B9;
	Mon, 28 Sep 2026 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621753; cv=none; b=efs5ZSoxNZbLhQuZA8//c4c+qtQ0YJOZ9cpdye+ClolhJVbHfG9UKM34Mn1xgUxLvqyLPsFT6lAUUlTdV6X8jYmNUL2MPNjZnzz0VbA114Fr4dxPxdMfvi0SrAE6+ZJhusbTMXls3LzuOECK/ZLzD5GvR9zQwijNz+LywrOLEYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621753; c=relaxed/simple;
	bh=XPwigVvTjklCcIr/x2Opf8X0G/XwL0/A2Cw7i4UcKPE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZnYB2+4Sx1fGdYz/aV+PZJsSLfAstEEKf+UBA0wbOuKciK3xi/KvwMsVdi/xOI33rVG66gU/ROWVum+PgJq8wzRd6QJ/ap+987ZajyhbWzjjN9uq/KXv7fBRRAfBnLteQAZ6JCc4lYOhojcxn7hqH8oUNNwCCM8JImKP2x/cNkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTBjZEhO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTBjZEhO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366761F000FF;
	Mon, 28 Sep 2026 18:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790621751;
	bh=sXgZG49MRdjq3CIf5uw5tFn4qyJNzUqQ3R8w8NhV8Tw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lTBjZEhOZ1193ahujLMQ9Ys2WFx95wVUR+mCpIxG3RXKEbGV+LbAkP0toUC1NsAKs
	 Zyd732LlZ/K+sGGVs5RUaGerfHOx8pztjkJOlkBC03jfIvnQfMcINcs+uZTYV/T8BW
	 j28/9TVK246oRAXizZxb4yPzxzcRIUhWFzEetUsyR4ce+SlDtkwQrHyD02nymXjt0z
	 Xgg8JC18SlFsezq8avIWmtLoJXwBlELk8YWwWNGAsGL4P8EYViD+gq2dm+JCiSDdba
	 QgmKVMmrxc8v5lUfcWjAdB/Wj0hO4EmS0MCGhkvqUyJdETafopeNzasiQEz9jfBFOH
	 1LVYuD/HLq1Cw==
Subject:
 Re: [PATCH net-next 5/6] ipv6: convert do_ipv6_getsockopt() to sockopt_t
From: netdev-bot+sashiko@kernel.org
To: leitao@debian.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 david.laight.linux@gmail.com, kernel-team@meta.com
Date: Mon, 28 Sep 2026 18:55:49 +0000
Message-ID: <179062174981.3145.15015654316454414221@kernel.org>
In-Reply-To: <20260925-sockopt_expand_out_v2-v1-5-c3ef2e3bb5c0@debian.org>
References: <20260925-sockopt_expand_out_v2-v1-5-c3ef2e3bb5c0@debian.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says the wrong thing about the order of
  checks.

--

ipv6: convert do_ipv6_getsockopt() to sockopt_t

This commit moves do_ipv6_getsockopt(), ip6_mroute_getsockopt() and
ipv6_getsockopt_sticky() from sockptr_t to sockopt_t, and drops the
MCAST_MSFILTER bridge. ipv6_getsockopt() now builds the sockopt_t with
sockopt_init_user() and always writes optlen back. The BPF caller
sol_ipv6_sockopt() builds it with sockptr_to_sockopt().

> MRT6_* is still dispatched before optlen is validated, so a negative
> optlen there wins over -EOPNOTSUPP.

[Severity: Low]
Is this description accurate? After this patch, ipv6_getsockopt() checks
optlen in sockopt_init_user(). That happens before do_ipv6_getsockopt()
reaches the ip6_mroute_opt() dispatch:

net/ipv6/ipv6_sockglue.c:ipv6_getsockopt() {
    ...
	err = sockopt_init_user(&sopt, optval, optlen);
	if (err)
		return err;

	err = do_ipv6_getsockopt(sk, level, optname, &sopt);
    ...
}

sockopt_init_user() rejects a bad optlen before anything else runs:

include/linux/net.h:sockopt_init_user() {
	if (get_user(len, optlen))
		return -EFAULT;
	if (len < 0)
		return -EINVAL;
    ...
}

sol_ipv6_sockopt() does the same thing through sockptr_to_sockopt().

So optlen is now validated before MRT6_* is dispatched, which is the
opposite of what the message says. The stated result is still right: a
negative optlen now wins over -EOPNOTSUPP. But that is because of the new
order, not the old one.

The IPv4 sibling commit "ipv4: convert do_ip_getsockopt() to sockopt_t"
describes the same change this way: "Validating optlen now precedes the
level check and the MRT_* dispatch". Could this message use similar
wording?

Could the message also list every errno whose precedence changed? Before
this patch, ip6_mroute_getsockopt() returned these without reading optlen:

  -EOPNOTSUPP (not a raw ICMPv6 socket)
  -ENOENT (no mr_table)
  -ENOPROTOOPT (unknown MRT6 name)

All three are now overridden by -EINVAL for a negative optlen and by
-EFAULT for an unreadable one. Under CONFIG_NETFILTER, the -ENOPROTOOPT
case used to fall through to nf_getsockopt().

Both callers now reject a negative optlen before calling in. Can the
len < 0 check in do_ipv6_getsockopt() and the olr < 0 check in
ip6_mroute_getsockopt() still be reached?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925-sockopt_expand_out_v2-v1-0-c3ef2e3bb5c0%40debian.org
