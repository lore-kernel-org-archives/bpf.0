Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC89537BE95
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756790; cv=pass; b=NDh1z8XOoS4zTcG4zaytNzMUw6vsQjoaoNOWaRFFqHsHUuop7u9xrkxRPVYN5vqVTM8zkEjXhXBU4Z64lJmMZ/NMa/nPthJRt+hK6faLILaPN7FjO5yEvfsSfCOQBxTC4u9VO2Odui92AgjDlzFyRvOc8ewcA0HfysdOl46JAV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756790; c=relaxed/simple;
	bh=YsBJ5rLzCHNROrpoUXAG2+olo/jg6vCTJlr1rdi8LKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6lo3bylONKltWwIu0LW4frEfuP2JN3KgGATSedViIdLMMcQhNHNzXdWsw5XW3SJWEQM8VWN1xfGCb2pXwobXFKCBpFr/V4BMdJBdHBm5eOHYn2Omjo36SamL3NKrYik3p0HFmDButqM+xjVWoQ144j+7glGkwc/ubdSvOUXx0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r3ngRI7J; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3ngRI7J"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-80a123ef90aso41010167b3.0
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 11:13:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782756787; cv=none;
        d=google.com; s=arc-20260327;
        b=BOH6ZEXAZObx1wVxwalBj6QtrGTjWoyrlhAYpwA4BTcjOn0nJNhRGiJgVsH6p2vAur
         kpSzTmZKiA7UV4cJFKGk79NSvCta4w841RKS3HPTPz+ZmhuLdPbsjlkYOXOcBqaZmnwK
         LLxbzniPz9W19WviHwTLdEu64XRt7SBYps5TcSsKL8bIpGmTmi7bNwHZKEPcCmzGrk9W
         frWVmILMojdAXMjIRlNz9X7mVnqkDgQ8MDfl5Ian8DpFQQkExq5ZXrTAPxAmsiX52OML
         4Kk9bHZMlb6e3K5gJnimKUK4e3uoJT4Vs2KSgQ3Wg7p0YTAg6hjcbgnkGs7XqWbMqSHW
         K/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SmmYAil1f9hLMNCPLSvS+Czx4YqCWUlhWfkBPgyh9NY=;
        fh=rTyvjpokTWnR6eb2aq4B5nuUgBe+IXlQoBo8y+gGPeI=;
        b=nBgFnAtkvb4WHCUVP5aq1/iapKDNT9UzW0Weh/XPwww2E5F4dn2jFtmcylKZw8OaT+
         8GWg+Wvp2CYQLLHIWl+bkjO0lj4F4+Od3R5zpjHDZ51MvWTGQt0d09XNXfMCLdhjVlcf
         sbJVtz14LZ53OAJWPK8kHGdJ2ouFS7IYiidDF0TwkVTO/MCrzazZnObdo1+SoUA/Nw6X
         6lA/DUWHn0GtryhLAzo3I6qCw99q3/dNG50Jr2EKZ95NSbVW5wjkO43CBsowE9/RYbAV
         u7ZbKq/7KzBu96+nZwTicpKGjbzr4qzb1p0H60yCu3rsbex4MZ6+M/Sr0QIFzP5QWW+N
         uHew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782756787; x=1783361587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmmYAil1f9hLMNCPLSvS+Czx4YqCWUlhWfkBPgyh9NY=;
        b=r3ngRI7Jw9a9T4fPzceGvzHGZRZZq6wE0N8XjsH5UPH5hLeo0brp789qCVWuxAnoS0
         gS3TMV/Cw6nuiR1WzZM/2N31gOX/7iUcSOu5g7v0WcTy6bmtuy5mq0DGSCWwRtreNS7X
         TysAfKHcBqNz1ud1PETZI/DUHiAb+js5G5s7xqEjK3LjYFhDoDHzJ+BGJRFBY9CPuzsz
         eGj6HqkRitxTwvykDsc694jyWxXtSsaHYkKS6F+X2098lujKa0HRsxnJOTfFr9g0IOoX
         ptSWKhC+6uoAzRb3d06nLra+bLdT7lRdQnRzvqxGNOOH5dYygTcgBJZFoExKIir97Gjx
         KS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756787; x=1783361587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SmmYAil1f9hLMNCPLSvS+Czx4YqCWUlhWfkBPgyh9NY=;
        b=fCzw9lXwgB6u6E8chpGY4nrAlYosljtdJhKw4CwBLZUxmELnBt27sWKW+1zk+8MZej
         vp9tA3/YsgMNJIvzkIF5wbYzV0PD+zD19mMEiOgHlScqRDvwjghA7eGfOUyDL407FYw5
         NlE3U/UKPpRoJz0a+A4Ysw1q8wv7qPpX9Lv/X30ARifmAfiCFH7P08+hRBFm2dl0A1LZ
         l2B61wXiayz59mwtPeCz54Wej1SqYEr//ny8R6NYr9K1bWGAO+T9uwH9mbBMvoT9O7Gv
         pSmaqCQYGttuCGAyjfos6R3mOViqgph3haZz9im4Xyux9nsFP3Hdzl/m78/jtftZ/mtn
         /y7w==
