Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBD2C00319
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 00:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D9B218A5
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 00:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0ljDKkF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbfB1AF6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 19:05:58 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34231 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbfB1AF6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 19:05:58 -0500
Received: by mail-oi1-f195.google.com with SMTP id g16so15085214oib.1;
        Wed, 27 Feb 2019 16:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5T/bgPS6/VeDJ53qPYrDIVVEdZmzXJfSdMGuzdy9r50=;
        b=j0ljDKkFGbMdj2AEfD9Q3OTmOB6Da9aIsqFbCsrdMCb/328A5dkVCkI9TFqWK111qw
         kRlOr5GQjfiEx31kHRImwYI+xYg+MKBRxpGjvCQLm2PNx9OYavsZNV831+eeC2jJZ5EF
         K646PhALhwOQU8vaQfd58x2tairGWsycmrrbnfRUHoNoaTGEB3TfIVWGzvZiloWFTnNv
         Xe0L3ijTqaX6EjRaEgGEwzr3rlXbCmWQnS5uzmm4zN+CcJvvNHofbqWCxf6cjRSS4cAI
         jplyvyR9Zy/AJr/vf8V8sXsr6lYNX9IbLo4FVwOQFsinReq0e9bzdyj/JyEL0+ANgFp1
         2kDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5T/bgPS6/VeDJ53qPYrDIVVEdZmzXJfSdMGuzdy9r50=;
        b=ELc2DHvziS3NROALtpvNf2R2cb2EHHzocQ7bVePOOLTY8yOsgotVr+m7Tfd4xZVBFk
         zTKWAeHv2kbb0+MHziXCkwcdbZ+31wDfHxcxBpjb909UIPa4tXeiCBH9qT3p5XaG2Svt
         DkA5SitMTZ2VTrCrTUSvSYxlq+Kyep3OoQU8gKC5v4B5zjBAaXGZrkOeon++JRfWJ71Y
         ekXdBNpvm8CJyNyMvSJj/sPFMtagrxUINs7uuJGprhpXPZbuIDTQKkdEADRESdMQWTD0
         fnY5SH3Gew7lRXrqASBfJSwKoh554C6FcxUWN/CeHQK07/H4mouSCV6UxZLjgNO5TTmj
         98eQ==
X-Gm-Message-State: AHQUAuZZ70FVs5sepx0NWo/Qk5A1eP5HCFDlJnDM1nVCT5I+LWHFI1cd
        SvQxeG6H6eR41OIwPuLyGpSZazNFVb2mRzZAlnBIWBZgsXQ=
X-Google-Smtp-Source: AHgI3Ib8nz6A7pp7oHVCGmGUt6wbTmbRUkeWUPOUVisK9FCJItJx+AXL/ukQmpryScut7KSGmC6i+VU5fSho20Aus90=
X-Received: by 2002:aca:3ed4:: with SMTP id l203mr1305035oia.88.1551312356972;
 Wed, 27 Feb 2019 16:05:56 -0800 (PST)
