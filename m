Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC076C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 00:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620542171F
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 00:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAU9Az45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbfB1AVM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 19:21:12 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45561 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730234AbfB1AVL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 19:21:11 -0500
Received: by mail-ot1-f68.google.com with SMTP id w26so2791601otp.12;
        Wed, 27 Feb 2019 16:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zs6ff59Rb6OF32nGMhHgWg9SU0+cViXit0LCMqtykLQ=;
        b=FAU9Az45JBtt4SAts9xAyUOPDhKDecN/cYoVC0qlHLM3j/jyt83MCzkTsvlqLg11Xx
         tDLA3ZbmJ6IHDMIueRm97JztjAAjP+d+zT/+PC3dsoFBpyRfjpyJ3JcnWWQUo55rypP/
         hBjcq28ZiZJ5mVqml11kt9SxaysBxa31BYd0cTnqrg9TEb+dDAvTYeSmj3xqGZg+YYEW
         xCALFk2/SCivM0yLN3bQB8KhBXoPUZL271C5ppe8HWHVeh3Gohqy7a/by/HlozeDj5WI
         5ounvxSz00+P4OwSCOaUW1dwHZ5UY/KEekvmE7a+AxpB/+qNqr3/kRjUbyPFJcqlSIDv
         MaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zs6ff59Rb6OF32nGMhHgWg9SU0+cViXit0LCMqtykLQ=;
        b=AV+msSfBv3JntkZqpZMFpUqRh9qrNMavopNZLjqWeAq6A2n5k4fejSgTzSkXyHxvP4
         9/JN764MkCr/jjVM4CoFAewcAGo69vJvJAeksROJ9Wfbzrba0h9PqbopwDXHcymZCL61
         1R0VK3Xl/itNGPzssxmuSRdi9jdbkXtU+f6tDtfZxpPl4a24o5m2MW234tYxV3/TQTWq
         fN2SpUAhSI2fo2ic7oZm2/F+4Pc2EFbVjb+s84bTIx+sxkEtkpNSnPRvOr/Ph20zhYr8
         bQf0SBNDWJ+9+R52ghRD3SJ0sQPaVUGgUdyljZq6x8wQC03fidYHGhdqNZaVy/Biox4D
         2wmw==
X-Gm-Message-State: AHQUAubMTWLlo5fVa1bo6pU0YhHwEKMUic3lHv87IzDs0/W+1VhHbZzP
        GUPtXGsCjHJ0wC4OHfkpVuZCAI/osbWnq2a8Bwg=
X-Google-Smtp-Source: AHgI3IaxEQ7ShEclDEp8axlkrnyT9RaS90JkfjsIwINLubnAXKRylMC5rWqIEpGZ9KpCFDN8p3UB7EDBUaZDetLtPMA=
X-Received: by 2002:a05:6830:149a:: with SMTP id s26mr4041026otq.206.1551313270362;
 Wed, 27 Feb 2019 16:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20190227233046.11718-1-jakub.kicinski@netronome.com> <20190227233046.11718-3-jakub.kicinski@netronome.com>
In-Reply-To: <20190227233046.11718-3-jakub.kicinski@netronome.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Feb 2019 16:20:58 -0800
Message-ID: <CAEf4BzZYa2tg6i5j2zodG5w27F+z9LCPgmnGrV5EbqAYoXyxCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] samples: bpf: remove load_sock_ops in favour
 of bpftool
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, oss-drivers@netronome.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 27, 2019 at 3:31 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> bpftool can do all the things load_sock_ops used to do, and more.
> Point users to bpftool instead of maintaining this sample utility.
>
> Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>

thanks!

Acked-by: Andrii Nakryiko <andriin@fb.com>

