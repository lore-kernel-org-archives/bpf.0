Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB537D135
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776729110; cv=pass; b=so1QnzdI0cXHQ2Z/wyiTMfE+p/+8rpgVMBPdDZpkYu5vuCc4dtwA5RNFLmabd48Qpe5UyDueQ10lcKnuO5TYeBv1yGqSUVAkkXvnXrTy/cvbKI79Hqrrvm8/E4zicPvWQtDWBJSDOhXmGu7YAOQfxPygqMi6imj7fZfDB9gzy7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776729110; c=relaxed/simple;
	bh=s9fEB4HcPUF02NL65VFRpx5OJumcFk5Y0bPMUsQ9WUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQmSqlAaKX3ya8L3nxNMnSs8A7elUU214NAOuWHGrZlLGN/L1vNB6P+hKrOUTCjm7LP4JgFmgukm+UZDzEH7soYT7TnbIqYTUyat5QvmFCC1S91q4XasyGo74b2aR1KZGHuZHI7rvy7H6x9UNzpjZv9tdgoMDnKSAfZdWCxr2jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aa2fjAQ+; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa2fjAQ+"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a10d130b37so3570419e87.0
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 16:51:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776729107; cv=none;
        d=google.com; s=arc-20240605;
        b=Qzzo/tEJ627Lb+IFJq69R44mxp+lsO4iwIMXPd7e7IYdmoszSwo5RT3HCUOEXttGwi
         YVs2O5o5kyJb6ECj58ePwYHOUAaGH+PZZjTiuxiI6HlIQ/bY0/Fu6DmuuuUL7c8HDmi0
         xyITbmpzmhTLWMOcdBUpr67APjJ7dF9GvxylcIXBfZ/Smrmal2JXR9H6hERypzQs74Jx
         Ma5lqgfSl09Y4rgt7e+CI4Sulqwv1Gh93WVjIIXVsmFY37AusATlDpcDhkyApGBN0pE+
         dPJpcZ8FjHL698oSTUTuScObFvZ3GVdGdWuaJ+e7ZUO4QAkvsQBTSwWhBRZexcd2zxWv
         lmDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oDo36uCMCaHt5ZmgnJMJ4TzVZMj5UW2xL0ZAxqW8dlY=;
        fh=ufUKeSpCrM7UZhECS00Uov6qBYdMktaAxuA3HGXOKqc=;
        b=A5bQ05/xkvvkPmouN6O0kmLJg19aaFSWnHDhXLnk5mPFJYuoCTlLjROfrS+d5vyNaW
         yXbfO5dRkF3zkIG1vm18SkY83zLztmiNhaFfWCuqfjksOn4sqqL6qaw4kfPedSnzlDvB
         UhUnOwlFRM2xXG+SWWZM27b7xNBlnQiHPzMYfyMXpZTX6cOfkidnXGSiToiQRK5Ma66e
         cqpmReqeLVTQP0pgRG6xLiC52VYiTu21HrXNRSLZrgoeJDtzNXFLr3Va3NCLiUvdfk+y
         NlqYyF0SM5RwNE2UAv2p5kLOKmkgkD/bP4kktFPNqfWwwYpsGFCiHWQHlnFu9lBcxcOw
         3iYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776729107; x=1777333907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDo36uCMCaHt5ZmgnJMJ4TzVZMj5UW2xL0ZAxqW8dlY=;
        b=Aa2fjAQ+F2vq0LLiojaiMi/J4n62t2MjPZFtYkAxZpwkONbqnjH8KzgIn6WBkJBayW
         CkoHP2ASmQILpL1vtkmh+Hr7IX1Ao+Ak+omfyK42smPoCK71Z1M/axWD0c8fOVyN1kVW
         ZSWJXBm8juWnjfT7kpwxZ4P4RIQDGLEhvkYDkN99yHCWN278+626CHklTRsRs7PG+ecj
         f7/77nZeVm6qxtwvdOBXngXbTpM7UN7eq5rXjQCpTd7rhKxH9V/uuRI2xp+9apaJ5w98
         cWUBNpc07nwXvZktctLxPhyp71YZmLfZSNrxLs1Qp6eLtc+XH0Nm5eY3U6lzS6lCP/7c
         AH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776729107; x=1777333907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oDo36uCMCaHt5ZmgnJMJ4TzVZMj5UW2xL0ZAxqW8dlY=;
        b=EjogciRnemvZ2+7DcjV/hLFWC3WZRCb+JSehaLK+tor33fPDdLTzUASLcX+C2hIIln
         jnNs92KKh5Z4FqFBgk2dgrWUMi0ulFyQFPCtw2TGElxrjH2jhjO/+WGs3Pzsiy2Koasw
         Z/D/D1RcfN7xdM7nDsQTPzKHc0l8ywjZteEQWLzxD/T2NwSCJDovPavIsZl42yxHEzcQ
         azkPrBoXREg6ycc4T22wjw2XSsWfwwg6ZbYbzbzuYXqNj248c4c53/KiCcvYlf3X2Wtr
         s65EfklH7wF1ZoSG4vOTbX7UDInwOR1l6H6bv+nuThwZf43nazowbI3unzmByydp4XpS
         LmXA==
