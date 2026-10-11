Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA33368276;
	Sun, 11 Oct 2026 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791752610; cv=none; b=po31O/aQIkTwcjtmubO4rM2i8kvfGf2sRk+lys61+FTKPzSuEDD5fCJdOsTdm79Fbp/izj/Rw1kG9qO1j2Zr5WNlB9+oOxMQcBwpJY+XBMOqyPjRa2OrG0hQMAxGNB3ctmv4uxVlG3sFUBweyaL+uB5FhMBBZlexWHN83Qp08CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791752610; c=relaxed/simple;
	bh=OgI/bHo4oc1y8HnUI1Vvb2ubbaY+msprP5OU7osb4FE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cFBAqtko89tbBoK0YF6nWBlDbDriM1VxtLQl6ndf5/77GEmP6Kw6FZMqbQZJqaf/o239DyjVY4+ZqCr8QrBaba14NGy8ATi29+pZQucHdrxufcfvqdyc2vXRtoZDddVtTZfWqE0agollONbsyfa6m35Y7tE7HoayraOm6wWPKs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9GZyS89; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9GZyS89"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0235E1F0089B;
	Sun, 11 Oct 2026 21:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791752608;
	bh=i6K2rse2GTNWdify1/eu62I2wM0NylsqCkleWxwlDno=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=a9GZyS8903uT1G1SBIcBy4EGypHZwjmieYJRTScAa2xqd8wM6qcKGKfZNXNU1I7AQ
	 GdDCgpGRpTu0kGzdaxezida9Z/D9Aq5eRjdKdC5KjhddUQkJrUoin+4fwngRS7p785
	 8ir3GYLInvlI+xLDQ/OzyrtENQaTyBYoF95jTFPNtTsC267nfLnbUjP6acM3UmMHlu
	 4oIgahQ+2aJ0NBUdyUV6/mQwNq8zcX+YPJcMwHjirDKRuyZS0sqh41J70nqQE7ZBOy
	 HRJ+1hMU80swfz15I0V6LYiP8WH/SPjfO3quPiZjIjnZX7bMnM1TFn/rDUrZEANycF
	 YHVFPfEw0jBtg==
Subject: Re: [PATCH net v2 3/3] selftests: net: exercise dev-bound cls_bpf on
 shared blocks
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, jiri@resnulli.us, bpf@vger.kernel.org, victor@mojatatu.com
Date: Sun, 11 Oct 2026 21:03:27 +0000
Message-ID: <179175260755.434549.1147971569759277746@kernel.org>
In-Reply-To: <QDISC-PYC7.v2.20261010165947-4@mojatatu.com>
References: <QDISC-PYC7.v2.20261010165947-4@mojatatu.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the first subtest checks that "the
  program attaches to a shared block owned by its device, and the filter…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the late-
  join subtest (block 30) runs a core offload-accounting imbalance and…
- [Low] This problem wasn't introduced by this patch, but the same-
  offload-device subtest hits a netdevsim state-tracking defect.
- [Low] This problem wasn't introduced by this patch, but if one of the
  new subtests fails, a netdevsim device can be left behind.

--

selftests: net: exercise dev-bound cls_bpf on shared blocks

This adds test_tc_shared_block() to bpf_offload.py. The test attaches a
device-bound SCHED_CLS program to netdevsim through shared tc blocks. It
covers four cases: attach on a block owned by the bound device, rejection
when a foreign device is a member, rejection of a foreign device that
joins late during replay, and acceptance on a second port of the same
netdevsim device.

> diff --git a/tools/testing/selftests/net/bpf_offload.py b/tools/testing/selftests/net/bpf_offload.py
> index c856d266c8f36..8c1da9b51be5a 100755
> --- a/tools/testing/selftests/net/bpf_offload.py
> +++ b/tools/testing/selftests/net/bpf_offload.py

[ ... ]

