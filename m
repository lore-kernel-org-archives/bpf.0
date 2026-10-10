Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B943A809;
	Sat, 10 Oct 2026 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791623580; cv=none; b=QUVxj66PUSSfQ9oTtVTIEBERg62Fx8ha8LwWSgc6NqkMUPXCBt4yafwkVjlQFMK2bVtZyhB9woUrOBMWBlIC3L4N3RdOWBYrBrsLfaZc468SInZY4JfFMd3k7grQFq0pwTff/CCVOTItnUdq+6guDXYOqu2Htvfl+owm1MFJspo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791623580; c=relaxed/simple;
	bh=+Qp0NfL7bUiNxcnvhbz1Hn4/uJqLLLXkgA3LHyJAXdw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=he1bLh2lAOlMTRHcgx7LphE/sN4IeGSiO8HkWRDaHKaKGKmzk+LwoOeqsNLz1qUrPgL5nvvh0CqAx1gy8i3ZX4lOwQQ50Az+pU78aoxtSDscMe/ny7r3B4uAbbUIu/NHBxSLb8K85CPtGd73Cd9zCOcp/hK7QgZinawvPgyktvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHlex1Yh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHlex1Yh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399091F00893;
	Sat, 10 Oct 2026 09:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791623578;
	bh=xdn5aL86PRtScK6uYjQu/5FHrPPrkOYJq5HqsAyPgFc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eHlex1YhMI1dW1YGEECmfvZEkAAX5eMD2johHjrVwIR4uv2HJUcgBb4LlQP4Rgice
	 xoV+42CGh6W0N6eqk9mrLcJTBzs78tQ4U6F9cP7CBi+1w+1O/xXWrUIXE/CR46De60
	 OUXDFn8U02kRV7abz6iz+V9PU/Zy7bJ6yzAUfETWTe0ButeH57ntGhmE4sWv6/yy/G
	 WUWY+CadCBDYyYCTOzaMvXy+sD7rxgbhTCWHDBHB7A7cSm2Lb5y0CJj7lenhrPkBFY
	 UIR+E6z2Fj+aOn1yhuHvODltDmcDNAFni6Zgy3rAu/UplNgPRtLBq/ZidRv4INpxe6
	 BOojbf5BP0dFQ==
Subject:
 Re: [PATCH net-next v2 6/7] ipv6: convert do_ipv6_getsockopt() to sockopt_t
From: netdev-bot+sashiko@kernel.org
To: leitao@debian.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, sdf@fomichev.me, shuah@kernel.org,
 edumazet@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 david.laight.linux@gmail.com, kernel-team@meta.com
Date: Sat, 10 Oct 2026 09:12:56 +0000
Message-ID: <179162357674.434549.6706954274592631376@kernel.org>
In-Reply-To: <20261009-sockopt_expand_out_v2-v2-6-8ac08c469ecb@debian.org>
References: <20261009-sockopt_expand_out_v2-v2-6-8ac08c469ecb@debian.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ipv6_getsockopt() now reads optlen and replaces a negative
  value with 4 before it calls do_ipv6_getsockopt().
- [Low] When the caller passes a negative optlen, ipv6_getsockopt() sets
  sopt.optlen to 4 and then always runs `put_user(sopt.optlen, optlen)`,…
- [Low] The commit message explains why sockopt_init_user() cannot be
  used by pointing to 'See discussion in the previous patch/commit.' The…
- [Low] ipv6_getsockopt() now declares `int len, err;` at function scope
  (line 1359) and then declares `int len = sopt.optlen;` again inside…

--

ipv6: convert do_ipv6_getsockopt() to sockopt_t

This commit converts do_ipv6_getsockopt(), ip6_mroute_getsockopt() and
ipv6_getsockopt_sticky() from sockptr_t to sockopt_t. ipv6_getsockopt()
now reads optlen itself and treats a negative value as 4. It builds a
user-backed sockopt_t with a new sockopt_set_user() helper and always
writes optlen back, while sol_ipv6_sockopt() builds its sockopt_t with
sockptr_to_sockopt().

> ipv6_getsockopt() cannot use sockopt_init_user() as its IPv4 sibling
> does, since that rejects a negative optlen and this level answers it as
> 4. See discussion in the previous patch/commit.

[Severity: Low]

Which commit is "the previous patch/commit"? The patch right before this
one in the series is "ipv4: convert do_ip_getsockopt() to sockopt_t", and
it does not discuss negative optlen.

The reasoning appears to be in "ipv6: treat a negative optlen as 4 in
do_ipv6_getsockopt()", which is several patches earlier. Could the message
name that commit directly?

The message also doesn't mention the new sockopt_set_user() helper. It is
added to include/linux/net.h by splitting it out of sockopt_init_user().

> diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
> index b488391496af3..c9787579531f6 100644
> --- a/net/ipv6/ipv6_sockglue.c
> +++ b/net/ipv6/ipv6_sockglue.c

[ ... ]

