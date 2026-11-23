Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795473807;
	b=HuaO1Kw7sWPFULe7B6LNvSLPKIfNNQPCyK2iK668dhfC8ADDCYQuWUWT0EeMLWeNwY9M
	 6i8oQBHz+GvcG/EPARZSCr/7geL0ZQsyXNTsv76+UtIVrqoBy2Gi/8r1pIrGc/VMr+5yx
	 ypeSdIIXwiJcU3ohvIcFIvNM+gHzKfdVRqPGDkZ55dGso3CeApkEULurA0s9EjMj5xBfi
	 eKsSnYWc95hTZ9qTyiMS48a8GMIpREnlDc75mRtU0w8KExxQ2EABlKb8H8+bp0BgZDdFo
	 jP1NLNsfzdpUvpdPu21M8mU6mLk21HLpgTPDTWI3SsfppicW5+4rhkQTUpVM2/p7vvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795473807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KoaCT3k2u+3gdASFJNpsPM+Yd03fFCalQiVgHKeiTvs=;
	b=cI3GpFZnjt+wDL+o5LJgzxCqYFe0lYjHETbNwIadOiVTMrAsNMipH9zUk2VwyzPHbYWE
	 BNRaEtInavU1wFthObRxzZpjtM3i/65mpza0I3JixpUQ43oAikAowc4GCDiyE6FgHyU+g
	 jyoD7djA+b2idqontHu9iNIhr0AlvcW41f4M82LuaZ5zN5PKBFpp1qEp+LugYmOyZ6FqM
	 Id+ixlOYK/UesaUWAHsJq+c/YkuMesXbvF0AqcEn7evpjumd/4XfXk7BBBibZkXrC4fjW
	 z/uegbrTVh283r4YAPoPN5ohfbE3RgyBixiy1iicDmC3F6LpaUtZ6iPvquav5FkDF8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pdcEEl5u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720E6606A321
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 720E6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pdcEEl5u
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so49730145e9.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 14:43:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795473806; cv=none;
        d=google.com; s=arc-20260327;
        b=EttinHxPDivsWNw8WdkWarPZgYNFVFeQ/74poGz1YaY6CfxbK8WTvilpilhQywiry1
         D/0I72dba71AildM2edFeIr4k8O7Jnphm/6mR3GqUawnCByHoIAYg6YtItDj5OWp6pr+
         h8dvt8ghxXF/MXOjQ0IQCo31B4k+/itzCxdOAmKOWTKvr43LnA95IopQ6BBeUPg2vc96
         HHWcW+ziiTf01y/fxUjI61kIkTgDhNbf7sgaaHQl1JUh8swNOF4UxtR0svXgNj/g8EmY
         7GTcrhXiir+q4KkAJ9AhSwA8lslqXmBwrZ3VmjGYyf80qwEVRoDTe0so33AnncrG2I3c
         E7Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KoaCT3k2u+3gdASFJNpsPM+Yd03fFCalQiVgHKeiTvs=;
        fh=0jRyznSDXiqYvuQuwE3/3cP3d6qL1thNimMIzxhysEQ=;
        b=EyV/H+N5is1aS8Aqt0tIqG4i9ClVnFBvWfYUOmKeUlqvBSOGXf7vUed6iw7X1sSHKM
         JCYjRWYDBMDFsxYnls1+yNpymmg/zPRym3iKTzVkjxTr77JXq0L9gH/TT7e8LWVcON8N
         3L9rracnIKxYvTnN8cnYuRDfK/16lp6xUAc43pXU5UtfFgiy9vdKJpC6lA0jrcisskSQ
         +YqStvdEpUBnlsOYMbAZwWTb0pStYnDY0OgjjLr9Gdwba5dDhgdCQQ1UnJSsYWTROb5S
         VIrGaMnZhfvK9Dlk3A2dhwDXBpRxT+VX9H1XsGyFTNy6Xy27ipvVhWTsO2ZyX59uIuql
         nk+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795473806; x=1796078606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KoaCT3k2u+3gdASFJNpsPM+Yd03fFCalQiVgHKeiTvs=;
        b=pdcEEl5ufh7xWaqQYl8dtJCQdMuE5KBoSI3trvQ/f0bmwn1JpZAnxsxu1Chz32bpFm
         ArXNkVmzAyemCB38m+zTfJTjHRt9L+1Pp6Tj2yjiT8gwHlu6CKk2RD+wPM2BgoII+NhB
         KQrZclBG9FbjUdxMs4+22BvMav4BrNter5Ei9SX8ziJm8U0U9OuhTkntghHQ+uSnwFHI
         14C0MmlxVXedI3UC62QZ7LDACnprxY6ycBmc/w2h7VGSswLV0986iGMHwwD0HGnbp699
         2IUya4kyQ38iSoOZe/rlgYmAcreYyGRIQgUsEPTJwLKcLL1MKBaVJJLb/K5dJ9XR6Scj
         CSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795473806; x=1796078606;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KoaCT3k2u+3gdASFJNpsPM+Yd03fFCalQiVgHKeiTvs=;
        b=jtHH+J/EFupVd2na2sMdgGRv03Pn6Im+b3qnDisviVgESKGKOTdnFZURTEoQ8JcGQX
         Ny65W9ntUb+dEaixI161IGwrGO9x6q34o/zpVMS8gqrLSczUtVgHSu8kl7KDtiYJevJT
         6Gj+FQA0EzjDK2cecoaH+6G4bg+Md3JrA6zSU77XWNpsuDs4e646GXbez1p0ngueJZ7x
         RiOEOXfVRxYRT6kM4bJ0Svb4nmp1m9n+5I/Dml1/qJ3t3kceAjUCHWXpN8A/INNIavPj
         XraYgxhYY3QrBG9H1h9glx6J4o+489gjnvlpUerAX9KyAoS1i0ELR0Euh+tFPFWkKfU7
         uGaQ==
