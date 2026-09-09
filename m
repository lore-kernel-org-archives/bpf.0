Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7DD35C1A1
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974347; cv=pass; b=KJBOyBhUwWFQgPxqN6yS3ytxl6Bu/e9QvnZX8zic0cQlY0c4tCE82wufDGFJi36DWGVg5S3g5Dve8CRJ/CmTR7u2Cx7Y9fXiJ2iBvUxl5T7cZZgsh35zidmZ46KT9Z0HuBxsgsE0RdcN2J/zkaH8S+0ZYJkd56ilOynL+hpfi+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974347; c=relaxed/simple;
	bh=BQ+Hst8gOUWR37L4XOKGfAUQBTOzIL1QvKMGUdQMdVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kiIf/zprz68zGovuUR76Bmhe1TIr5yU7iGxoWBXWRGEbLewedDwnNfSnWL6GKt8ZpFkez7fZW/+OCEAt96V46eLx0PmT0S53EOWlNMc4/Y/Y8IaK+KvZOA2hisOccSQ2wLCTlo5AU9dNgIAGPZ1Vs9cexnLxYXnkvZlWDygjP1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=z5hGrFdL; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="z5hGrFdL"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab201ebso628799d50.3
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 10:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788974345; cv=none;
        d=google.com; s=arc-20260327;
        b=J0fAZICXGIP4gJsDEZoletpzwbJCyLVVfs5qkXfO3heP8bE6Em3BmGFK5eu2SokMi6
         JHCBjLIBKfPAJA7LJKkk0Lom0rETaagj6mRvMz+oPfYL2dGA+59r8/7WFMwSqCH5VIbv
         P/c2EGoanz4m+j+D76/sYUHIdUD5oFyxsiW+e8mwedDrRKPEWhSi2sMnw73Z/szsWes4
         xDfz/lfv2BG7d5irvgek+0oRjafns9NmfaUKr88NaY8xLD99J6Ncjkje5qmHqYswbzi2
         B/5OLvh0Y3sIHT5GePCo7kZWjJJr41xbVX62HGYBtJpn5Y7B8dToQ4FMhMyI2TFoHrGv
         3rOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6E68RRU9n5lqapFJ2+/cJtqMKWFxDFCie3V1FAMd+4g=;
        fh=cMwJsRPNsMH9fQg+C5UoGZGEPwr1I7iO/ZM73/4YHyQ=;
        b=k/G+BK6HEWeTaLSN4/ePiDCERN6HtUycRDtb6Lywmtg72uza/KJ0WnG2Ha43CFcQcS
         ep4qaaC3i5+VRjWkZqzSZFl59ifm6mVFdRyECx0hXUaBqQQ00deBQBPg+kBo8DdQgiYX
         20RJ5IEauFftrGabWv8sZtxstG2pcVHxDr6QaNaMPsU0t6P4B2jCo/DUGm8qymVM///I
         XcBr6ufv6Rrrs0515dPhUgqmdWdRu2AC8YZGQij7YgFXdUnvoG0bocqzhik69dMfzTq6
         vXJceBv0MV0+EzY71TVKbd7PSGyoaJTQFvPG0AYGiOOOK4OJk58tP7KACRgEVRKpfyLq
         MnpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788974345; x=1789579145; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6E68RRU9n5lqapFJ2+/cJtqMKWFxDFCie3V1FAMd+4g=;
        b=z5hGrFdLgDm+Rboba1delLX9FtBlGxiqFqtudICHSpjiuW5vLNEDkDrgXRLUm1PXXg
         kLmD2HNMODCvIVFA8LA/2qGCV2uYXs85B0YZxMcn6U6pToLCx6fw6XKfnjI1NT62uQ9m
         NQcfRaQvAnUtYKnCqle6DedFs4YvKDjGIKJlYdRZJedWgD/D8g37YzjaVGuuvzohaFXp
         9pMU6JoGGgOux4/Fadq7gM+tY8ttdQWnQGyPgBzhHyccVOkEMqNJkVOsQdUqxszwPgoX
         PRv9sM321iDCHK5aydwxCllwGLdEq57cHpyBW70GVCfH2jzsP1wpZLE0afTHdNvqgtv6
         LLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788974345; x=1789579145;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6E68RRU9n5lqapFJ2+/cJtqMKWFxDFCie3V1FAMd+4g=;
        b=Ng37obLRvHHS6DhjdgDkMnI3dxeaxv92xAn+th7lElxA+x4IE/A21Zo9gEIZyLojFy
         CauEYctbcnl4ZjjBZ3M+SrK7tYZ8uMH3JLzp8DTAHvGOdycNwVf0lgSnptjUCabP0KkP
         QXboIoi2/aoAff4ch+n+ZZld0hmVaMUdIDB8Jd+SgQ1tG6LdR/7No9OWHIr9YmH8lcQT
         UayaLds/PbfFoQpMYPTwpQkRetJsWC+M16ELKbjAMbOw35+zvAgrRBZ7Ecu9EmB6dV2A
         qs9zIqH6wGdXnZ36FD+AlvoIKlKTW52pwZ6dBpSWuasYCA6WS+UsDtKtYPWHtMA/LCKI
         jsRQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4G+pzfusm54dC1u9kHCaLxL0zJlQ9XRfXDuUWMghJuY6rqDDBxS9CGd4aLSy2NQm4Pd4=@vger.kernel.org
