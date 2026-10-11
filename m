Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E663B371CF8
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791762623; cv=pass; b=dINf+hzoKMUn8F0jLN34SkzoVzSXstP8n9XiEA5cS62TAS6PcvrwYhcYiSessKiNtfYHfR82TJwKa+AC1ICJRUPxPUEiI7+thRLfk2wpFkJnd9lgbQeanbecv4k/DvUQup44QnYgR7wzPceNQdLYvXP3T4HPLtg8nphKwNZv9y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791762623; c=relaxed/simple;
	bh=/VSk4aRzpW/Ssz5gd6omr3QOx2ETjVACkmFQtXQwvb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PofYOQsrClFMrZAgLBMQoxPy+NdykCUA0T+B8p/uJxSqynoBoYbK858f9oa9jM9DSuO55EFtMu4fJebAK/8CyhMnv3kvOFmimqz5RmbYt+JqI+OXJrbYLmuBM70Tx/xMgvSAW64sTK4unH6xwlVKbVzcxFl0rCPMTtXjyA8hYp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=TCwU+p+x; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="TCwU+p+x"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-88cfa501c5cso318098b3a.3
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 16:50:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791762621; cv=none;
        d=google.com; s=arc-20260327;
        b=BLdFv0P3RFOnf4ZDVfvOY29kGRj6SZxQj+kKvcbLimnKBqvTI4TQ6nuol9o+saQdps
         Y/Bxsxg8FJHfAxZp/rDcANfqI2IWr58icI5Oq1plFr8+BwQR556w+yudCl4bdvOlCMmW
         ABtUfyfJErGk/WbY52rgHU+tgKvnKKxp2s0wdLUi7KD+ZlOzBWweiB31gnVAL+GYBxzJ
         Ymmwc2GPbat0ji64OLULlJKo78yJd+zDDU8dyMzCEK4qF6npXQFqrM4du1PRT5Xk0Hdx
         HpPnNGhPbAZ5IicJRXytG/t9Gqp6ALI5JbyaQFzi8kC1SsGuz1eMqte4Zvrfze92qcNS
         AZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u4PqpVrpatImFkzFg+aGm6oTuO6TBHSKdUouwf1g6s0=;
        fh=SiurrjaU6RoqMvS6G3sV4clHKJd3Vg5G/XGUsqMmlug=;
        b=C3VjfQYNdOjtMGHucKXxIYNIf4Oz4pwp0Y18dR7DAn09ccrUYUP9JEmsLS+G1Q5XzD
         oliq0jCVbE6FsM/xd6NVJw2BMcEzOsRQoKsfcdO46HfIkMqAQS3tVJOM1xChxAwUASKj
         xaSqgnB8nDxBKbz5YZ7PMquSS041BCOKWBngvQ7A/L5alYjgcIG+CJvFw290u4oLJyDc
         44NQmwqIQR54gI2Ya33oYq/dUj4Sl6KLD7Sg0WmFwg8UXum1PLOsYEMBHusbn09PtU3x
         OkUxeZG2ObVtFW6+cqncCC3Jo16sEApebi0YTiRvwNkdibk+qQgLZRRLAqMbZ6fc+jwM
         Un4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791762621; x=1792367421; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u4PqpVrpatImFkzFg+aGm6oTuO6TBHSKdUouwf1g6s0=;
        b=TCwU+p+xvjRy+mUwrVvwIlIHbhL+xsRm33ofEcOzUhPfQ447YQHFo5WAXcCBr+5Uzv
         Nbl0g3McLQqVGt9KmhJIW75zWrYEr6HWD/davtHDki3iG7WhYrwozKyx/hJBEBIzklOa
         mKH3nJd/j3+c8SdKDwUARpAbu3y05p2LDRHsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791762621; x=1792367421;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u4PqpVrpatImFkzFg+aGm6oTuO6TBHSKdUouwf1g6s0=;
        b=LHoN4roq/jTRIpy8qMCQiyvysliHztVe5nEq5b2E5Dd+oyhwJQ5gSbD8Ajm/SiRjpn
         ieGSO4IRWyOmgHWYDAjUiVx6KMyxfZQUwvASESQ4Uu9pqbxWc+NjHc+NgYmFEgxbLT+q
         W+1FjFaQ9jxg+GeShJ/gMavsIWS01xCnq85Fmz/T4yhQQf/5sEWQUetSJjrP5gq4hdZk
         8FRqm7LqDIXH9J9Wu6/jFoLdgkjOwsYvUSkX90TA8SorIHvmFZFqWCO+J0zVFL8FJ7Xt
         PG3drf2k6s4FZFq5NspJuvFKUgA0ZE/DLcewjonM+YGO5dreGdbXZx8ayWz/XBwQe46M
         ypbA==