X-Forwarded-Encrypted: i=1; AL+hErEul0dsS50NrwdQfXQG1Z8M+saPYZico/dqsPPP3ExHrW+VpIi9/ASQb8/2J+xGsm360mQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rx9SY1mxelB1nitqW9UMevuo0sv4nLi8v/zcWGXvqEDuRS06X
	cC9oBjhjOFIgwREcT/0a+i+ZNe4HeKFaCPUsXZEmnSzO6h1e+kVxhHF5k8hPPg9BELeIn3mbdAj
	jCRzutXfWd58EHsQX05isImpqp2X02EI=
X-Gm-Gg: AZFdTZdjDf8chWbl/UaLd2PxtjXpP4QU1Je58HWFj0M9G+Vw6XABeC9rZYemb2qou80
	9Yjo2+5Pabk+8B34u5UmtFjfBqy8cE4un68AmUt04dRxfZ+cjjQIu1rL8Msl2DK8hO6veYbDUN4
	0EImtskW+IM+mk0jpB/+3tJUKxiQWBlGXujEhgaBZMYNUchTpZzV7dNfD90A5SP5VKEXHsDsAFD
	5If17VwSCckSwa0/BXaWi+cjRE1Qkag+JznQOv163fmlDysRmD8XMvXKA7PnlbsqWQf7Iv6L9Gp
	0+b6uLfn7QXYkphitwiQLb770646XM4aS3vj8qyL/P8cAJp5rnA+lQq08LRUCpbNa3oBDE+9fMi
	z/Jnp3BAhnsdT4/fPXoa0T/2AcTajJDnmMnL98ZVu6DyMaumZBZ907qyef/JM37iJNZzfq4XiKK
	KPaLXT6qINh/0NKsvW3Y4/ie2LBY0XL4Hd4eXTVqPLNqs9HA9rpF/5TQl/C734nB1pJxl6FOCDt
	xI=
X-Received: by 2002:a05:600c:20c:b0:4a2:f58:9a82 with SMTP id
 5b1f17b1804b1-4bb861590abmr246078985e9.13.1795473805423; Mon, 23 Nov 2026
 14:43:25 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121012402.84848-1-tianyi@cloudflare.com> <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com>
 <CAG4wq-f18SHytDb39SdJYzRPk-dzECjH_HCSiMGAQ721Zmfomg@mail.gmail.com>
 <CAKgT0UeWWherBt1MDcPF7R7jxt6E_3peo8VuxrgY3JdseM-0rg@mail.gmail.com> <CAG4wq-dizUz-6GB8Aj1wRTQBOzbHbT7pX9gom+AhR=5OWSyjzw@mail.gmail.com>
