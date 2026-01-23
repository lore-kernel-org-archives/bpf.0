Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A157923314B
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194379; cv=pass; b=uo0lC0NdFEf52YBWNMwynUbRNCoPWqmHBUwU3V+fafMY3v8L9cNf86TqjUt/htKle661UYLrX5KyQ5FIX31xR6iNj/uxp91U+6tskzjjIIXaXOq0CaIG33lR+AMRvSOMNVgqUUNgPaiCXl6HlJXF9Gy61q0mT2oDaeUd60arDQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194379; c=relaxed/simple;
	bh=z3EtqsDAY+x87WF7+9aLT4AVPsq/B/vh8YxvXKfaXBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svxLO2B97VPJl96zrPdQiCXd4skYhXaFE0HTTfcOgjf/f6I0/fdlqWbPzzsTqBnWUF4g/zNU5hYCQdQDk6/cT2WLJ+0KftUG+zNMWQYYV/ggjhbFakt4FJE7oS9Etovmbfr1LPE3LSr5zoEFrYYCUtGw4vxfWu9T/yqC0gysgFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ng9QfeUn; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ng9QfeUn"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34abc7da414so1457346a91.0
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 10:52:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769194378; cv=none;
        d=google.com; s=arc-20240605;
        b=UtUSzf17uOnhIb+2OuLcuhIGQWU4fpfktbYumuksmgRAFxwTepiDoWz0Lm4Xk5d6v1
         6H9M98W0qCzqGq969oIAf5SgMespilSU2psOado5Cl7Iw4xhj6DVrfTQ8rADidedOZkU
         yGzroMiPB9fNCrfwMDQGxKxfHilBV5Nk/08nq0Ouxsiyu5B0PIUV8f9in0PkNmPJlEX4
         VJj/ClId2VlEK2wR52yxhJEp9sjKtSjES6iJ6WbF7SMWAqr0so2wcKgLuk3ggjtv5BBz
         qiTNmySVh+BQc4SY/hWkjHIRKu506en69toZiQOTi42/gLsiuvs3i0qGbwswgaIs7cFq
         NOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N2X2oUhuqV8lqBjwyLuRAgoJAdlYDpctSNg1JkT30xg=;
        fh=iaw9ywCEPaOOZxWZ2p58MYo0/Lmv954FQ8xuWQj5jMc=;
        b=Knyf6PW39LIOGwaAlCEM+yBYveUGDta3baH8VmPPzgOEFH7zibUxw7P/jwpk5XtBc+
         B04Pu6vPXrD1AvXGc0D3Hi26kHYoJuyTSBV9dR7t9z8SRM4zxQAZigyH3yXUirxM3Ygv
         SAgwu24ZSfwDzbfX1SoNFDbVNl0d5TKNLe70F2AndBiezOQWbITb1MuID8KyiE8OQwrv
         WKxu/WGdY21lRiN8uWyk4I1IoVxYYjaFvkebk/uPFe0h3/60nf9X+9t2DJDhltJgPB11
         vRBd78C++qy+Q3hM+n11KZ/bPP4LLzEaiPA6OuzHQjaodzFBdqwj577M/C0qGZOkLN/N
         z5cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769194378; x=1769799178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2X2oUhuqV8lqBjwyLuRAgoJAdlYDpctSNg1JkT30xg=;
        b=ng9QfeUnUtGWaldLldWWP1YAYQfw/50B+tT0f5EnQgvolYeZvXsswPqZFIFvoxyhgs
         ajccn5uQK00JCHA/gEy2oWicHHgGmjnOobky1VOQ52mNxDuckuoLBup3VNI/w7Sssool
         1M/uuhrRqJ+WJTfafFZn1c/LuKbPNgWbM1ywsoOw7SAFkyS2gUlZPGWAnkyVS+6336Nj
         CO3KFu6grhlsJXjmVyBiKZ+yme5DWTBvYQ05wEXaj9mYVcapeudq/GiRi78o165za5/Y
         ViBVK8PdwLNwzMlFT31FJzmc8T88uNPW1+sme46Jz7mRI53C/9wSygwtLpKSCZ7q6kaU
         TNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769194378; x=1769799178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N2X2oUhuqV8lqBjwyLuRAgoJAdlYDpctSNg1JkT30xg=;
        b=inDy0Rgd4vaBxbv9D8V/ojYhHYd8xcJSB4P/SHMldYeRQ8L9LPiyt1vWlG8h73BZo5
         hsbbmU2MCFzSGiYzcPtYWYi0Ejacxh4MwV0lbQ95gkRKo6J7pEetZyvaEaQkphlblM4v
         xsm/Bu1aHsAMAGc5lfGUquZ4ELnv/1IdZ511LAliThAYMgBWa3+iyJK2rjzNyecBTROV
         exK4gEgbiX0vL36KSNPJE42th1QiBlAN7EM/plMxcBfPqYoHjVr/5pHNIP1aqm2MjO8Y
         FcDSCkQrXeVoMtP2n+XCAbiSUkGbPGyiEafSbqlwpu1dBtpPbkePrse5X+7A14fujKmC
         ad7A==
