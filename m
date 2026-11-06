Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793959010;
	b=4Sn6j08HVtH84Vtc7Sqx16eBH1kMwz3Sp664C7KRlTyKa6fTRcqn9yXy+i+7/54SxoUc
	 Q7Ng5G/k8l8Dj2CWtjZtlM+d8EoEw43cgbtKXmTFAxAPLulzJFvH/Ix2Ggl/gkG3nFR7U
	 DSVfz5xZvIJjpL02UyZsHuFLYN6jdEtIaOXd1tAAYst+bnyf5hHqZgC3Dcc/bcBJL6TxJ
	 s/BG4G33sAuzqd/LVy5uBZCi6YMEY6v/y1WK/DcA26+z0zEPzjpPHB17wdrDTOETLvVbX
	 OgW/Qst3sUsKMeAQ0CA8Psn1DmNRejQcXKkqIOgOLP9ELhNhHHze9ebU5edtyOaYEPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dXmTy9uwoF9XL/Y4Z/VfoMc9t8DpXi9yTYkuKDHufjU=;
	b=apUoKiIjMFApus1GW3HRI4r0FKnVevuqv2UZcGLJU4RUNzTZZhCdeR9KQhwMczIgZMfi
	 GQtC5Vs5PZ/yYiNv8hQm9Ar3R6xzslVff6M+3aI0M+A9dqA4d8zW45CvKdSXoTvc5qiIp
	 Q35askK4XZ4tEXY2eCvAManv4XiGHTdDHfIprn2UdWVzCy/M36j4LVwbHAAK3b/lQR2Gd
	 5zB526xIH/5/7sJ/qlS70OG70BAtAkyPNJ6a3PkN0KH0bi9+uXC2GJcWKXPYO529zFExn
	 byFFO6lF3FcbIIx7OqwLdtEYnpiMWSQu7rrlubtC0ZVv3Cbctu96dsVn/Z5CTcs4cnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mG007myQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99821606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 09:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99821606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mG007myQ
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6fbf1ba31fbso190938eaf.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 01:56:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793959008; cv=none;
        d=google.com; s=arc-20260327;
        b=dzaARM9lVeJvjdkFzXv1BwCxBNRRKBa3OjaHlLzHOJwBPs7byDFueDgcb1WQ/liIrU
         nraltgUp5yhTJh964JFGaLXx1440AkWN/Fjy/scUdsPRYVp1lUe8cdGatO6RjRLUuGUZ
         5RUIW2NgCEDiyXYO44hICsXIO/gd8xnEX7Rp1xaPtSaUcBry7uMs0YwMR/ct0JE3EpFa
         zpgSYZbr+CZGBy8LoFEQZ1eWUm0yzKXmWART7fVs5JAQQFBzESgzfh/65vPVvxrnDJHu
         yhubnvXtu4R482Mz8nuyGEx454SCygOyUF6HWEJkjWDni9wkOOu8GWjOGy92RBRhtcVY
         0WAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dXmTy9uwoF9XL/Y4Z/VfoMc9t8DpXi9yTYkuKDHufjU=;
        fh=0XmEwrk5JthXmCtdcDnS6bnkVSWEk7W06xaHRAYuoKA=;
        b=BvGPsBoFbrTjJVwWSDp2927ZZ+AAbIL0QTM+3E545dRfgrCtJJnOrKsMhi7fCdQiRb
         NA/u6gwB7pUAthMkCu60vhseZaAip9XLsyZ+JnJ/meZcvES2i5I9ew8eAt88Sb/2VWwq
         wxKp6litkDPBN+RMCmB+8C+abdZEIm4b5oqDl8bCCJSijrBxfgghdy2obW3TItNHuH+J
         v5/KwOS2KFxme+cUHHHVt8K7Hmg1IgCNBltiGojdrJSvZETKdOM0rjM8/uwTSjiox1XR
         AMgMC1sjvi04dAH0WORhluyidjB8TOIXpP2BFDKRs2DUDnGeQvrpkEYuE5Rh7KbVtanW
         xfmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793959008; x=1794563808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dXmTy9uwoF9XL/Y4Z/VfoMc9t8DpXi9yTYkuKDHufjU=;
        b=mG007myQQv8iEXsyxOhdCLnDBMuJ3sEudhIrw7XVImYzlfD82GgX7wDT9wWsOFl7Hu
         7yjF5uIW4+03ikLTTQO/NepbXhH6cxxQ1bDAPVzdH9pBF12xoA07HBfACxMIVODigtyO
         8Pv0r9YXE70Lz0NdKNofcbuJ92qGTCEq6noVO0bmcLYbZvU6M8QCrbS9ssOTdjQTcoGE
         K8Hn5VcSZNVb74u6JG+376HsPL3P2poNRfjlxFZUa+mU/T2zPD1R3Me81fZV1QNvwQns
         ddjWEm7SzLwMRNK6UtM9KROEjUkfoY163j3VoWNaHPJZ2Aji3wFyig81U4NuiDcC2djR
         +Ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793959008; x=1794563808;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dXmTy9uwoF9XL/Y4Z/VfoMc9t8DpXi9yTYkuKDHufjU=;
        b=fhDzB3MQedg3ZxaqBfW6VjcosKe1l7+DE0h7EPAp+bebaRHrLX0R39hPB2bp+DbeZO
         +QqZplCGIiJ55o7kpQYbUJjzfbaGnghO71Vws6nOtr5e/jX4DSk0ZywxODekB21ud+wp
         kSzoK42Q6AvT9CMTCmxvl3VL4xSRg6vOhmFzcOHM4RSo1V/Nq+PjXgdMmK1qQjd4+rZL
         mNBC1bLkKZVmCu6xqMXSXiKstx60ndHQxVGIZy6rmntm31tk6C0LCASjfpyFkJq99bjB
         IGSS7CKH/lto5Py9DxoULGyFyB7JhaXhvAuW6K4e8O33QNR1hRL46f2kMLZPUYlEyij5
         Ydyw==
