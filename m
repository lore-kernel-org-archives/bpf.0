Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46AFC43218
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 17:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A5F206BF
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 17:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwO7KZc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfDYReq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:34:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44519 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfDYReq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 13:34:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id s10so979009qtc.11;
        Thu, 25 Apr 2019 10:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZ4OJXcUKD2iFARS9oIuhkOlaXdIEcLt6qWirrgSTwY=;
        b=cwO7KZc+ELBryflRD6Pxr1b+GuTdCFETqof3GrZOD1gEZlOXXEu0q+7Ku6Cyn2f1eJ
         FYKhuSnEm58PuIub/T3bTKDuHzzgR79Bp7ns6XaCBreHtO23k7l0TnT27J4+H1onbWyO
         Sb0mKLditGNWRUeyFFfayv4q6M4Vip99ElJQnYjvNsaCNCbPp58oL+MJJR5oOfAgWJQ8
         7poLJbMtTbVo4za1fNcwhfy/EMURZMXtwZrqf4BL1LbyXQ4r9tnzWtAgb26gkKEKM8/+
         geJufwGExfxwFyVTM6Lh5fATL1PHy7mXaR5K72PjXb7/+iTLHnh4zDhT1gLoeKpcNlN5
         81Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZ4OJXcUKD2iFARS9oIuhkOlaXdIEcLt6qWirrgSTwY=;
        b=nw0zUF24Bv3SnQZeDdiF2fEJYVCiOR6KZfJijuLGkBHGMcdluFv2IzaLdiBl/CEa6o
         X5ZPvzM8gP8F7ezpbLa5kldvrsUpdTIUZ3i1Fi1jPnO1oMo/ECQIt/faHJykGfvX+o54
         yqMVhyWjugx9lefHr21kmj1qHzY+MOIh/ua3rd4eANYU4CIRb6Qn8W5o97LYY7XbxBNc
         QHEM4yfPaeAuQDHGiBIroV167EXdP2jMuYkaBrOH3jSGI6veA+ziSvcXZAtVba5CfGhE
         ExQ5+LHUbBsmxiHwZ30qMO1St0jBj0b9vXO+4o0SWCfT5w1NrhMbTPUr22UvTaD4UyE6
         Dstg==
X-Gm-Message-State: APjAAAVaaykZJTxEKuTyeajUlXQvrSvT5aNWOIEPL/UaXy7Nw3CmUShY
        se9X+blW1L/FUA1xEepAtupdndLO22O4DoENY7Q=
X-Google-Smtp-Source: APXvYqw7yzE8drQpqQnO5mVBiwv3EvhHa3WOnFQLYJOOsxquoy5Z9pvYFhE3R7Tp6npp8rjg/Fqs84/vtWrb4tGpe7g=
X-Received: by 2002:ac8:311a:: with SMTP id g26mr20212839qtb.27.1556213685125;
 Thu, 25 Apr 2019 10:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <155614416551.29379.12486744636513956469.stgit@john-XPS-13-9360>
In-Reply-To: <155614416551.29379.12486744636513956469.stgit@john-XPS-13-9360>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Apr 2019 10:34:34 -0700
Message-ID: <CAEf4Bza3CMqp5pqtkEFh+3GAHcH+qcKYJhbL02jbauWjD_K0Xg@mail.gmail.com>
Subject: Re: [bpf-next PATCH] bpf: sockmap, test tool support to skip cgroup arg
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 25, 2019 at 12:19 AM John Fastabend
<john.fastabend@gmail.com> wrote:
>
> Its handy to not have to setup a cgroup environment when running
> test_sockmap with user specified options. This patch setups a cgroup
> environment, similar to how it is done with the auto test suite, when
> the user does not provide a cgroup arg.
>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  tools/testing/selftests/bpf/test_sockmap.c |   24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> index 3845144e2c91..11dfb1f10e15 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -1734,6 +1734,7 @@ int main(int argc, char **argv)
>         int opt, longindex, err, cg_fd = 0;
>         char *bpf_file = BPF_SOCKMAP_FILENAME;
>         int test = PING_PONG;
> +       bool cleanup = true;
>
>         if (argc < 2)
>                 return test_suite(-1);
> @@ -1773,6 +1774,7 @@ int main(int argc, char **argv)
>                                         cg_fd, optarg);
>                                 return cg_fd;
>                         }
> +                       cleanup = false;
>                         break;
>                 case 'r':
>                         rate = atoi(optarg);
> @@ -1818,9 +1820,23 @@ int main(int argc, char **argv)

Code one line above this, assumes that tool in non-test mode always
has argc > 3. With --cgroup being optional, that's not true anymore,
right? Or am I missing how it's supposed to be used?

>                 return test_suite(cg_fd);
>
>         if (!cg_fd) {
> -               fprintf(stderr, "%s requires cgroup option: --cgroup <path>\n",
> -                       argv[0]);

Now that --cgroup is optional, would it make sense to update usage
function at line 121 to remove "--cgroup <cgroup_path>"?

> -               return -1;
> +               if (setup_cgroup_environment()) {
> +                       fprintf(stderr, "ERROR: cgroup env failed\n");
> +                       return -EINVAL;
> +               }
> +
> +               cg_fd = create_and_get_cgroup(CG_PATH);
> +               if (cg_fd < 0) {
> +                       fprintf(stderr,
> +                               "ERROR: (%i) open cg path failed: %s\n",
> +                               cg_fd, optarg);
> +                       return cg_fd;
> +               }
> +
> +               if (join_cgroup(CG_PATH)) {
> +                       fprintf(stderr, "ERROR: failed to join cgroup\n");
> +                       return -EINVAL;
> +               }
>         }
>
>         err = populate_progs(bpf_file);
> @@ -1839,6 +1855,8 @@ int main(int argc, char **argv)
>         options.rate = rate;
>
>         err = run_options(&options, cg_fd, test);
> +       if (cleanup)
> +               cleanup_cgroup_environment();
>         close(cg_fd);
>         return err;
>  }
>
