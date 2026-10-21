Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792604526;
	b=v5TxMaYT15D2i/TR00grdp1qBfBTQGHPJDMbeBhqVmy2D4WtJQDkq/rwjJLL7TmGcoOC
	 9XVvg6AS6SR9zN9yQJeX8+c5j8B2m07xjMiVWfKkWxkI0t8Av0BqBjsGMwgHErfBGLcow
	 dfUMyq2FdJLyZqTCD4mzYjrPtXd+EU6RjjRGBFMn4fau1t6wLoK6RM7L2NxJXgiJvL1oU
	 jxShWDUPx/78z6E8P21ApaWAu4F3UZ778sfMprs8fwL3x+PIQALXfdQbNj0m9ByVNe6He
	 pdK1E+V4KBPVExXQAymDi/1lqNfPfe8ZGlsRQXiivmaxdh5XhdB4ofbZ4f3uheS1zTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604526;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=WbPfC3xf415pZLIbAAwGQiH8uDkz76+8nE49QrFCe/Q=;
	b=L/8LfS/H5IP7bD4PTppgtv185usK4b1MJwDcIlBRk35RbgAVm+DeGbPqk4eFj/8gjaZ/
	 EqXpYnD305/s2e+owpSWExHtv2PznaGBj2DXbjeZx+dChlyhvhRX9jn6C2ORnApJGNzyH
	 VRivRaXAP75j/HfkQH38R5jr4gnrl+CRY4GxyZIMYIOaOSNl3eFNiujAdGFsuqOjzymOz
	 vV1qomItdUHG56KJSOx1jsdZ2TZtdM8xbmJCg7XI8l5mHTvN2aLzsd3T4EmMmw8G7rJ4y
	 skeNXvdXE5DD2JbMMMKE4pgbzp4pkZOcx1w0IAOjx7GcFHJOBvCHWCOd+tqXhl9dOBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A174606A31F
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 17:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A174606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso556899a91.2
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 10:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792604520; cv=none;
        d=google.com; s=arc-20260327;
        b=nMEowVKL5oFfD3RjaVBzu7lYqQWucGKfld/SA+ibI8fQZZRyNXexIgxexPr6JBNJEG
         6L6twNV+wW7hZyXAhLVXWYhykfiM51i02EKQLRe5iE60sjWyH4vudkaif2kI/w+s1IvN
         dfHQqitI3SV5m992pUnDf/wUJfXERDzTHI9zEY4T+E79P4QCkdSGYNPsPwXj9DZ8hkgy
         o8riNg03uY3B3hp3DZKwHt0jBqygV1vyGpgUU2Bi2K1JS8QBaHdmZ4rG3c+dK26+4PKW
         cYDKkuPvq86ByyMyPbxuKYnffvvqZ8E9vGReHVJ59AmI7ZkTVbTIcQDQ91oARNCdXjq5
         pDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WbPfC3xf415pZLIbAAwGQiH8uDkz76+8nE49QrFCe/Q=;
        fh=PvUGavGpFlNRd7NQy2ALC1wcQIZjFG1VK/PefPLkKGI=;
        b=UuvYXGAwpppYh7xI+8MVEjVbwt93XaIOdXYaIX+epRnAgwuyzu+MZ4GlbpX9x1Lwsh
         ZAOyHShmqxWQQZFst/klU1IINegh5jBWkkbS4RQo41ojUFZzMCDxPtYcTEaUS/8whviz
         aE2JdB9luJS7/oFp15hkjypHNAWkXuOG5uBfVCJPf8cocCg1I0cbfgFFHzl8X+daaYds
         2aVmb3h9fT2Z8CnCuwPvYvlVGoN719GQCWbRcI/RicUcQyVTjA7ZpzAIbBa5xNNEJ5w0
         DmuBnDd8iTSefVr7CnLHd6xxehKVv4UAR8M/BDFSyBaGEGNVNG5fy9snUH2ljDhEVCQZ
         8E/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792604520; x=1793209320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WbPfC3xf415pZLIbAAwGQiH8uDkz76+8nE49QrFCe/Q=;
        b=GvAbxW8UXtF+sRo9OMu4rbiOvh/ZUVz/YIvz0PscUkArcnkkSoHXjx90jpuxuMfVj+
         gvaXcIpvK/50UG3alQJ1Dp+2g0gdqjTAy5dm37l86wOcXJrukh709bQOUA+kBnTyfJi8
         qZtNnpMZsfDYyI6WIxZvhBlQZbClbbWY0qrp2jd4DE/n1oA/K0IeB0+YkDIMXH+Xuj5T
         HPw+nY/bs4Z0G4Xi/rxh0plLMUug5NI98mr/u7qmV3y0SN6sva4+Duq9Bz9yHmm7Kk1d
         jtodxu+rnwuW5xb6SJB7Sri91KGj7ab04wNmbK0F7wLB2SDE9nwKdnQabNsQv+yJvzy9
         J5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792604520; x=1793209320;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WbPfC3xf415pZLIbAAwGQiH8uDkz76+8nE49QrFCe/Q=;
        b=ZM2IyYwdV4pJ3dbsSn1QHXNV9fhTx3t0hqZeENQjnQPicNafrNURb5BuxwXYlmufro
         Pp6Q1OlT+n3bg0dSxzZC4PYDh7NH4JYVPqYtC19ELg1QwaIzvOXY/NvPIswkVurcAU6U
         le1y3TUZKeFjIBFTcA7UkuiDUGFSCmRNOQbhTIfkWx6HSGqHHvP2GXKVb8W8FQP32pi2
         djGS4FBrXS9RahU64l69gwJpNHdiqIVAUL/u9kH/3cLosAfzpXpf5eoM8L/DnCloBMFM
         RwZ2FENxBlJ6vzaUafCcpPZ1pP8p+37LU+EOJwcvz8HdK6w3q7LKVTJVnj+UYP1mctOw
         BKMw==