X-Gm-Message-State: AFuF++nu1Q8BwdJ1oa3esUo/a39R4MTESLqcWXVjqF5LoCsJdzqBy0pp
	LvSDBKx421xkMqQFvWb9kXxpnsaDqqjhKiE9rrM03w43T8NQqwZBBozDfmsYMNuoga+DM5MzxkZ
	CyTKueRjxxmWtgVvuoMOcFVzHZ8nPdljSWkcMMPweuQ==
X-Gm-Gg: AYBFou2lnKjjQFmb4KvsQaZuFXf1ne8CwmlT1gNhN7oC+PVfP0uTDO36fZa3K9O74sn
	2+BYLvsp4s2ORzbFggvRC9DCdEd0hPC1kWzz9ksqQEmrH/DWruMwIQpNkljS4S3kYXzbO8/tW1Y
	PzbmX+pTXrNrtsBIAOau0PGhSDH9T7JzIPTB77v4KHn2OtH2TK8zSbKpDMPTReHIkZVqyqJI8Cx
	jUHiXdfrO8ID2L3taE/Cx3W3xH1bXkVGAm5MwlMiZ4JzAxpJGFA/BtLGYhUM+aYH+03FjBjOMRU
	pkGW0tBYN3OTLoJQqpIBYJzhunuLXviA+E0YDcTZp6Ts77jAlElLmpM=
X-Received: by 2002:a05:690e:1407:b0:66f:c284:4806 with SMTP id
 956f58d0204a3-67110027d40mr1411230d50.66.1788974344494; Wed, 09 Sep 2026
 10:19:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909024011.1252694-1-nikhilljatt@gmail.com>
In-Reply-To: <20260909024011.1252694-1-nikhilljatt@gmail.com>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Wed, 9 Sep 2026 13:18:52 -0400
X-Gm-Features: AcwNN1U4pDVgjWmRTrx7PuoPtmF0Fx_Otlis6cGINQ1Y-tUySGzn4ekMF7-3TDY
Message-ID: <CABFh=a7Z=heZODVsXwisY3VwULDy-Rq1hwO09exgX2d0-KzgUQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix reading neigh ha in bpf_fib_lookup()
To: Nikhil <nikhilljatt@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, horms@kernel.org, dsahern@gmail.com, hawk@kernel.org, 
	razor@blackwall.org, stable@vger.kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 10:40=E2=80=AFPM Nikhil <nikhilljatt@gmail.com> wrot=
