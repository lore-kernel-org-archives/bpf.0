Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF51456296;
	Fri, 25 Sep 2026 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790371403; cv=none; b=OU0F1nu2RGk9AgiMkvOfAWIbGM6gEM8u+1VqEWPlOlL6HbtuZpzPWfbHtDWyg5vhLeeAU3AeY4r5qRlkqbj/HWPPYf5i0W56U5EIeVwprYRL29Uu8fuB3oFsSKm0ZAZZxGamUy0geaikgkm8JNOcIwOJsoeh7c50oVt5NKWCZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790371403; c=relaxed/simple;
	bh=HerTneftuhQfAknI9R2FicxbJNpDAGXWHHvZw49HstY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5P1N3iRzb8VxuMQekfV0Rzd+0xutV4ZJi9dO9CqTMoJgkPxCYA+hpiE08kEIe6GIw8ADVfnCPGOq+bnxBg0f0GxpElcQFt9C/jZPbMl+aBahNhRBQnxNlh9GpU9qyRgVVv0w36g/3igCOza0/5e5hk8wY9UaOqJ1rbknT1O5y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZMfZCLmV; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZMfZCLmV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790371401; x=1821907401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DMNrHieUH4/OcqJVLdfiVHAW2UU4cQkS2bASkWEaKxY=;
  b=ZMfZCLmVKZFbthA0aR9kpOc6xCIq+0jpiRBLC8fVeuDsMzB9W1iyNPqD
   cGfIZ/LqPldNczzz11PNY6pW7Wpf1Q0Pk0YCJDglNz1ZRy8t/HoIq2jMx
   P4Gv9ff/1msCnGJJevOTnLJS5/+3m59d9pE+38xFxyHBD72iWS2iFCs85
   maPI5L4UGYJVVrjdhKJxKp4ALowQaTwmwdl9m72ShxZ/t3W5L3qDxv5qf
   OB7BmV7OUBcJOdAGoxRaDlvDkyQYqLskGBbH2fd1LWBTqq0kPWMxZE8LM
   GGqBYVEU32VqB0TN7gMxguwWrdyu9zrM1ZWfOMYEOTWBT/f++nJezS1oR
   Q==;
X-CSE-ConnectionGUID: CY6CyhnDSwC+dDMmh9ZlrQ==
X-CSE-MsgGUID: pfrxjD44RRigskAFze2eqw==
X-IronPort-AV: E=Sophos;i="6.27,123,1787011200"; 
   d="scan'208";a="29577426"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 21:23:21 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:18344]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.144:2525] with esmtp (Farcaster)
 id da323cf6-d9e1-457c-95b6-0d78905d856b; Fri, 25 Sep 2026 21:23:21 +0000 (UTC)
X-Farcaster-Flow-ID: da323cf6-d9e1-457c-95b6-0d78905d856b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 21:23:20 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 21:23:20 +0000
From: Jay Wang <wanjay@amazon.com>
To: Alan Maguire <alan.maguire@oracle.com>, <bpf@vger.kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>
CC: Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song
	<yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor
	<nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	<linux-kbuild@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, "Petr
 Pavlu" <petr.pavlu@suse.com>, <linux-modules@vger.kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, <linux-kernel@vger.kernel.org>, Hazem Mohamed Abuelfotoh
	<abuehaze@amazon.com>, Bjoern Doebel <doebel@amazon.de>,
	<jay.wang.upstream@gmail.com>
Subject: Re: [PATCH bpf-next 0/6] bpf: make the vmlinux BTF an on-demand loadable module (CONFIG_DEBUG_INFO_BTF=m) to save ~5.4 MB memory
Date: Fri, 25 Sep 2026 21:23:19 +0000
Message-ID: <20260925212319.25401-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <9cf62f86-0b7d-4175-8334-74493ea3b04c@oracle.com>
References: <9cf62f86-0b7d-4175-8334-74493ea3b04c@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Thanks for the review, Alan.  v2 is out and addresses these:
https://lore.kernel.org/bpf/20260925211314.5118-1-wanjay@amazon.com/

Answers inline.

