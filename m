Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68AF2E091B
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 21:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782507849; cv=pass; b=ah9VgZ/DEDq/uGOy67zKWbnnKPtD1D4ybNeC4NsuSx4/hp9z0/toOpyfeNwL2Nk4obscIzoh2F0PglXTsNnb993oWHawBZ5lsUY0XVHxDbnQ/VDb3qe2xdXko5Umscav37ux7bADjLU1b07SZYOnQE9sgp0XlPyPMeyqq9gKvb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782507849; c=relaxed/simple;
	bh=Vwt5xW+F+uiSa1tQBJJ8nSM9E4LO58GodGc6uVU7V3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNV8rsFrwx3cnzPCm5FRhLtCDE+TsDUjaQ2u8RdhYJJfrRh6L4rlf6MvmZOpIdfUJKBVWsyzUQEFznKqn12J5qQYp6u9hP+aRWGsGQSBYi/dMau2SVHaYTQZfFP9+qG+KuxOoBzJD8B9fQ0i6rFFSaSt7aCnweVN5cBSdMr5Yj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RQbAIVHV; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQbAIVHV"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso443133a12.1
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 14:04:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782507846; cv=none;
        d=google.com; s=arc-20260327;
        b=b0qXfUoAl8eKkGDr2oxrfKH5rbQPPpBYbKd6gNtc2r+e8E0NZcR/TyjfpaahFHKOJH
         jnVrcsYoEG+zOBi9uxSBOPj1LibmcqjPg3N0+brrPufM+LOqo5sOSmlSQcEUqSouMfpB
         Kbk7hJ8sjB9ki9F+H0mFlYPnLZ7dF9QXNoRqA996oyZ0Rk+uJL7uGjrdrgQ7qmrwz5F3
         XdSIBJ3PyvEY7csAKkTcmKmK7IU3iMtF/++wOhcsDf2EZD1Dai2gXbJJVxk/XNvnf0Xn
         cU7CdQFNnVYlhSjPIWjT3sb/Wil1V4MBv9lUbhwA4vIqro4q4nybWkQTq7cmLF9bfLEU
         IHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tvCC8HZmChXEnRo8N9gbNXNqVSfwU8t8eArZec9rkjI=;
        fh=uweRL0/LZxwd345KDYuQqyZfCRPPhAxVH8OWFuXMTWg=;
        b=XUy4SCBWQQqKoolyHsvX4oVY1kAZhyLSL/MXaJ9bP+tk3OsEjc4r61lkZiOCKNVYHa
         0blayEuaefa++MSCpM9zupLk+7FRdim1a5vRapiLRh/yIUgVuiwSSxDv81ZxUbP1Vbzf
         fEwO+/DxUQmhFs3tF0U0ISBuWcBR0EFE2KkUt4QEpd7cKKe6v3LfLA3Wjx/liKFkn+hY
         Fuy7h1cc5MZfBsoNiG7KZWWyLkeitTjHdQaPnOY1iYqf9+W9VCF+mjtLWWQNcqOR/AmH
         CTFbqYq+xR4//mUOsTZu0HXAAP8tScR3OEp9NY/CYDHm8prONd+V2htljAJzTu/b0ZLZ
         5gzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782507846; x=1783112646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvCC8HZmChXEnRo8N9gbNXNqVSfwU8t8eArZec9rkjI=;
        b=RQbAIVHVzTu+u5DJwVg+56s5qoOktbvUMx+93V2Mj/kvl58IkMc0hFN9Ord4Mgn9yg
         bRjxKXSSkBzR99R6NuihGd9rJWlzc/8CpgN/qltnwnRgCl4WH2BG0GtEq/oMzNRgcgMA
         u34e1dFzklc9lyj627vBex6wkQMlIM/YjiTra6tonnka7/K2yY6bIm9hSnY9T0yQx2T1
         mzPq4iVh2SsQW2Ukg5qYnbYLr16q+0xjEmAR1ND4aajDhdYqRR822vOzQ883BjgeDtyf
         lsWxLKlhzAyYhQhKnO9urh+SyLd+qARQ2+4nlkmO8HdXtKPK505ICOTdxSdb1Uv+4j+B
         O0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782507846; x=1783112646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tvCC8HZmChXEnRo8N9gbNXNqVSfwU8t8eArZec9rkjI=;
        b=fQIHqdLSdw/vMWmIdjIsn2G8rAjA1wDoSD1pUjl4JE9RbmZ0BwbbrDB8DuuIFwAL4M
         CFBNqy6KvETw+iL4uOl7mXpjJGFQimacwpAh0GRMj/FOW8I8hGYf3HVGQGwt+WOo2qaL
         Z8dhHn5QK1FAlz2ULdj3m5RKOzqCi6Z3vmU/6L3O0fIrTR8CPEvlLmTJx814Pj8RRS3e
         +OhpKjQm/9c/4icRj+nUISSbz7pivl5D83J0/ahV2w4MSzG5EfS7xOv/OxGYQkNOXY6R
         TZcgL/GwlmvUt71FGA6srUKRxvSJFmKn65okbCvu/v0NYzvY+QHyQxIhk66N+L5lvu+y
         dnBA==
