Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A62378D94
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975443; cv=pass; b=F7StDmkinraP3ISzVuEidGtGcRfmvJW7IABv5iNUcWLnQl/cYgKrnOBSWWwoRR1nhGdccIi/W4Ahs7rcE4YT67+d6bWACqIki56sRCi58wAZFM5leo4IdWiGZD1jALUZjNHQQlD8U/zsdJLXa9wJfQ+dhWAQrdKMF9WyLTk2op4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975443; c=relaxed/simple;
	bh=L6EZGw8SGANGHrrGkcSveLb3zd9izGncX/8VAKQnZiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODKlIF09E+JLk//KY3vsByWnBd1mYMpi/EervATRWzo83tp4LUZQzSYNDqmobHn34YGC2BZUc2hszDAFDWHbS6xQ95JtLHxZ78dhFInD961Js4i8r4XhN2uFcNtXTVOJwToZuQkapINaTUc9+R9AXnnGxBXr86HRT7cT93X7fzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=z8jqWRYA; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="z8jqWRYA"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e50968489so526142d50.0
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 10:37:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788975441; cv=none;
        d=google.com; s=arc-20260327;
        b=Aj93B7rr+nTE1rtlGqs3KeteeD0QEZY24TXXEFZYVwCtzQewhByZaAcpFh39d7F9zZ
         qRjNJ4zDD/1V6XPPVQwyRXuGSf3FkOJhU6aSBQZuu7fTmfCtdLHYHYwksmCrXT0cYBF7
         SvzIiEhtJ3wVO52+io+GcMR1/oIiaHzKQGwZmxS9BlbjvbPh9Zbi8Hjc9IQk9OLtD+YY
         yLj38qWH1weJmjyZ+HTsARCmh2kMcjaGPnWfeygpvZHrB1PCZgZU/BPZ2xDMgF77wa5y
         1V3QiD1/ZiqLh1i5xfBo90UANhwc8A5x+CVesM7AFarSP9+m/ANCOu9/0Gxrh6qzHhaW
         mquw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Af6ITtfBEfomuP9/zSoltzeiZzdojuJAWeTn9uFF6ek=;
        fh=JUxPQ9G84apGdqsrDHlxyzhcHqRlwPX1mmt0jfs7mqU=;
        b=sOkO82TZU0zw1jlYJJ43OHG1ACPiqIxYq2S78JTQt+GHSDVhHIDrSxdOjtMzMXfQd4
         7uZPbg6+vEo8NhzcYl6r5yPsky4aeAdUzDudyml95kCR0udfP1rR/g9NFHrdlU3AjhmC
         c5Aoe/dKSTzVuqKqWRDn3lKGe5Wp4dB/BGen8kpSXLLNmLOhuP7bSzRGLMbN8yXrpyq0
         qI9e+NPu5Dur5xrEvHoyLqvruGlUzpnOShMCmRY9Cm4jCK++FcQB66zK27mutQzDHIyD
         EkDFPu29PluYDVAP8MCzkpDIHgEmSI6PdEWLQ/tWFaSNmTS52GwMV4Af4ZoRb6a+xE4R
         GS9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788975441; x=1789580241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Af6ITtfBEfomuP9/zSoltzeiZzdojuJAWeTn9uFF6ek=;
        b=z8jqWRYALdUGBkLxezUs8C+xjV5pUXYMTvjAM+dHk0vJHl285vdrgg+tiQs06BsHzO
         wgnRt6jtOn4koRztyEO7uUt7jGml4eR8vDalIXRM2dSa4IecKuidumQDJD66h6mA3/hL
         dnUlh7nWPZTgXLwOLsLrT6fxinNoS6qiitnhAAkU7SDN9IQF7CA16KattG4mqNuKQEkp
         c1QI0rO1IqhwVnwlBbHvZdQZ0oiL5HP39gJGwGO73V3zy+rmLYGFOKMlUwbuMvGsLbRI
         thxWKSCd7M7+fVvrtGg0mmBJtrrPeQkZ8RlFFfXV5l6cyati6NxJEnLxjn8qkpIQDlWa
         ia+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788975441; x=1789580241;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Af6ITtfBEfomuP9/zSoltzeiZzdojuJAWeTn9uFF6ek=;
        b=G8pktmgMHM4X1sgLNOJrx9zmkNqYkK6BaiUZBmQ3L4wubqFo28Ui2C989oi8DoowPT
         kHrzlAbyVVC4p0d+CAian11arzSTNfG6+fEeyueJhiMiVEQpRbn8OCP7/+BDTi1sj3PU
         OpeB3CJIfsdxXbDSo4IMNA9G/BSmLoNsNmbrKZGm0oIneGi8iYZME8O8foLx4zosmdGV
         G4ks9f4mo+SwlDlQmDOk+2yMHJF/FFZVAOnCxAQ8d1r9t4EwsXrr4tkB/ulhO/ReRw1u
         ZVoV82bo9DOD3uwlunROTqzWfSqA5cWXKOhM8m8vp+euYNj27GsCuBwA5Ws/1iAPCFpO
         R/+g==
