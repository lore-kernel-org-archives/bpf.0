Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1083242B5
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777581178; cv=pass; b=CDYo0sZON6xvTeyts4rKsTmZYdwGAGvbX3eUOn/0QTENLsTClt8L/mPy+xOxqjSa65N1R5AWOaKZyF052jpcONcf9ZCT7/XWw12FoV603er9DReYgMxZ7DKiE9hVk+pI+aWA20mWTjovt/EOlMHOboM9Gq9ELWHptQa/3PUPLms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777581178; c=relaxed/simple;
	bh=U2eH8NGTZAa0spz3Gpw8B0ZcuVJWHa8CNLda7oex5Hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ekq0vSw2bdpByOsqytXOp1pE9yBhi1Ocr3hOi55RjKwOC+qdNJM6IKKHrsS99RAgg9sgUfj/+URWU9Td0R6B+rMMp1iXMLq8dpybkJdkNFKwixcorilpNAH6qkTkV8C/+bsZy4n1lmZZIasxJJAQzHcJT0hNOkUW/kLZU1Gd3gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=icZoEP0e; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="icZoEP0e"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12dca45ca21so1831529c88.1
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 13:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777581176; cv=none;
        d=google.com; s=arc-20240605;
        b=KsGGDDxQE+/BkXkSgAXSUUAOIr0+JrhJEbZo8f5z0g4JNbx/IXRLnI8Q/jGlASYo65
         bmP7FhTWxAevHJCyA+AfKsYGjS+8M4QvumhAhGzhPsOiJcXMOTjsNjkYz8uFHDsbX17D
         jJQzHe6HWOatdAGzPlGsL3X21SYprlopm0Uut/kRcTxpXBRTQpTEZs5y3qdJjGQURHmT
         ekdNRM/JIhqqxZQthJ/lH5wAH3ruWO/VLr/IVsjMg+lLbtcaoNeHXmeA5ZhgZZRa43sY
         XsyFJKhxrLvfif5Fv63GFSqWao31Gvt94lGvOSauf8NVWNEkbA3uSbS8g+hoOdevskzC
         LiNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TMxaUy4qZ0yhVhil4Cjh0E5+hmuhmKfd+HYIaVWBDiE=;
        fh=cDCgUeUsMteTo9hsOMDLWeNXvhNm87TRObisZiHxods=;
        b=RxBkOTQI5f05BJ4CuXgnl6QMTXLJV30spx0TvJw7+4RXi8A41tHjNa/FZc1ryCvk+P
         R2PUEqOWKSQAmuStJA4R8sgFxh+odLb8fa0NJ/NmXQSCK5LLQpWyHP9CmPbT9HluFmsd
         9krvGQDWQDCEVGb9XCeJbMZPFTfo7G0k9mtEZMg4IbUEq4qnGwVSiGVo/eK9l712MiMw
         w0HaQNox+vk61X779Ug3//y0gi89pgizLZHysN3nidTdPEBDwgSH5ooInM/pt3T9YfO5
         xI5Pe2Z2Oz0KkGUCQ2SaUQ0iKMB6We3QPcp2kXFkga7+ah43Gt+yqiQAL7D1+bX8VqcW
         QpYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777581176; x=1778185976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMxaUy4qZ0yhVhil4Cjh0E5+hmuhmKfd+HYIaVWBDiE=;
        b=icZoEP0etWqUV5+RIHho1Peu9vOEoiezTz+D8YB0T/YQL1PAim0nF54pPOm2jNqGbI
         9kCvMDq2hJOB85t+TjOTzw4zzHKcXIlB3ZsWlKZfalJ/hyA9UFHWX1Q0+Et4aA+rXNOZ
         RqIQHv273qs1xSxTpn+uX4idOUHuouj8apeYXtLIYVYDnKdKUXvtKuMZkcskhDKil0+3
         vzH/dqedaxvlTX4knBKaP/12HmGA4XdLWIwiIPBAvrUv1XISk+jgazuMIeRlgvNp/Pno
         hNGkQpi/7ej157c7NX97ImsWviAdFjXG6MtW2A0N7XvEYUYgZyvxdy/a1tPsM26W6sf9
         3jNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777581176; x=1778185976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TMxaUy4qZ0yhVhil4Cjh0E5+hmuhmKfd+HYIaVWBDiE=;
        b=ATHpwYQjTSlBiMP6y6kUMOy05xFtd7oY1SxzFKTfnr4FWwk/1R3NIIZa0AsVi8UC06
         Uk+DiPRTikbFrHimchzMHAkgeZFbdIj8vm7Epi7T04dvEjxvRO8OUDnf065q7uEmCit7
         SeDbqVSyRiFnlX3QnSNj/4RAS3SRlO1CIlnhMPMB2bAvBdFHwY0sRZI4ivVKAzI/cZzX
         wNzAXsBvj9I1aPRCrJXWxhCvpU4R3MwrJY05KejBF+IDe6xgjDBfycezLZs5s1nf9oLM
         wWI4lJtbfVQfVnPYTk1YTJw9VreSZaWt8GeNs/gzVwXsXNwh3aIJZ49JxQzHZbubVKjH
         4rZQ==