X-Forwarded-Encrypted: i=1; AHgh+RpxVdxqStERG8RYJkUvbjUQE/Jq9i0rCMXPboED7k+tSbDRrYra0zuxzXkpYeIqmAAHuRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlyyX6Z+OVcQV1Hn6GRKhxn7Tf5nLi5WB1Ix9vQiZ5V0ooroyZ
	sGv6x7oUDlO3kqYkWJmvAvB8QBRVqsf7lfk7o5VXsetUZWnvDUIj3ksCS1vXOC/5IYL67EaL89y
	sVzqaoENT+U1DsJSPFTDm6uMiYuisx906efaw+3md
X-Gm-Gg: AfdE7cm4Hbl1OPyCPkczM78DtcAiYEPp3+GDEVpJAEYswaGe2WoSfKMLSV8qZ0ynEex
	IW7sI5fqfDfeUXm5pagdRNFxP/lmFo976QliW5BzNlh+xxp/mPOap5VHGtUJhem0Op9gNH+v3Jd
	fWi4jtWu/KuVMQSILKEWfVYWLnGnegbCPpCASeTq+ED6+IzwGpS1wHwbjA1oDbCg/wadaoRvsk/
	3dB3TqiQFKGM7hEUfUfC7alGhZwZENLXL+BMKkuejjFYmFr/4EEADeKJWHfDV++nXyIMSdnHSrm
	+EdDDfPu4kROW7hxVopCUoCtU8yfW5KmxU2PxFU2dQ2sW9qEt1NOPfsIvS0B317l3IDrKbjy9Gy
	TVidAJi3nFoX73gk04NZkHD/GlhiFpu/S3z3BsKQ=
X-Received: by 2002:a05:6402:d0e:b0:66e:abe5:ab22 with SMTP id
 4fb4d7f45d1cf-69810a15744mr3008960a12.5.1782507845615; Fri, 26 Jun 2026
 14:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co> <20260626-sockmap-lookup-udp-leak-v2-4-7e7e201c951a@rbox.co>
In-Reply-To: <20260626-sockmap-lookup-udp-leak-v2-4-7e7e201c951a@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 26 Jun 2026 14:03:50 -0700
X-Gm-Features: AVVi8CfI1JvVlmFD7FSw9WWO-q0ESRJAmfkw-4ZmG4UOIO4tf4PPeHZBhXKMPPU
Message-ID: <CAAVpQUAJYkOBEtgUpL5UgnwM9Hu3Y57a9xZWRy7zHg5XkGnW5w@mail.gmail.com>
Subject: Re: [PATCH bpf v2 4/4] selftests/bpf: Fail unbound UDP on sockmap update
To: Michal Luczaj <mhal@rbox.co>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Cong Wang <cong.wang@bytedance.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 1:37=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> sockmap now rejects unbound UDP sockets. Adjust test_maps.
>
> This effectively reverts commit c39aa2159974 ("bpf, selftests: Fix
> test_maps now that sockmap supports UDP").
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  tools/testing/selftests/bpf/test_maps.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/self=
tests/bpf/test_maps.c
> index c32da7bd8be2..81cd5d0d69c1 100644
> --- a/tools/testing/selftests/bpf/test_maps.c
> +++ b/tools/testing/selftests/bpf/test_maps.c
> @@ -759,12 +759,12 @@ static void test_sockmap(unsigned int tasks, void *=
data)
>                 goto out_sockmap;
>         }
>
> -       /* Test update with unsupported UDP socket */
> +       /* Test update with unsupported unbound UDP socket */
>         udp =3D socket(AF_INET, SOCK_DGRAM, 0);
>         i =3D 0;
>         err =3D bpf_map_update_elem(fd, &i, &udp, BPF_ANY);
> -       if (err) {
> -               printf("Failed socket update SOCK_DGRAM '%i:%i'\n",
> +       if (!err) {
> +               printf("Failed allowed unbound SOCK_DGRAM socket update '=
%i:%i'\n",

nit: Maybe s/Failed/Unexpectedly succeeded/ ?

If we want to avoid breakage, this patch needs to be squashed to
the fix patch, but it's discouraged in netdev, not sure about bpf tree.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
