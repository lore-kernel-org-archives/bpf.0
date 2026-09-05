Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B5723D28C
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 00:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788569730; cv=pass; b=Cp8niuOyvvcjm4qetHQQFzAlWP4J8LW9xMiLaxlqhyDcBELdpYHLXompcObeI+H7m+I/1xu94fqsdxwKGbE1bz+eGW8A7AZxHOrtgrQX6Cv46TaGjXG377wRnqTa53gkV3UR1QajKOulU+8P44TeyVTFeIe1o0gl2V2NgKCEjfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788569730; c=relaxed/simple;
	bh=uPysR5GFkyCY/qE0YCzGd8ZwpPP3JXLnMqhzAo7gH90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Su4kAqKJ0W7OtBBTG+FnSup4RU2ypDP6WTibupjAH7eTcwEVzFCDKJmqc9Q6FaueOzc/HEG8ixY4Rbh2J/kqEiKmIKHU+VTMhp66BIxPDcUmyh/CHxpgW/KcvFS9oDh1GvYJ6zNq8hCkkcCKqZekSdnfs/gt7U/ZIgvLvpGaF3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=hKs/C6u0; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="hKs/C6u0"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-86c0e4dd49cso21561607b3.3
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 17:55:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788569728; cv=none;
        d=google.com; s=arc-20260327;
        b=QABGaEReR2A1N4nSmXWqvkVKT7GcgO+p2PrTWJl0JsDBoZ+gnJehMljNcZTvH5NWcZ
         eQWjhVrRotT87NpXTVnfMgSkqR8yjs84XNkoU1uGEZJlvMKTGIPkCqOg7bHDMeXN4SlJ
         IX0cjvKuCbZwQuaky0NOiRgb1/wXJVOKYMT7RX5+N/3lgArzYc0dVruVvA55ubJf/IwS
         yBoYZNgc6a/Q7dTyn1m/s8kHrmp12MzrFG+mmcMOO3urlF+bOgLAo9//3U5EaX6rYskz
         e4c/bN1uzA5kLzNRJ2AX5q2n6t1UnqhyA4UmBHXdmPHOsNtE+CkBtRk4ITzhS2sf6H+j
         KWWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o2ZcMOhNLSW/gCHzJ1Lb1NgDbEasJyqkX407lKXNvbY=;
        fh=eLPn84XM2Xqaf8/ftZ6Qmi5CCU2ORPG5KlY9cjuntSg=;
        b=GlCUc+U4h4LXR3MV3dpNUFItZ4zE/gAhmpSZPyTWaPwUSd3bQbudgpe4/eiGFlvZdK
         0iFE22vrQoqPSGOu/dZWNPJMbQbU6d44TuirJto1y/Rhzac5rbOEUjt+wAnPBOrbINn6
         +jpNSgwQ8T73DX4veAPN1cBMfOgnOqJ3RUeAe8MCLynj/eedyL1Wan6j4ZfZpLTW+Cez
         fbH1UpFkWNcZWr6LVXpyzXkzhQ56kHx8XRetCUhZQETkJillV2pbLHLBe7qdT9vzfo2P
         E+qZDylZ+RuM5VTBDxukEKvBh+mU/KC6zJCG6SjAwqZe3zMkk/hkGlVRY7uXBOA/LhDf
         spFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788569728; x=1789174528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o2ZcMOhNLSW/gCHzJ1Lb1NgDbEasJyqkX407lKXNvbY=;
        b=hKs/C6u0ncsJZXhvsGxhlFZ/zYUqxJ/pC6z65oAb/4n8Wjx1zk9Bnjp43PN+hXSL/H
         w0oMMDhv6vg2Cpy+hUloiIlnpAVj02Y+QZ6Qw6CXMG241bQqTmbnKETOMaPD9GTQ3CmW
         KoJ43Iltbq2/PcsKgzQwdZRR2mx+dR41vNLA235BiJ1UK9BkdvE0TGY9FCL/tYxh+bH/
         +Rt1yFzNSHhJoMNWs23LRkCyMIjM6Rl7CgJP0BHjRLFCEvoYW14IFrWk8BQfGTkSEw9B
         Dbhn/nKQ90USRDahbCKx2O87nPo7QlFZtZIZLq8yOoXMA6D2CM1E3m56p0R2wZUGPKC0
         w/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788569728; x=1789174528;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o2ZcMOhNLSW/gCHzJ1Lb1NgDbEasJyqkX407lKXNvbY=;
        b=S2XgPGqdL55aHs0aj+T3SG5GlM7RUAsamuxK/rujNMtV4BRxQbCCy/ff0ztFyyT4d4
         hzWEPEvFDPVbzRSb+su7c6xv8d3esVvSkuOk7U0K7ZgfnBarm3XzJrZqZj0uLEdcQYzl
         K9vIXiHdrEowXRtJ0/7y0nlH5kpF14GF818aItaf4lkuPHft+HI59ICvqVLX28b81rgu
         Q2o1j6TD3sl42nhj4b3F8hu/AVqYSCv4Qx4UI6PZCI8Jlye/o9rdjFdKB/A+3qPga0vv
         LIUwI9ydbI8Z1bNqNN1G3/uEjHf3DBxSoFdzVHAC024xd9lDLnR3hezHYqpegUFlIYSt
         pAXw==