X-Forwarded-Encrypted: i=1; AKwUvBxKGs3bip2uncr/OvNRpweaOYKv0q3d0BUUI/WyB4JuL6XHtzdF0kSf58/EUIp0IoJqETQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/fL8yN0y3SoNiV58lh4NK6i6v/DYEMJfNu6sK2G+EKlA5/GxYi
	Y+qRhVPVKs3Xp00H6d9FsGBoyobF4L2MiPDr6dbwPLFUasKJEP6oE2YgLlI7pWLT1QrmAE6v6ZU
	vf+1aN3oZAQOmc5K1KVZs+UP6d3Lbigc=
X-Gm-Gg: AYBFou3t7LGT7d51+iLS+u0Zjcgeds2K3wOmlBkI8bCGctSCKz2gM9GFOZ9sntki+hg
	JTlpf6j7icwd5Oaj6vzdMfqO59plS66/igj7fFLSIuJzzj5IlMeqlgDUtEB19P7c0QfgNGXfyGT
	3Yu5O62OjxtYUO6a93PQNpBDIaPXMMHHgTXBu0zcA9iqq8C8x/zdaW6Uk7XicLMAf+1Gg/qNSmW
	l3UZuCyTrlTZeifud9rVJ7Ah5O8SX9a/hGOKfFWnN7DML3avPzXQJMkP+NGCTvqLWiNHr4YuvAV
	rqYOUyqE0M5Azy+1rCbN/kjxwrxvNtqSxJKBrT44qgRt/4BrIS+0Fu/cGJ9j+8iPld2CmG1fc3v
	gxzu3JpAf8BsP8k3gyytKAH2I1YpSqBJp8gccX/Cn+mzuSOPpyp+gnAEn9jbtF/xTV+TA
X-Received: by 2002:a05:6820:1ca9:b0:6df:10cb:4a5f with SMTP id
 006d021491bc7-716e799cefemr1213893eaf.70.1793959008021; Fri, 06 Nov 2026
 01:56:48 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103090651.35399-1-amaan.cheval@gmail.com> <179382654505.488856.2284543045939069308@kernel.org>
In-Reply-To: <179382654505.488856.2284543045939069308@kernel.org>
From: Amaan Cheval <amaan.cheval@gmail.com>
Date: Fri, 6 Nov 2026 15:26:36 +0530
X-Gm-Features: AclHuK8zljRi20SMMxIXqNiJVtR0YM6bZBYEmm6jP7OjzFd7Z5ca0jIffivj4yM
Message-ID: <CAG+wEg1vzCs2EXdLz6vLez_UoyzCzw0GY6=f+CmmNP+xvuXGpQ@mail.gmail.com>
Subject: Re: [PATCH net v3] gve: leave refcount headroom in the RX page bias
To: netdev-bot+sashiko@kernel.org, hramamurthy@google.com
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	bcf@google.com, jordanrhee@google.com, przemyslaw.kitszel@intel.com, 
	pkaligineedi@google.com, maolson@google.com, csully@google.com, 
	willemb@google.com, yangchun@google.com, npl@google.com, 
	awogbemila@google.com, shailend@google.com, nktgrg@google.com, 
	maxyuan@google.com, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	hawk@kernel.org, sdf@fomichev.me, daniel@iogearbox.net, ast@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 2:39=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 1 =C2=B7 High: 0 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Critical] This patch refills the bias only after
