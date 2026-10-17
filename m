Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8073C73F6;
	Sat, 17 Oct 2026 03:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206370; cv=none; b=ia4q5ir7hzumW9H7Z2HfESaCG3NDfP+V0865eHIsDr6AA0wiYwTxnN4Xr2o2xch0IRRwg9OzHkt7g0j94Zv4s6C532Zxpnkb68XULro3e96jPTKX7d/3+h+6e6fQ6mfMAn7iX8WqV7XSei+vU1UYkvgAKPvtl79sSna7Qk4U5Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206370; c=relaxed/simple;
	bh=AUw+1NtLTA7CeXqAmeBtHsi7eI/b1IgayiudT34fyc0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PPHXxIi8uV6AviX1jUycopeEFYf7sYTca9FCNr3G0VZGP8LsAOkblacxWl/oDWgNTRctVwq8hUuhxT3YiWfhgVfxx33/gZLKM9Iy//jeivaKrcnU25oM2GlVzIDHavWumsiCkBTpcpDkMV4Oxsll/IzrILO1StfTDAJ5gkEODlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C25Hgr3i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C25Hgr3i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52801F000C4;
	Sat, 17 Oct 2026 03:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792206369;
	bh=1UR2uMcxoUGV1eupIgy115ywrado/CO7vkubrRnMp/M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=C25Hgr3iZ0bUn1I59e6yM7DXCfJukNRPKPQLuQz+aRxbiCPy6nNnFjH8CpSuCJgqj
	 izWa+yaC4kdNUWP9AiavCKjLBNBZHdKVlnw70DGLMpKrtSFozmHrP3O6lcb6z2eM0y
	 gBMw1Q33beDCr6oY9Dj5kpjt1PPygLH3bY1qmbAet8/DHK/JW1LxhxiHtAPeK51VM/
	 azVEGEnjFyKOKtvdjbz8c+Z0m57/wjQpuoYFfXRwuUfeeuAnA2njjFTidCMEAgaJw2
	 WYWtl8jYyd3HkCnjOybPRxg3MS23dir8KQpb7qDIe/5gIuKhi/FVRNJsVaDr7z3jd6
	 +uYfhZa3kNbUw==
Subject: Re: [PATCH v3 net-next 09/15] selftests: xsk: run one test case per
 xskxceiver invocation
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Sat, 17 Oct 2026 03:06:08 +0000
Message-ID: <179220636838.434549.10005960398517216064@kernel.org>
In-Reply-To: <20261014184539.774708-10-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-10-maciej.fijalkowski@intel.com>
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

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] test_xsk.py main()
  (tools/testing/selftests/net/test_xsk.py:123-136) raises…
- [Medium] The commit message says test_xsk.py "leaves those [UNALIGNED]
  cases out when it cannot reserve them".
- [Medium] xsk_reserve_hugepages() (lib/py/xsk.py:15-25) raises
  vm.nr_hugepages, which sizes the pool of the *default* huge page size.
- [Low] xsk_wait_endpoint_exit()
  (tools/testing/selftests/net/lib/py/xsk.py:44-58) kills xskxceiver…

--

selftests: xsk: run one test case per xskxceiver invocation

This replaces test_xsk.sh and xsk_prereqs.sh with test_xsk.py. The new
script runs xskxceiver once per mode and case, each on a fresh veth pair,
and reports every case as its own KTAP result. xskxceiver now requires -m
and -t and runs exactly one case, and the shared huge page, busy-poll and
endpoint wait helpers move to net/lib/py/xsk.py.

> diff --git a/tools/testing/selftests/net/lib/py/xsk.py b/tools/testing/selftests/net/lib/py/xsk.py
> new file mode 100644
> index 0000000000000..50985bcb5b80c
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/py/xsk.py
> @@ -0,0 +1,58 @@

[ ... ]

> +def xsk_reserve_hugepages(saved, host=None):
> +    """Raise vm.nr_hugepages on host to what the UNALIGNED cases need, and
> +    return whether it has that many. Add the count to restore to saved, a
> +    list for xsk_release_hugepages()."""
> +    have = int(cmd("sysctl -n vm.nr_hugepages", host=host).stdout)

[Severity: Medium]
What happens here when vm.nr_hugepages can't be read or written?

cmd() is called with the default fail=True. A non-zero exit from sysctl
raises CmdExitFailure, and a missing sysctl binary raises
FileNotFoundError from Popen.

main() calls this before ksft_run(), so nothing turns the exception into
a per-case result. The whole script dies with a traceback and prints no
KTAP plan.

This can happen with CONFIG_HUGETLB_PAGE=n (the net selftests config
doesn't enable it), with a read-only /proc/sys in a container, or when
procps isn't installed. The old test_xsk.sh ran in all of these setups.

The commit message says test_xsk.py:

    "leaves those cases out when it cannot reserve them"

Here, though, a failed reservation aborts every case, not only the
UNALIGNED ones. xskxceiver already handles missing huge pages by itself:

tools/testing/selftests/net/lib/xsk/test_xsk.c:detect_ifobj_caps() {
    ...
	if (hugepages_present())
		ifobj_set_cap(ifobj, XSK_CAP_UNALIGNED);
    ...
}

Should failures here be caught and treated as "no huge pages"?

> +    if have >= NR_HUGEPAGES:
> +        return True
> +    cmd(f"sysctl -qw vm.nr_hugepages={NR_HUGEPAGES}", host=host)

[Severity: Medium]
Does vm.nr_hugepages size the right pool for the UNALIGNED cases?

vm.nr_hugepages sets the pool for the default huge page size. The
UNALIGNED UMEM always asks for 2MB pages:

tools/testing/selftests/net/lib/xsk/test_xsk.c:thread_common_ops() {
    ...
	if (umem->unaligned_mode)
		mmap_flags |= MAP_HUGETLB | MAP_HUGE_2MB;
    ...
}

The xskxceiver probe passes MAP_HUGE_2MB as the mmap offset instead of in
the flags, so it actually checks the default-size pool:

tools/testing/selftests/net/lib/xsk/test_xsk.c:hugepages_present() {
    ...
	bufs = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, MAP_HUGE_2MB);
    ...
}