X-Forwarded-Encrypted: i=1; AKwUvBz8QzzwrEOm3iC9IZwDLKE6q/2e62nsjR/1r3SalRylwxgAdmWhcM9I67j9MxEkhtULryQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJB4RcalmnTGT+NHejg6NaS2Ttj9bUsKmcbsA8Ed1own64c3FLW
	SPhRHD071XAK6DSGb7Pef5jj+qJv0xnHf2097/ARqfSRq7hSF7QduBt+iOZ3an8jeyMFf21w4DE
	yj07SicVPaStPIQyeLZIkEUggrWmDqFZF2j+c6GEJ
X-Gm-Gg: AYBFou0vaEZzrW7nqOIUOiFZCBbd00mrZkkniXr29HltnsmTvDPI3Fkpz9fARBCcbiA
	H4jtcykApSY0HrxSfs4AyR++9z2yIdpz7em+u1RUXfIQk6E22Ap0dYs712+qFgU8ZGtT1gwfP+o
	cGrrbbijazoQLK2G18F8sxnoHQJK8NMYx3ShOdyzfOeYExJEUB9Dhi283EU1yqlhYZ0HQqilcQd
	6K4Vz4mSXsGIM7mPNpCso/4aBYNguEmzA59oqfDCZ1Yw9NcHrHrF8VA5lbrSkHpbf6zl55GavGp
	UoX1X8IblVgz46D1v+eKJJ5G2o6XVg44sYQb21HO8IgOx5bIuDbaLjMNFuYSI29VVQUQyluAyRh
	MKTbeQWcXBXxVoynJ1FwXWFVlhcHLz55H3rbvX244BDYH
X-Received: by 2002:a05:6a00:3404:b0:886:15e3:df99 with SMTP id
 d2e1a72fcca58-897c6539615mr7207916b3a.17.1791762621027; Sun, 11 Oct 2026
 16:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-PYC7.v2.20261010165947-4@mojatatu.com> <179175260755.434549.1147971569759277746@kernel.org>
In-Reply-To: <179175260755.434549.1147971569759277746@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 11 Oct 2026 19:50:09 -0400
X-Gm-Features: AclHuK9B1zchKndOELbR-p8m58k1P0GSs3loNtgJNnwoB0tm_ovetI9ZvXiCm3o
Message-ID: <CAM0EoMmUzCnH92G22XMpqudQeNx-Bqm2QLHds-oUSK2CHYafnA@mail.gmail.com>
Subject: Re: [PATCH net v2 3/3] selftests: net: exercise dev-bound cls_bpf on
 shared blocks
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, jiri@resnulli.us, bpf@vger.kernel.org, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 5:03=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 (1) =C2=B7 Low: 0 (2)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The commit message says the first subtest checks that "the
>   program attaches to a shared block owned by its device, and the filter=
=E2=80=A6
>
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but the late-
>   join subtest (block 30) runs a core offload-accounting imbalance and=E2=
=80=A6
> - [Low] This problem wasn't introduced by this patch, but the same-
>   offload-device subtest hits a netdevsim state-tracking defect.
> - [Low] This problem wasn't introduced by this patch, but if one of the
>   new subtests fails, a netdevsim device can be left behind.
>

Unless something else which is substantial shows up I will not be
sending an update to this patch.

