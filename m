Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ABF36C582
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073940; cv=pass; b=NWjo7C0CAA3K7SE/0utJSov72tWJI5+E2mpDiVzPvJw6CheynHeW4Idy/XyH7TVLMWTAxF0sDD8GW1E0x10JltKwtTe6FOcPvW1sJAmOK0ZxtEJRAXL4BRi4zR21XXkiv/4lM5j7Nj0pE+F0flYv3zjyzn2f1ATek3cgM1eAEUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073940; c=relaxed/simple;
	bh=C5pfTvV3WZ1I+9Ct4l7b0ZuEXCoVBX+ftcPRqIh7A5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7j91Vvo8RosPYunVUR1H03A5z+UtQ49bBDoy5t0t9L3oglq8U2JWpyR92ySw1Iu9tzu3R9I24tC8PqQHK/RcL2qlFbufy77ESO6zfAIdRkXHdPNZ1bZTme9UA6V0YoNdR6IB0VbWphvUJ0kkl2QS7qRo4V27ouyDCnfuytqRJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkqqUc/U; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkqqUc/U"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-479e6bc357eso2448003b6e.2
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 06:25:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778073938; cv=none;
        d=google.com; s=arc-20240605;
        b=SiUIw/yWq5+9IV3JoY4ql2LDZntTkkdKpMhsZoKOBGmQTYqNMMScASUp0ZLqlpXVfc
         a34vD+RdevAiEeGDwPSdz/MoUocXAbd4Ydjqc4tQJ0fJR9n8BWccTUig4Xe6YHGGyFDf
         EUWi5mR00lkDjJAjEZKtMvanNLDUOVsB7ipUpOdqKVW4Q6ktGHNVZBbjEBWv12rqBB0E
         4fhsYWUnvyGTZsLEV5/q9xxREvdf7JFL63eGF80m01JUj0OBj1ouM7kPz67UvV7mKovr
         N/OxpbOMpZve4Rx89jDahuvyODpx18ajc89Whib43sQlggWJaF+TQiHlX27ZZARhBTjS
         u9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ezi+8kjcpMLH8rfbERu37F4krA9iSvG+U1DdJlGPhOg=;
        fh=8SPsG2PN0WUnPTc9pTACrl1Ic/8tEkEyj+JnkzNjifs=;
        b=K14J4MB4j0fCStW5bvEZozJMfnhyZMngGMAUSi+8tow7RPvtT+ztaLCt/rYPqv/50Q
         80QMOaqdRr8oogl3kULJ7kHu6pzhV6/Jiv2WSD7dvV+wfsn8DmY+wmeCdkLN6sQkJpXI
         XvYz/wxfN9GSQ1MCtbNtwYhgxS1ktmVRYcHSPuDjvqfBaXhfgJq+zGi9OYgJZPEpKqsh
         kXl1ry8z6DyJKGhQaO5/FiOTlSEL+C94x/rPl/V6JI2eC7kFa4d0UPFYPiXxn7fZtkKd
         +lbG4NW7LYoMzeczlMdZ2J5cn53nTDa6AH4D/OA07gvQcP2Pw3fewu3n0V+vG0BPavQV
         LoXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778073938; x=1778678738; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ezi+8kjcpMLH8rfbERu37F4krA9iSvG+U1DdJlGPhOg=;
        b=GkqqUc/U5vc6nciWSZ/ipa2LwjSQah5pZyEWxQwz6t6eiFfx2YNH8BK3NiRnYlTzWq
         w4ZQUi3qE+t7X7Yj40dTOh3U1bxtixYH469+dM4ZeDySwO3rOV9Zn0d4TWjZVSXk8z/Y
         zb1yWV9Jl7nhZ5wE+tPppc1D3NkqMvSB0hKcRXlWWDOBVvuGwLYHDZbIuFDRPjYiRMe8
         ILB4KaatFQ3QMpLraB19m21iumoHo4vpsEvB4tqZ+GAoGAErzxXvAFiH978SHt+psTLf
         queiO3AayKTyaV/N53Wt6kC9qF894f442v7iPgW14+MzBaaT3HYV+XUuWTmc1wnvd5XQ
         cCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778073938; x=1778678738;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezi+8kjcpMLH8rfbERu37F4krA9iSvG+U1DdJlGPhOg=;
        b=gEVt/YfWG8QT83CqR5UogzagtozLc3S2/+W5FKK+acnc8brcmrSI1sqC+n5XVvlooH
         HEcR5fju9lyEblBKwHbYKvqYds1O9+jpz5vdIPmIR7P9FUkOcLXYWonujv/xuRGCCEco
         4cxg2k1axoKB2jFrzvaPG7QyGO1yVEnuFSa5B0TtINrEfoHlqyLvaWolXNZCEjLrDWtZ
         LMo+g8MP5Rw40YGMg23+qaeZgijVVA1taUb3z1Oq4UCP5nItpITgH0feI+HwLwBMQj0K
         tHYA9YOHFMOdi+7zhJnydMubjqsrEuLXSRZFkmORqaXOSafXcouG8usdRIBNb5XSjevx
         hw0A==