X-Forwarded-Encrypted: i=1; AJvYcCXthppxc0i58hKqa+5OvbDLlrL44vouL/Da4vdOdy/8ZJNJX3nRWb3cg5mw3N2eJAH00MA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+A+AKLw2eUPh6Lp9L2RJTee6WwDAQ6XnmzKswuUNyJYEeyFyv
	4CBKy3/TQKU1S0qnFAt6XcyNdZ+8Mq6XldErhxVrP2WCN/O4kI6+Ceq+w+x6jDsK6mdPTS0I3xe
	t7UkuB3yZeRZnBvx+JXfXozQQCKjbjsU5+Jar
X-Gm-Gg: AZuq6aIGUSid8Ep24xBwOye+iBvRi2FQRTcs/wQrsPOCptrr6K+5aTaCGdepgpAC180
	yfWcIYCmGIKPqBEmwxq1LEgLTosfzZCT0QvA+uVLhBWL3FN4AnXAR4IrADS2XfRZXE1yBuz3BKf
	gRRPBKGnN36Gm+YkjJJh+U9kX0lg+nei39NWy1nAhEUGSga0GW1ALygSF9Ir6DUGjFPCQWC3vMD
	A3bbQIccWO/j5f5Yv6tBAsBn8YEFqwsxbMJUPX/53UYa+Dg5mj1aCpQI3Za3Nwl+d8GWAJec1We
	FV7JOeACHXzUTHMB9fl24w==
X-Received: by 2002:a17:90b:3c05:b0:343:7714:4ca6 with SMTP id
 98e67ed59e1d1-3536894c172mr2714897a91.22.1769194377547; Fri, 23 Jan 2026
 10:52:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123032445.125259-1-leon.hwang@linux.dev> <20260123032445.125259-3-leon.hwang@linux.dev>
 <CAADnVQJLz+nMHCZXUgy2MOxwFczEHNbG8ZUgfZeUY4yXFUKcNw@mail.gmail.com>
 <a0ce1dab-7d7e-4b04-a033-4f0611090d34@linux.dev> <CAADnVQ+HJkOikzE3KPhOkd1KNugs7=1dZKY1mfog-ez8noyrDA@mail.gmail.com>
 <419976da-f296-4418-8dfe-8ad50a9f8cb5@linux.dev>
In-Reply-To: <419976da-f296-4418-8dfe-8ad50a9f8cb5@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Jan 2026 10:52:43 -0800
X-Gm-Features: AZwV_QiinsC5aYUNOHtelkljzXUfW0ud6mJXa6FtpZCanGP-V52IbcGr9qrZsWM
Message-ID: <CAEf4BzYhhf7Jd6DDr2XVf=3gKeMMmrkWW9Sr49QxuW6QudSKig@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/9] libbpf: Add support for extended bpf syscall
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, LKML <linux-kernel@vger.kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 8:19=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 23/1/26 12:12, Alexei Starovoitov wrote:
> > On Thu, Jan 22, 2026 at 8:07=E2=80=AFPM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >>
> >>
> >> On 23/1/26 11:55, Alexei Starovoitov wrote:
> >>> On Thu, Jan 22, 2026 at 7:25=E2=80=AFPM Leon Hwang <leon.hwang@linux.=
dev> wrote:
> >>>>
> >>>>
> >>>> +static int probe_bpf_syscall_common_attrs(int token_fd)
> >>>> +{
> >>>> +       int ret;
> >>>> +
> >>>> +       ret =3D probe_sys_bpf_ext();
> >>>> +       return ret > 0;
> >>>> +}
> >>>
> >>> When you look at the above, what thoughts come to mind?
> >>>
> >>> ... and please don't use ai for answers.
> >>
> >> My initial thought was whether probe_fd() is needed here to handle and
> >> close a returned fd, since the return value of probe_sys_bpf_ext() isn=
=E2=80=99t
> >> obvious from the call site.

Have you looked at how probes are called (in feat_supported()?) They
all follow the same contract: > 0 (normally just 1) means feature is
supported, 0 means feature is not supported, and <0 means something
went wrong. Libbpf will log an error and will assume feature is not
supported.

probe_sys_bpf_ext() should either follow that convention or drop the
probe_ prefix altogether to avoid confusion. And then
probe_bpf_syscall_common_attrs() is necessary only as a wrapper around
probe_sys_bpf_ext() to ignore mandatory (but unused) token_fd argument
(so to make it "pluggable" into feat_supported() framework).

So, just make probe_sys_bpf_ext() follow probe contract as described,
and then just:

static int probe_bpf_syscall_common_attr(int token_fd)
{
    return probe_sys_bpf_ext();
}

Alternatively, just make probe_sys_bpf_ext() take token_fd (but ignore
it), and just use probe_sys_bpf_ext() directly for feat_supported().


probe_fd() is not suitable here because it's for a common case when we
expect syscall to succeed and create fd, in which case that successful
fd represents successful feature detection. This is not the case here,
so probe_fd() is not what you should use.

> >
> > Fair enough, but then collapse it into one helper if FD is a concern.
> > My question was about stylistic/taste preferences.
>
> Understood, thanks for the clarification.
>
> I=E2=80=99ll rework it with the stylistic preference in mind.
>
> Thanks,
> Leon
>
