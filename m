Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ABBC43219
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 18:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A305C20B7C
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 18:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8BnFqEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfDZShN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:37:13 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:36125 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfDZShM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Apr 2019 14:37:12 -0400
Received: by mail-qk1-f169.google.com with SMTP id m137so2492294qke.3
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2019 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=/lwAxIRHFf6YNLo2jgreZOlOK5l1XJuxHPZu/sO93J4=;
        b=h8BnFqEyucUVcaLAOs3RBrnPPg5sQIxFLyDjvXuZsnWWLlj/6FPQmDvA81Kbr0eBWC
         /79YAcCMvtrEnOxBar+EY+BLBWqYTmTo6MDFG3DT8nYJsDPbFTSKC28yST4JKbiYO+av
         IGgHuSbs57kjhBKQ/3YIEexIqAakGntqHDWtBBrGO+X7N6ep/ZBv0kx5WMKEmUAN08TF
         rg3rXVKAek9HAfcU1p9pneqc0pxODVZCD6kxnLFZH6sxs0YLo4IxoZ9e/nG8VAssEuZ2
         8k0m9WSztkPCk4qIvXaZBSSipg6zVdDnnAZkMYzNrMDeg8BIpTuGacOeJ7AEWPyiOTFu
         sfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=/lwAxIRHFf6YNLo2jgreZOlOK5l1XJuxHPZu/sO93J4=;
        b=GHOYPM0ij6Zr+TRemLnHk9iqWpoB3luuSbW2cKQ1RhxEfcdfkZ6Bi/VV9wn7+LNVmd
         +YYkPtDDrIoh7ebs5YNZJ0fCsmVtImJPTYLugeduE+rVEMQyJC9Q7Ur5hjc0wvOrMz5U
         OJ5CrSBxf08oXQGfPAseT5d/bByggu9im60nojCwJTOyrqvl0aSTh+KwYU+4YIfFVObi
         zFhpXa6AYnElSDoOoEV6cOCpgbI5lXzIzfqMYNbIyq2xiFapNl60I5Uwi1+m45bLNXmu
         7DqBc0YmjNzJc53vR2eBuHZ71KJphAQywoTEKPOn+x/g6wjszWWCP066gOYK2l5FwmPN
         Bqzg==
X-Gm-Message-State: APjAAAWsMDXu+9nYpWzd5dSH0aaLzg7ta9iBQXTpVaiDvUJezHU4FKJU
        vFUzxeckjPAQy2Q3hY9FLj+0R6hx
X-Google-Smtp-Source: APXvYqwiXLuwXIzlOGgSHYIBJi38xSPWQ6D2rD288qwmLIEHF7D/lxteDlLlzAqt66/0EUeuh1at1g==
X-Received: by 2002:ae9:ee15:: with SMTP id i21mr34020008qkg.107.1556303831252;
        Fri, 26 Apr 2019 11:37:11 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id f129sm12710898qkj.47.2019.04.26.11.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 11:37:10 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6145C4111F; Fri, 26 Apr 2019 15:37:07 -0300 (-03)
Date:   Fri, 26 Apr 2019 15:37:07 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org
Subject: perf BPF annotation output validation
Message-ID: <20190426183707.GE23426@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

tldr; more to the end there are some annotation for all sorts of cache level
misses trying to validate the 'perf annotation' output for disassembled
BPF programs.

[root@quaco ~]# uname -a
Linux quaco 5.1.0-rc5+ #4 SMP Wed Apr 17 19:33:00 -03 2019 x86_64 x86_64 x86_64 GNU/Linux

Running perf trace with:

[root@quaco ~]# cat ~/.perfconfig
[llvm]
	dump-obj = true
	clang-opt = -g
[trace]
	add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c
	#add_events = /wb/augmented_raw_syscalls.o
	show_zeros = yes
	show_duration = no
	no_inherit = yes
	show_timestamp = no
	show_arg_names = no
	args_alignment = 40
	show_prefix = yes

[annotate]

	hide_src_code = false
[root@quaco ~]#

clang/llvm 9:

[root@quaco perf]# eu-readelf -winfo /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o | grep compile_unit
 [     b]  compile_unit         abbrev: 1
