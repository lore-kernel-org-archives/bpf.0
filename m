Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F0B47127C
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789815866; cv=pass; b=NGCGCHViEFM5YMeZZJbF7wHLQZb1nLNFoT5RhhtLxTeZxiFldO8B8lF2haXGhw9fzCnphvcf5MRxtIj54/iMi+D2Qy0gyRg937GOnODG/7j/32tPR0Chfnno6tlp1uDHHIUnWFxieP5FWxfqsnzI3Q9MMgYLj/zxwr1P5iuLRyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789815866; c=relaxed/simple;
	bh=Uy8pdbu6T+f7Vaa/HfQOkCmS8NcxSl/AYSWfTMzxSOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MG71fNHaCWmbGxhz5+u8697jFZKRsNIdyVolnzrGMDs3uoiqK/Wu69iKYgFrxoNcOSyzwHS3w2PXR3dMsCh6Bg1AVORtjI9tcT30SZfnOpV4MKxuCA/RIswQJ2yeuA7VI0PUTZXKTQJSTqdDnPHijFBhRjobOn7dVm4M4ng4O4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hA9OeGUz; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hA9OeGUz"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a99cd5115bso2372752a12.3
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 04:04:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789815861; cv=none;
        d=google.com; s=arc-20260327;
        b=W4t5jRYgRM+g3fpqtr+jGk6jI+PjB8jy5OhmIWxDDEV4Ogdd82UQ/rA/Xj1UfiWX0N
         9V7yN2JGO6UaIgTzuqN1NCYfBshETPiQKYNqfxgeBzm5Ntfl0ISFyKyN3PQ/HgWmq4sy
         IuLObspt1mtvplCwe8Qz7zQQiNa8aSlNgTZE8GPp12z0aOM2gIr/qeFAbof8oevZ2md3
         OfyXEBKoqeqDmCOAWEjRu0Kzhq047yus4MgT0cH9VG6wWHTRFKOiWWQVPGassO6awFOT
         d3gcdOpkA5Fbnrv1X9IERu14qIYFgj8Yeur/8rVpGu77ob7NA9Ndwk6nQcKVaeHEIEzS
         41pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TaoU/CXeNzW1XLhDMwPnWzYzMZ7xTqLcjubBtefo9dU=;
        fh=PSOMr49a5Fxe17hs4kQaSwSJWfn5qWDAJnHUMpVmwBU=;
        b=IIUljY4ftSXQ8lMk/JzNr58UOp/plR2AMbIAeXt5v8XZRTmvHxn9bBobsKfv0pRi/q
         O9EMxxniWbVlxMJaBpL5gbcLpqflU73y4nhbNanAVyDJDIbRPLD/6JhPPAgYkxZgamzz
         jk5ORXgzMKoM4V72oHdIYmf0Vrr3DEW9nr1PRMg/7ltsd7KfLkkxpBD9VNPrgmBfliZc
         1dMGlniyzWkNd13Msw56WYXBXVKTomqzY5VcQf9xKoXknNvCFZjzG1+F8b/QK+rD1sd8
         G9/31nOnhAjqm1GhgyZPiHh1e5n3xNqTupmzzdYwLbi27r1MaIntmKcc1LlYTLQAhsJk
         XKWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789815861; x=1790420661; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TaoU/CXeNzW1XLhDMwPnWzYzMZ7xTqLcjubBtefo9dU=;
        b=hA9OeGUzy3Vd6kP9d4L+TDaxqU1xiw5lxsywbrcJT8yepumnd5t5E8BWcHU48ejDJo
         e0dbw6a2Cv4eH6yPzj8ZTnHhRiXNDDGYA1GHqsO5IqfCjRQRZBcld8GHhDrXMoJVY7AM
         zL1frWoKvvpueQYCvecI7zKN+nB7LH2K6PUNG7GAFvSuxqivvjqRUz+H0mcDxFqb4Q6u
         1/K/hFGKtU9H2mvCs9Rx1iZEFlwIad6IFfJyLkey2Vl2Uej+DaYWp3aDWHfNCCzMHdmA
         pjn2J8YN8YfwHeqrRiQQMfRY+4ZKxMc0Lwm1AfUNlncJSvhk0lSUcNiP40kwS8BsARb5
         LCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789815861; x=1790420661;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TaoU/CXeNzW1XLhDMwPnWzYzMZ7xTqLcjubBtefo9dU=;
        b=RltYBoqApzRmuh1T88iJlBNUOvX4Z1rTgJOWjJo5Ui2Qmfa3llJj5LOb6GBEQYUxUq
         o7kULhLa/P8Z8mGQPE7Pco4v8GDcVfQoThrXk1OfXTBLh9UkJBkZm6avMVkNvDVIXgW9
         RccxAv2mFOu1uCcm8H9bu20AAoM+BRQN009Zwp31iSu7d8+g4uxVj5lUEVJwnsfu4xsn
         KM3sRRsfC9K5FlHMLKblYgr/GkbSq14zHX4OXPJpexzroGia4Cmu4vT9KokxuYt4K+x6
         a7sFVClIy1ubl/6M5jyo/TYhTruEQIbKM0K7iVGSIUJrbhFqTYe8VTa7H26FbNgZ1yIv
         8Udw==
