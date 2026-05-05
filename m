Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B473BFE41
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 19:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778008769; cv=pass; b=mmIjyHyaJ5c0piigDVnRuKUry83t43O25SSCdxRWSEoWRTh4+RqH7fl2Q5O7AQPhzPfVb/09p666moa2ecdYLLjR4qV4fTDVLF+PAz18fSEKfn4zPC+0zOr2c+OMfSN5Tvl6BkhUpXbluk+yb3gfyW9r2+8z9T7KsEIoAqs1eTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778008769; c=relaxed/simple;
	bh=OJ/azNTybqYl8mOJ31pbz8g2rYikwtmrBFK0JFJNo5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvTru0LgKwJr1nHmnXRFuns1J0br6fXTR88LNQ6wcEEbL3JueDQau9P+ljKYfqY6CsVTToDjtIxDauwPsija6KHmg2UFEv3Rwt6ImXq8cD02s/tv6NfEWp1BKcRvmoCXG7cK4zku6jcEOl4loZhjLe366MQVVkQuEVnBJXliUXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUthnH/v; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUthnH/v"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38e7c3a2deaso52343521fa.2
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 12:19:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778008766; cv=none;
        d=google.com; s=arc-20240605;
        b=hDBkWkqsUTDHxcDgCySXDOCroPLRNfYx20GTr4ZY905spjj+6DtfdUHE+Y7hb7CDhm
         jxCz+7eJFBLKJ+BsTweBM9Iks30CmDx39kS7I9akiKYXmdKKgsEmTOFeV+33MlUxoR6v
         sZsGB/5dW02BK2aMaQbcmEHAOsaVR8eorhfh8Gy9QRcWcnnJ0AbywmJMYxGmobwtlRjl
         OsmzkSRxJB1BcttrrQtlJVmsfcEDXc56+I34aFvm59xRHOTcqA4uemZRdiM96YLncRNm
         xxAyafdSV/iMWruBH5dGcc1VcZYiIW+chrprDb6oiousr+V55PbpRPrA78RtfPm0RvwI
         tFQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J2hInhsFpGHxbrTs3e35Gl5nCTj5ZNbvxNvr+9nvuEc=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=ScrNYOzt8/ZQdeDCzEpS126DtYnZgs7M2TuDNqtnoU/VYbeXGcck6HPheD+rUpij1r
         7UtHNenaRU2/Bw75regRnDR3Un+EwNB+2ruYjQW5vS0t7Xc9+qmgpKyGwteSfwpfT6UG
         OdlI5RS0SSUVlVWkRm0twU9yeIADU6QL3cFTbdquUosuo+SgKM9uxjHTh3uxIt0GMemo
         DAWIEAnFi0EMVbTzoaUs/fKPjLVcbDsAok9mDjWWjuhEbx2MGHCmuNA6Il6esO1Hbo72
         sBjN0KMTR3JlbmtgeMu0+FXWL0o/RRfE3jGAn279QJJcYRw9U24ziSSotUwB7ORa6zby
         C6Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778008766; x=1778613566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2hInhsFpGHxbrTs3e35Gl5nCTj5ZNbvxNvr+9nvuEc=;
        b=KUthnH/vycmSN/CFJ3WMJOWNIOEiHKET46Wb8meHeH+RYrmaq7w92eLvuzTWI4ocZF
         tBM0Sy2/RrOadpdrgyFUCmH85UV5zx6dMzCUtgoG+WXrOFJl3U0ruU6mpHJq5s/btcL+
         Hx+gBrKW7ApZI7JZ8Pv6FbLMFCdpCFwVNn+aTP9iC0juj+Z5zuTvXEtTkKh5R1PwN8k8
         +vzFUuonFNUemtwgzoCAqxb2D+z+/gEt0ZNWkPuCgzAoWokiu9aMUYmslvqD8juPJ9iJ
         6vK3C5kT9oqaZLEfdAPHksNKvIdIf1ATD6qXvnyidfFi4OEJsUcfYxjFnHaDuCn9xQoO
         HNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778008766; x=1778613566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J2hInhsFpGHxbrTs3e35Gl5nCTj5ZNbvxNvr+9nvuEc=;
        b=bJTsstg7ld4+LSNG02psSR9rJ7mGbEa3f5ZgJlHR7j1vgyQa0ZNm0CPl3P4q0KIW1E
         uTbSZGwxxkL1+gV2syX143kMb6Rpq2szOUOB6xxY/55KLStGT0LUAzL4IfExP7wIca+v
         nLPy4wHSe0x+jzhh8apveGtCmjUVwDgxCEwyQdeuFEVFB+jQKxRQcXWAYgliLPxBZBS8
         PghzbVC0JMGxA8rivFBvycouqDO8KbK8GUzqPmASbzGwi9DUAotVuJIxPHLKvjqI4h+J
         l4qV08iGLgEVOI8wfnaDCfPHrAGUODKPfDyJracN726ao2ssJXlaepUbBW61B19PimaJ
         2v6w==
X-Gm-Message-State: AOJu0Yx6yoOanbUxeSC7EzLjXJn+88SyQiN1y4Xs7/ZHvma7KyJUW/61
	3mMSbOgbKkEi03Qyv7QG+3hBOLFknUBxpfU0Rs6itDTn4wV/tm85gjRbTdTvyNSgFMbIpGxkmas
	qAJ4j5nPlK9m3UpmKiaYQe3crDgOholBehDId
