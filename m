Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792641250;
	b=5ZgLDV3CYMwrv1w7h+XmeLYtfKLtSThQ0Fvj/V1+HASvqpRJleTCdqye7LWZeuwVsL1Z
	 5cDSmKED4bZYIf9KramLHe0kzf7uuqm9+E7Ym/IdwAxj96OQWAzTe4JVHwt6W1GxkDfn0
	 gM4EoSVnFc0G/zvIAUpd9fSkgHZ6P529OqXeDbB1J4UXGxosQpkLNzH9ilSPMKGyZ1GER
	 sEFa6lSFlzrhdvcUkEH8yju7ON0+dP51BC3S27t1jgvmTG6jjQ4Ahd2eteKHQ9D4QjA3e
	 MYrF1mc4OVWX4YS8bpAtm3OL4uidlYPlwY56pved4tqJKG03obZMLLFpnQXZjn7PeSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792641250;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xEoTQ9N/Tf+sH4oyVMEnoem256sSy7IUWX9i50eKFv8=;
	b=dsqqD+X3DhEsDXOPI7BvXsx5XR6ymDdpC8yudelPQ55KORXVDO+yNmCD3ir+8balCI9o
	 1zFCCyxx2wX1c3tF1c9RrS7ys1ELZ6zjwJ9NVgXXaVqc+FiYoygceoZvwHaxuGop81MKl
	 lhnsQ3VJaCpdVdAHWFuYT0CsPVtuw0NceSynxb6KIPMdzyF75C3ZCHnfy/kx5yeS0eD4f
	 AAqtn4jo5xrGI0PZnSlyNMjNAArVX5VJskYBCIxeC+eiv01mDE5LdA4ZNBgyerUiPKoIy
	 HZfkrzkKTbochYSGwWVqGRkukHDizKX7laLiGBPjz5JwUtfeVVBIqmjo+urINSgwiXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Oajm3/gM";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519BC606A32C
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 03:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oajm3/gM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F271F000CB
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 03:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792641250;
	bh=xEoTQ9N/Tf+sH4oyVMEnoem256sSy7IUWX9i50eKFv8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Oajm3/gMg0I+UfvqgtaJ4ZY+X4AIVBFJceUqX/3+cLVOz1hGzwdKpcK+upBg1+Mp/
	 voEZUHP/iCH/6kGKTCD5phHp+uEj749RaquF2vPVfz+8nDapHpK6Vi1mMTqzPzfjKm
	 t7Bz+pwrBVGVCp86q68a8Py9okSZIv8vNVWn79m+mNZuOpGuqRKYszVfvQdBF9XR7z
	 aqVG+lAFROInI44dqQdiBCGulpVdbVy6xV+g+DDVee/XB50UoaUe2nZG89w1bcSxfX
	 Lm9g5QdOSNhma1AFjwY9qDR90NYOuOIRb6Xoth2vI+oc2fw2+f4q06IiOcMZT1iz9A
	 r1IdVEkAZ99zA==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6df7f544919so803840eaf.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 20:54:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx+GfV7R3suZeeBlfXhY+J3BQs2yF4Bf5vbgUuE1soShdQJDt9mjNbs7adiy1t98bi9oFc=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4z0my9aMmRRtfLi0vJo6QeqJdc7SXrd4LNeS7q+9NvwF7AK30
	rcrGEiZwMAEE8KRA6jg1CcpTijSkBtLxWwHVo0ELlH0deu3UeVr3Qbq8HYAbf4T1dJej05SjIFw
	1Nod+0LIu+MvCWlzaJZTppD43PxW1T7A=
X-Received: by 2002:a05:6820:c8b:b0:6d6:bd40:5cc9 with SMTP id
 006d021491bc7-709422cb82emr2490276eaf.90.1792641249241; Wed, 21 Oct 2026
 20:54:09 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792607608.git.zhilinz@nebusec.ai> <2773af2572ff59055933e407a135b39bca537381.1792607608.git.zhilinz@nebusec.ai>
In-Reply-To: <2773af2572ff59055933e407a135b39bca537381.1792607608.git.zhilinz@nebusec.ai>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 22 Oct 2026 05:53:57 +0200
X-Gmail-Original-Message-ID: <CAL4WiioBzbo81K2EVw8UQG6w70JS3D80GNoDndXFfcG-qAhUEw@mail.gmail.com>
X-Gm-Features: AclHuK8N5ds3Fw9LF2Dx9sFZR46QYMs5QxSl65xz5Fzea10VnJ8VVtAmE9IYTNI
Message-ID: <CAL4WiioBzbo81K2EVw8UQG6w70JS3D80GNoDndXFfcG-qAhUEw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] tcp: release congestion control reference on rejection
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, ncardwell@google.com, 
	kuniyu@google.com, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	jonathon.reinhart@gmail.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 21 oct. 2026 =C3=A0 20:57, Zhiling Zou <zhilinz@nebusec.ai> a =C3=
=A9crit :
>
> tcp_set_default_congestion_control() takes a reference to the selected
> algorithm before checking whether a non-init netns may select a
> restricted algorithm. When the check fails, the function returns -EPERM
> without dropping the reference.
>
> For BPF struct_ops algorithms this keeps the struct_ops map and its
> programs alive. For module-backed algorithms it leaks the module
> reference as well. A network namespace administrator can repeatedly
> trigger the rejected request after the algorithm has been loaded.
>
> Drop the reference on the rejection path.
>
> Fixes: 8d432592f30f ("net: Only allow init netns to set default tcp cong =
to a restricted algo")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
>  net/ipv4/tcp_cong.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
> index 8e83ef81fc187..907c63af14785 100644
> --- a/net/ipv4/tcp_cong.c
> +++ b/net/ipv4/tcp_cong.c
> @@ -293,6 +293,7 @@ int tcp_set_default_congestion_control(struct net *ne=
t, const char *name)
>         } else if (!net_eq(net, &init_net) &&
>                         !(ca->flags & TCP_CONG_NON_RESTRICTED)) {
>                 /* Only init netns can set default to a restricted algori=
thm */
> +               bpf_module_put(ca, ca->owner);
>                 ret =3D -EPERM;
>         } else {
>                 prev =3D xchg(&net->ipv4.tcp_congestion_control, ca);

Thanks for the report.

Instead of taking a reference only to drop it, please move the
restricted check before bpf_try_module_get(), as
tcp_set_congestion_control() already does:

        if (!ca) {
                ret =3D -ENOENT;
        } else if (!net_eq(net, &init_net) &&
                   !(ca->flags & TCP_CONG_NON_RESTRICTED)) {
                /* Only init netns can set default to a restricted algorith=
m */
                ret =3D -EPERM;
        } else if (!bpf_try_module_get(ca, ca->owner)) {
                ret =3D -EBUSY;
        } else {

Also for v2:

- BPF is not needed to trigger this, and the module case is the
  interesting one. Any restricted module CC already loaded by root
  (e.g. tcp_bbr, not listed in tcp_allowed_congestion_control) leaks
  a module reference on each rejected write from a non-init netns.

  module->refcnt is a plain atomic_t: after 2^31 rejected writes it
  becomes negative, and every following module_put() hits the
  WARN_ON() in module_put(). An rmmod would then hit the BUG_ON()
  in try_release_module_ref().

  BPF struct_ops use an atomic64_t refcount, so they cannot overflow

  Please describe this in the changelog instead of the
  struct_ops/OOM scenario.

- No need for a cover letter for a single trivial patch.
  Your cover letter is adding noise, any LLM is able to rebuild a POC just =
fine.

Please wait 24 hours before sending v2.

Thanks.

pw-bot: cr