X-Forwarded-Encrypted: i=1; AKwUvBxvGutBrLuASxjZdkondpT364tNiwXNYI4AUGSZGruaYkTnXlm94mGEYzJ9qeEkYPrMG2Q=@vger.kernel.org
X-Gm-Message-State: AFuF++nb6guyt9iyc/sf4usT6oCwQZ259BumfuzCcECAMtWJb09j6zib
	YziibbklfxTsOCxVvsXZ9ImRxCrpAMZf1CnbzI/tcaXheNHm6tXICZs+KY2n/PlVURoQXUuUADo
	9VkJ4nByDAt9lq6Qp860GCbaAbuxIHlY=
X-Gm-Gg: AYBFou3ihGhVemi4QFaZT6/bLBMNSruzC+mQXMjl5qQubV7KIeYcTsX/SmDvdiKnyQm
	tFw9U7csLo3OaS5/DG85hHLVLLah/+8oLtCdRuoPNbiyAfL+ksP3Dh0hzlvtVF43aC43DlNCUCb
	SHtTSXwi+SsamZ0cMYmywpMhuVpLUzWxDbXWAJb9igBUn0Cee6vpeeygM/NK8qkRwIood5rpwoe
	7ysrrxLhiScxV49QkaKFx5FCgPTzzEhR6t1AM77yUnZkWO8CGqZdmi/ip6vITBn2ciF3x2ASztY
	yd/0yH+yX+t8wkBQ5zCyAwGSBSI1CqZCdEbXK9UEHfgEdJL9UacDfbjLghhXVaZPi+NWUiIrLWs
	lp3IKJTalSpJV5WtugN37rEU=
X-Received: by 2002:a17:907:1c93:b0:c19:6104:e5e4 with SMTP id
 a640c23a62f3a-c2a159adbefmr463681566b.20.1789815860423; Sat, 19 Sep 2026
 04:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917161335.1020405-2-bestswngs@gmail.com> <20260919110053.497301-2-bestswngs@gmail.com>
In-Reply-To: <20260919110053.497301-2-bestswngs@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
Date: Sat, 19 Sep 2026 19:03:43 +0800
X-Gm-Features: AcwNN1VEN7tDxPHeWKB8Nrg6EuEcehqwkEM-7eNLy9K-KJ6bav9GGVH1VcMnkSQ
Message-ID: <CANgPUi3E4g09FpaR2gz0eXuLQuLg4qJAp_Qscorb0b4Szj_akA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: reject dev-bound-only programs on other devices
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, xmei5@asu.edu, 
	co+ac0a8c41de69121d@bugs.sh, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<bestswngs@gmail.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=8819=E6=97=A5=E5=91=A8=
=E5=85=AD 19:01=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Weiming Shi <bestswngs@gmail.com>
>
> __bpf_offload_dev_match() falls back to comparing offdev pointers after a=
n
> exact netdev mismatch. Bound-only programs normally have NULL offdevs, so
> unrelated netdevs compare equal. A bound-only program on an
> offload-registered netdev can instead inherit a real offdev and match a
> sibling port. With CAP_BPF and CAP_NET_ADMIN, a caller can use
> bpf(BPF_LINK_CREATE) with a different target ifindex to run metadata kfun=
cs
> specialized for the bound driver on the target driver's xdp_buff. Running=
 a
> veth-bound program on tun reads beyond tun's bare stack xdp_buff as a
> veth_xdp_buff.
>
>   Oops: general protection fault, probably for non-canonical address
>   KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
>   RIP: 0010:veth_xdp_rx_timestamp (drivers/net/veth.c:1673)
>   Call Trace:
>    ...
>    tun_build_skb (drivers/net/tun.c:1739)
>    tun_get_user (drivers/net/tun.c:1856)
>    tun_chr_write_iter (drivers/net/tun.c:2091)
>    vfs_write (fs/read_write.c:595 fs/read_write.c:687)
>    ksys_write (fs/read_write.c:739)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:84)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>   Kernel panic - not syncing: Fatal exception in interrupt
>
> Restrict non-offloaded programs to exact netdev matches and retain the
> shared-offdev fallback only for genuinely offloaded multi-port programs.
>
> Cc: stable@vger.kernel.org
> Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
> Reported-by: <co+ac0a8c41de69121d@bugs.sh>
> Link: https://lore.kernel.org/bpf/20260917161335.1020405-2-bestswngs@gmai=
l.com/
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> Changes in v2:
> - Drop the redundant offdev NULL check.
> - State the capability requirements instead of using attacker wording.
> - Move the regression test to patch 2.
>
>  kernel/bpf/offload.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> index 0d6f55695..d85539981 100644
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -698,6 +698,8 @@ static bool __bpf_offload_dev_match(struct bpf_prog *=
prog,
>                 return false;
>         if (offload->netdev =3D=3D netdev)
>                 return true;
> +       if (!bpf_prog_is_offloaded(prog->aux))
> +               return false;
>
>         ondev1 =3D bpf_offload_find_netdev(offload->netdev);
>         ondev2 =3D bpf_offload_find_netdev(netdev);
> --
> 2.55.0

 Sorry for the noise.

 I mistakenly sent this v2 series as a reply to the v1 thread. Please
 disregard this posting. I will resend v2 as a new two-patch series.

 Apologies for the confusion.
