Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926413;
	b=ZkE2+/GA8dbq+en89B9l9bsWUENPVerOjOeiorzX5tioAD9s+oZy3tqmABmvxf1NN7yr
	 sWBxrnr/CUNOtRVPQeesAyB2UhR7fhJ6n+PnIZ12VQQgNWZFau63nZZ+Lk2RN+80hLQuv
	 725eqRD25Od36kLzJ5puVzoaD/kheE8yUgWBfCAENuBp5/ni06fI4ctbChxagrGE81VCH
	 uQ4sWqpT26GBXZ6tFjidXCldsJEh7GWdLk7DjJ9PB48kLu6PkJdewEEt2MzDU5mk+1wRV
	 cVc82OsIaexVRelhOSZhE2PU+TpUbNujydpDOFw3T6BeOcFycIvJxKUHOU72Q4af/tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926413;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=nHWPW4VdSrJJatZiB9Q4c/ci+6thEbpBkkx8hkoBRWU=;
	b=Bhush7YCTWbT0bES8hPuVVUbiAw92RJbe2yAaViSbZenu4ixtaUa1a+rzizsOnx263tO
	 65V0rD+IauDMCR5uYXJ+nDyHN9yLsQTmU2FvTDqD3cM7czT/Ae9YinRl0PHDjACzx6lZ2
	 c3GRRsACdl6C4ctvaMTutDbuMY1XYBGPuZAYbMc4wmnLeyvPN567dF4AUtj5mILKmD0z4
	 QniYb2r7tJiG+G1e0AJ/PUvCVwjZulGJCZhWG1lMNebx8ebGBZvfpbWDk5C3hFGyrm5XY
	 bYhGu4Lx+nppFEZX58eCbdkRZzgGQ0urISm9QaNPulzx7e5Pi9tdDpC0F+00ReitpDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQo4pYXH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E27606A31C;
	Tue, 17 Nov 2026 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQo4pYXH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F2A1F000C4;
	Tue, 17 Nov 2026 14:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794926413;
	bh=nHWPW4VdSrJJatZiB9Q4c/ci+6thEbpBkkx8hkoBRWU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TQo4pYXH1QA18aakyvBJ2E80M8uA19DCBq1jaTFZJk+q4y8LiRCDZNOSN7o9yoeuy
	 B4GoG4r086s90D1ftPWB0MRn7PO67sIXCu98xwm85TXjUBN6eKRqhFsG/6gHgrXoMC
	 3dX2A7H5CFtkxgVi2ncHaY3vEB5wD1fm8Trshhn6mgmFc5JQ5Y4D3Vbt0T+vM7IiL2
	 xSCb55hFnexsvG8p6MFmaxYf81PvcIuh8fNbd+mVX43wo6B3WAaMfJd9NguG2h1Aau
	 a7zsNdap1RWb9XQgqz4P3O4Y55vVk8BLXEQRWVqfXGOBT7sAo9y66ApSBNvlyfMscV
	 yd8FGkCIhTqKw==
Subject: Re: [PATCH net-next 4/6] bonding: factor out slave publication
From: netdev-bot+sashiko@kernel.org
To: hangbin.liu@linux.dev
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Date: Tue, 17 Nov 2026 14:40:12 +0000
Message-ID: <179492641202.3136.3136612053973913945@kernel.org>
In-Reply-To: <20261113-bond_enslave_restruct-v1-4-364c549e78db@kylinos.cn>
References: <20261113-bond_enslave_restruct-v1-4-364c549e78db@kylinos.cn>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new comment on bond_publish_slave() in
  drivers/net/bonding/bond_main.c says the helper will "Make the fully…
- [Low] The commit message calls bond_publish_slave() the "infallible
  'commit point'", and the new comment says "All fallible steps of…
- [Low] The commit author is 'Hangbin Liu <hangbin.liu@linux.dev>', but
  the only Signed-off-by is 'Hangbin Liu <liuhangbin@kylinos.cn>'.

--

bonding: factor out slave publication

This commit moves the final block of bond_enslave() into a new helper,
bond_publish_slave(). That block bumps slave_cnt, recomputes upper
features and carrier, adds NS maddrs, selects the active slave and
rebuilds the xmit slave arrays. The commit message calls this the
infallible commit point of the function and says there is no functional
change.

> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>

[Severity: Low]
This isn't a bug, but the Author address (hangbin.liu@linux.dev) does not
match the only Signed-off-by (liuhangbin@kylinos.cn). checkpatch reports
this as "From:/Signed-off-by: email address mismatch".

