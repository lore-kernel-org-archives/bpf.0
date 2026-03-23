Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08942BD11
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 01:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774231115; cv=pass; b=gmUW8XTvo92goVL8+6wfejvsk4JgYmLZPfr16k0oboKgBTTHiIsBn9nn+89qaxK0K8VVfS0jlOqSMM9VW5645zld403GracdSEaGrbFBCd5g0HUyVtKzH1ugytyWBWCWzTpWy/ivP2Vk/pTSec4QbT9Mk4bUa43SKHCAJUBb34A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774231115; c=relaxed/simple;
	bh=iTl9j61xwKYafZWDA1NnC4nrfAfOooissU0Y3W7kGgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srpenbWHfo5saXqWU1tL0x01kF7e2u5ej+dIBFmLibvihOKhENbFxxfBt//VMOGwOoqbfXER+retLP8xPfdi9O79qe1wW9Ntz1d2mz7Hyzyz0Ly/CfJv8sWKxHd/49jV26p0cTNrwWiIuavTkyEW3GDU1q1CpeK0A7+kinC9UF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+oyjZs1; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+oyjZs1"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ad8435f46so2567690d50.1
        for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 18:58:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774231113; cv=none;
        d=google.com; s=arc-20240605;
        b=UZe0b6uK31wL+RYMudYvv+hEJxO7mLCV48vFzNoBYIOAAH7zdu+kQQUaLpJ0luly4H
         9Vprh2aEvLfgZxwvdwD6EYNsX+SxbbL7LNegDlG4l6J8YD9qv9eJx/8Co1L3RrCIB/pN
         527zLoXNtRP7PGISFjf78gGi9vqA/+KfSykIGjFx/4eMs6QUiukMpewViksvDxpmmPS0
         grkEqzTj7JRzpUc2xUYKrv/cfQmWH+GLfPszB0NCYHbyT8Hs+0sM7kGnMk4u2GvklE/M
         UAsIg0XMCEa6D5aQnVhp+Fr2sKGp5nuUuT0qr/3/P6Zeb/wv/jKEFQqV+RPkvD7Copcm
         Gp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WcSAnZYbmAJQ+QQx6HQ8ldUFIfSlGoCs1n+430PFR10=;
        fh=i0cXD66XxzyIhdq57Yb6K52qyTZR3e4SrYjzrY3/FR4=;
        b=Rbr9EA2aSpK/3u+78x1hePe3mBerNtAVEYxhv8ff80kfCBG54ZZDqgXqoRj2jAMxoL
         nO4GWF/IrEtciJFns13AMVGcvUuQk4lnUU3odIQxlbnv57JDnpqDQzitnZxdEEsC4lOU
         TP9sepbsymWuH2SH9wPg3k2qJh1DtdxU5PUFCqzEliHZGi10SOKV+G71EerzM3jrlYi3
         b/tCrlItiI1VsSoa/igIuOkHuGWTRf8R9hMRggdWIzHZPA2KjA6L7dRUlIU/9ZuPE62s
         3vH04xMpOfyJxkOGa/jhXQ/0fz/x8TWvk2nXEKJJ1jpDhyfMXSnDvCXTriGJY/4TMHpA
         B5Zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774231113; x=1774835913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcSAnZYbmAJQ+QQx6HQ8ldUFIfSlGoCs1n+430PFR10=;
        b=V+oyjZs1fBHHeCj8jn2RP2tGgc9znKONSBfa7qmdCxAGgDgLdOlxkdr4xcqL2grEBs
         phyvCY1+Uti/Ez2OV5DFwlNr32PUZ2Mh4Mz52FqgFz9EkWGIeNkoYdByjYDgkt4aeWtI
         77wNEY30cSSJc7qMOZxVPT6Bs7EpxSuwctu+8wytqtdazBZuaFKp0SMc/BQmc47/uvdo
         D7reWT0zDI9auHI98fwzKhYNaV5uLf3nZSeJdQ+k9kryy3d1vgSRrL6YUlJj4vO6xTlz
         yikvVS4Gf20O76mYRu38qG9P21NyJHQhNvQ/9FLhSSYim8l74lpze8JtcKbAQdy5H7MB
         zbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774231113; x=1774835913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WcSAnZYbmAJQ+QQx6HQ8ldUFIfSlGoCs1n+430PFR10=;
        b=sy4oYW0sIebatLgfXZbQ0kNi+c0ymsljB+i900P0P184q4zLB3O1QxjIrNrW1yxjmg
         toi+shVNfn8IX9TwwK0CkzackXQ4Li/lkI+MLTSaEAZ4/gFz2z0dRnYo9VOy9mQBFyCR
         3wPWImZ8H53Q9SoWoVhmLJJzrv8J5SipD1IyRanUyjuiAgUF9XtsstFcidHhKseuNQ1P
         XDJ4UwEAtuw1jatAcTj121kQDj8Lv5Dfr2Y5xVHEvPPK0MIRZ1lj51AsOtvg7uuBR1sd
         RJr9fldoVuqNqrRCVRb1pZxhgN/nZ6mz+NsJqG8Ou07UcB/1edYTgRS/O4gssRg35TQT
         0V+g==
