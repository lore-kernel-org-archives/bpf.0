Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2F928466F;
	Sun,  3 May 2026 04:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777782584; cv=none; b=DtkM78afwC1Gc9Eg7twRuRLGi5s05i+/2va5K1x2I4qPTdN2NZwJsu+N9l6KokHxo4a6HvrWaD/HrgXOHuI4eVlkqYZJtnA8ZiXPBg+nV7ZeWI0FhGBTSL+LKEJY71VF4zNHNfaE4fqJFMFZ3bY/2YrehsnywszVguReVE+Xv74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777782584; c=relaxed/simple;
	bh=VofohV69jI0k846iHUVIdFXaRPq0r9hhV8hyN18Ny4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hC0OO2lPkJZya6OykC3B4pYd3P2zfTZJXxqtGzTJTxdxEuCTlb3KAwcJTrzz6XLxPioWVKrDrnLpvmXDyPEvmGykKhASnbso1PhqoK8ihIV8fH09NkkLYoKHynsMzKmtKFGXLceVl4il+Urk5i10l/Pr644u8h6ZaWG6rt/CCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kp410YlV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kp410YlV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=E7sh93hfbyoUNgV54jStbtEaFTy5U85h3CXi67TkmHE=; b=kp410YlV60EidwDd00OOExaMS5
	ZryRaT892yOpE8Jpd4pZPamvA//4Br+VMPodqPHbtaudeem5C0In2x3/TSo5jrLcVu4I4SLKN9Qzl
	/aQ1FGeN9dpn2RcowvkOl//s/8yInWfr0teqJdc9VxH1LDksuHvDeQbvBVFJVJWJ1ieUfA9bhh4bD
	AaP+um1SS96AQzV9TcS+xWNMB0P2bIW1rZhluc3fvsYx+I3K3V/kWT5j2ckOzH340HcrtOgqkI5YL
	TzAmmG+I0nLDoxJ1LIym1gTqZYPsxSUO+AIF+0utuE+5vkvftRWLucXDPxXYpiJEEFp5NwbSrCbXV
	4iviskwA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJOSP-0000000AK8H-2Nfv;
	Sun, 03 May 2026 04:29:29 +0000
Message-ID: <e456f0f0-5e49-4de4-9184-32ebc53cd0a1@infradead.org>
Date: Sat, 2 May 2026 21:29:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] bpf: introduce TAINT_UNSAFE_BPF for mutating helpers
To: Aaron Tomlin <atomlin@atomlin.com>, corbet@lwn.net, song@kernel.org,
 kpsingh@kernel.org, mattbobrowski@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, rostedt@goodmis.org, mhiramat@kernel.org
Cc: skhan@linuxfoundation.org, jolsa@kernel.org, martin.lau@linux.dev,
 yonghong.song@linux.dev, mathieu.desnoyers@efficios.com, neelx@suse.com,
 sean@ashe.io, chjohnst@gmail.com, steve@abita.co, mproche@gmail.com,
 nick.lange@gmail.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260503035220.520479-1-atomlin@atomlin.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260503035220.520479-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/2/26 8:52 PM, Aaron Tomlin wrote:
> The primary remit of the eBPF verifier is to ensure that eBPF programs
> can neither crash the kernel nor corrupt memory. Nevertheless,
> administrative utilities such as "bpftrace --unsafe" permit the loading
> of programs that employ destructive or mutating helpers, most notably
> bpf_probe_write_user() and bpf_override_return().
> 
> Since commit b28573ebfabe ("bpf: Remove bpf_probe_write_user() warning
> message"), the kernel no longer issues a warning when an attempt is made to
> invoke such destructive helpers.
> 
> Consequently, this patch introduces a novel kernel taint flag,
> TAINT_UNSAFE_BPF ("V"). Tainting the kernel establishes a permanent and
> readily auditable indicator (i.e., /proc/sys/kernel/tainted) to alert
> maintainers and that the kernel's execution flow or user memory may have
> been compromised by an eBPF program.
> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  Documentation/admin-guide/tainted-kernels.rst | 54 ++++++++++---------
>  include/linux/panic.h                         |  3 +-
>  kernel/panic.c                                |  1 +
>  kernel/trace/bpf_trace.c                      |  3 ++
>  4 files changed, 36 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> index 9ead927a37c0..630f24996e7b 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -79,30 +79,31 @@ which bits are set::
>  Table for decoding tainted state
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -===  ===  ======  ========================================================
> -Bit  Log  Number  Reason that got the kernel tainted
> -===  ===  ======  ========================================================
> -  0  G/P       1  proprietary module was loaded
> -  1  _/F       2  module was force loaded
> -  2  _/S       4  kernel running on an out of specification system
> -  3  _/R       8  module was force unloaded
> -  4  _/M      16  processor reported a Machine Check Exception (MCE)
> -  5  _/B      32  bad page referenced or some unexpected page flags
> -  6  _/U      64  taint requested by userspace application
> -  7  _/D     128  kernel died recently, i.e. there was an OOPS or BUG
> -  8  _/A     256  ACPI table overridden by user
> -  9  _/W     512  kernel issued warning
> - 10  _/C    1024  staging driver was loaded
> - 11  _/I    2048  workaround for bug in platform firmware applied
> - 12  _/O    4096  externally-built ("out-of-tree") module was loaded
> - 13  _/E    8192  unsigned module was loaded
> - 14  _/L   16384  soft lockup occurred
> - 15  _/K   32768  kernel has been live patched
> - 16  _/X   65536  auxiliary taint, defined for and used by distros
> - 17  _/T  131072  kernel was built with the struct randomization plugin
> - 18  _/N  262144  an in-kernel test has been run
> - 19  _/J  524288  userspace used a mutating debug operation in fwctl
> -===  ===  ======  ========================================================
> +===  ===   ======  ========================================================
> +Bit  Log   Number  Reason that got the kernel tainted
> +===  ===   ======  ========================================================
> +  0  G/P        1  proprietary module was loaded
> +  1  _/F        2  module was force loaded
> +  2  _/S        4  kernel running on an out of specification system
> +  3  _/R        8  module was force unloaded
> +  4  _/M       16  processor reported a Machine Check Exception (MCE)
> +  5  _/B       32  bad page referenced or some unexpected page flags
> +  6  _/U       64  taint requested by userspace application
> +  7  _/D      128  kernel died recently, i.e. there was an OOPS or BUG
> +  8  _/A      256  ACPI table overridden by user
> +  9  _/W      512  kernel issued warning
> + 10  _/C     1024  staging driver was loaded
> + 11  _/I     2048  workaround for bug in platform firmware applied
> + 12  _/O     4096  externally-built ("out-of-tree") module was loaded
> + 13  _/E     8192  unsigned module was loaded
> + 14  _/L    16384  soft lockup occurred
> + 15  _/K    32768  kernel has been live patched
> + 16  _/X    65536  auxiliary taint, defined for and used by distros
> + 17  _/T   131072  kernel was built with the struct randomization plugin
> + 18  _/N   262144  an in-kernel test has been run
> + 19  _/J   524288  userspace used a mutating debug operation in fwctl
> + 20  _/V  1048576  an unsafe eBPF program (mutating helper) was loaded
> +===  ===  =======  ========================================================
>  
>  Note: The character ``_`` is representing a blank in this table to make reading
>  easier.
> @@ -189,3 +190,8 @@ More detailed explanation for tainting
>   19) ``J`` if userspace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
>       to use the devices debugging features. Device debugging features could
>       cause the device to malfunction in undefined ways.
> +
> + 20) ``V`` if an eBPF program utilising unsafe, mutating helpers (such as
> +     bpf_probe_write_user() or bpf_override_return()) was loaded. These helpers
> +     bypass standard eBPF safety guarantees and can alter execution flow or
> +     corrupt memory.

(If this patch goes forward:)

In this same file (above), there is a little script around line 77 where
it should be changed:
s/20/21/

Also please update tools/debugging/kernel-chktaint for this taint flag.

-- 
~Randy

