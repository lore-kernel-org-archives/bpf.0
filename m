Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7292F347533
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848069; cv=pass; b=oZ36wYm63sJrhZrss+sDmtF9s6iuA8ISSLvVZUXT9donAZUn8YmxaP2S6Ndr+5Z5Uv61AJwiUMOem4xESpzSWp9BxTMSXXlybBgEwmYyNx76jENPfap5XJ+6qlchBPzN7JCmLChzPufP5rKfPoOeRmX781U7o1UmMPRx4dPf7EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848069; c=relaxed/simple;
	bh=g8pOFMMxehb9RZ9DhBdkxYORFSov9apiJqUZdwktDlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HoRtLweT7U+HcawdtgO1byDoMsEY+0Wgef+atE3fS6QBOijUUMT5397PKZ4uAKwago1C3TM3a3rte78yhXWfjOBcux/7PIo/YqA6BfgfcRV2Faj2FpWnKcVm9pp7l/HPqs4zK5Oz7GFktu07L6KA7JF/r1RDHwpQApx7in7iiUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=l4kUofqm; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="l4kUofqm"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c95395230so44735801fa.2
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 05:54:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785848062; cv=none;
        d=google.com; s=arc-20260327;
        b=DdH2fID4YRIx6P5kcL2/emN1pZmXghc2D1FLnEIUdu1W+eVprD76Jx7W8E/gaVokbH
         Ot0nODOi8bQtKuweGbMoy1+9P0QaS/np0CvXuwGVFl16avDvMW2wMiGW1vjnmTMlCuCM
         xCqNZ/8UKl2J6EBjUPxMNDrqmI0CDeQj06IJlBZ3MYqDtPmJL3VP5HFXLuzlZ3Z0TM9q
         3F0aMhBDAPo1uiZ5bfRPgKryCpmbaIpD91E+09K3a5x/9wT1wFQkX8WOJ0JToWJZuq75
         wvcVZs6cXGj89mpI2peEI/lRrUIeAYLherkzaeAT1crFs+Ze9WMgDA75W/u/Kw8R4jUw
         V6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5RYPHIjzPhmPACn1ADb7SmRVWtfETQb1UsJ60MYrg+4=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=pUt34KURz4aqyKbtiuhYnClUGw0Kfg0sdtbzqBTaJocaz1/8XZMyjPRfNDgFDOovtu
         rJUi4avWpV+dkXFxN5rFy4lqohQLrKk/xbPKHC3XGbPGzMDUymExhmXcnlySRrcZ+md8
         ysIwgxGcVk0JaeqtI7M89bOe7C+rYwUA/Qlhgzs2oGlX4pooPsrLtpiKiNdgl4mXe4Wa
         ahKShCj/o2X+Af0IyEETFWD8/Mh4W726TY68NiILcTGfbf8j/GPMdQdrERz3HhmxGC1P
         X9aJFvBShHBFW/4ZV0iUf7XATmFl7CuLVvycyejSEZVE70klH5k02zzJiTMx/rzG+RzI
         draA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785848062; x=1786452862; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5RYPHIjzPhmPACn1ADb7SmRVWtfETQb1UsJ60MYrg+4=;
        b=l4kUofqmowD8bvnJvraJHEPDhPbBO339D2N0mbyaCafg/0/klme/jZncDiEHMuLLPv
         /FBsI1Qfkp4oGHkqeFHOoA/lZFk88S5ib5cXyRhFEQOb5f4t5bwpD8bz8Kc119AFXygQ
         TpoGEJEQaLFz0sqsm7lrZ8T2rlgspN0qA0sVwP6+uCqnluME8Pcwy6/MDMk2RJd+ns4+
         9S1n9JpJM/+9+ZCVygRODhxo7l3b3ZGwoLNzoL1Fqzs0Kr5SznVrxoXXlPTT3+8jyrbX
         0meUlOP8YH443gKaQVom+8Q+zBsRuMk+HGEm4S+UHvXHwwLerSLuWJ8BwSys6rPggA8C
         WW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785848062; x=1786452862;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5RYPHIjzPhmPACn1ADb7SmRVWtfETQb1UsJ60MYrg+4=;
        b=IvaXZGc/im830y7UFtY95+/XvTWWAbN8ItOHrTCHWsti/9agtldKtiNy2KQwtLe/XK
         XWoCtYuaBDiwgegXdIjGavH72riirkiGNXF48Ymjz6pZGTU3vf5SfprdKRNVB0LNS6Ux
         Q4HhYBuJyrEwfFAmy9dDXSZ1FbIWHvEUUZR5zeYVAjaq/TTfP3fQE3rlqrBuCyYPU6kD
         1CKK979KdhJQkR5KSCC2/TFsyfndUuE5lB/cmjN+bSWcVEte9tnVsGAh6oMUhC/E5lZ9
         I8lVlsazXXFspnm81iGCVckV/KNK+btJguxeiLcpMujgH/ZsXuYEst4uE3EMb96Rh+V2
         BdRg==
