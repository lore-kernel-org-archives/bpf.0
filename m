Received: from smtp237.sjtu.edu.cn (smtp237.sjtu.edu.cn [202.120.2.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA1A3C5522;
	Sun, 18 Oct 2026 07:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.120.2.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792309193; cv=none; b=IQGLEP8uh68X2z81ZZ/LeYchZzmXeML/ZqGR6UF8OWUkkYfH5uKbMLYtIu9zL7vDfF6jo9uDnGmA/M9pPmXzH07z9Lfi8t53zfc9o39qLe2Rx3Rczzd1kEuLLlZaChMjPmbQ3OzqjivM9VqXjf5pt8HSRz/TaP1ptxyaeHLSdYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792309193; c=relaxed/simple;
	bh=Dz9tX0xnI58F/51y6mC7vxWmidW4kAxLgoH2ScLmvVE=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=cu0JeT8FedUMg1khP2j5LVeR7+jw01XeiDCwVJUreMV9odf6kU4mqEYCG+L9VbESV9ZF10OFHn7g60PgRv18QELl9S6YTleF5b3FfMiiICnIodFJDWTJs7cmd9j9YbjecSFACPLfsbfKPpyBsxfykeVLM618eKiw/dp7q44woc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sjtu.edu.cn; spf=pass smtp.mailfrom=sjtu.edu.cn; dkim=pass (2048-bit key) header.d=sjtu.edu.cn header.i=@sjtu.edu.cn header.b=DVXhO/nB; arc=none smtp.client-ip=202.120.2.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sjtu.edu.cn header.i=@sjtu.edu.cn header.b="DVXhO/nB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
	s=default; t=1792308775;
	bh=Dz9tX0xnI58F/51y6mC7vxWmidW4kAxLgoH2ScLmvVE=;
	h=Date:From:To:Cc:Subject:From;
	b=DVXhO/nBY9PJfht9ThIEMoApMpgsYJGdYWt7gv/v84CISs+uiTM3TCOTr4v4gsg6m
	 nU84/AfN00H5Pf5GN7hFRxa989d8kagsSrLvKZJXuxCAYPC+niHixKi4gnGZFLdEP6
	 wVMSZz5l244zJmYuQUi1+Zoy9iqQEnpJNx7cUnt7c5eZTku9401P0c/cgQtEkpdNFl
	 lOeK93VClfzxW/J8oJWzlYUtnr4FwdwKK6jCHSde4C7wNuxS9z2LlXKB6d1WLJHCZ+
	 x4GKVpQlkRPqu63JabsiNllVM+PulwQ/Zdkm7J2AKGJ/ybEWpTf3MEi1fpGp1d6Zl6
	 tfhfcYinwOu6g==
Received: from mta90.sjtu.edu.cn (unknown [10.118.0.90])
	by smtp237.sjtu.edu.cn (Postfix) with ESMTPS id 155607FB26;
	Sun, 18 Oct 2026 15:32:55 +0800 (CST)
Received: from mstore132.sjtu.edu.cn (unknown [10.118.0.132])
	by mta90.sjtu.edu.cn (Postfix) with ESMTP id 4CA9B37C884;
	Sun, 18 Oct 2026 15:32:54 +0800 (CST)
Date: Sun, 18 Oct 2026 15:32:53 +0800 (CST)
From: tom2cat <tom2cat@sjtu.edu.cn>
To: bpf <bpf@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Message-ID: <1357745264.37808649.1792308773472.JavaMail.zimbra@sjtu.edu.cn>
Subject: WARNING in bpf_update_branch_counts - scc exit with global
 bpf_throw subprog in a loop
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 10.0.18_GA_4835 (ZimbraWebClient - GC155 (Win)/10.0.18_GA_4828)
Thread-Index: 1o/sSta58jFzkwTho8J/wFTBPpBkNQ==
Thread-Topic: WARNING in bpf_update_branch_counts - scc exit with global bpf_throw subprog in a loop

Hi BPF maintainers,

I'm reporting a kernel WARNING (verifier internal-invariant violation) I
encountered on the BPF subsystem. It reproduces on Linux 7.3.0-rc7
(ec8bf8280261), on a clean build with BTF enabled.

### Summary

A small TC program where a global subprog containing bpf_throw() is called
inside a bounded loop triggers:

    verifier bug: scc exit: no visit info for call chain (1)
    WARNING: kernel/bpf/states.c:208 at bpf_update_branch_counts+0x42e/0x5b0

The load fails with -EFAULT. It needs all three: a global
subprog, bpf_throw(), and a loop. It also
loads on 7.0.0-rc6. Tested as root with CAP_BPF.

### Steps to Reproduce

Build with clang-19 -target bpf -O2 -g and load with libbpf:

    #include "vmlinux.h"
    #include <bpf/bpf_helpers.h>

    extern void bpf_throw(u64 cookie) __ksym;

    __noinline int g(int x)
    {
        if (x == 0x80000000)
            bpf_throw((u64)x);
        return x + 1;
    }

    SEC("tc")
    int scc_min_throw(struct __sk_buff *ctx)
    {
        u32 n = ctx->len & 3;

        for (int i = 0; i < n; i++)
            g(0x80000000 + i);
        return 0;
    }

    char _license[] SEC("license") = "Dual BSD/GPL";

### Full dmesg

    [    5.525562] ------------[ cut here ]------------
    [    5.525575] verifier bug: scc exit: no visit info for call chain (1)
    [    5.525578] WARNING: kernel/bpf/states.c:208 at bpf_update_branch_counts+0x42e/0x5b0, CPU#11: kcov_probe/505
    [    5.525613] CPU: 11 UID: 0 PID: 505 Comm: kcov_probe Not tainted 7.3.0-rc7 #1 PREEMPT(lazy)
    [    5.525622] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
    [    5.525629] RIP: 0010:bpf_update_branch_counts+0x4a3/0x5b0
    [    5.525636] Code: 8b 64 24 08 49 8d 3c 04 b9 40 01 00 00 29 c1 48 63 f1 8b 8b ac d1 00 00 48 c7 c2 64 dd 7a bd e8 33 a9 00 01 4c 89 f7 4c 89 e6 <67> 48 0f b9 3a 4c 8d b3 88 08 00 00 66 c7 83 10 ce 00 00 28 00 b8
    [    5.525641] RSP: 0018:ffffa284412b7b00 EFLAGS: 00010246
    [    5.525650] RAX: 0000000000000002 RBX: ffff9be748bc0000 RCX: b6c3c1a83a765600
    [    5.525658] RDX: 0000000000000000 RSI: ffff9be748bcce10 RDI: ffffffffbe2eaf60
    [    5.525660] RBP: ffff9be748bc0000 R08: 0000000000000000 R09: 0000000000000031
    [    5.525663] R10: 0000000000000000 R11: 0000000000000007 R12: ffff9be748bcce10
    [    5.525666] R13: 0000000000000370 R14: ffffffffbe2eaf60 R15: ffff9be748bcd170
    [    5.525669] FS:  00007fc261ce7740(0000) GS:ffff9be7bf4a8000(0000) knlGS:0000000000000000
    [    5.525673] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [    5.525676] CR2: 0000555f70685b00 CR3: 000000000358c004 CR4: 0000000000170ef0
    [    5.525688] Call Trace:
    [    5.525715]  <TASK>
    [    5.525731]  ? check_func_call+0x62f/0x650
    [    5.525742]  do_check_common+0xe3c/0x13a0
    [    5.525752]  do_check_main+0x23/0x50
    [    5.525760]  bpf_check+0xd65/0xdd0
    [    5.525768]  bpf_prog_load+0x686/0x750
    [    5.525782]  __sys_bpf+0x5bc/0x7f0
    [    5.525793]  __x64_sys_bpf+0x29/0x40
    [    5.525799]  do_syscall_64+0x113/0x340
    [    5.525814]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
    [    5.525824] RIP: 0033:0x7fc261e089dd
    [    5.525829] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 23 b4 0f 00 f7 d8 64 89 01 48
    [    5.525833] RSP: 002b:00007ffdf6ccd428 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
    [    5.525838] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fc261e089dd
    [    5.525841] RDX: 00000000000000a8 RSI: 00007ffdf6ccd4b0 RDI: 0000000000000005
    [    5.525844] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000003
    [    5.525846] R10: 0000555f706e31e0 R11: 0000000000000246 R12: 0000000000000005
    [    5.525849] R13: 00000000000000a8 R14: 00007ffdf6ccd4b0 R15: 0000555f95a07e00
    [    5.525853]  </TASK>
    [    5.525855] ---[ end trace 0000000000000000 ]---

Please let me know if you need more information or if I can help test a patch.