Before this patch nothing filled the default pool, so on a typical host
the probe failed and the UNALIGNED cases skipped.

Now the default pool is raised to 32. Take a setup where the default huge
page size is not 2MB, such as s390 (1MB), ppc64 hash (16MB) or arm64 with
a 16K granule (32MB). The probe passes and XSK_CAP_UNALIGNED is set. The
real MAP_HUGE_2MB mmap then fails with EINVAL or ENOMEM.

Would those cases now fail where they used to skip?

Larger default sizes are a second concern: x86 with default_hugepagesz=1G,
or arm64 with a 64K granule (512MB). There, nr_hugepages=32 also reserves
16-32GB for the run, and the UNALIGNED cases can't use any of it.

Is /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages the pool that
should be raised here?

> +    saved.append((host, have))
> +    got = int(cmd("sysctl -n vm.nr_hugepages", host=host).stdout)
> +    return got >= NR_HUGEPAGES

[ ... ]

> +def xsk_wait_endpoint_exit(endpoint, label, timeout):
> +    """Wait up to timeout seconds for xskxceiver to exit, kill it if it does
> +    not, and return its exit code. Log its output, a KTAP stream of its own,
> +    prefixed with label, only if it did not pass."""
> +    try:
> +        endpoint.process(terminate=False, fail=False, timeout=timeout)
> +    except subprocess.TimeoutExpired:
> +        endpoint.proc.kill()

[Severity: Low]
Can xskxceiver be left running when something other than TimeoutExpired
interrupts this wait?

ksft_run() installs a SIGTERM handler that raises KsftTerminate:

tools/testing/selftests/net/lib/py/ksft.py:_ksft_intr() {
    ...
    if term_cnt == 1:
        raise KsftTerminate()
    ...
}

During a case, the main thread is almost always blocked in
endpoint.process() here. If the runner sends SIGTERM to the Python
process, KsftTerminate passes through this function and the child is
never killed.

ksft_run() then runs the deferred "ip link del". That removes the veth
pair while xskxceiver still has its sockets and XDP program bound, and
the script exits with the child orphaned.

The child is started by _start() with cmd(background=True). The bkg()
context manager would terminate it on any exception.

Would a try/finally, or bkg(), be a better fit here?

> +        endpoint.process(terminate=False, fail=False)
> +        ksft_pr(f"killed after {timeout}s", line_pfx=f"{label}|")

[ ... ]

> diff --git a/tools/testing/selftests/net/test_xsk.py b/tools/testing/selftests/net/test_xsk.py
> new file mode 100755
> index 0000000000000..acfdba55fbae8
> --- /dev/null
> +++ b/tools/testing/selftests/net/test_xsk.py
> @@ -0,0 +1,140 @@

[ ... ]

> +def main():
> +    # ksft_run() exits on -l and -h before main() restores the huge pages.
> +    if "-l" in sys.argv or "-h" in sys.argv:
> +        sys.exit(f"{sys.argv[0]}: -l and -h are not supported")
> +    if not XSK_BIN.exists():
> +        print(f"1..0 # SKIP {XSK_BIN} was not built")
> +        sys.exit(SKIP_CODE)
> +    saved_hugepages = []
> +    hugepages = xsk_reserve_hugepages(saved_hugepages)
> +    cases = _get_cases(hugepages)
> +    ksft_run([ksft_variants(cases)(test_xsk),
> +              ksft_variants(cases)(test_xsk_busy_poll)])
> +    xsk_release_hugepages(saved_hugepages)

[Severity: Medium]
Is the huge page count restored on every exit path?

The commit message says test_xsk.py "restores the count when it ends" and
that "ksft_run() exits on -l and -h before the count is restored, so
test_xsk.py rejects both".

The argv check only matches the exact tokens "-l" and "-h". Also,
xsk_release_hugepages() is not in a finally block. That leaves several
paths that exit after the sysctl has been raised.

Any unknown option makes _KsftArgs exit. That includes --help and the old
test_xsk.sh options -m, -v and -d:

tools/testing/selftests/net/lib/py/ksft.py:_KsftArgs.__init__() {
    ...
        try:
            opts, _ = getopt.getopt(sys.argv[1:], 'hlt:T:')
        except getopt.GetoptError as e:
            print(e, file=sys.stderr)
            sys.exit(1)
    ...
}

getopt also accepts grouped short options, so -lt 'test_xsk.drv_*' or -hl
gets past the argv check. It then reaches the sys.exit(0) for -h in
_KsftArgs, or this one in _ksft_generate_test_cases():

    if cli_args.list_tests:
        for _, _, name in test_cases:
            print(name)
        sys.exit(0)

_get_cases() also runs "xskxceiver -l" through cmd() with fail=True. A
CmdExitFailure there, or a Ctrl-C before ksft_run(), escapes main() the
same way.

In each case the raised vm.nr_hugepages stays on the host after the
script exits.

SystemExit is an exception, so a try/finally around everything after
xsk_reserve_hugepages() would cover all of these paths, plain -l and -h
included. Would that remove the need to reject -l and -h at all?

> +    ksft_exit()

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014184539.774708-1-maciej.fijalkowski%40intel.com
