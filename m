Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794921337;
	b=hdcNIsSCsVTaWiaqUiBBmMuWEbthgO4rv9lz59vNFgcGy8ST9Fi7EhfAt57fTwfY3vrC
	 OeISASSMRMpcFeJnnRpkl5IUfFz6xkWt741ugEd8Rd5Q8fdViYka7As5TIEJZB4DJ1/wc
	 vKgJU9HizmXlLJMAq8t7l6YN2SLCeUeQOV/vFLhpJy2vK7rIkgggrDh+IruweQlrpAh3c
	 hAcEqacRCKugWtoQNKaRrJ52GfIDEmwRqWUWbSSPpAitn0Yjq8+dtL52rSMk+xcq5AE/c
	 jZKmpnuFIZGy5R29UUjDw8awBl/wpSc1/jPm7AUfYHtbxpe1iju8LyhOmtVOq8LoMsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1jF6nkDRFB/GiZglzFtKPBujyqk5PL06Y3EZwEZ3anc=;
	b=upsunxf7v2B2m19FtajALQMp4j5NRQ7JWeVmZ9gRV7GR5bVASbu5yA1h8967nNHTkmum
	 kpzy/heGAs99svmO8sRSjA4tFU6aO+AXjKy2X0WogoZR3g1EB6CywKvyG/06aHt4ltptP
	 qW9msDnpjemM4h532Jgye0KgXAUXBj5Ii/2UfVlico41QhLwtbdOOb1Taml/SGYnSuuql
	 Pp07v5KfLyyJkGJRe60d7k6AnKNauuhCAjwzcW05bIxOhS+YJG7p9YX3TngrlokM3Y9Ko
	 2pkDgkbscgHX1EUFrAJNsr5ViJ64/XiDSfA6o9yiz6DxFmvhjmJR4avv88kII+4rW4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=NuJ2Ql3h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3474606A323
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 13:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3474606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=NuJ2Ql3h
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67be4f2f4d4so5613088d50.2
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 05:15:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794921336; cv=none;
        d=google.com; s=arc-20260327;
        b=ffHZ/oo7uPCF6dG8vjiobNy8+42h3ifn0yyxMv2PMS2jGuGw+acYb7g066kAiMUL9l
         HOGkhdLeXOfW22HwCa9whrntRIWoGGGbJg5kaOpd/aeb3KQWnamsU+fxErWqO7UANWlL
         lmubQ7KwtS8N31KeapPvyDh5WCgrob4jnZvs9QwMlPSHNhqTxZyijYeP2TKhYXk6Yvr9
         P6ScPgo7Q5dxoDH8OLvISFRa7OajgjFK3MMoPe/ZFMZq0nLZwpQHGBhSgdiUj2eyETVH
         1/aTfc0viKAzKyHr2D3ntiGRlEahPiz4UyOvFUIGsAVURaPS+5fpFh7eyon0kq6w4jRw
         kMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1jF6nkDRFB/GiZglzFtKPBujyqk5PL06Y3EZwEZ3anc=;
        fh=5z42DS5rXZLx6IfxhMvHXZMkGFjOtrM8YK2i8ij8eZ0=;
        b=IPtjgoUE/5KKwv5XnzmLrMXiSNxwuYPvVZuK65+mW8usIuxioNKlgWJh8a+ZJbM0a3
         qwRfAtLbu65tSNVAeb25WWzKUcm8jC4iPM5hRAC1PIibnddg+asfzoXZZPi/aEfq93Nw
         9gMk4wUs9x6QP27nwQ/AplYJB6dZaaqEwDnT2wUBqMFiIt1pxDSQyK+yqumnAs/kqszP
         aMe0jhA/tOPxgKo3l517DsPNw2Y83w9HVrIInFEeQl3GsMSGj7hF4fzeHSV2+tj2TElY
         pzGXb9pD2WPl94ExoIeKa4wARmBDzk7wGHuaKIVGxFyB4vmC2MRW/y33Af8vAdBpFtt+
         ifIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794921336; x=1795526136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1jF6nkDRFB/GiZglzFtKPBujyqk5PL06Y3EZwEZ3anc=;
        b=NuJ2Ql3hrgR/TwVxkytKuMigdKpEd1OBYeXGjlBd6DYYX7OR56G74NgO/xIRG1Qjb/
         50W3GlzbUGfFkfeoOXFSnlco/IsS60ONNnpGLfKehD0RPM4wgiVgYGD/ZmTgaON7Mbz2
         jgbX0fr9r1aIJph7TctK020EWmnCkfY4Vr8Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794921336; x=1795526136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1jF6nkDRFB/GiZglzFtKPBujyqk5PL06Y3EZwEZ3anc=;
        b=AvtsR1I3FE/sq+/G0Auh83qk3EvDJakg/S2CLW5FyCnUB3Sq1uvVDwHkJMyqqeTqmk
         dzrM4qw1Euvu4aVMx/lyxTs3UwfYPDt4rV0ji2cIVU+D0CM8/qRUFZnEUATZmj+Q48/g
         rXi9RbhsNQfG2NAxywEQciJWRFjF2vCWyAYEFjUEa5uPLdPdfTFnEDnCn8JY0Y6IkpLY
         zeJA5o4z04vQj6hC+sZjUiBQ9qXFbamjpzldJkZUsK1B+eLFFy8Ga6PubWz5fzVBeAqH
         d++j23I1XLcbyWIdKPQDtOxTNumOSPRRuaNMR4BaC1aNAOYoH91k9jsi6lDLV0xW8Uvc
         EezA==
