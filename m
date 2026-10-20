Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524627;
	b=CLPnZFyntw+9wiMzEWEeh6KwBxEcGyQ4k8hlOGFG9Td3aKPZ1SyB8nOc7HrJRyMtUKE0
	 7YuGGYNknvMkDyHKL9WdecyZEY38Q9qcjszk5kXnlstcge+VLsTBv4hyZWCn0+lDcedV5
	 yl0N6ylOm4I6rcHlM84mh5hY7TkM5ZnGvq+gi5TzMUdBgGeyTVJulZwLlTcF3ZaBTHuD3
	 VCxiKKQV4eszu+a9FlvpX+vtUcBXAWIV3Jd1kmcAV8ULRsH1mDk93R2p4N/Ky+rzPLihq
	 cOmdjfQyrMruyjwK+AFKTyzwSQxyHo2MwDKsVCMGKIdWHYmhX9Y/+hsdsWLSlYd3oVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524627;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=KSeUcvYUjSwsww34n8o7HdXqLU0bLoM+ufR8PXL12y8=;
	b=5hOBgIa29g7Yu8t09LRBLBxC3o6s0UZxIOkcaqXyw2yujndMpsnwjIdGMd+nAfHhPaHw
	 GawaqkFlm9prbQuIP0Uq9d3RueKDAktAXrvO4WOImI3Tv3/BDOflLYINwtS8/Gsu61ZCF
	 BPtVJRoX6JoKLn7wwFVL31Oo9Kpt4aLxJALkOf/kuiD4nqt5owMukZtm69PELBDF0rg5f
	 XV7xGEjlg/pWmiosMSHl0x8BSOjkzYpZ1u+LKKI8JhaBQgWtKdHrC7ywuYKy8sDkzG8Um
	 UvIzE+LIw+7UpZ/iQMMsnNiq7IvOobxrTBcG84iTMZgkByLpNDEYZ7LobWewQIa9nMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAeLnyPy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D78606A322;
	Tue, 20 Oct 2026 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAeLnyPy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EBB1F000CE;
	Tue, 20 Oct 2026 19:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792524626;
	bh=KSeUcvYUjSwsww34n8o7HdXqLU0bLoM+ufR8PXL12y8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JAeLnyPyB6jABg2Y16IolXFwqhIFPwWIJRyPK/1woNixgG3DFtV+hdVddTuClialv
	 xbm8ppWAY3xNJHi/9iHtD1UPRkHCycxTdl5ICzaglY7YSju6bPURo+j4w7u5Np8YLb
	 GaCAISgXVAgVozkqA6kzg2utb412SSzRg6ZjLAu76DECG3Nh13ydLBC5Hqw48Nu0yW
	 RIcNmkfpX1PMnL1R5Jxh2Ppf/Pqw1va9kJy+qDDJChV8+3p1f2+tbhu+WmkjkNPtn1
	 3sqFot52DEzNMWWyXD5+GKLWNtY0ezLcfYmq7qW6L6wXf/QTPIl4QlLrRa69870Bjg
	 MDU8pGFjCj/5g==
Subject: Re: [PATCH v4 net-next 09/15] selftests: xsk: run one test case per
 xskxceiver invocation
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Tue, 20 Oct 2026 19:30:25 +0000
Message-ID: <179252462533.3135.3442908149115698082@kernel.org>
In-Reply-To: <20261016174338.787135-10-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-10-maciej.fijalkowski@intel.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] test_xsk.py reserves the 2 MiB pool only
  (/sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages), on the…
- [Low] In xsk_wait_endpoint_exit()
  (tools/testing/selftests/net/lib/py/xsk.py), the TimeoutExpired…
- [Low] Concern: xsk_reserve_hugepages()/xsk_release_hugepages() read,
  modify and restore the global 2 MiB nr_hugepages with no protection…

--

selftests: xsk: run one test case per xskxceiver invocation

This replaces test_xsk.sh and xsk_prereqs.sh with test_xsk.py, which runs
xskxceiver once per mode and case on a fresh veth pair. It moves the huge
page, busy-poll and endpoint wait helpers into net/lib/py/xsk.py.
xskxceiver now requires -m and -t and runs exactly one case.