> I have a question about the approach here; my experience with using sysfs
> with a dummy placeholder file which triggered on-demand module load when
> accessed was it didn't work with sysfs interfaces because the file size needed
> to be refreshed, and the reader would usually error out since it saw an
> empty file and gave up reading. I wound up having to switch to using
> kernfs to update size attributes on open such that the caller would see the
> size change synchronously once the load completed. See patch 15 in the above
> series for the details.
>
> It seems like you used a different approach here, and by storing the size
> in the BTF metadata this problem was avoided. From the below it seems like
> there are no first-caller issues from userspace (like if the first caller
> does "bpftool btf dump file /sys/kernel/btf/vmlinux")?

Right, that is the reason for .BTF.meta: the size is known at build time,
so the file is created with its final size at boot and the load happens
in read()/mmap().  No kernfs internals, no i_size update.

I have now tested exactly that with the in-tree bpftool (libbpf 1.8) as
the first user on a fresh boot, nothing else having touched the BTF:

  bpftool btf dump file /sys/kernel/btf/vmlinux
  bpftool btf list

Both work and lsmod shows btf_vmlinux afterwards.  Same for libbpf-loaded
programs as the first user: a global subprogram taking the context,
bpf_snprintf_btf(), a CO-RE field read, and a kfunc of an out-of-tree
module (below).

> Another issue; during boot, request_module can call back out to modprobe
> and depending on where you are in the boot process, the module may not be
> available due to filesystem not mounted yet etc. Maybe this just means that
> btf_vmlinux.ko needs to be in the initramfs image? If that's the case, I
> would suggest highlighting that in the CONFIG_DEBUG_INFO_BTF Kconfig description,

Yes.  If request_module() fails the caller gets NULL, i.e. behaves as on a
kernel without BTF, and the next user retries; nothing is cached.  So a
program that needs kernel types before the root fs is mounted fails
unless btf_vmlinux.ko is in the initramfs.  I have added a paragraph
along the lines you suggest to the Kconfig help in v2.

> Another concern to balance; embedded folks were interested in vmlinux
> BTF as a module to limit on-disk footprint rather than (or likely as
> well as) runtime memory; [...] If I'm following, the final vmlinux image that winds
> up on disk doesn't contain the BTF section, right? If so that's great
> news for them.

Right.  With =m v2 strips the BTF from vmlinux, so no boot image carries
it; it only lives in btf_vmlinux.ko, which a system can also choose not
to install.

> And another thing I was wondering about - did you test with modules
> containing a .BTF.base (built standalone via "make -C path2module")?

Not in v1, thanks for asking.  Looking at that case showed a problem,
fixed in v2: for a module with .BTF.base the raw .BTF is only valid
against the distilled base and is rewritten in place when it is
relocated, so it must not be served before that.  In v2 the sysfs file
of such a module is still created at load time with its final size (the
relocation only rewrites ids and string offsets), but its reader loads
the vmlinux BTF and waits until this module's BTF is relocated and
published before serving it; modules without .BTF.base, whose data is
final, are served as before.

Tested with an out-of-tree module that has a .BTF.base and registers a
kfunc from its init, loaded before the vmlinux BTF: once the BTF is
loaded it gets its id, relocated types and its kfunc, and a program
calling that kfunc works.

> What I meant by the hard part (aside from deferred handling which is hard
> enough!) is that there is a conflict between the goal of saving memory and being
> forced to allocate memory for module BTF for a deferred-load scheme like this.
> [...]
> CONFIG_DEBUG_INFO_BTF=y results in upfront allocation of memory for kernel and module BTF
> CONFIG_DEBUG_INFO_BTF=m results in upfront allocation of memory for module BTF only

Agreed, and v2 says so explicitly in the Kconfig help and the cover
letter: the copy kept for a deferred module is the same copy
btf_parse_module() makes with =y, so module BTF costs the same at the same
time in both; the saving is the vmlinux BTF only.

> It might be worth thinking about providing a means to control whether such
> module allocations happen prior to vmlinux BTF loading for highly memory-constrained
> systems. Anything delivering kfuncs etc should probably always allocate since it
> constitutes core BPF infrastructure.

Makes sense as a follow-up; I would rather not grow this series with it.
The distinction you draw (keep it for modules that register kfuncs or
struct_ops, make it optional otherwise) is what I would start from.

Thanks,
Jay
