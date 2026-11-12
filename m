Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472429;
	b=j7LwGp4iHKGt1q8na/rR5ucwCMjRFcvUEz5B1xdZn+77v26r2OMpDpL7sXl57bYVD9iS
	 /OpVcT1U+D+jW9XlwkXAXEVIBEk5RLnSa7QnZox8rGM6ZyjPeNoQmsx5DOgnupRDcr2GF
	 Ei6ipPZ9uUNQYoqqp39vAWbKJ3NbFUVt0PuZlC+qzv8NK59TUtwz6I1oduYmgGN7NKAST
	 mOvWT+ck1QIblMPQpT2h2P3qRnThK1Xbgs7gKs9zj+ENcUe0ahxXujRap7WyPWHBfun4n
	 XfPcJJemS2SYbQ/d0jFh3fF2SrYSniXkaFImuIt8w2oFssY3/Fffgs1SahYZ3KH/1uQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uOYvxf+M0Ap4noHF2nmW81cSBmYvF6P+PnsYCByXef8=;
	b=EOqJ1NqgBwOtkayerCZ8Rfz0eZKpm490ykK2LZZTxN9dCECX47YCrnyXAYhKckjXrp7J
	 UEThMAw3qGU/WB3Fi6B7QrYBIHGWiOwBMKwEveDZ5XagfWdEx4jfPebM/h57F+mFIzrua
	 YYaZ9CmzTRgV087wJ4av8luB+JUAeTyqP5t3xb0fIPo2IkjwVL7Pa/WzJwf7dqBxmeg0F
	 LdKYPyWxN2ziblroZBHtouEl5owsbP9bo2qL/XW68xA9L4M7Fn/NxNYFvWyeVy/EKra7M
	 R6iESVd2n6HQUMXxT9k5WR+rAuhgtfegoWzdSsnGOkamuoBUnR5lj8NkQt0z0WwT7Pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oi8b8PLn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D7A60734AA
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 08:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79D7A60734AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oi8b8PLn
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-705cb6ceebaso2766373eaf.3
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 00:33:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794472428; cv=none;
        d=google.com; s=arc-20260327;
        b=kAPGVHb3yoz4VBYTjDQmEV9DQAyzyzuylN8n3CnLY+HbClId53dzGp/rGyvnBYjKR1
         I4JMaUuHR3zXuaYB1tS/Gb2F1YAG7YON2VXRpS9cfkchmaKDw0FwZ5oyx6/TNt+RYRNY
         bfneI6sDdTORUtCYTKdI/PtpCCeiw7dRVTrO9qiG9V3hmKbyxFCk4TgvHxTHxMPFVe80
         15HKmzC9+JWL047E68EVwvi0LlB5IDA2UkyZ5Oh/vX++Mcql566Jv71zf8LczNtT+Bxj
         inmblwCUr/3g9zoJ4l1yg/S8RnkSYgsCuJMLq5KJhvObZIIfwDRbAutMMxVCpwkHGx92
         RrdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uOYvxf+M0Ap4noHF2nmW81cSBmYvF6P+PnsYCByXef8=;
        fh=YoPGF83F2IxbhFb8lNfFhiraH1K2Q++tw/4dAU/VTqA=;
        b=rJZ6r8G4ek+9/xP0hej5mpJRN+DM1Le+Z+qp4lrVTeKpZmtdvAlqkzxnBpRaGU6I+m
         2wEINq30BkLD0fIYoLYwE1rJpEQsF2M5eM5hHC3t2Huy60xkFa1tHLRgahTYRzLEPrEQ
         FJR6lpuLi0GAETJa0P2b1ERPia77oXR/hACBsvpzsGjGasF1yRnbB20xfc2NNgKuFk9Y
         gANNULAQfLsBA8TgXCKsfZBYcPuV6AWsW0vTsDndWo0ELimrWklNf4+uKROFapL1MZ7O
         M7WfbwWlqX9Ro2oIisLjtYXMZov7PmzC1yxZf9ohYvaYbDykC3FHeCH2NeYRyh5dMHOY
         lwzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794472428; x=1795077228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uOYvxf+M0Ap4noHF2nmW81cSBmYvF6P+PnsYCByXef8=;
        b=Oi8b8PLnrmaQ64bFFPurb/0NRJSzOTgERT3w52aHLchDiGE24NvNc053MGzsM+qWdL
         ab6xBre0Y27SWz0NmrywKH21t/466fyW7knd2Doyzxy9qhiNmu8hkmno4/lsE2WZxlzH
         22p9C4gSoYQpEuV2L4h42JiLHb7tpw27dm67IQiaIuePmeBEJg6W/XbL5OHHBuPAlJCI
         tu8qeYoLlHJf4HiWDS3uu5OIG+pmyFXb+l1gKtpZgQdPdyaeJLe6UZf8HBUW6dA3vAfS
         gdzKhEwM4a7ocp3W88w62eMBgYlyvTCne/5bB0mwVJwyZ0Rx5kM1dCLfo8OxSdQh7aZp
         ba2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794472428; x=1795077228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uOYvxf+M0Ap4noHF2nmW81cSBmYvF6P+PnsYCByXef8=;
        b=hTNd955Dt+VS5I2YM6NSbKFdKoH5gx4nDHfrcKeFvduN80oieZN1qORtQlZBHSeyF+
         NQQIYOQWrT1sOzItTFB24NC6GVhbL62tqQWx5q1PJ+vcFjXxN0qmefnyuK5XotgSZk91
         h6eHTm+O7Op1LFhBzxaiS/kQp1Gv4qaah95uAK2T4RAmZIBfciSu4rpjLqNqg+tk33YE
         QUqSkX40Gv3xI5lhGTBi9yApdTGFwhh485f+izw0Z2dWFTGZNomXqXlqqacx0oFCBZH3
         d3yKz0iq48GqoGCT7ytfi7VqCREPMQu5xyulBBSKOgPwIndDHwMBtAlxlT9nTFyIv0kV
         Vukg==