X-Gm-Message-State: AFq9FYJYPGy6uUQ99JHHhhvhFA7HR5AotcKfkaTkhK9IOcqAEy/Q+L1L
	mO6WDVEsDPHBcaopsvTisQdjtq+K7eLpFtCsFL+mFQCuQRUMoEEJrREoXYq1YaauSobTWHcOpC1
	3E1qiAX78am/bpSZryqolihDCpTp0/iU=
X-Gm-Gg: AYBFou3HREp75C3yQuNp559/co5uQfCTDZjmy2zXabtxvadSKbhTfN1KKY/o+BF7BAw
	SRBQt0orDLmtMUgPf+OL5S8JnciH+yD/mR/Gsq2w5QO71+nWreTLMUmwA88gr7WY7jX3dcJdrxy
	q/gr/G3GgvciWPfGmoJPhTfGAaSlqJB4oFyEJB5AD3soPTcoivgbgNUvtmmd+gyGQzBY5H06mDd
	qVpWxaM1Lib5jMZk6LLJf8kVTAD5SRicWChnG67sbwLvd0RwG1e2jt2bSItWSV8OE4peNBXkDYL
	czKkw3Vqz4a9dfZs2TK1SysjGgbhJGGlq1RiEieNNnrB1GBGd+Uy+7VZ5YuO+4uFo6iDJ5oSk1/
	3oNhuI3V9tTng0AjGYUbS1ehZMRepUwOrmgI7ImHijrzFwfrbzbr8/FKxTSO4alExSfq3WVXpHo
	qUKN3vZT253OiKd4EGVQ==
X-Received: by 2002:a17:90b:258c:b0:3ab:2ad1:f10a with SMTP id
 98e67ed59e1d1-3ad86ca45acmr2134722a91.0.1792604519654; Wed, 21 Oct 2026
 10:41:59 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019153628.15912-1-leon.hwang@linux.dev> <20261019153628.15912-6-leon.hwang@linux.dev>
 <CAEf4Bzbr46UkiE1sbb+Zwcs0S1ejpKmtTGjNCAkWD-J6FRcPGQ@mail.gmail.com> <d4fc4fcd-3691-4122-8b3e-a75447956255@linux.dev>