[root@quaco perf]# eu-readelf -winfo /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o | grep compile_unit -B1 -A10
 Version: 4, Abbreviation section offset: 0, Address size: 8, Offset size: 4
 [     b]  compile_unit         abbrev: 1
           producer             (strp) "clang version 9.0.0 (https://git.llvm.org/git/clang.git/ 7906282d3afec5dfdc2b27943fd6c0309086c507) (https://git.llvm.org/git/llvm.git/ a1b5de1ff8ae8bc79dc8e86e1f82565229bd0500)"
           language             (data2) C99 (12)
           name                 (strp) "/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c"
           stmt_list            (sec_offset) 0
           comp_dir             (strp) "/root"
           low_pc               (addr) raw_syscalls:sys_enter+000000000000000000 <sys_enter>
           ranges               (sec_offset) range list [     0]
 [    2a]    variable             abbrev: 2
             name                 (strp) "__augmented_syscalls__"
             type                 (ref4) [    3f]
[root@quaco perf]#

I then leave  this running doing system wide syscall tracing using that
augmented_raw_syscalls.c eBPF program hooked into the syscall enter and
exit tracepoints, so that I have something to profile and further test
the BPF support in perf top/annotate/report (slides for LSFMM anyone?
:-)) then I get:

# perf trace -a sleep 100h
<SNIP>
tmux: server/11597 ioctl(8</dev/ptmx>, TIOCLINUX, 0x7ffe1b49abf8) = 0
tmux: server/11597 readv(8, 0x7ffe1b49ac00, 1)             = 101
tmux: server/11597 ioctl(8</dev/ptmx>, TIOCSPGRP, 0x7ffe1b49a9f4) = 0
tmux: server/11597 openat(AT_FDCWD, "/proc/30339/cmdline", O_RDONLY) = 5
tmux: server/11597 fstat(5, 0x7ffe1b49a8e0)                = 0
tmux: server/11597 read(5, 0x5571aaeb2c10, 1024)           = 10
tmux: server/11597 close(5)                                = 0
gnome-shell/19195  ... [continued]: ioctl())              = 0
tmux: server/11597 poll(0x5571aad38e50, 6, 11997)       ...
gnome-shell/19195 ioctl(11</dev/dri/card0>, DRM_MODE_RMFB, 0x7ffc2129c25c) = 0
gnome-shell/19195 recvmsg(39<socket:[18671390]>, 0x7ffc2129c440, NONE) = -1 EAGAIN (Resource temporarily unavailable)
<SNIP>

With that running, I do:

[root@quaco perf]# perf record -a sleep 2s
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 1.647 MB perf.data (3698 samples) ]
[root@quaco perf]# 

I.e. collect 2 seconds worth of CPU cycles samples, system wide.

[root@quaco perf]# perf record -a sleep 2s
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.328 MB perf.data (17764 samples) ]
[root@quaco perf]# perf report --header-only perf.data | grep -i b[pt]f
# event : name = cycles, , id = { 266608, 266609, 266610, 266611, 266612, 266613, 266614, 266615 }, size = 112, { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|CPU|PERIOD, read_format = ID, disabled = 1, inherit = 1, mmap = 1, comm = 1, freq = 1, task = 1, precise_ip = 3, sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1, ksymbol = 1, bpf_event = 1
# bpf_prog_info 13: bpf_prog_7be49e3934a125ba addr 0xffffffffc0437f01 size 229
# bpf_prog_info 14: bpf_prog_2a142ef67aaad174 addr 0xffffffffc04393cd size 229
# bpf_prog_info 17: bpf_prog_7be49e3934a125ba addr 0xffffffffc052ca3c size 229
# bpf_prog_info 18: bpf_prog_2a142ef67aaad174 addr 0xffffffffc0531218 size 229
# bpf_prog_info 21: bpf_prog_7be49e3934a125ba addr 0xffffffffc0cb8010 size 229
# bpf_prog_info 22: bpf_prog_2a142ef67aaad174 addr 0xffffffffc0cba8be size 229
# bpf_prog_info 65: bpf_prog_7be49e3934a125ba addr 0xffffffffc03f6bc2 size 229
# bpf_prog_info 66: bpf_prog_2a142ef67aaad174 addr 0xffffffffc03f87f6 size 229
# bpf_prog_info 125: bpf_prog_819967866022f1e1_sys_enter addr 0xffffffffc0c6e5a1 size 381
# bpf_prog_info 126: bpf_prog_c1bd85c092d6e4aa_sys_exit addr 0xffffffffc0c953a8 size 191
[root@quaco perf]# 

So everything seems in order, but then:

[root@quaco perf]# perf report | grep bpf_prog
     0.14%  perf             bpf_prog_c1bd85c092d6e4aa_sys_exit   [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
     0.08%  gnome-terminal-  bpf_prog_819967866022f1e1_sys_enter  [k] bpf_prog_819967866022f1e1_sys_enter
     0.06%  perf             bpf_prog_819967866022f1e1_sys_enter  [k] bpf_prog_819967866022f1e1_sys_enter
     0.04%  gnome-terminal-  bpf_prog_c1bd85c092d6e4aa_sys_exit   [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
     0.01%  alsa-sink-ALC25  bpf_prog_819967866022f1e1_sys_enter  [k] bpf_prog_819967866022f1e1_sys_enter
     0.01%  Web Content      bpf_prog_c1bd85c092d6e4aa_sys_exit   [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
     0.01%  lvmetad          bpf_prog_819967866022f1e1_sys_enter  [k] bpf_prog_819967866022f1e1_sys_enter
     0.00%  alsa-sink-ALC25  bpf_prog_c1bd85c092d6e4aa_sys_exit   [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
     0.00%  sssd_kcm         bpf_prog_c1bd85c092d6e4aa_sys_exit   [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
     0.00%  gnome-shell      bpf_prog_819967866022f1e1_sys_enter  [k] bpf_prog_819967866022f1e1_sys_enter
     0.00%  firefox          bpf_prog_c1bd85c092d6e4aa_sys_exit   [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
     0.00%  weechat          bpf_prog_c1bd85c092d6e4aa_sys_exit   [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
     0.00%  WebExtensions    bpf_prog_c1bd85c092d6e4aa_sys_exit   [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
     0.00%  Timer            bpf_prog_819967866022f1e1_sys_enter  [k] bpf_prog_819967866022f1e1_sys_enter
     0.00%  Web Content      bpf_prog_819967866022f1e1_sys_enter  [k] bpf_prog_819967866022f1e1_sys_enter
[root@quaco perf]#

Ok, lets check that bpf_prog_819967866022f1e1_sys_enter symbol, 38% of
the samples at just at that %rbp, more in a previous run...

[root@quaco perf]# perf annotate --stdio2 bpf_prog_819967866022f1e1_sys_enter
Samples: 25  of event 'cycles', 4000 Hz, Event count (approx.): 7248318, [percent: local period]
bpf_prog_819967866022f1e1_sys_enter() bpf_prog_819967866022f1e1_sys_enter
 38.00         push   %rbp
   
  2.72         mov    %rsp,%rbp
               sub    $0x170,%rsp
 13.19         sub    $0x28,%rbp
  3.30         mov    %rbx,0x0(%rbp)
 20.33         mov    %r13,0x8(%rbp)
               mov    %r14,0x10(%rbp)
               mov    %r15,0x18(%rbp)
               xor    %eax,%eax
               mov    %rax,0x20(%rbp)
               mov    %rdi,%rbx
 13.34       → callq  *ffffffffd359487f
               mov    %eax,-0x148(%rbp)

So I ended up trying with a event group to check what could be that:

[root@quaco perf]# perf record -a -e '{cycles,instructions,cache-misses}' sleep 2s
[ perf record: Woken up 18 times to write data ]
[ perf record: Captured and wrote 6.619 MB perf.data (91964 samples) ]
[root@quaco perf]# perf annotate --stdio2 bpf_prog_819967866022f1e1_sys_enter
Samples: 314  of events 'anon group { cycles, instructions, cache-misses }', 4000 Hz, Event count (approx.): 118106063, [percent: local period]
bpf_prog_819967866022f1e1_sys_enter() bpf_prog_819967866022f1e1_sys_enter
 20.88  24.58  49.11         push   %rbp

 47.37  31.62  26.71         mov    %rsp,%rbp
  1.16   0.00   0.00         sub    $0x170,%rsp
                             sub    $0x28,%rbp
  0.58   2.48   0.00         mov    %rbx,0x0(%rbp)
  7.10   5.92   0.00         mov    %r13,0x8(%rbp)
  0.51   0.96   7.96         mov    %r14,0x10(%rbp)
  0.00   1.10   0.00         mov    %r15,0x18(%rbp)
  0.58   0.00   0.00         xor    %eax,%eax
                             mov    %rax,0x20(%rbp)
  2.39   0.85   0.00         mov    %rdi,%rbx
  0.58   1.96   0.00       → callq  *ffffffffd359487f
                             mov    %eax,-0x148(%rbp)
  2.88   0.89   3.50         mov    %rbp,%rsi
                             add    $0xfffffffffffffeb8,%rsi

So seems ok? I.e. that big cost at right the start of the BPF program is
just cache pressure, probably, right?


[root@quaco perf]# perf record -a -e '{L1-icache-load-misses,L1-dcache-load-misses}' sleep 2s
[ perf record: Woken up 14 times to write data ]
[ perf record: Captured and wrote 5.557 MB perf.data (72026 samples) ]
[root@quaco perf]# perf annotate --stdio2 bpf_prog_819967866022f1e1_sys_enter
Samples: 376  of events 'anon group { L1-icache-load-misses, L1-dcache-load-misses }', 4000 Hz, Event count (approx.): 3715276, [percent: local p>
bpf_prog_819967866022f1e1_sys_enter() bpf_prog_819967866022f1e1_sys_enter
  1.54  63.01         push   %rbp
          
 53.09  28.13         mov    %rsp,%rbp      
  0.58   0.00         sub    $0x170,%rsp    
  0.00   0.55         sub    $0x28,%rbp     
  6.96   0.00         mov    %rbx,0x0(%rbp) 
 10.25   0.00         mov    %r13,0x8(%rbp) 
  0.73   0.00         mov    %r14,0x10(%rbp)
  3.04   0.00         mov    %r15,0x18(%rbp)

Looks like. furthermore:

[root@quaco perf]# perf record -a -e '{L1-icache-load-misses,L1-dcache-load-misses,dTLB-load-misses,iTLB-load-misses}' sleep 2s
[ perf record: Woken up 21 times to write data ]
[ perf record: Captured and wrote 7.708 MB perf.data (112323 samples) ]
[root@quaco perf]# perf annotate --stdio2 bpf_prog_819967866022f1e1_sys_enter
Samples: 391  of events 'anon group { L1-icache-load-misses, L1-dcache-load-misses, dTLB-load-misses, iTLB-load-misses }', 4000 Hz, Event count (>
bpf_prog_819967866022f1e1_sys_enter() bpf_prog_819967866022f1e1_sys_enter
  1.98  64.42 100.00  13.66         push   %rbp

 50.79  23.91   0.00  82.23         mov    %rsp,%rbp
                                    sub    $0x170,%rsp
  0.24   0.00   0.00   0.00         sub    $0x28,%rbp
  7.73   0.00   0.00   0.00         mov    %rbx,0x0(%rbp)
 11.13   0.44   0.00   0.00         mov    %r13,0x8(%rbp)
                                    mov    %r14,0x10(%rbp)
  1.64   0.46   0.00   0.00         mov    %r15,0x18(%rbp)

Do these numbers look sane to you guys?

Song, I also noticed that source code is not being intermixed for the
--stdio annotation, while it works, to some degree, for '--tui', i.e.
when you do 'perf top', press '/bpf' to show just symbols with that
substring and then press enter or 'A' to annotate, we can see the
original C source code for the BPF program, but it is mangling the
screen sometimes, I need to try and fix, please take a look if you have
the time.

Also things like the callq targets need some work to tell what function
is that, which as I said isn't appearing on the --stdio2 output, but
appears on the --tui, i.e. we need to resolve that symbol to check how
to map back to a BPF helper or any othe callq target.

Also, what about those 'je 0', i.e. the target is being misinterpreted
or is this some BPF construct I should've know about? :)

  2.68   0.00   0.00   0.00         mov    %rdi,%rbx                    
                                  → callq  *ffffffffd359487f            
                                    mov    %eax,-0x148(%rbp)            
  9.61   0.00   0.00   0.00         mov    %rbp,%rsi                    
                                    add    $0xfffffffffffffeb8,%rsi     
                                    movabs $0xffff9d556c776c00,%rdi
    
                                  → callq  *ffffffffd3595b2f            
                                    cmp    $0x0,%rax                    
                                  → je     0                            
  0.00   1.25   0.00   0.00         add    $0x38,%rax                   
  0.80   0.21   0.00   0.00         xor    %r13d,%r13d                  
                                    cmp    $0x0,%rax                    
                                  → jne    0                            
                                    mov    %rbp,%rdi                    
                                    add    $0xfffffffffffffeb8,%rdi

- Arnaldo