> @@ -629,6 +661,111 @@ def test_spurios_extack(sim, obj, skip_hw, needle):
>                              include_stderr=True)
>      check_no_extack(res, needle)
>  
> +def test_tc_shared_block():

[ ... ]

> +    start_test("Test TC shared-block dev-bound attach...")
> +    # The pinned program is dev-bound to this device; attaching it through
> +    # a shared block must succeed even though block->q is NULL.
> +    sim.tc_add_block(22)
> +    # err is kept (include_stderr) for post-mortem value on a failure.
> +    ret, _, err = sim.tc_add_block_filter(22, bpf_pinned("/sys/fs/bpf/tc_shared"),
> +                                          da=True, skip_sw=True,
> +                                          fail=False, include_stderr=True)
> +    fail(ret != 0, "dev-bound program rejected on a matching shared block")
> +    fail(sim.dfs_read("bpf_offloaded_id") == "0",
> +         "dev-bound program not offloaded on a matching shared block")
> +    sim.tc_del_block(22)

[Severity: Medium]
The commit message says this subtest checks that "the program attaches to
a shared block owned by its device, and the filter teardown leaves the
device unloaded". Is the teardown part checked anywhere?

After sim.tc_del_block(22), nothing reads bpf_offloaded_id again or waits
for the flush. sim.tc_del_block(30) has the same gap. So does the
sim3b.tc_del_block(50) / sim3.tc_del_block(50) pair, which covers the
unbind remove replay and the last-member block destroy.

The tc_del_block() helper also ignores failure:

    def tc_del_block(self, block):
        tc("qdisc del dev %s clsact" % (self['ifname']), fail=False)

The only check left is bpftool_prog_list_wait(expected=0) at the end. It
runs after simdev3.remove(), simdev.remove() and the rm of both pins. It
counts programs, not per-port offload state, so it can't tell an unload
caused by filter teardown from one caused by device removal.

Suppose the remove replay through
cls_bpf_reoffload()->nsim_bpf_setup_tc_block_cb()->nsim_bpf_offload(ns,
NULL, true) stopped clearing ns->bpf_offloaded:

For blocks 30 and 50, the only sign would be the
WARN_ON(ns->bpf_offloaded) in nsim_bpf_uninit() in dmesg.

