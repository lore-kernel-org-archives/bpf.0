Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E554D7D21
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 18:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090009; cv=none; b=EoFJzvEhuQ2JCoDopDXLf366KfIsMZ8k3I0Y+8zy6V2h5LqmpqLVLeN1TVCjRwEfAdmSIeJuxoWu+9trx2Pp80+KAAQo0mMwKJjDcS/NBf3lcIF7zY+SDQjMfF8bu7WtzFdbvEMsPxTON84WRyWNvVxokbt9N6quaMH43+NbpmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090009; c=relaxed/simple;
	bh=mdeaVvRyLdbPiVIJEQwZSPyviOwXNTFpgNG+LMHzYeQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=myg5zPhVgpxkMluucMOreKbMD/aixQTnzyFs5cccs9xbe9KIXG5NEHQ4GMNKfn9UNccef2NHC7IDb9YnEEExHiKdAbZYKpu3WPuPcDfZBndUWYRWXzgBFyk9Li4PrYP+42aoAOLRB4fsOzyAc1eCSodmhL4fGJgC494zxXoyDuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVSc6Rv4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVSc6Rv4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC3C1F000C6;
	Thu, 15 Oct 2026 18:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792090004;
	bh=rVLXs8jp4ZJH82C5wOWCfyJU1Wa/k5pcow066P3MZYg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hVSc6Rv4nYchjmo3967PScm8SSrdlkqUoBWNDCNRrO6zl9x8ma0pv4QqHslaHW5sD
	 1zwBzXcECn+Cy75mMpk7VobNgVZ3VuuEVgBoDDQC1dCaecZoA9IqBOWIACA2mtWedp
	 8zmXO1cd/D7HPRwqWKt7Ax1jqPoQp/rqY7L6a/MCwPZ/G5utpC3roJNcc1B7z+W+gw
	 0GHENbKbiSTx+geEUMb2X9Xn+XHK15LWeZ/Nnv5UNFS/KvcCeXP5NOBR+K/br5csPT
	 0znimUmmZu3ysnmiXVD8ddP7UVvI5Fo41ek/6DKkOa0HiBL7iPdvkDgUyYYEGv2ORG
	 6zkvvoenYtsQA==
Message-ID: <sashiko-outbox-173334@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 net-next 14/15] selftests: drv-net: test AF_XDP
 zero-copy with an SKB peer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261014184539.774708-15-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
 <20261014184539.774708-15-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:46:43 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: drv-net: system state leaked on exception in xsk.py
--

commit 800c14b8cb37c2773db542cb20c9fa28d14761b7
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

selftests: drv-net: test AF_XDP zero-copy with an SKB peer

This commit adds a new test script to run AF_XDP zero-copy tests against
an SKB-mode peer using pairs of xskxceiver processes. It sets up ntuple
filters, reserves huge pages, configures queues out of RSS, and cleans up
the configuration when the tests are complete.

> diff --git a/tools/testing/selftests/drivers/net/hw/xsk.py b/tools/testin=
g/selftests/drivers/net/hw/xsk.py
> new file mode 100755
> index 0000000000000..fd708bb3420db
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/xsk.py
[ ... ]
> +def _steer_udp(cfg, ifname, port, queue, host=3DNone):
> +    """Steer the test flow to queue, return False if ifname cannot."""
> +    ntuple =3D ethtool(f"-k {ifname}", json=3DTrue, host=3Dhost)[0]["ntu=
ple-filters"]
> +    if not ntuple["active"]:
> +        if ntuple["fixed"]:
> +            print(f"1..0 # SKIP {ifname} does not support ntuple-filters=
")
> +            return False
> +
> +        ethtool(f"-K {ifname} ntuple-filters on", host=3Dhost)
> +
> +    out =3D ethtool(f"-N {ifname} flow-type udp4 dst-port {port} action =
{queue}",
> +                  host=3Dhost).stdout

[Severity: Medium]
If the ethtool command fails here, cmd() will raise a CmdExitFailure
exception since fail=3DTrue is the default in net/lib/py. Does this leave
ntuple-filters on permanently enabled on the physical NIC, because the
exception prevents appending the rule to cfg.rules for later cleanup?

> +    rule =3D re.search(r"ID (\d+)", out).group(1)
> +    cfg.rules.append((host, ifname, rule, ntuple["active"]))
> +    return True
[ ... ]
> +def main():
> +    # ksft_run() exits on -l and -h before main() can undo the setup.
> +    if "-l" in sys.argv or "-h" in sys.argv:
> +        sys.exit(f"{sys.argv[0]}: -l and -h are not supported")
> +
> +    with NetDrvEpEnv(__file__, nsim_test=3DFalse) as cfg:
[ ... ]
> +        cases =3D _get_cases(cfg)
> +
> +        # _fixup_args() sets the options that differ between the cases.
> +        cfg.args =3D ["--hw",
> +                    "-p", cfg.remote_addr_v["4"],
[ ... ]
> +        cfg.local_args =3D [str(cfg.bin_local),
> +                          "-i", cfg.ifname,
> +                          "-m", "zc",
> +                          "--queue", str(cfg.queue),
> +                          "--peer-mac", cfg.remote_dev["address"]]
> +
> +        ksft_run([ksft_variants(cases)(test_xsk),
> +                  ksft_variants(cases)(test_xsk_busy_poll)], args=3D(cfg=
,))
> +
> +        xsk_release_hugepages(saved_hugepages)
> +        _unsteer_udp(cfg)
> +        ethtool(f"-X {cfg.ifname} default")

[Severity: Medium]
If an exception is raised earlier in main(), such as during _get_cases() or
other setup commands, will execution exit the function immediately and bypa=
ss
these cleanup calls?

Since this can leak system-wide configurations like hugepage allocations and
hardware NIC RSS/ntuple settings, would it make sense to protect the cleanup
sequence with a try...finally block?

> +    ksft_exit()
> +
> +
> +if __name__ =3D=3D "__main__":
> +    main()

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014184539.7747=
08-1-maciej.fijalkowski@intel.com?part=3D14