X-Gm-Message-State: AOJu0YwuDpvaT6nOuHHw+gh19HgDQRRDnVLTetOhM5Uwur9fCcSYyHD1
	05auvZQ4//bZAHPzJYeJTXskqNq9dmu/sTLO6w/ciV2dxHvMQ5V2labnqYtNBnq1vJpsBgEIMFi
	d5H7TuzUFaNOVPQKfYwIGFVwHSC4WXgd6NAAnpuVSRtdyf3mV9cNEqpAM3Ujq2rxZ
X-Gm-Gg: AR+sD11HeZPX/cX+yezLQ8gbg1327Tcc9Xg2BU1pKdC+6+476pbIrHPtqajeCcfO+RX
	+Kcv+stu44R8Xli4PueSpd2Tm2J5uVLcDRjqPFbwVR/y9j09uA2zf4PDft9CISeRYRNql2PrsyW
	j+pWrpJ73NsJjiZNfa1E8uoxNs/VyaSljIrxW17/RCo+U2lsNBxJHwyvJVIZHQ/hqtN4ICIrCbq
	Iu8Od0ckqsVtvMFiZLw8oGFxaOmLxtKi6ugBoxV2Ob5hSQ+mhDfI6FsahSalLNUZ2kwdk+qWsVi
	nV2bwaW6zaFc6Zl4BPXN9Ndyv+/qZEFtBoSRyRxkf63QPx2mkhkufec=
X-Received: by 2002:ac2:4988:0:b0:5ae:bfd6:1bc1 with SMTP id
 2adb3069b0e04-5b2e4f24f35mr2111874e87.14.1785848061423; Tue, 04 Aug 2026
 05:54:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785757386.git.zhilinz@nebusec.ai> <6b2afef5d1738763c6965e8e466eb16e43e4f956.1785757386.git.zhilinz@nebusec.ai>
 <20260804121615.E42661F000E9@smtp.kernel.org>