X-Forwarded-Encrypted: i=1; AFNElJ//nzMjKXyRw0V0K0iGw9plWqNFTVsDV9Oydw3JNT3yq3/eThBY6knp6fkFNn4Lp1C5WzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBehOyVEBLADsMsolUovoxnZLbF6q6okg9rJrP2AcHLebg6/Q7
	AFrXFwX7DqxTvZ8yqJDJWXLrKG6ddvobd/CkWF1mn122X3bKLPKKOupq9AqjlHHOsAX9RoOnb3O
	9HXGloKxx/6rCvEO1gop6CPo7h1tudUrf7/vWGQzG
X-Gm-Gg: AeBDieurym7T35ImQ1/uwIL5cHYL8dax/6h2mzRkbLZk0fJC4+QWPp9zMi9eHlr2vhT
	H70TE+7rEdwEGwCLvgH5jFZ40oJOu6nT87MvDw9RrrSofyRlL4dhxgVzu1Q4JSC1EQmEBQ1TkfK
	xDXXY6zfc1Oc4RTjDPu5Txly8zlrFLl8oZNMgAs5GluLrCNACHPnEa6pxbm8baOLT/70sM3Cn8Y
	2HfIYpyx1SEajmnJaACQKGMdGuyYgXfjNKj8zuM3wScZsRv09O9NWTiQSHuidkf8xJPy+BqeETV
	YDCiGZbDVAvY7t6hW+TpXcw6OSda1WmGrtRc3oPUUKiNGfUvhEpdyPGqfH3V6TFXUb7YgFf5JWq
	4is/1DhtjuVhypOegRF1PLWCiQOOKxvTsii6ojesi9dXFzOx49ByFc9Kk5jy5zh90GRwsqX7izz
	5e+mILcDY4
X-Received: by 2002:a05:7022:427:b0:12c:8e7f:1b30 with SMTP id
 a92af1059eb24-12deac42292mr2220710c88.2.1777581175300; Thu, 30 Apr 2026
 13:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430184405.1227386-1-kuniyu@google.com> <20260430184405.1227386-3-kuniyu@google.com>
In-Reply-To: <20260430184405.1227386-3-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 30 Apr 2026 13:32:44 -0700
X-Gm-Features: AVHnY4Ls7u6p0o5JMcAnAHJzpiAZfoiB3CE6dVbmTrXjuY0KiwPbdq7_p-En4PA
Message-ID: <CAAVpQUC83MxhfV-sreAPvfPJoqW=G20CPCPdRaQ6hvMt_khFtw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf 2/2] selftest: bpf: Add test for bpf_tcp_sock() and
 RAW socket.
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 11:44=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> Let's extend sockopt_sk.c to cover bpf_tcp_sock() for the
> wrong socket type.
>
> Before:
>   # ./test_progs -t sockopt_sk
>   [  151.948613] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   [  151.951376] BUG: KASAN: slab-out-of-bounds in sol_tcp_sockopt+0xc7/0=
x8e0
>   [  151.954159] Read of size 8 at addr ffff88801083d760 by task test_pro=
gs/1259
>   ...
>   run_test:FAIL:getsetsockopt unexpected error: -1 (errno 22)
>   #427     sockopt_sk:FAIL
>
> After:
>   #427     sockopt_sk:OK
>
> While at it, missing free() is fixed up.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  .../selftests/bpf/prog_tests/sockopt_sk.c       | 17 ++++++++++++++++-
>  tools/testing/selftests/bpf/progs/sockopt_sk.c  | 16 ++++++++++++++++
>  2 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/=
testing/selftests/bpf/prog_tests/sockopt_sk.c
> index 53637431ec5d..87e771c8991f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> @@ -190,7 +190,7 @@ static int getsetsockopt(void)
>         fd =3D socket(AF_NETLINK, SOCK_RAW, 0);
>         if (fd < 0) {
>                 log_err("Failed to create AF_NETLINK socket");
> -               return -1;
> +               goto err;
>         }
>
>         buf.u32 =3D 1;
> @@ -211,6 +211,21 @@ static int getsetsockopt(void)
>         }
>         ASSERT_EQ(optlen, 8, "Unexpected NETLINK_LIST_MEMBERSHIPS value")=
;
>
> +       /* Trick bpf_tcp_sock() with IPPROTO_TCP */
> +       close(fd);
> +       fd =3D socket(AF_INET, SOCK_RAW, IPPROTO_TCP);
> +       if (fd < 0) {
> +               log_err("Failed to create RAW socket");
> +               goto err;
> +       }
> +
> +       optlen =3D 60;
> +       err =3D setsockopt(fd, SOL_TCP, TCP_SAVED_SYN, &buf, optlen);
> +       if (err) {

Ugh, I forgot to commit s/err/!err/ change.. :/

pw-bot: cr