X-Forwarded-Encrypted: i=1; AJvYcCUBQ+EhmYPkarM3S8V0wOZwHYVukRMkWhmqIqdDEqf/f197jZhT0bv+AfPbIfGdVUVj6W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJqOHI/26VkODav7iMAm4bR5wGhnzK4A1Pc2fKsjOZBcz4Zs0u
	aaQEeJV1/ejl2uP1u8wEZ30RwNptvS4ZSK9G41jKdaAEKpO5DEk2NB1Ts0NtOLQOyPpWKiFaYw7
	q73AZSEv/NmeRnzQX/mUcT4oD9JAMuG8=
X-Gm-Gg: ATEYQzxrnCY1bsyDa8bVx4kPrB2tl+B4uMwZrlP0BlecD7WvTFIxozv8fmNPBxwisxO
	nx8m0mji1p26ncUqX4QN/k1paxtkhCqqghvVYFBFfeSW9evkSDGNePnaU1P+BOC1aXuQfvALlrf
	QnbnV2SIu94a56SwQRNYR/AKoOGLoqjC0ajFmHN4UQt/AbJyTFdkFNVbH/416XN2E5C2cJQjbNu
	dnMLGW5qLJdzC6KXBw+izeieiTeWLf0/CD7vGOoQaF4+bSUk9EMDXu5viiOI+WYoDGKi/+1D1qa
	ifuW6GtuT56eP1/Sos5HXBwhVrQPYERK9zG6tDaUHTpIIXKah8SV2DHScJ8u
X-Received: by 2002:a53:ecdd:0:b0:64d:6045:993 with SMTP id
 956f58d0204a3-64eaa7dea07mr8514021d50.44.1774231112609; Sun, 22 Mar 2026
 18:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322204755.39783-1-varunrmallya@gmail.com>
In-Reply-To: <20260322204755.39783-1-varunrmallya@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Mon, 23 Mar 2026 09:58:21 +0800
X-Gm-Features: AQROBzBBIyEhR_XwG3y5fCdmS5OmCwzDn7PrD6wraqg-yAC18KrLaWj7ta7EI1M
Message-ID: <CABFUUZEcMH=kpc8NNkpQMV_PNVA_vSvcE-y1c=_2vbGZLCFQ7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Improve connect_force_port
 test reliability
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: jiayuan.chen@linux.dev, yonghong.song@linux.dev, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 4:48=E2=80=AFAM Varun R Mallya <varunrmallya@gmail.=
com> wrote:
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/connect_force_port.c =
b/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
> index 24d553109f8d..f2729211147f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
> +++ b/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
> @@ -53,6 +53,9 @@ static int run_test(int cgroup_fd, int server_fd, int f=
amily, int type)
>         __u16 expected_peer_port =3D 60000;
>         struct bpf_program *prog;
>         struct bpf_object *obj;
> +       struct bpf_map *map;
> +       unsigned short *port_ptr;
NIT: __u16 is better than unsigned short both in BPF and here
> +       size_t port_size;
>         const char *obj_file =3D v4 ? "connect_force_port4.bpf.o" : "conn=
ect_force_port6.bpf.o";
>         int fd, err;
>         __u32 duration =3D 0;
> @@ -61,6 +64,14 @@ static int run_test(int cgroup_fd, int server_fd, int =
family, int type)
>         if (!ASSERT_OK_PTR(obj, "bpf_obj_open"))
>                 return -1;
>
> +       /* Auto assigns the port according to availability */
> +       map =3D bpf_object__find_map_by_name(obj, ".bss");
> +       if (ASSERT_OK_PTR(map, "find bss map")) {
> +               port_ptr =3D bpf_map__initial_value(map, &port_size);
> +               if (ASSERT_OK_PTR(port_ptr, "get bss initial value"))
> +                       *port_ptr =3D ntohs(get_socket_local_port(server_=
fd));
> +       }
Could we make both ASSERT_OK_PTR() failures jump directly to close_bpf_obje=
ct?
That would shorten the execution path and keep the failure log cleaner.