X-Forwarded-Encrypted: i=1; AL+hErHtqn51XnuwXh5ImwPazL8m3SxC2razsHX0Pvp4mV5z2JG0VB0+RjxWEMNH0o1XYMJmMmo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dP5sdaY+gXwlAq9yUR3ofGg45Jb0B5Rt5aFqYbk/GSC5nhV2n
	0fQEXS4hLmPykz/EDBTnONhs3rgm+KAQWo4zmgcbDwVX92jRq5Zz3ktI7S9IFeeioVeailQ1o2v
	XIOelWqeT6kJGuj5uY1av4Ct2uJjQ640gTvCWurrMO6CI8O6nfGqBzQ==
X-Gm-Gg: AZFdTZd97vnlPbf9aLRDz4pef2ALFaqMoArKfNQgtoBlRVIxlBMIbE6rtITXfBAp/FH
	wr9yVGc1TcgZ37N4jbI82rrPTtUoVDFIevUDa1QbCvU/WOwqKwAnO/Oht85kZqNqyD//SuzGXcQ
	ukz6Hv2z5TdpGWeTv115s7OxOocuWaIezrAhtuGPiTDbribAB9T/pfPMkXc3tDqGUGHgeuxLfdC
	+/ZYfAuB2SHadFCsf0mwDmAUoIUgTiBAom4k20MHB6U5tX/sWwZFFLpwrCF54s7EYFUrS+THhGh
	7vP+GNlXKzwk699jA7FhTFDweKreD8AjfsvdCVJMI7rPf92ZUHAXFnG+fytFasop4m4QfF29CnB
	5DHLiIe8A7FI5qYDp+UP2hLNl6X+t2JPN3BsV6Sbe86HGGOpvx5CSwWc9duvX/NWd9bJw6hbquI
	mSrv274ZAlAYs+PRHkiz8OHvKZhdixyLyCjapj
X-Received: by 2002:a05:690e:408e:b0:67d:abc4:a4d4 with SMTP id
 956f58d0204a3-67dabc4a519mr4026388d50.72.1794921335493; Tue, 17 Nov 2026
 05:15:35 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CORE-9NOG.v4.r0.20261116135311@mojatatu.com> <CORE-9NOG.v4.r0.20261116135311-4@mojatatu.com>
 <DMWXH28YQDYH.1SI4Y5WQ7EPSR@gmail.com> <CAM0EoMk10vCoAKZq0P=8A_jed=Z3SudLEUV8uvXO5F=ewNjnGQ@mail.gmail.com>
 <DMX7RM93TMGR.AXFN4YJ55REF@gmail.com>