For block 22, the failure would show up later as -EBUSY ("driver and
netdev offload states mismatch") on the block 30 attach. The test would
then report it as "dev-bound program rejected on a matching shared block".

Could a check like this be added after each tc_del_block() for sim, sim3
and sim3b, while the devices still exist?

    fail(sim.dfs_read("bpf_offloaded_id") != "0", ...)

It could also be worth checking that sim3 is still loaded after sim3b
leaves block 50. Otherwise, the teardown claim could be dropped from the
commit message.

> +
> +    start_test("Test TC shared-block broadcast to a foreign member...")
> +    # Add an independently backed device to the SAME block before the
> +    # attach.  The program is bound to sim's device only, and the offload
> +    # path fans it out to every member, so the attach must be rejected.
> +    simdev2 = BpfNetdevSimDev()

[Severity: Low]
This is a pre-existing issue, not one introduced by this patch, but can a
failure in one of these subtests leave a netdevsim device behind?

clean_up() loops over the same list that each removal modifies:

    for dev in devs:
        dev.remove()

and BpfNetdevSimDev.remove() does:

    def remove(self):
        super().remove()
        devs.remove(self)

As a result, every removal skips the next entry in the list.

Here simdev and simdev2 (or simdev3) are both alive. A fail() in the
broadcast, late-join or same-offload-device subtest raises before the
local simdevN.remove(). The outer finally then calls clean_up(), which
removes the first device and skips the second. The second device and its
clsact qdisc are left in place.

Looping over a copy of the list (for dev in list(devs):) would avoid
this.

[ ... ]

> +    sim.tc_add_block(30)
> +    ret, _, err = sim.tc_add_block_filter(30, bpf_pinned("/sys/fs/bpf/tc_shared"),
> +                                          da=True, skip_sw=True,
> +                                          fail=False, include_stderr=True)
> +    fail(ret != 0, "dev-bound program rejected on a matching shared block")
> +    ret, _, err = sim2.tc_add_block(30, fail=False, include_stderr=True)
> +    fail(ret == 0, "foreign device joined a populated dev-bound shared block")
> +    check_extack_nsim(err, "program bound to a different device.", args)
> +    fail(sim2.dfs_read("bpf_offloaded_id") != "0",
> +         "replayed program loaded onto a foreign device")

[Severity: Medium]
This isn't a bug introduced by this patch, but the rejected join here
seems to break the core offload accounting, and these assertions can't
catch it.

When sim2 joins block 30, tcf_block_bind()->tcf_block_playback_offloads()
with add=true replays the filter to sim2's callback. The callback rejects
it with -EINVAL. Because the filter is skip_sw, tc_setup_cb_reoffload()
returns the error and the playback unwinds:

net/sched/cls_api.c:tcf_block_playback_offloads() {
    ...
err_playback_remove:
	tcf_proto_put(tp, true, NULL);
	tcf_chain_put(chain);
	tcf_block_playback_offloads(block, cb, cb_priv, false, offload_in_use,
				    extack);
    ...
}

This sends a remove to the same sim2 callback, including for the tp whose
add just failed. nsim returns success for removing a program it never
held:

drivers/net/netdevsim/bpf.c:nsim_bpf_setup_tc_block_cb() {
    ...
	if (ns->bpf_offloaded != oldprog) {
		oldprog = NULL;
		if (!cls_bpf->prog)
			return 0;
    ...
}

So tc_setup_cb_reoffload() calls tc_cls_offload_cnt_update() with
add=false. The filter's in_hw_count drops from 1 (sim's real offload) to
0. TCA_CLS_FLAGS_IN_HW is cleared and block->offloadcnt drops to 0, while
sim still has the program loaded.

When sim.tc_del_block(30) runs, the unbind decrements in_hw_count again.
The u32 wraps to 0xFFFFFFFF and stays there until block destruction calls
tc_cls_offload_cnt_reset(). Until then, tcf_block_offload_in_use() is
false, so tcf_block_offload_bind() skips its "dev has offload disabled"
check.

Would it be worth also checking sim's offload state and the filter's
in_hw flag after the rejected join?

The same remove-returns-0 behaviour can already be reached through nsim's
-EBUSY add rejection path, and nfp's callback has the same shape.

[ ... ]

> +    fail(sim3b.dfs_read("bpf_offloaded_id") == "0",
> +         "program not offloaded to the same-offload-device port")
> +    sim3b.tc_del_block(50)
> +    sim3.tc_del_block(50)

[Severity: Low]
This is a pre-existing netdevsim issue, not one introduced by this patch,
but with this teardown order the program's debugfs loaded state is wrong
while sim3 is still offloaded.

netdevsim tracks loaded state in a single per-program boolean that every
port shares:

drivers/net/netdevsim/bpf.c:nsim_prog_set_loaded() {
    ...
	state = prog->aux->offload->dev_priv;
	state->is_loaded = loaded;
}

sim3b.tc_del_block(50) replays a remove to sim3b. That runs
nsim_bpf_offload(ns, NULL, true), which calls
nsim_prog_set_loaded(ns->bpf_offloaded, false). This clears is_loaded
even though sim3's ns->bpf_offloaded still points at the program.

Until sim3 leaves the block, bpf_bound_progs/<id>/loaded reads as not
loaded. The WARN(state->is_loaded, ...) in nsim_bpf_destroy_prog() also
won't fire in this case.

The existing XDP multi-dev ASIC tests already follow the same pattern.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-PYC7.v2.20261010165947%40mojatatu.com