MIME-Version: 1.0
References: <20190227233046.11718-1-jakub.kicinski@netronome.com> <20190227233046.11718-5-jakub.kicinski@netronome.com>
In-Reply-To: <20190227233046.11718-5-jakub.kicinski@netronome.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Feb 2019 16:05:45 -0800
Message-ID: <CAEf4BzZsYnvQZTqB6g9RocZpuCMxZ+eCnLqBccerFNkQ8ReEFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] samples: bpf: use libbpf where easy
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
> Some samples don't really need the magic of bpf_load,
> switch them to libbpf.
>
> Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
> ---
>  samples/bpf/Makefile       |  6 +++---
>  samples/bpf/fds_example.c  |  9 ++++++---
>  samples/bpf/sockex1_user.c | 22 ++++++++++++----------
>  samples/bpf/sockex2_user.c | 20 +++++++++++---------
>  4 files changed, 32 insertions(+), 25 deletions(-)
>
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 4dd98100678e..0c62ac39c697 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -59,9 +59,9 @@ LIBBPF = $(TOOLS_PATH)/lib/bpf/libbpf.a
>  CGROUP_HELPERS := ../../tools/testing/selftests/bpf/cgroup_helpers.o
>  TRACE_HELPERS := ../../tools/testing/selftests/bpf/trace_helpers.o
>
> -fds_example-objs := bpf_load.o fds_example.o
> -sockex1-objs := bpf_load.o sockex1_user.o
> -sockex2-objs := bpf_load.o sockex2_user.o
> +fds_example-objs := fds_example.o
> +sockex1-objs := sockex1_user.o
> +sockex2-objs := sockex2_user.o
>  sockex3-objs := bpf_load.o sockex3_user.o
>  tracex1-objs := bpf_load.o tracex1_user.o
>  tracex2-objs := bpf_load.o tracex2_user.o
> diff --git a/samples/bpf/fds_example.c b/samples/bpf/fds_example.c
> index 9854854f05d1..36f1f18aae3c 100644
> --- a/samples/bpf/fds_example.c
> +++ b/samples/bpf/fds_example.c
> @@ -14,8 +14,8 @@
>
>  #include <bpf/bpf.h>
>
> +#include "bpf/libbpf.h"
>  #include "bpf_insn.h"
> -#include "bpf_load.h"
>  #include "sock_example.h"
>
>  #define BPF_F_PIN      (1 << 0)
> @@ -57,10 +57,13 @@ static int bpf_prog_create(const char *object)
>                 BPF_EXIT_INSN(),
>         };
>         size_t insns_cnt = sizeof(insns) / sizeof(struct bpf_insn);
> +       char bpf_log_buf[BPF_LOG_BUF_SIZE];
> +       struct bpf_object *obj;
> +       int prog_fd;
>
>         if (object) {
> -               assert(!load_bpf_file((char *)object));
> -               return prog_fd[0];
> +               assert(!bpf_prog_load(object, 0, &obj, &prog_fd));

Here and in few more places below: is it possible to specify correct
bpf_prog_type instead of 0?

> +               return prog_fd;
>         } else {
>                 return bpf_load_program(BPF_PROG_TYPE_SOCKET_FILTER,
>                                         insns, insns_cnt, "GPL", 0,
> diff --git a/samples/bpf/sockex1_user.c b/samples/bpf/sockex1_user.c
> index be8ba5686924..5e7c4be3e645 100644
> --- a/samples/bpf/sockex1_user.c
> +++ b/samples/bpf/sockex1_user.c
> @@ -3,28 +3,30 @@
>  #include <assert.h>
>  #include <linux/bpf.h>
>  #include <bpf/bpf.h>
> -#include "bpf_load.h"
> +#include "bpf/libbpf.h"
>  #include "sock_example.h"
>  #include <unistd.h>
>  #include <arpa/inet.h>
>
>  int main(int ac, char **argv)
>  {
> +       struct bpf_object *obj;
> +       int map_fd, prog_fd;
>         char filename[256];
> -       FILE *f;
>         int i, sock;
> +       FILE *f;
>
>         snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
>
> -       if (load_bpf_file(filename)) {
> -               printf("%s", bpf_log_buf);
> +       if (bpf_prog_load(filename, 0, &obj, &prog_fd))
>                 return 1;
> -       }
> +
> +       map_fd = bpf_object__find_map_fd_by_name(obj, "my_map");
>
>         sock = open_raw_sock("lo");
>
> -       assert(setsockopt(sock, SOL_SOCKET, SO_ATTACH_BPF, prog_fd,
> -                         sizeof(prog_fd[0])) == 0);
> +       assert(setsockopt(sock, SOL_SOCKET, SO_ATTACH_BPF, &prog_fd,
> +                         sizeof(prog_fd)) == 0);
>
>         f = popen("ping -4 -c5 localhost", "r");
>         (void) f;
> @@ -34,13 +36,13 @@ int main(int ac, char **argv)
>                 int key;
>
>                 key = IPPROTO_TCP;
> -               assert(bpf_map_lookup_elem(map_fd[0], &key, &tcp_cnt) == 0);
> +               assert(bpf_map_lookup_elem(map_fd, &key, &tcp_cnt) == 0);
>
>                 key = IPPROTO_UDP;
> -               assert(bpf_map_lookup_elem(map_fd[0], &key, &udp_cnt) == 0);
> +               assert(bpf_map_lookup_elem(map_fd, &key, &udp_cnt) == 0);
>
>                 key = IPPROTO_ICMP;
> -               assert(bpf_map_lookup_elem(map_fd[0], &key, &icmp_cnt) == 0);
> +               assert(bpf_map_lookup_elem(map_fd, &key, &icmp_cnt) == 0);
>
>                 printf("TCP %lld UDP %lld ICMP %lld bytes\n",
>                        tcp_cnt, udp_cnt, icmp_cnt);
> diff --git a/samples/bpf/sockex2_user.c b/samples/bpf/sockex2_user.c
> index 125ee6efc913..e3611dbfce97 100644
> --- a/samples/bpf/sockex2_user.c
> +++ b/samples/bpf/sockex2_user.c
> @@ -3,7 +3,7 @@
>  #include <assert.h>
>  #include <linux/bpf.h>
>  #include <bpf/bpf.h>
> -#include "bpf_load.h"
> +#include "bpf/libbpf.h"
>  #include "sock_example.h"
>  #include <unistd.h>
>  #include <arpa/inet.h>
> @@ -17,22 +17,24 @@ struct pair {
>  int main(int ac, char **argv)
>  {
>         struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
> +       struct bpf_object *obj;
> +       int map_fd, prog_fd;
>         char filename[256];
> -       FILE *f;
>         int i, sock;
> +       FILE *f;
>
>         snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
>         setrlimit(RLIMIT_MEMLOCK, &r);
>
> -       if (load_bpf_file(filename)) {
> -               printf("%s", bpf_log_buf);
> +       if (bpf_prog_load(filename, 0, &obj, &prog_fd))
>                 return 1;
> -       }
> +
> +       map_fd = bpf_object__find_map_fd_by_name(obj, "hash_map");
>
>         sock = open_raw_sock("lo");
>
> -       assert(setsockopt(sock, SOL_SOCKET, SO_ATTACH_BPF, prog_fd,
> -                         sizeof(prog_fd[0])) == 0);
> +       assert(setsockopt(sock, SOL_SOCKET, SO_ATTACH_BPF, &prog_fd,
> +                         sizeof(prog_fd)) == 0);
>
>         f = popen("ping -4 -c5 localhost", "r");
>         (void) f;
> @@ -41,8 +43,8 @@ int main(int ac, char **argv)
>                 int key = 0, next_key;
>                 struct pair value;
>
> -               while (bpf_map_get_next_key(map_fd[0], &key, &next_key) == 0) {
> -                       bpf_map_lookup_elem(map_fd[0], &next_key, &value);
> +               while (bpf_map_get_next_key(map_fd, &key, &next_key) == 0) {
> +                       bpf_map_lookup_elem(map_fd, &next_key, &value);
>                         printf("ip %s bytes %lld packets %lld\n",
>                                inet_ntoa((struct in_addr){htonl(next_key)}),
>                                value.bytes, value.packets);
> --
> 2.19.2
>
