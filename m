Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB2DEEA8
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776348330; cv=none; b=DuBP3WXNVFIAVb+YofesB4bYc+ei2sjzoyvPp1xgU9AJkEYcAXaSJ0c3KHalGiJ4udBCAcBnDk9eAibfQmS/BbKOBmkrIQRbe9yB1bHp2wxBOkZTxNyW5Cyl9jmpN48hut7DVYqEMI75KfR36qN8aq4IkQZ2TuSsJcn+sKbu+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776348330; c=relaxed/simple;
	bh=ztFfQr19wR0HwC7KfDcAstFQq6/mLpp2xa4htHN5zgk=;
	h=Message-ID:Date:MIME-Version:From:Subject:Cc:To:Content-Type; b=bwU+XkW3SvQEA47gALTU6A9PXuoh6nDJII/Vui7j0XOrnB80e4GlQyU8w6MTQ2z7n8ghRw89i+1tA1FM/xwGNcwIjTGtVdt4h4jkrPuzWgYZ0n1JUqF9r2yadh7FSNaTSXg6K2Kcy2giPY+Xk6a9Sja3ng4bAZom3P8eunJ7Zkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1wDNLI-0003we-Hp; Thu, 16 Apr 2026 16:05:16 +0200
Message-ID: <b63e9174-7a3d-4e22-8294-16df07a4af89@pengutronix.de>
Date: Thu, 16 Apr 2026 16:05:16 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jonas Rebmann <jre@pengutronix.de>
Subject: XDP BPF JIT memory leak on armv7
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
To: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Russell King
 <linux@armlinux.org.uk>, Puranjay Mohan <puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bpf@vger.kernel.org

Hello,

We have observed a memory leak when using the JIT on armv7 with XDP
programs in all kernels tested (6.1 to v7.0/master).

kmemleak reports:

unreferenced object 0xbf0a1000 (size 4096):
   comm "ping", pid 818, jiffies 4294949376
   hex dump (first 32 bytes):
     00 10 00 00 f1 de fd e7 f1 de fd e7 f1 de fd e7  ................
     f1 de fd e7 f1 de fd e7 f1 de fd e7 f1 de fd e7  ................
   backtrace (crc 38a5ba95):
     kmemleak_vmalloc+0x38/0x94
     __vmalloc_node_range_noprof+0x624/0x7e0
     execmem_alloc+0x7c/0x100
     bpf_jit_binary_alloc+0x64/0xfc
     bpf_int_jit_compile+0x14c/0x348
     bpf_jit_subprogs+0x4fc/0xa60
     bpf_check+0x1840/0x30e0
     bpf_prog_load+0x720/0xec4
     __sys_bpf+0x4cc/0x25d4
     ret_fast_syscall+0x0/0x54

This was reproduced on various debian systems:
  - stock debian sid with 6.19.12+deb14-armmp-lpae
  - stock debian 12 with 6.1.0-44-armmp-lpae

As well as debian sid with custom built kernels with a
multi_v7_defconfig based config, amongst versions tested: latest master,
(7.0.0-08391-g1d51b370a0f8), v7.0, v6.18, v6.8, v6.12.

Precise reproduction steps:
Enable the BPF JIT (if not done via CONFIG_BPF_JIT_ALWAYS_ON=y):
# sysctl -w net.core.bpf_jit_enable=1

Prepare any simple XDP program:
$ git clone https://github.com/xdp-project/xdp-tutorial.git
$ cd xdp-tutorial
# apt install git cmake build-essential xdp-tools clang pkg-config libelf-dev m4 libpcap-dev llvm libbpf-dev libxdp-dev
$ ln -s /usr/include/arm-linux-gnueabihf/gnu/stubs-hard.h /usr/include/arm-linux-gnueabihf/gnu/stubs-soft.h
$ ./configure
$ cd basic01-xdp-pass
$ make

Store /proc/vmallocinfo:
# cat /proc/vmallocinfo > /tmp/vmallocinfo-before

Load the program and confirm it is loaded, unload and confirm:
# ./xdp_pass_user -d lo
# xdp-loader status
lo                     xdp_prog_simple   skb      83   d4f8542f2b42fac5
# ./xdp_pass_user -d lo --unload-all
# xdp-loader status
lo                     <No XDP program loaded!>
  
Compare /proc/vmallocinfo:
# cat /proc/vmallocinfo > /tmp/vmallocinfo-after
# diff -u <(grep bpf_jit_binary_alloc /tmp/vmallocinfo-before) <(grep bpf_jit_binary_alloc /tmp/vmallocinfo-after)
+0x4e292a08-0xae3e49c0    8192 bpf_jit_binary_alloc+0x64/0xfc pages=1 vmalloc

# echo scan > /sys/kernel/debug/kmemleak
# cat /sys/kernel/debug/kmemleak
[see above]

The backtrace corresponds in commit 1d51b370a0f8 to

mm/kmemleak.c:596
mm/vmalloc.c:4093
mm/execmem.c:44
kernel/bpf/core.c:1093
arch/arm/net/bpf_jit_32.c:2241
kernel/bpf/fixups.c:1122
kernel/bpf/verifier.c:20099
kernel/bpf/syscall.c:3083
kernel/bpf/syscall.c:6252
arch/arm/kernel/entry-common.S:44

Each subsequent run introduces an additional leak.

Thanks,
Jonas
