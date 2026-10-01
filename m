Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766C37186A;
	Thu,  1 Oct 2026 23:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898705; cv=none; b=UJxIf6/dhKNNAvSLX3d6iP9CVUGT+GXofggUE3AUUtGXnRaR9beoUl0+FL9eY2DT8K3HhUUI7URZoqHQbr9vj77oKWnmUe18fcvWQGutacVM/CDpD9Bg2aVhRLebFd4KibgGA73CnQVGYDXE1eh02RsVz2Ix3xTo3FABfx9iEsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898705; c=relaxed/simple;
	bh=WHck0ywhjUCTTwLHuy3UbUs79vHRrk/zkdgVRW8gpJk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kfu7s4S9Z953ek3m/fylN9vsvGt6tP3wIIbH2RCheMlULOMtQBhSQ2UiPdL3pEskSCzflhHV9/3j5RMhWupE/F3f9eGcywq3l80YuasqvWvo5c7Gg+E6LNDceSoPFJXS7nxKsC0znkwc4wVx5exxClnjIEqg3yL5X41NI3PdBI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZZG0SGfO; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZZG0SGfO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790898704; x=1822434704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WeIYKnlOAtM1a/VlsYo+DHODN4ohW4AB0s+LwV2cQtc=;
  b=ZZG0SGfOOBHUV2rOwnDzNGSM1/P6+U/UDkSodlsqFNqoKd7mh9wCgACb
   ksKIdjHYTxNnWVlkb5xYct5wRil/zzZ3rLyZKJXHpCUNFRRBjhl61Y/z1
   T9BWwCw34vaajBuzGJVDLVj1fj3de2S4o3n+FkfIS56/UcC89yTrgLdB5
   q1/wIJ448QQrlXVMTxFOt6wJ2s5E2+COamc1IXda1t0fOX9TqgOS1ZYSg
   a1sVU3DgKknA2i5cdOdrocHkgw2d/bJk2mNtO3Jl0UkEtVG4Sqs/8lJTp
   itGSgLKHn5NJslZEbC4n396xTvvXo/C9NpbrNgP9hGd/xDkfTPx6wZPoP
   w==;
X-CSE-ConnectionGUID: +V7em1bASRCqqEzUPi6qOw==
X-CSE-MsgGUID: w6JY2dSrTKeGys10kAMEGg==
X-IronPort-AV: E=Sophos;i="6.27,135,1787011200"; 
   d="scan'208";a="29966697"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 23:51:44 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:30508]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.212:2525] with esmtp (Farcaster)
 id 3e7b6b1f-ed9e-48a1-bedd-7057438ca825; Thu, 1 Oct 2026 23:51:43 +0000 (UTC)
X-Farcaster-Flow-ID: 3e7b6b1f-ed9e-48a1-bedd-7057438ca825
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 23:51:43 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 23:51:43 +0000
From: Jay Wang <wanjay@amazon.com>
To: <alexei.starovoitov@gmail.com>
CC: <abuehaze@amazon.com>, <alan.maguire@oracle.com>, <andrii@kernel.org>,
	<arnd@arndb.de>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
	<doebel@amazon.de>, <eddyz87@gmail.com>, <jay.wang.upstream@gmail.com>,
	<jolsa@kernel.org>, <linux-kbuild@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-modules@vger.kernel.org>,
	<martin.lau@linux.dev>, <mcgrof@kernel.org>, <memxor@gmail.com>,
	<mpohlack@amazon.de>, <nathan@kernel.org>, <nsc@kernel.org>,
	<ojeda@kernel.org>, <petr.pavlu@suse.com>, <rust-for-linux@vger.kernel.org>,
	<samitolvanen@google.com>, <yonghong.song@linux.dev>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
	<linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 4/9] bpf: take the vmlinux BTF from the btf_vmlinux module