The same mismatch shows up on all six patches in the series, from
"bonding: check XDP support before enslaving changes state" through
"bonding: factor out bond_enslave_validate".

Could the addresses be made to match, or a From: line or Signed-off-by
be added for the author address?

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index f696a0d150346..bb37526834562 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1884,6 +1884,34 @@ void bond_xdp_set_features(struct net_device *bond_dev)
>  	xdp_set_features_flag(bond_dev, val);
>  }
>  
> +/* Make the fully prepared slave visible to the rest of the bonding
> + * code.  All fallible steps of bond_enslave() must have completed
> + * before this runs: error paths never undo the publication.
> + */

[Severity: Low]
Is "visible to the rest of the bonding code" accurate here? By the time
bond_publish_slave() runs, bond_enslave() has already made the slave
reachable:

    res = netdev_rx_handler_register(slave_dev, bond_handle_frame,
                                     new_slave);
    ...
    res = bond_master_upper_dev_link(bond, new_slave, extack);
    ...
    res = bond_sysfs_slave_add(new_slave);

bond_for_each_slave() is netdev_for_each_lower_private(). So once
bond_master_upper_dev_link() returns, every bond_for_each_slave() walker
sees the new slave. bond_xdp_set_features(), called just before this
helper, already iterates over it.

In the default (trunk) mode, the switch in bond_enslave() also publishes
the slave as curr_active_slave. That happens before several steps that
can still fail (netpoll, rx_handler, upper link, sysfs, promisc/allmulti,
XDP):

    if (!rcu_access_pointer(bond->curr_active_slave) &&
        new_slave->link == BOND_LINK_UP)
        rcu_assign_pointer(bond->curr_active_slave, new_slave);

The err_detach path then undoes that:

    if (rcu_access_pointer(bond->curr_active_slave) == new_slave) {
        block_netpoll_tx();
        bond_change_active_slave(bond, NULL);
        bond_select_active_slave(bond);
        unblock_netpoll_tx();
    }

So "error paths never undo the publication" does not seem to hold either.

The helper actually commits slave_cnt and rebuilds derived state: upper
features, carrier, NS maddrs, active slave selection and the xmit slave
arrays. Between bond_master_upper_dev_link() and bond_publish_slave(),
list walkers see N+1 slaves while slave_cnt is still N.

Could the comment say that instead? Otherwise a later change might assume
the slave cannot be reached before this point.

> +static void bond_publish_slave(struct bonding *bond, struct slave *slave)
> +{

[ ... ]

> +	/* broadcast mode uses the all_slaves to loop through slaves. */
> +	if (bond_mode_can_use_xmit_hash(bond) ||
> +	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
> +		bond_update_slave_arr(bond, NULL);
> +}

[Severity: Low]
The commit message calls this the infallible "commit point", and the
comment above says all fallible steps must be done before this runs. Can
bond_update_slave_arr() still fail here?

drivers/net/bonding/bond_main.c:bond_update_slave_arr() {
    ...
	usable_slaves = kzalloc_flex(*usable_slaves, arr, bond->slave_cnt);
	all_slaves = kzalloc_flex(*all_slaves, arr, bond->slave_cnt);
	if (!usable_slaves || !all_slaves) {
		ret = -ENOMEM;
		goto out;
	}
    ...
}

On that path bond_set_slave_arr() is never called. Since skipslave is
NULL, nothing else makes up for it.

bond_publish_slave() returns void, so the error is dropped and the
slave_arr work is not re-armed. bond_slave_arr_handler() does re-arm it
when the same call fails:

	ret = bond_update_slave_arr(bond, NULL);
	rtnl_unlock();
	if (ret) {
		pr_warn_ratelimited("Failed to update slave array from WT\n");
		goto err;
	}
	return;

err:
	bond_slave_arr_work_rearm(bond, 1);

If the allocation fails, bond_enslave() still returns 0 and slave_cnt
has already been incremented. all_slaves and usable_slaves still hold
the old slave set. bond_xmit_broadcast() skips the new slave, and
XOR/3ad/TLB hashing never picks it, until some unrelated event rebuilds
the arrays.

The unchecked call was already inline in bond_enslave() before this
patch. What is new is the void helper and the comment that call it
infallible.

Should the comment and commit message be corrected? Or should the helper
call bond_slave_arr_work_rearm(bond, 1) when bond_update_slave_arr()
fails?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-bond_enslave_restruct-v1-0-364c549e78db%40kylinos.cn