Sun Jian
> +
>         err =3D bpf_object__load(obj);
>         if (!ASSERT_OK(err, "bpf_obj_load")) {
>                 err =3D -EIO;
> @@ -138,25 +149,25 @@ void test_connect_force_port(void)
>         if (CHECK_FAIL(cgroup_fd < 0))
>                 return;
>
> -       server_fd =3D start_server(AF_INET, SOCK_STREAM, NULL, 60123, 0);
> +       server_fd =3D start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
>         if (CHECK_FAIL(server_fd < 0))
>                 goto close_cgroup_fd;
>         CHECK_FAIL(run_test(cgroup_fd, server_fd, AF_INET, SOCK_STREAM));
>         close(server_fd);
>
> -       server_fd =3D start_server(AF_INET6, SOCK_STREAM, NULL, 60124, 0)=
;
> +       server_fd =3D start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
>         if (CHECK_FAIL(server_fd < 0))
>                 goto close_cgroup_fd;
>         CHECK_FAIL(run_test(cgroup_fd, server_fd, AF_INET6, SOCK_STREAM))=
;
>         close(server_fd);
>
> -       server_fd =3D start_server(AF_INET, SOCK_DGRAM, NULL, 60123, 0);
> +       server_fd =3D start_server(AF_INET, SOCK_DGRAM, NULL, 0, 0);
>         if (CHECK_FAIL(server_fd < 0))
>                 goto close_cgroup_fd;
>         CHECK_FAIL(run_test(cgroup_fd, server_fd, AF_INET, SOCK_DGRAM));
>         close(server_fd);
>
> -       server_fd =3D start_server(AF_INET6, SOCK_DGRAM, NULL, 60124, 0);
> +       server_fd =3D start_server(AF_INET6, SOCK_DGRAM, NULL, 0, 0);
>         if (CHECK_FAIL(server_fd < 0))
>                 goto close_cgroup_fd;
>         CHECK_FAIL(run_test(cgroup_fd, server_fd, AF_INET6, SOCK_DGRAM));
> diff --git a/tools/testing/selftests/bpf/progs/connect_force_port4.c b/to=
ols/testing/selftests/bpf/progs/connect_force_port4.c
> index 27a632dd382e..d2beff466902 100644
> --- a/tools/testing/selftests/bpf/progs/connect_force_port4.c
> +++ b/tools/testing/selftests/bpf/progs/connect_force_port4.c
> @@ -14,6 +14,8 @@
>
>  char _license[] SEC("license") =3D "GPL";
>
> +unsigned short port =3D 0;
> +
>  struct svc_addr {
>         __be32 addr;
>         __be16 port;
> @@ -40,7 +42,7 @@ int connect4(struct bpf_sock_addr *ctx)
>         if (bpf_bind(ctx, (struct sockaddr *)&sa, sizeof(sa)) !=3D 0)
>                 return 0;
>
> -       /* Rewire service 1.2.3.4:60000 to backend 127.0.0.1:60123. */
> +       /* Rewire service 1.2.3.4:60000 to backend 127.0.0.1:port. */
>         if (ctx->user_port =3D=3D bpf_htons(60000)) {
>                 orig =3D bpf_sk_storage_get(&service_mapping, ctx->sk, 0,
>                                           BPF_SK_STORAGE_GET_F_CREATE);
> @@ -51,7 +53,7 @@ int connect4(struct bpf_sock_addr *ctx)
>                 orig->port =3D ctx->user_port;
>
>                 ctx->user_ip4 =3D bpf_htonl(0x7f000001);
> -               ctx->user_port =3D bpf_htons(60123);
> +               ctx->user_port =3D bpf_htons(port);
>         }
>         return 1;
>  }
> @@ -63,7 +65,7 @@ int getsockname4(struct bpf_sock_addr *ctx)
>                 return 1;
>
>         /* Expose local server as 1.2.3.4:60000 to client. */
> -       if (ctx->user_port =3D=3D bpf_htons(60123)) {
> +       if (ctx->user_port =3D=3D bpf_htons(port)) {
>                 ctx->user_ip4 =3D bpf_htonl(0x01020304);
>                 ctx->user_port =3D bpf_htons(60000);
>         }
> @@ -79,7 +81,7 @@ int getpeername4(struct bpf_sock_addr *ctx)
>                 return 1;
>
>         /* Expose service 1.2.3.4:60000 as peer instead of backend. */
> -       if (ctx->user_port =3D=3D bpf_htons(60123)) {
> +       if (ctx->user_port =3D=3D bpf_htons(port)) {
>                 orig =3D bpf_sk_storage_get(&service_mapping, ctx->sk, 0,=
 0);
>                 if (orig) {
>                         ctx->user_ip4 =3D orig->addr;
> diff --git a/tools/testing/selftests/bpf/progs/connect_force_port6.c b/to=
ols/testing/selftests/bpf/progs/connect_force_port6.c
> index 19cad93e612f..7b5f3c6040cc 100644
> --- a/tools/testing/selftests/bpf/progs/connect_force_port6.c
> +++ b/tools/testing/selftests/bpf/progs/connect_force_port6.c
> @@ -13,6 +13,8 @@
>
>  char _license[] SEC("license") =3D "GPL";
>
> +unsigned short port =3D 0;
> +
>  struct svc_addr {
>         __be32 addr[4];
>         __be16 port;
> @@ -39,7 +41,7 @@ int connect6(struct bpf_sock_addr *ctx)
>         if (bpf_bind(ctx, (struct sockaddr *)&sa, sizeof(sa)) !=3D 0)
>                 return 0;
>
> -       /* Rewire service [fc00::1]:60000 to backend [::1]:60124. */
> +       /* Rewire service [fc00::1]:60000 to backend [::1]:port. */
>         if (ctx->user_port =3D=3D bpf_htons(60000)) {
>                 orig =3D bpf_sk_storage_get(&service_mapping, ctx->sk, 0,
>                                           BPF_SK_STORAGE_GET_F_CREATE);
> @@ -56,7 +58,7 @@ int connect6(struct bpf_sock_addr *ctx)
>                 ctx->user_ip6[1] =3D 0;
>                 ctx->user_ip6[2] =3D 0;
>                 ctx->user_ip6[3] =3D bpf_htonl(1);
> -               ctx->user_port =3D bpf_htons(60124);
> +               ctx->user_port =3D bpf_htons(port);
>         }
>         return 1;
>  }
> @@ -68,7 +70,7 @@ int getsockname6(struct bpf_sock_addr *ctx)
>                 return 1;
>
>         /* Expose local server as [fc00::1]:60000 to client. */
> -       if (ctx->user_port =3D=3D bpf_htons(60124)) {
> +       if (ctx->user_port =3D=3D bpf_htons(port)) {
>                 ctx->user_ip6[0] =3D bpf_htonl(0xfc000000);
>                 ctx->user_ip6[1] =3D 0;
>                 ctx->user_ip6[2] =3D 0;
> @@ -87,7 +89,7 @@ int getpeername6(struct bpf_sock_addr *ctx)
>                 return 1;
>
>         /* Expose service [fc00::1]:60000 as peer instead of backend. */
> -       if (ctx->user_port =3D=3D bpf_htons(60124)) {
> +       if (ctx->user_port =3D=3D bpf_htons(port)) {
>                 orig =3D bpf_sk_storage_get(&service_mapping, ctx->sk, 0,=
 0);
>                 if (orig) {
>                         ctx->user_ip6[0] =3D orig->addr[0];
> --
> 2.53.0
>
>