>   gve_dec_pagecnt_bias() reaches 0, and it lowers the per-page bias from=
=E2=80=A6
>
> --
>
> gve: leave refcount headroom in the RX page bias
>
> This patch lowers the gve RX page refcount bias from INT_MAX to USHRT_MAX
> and stores it in a u16. This leaves page_count() room for references the
> stack takes with get_page(), such as splice() and tee(). When the bias
> reaches 0, it is refilled with a fixed batch of GVE_PAGECNT_BIAS.
>
> Link: https://github.com/amaanc/kernel-bias
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/=
ethernet/google/gve/gve_utils.c
> > index caed38cd5f2b3..cb6fba3122d5b 100644
> > --- a/drivers/net/ethernet/google/gve/gve_utils.c
> > +++ b/drivers/net/ethernet/google/gve/gve_utils.c
> > @@ -93,15 +93,9 @@ void gve_dec_pagecnt_bias(struct gve_rx_slot_page_in=
fo *page_info)
> >  {
> >       page_info->pagecnt_bias--;
> >       if (page_info->pagecnt_bias =3D=3D 0) {
> > -             int pagecount =3D page_count(page_info->page);
> > -
> > -             /* If we have run out of bias - set it back up to INT_MAX
> > -              * minus the existing refs.
> > -              */
> > -             page_info->pagecnt_bias =3D INT_MAX - pagecount;
> > -
> > -             /* Set pagecount back up to max. */
> > -             page_ref_add(page_info->page, INT_MAX - pagecount);
> > +             /* Out of bias: take another batch of references. */
> > +             page_info->pagecnt_bias =3D GVE_PAGECNT_BIAS;
> > +             page_ref_add(page_info->page, GVE_PAGECNT_BIAS);
> >       }
> >  }
>
> [Severity: Critical]
>
> Can this free a DQO-QPL RX page that is still registered with the device?
>
> Because the refill happens only at 0, the 1 -> 0 transition hands the
> driver's last reference to the consumer. With INT_MAX a page needed about
> 2^31 handoffs to get there. With GVE_PAGECNT_BIAS it happens every 65534
> handoffs.
>
> On DQO-QPL, gve_xdp_done_dqo() redirects the buffer before it touches the
> bias:
>
>         case XDP_REDIRECT:
>                 err =3D xdp_do_redirect(priv->dev, xdp, xprog);
>                 if (unlikely(err))
>                         goto err;
>                 gve_reuse_buffer(rx, buf_state);
>
> gve_reg_xdp_info() registers QPL rings as MEM_TYPE_PAGE_SHARED. If the
> redirect target is an AF_XDP socket in copy mode, the page is released
> synchronously:
>
> xdp_do_redirect()
>   xsk_rcv()
>     xdp_return_buff()
>       __xdp_return()
>         page_frag_free()
>           put_page_testzero()
>           free_frozen_pages()
>
> Suppose the page is at pagecnt_bias =3D=3D 1 and page_count =3D=3D 1. Tha=
t is the
> normal recyclable state once all earlier consumers have released their
> references. The QPL page then goes back to the buddy allocator while it i=
s
> still DMA mapped, registered in the QPL and owned by the buf_state.
>
> After that, gve_reuse_buffer()->gve_dec_pagecnt_bias() calls
> page_ref_add(page, GVE_PAGECNT_BIAS) on the freed page.
> gve_try_recycle_buf() then sees page_count - bias =3D=3D 0 and posts the =
page
> back to the NIC. Could the device then DMA packet data into memory that
> has already been handed to another user?
>
> The v3 notes say XDP on DQO-QPL "will be blocked explicitly in a separate
> patch". In this tree, gve_xdp(), gve_verify_xdp_configuration() and
> gve_set_xdp() do not check queue_format.
>
> gve_set_netdev_xdp_features() sets xdp_features =3D 0 for DQO-QPL, but
> nothing on the attach path enforces it. xp_assign_dev() also falls back t=
o
> copy mode when NETDEV_XDP_ACT_XSK is missing.
>
> That note is below the --- line, so it will not be in the applied commit.
> The patch is also tagged for stable without naming the prerequisite.
>
> The commit message also says:
>
>   Use USHRT_MAX in a u16, as igb, igc, ixgbe, i40e and hns3 do
>
> Those drivers refill at bias =3D=3D 1, so they always keep a reference. F=
or
> example, igb_can_reuse_rx_page() does:
>
>         if (unlikely(pagecnt_bias =3D=3D 1)) {
>                 page_ref_add(page, USHRT_MAX - 1);
>                 rx_buffer->pagecnt_bias =3D USHRT_MAX;
>         }
>
> Would it be safer to refill at 1 here, as v2 did, so the driver never
> gives up its last reference on a QPL page?

The scenario is real, but it is reachable only because XDP can be
attached on DQO-QPL at all, which the driver does not support:
commit d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ
RDA") dropped the queue_format check that used to refuse it, and the
core only checks that ndo_bpf exists. Harshitha indicated on v2 that the
right fix is to block XDP on DQO-QPL rather than to change the refill
point.

Harshitha, I know you mentioned Google would send that patch:

  https://lore.kernel.org/netdev/CAEAWyHfCM_ZesnChP71AQvxjM4MASwukesgzuWCYE=
Cts7jiNhA@mail.gmail.com/

Since this fix depends on it, I'd like to post v4 as a two-patch
series with the DQO-QPL block as 1/2, so that the fix and its
prerequisite reach stable together. If you already have one in
flight, or would rather send your own, please let me know and
I'll drop 1/2 and rebase on yours instead.

pw-bot: cr

>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261103090651.35399-1-amaan.cheval%40gmail.com