Date: Thu, 1 Oct 2026 23:51:42 +0000
Message-ID: <20261001235142.4626-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <DLP3USQDIMJG.1FUZXEXOX38TR@gmail.com>
References: <DLP3USQDIMJG.1FUZXEXOX38TR@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Sat, Sep 26, 2026 at 08:29:12AM +0000, Alexei Starovoitov wrote:
> On Fri, Sep 25, 2026 at 10:42 PM Jay Wang <wanjay@amazon.com> wrote:
> > +	if (!data && load) {
> > +		/*
> > +		 * The module notifier installs the BTF before init_module()
> > +		 * returns, so it is either there after this or the module is
> > +		 * not available (yet).  Not cached: a later call retries,
> > +		 * e.g. once the module becomes reachable on the root fs.
> > +		 */
> > +		request_module("btf_vmlinux");
>
> This will deadlock.
> event_btf_ids_read() calls btf_get_module_btf(NULL) with event_mutex
> held. With =m and BTF not loaded yet
>   cat /sys/kernel/tracing/events/sched/sched_switch/btf_ids
> gets here and waits for modprobe. modprobe gets to
> trace_module_notify() which takes event_mutex.
> lockdep doesn't see it.
>
> print_function_args() gets here for every line of the trace,
> from ftrace_dump() with irqs off too. When the module is not
> installed that is one modprobe per line.
>
> Every caller of bpf_get_btf_vmlinux() and bpf_find_btf_id() was
> written for a function that doesn't wait for user space.

Right.  Given that fixing those callers one by one does not work, as
there are too many and every new one would have to know, I went with a
different mechanism in v4:
https://lore.kernel.org/bpf/20261001225214.12351-1-wanjay@amazon.com/

In short, the lookups no longer load the BTF; only requests from user
space do, at their start.

The lookups cannot wait for the module, because they run in places that
must not sleep, or that hold locks the module load needs too: under
event_mutex in your btf_ids case, with interrupts off in ftrace_dump(),
inside a running BPF program.  Loading the module means waiting for
modprobe, so waiting in any of them can deadlock or sleep where it must
not.

Loading at the start of a request from user space is enough, because
that is where every need for the BTF begins: a program or map that uses
kernel types, a read of the BTF file, a probe event with BTF arguments.
At that point the request holds nothing yet, so it can safely wait for
modprobe.  And once it has loaded the BTF, the lookups it makes later
find it there, so they have no reason to wait.  Only the kernel's own
early users, the kfunc and struct_ops registrations at boot and the BTF
of modules loaded before it, come before any such request, and they are
queued until the BTF arrives.

With =m, bpf_get_btf_vmlinux() and bpf_find_btf_id() never load the
module and never sleep.  Until the BTF is loaded they fail as on a
kernel without BTF (NULL, -EINVAL), so every existing caller keeps the
assumptions it was written with.  The only function that loads the BTF
is a new bpf_load_btf_vmlinux(), called at the start of such a request,
with nothing held that loading a module needs:

 - on entry to the bpf() syscall: a BPF_PROG_LOAD, BPF_MAP_CREATE or
   BPF_BTF_LOAD that failed while the BTF was missing is run once more
   after loading it, the way tc and nf_tables retry after loading a
   module.  The verifier itself never waits, and bpf_sys_bpf() does not
   go through that entry;
 - BPF_BTF_GET_NEXT_ID with CAP_SYS_ADMIN, and loading a syscall
   program, since a light skeleton loader loads its programs while it
   runs;
 - read() of /sys/kernel/btf/vmlinux.  Not mmap(): it runs with the
   caller's mmap_lock held, and a uprobe registration holds event_mutex
   while it takes the mmap_lock of every mm mapping the probed file,
   which would close a loop through the module load.  mmap() fails
   until the BTF is loaded, and libbpf then falls back to read();
 - read() of the sysfs file of a module built against a distilled base
   (.BTF.base), through a work item: the reader holds the file's kernfs
   active reference, which MODULE_STATE_GOING drains with the module
   notifier chain held;
 - reading btf_ids (before event_mutex), creating probe events with BTF
   arguments (the parser holds only dyn_event_ops_mutex, which no module
   load takes), and mounting bpffs with delegate options that name
   commands or types.

print_function_args() only uses the BTF if it is already loaded and
never waits for it, so no modprobe per line.  Both of your cases now
work as the first BTF user after boot: the cat of btf_ids loads the BTF
before taking event_mutex and prints the ids, and func-args with sysrq-z
prints the functions without arguments, as on a kernel without BTF; the
arguments show up once a request from user space has loaded the BTF.

Jay