> @@ -998,42 +998,21 @@ static int compat_ipv6_get_msfilter(struct sock *sk, sockopt_t *opt)
>  	return 0;
>  }
>  
> -int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
> -		       sockptr_t optval, sockptr_t optlen)
> +int do_ipv6_getsockopt(struct sock *sk, int level, int optname, sockopt_t *sopt)
>  {
>  	struct ipv6_pinfo *np = inet6_sk(sk);
>  	int len;
>  	int val;
>  
>  	if (ip6_mroute_opt(optname))
> -		return ip6_mroute_getsockopt(sk, optname, optval, optlen);
> +		return ip6_mroute_getsockopt(sk, optname, sopt);
>  
> -	if (copy_from_sockptr(&len, optlen, sizeof(int)))
> -		return -EFAULT;
> -	/* Historic bug compatibility: the int options have always taken a
> -	 * negative optlen as 4, so take it as 4 everywhere.
> -	 */
> -	if (len < 0)
> -		len = 4;
> +	len = sopt->optlen;

[Severity: Medium]

Before this patch, the negative-optlen-as-4 handling ran after the
ip6_mroute_opt() dispatch, so MRT6_VERSION, MRT6_PIM and MRT6_ASSERT never
saw it. Now that the handling lives in ipv6_getsockopt(), does it also
apply to the mroute options?

ipv6_getsockopt()
    if (len < 0)
        len = 4;
    sockopt_set_user(&sopt, optval, len);
  do_ipv6_getsockopt()
    ip6_mroute_getsockopt()
        olr = min_t(int, sopt->optlen, sizeof(int));
        if (olr < 0)
            return -EINVAL;

The old ip6_mroute_getsockopt() read the raw user optlen and returned
-EINVAL for a negative value. When the caller passes -1, olr is now 4.
On a raw ICMPv6 socket, getsockopt(SOL_IPV6, MRT6_VERSION) with
optlen = -1 now succeeds, writes 4 bytes into optval and sets optlen
to 4.

The other caller, sol_ipv6_sockopt(), goes through sockptr_to_sockopt().
That already rejects a negative length, so the olr < 0 check in
ip6_mroute_getsockopt() looks unreachable now.

The IPv4 side still rejects this input. ip_getsockopt() uses
sockopt_init_user(), which returns -EINVAL for len < 0, and
ip_mroute_getsockopt() keeps its own olr < 0 check. Is the difference
between IPv4 and IPv6 intended?

The comment moved into ipv6_getsockopt() says "the int options have
always taken a negative optlen as 4", which was not true for MRT6_*.

The order of operations also changes for these options. On a socket that
isn't raw ICMPv6, the old code returned -EOPNOTSUPP without touching
optlen. Now get_user() and put_user() on optlen run first, so an
unreadable or unwritable optlen gives -EFAULT instead.

Should the mroute options skip the negative-to-4 conversion? If not,
could the commit message describe this behavior change?

[ ... ]

> @@ -1377,7 +1355,8 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
>  int ipv6_getsockopt(struct sock *sk, int level, int optname,
>  		    char __user *optval, int __user *optlen)
>  {
> -	int err;
> +	sockopt_t sopt;
> +	int len, err;
>  
>  	if (level == SOL_IP && sk->sk_type != SOCK_RAW)
>  		return ip_getsockopt(sk, level, optname, optval, optlen);
> @@ -1385,15 +1364,22 @@ int ipv6_getsockopt(struct sock *sk, int level, int optname,
>  	if (level != SOL_IPV6)
>  		return -ENOPROTOOPT;
>  
> -	err = do_ipv6_getsockopt(sk, level, optname,
> -				 USER_SOCKPTR(optval), USER_SOCKPTR(optlen));
> +	if (get_user(len, optlen))
> +		return -EFAULT;
> +	/* Historic bug compatibility: the int options have always taken a
> +	 * negative optlen as 4, so take it as 4 everywhere.
> +	 */
> +	if (len < 0)
> +		len = 4;
> +	sockopt_set_user(&sopt, optval, len);
> +
> +	err = do_ipv6_getsockopt(sk, level, optname, &sopt);
> +	if (put_user(sopt.optlen, optlen))
> +		return -EFAULT;

[Severity: Low]

When the caller passes a negative optlen, sopt.optlen is 4 at this point,
and put_user() runs whatever err is. Do failing calls now change the
caller's optlen from -1 to 4?

For example, IPV6_PATHMTU with optlen = -1 fails the
"len < sizeof(mtuinfo)" check and returns -EINVAL, and then
put_user(4, optlen) runs. The same happens for:

- -ENOTCONN from IPV6_MTU
- -EINVAL from IPV6_FLOWLABEL_MGR and MCAST_MSFILTER
- -EOPNOTSUPP and -ENOENT from the MRT6_* options
- the default -ENOPROTOOPT

In the parent commit, none of these paths wrote optlen. For MCAST_MSFILTER,
sockptr_to_sockopt() rejected a negative optlen and left optlen alone.
Earlier patches in the series described this as leaving "the caller's
optlen word unchanged".

The netfilter fallback below now gets 4 instead of the caller's original
value. If nf_getsockopt() fails, optlen has already been overwritten.

The commit message mentions the unconditional write-back. It doesn't say
that the stored value can differ from the caller's input on failure. Is
that intended?

>  #ifdef CONFIG_NETFILTER
>  	/* we need to exclude all possible ENOPROTOOPTs except default case */
>  	if (err == -ENOPROTOOPT && optname != IPV6_2292PKTOPTIONS) {
> -		int len;
> -
> -		if (get_user(len, optlen))
> -			return -EFAULT;
> +		int len = sopt.optlen;

[Severity: Low]

This isn't a bug, but this inner int len shadows the int len that this
patch adds at the top of ipv6_getsockopt(). Could it simply be
"len = sopt.optlen;"? W=2 builds with -Wshadow will warn here.

>  
>  		err = nf_getsockopt(sk, PF_INET6, optname, optval, &len);
>  		if (err >= 0)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-sockopt_expand_out_v2-v2-0-8ac08c469ecb%40debian.org
