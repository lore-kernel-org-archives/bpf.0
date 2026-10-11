Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1CC3ACEF8
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 23:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791762579; cv=pass; b=pUC9Cm5vZ6nX5hM2/PDZqQ3f+bRPvvQNQ9LGpjLi5ra8KIiIw2WJGw3FNbx4NAZYJEmYHsmo85IlDOAsfm/Km8TvDjTXaUWJwW6KusC8oHrSQUioVIR6RYWsqZeqDp4xAd6QUymKtvpIU7jkF4WvXNT2mHrQPiXZ8yO7P7ngE68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791762579; c=relaxed/simple;
	bh=HrfKmn9qs6fAPDd1wR5ofdTOe/bVER6zo8Nme2pwZT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J85Qg4CKXP0h5vkxQ3MXlWhjMpo6T6679QJWonOdkVLTUy0I99FRqrzSj1ien7mafD0UmClzwLT+uC3lXVaBetJyaKUzvIQ/YU3Wye4l0DnTw6IztGCSRnxWZGcsjajjKwTyG49y0pU+dphktbu2QaAA/aFIGaZoA3zr7IClEO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Q5zAirmr; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Q5zAirmr"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-88b7d853b11so742971b3a.1
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 16:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791762576; cv=none;
        d=google.com; s=arc-20260327;
        b=qjp3uuk4vTUKFaf6HNx4CQLFNTBatDIR0edrCye5UMa8w0K1XBCIWWbQxQAt5aQH8o
         +3ajidXkBNzDIdwtA14C+gtqaYqtQjdXuXw1XBmcggiX+0gqW7JqrEbNTRSGZ1G2PfyW
         kK4u7H4eOY9JPBRQ/5eVli3dN2xvbbV2oEIOBTSRMfNOCLCXSnDXAqDh29l/HCsV5pVj
         iVFpKYdpYU3oFWQV2289dR23mU4PUTmRQ9EM47WnvVzy3WvtBhzU6jdWEHiVdlJ6m1FW
         ldg9ELS5/WJhV1YGQERtvMtAYgBEyQJF/KSvqY86FM1hwXFnK6LkoCnkx4CwBsxrizvK
         3xow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xxVsFCn2koVdZeQBwo5grIeecj1lz6W9qtXamdCYuig=;
        fh=TElz4QMlk121ux/fgJIOnaEmjdahA37aQA1A3cqXFNE=;
        b=gbNQe8nGqddhpQNrwVmZHZET6t1ostiW8IPse0ZtRZa6IUlV5T5DUGEsRdfPofVwQV
         rMbhH7JkKkHbG4DedREHGs3aC40Umy+OC8hCM9XUkt9OVsBG1kbXi7S2qtOslZL6e9ha
         hUVXIc5Abjz+RKaXBH3KhQUtjtraFQd5rmCSO+86monEIZzfVSDgruQ2oS4EfreXBfss
         d83128s9yo9bnitSzURiz6h+sNcI5nvn3jLrxk5Jo07siI6sGMwNRbmuIdoB0NqR2CD7
         k/KVrMJ6t1k3afOk15yFKu/sINMoVS67F2IzNskHkU0KXGfmVmmf9kDoB/lyXjOTLmpF
         L5xA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791762576; x=1792367376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xxVsFCn2koVdZeQBwo5grIeecj1lz6W9qtXamdCYuig=;
        b=Q5zAirmr+gXzC0ETmZMqiyZVkzoc8f23J5VyDIbk6pam+NKhMqUp7IEH7n4xhPywwm
         BcKTLkGmczehSN09PkvFdxii/foh5U9U7E2EmWzjwK+/Neoe8SUbnqRec4u8X26Sxl09
         xfKjruH8u0gD4CurZ2dcL6AhStsMVWKpiuw0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791762576; x=1792367376;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xxVsFCn2koVdZeQBwo5grIeecj1lz6W9qtXamdCYuig=;
        b=vKJNmkTxVd7FqUXkENusTXnlWiZmLL8gsxEICL71dlReD15xfS7NXGOHvMywAKUaP6
         GfMUf5HkTX87jYsX0otWKjMbI7GW0xGZcH2oq2Gvo9AefU7JY0f0p8C8vP0ycC5avaJl
         4v4rACB4hHXjR4TE1y5cRbvUJt3qLuivJQbJunz+tMyVLVrPhTNEgizN8VlrNiLmI3JJ
         awruP4RYgvqlWz3o2N3Y+JU34h2LgxK27nU9uxSk6qHcQ+rCO7iNzD6swG7+89D8vVbc
         guR9lcehgOySR/FVT7+oS84E604CXkhWVokdh4N26k07Fyzdr/+lq/uHudeosfOhLkjZ
         VaVA==
X-Forwarded-Encrypted: i=1; AKwUvBzoeDUTY7VWSl1niKac5uY1wJh4JO/r0qEIvdx1UPACbLEYqogWK48ei6ym1dnrcS+AToA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTYa5x0zoOEzutkBIJESTk/dKZ3/lvx4PEAFRRUNyBvRpTKAjr
	Q6ecq6VONVQfSa8emND+GMqxMkAcIphfMZMSvS/B+skVScS1Dy5Hfy7N2d9ltHw5IzFUWjVSzld
	fS2zLWrzndeF2h22yu5i3wf/04hI4z8RfeBc8HQTK
X-Gm-Gg: AYBFou16jv+mSsiB1zPsSQ1oYu9/KOjwhCO9Dn2gKPqV0HYuNSPr8xxoYHbh7Eo8li0
	LMLD8zvbUrMnVUeAJ2ebo64s0l0ashmsBySff4J3DIcSUl3ABln2Lc/HQ5QCjpM7k/DghshyaXH
	Z2wbvOijlk+Y/lni0E5Zaujy2EfBta0wiq7jCB/Q109f6d0qxU7kiacb674k2e9Ac8HBOY7ttei
	o6BcgAIOuONmE3TfIZ3F6MVXKsm9Sg3ojOfU+83XeYwK3c9A4tW/Sh8nkFc/O7eGw7fIMXbwLck
	aQ2bEKErGX4aDr86kP10cV/RehwBofocTuWrYyZbBTW3JvjWtcb4mF6ZmppvDSe3LlBuHuJtEqM
	qa3xvyC2VayOpzc9GGvpX62BDjp4+qT6A7Q==
X-Received: by 2002:a05:6a00:9284:b0:890:e1ff:3bac with SMTP id
 d2e1a72fcca58-897c3ef925emr6357823b3a.8.1791762576250; Sun, 11 Oct 2026
 16:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-PYC7.v2.20261010165947-4@mojatatu.com> <179175260755.434549.1147971569759277746@kernel.org>
In-Reply-To: <179175260755.434549.1147971569759277746@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 11 Oct 2026 19:49:24 -0400
X-Gm-Features: AclHuK8d5drO7j5c0DGAq8NuaCDnyn2xqFpgj8CthGJvTQntklzqnOT6cxSg2Cc
Message-ID: <CAM0EoMk2X9JdHUop7yh0s6jphZXF+LJFZ+Fnfy6LHxmiLFVpoQ@mail.gmail.com>
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