> diff --git a/tools/testing/selftests/net/lib/py/xsk.py b/tools/testing/selftests/net/lib/py/xsk.py
> new file mode 100644
> index 0000000000000..ffaf4b2d35b9d
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/py/xsk.py
> @@ -0,0 +1,73 @@

[ ... ]

> +NR_HUGEPAGES = 32
> +# xskxceiver maps the UMEMs of the UNALIGNED cases with MAP_HUGE_2MB.
> +HUGEPAGES = "/sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages"

[Severity: Medium]
This comment, and the commit message line "test_xsk.py reserves 32 huge
pages of 2 MiB, the size that xskxceiver maps the UNALIGNED UMEMs with",
hold for thread_common_ops(). Do they also hold for the probe that decides
whether the UNALIGNED cases can run?

hugepages_present() in lib/xsk/test_xsk.c does:

	bufs = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, MAP_HUGE_2MB);

Here MAP_HUGE_2MB goes in as the offset and is not OR-ed into the flags.
That leaves no size bits in flags, so the kernel uses the default hstate.

Take a host booted with default_hugepagesz=1G, or arm64 with 64K pages.
The probe checks the wrong pool there. The 0x54000000 offset is also not
aligned to the default huge page size, so the mmap fails with -EINVAL.

On such a host the sequence is:

  xsk_reserve_hugepages() fills the 2 MiB pool and returns True
  _get_cases() keeps the UNALIGNED cases
  detect_ifobj_caps()->hugepages_present() fails
  XSK_CAP_UNALIGNED stays clear
  testapp_validate_traffic() prints "No huge pages present." and skips

Every UNALIGNED case then skips, even though the 2 MiB pages were reserved.
The docstring says these cases are left out only without huge pages.

The probe was already wrong before this patch, but this patch is the first
to rely on xskxceiver using the 2 MiB pool. Should hugepages_present() put
MAP_HUGE_2MB in the flags, the way thread_common_ops() does?

> +
> +
> +def xsk_reserve_hugepages(saved, host=None):

[ ... ]

> +    have = cmd(f"cat {HUGEPAGES}", fail=False, host=host)
> +    if have.ret:
> +        return False
> +    have = int(have.stdout)
> +    if have >= NR_HUGEPAGES:
> +        return True
> +    saved.append((host, have))
> +    cmd(f"echo {NR_HUGEPAGES} > {HUGEPAGES}", shell=True, fail=False,
> +        host=host)

[ ... ]

> +def xsk_release_hugepages(saved):
> +    """Restore the counts that xsk_reserve_hugepages() added to saved, the
> +    last one first, as two hosts can share the pool."""
> +    for host, have in reversed(saved):
> +        cmd(f"echo {have} > {HUGEPAGES}", shell=True, fail=False, host=host)

[Severity: Low]
This probably isn't a problem in practice. The kselftest runner runs tests
one at a time, and saving and restoring nr_hugepages is the usual pattern
(mm's run_vmtests.sh does the same).

Still, the 2 MiB nr_hugepages count is global, and it is read, changed and
restored here with no coordination. If something else on the host changes
it during the run, would this restore overwrite that change?

[ ... ]

> +def xsk_wait_endpoint_exit(endpoint, label, timeout):

[ ... ]

> +    try:
> +        endpoint.process(terminate=False, fail=False, timeout=timeout)
> +    except subprocess.TimeoutExpired:
> +        endpoint.proc.kill()
> +        endpoint.process(terminate=False, fail=False)

[Severity: Low]
Can this second process() call time out too? That could happen if
xskxceiver is in uninterruptible sleep, for example blocked in the kernel on
a hung page_pool or XDP teardown, so the SIGKILL does not take effect.

cmd.process() defaults to timeout=20, so this is another bounded
proc.communicate(timeout=20). A TimeoutExpired raised inside this handler
is not caught by the except BaseException clause next to it.

The exception would then escape without the "killed after" log, without the
captured stdout and stderr, and with the child left unreaped. ksft_run()
would mark the case failed with a traceback.

The case would also take about 2 x CASE_TIMEOUT. The commit message says:

    A case is killed and fails after 20s, so that the run ends within
    the net timeout even if all cases hang.

> +        ksft_pr(f"killed after {timeout}s", line_pfx=f"{label}|")
> +    except BaseException:
> +        endpoint.proc.kill()
> +        endpoint.proc.wait()
> +        raise

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016174338.787135-1-maciej.fijalkowski%40intel.com