X-Gm-Message-State: AOJu0YzbipO7sLm9ykmuPw/cRbrKyzfyirtXSuiwQ1NiehQYYM5w2MOu
	Qemlw+lBYq03SdeJDZ+IhBMLf7Fyba/aiCqgVOImWfsjCVkBo03YNGLbYEO1kI1hV0TOAo7buPB
	/obgnZTDaoLYw9cEVbxSgxFvQ5aZcFoY=
X-Gm-Gg: AeBDietQ9llyPz5TZat71ngJ6SqD/cMuOJUbT2CTHCc4p+7UUGMwHQreaWGqamA/ZeS
	Zk+sI/fJgTfoL+lA/K+mf8MiPiapY+PH6uX8OVvgNX+LVuN+FaaDvxaDXIjqKFOfdAMPFo72OQN
	fKmPb47Yv99bCFwkou9GivjWqB92AVoNRgpsxdQrjnSrL8AwVZvKVbI9w9gDzWHy7hof4zctnOY
	q6m2EHt7KzMTHBi6rK2u4k2SruApazlCusgiAJ9LQvP5KTO5sF1uEvXtaM1bmcjMTXvUdYu50EY
	vr6E5+AFXRwKf6FULQ==
X-Received: by 2002:a05:6512:39c8:b0:5a2:b259:5569 with SMTP id
 2adb3069b0e04-5a4172a2e01mr4324041e87.15.1776729106838; Mon, 20 Apr 2026
 16:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420082805.14844-2-kerneljasonxing@gmail.com> <e4a22d20c77e94657d63243af39a0667.sdf.kernel@gmail.com>
In-Reply-To: <e4a22d20c77e94657d63243af39a0667.sdf.kernel@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Apr 2026 07:51:08 +0800
X-Gm-Features: AQROBzDt6xk7X7rL1lu7M5J437t_MiicWLglq5dSczkZIyjL9h6pxEYDUZ4AwYg
Message-ID: <CAL+tcoCwEeOriG3y-EZm6TfDenr3uCEDXUJ8MtrW9x=Jx40ohQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/8] xsk: reject sw-csum UMEM binding to
 IFF_TX_SKB_NO_LINEAR devices
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 3:34=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > skb_checksum_help() is a common helper that writes the folded
> > 16-bit checksum back via skb->data + csum_start + csum_offset,
> > i.e. it relies on the skb's linear head and fails (with WARN_ONCE
> > and -EINVAL) when skb_headlen() is 0.
> >
> > AF_XDP generic xmit takes two very different paths depending on the
> > netdev. Drivers that advertise IFF_TX_SKB_NO_LINEAR (e.g. virtio_net)
> > skip the "copy payload into a linear head" step on purpose as a
> > performance optimisation: xsk_build_skb_zerocopy() only attaches UMEM
> > pages as frags and never calls skb_put(), so skb_headlen() stays 0
> > for the whole skb. For these skbs there is simply no linear area for
> > skb_checksum_help() to write the csum into - the sw-csum fallback is
> > structurally inapplicable.
> >
> > The patch tries to catch this and reject the combination with error at
> > setup time. Rejecting at bind() converts this silent per-packet failure
> > into a synchronous, actionable -EOPNOTSUPP at setup time. HW csum and
> > launch_time metadata on IFF_TX_SKB_NO_LINEAR drivers are unaffected
> > because they do not call skb_checksum_help().
> >
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
> >
> > Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.ker=
nel.org/#t
> > Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate=
 function")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/xdp/xsk_buff_pool.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > index 37b7a68b89b3..c2521b6547e3 100644
> > --- a/net/xdp/xsk_buff_pool.c
> > +++ b/net/xdp/xsk_buff_pool.c
> > @@ -169,6 +169,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> >       if (force_zc && force_copy)
> >               return -EINVAL;
> >
> > +     if (pool->tx_sw_csum && (netdev->priv_flags & IFF_TX_SKB_NO_LINEA=
R))
> > +             return -EOPNOTSUPP;
> > +
> >       if (xsk_get_pool_from_qid(netdev, queue_id))
> >               return -EBUSY;
> >
> > --
> > 2.41.3
> >
>
> Wondering whether a better fixes tag is commit 11614723af26 ("xsk: Add op=
tion
> to calculate TX checksum in SW")?
>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Thanks for the check. But not really. It is the commit 30c3055f9c0d
that brings the csum support of IFF_TX_SKB_NO_LINEAR case where this
issue can be triggered (because this mode no longer puts data into skb
linear area).

Thanks,
Jason