cheers,
jamal
> --
>
> selftests: net: exercise dev-bound cls_bpf on shared blocks
>
> This adds test_tc_shared_block() to bpf_offload.py. The test attaches a
> device-bound SCHED_CLS program to netdevsim through shared tc blocks. It
> covers four cases: attach on a block owned by the bound device, rejection
> when a foreign device is a member, rejection of a foreign device that
> joins late during replay, and acceptance on a second port of the same
> netdevsim device.
>
> > diff --git a/tools/testing/selftests/net/bpf_offload.py b/tools/testing=
/selftests/net/bpf_offload.py
> > index c856d266c8f36..8c1da9b51be5a 100755
> > --- a/tools/testing/selftests/net/bpf_offload.py
> > +++ b/tools/testing/selftests/net/bpf_offload.py
>
> [ ... ]
>
> > @@ -629,6 +661,111 @@ def test_spurios_extack(sim, obj, skip_hw, needle=
):
> >                              include_stderr=3DTrue)
> >      check_no_extack(res, needle)
> >
> > +def test_tc_shared_block():
>
> [ ... ]
>
> > +    start_test("Test TC shared-block dev-bound attach...")
> > +    # The pinned program is dev-bound to this device; attaching it thr=
ough
> > +    # a shared block must succeed even though block->q is NULL.
> > +    sim.tc_add_block(22)
> > +    # err is kept (include_stderr) for post-mortem value on a failure.
> > +    ret, _, err =3D sim.tc_add_block_filter(22, bpf_pinned("/sys/fs/bp=
f/tc_shared"),
> > +                                          da=3DTrue, skip_sw=3DTrue,
> > +                                          fail=3DFalse, include_stderr=
=3DTrue)
> > +    fail(ret !=3D 0, "dev-bound program rejected on a matching shared =
block")
> > +    fail(sim.dfs_read("bpf_offloaded_id") =3D=3D "0",
> > +         "dev-bound program not offloaded on a matching shared block")
> > +    sim.tc_del_block(22)
>
> [Severity: Medium]
> The commit message says this subtest checks that "the program attaches to
> a shared block owned by its device, and the filter teardown leaves the
> device unloaded". Is the teardown part checked anywhere?
>
> After sim.tc_del_block(22), nothing reads bpf_offloaded_id again or waits
> for the flush. sim.tc_del_block(30) has the same gap. So does the
> sim3b.tc_del_block(50) / sim3.tc_del_block(50) pair, which covers the
> unbind remove replay and the last-member block destroy.
>
> The tc_del_block() helper also ignores failure:
>
>     def tc_del_block(self, block):
>         tc("qdisc del dev %s clsact" % (self['ifname']), fail=3DFalse)
>
> The only check left is bpftool_prog_list_wait(expected=3D0) at the end. I=
t
> runs after simdev3.remove(), simdev.remove() and the rm of both pins. It
> counts programs, not per-port offload state, so it can't tell an unload
> caused by filter teardown from one caused by device removal.
>
> Suppose the remove replay through
> cls_bpf_reoffload()->nsim_bpf_setup_tc_block_cb()->nsim_bpf_offload(ns,
> NULL, true) stopped clearing ns->bpf_offloaded:
>
> For blocks 30 and 50, the only sign would be the
> WARN_ON(ns->bpf_offloaded) in nsim_bpf_uninit() in dmesg.
>
> For block 22, the failure would show up later as -EBUSY ("driver and
> netdev offload states mismatch") on the block 30 attach. The test would
> then report it as "dev-bound program rejected on a matching shared block"=
.
>
> Could a check like this be added after each tc_del_block() for sim, sim3
> and sim3b, while the devices still exist?
>
>     fail(sim.dfs_read("bpf_offloaded_id") !=3D "0", ...)
>
> It could also be worth checking that sim3 is still loaded after sim3b
> leaves block 50. Otherwise, the teardown claim could be dropped from the
> commit message.
>
> > +
> > +    start_test("Test TC shared-block broadcast to a foreign member..."=
)
> > +    # Add an independently backed device to the SAME block before the
> > +    # attach.  The program is bound to sim's device only, and the offl=
oad
> > +    # path fans it out to every member, so the attach must be rejected=
.
> > +    simdev2 =3D BpfNetdevSimDev()
>
> [Severity: Low]
> This is a pre-existing issue, not one introduced by this patch, but can a
> failure in one of these subtests leave a netdevsim device behind?
>
> clean_up() loops over the same list that each removal modifies:
>
>     for dev in devs:
>         dev.remove()
>
> and BpfNetdevSimDev.remove() does:
>
>     def remove(self):
>         super().remove()
>         devs.remove(self)
>
> As a result, every removal skips the next entry in the list.
>
> Here simdev and simdev2 (or simdev3) are both alive. A fail() in the
> broadcast, late-join or same-offload-device subtest raises before the
> local simdevN.remove(). The outer finally then calls clean_up(), which
> removes the first device and skips the second. The second device and its
> clsact qdisc are left in place.
>
> Looping over a copy of the list (for dev in list(devs):) would avoid
> this.
>
> [ ... ]
>
> > +    sim.tc_add_block(30)
> > +    ret, _, err =3D sim.tc_add_block_filter(30, bpf_pinned("/sys/fs/bp=
f/tc_shared"),
> > +                                          da=3DTrue, skip_sw=3DTrue,
> > +                                          fail=3DFalse, include_stderr=
=3DTrue)
> > +    fail(ret !=3D 0, "dev-bound program rejected on a matching shared =
block")
> > +    ret, _, err =3D sim2.tc_add_block(30, fail=3DFalse, include_stderr=
=3DTrue)
> > +    fail(ret =3D=3D 0, "foreign device joined a populated dev-bound sh=
ared block")
> > +    check_extack_nsim(err, "program bound to a different device.", arg=
s)
> > +    fail(sim2.dfs_read("bpf_offloaded_id") !=3D "0",
> > +         "replayed program loaded onto a foreign device")
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but the rejected join here
> seems to break the core offload accounting, and these assertions can't
> catch it.
>
> When sim2 joins block 30, tcf_block_bind()->tcf_block_playback_offloads()
> with add=3Dtrue replays the filter to sim2's callback. The callback rejec=
ts
> it with -EINVAL. Because the filter is skip_sw, tc_setup_cb_reoffload()
> returns the error and the playback unwinds:
>
> net/sched/cls_api.c:tcf_block_playback_offloads() {
>     ...
> err_playback_remove:
>         tcf_proto_put(tp, true, NULL);
>         tcf_chain_put(chain);
>         tcf_block_playback_offloads(block, cb, cb_priv, false, offload_in=
_use,
>                                     extack);
>     ...
> }
>
> This sends a remove to the same sim2 callback, including for the tp whose
> add just failed. nsim returns success for removing a program it never
> held:
>
> drivers/net/netdevsim/bpf.c:nsim_bpf_setup_tc_block_cb() {
>     ...
>         if (ns->bpf_offloaded !=3D oldprog) {
>                 oldprog =3D NULL;
>                 if (!cls_bpf->prog)
>                         return 0;
>     ...
> }
>
> So tc_setup_cb_reoffload() calls tc_cls_offload_cnt_update() with
> add=3Dfalse. The filter's in_hw_count drops from 1 (sim's real offload) t=
o
> 0. TCA_CLS_FLAGS_IN_HW is cleared and block->offloadcnt drops to 0, while
> sim still has the program loaded.
>
> When sim.tc_del_block(30) runs, the unbind decrements in_hw_count again.
> The u32 wraps to 0xFFFFFFFF and stays there until block destruction calls
> tc_cls_offload_cnt_reset(). Until then, tcf_block_offload_in_use() is
> false, so tcf_block_offload_bind() skips its "dev has offload disabled"
> check.
>
> Would it be worth also checking sim's offload state and the filter's
> in_hw flag after the rejected join?
>
> The same remove-returns-0 behaviour can already be reached through nsim's
> -EBUSY add rejection path, and nfp's callback has the same shape.
>
> [ ... ]
>
> > +    fail(sim3b.dfs_read("bpf_offloaded_id") =3D=3D "0",
> > +         "program not offloaded to the same-offload-device port")
> > +    sim3b.tc_del_block(50)
> > +    sim3.tc_del_block(50)
>
> [Severity: Low]
> This is a pre-existing netdevsim issue, not one introduced by this patch,
> but with this teardown order the program's debugfs loaded state is wrong
> while sim3 is still offloaded.
>
> netdevsim tracks loaded state in a single per-program boolean that every
> port shares:
>
> drivers/net/netdevsim/bpf.c:nsim_prog_set_loaded() {
>     ...
>         state =3D prog->aux->offload->dev_priv;
>         state->is_loaded =3D loaded;
> }
>
> sim3b.tc_del_block(50) replays a remove to sim3b. That runs
> nsim_bpf_offload(ns, NULL, true), which calls
> nsim_prog_set_loaded(ns->bpf_offloaded, false). This clears is_loaded
> even though sim3's ns->bpf_offloaded still points at the program.
>
> Until sim3 leaves the block, bpf_bound_progs/<id>/loaded reads as not
> loaded. The WARN(state->is_loaded, ...) in nsim_bpf_destroy_prog() also
> won't fire in this case.
>
> The existing XDP multi-dev ASIC tests already follow the same pattern.
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-PYC7.v2.20261010165947%40mojatatu.com