X-Forwarded-Encrypted: i=1; AHgh+RrHXEGjF2CPHjATTVAoJmjaw6DfVzQHvQKaWyiWoaiEEcD7xHt5tQiI3/hgTFaCIrLRg3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU8JfiP+Iv7EIi5pkGX9b5Vs4XaaJOSQ2Dr3gVx93V4nFZauI4
	rZWHJ8abcpTCNdnn6kXSrgY2x7LyGT+htO20BQ7cwQfZCdK2gNRstTzs0wblrRGA031Oa28cWPc
	as+7H29bvSMDr32V3PnqxTtG+5sOt75w=
X-Gm-Gg: AfdE7cnq7psoWRdiEvhIK6oJC6A7bCQdSnrRkL5b26/N3XUm2Qc6MjyoqFZ5K7yc5+O
	/IROTCSAnt5TqJmlFO3p0aDusR50l1cv/0AY6vIo3cusnrnx9WGdiFGDdFJikfzcXPGfSEqhSf9
	0slC7k293p/qJUosorBkfAP7XuEEu4O6gblRgCUYA4CgXbZZm7y/oZxm8H8c7hHQzgEaP76KVqD
	iQ71R3GZP3ilPi9gsrR9jYW39pHoVTpMBYIBsZkDdTbKy9wZclM5L3yFAX6fuFFjEhujLnv4PCr
	yyFdd/yuorCc
X-Received: by 2002:a05:690c:dcd:b0:80b:1616:5c0e with SMTP id
 00721157ae682-810e984a566mr3240827b3.20.1782756787534; Mon, 29 Jun 2026
 11:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629125637.384923-1-layus.on@gmail.com>