X-Forwarded-Encrypted: i=1; AKwUvBxgudaUVBYOwjHxsGgwTq5adI8HEf7lSChvqVw9PDxrpkeYtMSxxAn95w/Bt++Uj2Yj/Ng=@vger.kernel.org
X-Gm-Message-State: AFuF++ly+VmRqohXXGTg9fOVMLNyoUOd8Sw45Vgh1/hP2CBLP0Jo9YtH
	y0wetcB0NInwi7TE9cZUGSlPUSdBuK1yO8rOydrRO8s6K/DTYN7vg0HToIBU71swbGVCdVLwhye
	WHZ/W/N8YPUwyFfrKD724//3UGsm2YhDO4wpdJ0+kOQ==
X-Gm-Gg: AYBFou3LTWNi7q8k/r8WCRO5dfpS7aj4zplMyhUzBVzv1lyTWV4PSfBUycd1BkdQAn/
	Y3A65Sa+NILquqB3xb2ugAmIicgTSq80BuAEzF2Gc35r+XXm4in+MlqB2gmEkJEWovGMFDuAlZG
	F5cpCWDsjDhlNVVGbxw0l8z6bC7H6Cj58KNXt0tnz+IROBR6mXJzKFVfzTlv6mG0YD51Spq7nmW
	r+eeeIFqBYq2pQy/3yaUna3PosQ2qjsF6GIgyDwU16aY5DD5raaoWelzDxDaoAiMtEOsriq40QW
	9iQBLNLSjN0jTnQsjJJMUWDlXvHc/wJG/EIn0FWOfUYpHM0elmT7Cfs4qdVR
X-Received: by 2002:a05:690c:dd6:b0:873:5c7b:c0ed with SMTP id
 00721157ae682-8735c7bc2c1mr17195157b3.37.1788569727646; Fri, 04 Sep 2026
 17:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901014713.3502900-2-sanghyun.park.cnu@gmail.com>
In-Reply-To: <20260901014713.3502900-2-sanghyun.park.cnu@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Fri, 4 Sep 2026 20:55:16 -0400
X-Gm-Features: AcwNN1UW-1j4dMWYep58MqXBEV0s9deTc9aokvKEnPaB7kyqQmbppPFFaFUGT3s
Message-ID: <CABFh=a4Gj1c64ak2NautOWxyo1g+7F1ruPjf_HRQ9ek6Zt4j4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Validate program attach type during
 link update
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, Leon Hwang <leon.hwang@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Pu Lehui <pulehui@huawei.com>, 
	Suchit Karunakaran <suchitkarunakaran@gmail.com>, Xu Kuohai <xukuohai@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 9:47=E2=80=AFPM Sanghyun Park