In-Reply-To: <CAG4wq-dizUz-6GB8Aj1wRTQBOzbHbT7pX9gom+AhR=5OWSyjzw@mail.gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 23 Nov 2026 14:42:48 -0800
X-Gm-Features: Aa3M54qi82M1DAMMWxrM8C2P0C7XHARA7mgqCdyXPQsvQZsIrQdsx5S-vHEw8KA
Message-ID: <CAKgT0UffmbELMsGi8HRfu62MfC9VRYZ+TMNKFjZMWJyrV4t3jw@mail.gmail.com>
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Paul Greenwalt <paul.greenwalt@intel.com>, Alice Michael <alice.michael@intel.com>, 
	Eric Joyner <eric.joyner@intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org, kernel-team@cloudflare.com, 
	tianyi.gao@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 2:01=E2=80=AFPM Tianyi Gao <tianyi@cloudflare.com> =
wrote:
>
> On Mon, 2026-11-23, Alexander H Duyck wrote:
> > For example, one recent one I saw was an issue on the Tx side where
> > an outgoing XDP program was modifying the frame and actually not
> > updating the pseudoheader checksum. As a result it was breaking Tx
> > checksum offloads for NICs that were using the HW_CSUM that used
> > that checksum header. We could have fixed it by forcing all the
> > drivers to recalculate the pseudo-header checksum, but instead we
> > pushed back on the program that was making that change.
>
> Thank you for the explanation, Alex.
>
> On Tx the checksum is in the frame, so the program can fix it. On Rx
> the program can't touch skb->csum at all, so there is nothing to push
> back on.
>
> > The point is you are fixing things for your use case, but anybody
> > who is using the CHECKSUM_COMPLETE to compute the checksum on the
> > frames and using XDP without changing the frames will see this as a
> > significant performance regression.
>
> Without GCS, TCP and UDP still get CHECKSUM_UNNECESSARY, same as
> E810. GCS only came in v6.15, so this just puts E830 with XDP back
> to where it was.
>
> The cases I can think of that are truly impacted are IPv6 with
> extension headers, and UDP tunnels that the NIC does not parse and
> that have a zero outer checksum. These fall back to software
> checksum.
>
> And programs that do change the frame are worse off today. Every
> packet gets summed again in software, plus the "hw csum failure".
>
> I don't see a fix that meets all of these:
>
> 1. It is small enough and can be backported to stable.
> 2. It fixes the problem fully. We could drop CHECKSUM_COMPLETE only
>    when the program moved data or data_end, but some in-place
>    writes, e.g. NAT or the IPv6 hop limit, would still trigger
>    "hw csum failure". IMO that brings more problems.
> 3. It keeps CHECKSUM_COMPLETE for programs that do not change the
>    frame. But that looks like a bigger change, which doesn't fit
>    net.
>
> If you have one, I am happy to take it. Otherwise, as I understand
> it, the choice is between:
>
> 1. A performance regression for some programs, but no "hw csum
>    failure".
> 2. No regression for those programs, but "hw csum failure" stays
>    for programs that change the frame.
>
> I would like to know how the community normally decides between
> these.

The thing is your fix isn't really complete. As I said it is primarily
just addressing your use case and sweeping follow-on issues under the
rug. In the mlx5e case they were disabling the feature via the private
control flag if it was enabled. In the case of your change you are
just disabling it without exposing that it is disabled.

From what I can tell you are just bypassing the checksum complete
logic, but you don't exit out of the function as a result. What
effects is that having on frames that would have been normally
checksum complete? Specifically, is it being treated as though the
frame is unrecognized, or is it falling through into the
CHECKSUM_UNNECESSARY path with all the indications that a tunnel was
still there even though you stripped the header?

The issue is that the driver is making a number of assumptions about
what is there based on what the hardware parsed for headers and such.
With the headers being stripped and/or replaced those aren't correct
anymore. That is why we should probably be looking at dropping more of
the existing logic or forcing a rescan of the packet once the headers
are replaced to update the descriptor data for the skb configuration.