In-Reply-To: <20260629125637.384923-1-layus.on@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 29 Jun 2026 11:12:54 -0700
X-Gm-Features: AVVi8CdW3Ek5fAOq0hw_26M9hi49cDbrZRotwx5VJpI7hZNDTSnWdF5fckFOukc
Message-ID: <CAMB2axM=utfi11L1e2-yMgCiSEZ=QrZAPrcFLwk44hNqyT1qJQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Mask socket type flags in mptcpify prog
To: "Guillaume @layus Maudoux" <layus.on@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 6:19=E2=80=AFAM Guillaume @layus Maudoux
<layus.on@gmail.com> wrote:
>
> The mptcpify BPF prog hooks update_socket_protocol() to rewrite
> eligible TCP socket() calls to IPPROTO_MPTCP. It only does so when the
> socket type is exactly SOCK_STREAM:
>
>         type =3D=3D SOCK_STREAM
>
> The problem is that update_socket_protocol() in __sys_socket() is
> called on the raw type argument as passed from userspace, before
> __sys_socket_create() strips the flag bits with
> "type &=3D SOCK_TYPE_MASK". The type argument may therefore carry
> SOCK_CLOEXEC and/or SOCK_NONBLOCK in its upper bits, and the equality
> check above then fails.
>
> As a result, any socket created with e.g.
> socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0) -- which is what common
> libraries do by default -- is silently left as plain TCP instead of
> being upgraded to MPTCP. This was observed in practice with curl,
> whose connections were not upgraded to MPTCP despite the prog being
> attached.
>
> The impact reaches beyond the test, because mptcpify.c is referenced
> as example code for users who want to transparently enable MPTCP. The
> same mistake is therefore likely to be copied into real deployments,
> where it fails the same way and is hard to diagnose.
>
> The fix is to mask off the flag bits before comparing, mirroring what
> the socket core does:
>
>         (type & SOCK_TYPE_MASK) =3D=3D SOCK_STREAM
>
> Since SOCK_TYPE_MASK is not exposed through vmlinux.h, define it in
> bpf_tracing_net.h.
>
> To exercise the regression directly, extend the mptcpify test to also
> create the server socket with SOCK_CLOEXEC and SOCK_NONBLOCK set.
> Routing a flagged type through start_server() then revealed a second
> instance of the same pattern: start_server_addr() compared the type
> against SOCK_STREAM for equality to decide whether to set SO_REUSEADDR
> and call listen(), and so would skip listening for a flagged type.
> Mask the type there as well. As SOCK_TYPE_MASK is not exposed by
> glibc's <sys/socket.h> either, define it in network_helpers.h,
> mirroring prog_tests/socket_helpers.h.
>
> Fixes: ddba122428a7 ("selftests/bpf: Add mptcpify test")
> Signed-off-by: Guillaume @layus Maudoux <layus.on@gmail.com>

Hello,

You will need to use your real name in the SOB. At least "@" caused
some problems when I downloaded the patch.

Please also include "bpf-next" in your subject prefix so that the CI
can properly test it.