In-Reply-To: <20260804121615.E42661F000E9@smtp.kernel.org>
From: zhilin zou <zhilinz@nebusec.ai>
Date: Tue, 4 Aug 2026 20:54:07 +0800
X-Gm-Features: AUfX_mwY1kKZWT1Qi6nvd0jgkx1dkhCKhHHUMbCWOBOTIy4c3tO-8bsanyyfWlc
Message-ID: <CANB6i5yoK8dV0y8BXDaFFVQ--TkMztrFkFDxtPsGRD+DjTsVXA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] xdp: reject clones that overrun skb_shared_info tailroom
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 8:16=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Missing SKB_WITH_OVERHEAD check in `xdp_convert_zc_to_xdp_frame(=
)` leads to in-page overwrite of packet data with `skb_shared_info`.
> - [High] Incorrect `headroom` initialization in `xdp_convert_zc_to_xdp_fr=
ame()` causes an out-of-bounds write of `skb_shared_info` into the next phy=
sical page.
> - [High] Silently dropping packet fragments in `xdp_convert_zc_to_xdp_fra=
me()` causes truncation of multi-buffer packets.
> --
>
> --- Patch [1]: [PATCH net 1/1] xdp: reject clones that overrun skb_shared=
_info tailroom ---
> commit 06453b67e02a5370da9d6643a102dd0628f4807c
> Author: Zhiling Zou <zhilinz@nebusec.ai>
>
> xdp: reject clones that overrun skb_shared_info tailroom
>
> This commit updates xdpf_clone() to reject frames that do not leave
> enough room for skb_shared_info. It changes the bounds check to use
> SKB_WITH_OVERHEAD(PAGE_SIZE) to prevent build_skb_around() from
> corrupting live packet bytes during XDP-to-SKB conversion.
>
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index 9890a30584ba7..0194e69da339a 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -871,7 +871,7 @@ struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf=
)
> >       headroom =3D xdpf->headroom + sizeof(*xdpf);
> >       totalsize =3D headroom + xdpf->len;
> >
> > -     if (unlikely(totalsize > PAGE_SIZE))
> > +     if (unlikely(totalsize > SKB_WITH_OVERHEAD(PAGE_SIZE)))
> >               return NULL;
> >       page =3D dev_alloc_page();
> >       if (!page)
>
> Looking at the fix applied here, there appear to be similar pre-existing
> issues in the same file within xdp_convert_zc_to_xdp_frame():
>
> net/core/xdp.c:xdp_convert_zc_to_xdp_frame() {
>         metasize =3D xdp_data_meta_unsupported(xdp) ? 0 :
>                    xdp->data - xdp->data_meta;
>         totsize =3D xdp->data_end - xdp->data + metasize;
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does this calculation
> result in silently dropped packet fragments?
>
> If an AF_XDP multi-buffer zero-copy packet with XDP_FLAGS_HAS_FRAGS set i=
s
> passed here, only the linear data size is calculated. The fragments appea=
r
> to be ignored, and the original xdp_buff is freed back to the pool,
> returning a truncated xdp_frame without propagating the fragments.
>
>         if (sizeof(*xdpf) + totsize > PAGE_SIZE)
>                 return NULL;
>
> [Severity: High]
> This is a pre-existing issue, but should this bounds check also use
> SKB_WITH_OVERHEAD(PAGE_SIZE) similar to the fix in xdpf_clone()?
>
> If an AF_XDP zero-copy packet has a linear length between
> SKB_WITH_OVERHEAD(PAGE_SIZE) and PAGE_SIZE, it will pass this check.
> When __xdp_build_skb_from_frame() later converts this frame into an SKB,
> build_skb_around() could overwrite the valid packet payload with
> skb_shared_info.
>
>         addr +=3D sizeof(*xdpf);
>         data_to_copy =3D metasize ? xdp->data_meta : xdp->data;
>         memcpy(addr, data_to_copy, totsize);
>
>         xdpf->data =3D addr + metasize;
>         xdpf->len =3D totsize - metasize;
>         xdpf->headroom =3D 0;
>
> [Severity: High]
> This isn't a bug introduced by this patch, but could setting headroom to =
0
> instead of metasize cause an out-of-bounds write?
>
> If metasize is greater than 0, setting headroom to 0 shifts the computed
> hard_start of the SKB buffer forward by metasize bytes. When
> build_skb_around() is called on this buffer with a length of PAGE_SIZE,
> the buffer logically extends past the allocated page boundary.
>
> If fragments are later appended or the tailroom is used, could the stack
> write directly into the next physical page?
> }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6b2afef5d1738763c=
6965e8e466eb16e43e4f956.1785757386.git.zhilinz@nebusec.ai?part=3D1

Thanks for the review.

The reported issues are not introduced by this patch. This patch is limited
to the reproduced devmap broadcast clone path in xdpf_clone(), where the cl=
one
is copied into a single page and can later be converted to an skb without
reserved skb_shared_info tailroom.

I agree that xdp_convert_zc_to_xdp_frame() looks like a similar pre-existin=
g
area worth auditing separately: it also clones into a PAGE_ORDER0 xdp_frame
and sets frame_sz to PAGE_SIZE. The SKB_WITH_OVERHEAD() bound and the
metadata/headroom handling there need separate validation because that path=
 is
for XSK zero-copy conversion, not the devmap broadcast clone path fixed her=
e.

For the fragment point, I would like to verify the reachable path first. If=
 a
fragmented XSK zero-copy xdp_buff can reach xdp_convert_zc_to_xdp_frame(),
then preserving or rejecting frags should be handled in a follow-up fix.

So I would prefer to keep this patch focused on the confirmed xdpf_clone()
bug, and handle xdp_convert_zc_to_xdp_frame() as a separate follow-up after
checking reachability and reproducing it.
