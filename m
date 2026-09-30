Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3956F3A7597;
	Wed, 30 Sep 2026 04:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743098; cv=none; b=d72rRyho70x8+3ek//OWExb2z/lqzNve7U9Y45Bkug+K+VWrwHgcZC9bGUj/ZPEKb3eyrjZmKG5FDb3CwWuuQDd1YE9gBiUULW/4Ke3S+qE0b6oxB701b7ngSGSJErkUxHyCHt+LoSr9lBlRKkcgrpm2QV8r0FM1v5IkrBMcgMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743098; c=relaxed/simple;
	bh=GYT7eT1KECwmbDFaNvpJby6plAGRiWvUhiK4AYcnTek=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pdIF4DLctsJ3LsWNbVyDL66bAiiNTmiBBpftC82ADUvCoCWqB+r8ylu16PQBxZuuz1ZMKP+MzZfqsljn9vj/WcVaYA3XyHn+J68cqB5HA9RcQPWWXp/5ihCZZkGic0HUryqKPG5//hIXr/1zzJSllQgSu84iS3znhw5Jh7vy430=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlIVYB3M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlIVYB3M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065751F00893;
	Wed, 30 Sep 2026 04:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790743096;
	bh=0XtIy8zM3q+07kSNv4YHXbKWv3mSH0OFJhoXTaP+DQQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HlIVYB3MbTsUg2+myQHVu1qPTpBTWTEt6V2O7DrYrG3XR6pW1Qpm3qaTSI2f3+MZv
	 e8JfF0ckvTonyrNqEoKRFXUCUbamQgux2go8kT/OblDTwHeEMSE17IEulSucAdAz+G
	 g2pMNXvIyFeU676wDZ+Cc2uc5yMwY8VajYDUiQUw43HHjw4M/aRbbiqBjXQdhL+rc6
	 fqC8BrQIN/qT/mArR0Gs0pVb9pxwRqpCWUIrHv3yeJRC4+dIi2/KsuqNjJwYUdcbbQ
	 AXnnzZ3Zx3Wkt7fZzOQFatDaLI4/hl4HZcBQDDvlbt1MDlw9JdCU0Rnt/gNF7JTLtf
	 QP55TTlMUF1MA==
Subject: Re: [PATCH net-next 4/5] selftests/bpf: check XDP attach on a nested
 bond slave
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net,
 hawk@kernel.org, sdf@fomichev.me, emil@etsalapatis.com, liuhangbin@gmail.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, aleksander.lobakin@intel.com
Date: Wed, 30 Sep 2026 04:38:15 +0000
Message-ID: <179074309557.434549.13415973847934182641@kernel.org>
In-Reply-To: <20260928223648.2739371-5-kuba@kernel.org>
References: <20260928223648.2739371-5-kuba@kernel.org>
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

- [Low] The commit message and the new in-code comment in
  test_xdp_bonding_nested()…
- [Low] In test_xdp_bonding_nested()
  (tools/testing/selftests/bpf/prog_tests/xdp_bonding.c:492-494) the new…

--

selftests/bpf: check XDP attach on a nested bond slave

This extends test_xdp_bonding_nested() so that it also attaches a
program to bond_nest2 after the outer bond already has one. The new
attach is expected to be refused. The commit message says the refusal
works because the direct upper (bond_nest1) records the program it was
handed.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
> index c42488e445c28..486e0f9a2adac 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c

[ ... ]

> @@ -488,10 +489,23 @@ static void test_xdp_bonding_nested(struct skeletons *skeletons)
>  	if (!ASSERT_OK(err, "set bond_nest2 master"))
>  		goto out;
>  
> +	nest2 = if_nametoindex("bond_nest2");
> +	if (!ASSERT_GE(nest2, 0, "if_nametoindex bond_nest2"))
> +		goto out;

[Severity: Low]
Can this check ever fail? if_nametoindex() returns 0 on failure, and
ASSERT_GE(nest2, 0, ...) then evaluates 0 >= 0, which is true. So the
goto out is never taken.

If the lookup did fail, nest2 would be 0, and the attach below would
fail in bpf_xdp_link_attach() before any XDP attach restrictions are
checked:

net/core/dev.c:bpf_xdp_link_attach() {
    ...
	dev = dev_get_by_index(net, attr->link_create.target_ifindex);
	if (!dev) {
		rtnl_unlock();
		return -EINVAL;
	}
    ...
}

The later ASSERT_ERR_PTR(link2, ...) accepts any error. That -EINVAL
would therefore be reported as the nested slave being correctly
refused.

The same pattern already exists for bond. There, though, a bad ifindex
makes the positive ASSERT_OK_PTR() fail. Here it feeds a negative
assertion, so the result is a false pass.

Should this be ASSERT_GT(nest2, 0, ...) instead?

> +
>  	link = bpf_program__attach_xdp(skeletons->xdp_dummy->progs.xdp_dummy_prog, bond);
> -	ASSERT_OK_PTR(link, "attach program to master");
> +	if (!ASSERT_OK_PTR(link, "attach program to master"))
> +		goto out;
> +
> +	/* Attaching to a nested slave is not allowed either. Only the direct
> +	 * upper is consulted, so this only holds if every device the program
> +	 * was propagated to records it.
> +	 */
> +	link2 = bpf_program__attach_xdp(skeletons->xdp_dummy->progs.xdp_dummy_prog, nest2);
> +	ASSERT_ERR_PTR(link2, "attach program to nested slave when master has program");

[Severity: Low]
Do this comment and the commit message describe the check that
actually refuses this attach?

The commit message says:

  "Only the direct upper is consulted when deciding whether a device is
  already running XDP, so with bond -> bond_nest1 -> bond_nest2 the
  check on bond_nest2 looks at bond_nest1, and it only sees a program
  there if bond_nest1 recorded the one it was handed."

Attaching to bond propagates all the way down the chain:

bond_xdp_set(bond)
  dev_xdp_propagate(bond_nest1)
    bond_xdp_set(bond_nest1)
      dev_xdp_propagate(bond_nest2)
        netif_xdp_propagate()
          dev->xdp_from_upper = !!bpf->prog;

This sets xdp_from_upper on bond_nest2 itself. The nest2 attach then
stops in dev_xdp_attach() before the upper device walk:

	/* the program belongs to an upper device */
	if (dev->xdp_from_upper) {
		NL_SET_ERR_MSG(extack, "Can't replace an XDP program installed by an upper device");
		return -EBUSY;
	}

The netdev_for_each_upper_dev_rcu() loop, which would return -EEXIST
after looking at bond_nest1, is never reached. So bond_nest1 is not
consulted for this attach.

ASSERT_ERR_PTR() also checks only that the attach failed, not which
errno was returned. -EBUSY, -EEXIST and unrelated failures all pass the
same way. The test does still catch the pre-fix behaviour, where the
attach succeeded.

Could the comment and commit message describe the xdp_from_upper
refusal instead? And could the test check the expected errno, so the
two rejection paths can be told apart?

>  
>  out:
> +	bpf_link__destroy(link2);
>  	bpf_link__destroy(link);
>  	system("ip link del bond");
>  	system("ip link del bond_nest1");

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928223648.2739371-1-kuba%40kernel.org