e:
>
> bpf_ipv4_fib_lookup() and bpf_ipv6_fib_lookup() copy the neighbour's
> link layer address into params->dmac without any synchronisation, but
> neigh_update() writes neigh->ha under write_seqlock(&neigh->ha_lock)
> exactly because there are lockless readers.  A BPF program calling
> bpf_fib_lookup() while the neighbour is being updated can therefore be
> handed a torn address, and XDP/tc then forwards the packet to a bogus
> L2 destination.
>
> neigh_ha_snapshot() cannot be used here because it copies dev->addr_len
> bytes while params->dmac is only ETH_ALEN long (an IPoIB egress device
> has addr_len 20 and would overflow into params->smac), so open-code the
> seqlock loop around the ETH_ALEN copy.
>
> Same problem and same fix as commit 57549ab90791 ("net: bridge: arp/nd
> proxy: fix reading neigh ha") and commit b824059a673b ("vxlan: fix
> reading neigh ha").
>
> Reproduced on x86_64 under qemu: a dummy device holds a permanent
> neighbour whose lladdr is flipped between aa:aa:aa:aa:aa:aa and
> bb:bb:bb:bb:bb:bb with RTM_NEWNEIGH, while an XDP program driven by
> BPF_PROG_TEST_RUN calls bpf_fib_lookup() in a loop and checks that all
> six bytes of the returned dmac are equal.  Before this patch: 211 torn
> addresses out of 16300000 lookups (last one aa:aa:aa:aa:bb:bb).  After
> this patch: 0 out of 38060000 lookups.
>
> Fixes: 87f5fc7e48dd ("bpf: Provide helper to do forwarding lookups in ker=
nel FIB table")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikhil <nikhilljatt@gmail.com>
> ---

Bot is right wrt possible lockups, please adjust the seqlock
accordingly. Also please
add your full name in the SOB.

pw-bot: cr

>  net/core/filter.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 61940e753552..6fdb85c9af44 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6298,6 +6298,20 @@ static const struct bpf_func_proto bpf_skb_get_xfr=
m_state_proto =3D {
>  #endif
>
>  #if IS_ENABLED(CONFIG_INET) || IS_ENABLED(CONFIG_IPV6)
> +/* Take a stable snapshot of the neighbour's link layer address.
> + * neigh_ha_snapshot() can not be used here because it copies dev->addr_=
len
> + * bytes while params->dmac is only ETH_ALEN long.
> + */
> +static void bpf_fib_dmac_snapshot(u8 *dmac, const struct neighbour *neig=
h)
> +{
> +       unsigned int seq;
> +
> +       do {
> +               seq =3D read_seqbegin(&neigh->ha_lock);
> +               memcpy(dmac, neigh->ha, ETH_ALEN);
> +       } while (read_seqretry(&neigh->ha_lock, seq));
> +}
> +
>  static int bpf_fib_set_fwd_params(struct net_device *dev,
>                                   struct bpf_fib_lookup *params,
>                                   u32 flags, u32 mtu, u32 in_ifindex)
> @@ -6491,7 +6505,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, str=
uct bpf_fib_lookup *params,
>
>         if (!neigh || !(READ_ONCE(neigh->nud_state) & NUD_VALID))
>                 return BPF_FIB_LKUP_RET_NO_NEIGH;
> -       memcpy(params->dmac, neigh->ha, ETH_ALEN);
> +       bpf_fib_dmac_snapshot(params->dmac, neigh);
>         memcpy(params->smac, dev->dev_addr, ETH_ALEN);
>
>  set_fwd_params:
> @@ -6644,7 +6658,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, str=
uct bpf_fib_lookup *params,
>         neigh =3D __ipv6_neigh_lookup_noref(dev, dst);
>         if (!neigh || !(READ_ONCE(neigh->nud_state) & NUD_VALID))
>                 return BPF_FIB_LKUP_RET_NO_NEIGH;
> -       memcpy(params->dmac, neigh->ha, ETH_ALEN);
> +       bpf_fib_dmac_snapshot(params->dmac, neigh);
>         memcpy(params->smac, dev->dev_addr, ETH_ALEN);
>
>  set_fwd_params:
> --
> 2.43.0
>
>