In-Reply-To: <d4fc4fcd-3691-4122-8b3e-a75447956255@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Oct 2026 10:41:43 -0700
X-Gm-Features: AclHuK8euPDDrPLcZ78w73yg4ZplR7FA7dJCpvboj2MZKSFYtjKIdYl4Mw0-_4w
Message-ID: <CAEf4BzY13x1skc6XSnXGyoLwaFoOtENGokUX7XHiakEyw+eQEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/6] libbpf: Add bpf_link_create_log API
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, Masashi Honma <masashi.honma@gmail.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 8:27=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On 2026/10/21 07:25, Andrii Nakryiko wrote:
> > On Mon, Oct 19, 2026 at 8:37=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
>
> [...]
>
> >> --- a/tools/lib/bpf/bpf.h
> >> +++ b/tools/lib/bpf/bpf.h
> >> @@ -484,6 +484,11 @@ LIBBPF_API int bpf_link_create(int prog_fd, int t=
arget_fd,
> >>                                enum bpf_attach_type attach_type,
> >>                                const struct bpf_link_create_opts *opts=
);
> >>
> >> +LIBBPF_API int bpf_link_create_log(int prog_fd, int target_fd,
> >> +                                  enum bpf_attach_type attach_type,
> >> +                                  const struct bpf_link_create_opts *=
opts,
> >> +                                  struct bpf_log_opts *log_opts);
> >
> > Leon,
> >
> > how about instead of adding this new API, we try to repurpose
> > bpf_link_create_opts' iter_info to be used as log opts? we have this
> > right now:
> >
> > union bpf_iter_link_info; /* defined in up-to-date linux/bpf.h */
> > struct bpf_link_create_opts {
> >         size_t sz; /* size of this struct for forward/backward compatib=
ility */
> >         __u32 flags;
> >         union bpf_iter_link_info *iter_info;
> >         __u32 iter_info_len;
> >         __u32 target_btf_id;
> >         union {
> >
> >
> > that iter_info/iter_info_len is a bit of a legacy before we had
> > per-attach type union, what if we add iter section into the union,
> > wrap iter_info with union and put log_opts there, mark iter_info
> > deprecated or something.
> >
> > I'm not sure anyone is actually using iter_info (I didn't find any
> > uses in Meta code base, for instance), but we can detect its use by
> > checking iter_info_len: if it's non-zero, then iter_info must be a
> > real bpf_iter_link_info. so we should be able to detect this just
> > fine, the only downside is that you can't use log_opts and iter_info
> > simultaneously, but I think that's fine: you can update your code to
> > use new iter.info fields instead, if you need log_opts + iter_info.
> >
> > WDYT?
> >
>
> IIUC, the struct bpf_link_create_opts will be changed to
>
> struct bpf_link_create_opts {
>         size_t sz; /* size of this struct for forward/backward compatibil=
ity */
>         __u32 flags;
>         union {
>                 union bpf_iter_link_info *iter_info;
>                 struct bpf_log_opts *log_opts;
>         };
>         __u32 iter_info_len;
>         __u32 target_btf_id;
>         union {
>                 /* ... */
>                 struct {
>                         union bpf_iter_link_info *info;
>                         __u32 len;
>                 } iter;
>         };
> };
>
> Thereafter, iter.info is preferred against iter_info. And to keep
> backward compatibility, iter_info is used only when iter_info_len is
> set. But iter_info_len and iter.len are not allowed to be set at the
> same time.
>
> With this change, the bpf_link_create_log API can be dropped.
>
> I'd like to drop the bpf_link_create_log API first, then add iter.info
> in the series of log support for iter link_create in the future.

up to you, but I don't see the problem of dropping bpf_link_create_log
API and moving iter.info in the same series

>
> Thanks,
> Leon
>