X-Gm-Message-State: AFuF++leludSPQ7vt3xDR8D3E2MaoH8QFPNh89vxoVnN0f8jlVaGcfVF
	nMD2Fmp4wIyOEDzPhkaK2LSRr5HbSagyMIOXnq3NtyDJ8PPVr3s4zCkNTBEgESZZBOTjhs7li0D
	IhD7+cAG+4RXko49Jj9e8AiC0ISe7KyNC/tywNoUmuQ==
X-Gm-Gg: AYBFou18m+RsJRK9K9x7rdHQnJyjR6NAU1pW28iSMoshcpmcCog9vtpeJ4Bb2zEtNtO
	z+YjGlRPT3uNE5aK9mqJAKg/nG2swPR2bmKL8vhqnUWlCpUuuB1Clzhpcfbraj3KOY0swmMVxhP
	nsac35NnRkTgEw7IkMSa3x/B9Thki2vvgqCnkYBEQSnIDyF+DhHYK0jgudEcS2+/eqC7QL4A5IA
	svvb4ZZ3weBWeVP5PEdkZNG+Bt2hVkKdS0b+4J7p1YhFjCX9Ntr1cTADGlOfxsBiH7Fe0zUILnt
	ve9gyYy6OP2olipAKvB7XdZwSi/Nmuhk1l5BESHru8MJxl1w+yOhfYwh2jtBcMyb
X-Received: by 2002:a05:690e:400a:b0:66d:93e:f06b with SMTP id
 956f58d0204a3-671100b5114mr953412d50.38.1788975439124; Wed, 09 Sep 2026
 10:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909135324.60165-1-cenzhang@linux.microsoft.com>