X-Gm-Gg: AeBDieumR/ZtiMJm7xCfkjqKydFYChfckE3NR2sR9pTi4LKz/kkkWwzqS7k4e3SDuu+
	A+k+UefsYvu09rQ+eQDXD/OsGS8c5eIGOBE2r7mIB/+st4IYPLRboeuaPbdzxM/ahWxHYbFlsN3
	kqQWFZdJkJv/JHu8lmbhy4d3+Za77Vv+oRrU8P0IqUqg/IGJlMYvR6L8BYNoBfZIzRgoYWWllXi
	epdWfSi//sm4Zgm3w+kdKgnwgFwzZcdJKDag9O9+oF6s6AX4sggXZ0UaEqbpprie/C8u5espbpe
	hzZGhLA1zYzzDsVr6CslAftSmr2RTYAUBrXfvnmGIAepkFQH
X-Received: by 2002:a05:6512:124c:b0:5a8:7f4c:8a22 with SMTP id
 2adb3069b0e04-5a887cdf0a2mr16191e87.20.1778008765335; Tue, 05 May 2026
 12:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502200722.53960-2-kerneljasonxing@gmail.com> <20260503200923.7665EC2BCB4@smtp.kernel.org>
In-Reply-To: <20260503200923.7665EC2BCB4@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 5 May 2026 22:18:45 +0300
X-Gm-Features: AVHnY4Izr1VDOtLcrgCkeA9mksANhIATUkN7CcbB1jdPUEjGd4YL-TtrrNIfxM0
Message-ID: <CAL+tcoD09aryHzbUTwDMBP1u2fiCDO3MWo3fvsVSK58DG0TvNQ@mail.gmail.com>
Subject: Re: [PATCH net v5 1/8] xsk: reject sw-csum UMEM binding to
 IFF_TX_SKB_NO_LINEAR devices
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2026 at 11:09=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Unconditional rejection of `XDP_UMEM_TX_SW_CSUM` breaks valid na=
tive zero-copy configurations.
> - [High] The root cause of the 'wedged TX ring' remains unaddressed, allo=
wing trivial userspace triggers.
> --
>
> commit a1862dee263d88bc3b6ca0898f858a88e2e37fce
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
>
> This commit attempts to prevent silent per-packet failures and wedged TX
> rings when using sw-csum with drivers advertising IFF_TX_SKB_NO_LINEAR.
> It does so by rejecting the bind operation with -EOPNOTSUPP during setup.
>
> Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kerne=
l.org/#t
> Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate f=
unction")
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
>
> > Without the patch, every descriptor carrying 'XDP_TX_METADATA |
> > XDP_TXMD_FLAGS_CHECKSUM' produces:
> > 1) a WARN_ONCE "offset (N) >=3D skb_headlen() (0)" from skb_checksum_he=
lp(),
> > 2) sendmsg() returning -EINVAL without consuming the descriptor
> >    (invalid_descs is not incremented),
> > 3) a wedged TX ring: __xsk_generic_xmit() does not advance the
> >     consumer on non-EOVERFLOW errors, so the next sendmsg() re-reads
> >     the same descriptor and re-hits the same WARN until the socket
> >     is closed.
>
> Does this completely resolve the wedged TX ring issue? While this patch
> prevents skb_checksum_help() from returning -EINVAL, xsk_skb_metadata()
> can still return -EINVAL for other reasons, such as an out-of-bounds
> csum_start or csum_offset provided by userspace.
>
> If xsk_build_skb() returns -EINVAL, wouldn't __xsk_generic_xmit() still
> evaluate if (err !=3D -EOVERFLOW) goto out; and break its loop without
> consuming the descriptor? Might the generic transmit path need to be
> updated to consume the descriptor and drop the packet on terminal errors
> like -EINVAL to fully prevent userspace from wedging the ring?

I believe we've 'discussed' this before. This is a fresh new and
pre-existing bug (happending) unrelated to this one. A few days ago,
thanks to your reminder, it was put on my to-do list.

>
> > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > index cd7bc50872f6..d981cfdd8535 100644
> > --- a/net/xdp/xsk_buff_pool.c
> > +++ b/net/xdp/xsk_buff_pool.c
> > @@ -175,6 +175,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> >       if (force_zc && force_copy)
> >               return -EINVAL;
> >
> > +     if (pool->tx_sw_csum && (netdev->priv_flags & IFF_TX_SKB_NO_LINEA=
R))
> > +             return -EOPNOTSUPP;
> > +
>
> Will this check unconditionally reject valid native zero-copy configurati=
ons?
>
> In native zero-copy mode (when force_zc is set), the transmission path
> bypasses __xsk_generic_xmit() entirely and processes descriptors natively=
,
> meaning it does not use xsk_build_skb_zerocopy() or invoke
> skb_checksum_help().
>
> If a UMEM legitimately has the XDP_UMEM_TX_SW_CSUM flag set (for example,
> when shared across multiple devices), it appears this will now return
> -EOPNOTSUPP. Should this check be restricted to only apply when using the
> generic datapath?

The same topic we 'discussed' before. No one is using the software
checksum feature on zerocopy mode. People will be warned because of
wrong usage and then adjust their own codes correspondingly.

Thanks,
Jason

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502200722.53=
960-1-kerneljasonxing@gmail.com?part=3D1