In-Reply-To: <DMX7RM93TMGR.AXFN4YJ55REF@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 17 Nov 2026 08:15:23 -0500
X-Gm-Features: AclHuK-WzLYszVXBsuW9keMZDCNkdCoq7_wHfjFaf6G49fobSVbVlVyY5hH2KC4
Message-ID: <CAM0EoMkqwoJdzChpCVcw+c_XXsR7hw1_Wy6J-zQbq4JjogqTSA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/4] bpf: drop the stale dst when redirecting
 to an explicit nexthop
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	bpf@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 11:50=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 16, 2026 at 02:06 PM Jamal Hadi Salim <jhs@mojatatu.com> wrot=
e:
> > encap ip/ip6 or encap xfrm template the tunnel template lives in
> > dst->lwtstate  that wont work (packet reaches the tunnel or xfrm
> > device with no encapsulation).
>
> ok. agree.
>
> > For that reason we cant drop 3 and 4. I see the change in 2/4 (I see
> > 1/4 not changing either) .  The change is not that small because it
> > will have to touch multiple core files (although just small mechanical
> > surgeries). Summary it will still be 4 patches..
>
> can we keep the route and fix neigh_update_process_arp_queue() instead ?
> The bug is its lookup via dst. Only teql needs that lookup, I think.

Didn't look closely - eql moves skb->dev to a slave the same way, but
has no neighbour code of its own, so it looks like teql is the main
player.
But the drain is not the only reader: skb_tunnel_info() reads
skb_dst(skb)->lwtstate, so keeping the route leaves dst->dev=3DA on a
skb bound for B. With the 2/4 I was planniong for v5 no drain change
is needed at all, since dst_neigh_lookup_skb() returns NULL on the
replacement metadata dst and the existing n2 =3D=3D NULL path already
outputs on the parking neighbour.

> A is the device of the route, B is the target of the redirect:
>
>   skb is queued by        skb->dev  neigh->dev  lookup via dst gives
>   ----------------------  --------  ----------  --------------------
>   ip_finish_output2()     A         A           the same neigh
>   bpf_redirect_neigh(nh)  B         B           neigh on A, the bug
>   nft fwd                 B         B           neigh on A, the bug
>   __teql_resolve()        master    slave       neigh on master
>
> The diff skips the lookup when skb->dev is neigh->dev.
> lwtstate, NBMA tunnels, realm and ICMP errors work as today.
> The fast path doesn't change. No need for patches 2, 3 and 4.
> and 1/4 is not a prerequisite.
>
> Your teql 3/3 queues the skb with skb->dev =3D=3D slave. With this diff
> the neigh of the slave adds the header and sends the skb.
>
> thoughts?
>
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index d6e9c7c..04758ca 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -1331,9 +1331,11 @@ static void neigh_update_process_arp_queue(struct =
neighbour *neigh)
>                  * the packet in the output path.  So what we need to do
>                  * here is re-lookup the top-level neigh in the path so
>                  * we can reinject the packet there.
> +                * When skb->dev is neigh->dev 'neigh' is the top-level o=
ne.
> +                * dst can be a route via another device after a redirect=
.
>                  */
>                 n2 =3D NULL;
> -               if (dst &&
> +               if (dst && skb->dev !=3D neigh->dev &&
>                     READ_ONCE(dst->obsolete) !=3D DST_OBSOLETE_DEAD) {
>                         n2 =3D dst_neigh_lookup_skb(dst, skb);
>                         if (n2)

This will fix the cases you showed in the table above i.e nft(6),
bpf(6) but will break any xfrm and many lwt paths (including
bpf_lwt/6). Apologies if i am stating something that might be already
obvious, but let me illustrate with one example: lwt.

A is the device of the route, B is the target of the redirect, and lwt
is the lwtstate that route carries (encap type ip/ip6).

skb is queued by nft_fwd_neigh_eval(), skb->dev=3DB, neigh->dev =3D B
Lookup via dst gives neigh on A  - because the dst is still the
arrival route and dst->dev is A; ipv4_dst_neigh_lookup() takes the
device from the dst and the address from the skb  _ only when the
route has no gw_  (the device is never taken from the skb)
(Essentially, this is the bug) i.e a non-NULL neigh means the drain
reinjects on A's neighbour, so the frame leaves B with A's neighbour
and A's source.
dst also carries lwtstate (outer endpoints) that B's tunnel needs.  A
drop takes it down with the route.
Note on skb_valid_dst(): "true" means only "the slot is a route", not
"the route carries nothing". A route may carry an lwtstate that this
test cannot rule out.

So a skb_dst_drop() will result in dropping the packet in the cases i
described. Example for gre:
skb_tunnel_info() then finds neither a METADATA_IP_TUNNEL template nor
a dst->lwtstate(encap type ip/6) and gre tx will then drop the skb

I have a patch for 2/4 i can share if it would help the discussion.

cheers,
jamal