In-Reply-To: <20260909135324.60165-1-cenzhang@linux.microsoft.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Wed, 9 Sep 2026 13:37:08 -0400
X-Gm-Features: AcwNN1WDkVwiFlZuDNEwXauBrRSu0q6NKwPjowBV4De_y5EG6aHsz-Bo8i1LExM
Message-ID: <CABFh=a4VyzxsQqsayWpTKjxY3HL2C072u=pbecEpNDbL9eBNKA@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix non-linear SRH access in bpf_update_srh_state()
To: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	sdf@fomichev.me, martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, ihor.solodrai@linux.dev, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	m.xhonneux@gmail.com, dlebrun@google.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	xmei5@asu.edu, tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 9:53=E2=80=AFAM Cen Zhang (Microsoft Security FORGE
Labs) <cenzhang@linux.microsoft.com> wrote:
>
> bpf_update_srh_state() locates an SRH with ipv6_find_hdr() and caches
> skb->data + srhoff in the per-CPU SEG6 BPF state. This assumes that the
> returned offset is within the skb linear head.
>
> That assumption is wrong because ipv6_find_hdr() uses skb_header_pointer(=
)
> and can locate an SRH in non-linear data. The direct srh->hdrlen read and
> the cached SRH pointer can therefore access memory outside the linear are=
a.
>
> BUG: KASAN: slab-use-after-free in bpf_update_srh_state+0x1bc/0x200
>  net/core/filter.c:7027 bpf_update_srh_state()
>  bpf_lwt_seg6_action()
>  input_action_end_bpf()
>  seg6_local_input()
>  ipv6_rthdr_rcv()
>
> Fix this by using seg6_get_srh(), which pulls and validates the complete
> SRH and reloads its pointer afterwards. Pulling can reallocate skb->head,
> so refresh the BPF data pointers inside bpf_update_srh_state() immediatel=
y
> after the call.
>
> For End.DT6, make the inner IPv6 base header linear before removing the
> outer headers. Pulling only the outer headers can leave the inner header =
in
> non-linear data, while ipv6_find_hdr() and the nexthop lookup access it
> directly. Clear the cached SRH pointer and refresh the BPF data pointers =
if
> the pull fails.
>
> End.B6 and End.B6.Encap can insert a new SRH and reallocate the skb befor=
e
> a later HMAC calculation or nexthop lookup returns an error. Rebuild the
> SRH state when the skb length changes, which indicates that the new SRH w=
as
> inserted. Failures before insertion leave the existing state unchanged.
>
> Fixes: 486cdf21583e ("bpf: add End.DT6 action to bpf_lwt_seg6_action help=
er")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Link: https://lore.kernel.org/bpf/20260901183151.16648-1-cenzhang@linux.m=
icrosoft.com/
> Suggested-by: Emil Tsalapatis <emil@etsalapatis.com>
> Link: https://lore.kernel.org/bpf/CABFh=3Da5iLOEJdPhoaWUhLc0eEqAuhnd83_jJ=
r9MVZZG6gSJAEw@mail.gmail.com/
> Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@linux.=
microsoft.com>
> Assisted-by: Copilot:gpt-5.6-sol
> ---
> Changes in v2:
> - Rebuild the SRH state after End.B6 and End.B6.Encap only when the skb
>   length changes, avoiding selection of a spent Routing Header on errors
>   before insertion.
> - Rebase onto the current bpf master branch.
>
> Please queue this fix for stable kernels.
>
> Testing:
> - Static checks only: checkpatch.pl, diff --check and patch replay.
> - No targeted selftest was added. BPF LWT test-run does not support
>   non-linear skbs, and the existing SEG6 netns test does not create a
>   split inner IPv6 header for End.DT6.
>
>  net/core/filter.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 8513167a858a..b037d70e5fe6 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7017,15 +7017,16 @@ static void bpf_update_srh_state(struct sk_buff *=
skb)
>  {
>         struct seg6_bpf_srh_state *srh_state =3D
>                 this_cpu_ptr(&seg6_bpf_srh_states);
> -       int srhoff =3D 0;
> +       struct ipv6_sr_hdr *srh;
>
> -       if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0)=
 {
> -               srh_state->srh =3D NULL;
> -       } else {
> -               srh_state->srh =3D (struct ipv6_sr_hdr *)(skb->data + srh=
off);
> -               srh_state->hdrlen =3D srh_state->srh->hdrlen << 3;
> -               srh_state->valid =3D true;
> -       }
> +       srh =3D seg6_get_srh(skb, 0);
> +       bpf_compute_data_pointers(skb);
> +       srh_state->srh =3D srh;
> +       if (!srh)
> +               return;
> +
> +       srh_state->hdrlen =3D srh->hdrlen << 3;
> +       srh_state->valid =3D true;
>  }
>
>  BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
> @@ -7033,6 +7034,7 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, s=
kb,
>  {
>         struct seg6_bpf_srh_state *srh_state =3D
>                 this_cpu_ptr(&seg6_bpf_srh_states);
> +       unsigned int old_len;
>         int hdroff =3D 0;
>         int err;
>
> @@ -7058,32 +7060,37 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *,=
 skb,
>
>                 if (ipv6_find_hdr(skb, &hdroff, IPPROTO_IPV6, NULL, NULL)=
 < 0)
>                         return -EBADMSG;
> -               if (!pskb_pull(skb, hdroff))
> +               if (!pskb_may_pull(skb, hdroff + sizeof(struct ipv6hdr)))=
 {
> +                       srh_state->srh =3D NULL;
> +                       bpf_compute_data_pointers(skb);
>                         return -EBADMSG;
> +               }
> +               __skb_pull(skb, hdroff);
>
>                 skb_postpull_rcsum(skb, skb_network_header(skb), hdroff);
>                 skb_reset_network_header(skb);
>                 skb_reset_transport_header(skb);
>                 skb->encapsulation =3D 0;
>
> -               bpf_compute_data_pointers(skb);
>                 bpf_update_srh_state(skb);
>                 return seg6_lookup_nexthop(skb, NULL, *(int *)param);

Sorry but sth we missed on v1:, We need to do tbl_id =3D *(int *)param;
before we start
pulling. The verifier allows the *param pointer to point to packet
memory, and we may
be freeing the packet in pskb_may_pull(). There is no good reason for
*param to be
pointing to packet memory, but it's still possible.

pw-bot: cr

>         case SEG6_LOCAL_ACTION_END_B6:
>                 if (srh_state->srh && !seg6_bpf_has_valid_srh(skb))
>                         return -EBADMSG;
> +               old_len =3D skb->len;
>                 err =3D bpf_push_seg6_encap(skb, BPF_LWT_ENCAP_SEG6_INLIN=
E,
>                                           param, param_len);
> -               if (!err)
> +               if (skb->len !=3D old_len)
>                         bpf_update_srh_state(skb);
>
>                 return err;
>         case SEG6_LOCAL_ACTION_END_B6_ENCAP:
>                 if (srh_state->srh && !seg6_bpf_has_valid_srh(skb))
>                         return -EBADMSG;
> +               old_len =3D skb->len;
>                 err =3D bpf_push_seg6_encap(skb, BPF_LWT_ENCAP_SEG6,
>                                           param, param_len);
> -               if (!err)
> +               if (skb->len !=3D old_len)
>                         bpf_update_srh_state(skb);
>
>                 return err;
>
> base-commit: 15e2565f1c43771af0bc5324971cabaad79ac286
> --
> 2.55.0