<sanghyun.park.cnu@gmail.com> wrote:
>
> Cgroup link updates compare only the program type. Programs verified
> for different hooks can share a type, so a UDP6 sock_addr program can
> replace a UDP4 program and write beyond the four-byte ipc.addr field in
> the stack-local struct ipcm_cookie. The same gap permits incompatible
> LSM_MAC and LSM_CGROUP replacements.
>
> Validate every replacement program against the link attach type before
> dispatching to the link-specific update operation. Keep the CGROUP_SKB
> CAP_NET_ADMIN check at initial attach so pinned or delegated link FDs can
> still be updated after a capability drop.
>
> Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active b=
pf_cgroup_link")
> Acked-by: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
> v5:
>   - Fold the link-create permission check call onto one line.
> v4: https://lore.kernel.org/r/20260831023918.1857658-1-sanghyun.park.cnu@=
gmail.com
>   - Validate every program link update through the shared attach-type hel=
per.
>   - Fold the LSM attach-flavor check into that helper.
>   - Keep the CGROUP_SKB permission check in the attach-only wrapper and r=
ename
>     the wrapper to describe that role.
>   - Follow the preferred BPF multi-line comment style.
>   - Add focused regression selftests as patch 2/2.
> v3: https://lore.kernel.org/r/20260821084726.3769957-2-sanghyun.park.cnu@=
gmail.com
>   - Factor the CGROUP_SKB CAP_NET_ADMIN check into an attach-only helper.
> v2: https://lore.kernel.org/r/20260818061021.2551771-2-sanghyun.park.cnu@=
gmail.com
>   - Extend validation from cgroup sock_addr programs to all cgroup progra=
m
>     types, including exact LSM attach flavors.
>   - Preserve legacy CGROUP_SKB ingress/egress replacement compatibility.
>   - Keep the CGROUP_SKB CAP_NET_ADMIN check on attach, not link update.
> v1: https://lore.kernel.org/r/20260805052858.2390918-3-sanghyun.park.cnu@=
gmail.com
> ---
>  kernel/bpf/syscall.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6874ba1424af..2bcd3f3a2a55 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4481,14 +4481,9 @@ static int bpf_prog_attach_check_attach_type(const=
 struct bpf_prog *prog,
>         case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
>         case BPF_PROG_TYPE_CGROUP_SOCKOPT:
>         case BPF_PROG_TYPE_SK_LOOKUP:
> +       case BPF_PROG_TYPE_LSM:
>                 return attach_type =3D=3D prog->expected_attach_type ? 0 =
: -EINVAL;
>         case BPF_PROG_TYPE_CGROUP_SKB:
> -               if (!bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
> -                       /* cg-skb progs can be loaded by unpriv user.
> -                        * check permissions at attach time.
> -                        */
> -                       return -EPERM;
> -
>                 ptype =3D attach_type_to_prog_type(attach_type);
>                 if (prog->type !=3D ptype)
>                         return -EINVAL;
> @@ -4542,6 +4537,20 @@ static int bpf_prog_attach_check_attach_type(const=
 struct bpf_prog *prog,
>         }
>  }
>
> +static int bpf_prog_attach_check_perm(const struct bpf_prog *prog,
> +                                     enum bpf_attach_type attach_type)
> +{
> +       /*
> +        * CGROUP_SKB programs can be loaded by unprivileged users, so ch=
eck
> +        * permissions at attach time.
> +        */
> +       if (prog->type =3D=3D BPF_PROG_TYPE_CGROUP_SKB &&
> +           !bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
> +               return -EPERM;
> +
> +       return bpf_prog_attach_check_attach_type(prog, attach_type);
> +}
> +
>  static bool is_cgroup_prog_type(enum bpf_prog_type ptype, enum bpf_attac=
h_type atype,
>                                 bool check_atype)
>  {
> @@ -4606,7 +4615,7 @@ static int bpf_prog_attach(const union bpf_attr *at=
tr)
>         if (IS_ERR(prog))
>                 return PTR_ERR(prog);
>
> -       if (bpf_prog_attach_check_attach_type(prog, attr->attach_type)) {
> +       if (bpf_prog_attach_check_perm(prog, attr->attach_type)) {
>                 bpf_prog_put(prog);
>                 return -EINVAL;
>         }
> @@ -5805,8 +5814,7 @@ static int link_create(union bpf_attr *attr, bpfptr=
_t uattr)
>         if (IS_ERR(prog))
>                 return PTR_ERR(prog);
>
> -       ret =3D bpf_prog_attach_check_attach_type(prog,
> -                                               attr->link_create.attach_=
type);
> +       ret =3D bpf_prog_attach_check_perm(prog, attr->link_create.attach=
_type);
>         if (ret)
>                 goto out;
>
> @@ -5968,6 +5976,10 @@ static int link_update(union bpf_attr *attr)
>                 goto out_put_progs;
>         }
>
> +       ret =3D bpf_prog_attach_check_attach_type(new_prog, link->attach_=
type);
> +       if (ret)
> +               goto out_put_progs;
> +
>         if (link->ops->update_prog)
>                 ret =3D link->ops->update_prog(link, new_prog, old_prog);
>         else
> --
> 2.48.1