> ---
>  samples/bpf/.gitignore             |  1 -
>  samples/bpf/Makefile               |  2 -
>  samples/bpf/load_sock_ops.c        | 97 ------------------------------
>  samples/bpf/tcp_basertt_kern.c     |  2 +-
>  samples/bpf/tcp_bpf.readme         | 14 +++--
>  samples/bpf/tcp_bufs_kern.c        |  2 +-
>  samples/bpf/tcp_clamp_kern.c       |  2 +-
>  samples/bpf/tcp_cong_kern.c        |  2 +-
>  samples/bpf/tcp_iw_kern.c          |  2 +-
>  samples/bpf/tcp_rwnd_kern.c        |  2 +-
>  samples/bpf/tcp_synrto_kern.c      |  2 +-
>  samples/bpf/tcp_tos_reflect_kern.c |  2 +-
>  12 files changed, 16 insertions(+), 114 deletions(-)
>  delete mode 100644 samples/bpf/load_sock_ops.c
>
> diff --git a/samples/bpf/.gitignore b/samples/bpf/.gitignore
> index 8ae4940025f8..dbb817dbacfc 100644
> --- a/samples/bpf/.gitignore
> +++ b/samples/bpf/.gitignore
> @@ -1,7 +1,6 @@
>  cpustat
>  fds_example
>  lathist
> -load_sock_ops
>  lwt_len_hist
>  map_perf_test
>  offwaketime
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index a333e258f319..4dd98100678e 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -40,7 +40,6 @@ hostprogs-y += lwt_len_hist
>  hostprogs-y += xdp_tx_iptunnel
>  hostprogs-y += test_map_in_map
>  hostprogs-y += per_socket_stats_example
> -hostprogs-y += load_sock_ops
>  hostprogs-y += xdp_redirect
>  hostprogs-y += xdp_redirect_map
>  hostprogs-y += xdp_redirect_cpu
> @@ -71,7 +70,6 @@ tracex4-objs := bpf_load.o tracex4_user.o
>  tracex5-objs := bpf_load.o tracex5_user.o
>  tracex6-objs := bpf_load.o tracex6_user.o
>  tracex7-objs := bpf_load.o tracex7_user.o
> -load_sock_ops-objs := bpf_load.o load_sock_ops.o
>  test_probe_write_user-objs := bpf_load.o test_probe_write_user_user.o
>  trace_output-objs := bpf_load.o trace_output_user.o $(TRACE_HELPERS)
>  lathist-objs := bpf_load.o lathist_user.o
> diff --git a/samples/bpf/load_sock_ops.c b/samples/bpf/load_sock_ops.c
> deleted file mode 100644
> index 8ecb41ea0c03..000000000000
> --- a/samples/bpf/load_sock_ops.c
> +++ /dev/null
> @@ -1,97 +0,0 @@
> -/* Copyright (c) 2017 Facebook
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of version 2 of the GNU General Public
> - * License as published by the Free Software Foundation.
> - */
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <linux/bpf.h>
> -#include <bpf/bpf.h>
> -#include "bpf_load.h"
> -#include <unistd.h>
> -#include <errno.h>
> -#include <fcntl.h>
> -#include <linux/unistd.h>
> -
> -static void usage(char *pname)
> -{
> -       printf("USAGE:\n  %s [-l] <cg-path> <prog filename>\n", pname);
> -       printf("\tLoad and attach a sock_ops program to the specified "
> -              "cgroup\n");
> -       printf("\tIf \"-l\" is used, the program will continue to run\n");
> -       printf("\tprinting the BPF log buffer\n");
> -       printf("\tIf the specified filename does not end in \".o\", it\n");
> -       printf("\tappends \"_kern.o\" to the name\n");
> -       printf("\n");
> -       printf("  %s -r <cg-path>\n", pname);
> -       printf("\tDetaches the currently attached sock_ops program\n");
> -       printf("\tfrom the specified cgroup\n");
> -       printf("\n");
> -       exit(1);
> -}
> -
> -int main(int argc, char **argv)
> -{
> -       int logFlag = 0;
> -       int error = 0;
> -       char *cg_path;
> -       char fn[500];
> -       char *prog;
> -       int cg_fd;
> -
> -       if (argc < 3)
> -               usage(argv[0]);
> -
> -       if (!strcmp(argv[1], "-r")) {
> -               cg_path = argv[2];
> -               cg_fd = open(cg_path, O_DIRECTORY, O_RDONLY);
> -               error = bpf_prog_detach(cg_fd, BPF_CGROUP_SOCK_OPS);
> -               if (error) {
> -                       printf("ERROR: bpf_prog_detach: %d (%s)\n",
> -                              error, strerror(errno));
> -                       return 2;
> -               }
> -               return 0;
> -       } else if (!strcmp(argv[1], "-h")) {
> -               usage(argv[0]);
> -       } else if (!strcmp(argv[1], "-l")) {
> -               logFlag = 1;
> -               if (argc < 4)
> -                       usage(argv[0]);
> -       }
> -
> -       prog = argv[argc - 1];
> -       cg_path = argv[argc - 2];
> -       if (strlen(prog) > 480) {
> -               fprintf(stderr, "ERROR: program name too long (> 480 chars)\n");
> -               return 3;
> -       }
> -       cg_fd = open(cg_path, O_DIRECTORY, O_RDONLY);
> -
> -       if (!strcmp(prog + strlen(prog)-2, ".o"))
> -               strcpy(fn, prog);
> -       else
> -               sprintf(fn, "%s_kern.o", prog);
> -       if (logFlag)
> -               printf("loading bpf file:%s\n", fn);
> -       if (load_bpf_file(fn)) {
> -               printf("ERROR: load_bpf_file failed for: %s\n", fn);
> -               printf("%s", bpf_log_buf);
> -               return 4;
> -       }
> -       if (logFlag)
> -               printf("TCP BPF Loaded %s\n", fn);
> -
> -       error = bpf_prog_attach(prog_fd[0], cg_fd, BPF_CGROUP_SOCK_OPS, 0);
> -       if (error) {
> -               printf("ERROR: bpf_prog_attach: %d (%s)\n",
> -                      error, strerror(errno));
> -               return 5;
> -       } else if (logFlag) {
> -               read_trace_pipe();
> -       }
> -
> -       return error;
> -}
> diff --git a/samples/bpf/tcp_basertt_kern.c b/samples/bpf/tcp_basertt_kern.c
> index 4bf4fc597db9..6ef1625e8b2c 100644
> --- a/samples/bpf/tcp_basertt_kern.c
> +++ b/samples/bpf/tcp_basertt_kern.c
> @@ -7,7 +7,7 @@
>   * BPF program to set base_rtt to 80us when host is running TCP-NV and
>   * both hosts are in the same datacenter (as determined by IPv6 prefix).
>   *
> - * Use load_sock_ops to load this BPF program.
> + * Use "bpftool cgroup attach $cg sock_ops $prog" to load this BPF program.
>   */
>
>  #include <uapi/linux/bpf.h>
> diff --git a/samples/bpf/tcp_bpf.readme b/samples/bpf/tcp_bpf.readme
> index 831fb601e3c9..fee746621aec 100644
> --- a/samples/bpf/tcp_bpf.readme
> +++ b/samples/bpf/tcp_bpf.readme
> @@ -8,14 +8,16 @@ a cgroupv2 and attach a bash shell to the group.
>    bash
>    echo $$ >> /tmp/cgroupv2/foo/cgroup.procs
>
> -Anything that runs under this shell belongs to the foo cgroupv2 To load
> +Anything that runs under this shell belongs to the foo cgroupv2. To load
>  (attach) one of the tcp_*_kern.o programs:
>
> -  ./load_sock_ops -l /tmp/cgroupv2/foo tcp_basertt_kern.o
> +  bpftool prog load tcp_basertt_kern.o /sys/fs/bpf/tcp_prog
> +  bpftool cgroup attach /tmp/cgroupv2/foo sock_ops pinned /sys/fs/bpf/tcp_prog
> +  bpftool prog tracelog
>
> -If the "-l" flag is used, the load_sock_ops program will continue to run
> -printing the BPF log buffer. The tcp_*_kern.o programs use special print
> -functions to print logging information (if enabled by the ifdef).
> +"bpftool prog tracelog" will continue to run printing the BPF log buffer.
> +The tcp_*_kern.o programs use special print functions to print logging
> +information (if enabled by the ifdef).
>
>  If using netperf/netserver to create traffic, you need to run them under the
>  cgroupv2 to which the BPF programs are attached (i.e. under bash shell
> @@ -23,4 +25,4 @@ attached to the cgroupv2).
>
>  To remove (unattach) a socket_ops BPF program from a cgroupv2:
>
> -  ./load_sock_ops -r /tmp/cgroupv2/foo
> +  bpftool cgroup attach /tmp/cgroupv2/foo sock_ops pinned /sys/fs/bpf/tcp_prog
> diff --git a/samples/bpf/tcp_bufs_kern.c b/samples/bpf/tcp_bufs_kern.c
> index 0566b7fa38a1..e03e204739fa 100644
> --- a/samples/bpf/tcp_bufs_kern.c
> +++ b/samples/bpf/tcp_bufs_kern.c
> @@ -9,7 +9,7 @@
>   * doing appropriate checks that indicate the hosts are far enough
>   * away (i.e. large RTT).
>   *
> - * Use load_sock_ops to load this BPF program.
> + * Use "bpftool cgroup attach $cg sock_ops $prog" to load this BPF program.
>   */
>
>  #include <uapi/linux/bpf.h>
> diff --git a/samples/bpf/tcp_clamp_kern.c b/samples/bpf/tcp_clamp_kern.c
> index f4225c9d2c0c..a0dc2d254aca 100644
> --- a/samples/bpf/tcp_clamp_kern.c
> +++ b/samples/bpf/tcp_clamp_kern.c
> @@ -9,7 +9,7 @@
>   * the same datacenter. For his example, we assume they are within the same
>   * datacenter when the first 5.5 bytes of their IPv6 addresses are the same.
>   *
> - * Use load_sock_ops to load this BPF program.
> + * Use "bpftool cgroup attach $cg sock_ops $prog" to load this BPF program.
>   */
>
>  #include <uapi/linux/bpf.h>
> diff --git a/samples/bpf/tcp_cong_kern.c b/samples/bpf/tcp_cong_kern.c
> index ad0f1ba8206a..4fd3ca979a06 100644
> --- a/samples/bpf/tcp_cong_kern.c
> +++ b/samples/bpf/tcp_cong_kern.c
> @@ -7,7 +7,7 @@
>   * BPF program to set congestion control to dctcp when both hosts are
>   * in the same datacenter (as deteremined by IPv6 prefix).
>   *
> - * Use load_sock_ops to load this BPF program.
> + * Use "bpftool cgroup attach $cg sock_ops $prog" to load this BPF program.
>   */
>
>  #include <uapi/linux/bpf.h>
> diff --git a/samples/bpf/tcp_iw_kern.c b/samples/bpf/tcp_iw_kern.c
> index 4ca5ecc9f580..9b139ec69560 100644
> --- a/samples/bpf/tcp_iw_kern.c
> +++ b/samples/bpf/tcp_iw_kern.c
> @@ -9,7 +9,7 @@
>   * would usually be done after doing appropriate checks that indicate
>   * the hosts are far enough away (i.e. large RTT).
>   *
> - * Use load_sock_ops to load this BPF program.
> + * Use "bpftool cgroup attach $cg sock_ops $prog" to load this BPF program.
>   */
>
>  #include <uapi/linux/bpf.h>
> diff --git a/samples/bpf/tcp_rwnd_kern.c b/samples/bpf/tcp_rwnd_kern.c
> index 09ff65b40b31..cc71ee96e044 100644
> --- a/samples/bpf/tcp_rwnd_kern.c
> +++ b/samples/bpf/tcp_rwnd_kern.c
> @@ -8,7 +8,7 @@
>   * and the first 5.5 bytes of the IPv6 addresses are not the same (in this
>   * example that means both hosts are not the same datacenter).
>   *
> - * Use load_sock_ops to load this BPF program.
> + * Use "bpftool cgroup attach $cg sock_ops $prog" to load this BPF program.
>   */
>
>  #include <uapi/linux/bpf.h>
> diff --git a/samples/bpf/tcp_synrto_kern.c b/samples/bpf/tcp_synrto_kern.c
> index 232bb242823e..ca87ed34f896 100644
> --- a/samples/bpf/tcp_synrto_kern.c
> +++ b/samples/bpf/tcp_synrto_kern.c
> @@ -8,7 +8,7 @@
>   * and the first 5.5 bytes of the IPv6 addresses are the same (in this example
>   * that means both hosts are in the same datacenter).
>   *
> - * Use load_sock_ops to load this BPF program.
> + * Use "bpftool cgroup attach $cg sock_ops $prog" to load this BPF program.
>   */
>
>  #include <uapi/linux/bpf.h>
> diff --git a/samples/bpf/tcp_tos_reflect_kern.c b/samples/bpf/tcp_tos_reflect_kern.c
> index d51dab19eca6..de788be6f862 100644
> --- a/samples/bpf/tcp_tos_reflect_kern.c
> +++ b/samples/bpf/tcp_tos_reflect_kern.c
> @@ -4,7 +4,7 @@
>   *
>   * BPF program to automatically reflect TOS option from received syn packet
>   *
> - * Use load_sock_ops to load this BPF program.
> + * Use "bpftool cgroup attach $cg sock_ops $prog" to load this BPF program.
>   */
>
>  #include <uapi/linux/bpf.h>
> --
> 2.19.2
>