> ---
>  tools/testing/selftests/bpf/network_helpers.c |  4 ++--
>  tools/testing/selftests/bpf/network_helpers.h |  5 +++++
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 20 +++++++++++++++----
>  .../selftests/bpf/progs/bpf_tracing_net.h     |  3 +++
>  tools/testing/selftests/bpf/progs/mptcpify.c  |  2 +-
>  5 files changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testin=
g/selftests/bpf/network_helpers.c
> index b82f572641b7..db935a9d9fc1 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -111,7 +111,7 @@ int start_server_addr(int type, const struct sockaddr=
_storage *addr, socklen_t a
>         if (settimeo(fd, opts->timeout_ms))
>                 goto error_close;
>
> -       if (type =3D=3D SOCK_STREAM &&
> +       if ((type & SOCK_TYPE_MASK) =3D=3D SOCK_STREAM &&
>             setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on))) {
>                 log_err("Failed to enable SO_REUSEADDR");
>                 goto error_close;
> @@ -128,7 +128,7 @@ int start_server_addr(int type, const struct sockaddr=
_storage *addr, socklen_t a
>                 goto error_close;
>         }
>
> -       if (type =3D=3D SOCK_STREAM) {
> +       if ((type & SOCK_TYPE_MASK) =3D=3D SOCK_STREAM) {
>                 if (listen(fd, opts->backlog ? MAX(opts->backlog, 0) : 1)=
 < 0) {
>                         log_err("Failed to listed on socket");
>                         goto error_close;
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testin=
g/selftests/bpf/network_helpers.h
> index 79a010c88e11..75133119c04a 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -25,6 +25,11 @@ typedef __u16 __sum16;
>  #define VIP_NUM 5
>  #define MAGIC_BYTES 123
>
> +/* include/linux/net.h */
> +#ifndef SOCK_TYPE_MASK
> +#define SOCK_TYPE_MASK 0xf
> +#endif
> +
>  struct network_helper_opts {
>         int timeout_ms;
>         int proto;
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testi=
ng/selftests/bpf/prog_tests/mptcp.c
> index 8fade8bdc451..faa001ea84ab 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -264,7 +264,7 @@ static int verify_mptcpify(int server_fd, int client_=
fd)
>         return err;
>  }
>
> -static int run_mptcpify(int cgroup_fd)
> +static int run_mptcpify(int cgroup_fd, int type)
>  {
>         int server_fd, client_fd, err =3D 0;
>         struct mptcpify *mptcpify_skel;
> @@ -280,7 +280,7 @@ static int run_mptcpify(int cgroup_fd)
>                 goto out;
>
>         /* without MPTCP */
> -       server_fd =3D start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
> +       server_fd =3D start_server(AF_INET, type, NULL, 0, 0);
>         if (!ASSERT_GE(server_fd, 0, "start_server")) {
>                 err =3D -EIO;
>                 goto out;
> @@ -307,7 +307,18 @@ static int run_mptcpify(int cgroup_fd)
>  static void test_mptcpify(void)
>  {
>         struct netns_obj *netns =3D NULL;
> -       int cgroup_fd;
> +       int cgroup_fd, i;
> +       int types[] =3D {
> +               SOCK_STREAM,
> +               /* userspace sets these flags together with the type, and=
 the
> +                * BPF prog must still upgrade the socket to MPTCP. See
> +                * update_socket_protocol() in net/socket.c, which runs b=
efore
> +                * the type is masked with SOCK_TYPE_MASK.
> +                */
> +               SOCK_STREAM | SOCK_CLOEXEC,
> +               SOCK_STREAM | SOCK_NONBLOCK,
> +               SOCK_STREAM | SOCK_CLOEXEC | SOCK_NONBLOCK,
> +       };
>
>         cgroup_fd =3D test__join_cgroup("/mptcpify");
>         if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
> @@ -317,7 +328,8 @@ static void test_mptcpify(void)
>         if (!ASSERT_OK_PTR(netns, "netns_new"))
>                 goto fail;
>
> -       ASSERT_OK(run_mptcpify(cgroup_fd), "run_mptcpify");
> +       for (i =3D 0; i < ARRAY_SIZE(types); i++)
> +               ASSERT_OK(run_mptcpify(cgroup_fd, types[i]), "run_mptcpif=
y");

nit: testing all four type combinations adds little value here. I'd
drop array+loop and keep two. For example:

  ASSERT_OK(run_mptcpify(cgroup_fd, SOCK_STREAM), "run_mptcpify");
  ASSERT_OK(run_mptcpify(cgroup_fd, SOCK_STREAM | SOCK_CLOEXEC),
"run_mptcpify_cloexec");

>
>  fail:
>         netns_free(netns);
> diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/=
testing/selftests/bpf/progs/bpf_tracing_net.h
> index d8dacef37c16..c4b438854565 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> @@ -8,6 +8,9 @@
>  #define AF_INET                        2
>  #define AF_INET6               10
>
> +/* include/linux/net.h */
> +#define SOCK_TYPE_MASK         0xf
> +
>  #define SOL_SOCKET             1
>  #define SO_REUSEADDR           2
>  #define SO_SNDBUF              7
> diff --git a/tools/testing/selftests/bpf/progs/mptcpify.c b/tools/testing=
/selftests/bpf/progs/mptcpify.c
> index cbdc730c3a47..e3f8cb54dbe9 100644
> --- a/tools/testing/selftests/bpf/progs/mptcpify.c
> +++ b/tools/testing/selftests/bpf/progs/mptcpify.c
> @@ -15,7 +15,7 @@ int BPF_PROG(mptcpify, int family, int type, int protoc=
ol)
>                 return protocol;
>
>         if ((family =3D=3D AF_INET || family =3D=3D AF_INET6) &&
> -           type =3D=3D SOCK_STREAM &&
> +           (type & SOCK_TYPE_MASK) =3D=3D SOCK_STREAM &&
>             (!protocol || protocol =3D=3D IPPROTO_TCP)) {
>                 return IPPROTO_MPTCP;
>         }
> --
> 2.54.0
>
>