X-Forwarded-Encrypted: i=1; AL+hErELiwQnyc2p7kPxN6O1giujgjuUlP6F59rXfKHHHALzw8rAbeQkHO52oZWju5M55zlxsxU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9e1ct06lZ4olRupZYai87vnCv2Nf5yGwdR3nQJIi2A/Y5ZxxWA
	vbkvbKjk1GzBSINk+S+gLM36gajhT0polM45k+QpHTUfn5tZRAN2YeUR7G+BwzOBc7EHUyD8t4g
	YDYFDvj3ItYrzJy5Voie2iGGauQ7Vw98=
X-Gm-Gg: AYBFou1DJzt/bahMnY1dDeY7DGnXG+eHd7dmH6VizcFL8RKbu8bxGGaNm3UKL48/Xc/
	cQ8X7JIAJvJMrhmP8cCbglwpHD0gMxoLO4f+vpxcLBNsCXuxZxTsP+00bCqY9IyAKKrZOanookU
	IEUnZobETo+byGoLIL43+GMcJ5tVIDcD82eavZ3whvQMX9udtszTAKTp3PiVRuQBEl2wTnvBUcn
	x/zG1lizfsLCBM/gEX6/xniba+xhPkQqVaGM3YqbnSMVJrJFoNcS8SXYk/oO/QmcuGFcUZRKfl1
	X9uCzj5QNKtyWBlppY0ZEUgTZ+3/Eocf7HYhv3Hpt6uFf6aBaTlSrMMijp2axVYnhzlYKkYsaAG
	nYknhjZDtpim0raoC0wFG6yceK86UxK/RQY0mz/fmxXh5giUk51xXxVZClPd60Y4lBF+yQMPF5l
	XxvQ8oGTKgDgG3RA==
X-Received: by 2002:a05:6820:8912:b0:70e:78ba:1193 with SMTP id
 006d021491bc7-71917852a66mr2642193eaf.27.1794472428165; Thu, 12 Nov 2026
 00:33:48 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109100437.331423-1-amaan.cheval@gmail.com>
 <20261109100437.331423-2-amaan.cheval@gmail.com> <CALuQH+Uee+=2NyhCXVmmESwXxSqDYKY3Foj70KM2qY6g5UsOXw@mail.gmail.com>