X-Forwarded-Encrypted: i=1; AFNElJ99NX/6YgeENr69bh8g0tPrcYTYApntRqYXhk59boSFucq5b4KdtFS9smzcPN52s10lpVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZcmhDMq4gZm/bmKuLbylPt1mF3kfpzct4ypEg9e5h7p8eDdas
	RxlUJGXEK8zMGq7UexqdGKXB9CYFbd4TS4X68LPpCjpcqL28FQB1nQDdOsUdGeie5+i8UQQ3ubE
	GEe0bfGcjDpuFOF9ZAvjDVsJlw37FlZ0=
X-Gm-Gg: AeBDievbKc4ZKgAq15T8n3ro0JJbrgPLA9jyckX3dDF0ieyKSrtGBEkgA18hd6e8PwW
	NBcpzR7WAdMAG3VvRAD0SG7pksK1D5V+dDF8BMO2W/pc7P1SHjHVqOTDLDLj6j3xYBRpz9AY8QA
	h+mNaVdUcWLoy8Atw5e4gx8MmB7R5M4Crc9CpNYln4A1ftCyTv/1DP0OvlP62U5uicW0uYo99uD
	JwXVzN3w+oY/oomPsb9PrlmQtqyGCMCKMbd09yTIwxCJVYCHNDa0wu34cZwDxoofZGY4PmK0Wv6
	9/SMZkTV/+7cyNY=
X-Received: by 2002:a05:6808:bc8:b0:466:ff78:138f with SMTP id
 5614622812f47-48042496c2bmr1944836b6e.29.1778073937776; Wed, 06 May 2026
 06:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506065048.592474-1-paulhoussel2@gmail.com>
 <20260506065048.592474-3-paulhoussel2@gmail.com> <afs_CIQUer2tfh_3@mail.gmail.com>
In-Reply-To: <afs_CIQUer2tfh_3@mail.gmail.com>
From: polo <paulhoussel2@gmail.com>
Date: Wed, 6 May 2026 15:25:25 +0200
X-Gm-Features: AVHnY4LxYaXCVd37NrLjUtWeNdQ4H0yD_0CPRZXfARYI_N7z7z4-QQDYd7jMsDo
Message-ID: <CA+aJb_07N8ggcSL-tomJUHoNKY+u46vtojNyFercfN7=W99p_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/bpf: add tests to verify the enforcement of CONFIG_CGROUP_LSM_NUM
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: paul.houssel@orange.com, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Florian Westphal <fw@strlen.de>, "T.J. Mercier" <tjmercier@google.com>, Li RongQing <lirongqing@baidu.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Indeed, the arguments of LSM programs can be omitted in the BPF_PROG
macro if they are unused. I'll refactor the file by using a macro.


On Wed, 6 May 2026 at 15:15, Paul Chaignon <paul.chaignon@gmail.com> wrote:
>
> On Wed, May 06, 2026 at 08:50:48AM +0200, Paul Houssel wrote:
> > Add a selftest that verifies the kernel correctly enforces
> > CONFIG_CGROUP_LSM_NUM as the maximum number of concurrently attachable
> > per-cgroup LSM hook slots.
> >
> > The BPF program side (progs/cgroup_lsm_num.c) defines 12 lsm_cgroup
> > programs, each attached to a distinct LSM hook. The test side
> > (prog_tests/cgroup_lsm_num.c) attempts to attach all 12 programs one by
> > one to a cgroup, and verifies that exactly 10 succeed and 2 are rejected,
> > matching the value of CONFIG_CGROUP_LSM_NUM set to 10 in the selftest
> > Kconfig fragment.
> >
> > Signed-off-by: Paul Houssel <paulhoussel2@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/config            |  1 +
> >  .../selftests/bpf/prog_tests/cgroup_lsm_num.c | 60 ++++++++++++
> >  .../selftests/bpf/progs/cgroup_lsm_num.c      | 92 +++++++++++++++++++
> >  3 files changed, 153 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/cgroup_lsm_num.c
>
> [...]
>
> > diff --git a/tools/testing/selftests/bpf/progs/cgroup_lsm_num.c b/tools/testing/selftests/bpf/progs/cgroup_lsm_num.c
> > new file mode 100644
> > index 000000000000..0cce61cd7b26
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/cgroup_lsm_num.c
> > @@ -0,0 +1,92 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2026 Orange */
> > +
> > +/*
> > + * 12 LSM programs with lsm_cgroup attachment type, each on a distinct LSM
> > + * hook. Used by prog_tests/cgroup_lsm_num.c to verify that the kernel
> > + * enforces the CONFIG_CGROUP_LSM_NUM limit on unique per-cgroup LSM hook
> > + * slots. With CONFIG_CGROUP_LSM_NUM set to 10, 10 shall be attached and 2
> > + * rejected.
> > + */
> > +
> > +#include "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +SEC("lsm_cgroup/socket_create")
> > +int BPF_PROG(hook0, int family, int type, int protocol, int kern)
> > +{
> > +     return 1;
> > +}
> > +
> > +SEC("lsm_cgroup/socket_post_create")
> > +int BPF_PROG(hook1, struct socket *sock, int family, int type,
> > +          int protocol, int kern)
> > +{
> > +     return 1;
> > +}
> > +
> > +SEC("lsm_cgroup/socket_socketpair")
> > +int BPF_PROG(hook2, struct socket *socka, struct socket *sockb)
> > +{
> > +     return 1;
> > +}
> > +
> > +SEC("lsm_cgroup/socket_bind")
> > +int BPF_PROG(hook3, struct socket *sock, struct sockaddr *address,
> > +          int addrlen)
> > +{
> > +     return 1;
> > +}
> > +
> > +SEC("lsm_cgroup/socket_connect")
> > +int BPF_PROG(hook4, struct socket *sock, struct sockaddr *address,
> > +          int addrlen)
> > +{
> > +     return 1;
> > +}
> > +
> > +SEC("lsm_cgroup/socket_listen")
> > +int BPF_PROG(hook5, struct socket *sock, int backlog)
> > +{
> > +     return 1;
> > +}
> > +
> > +SEC("lsm_cgroup/socket_accept")
> > +int BPF_PROG(hook6, struct socket *sock, struct socket *newsock)
> > +{
> > +     return 1;
> > +}
> > +
> > +SEC("lsm_cgroup/socket_sendmsg")
> > +int BPF_PROG(hook7, struct socket *sock, struct msghdr *msg, int size)
> > +{
> > +     return 1;
> > +}
> > +
> > +SEC("lsm_cgroup/socket_recvmsg")
> > +int BPF_PROG(hook8, struct socket *sock, struct msghdr *msg, int size,
> > +          int flags)
> > +{
> > +     return 1;
> > +}
> > +
> > +SEC("lsm_cgroup/socket_getsockname")
> > +int BPF_PROG(hook9, struct socket *sock)
> > +{
> > +     return 1;
> > +}
> > +
> > +SEC("lsm_cgroup/socket_getpeername")
> > +int BPF_PROG(hook10, struct socket *sock)
> > +{
> > +     return 1;
> > +}
> > +
> > +SEC("lsm_cgroup/socket_shutdown")
> > +int BPF_PROG(hook11, struct socket *sock, int how)
> > +{
> > +     return 1;
> > +}
>
> This should probably use a macro to avoid being so verbose. AFAICT, only
> the attach point needs to change between program declarations.