In-Reply-To: <CALuQH+Uee+=2NyhCXVmmESwXxSqDYKY3Foj70KM2qY6g5UsOXw@mail.gmail.com>
From: Amaan Cheval <amaan.cheval@gmail.com>
Date: Thu, 12 Nov 2026 14:03:36 +0530
X-Gm-Features: AclHuK8jw0nrbYX6MTsSZqQlwj6_5UHh4mClUVm7LQtL7_VDZNXktjTz3rcpg6s
Message-ID: <CAG+wEg1fWbnaWmEBeCA0RcwYvMDrAcacX4qCO++bsNK98FS=Vw@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] gve: refuse XDP on queue formats without XDP support
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	bcf@google.com, jordanrhee@google.com, przemyslaw.kitszel@intel.com, 
	maciej.fijalkowski@intel.com, pkaligineedi@google.com, maolson@google.com, 
	csully@google.com, willemb@google.com, yangchun@google.com, npl@google.com, 
	awogbemila@google.com, shailend@google.com, nktgrg@google.com, 
	maxyuan@google.com, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	hawk@kernel.org, sdf@fomichev.me, daniel@iogearbox.net, ast@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 1:16=E2=80=AFAM Joshua Washington <joshwash@google.=
com> wrote:
>
> On Mon, Nov 9, 2026 at 2:05=E2=80=AFAM Amaan Cheval <amaan.cheval@gmail.c=
om> wrote:
> >
> > Commit d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ
> > RDA") enabled XDP on DQO-RDA by dropping the queue_format check from
> > verify_xdp_configuration(), which until then refused every format but
> > GQI-QPL. Nothing replaced it: gve_set_netdev_xdp_features() advertises
> > no XDP features for DQO-QPL and gve_xdp_xmit() rejects it, but the core
> > only checks that ndo_bpf exists, so a native XDP program, and an AF_XDP
> > socket on top of it, can still be attached on a queue format the driver
> > does not support.
> >
> > The DQO-QPL RX path was never written for that. Its page accounting
> > assumes the driver keeps a reference of its own across every handoff:
> > gve_xdp_done_dqo() passes the buffer to xdp_do_redirect() and then
> > recycles it with gve_reuse_buffer(), so a redirect target that releases
> > the buffer synchronously, such as an AF_XDP socket in copy mode, can
> > drop the page's last reference when pagecnt_bias runs out. The page is
> > then freed while it is still DMA-mapped and registered in the QPL, and
> > the driver posts it back to the device.
> >
> > Refuse XDP setup in gve_verify_xdp_configuration() whenever the driver
> > advertises no XDP features for the current queue format, which today
> > means DQO-QPL. A zero-copy XSK pool bind is already refused by the core
> > for the same reason, and a copy-mode bind never reaches the driver and
> > is harmless without a program.
> >
> > Fixes: d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ R=
DA")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
> Reviewed-by: Joshua Washington <joshwash@google.com>

Thank you for the review and guidance!


>
> > ---
> > v5:
> >  - Check dev->xdp_features instead of queue_format, and reword the
> >    subject and message around that (Joshua).
> > v4: https://lore.kernel.org/netdev/20261106114551.212675-2-amaan.cheval=
@gmail.com/
> >
> >  drivers/net/ethernet/google/gve/gve_main.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 2437cd8ba633..fe560f5c5408 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -1723,6 +1723,12 @@ static int gve_verify_xdp_configuration(struct n=
et_device *dev,
> >         struct gve_priv *priv =3D netdev_priv(dev);
> >         u16 max_xdp_mtu;
> >
> > +       if (!(dev->xdp_features & NETDEV_XDP_ACT_BASIC)) {
> > +               NL_SET_ERR_MSG_MOD(extack,
> > +                                  "XDP is not supported on this queue =
format.");
> > +               return -EOPNOTSUPP;
> > +       }
> > +
> >         if (dev->features & NETIF_F_GRO_HW) {
> >                 NL_SET_ERR_MSG_MOD(extack,
> >                                    "XDP is not supported when HW-GRO is=
 on.");
> > --
> > 2.47.3
> >
>
> Thanks!
