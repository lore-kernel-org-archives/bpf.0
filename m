Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795624415;
	b=iIEze61yhRLAeNugG1AHBOXZzaU2Knz7fD/LBM35njBivyKgyRhlaRbrCY/maw0qJW0t
	 qmJaEcRUtpwCgJDOFrrpS9rzkb5wArmMXG1kf34+L+mkEQzgXftZz1rKOi2g29fgwYyXV
	 6+Ck5eKQpPBHk7WX2bnXpyPijbnbgDX7LUiUgBuQo4zyb0a2ek6upto1lZosivNzaF0Ok
	 Eutp3kdFWPDh97f/O9SsjFWr0zxiGTv60wVG2P8WGupEchAlIHzZHogxNq86g9N8Mp4TD
	 VkH0nck5PZfG6MChI8FBVCt7aXBCPB1k13ecu4LxA7iwcJluYUHfm92KvSOiDT8uvww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=G8pGBF4gig+42xucKEgB4reT/S4vYsrjWIoua9qgDow=;
	b=XjVcUoswhJ4SHmjdS3p/J8hNAl4T0o2YGdbk1RaDexV29Z3icPTBgibSXVdpRya3cDRP
	 p2pzjzQNs1Aa+OWFpPBgsANSi7FZc+IafGYKACShmv3Eb++Cs1dgrcf7RWcqYdXlgv/xb
	 fv2EETUSV/EagpoJIwCR7b9MWEWZNM6TylvRr/ytQfSOaoPLJ91yRobNKb5V/LEXxIlnq
	 pglfD2nq7Bc27wTSI23iQrcBE1QIWyd+WDIdaMJl3Sra68fVP6XHvlg9N4IghTk3Fdvkn
	 mRyeOiCkdfMGVpAy5vs7p7kDhUreAwbLo0UGhf6u0Fh/B/JnkGF5XkoaXddwRrYtU/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rbqg8zfj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB4606A685
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 16:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DADB4606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rbqg8zfj
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so39072695e9.0
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 08:33:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795624413; cv=none;
        d=google.com; s=arc-20260327;
        b=TokxSYBCsZmJRs5ldx/wKJko+TM7CC/TbJdkamYpmMAm8N/0bNk0QqXw4XtBehXhPN
         rGJwXeNOqz+TkWOyrXNHd7a2zeknBiNL8DYnsa4TVTVu7Hsi7fOm23pUQmBKbRKSC3k9
         O2Re0HESdp44/ATe8N/TbjV0YZDjR+HSE5f9+wv4l1HKvEg1noZp3AIfXDKjLEhty1Ll
         Il72t4FtBkHFmlhegekd487HP7W6AiYPr0CHRLkRDp0fxDb051YkngLiCdX5u2Is51Ow
         S4elkqud2C80lJDuRMfm63+k7HZLas/IZ6Qe71fnNKl76xF40tb1C2TjJezGMfMbCLCK
         HxsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G8pGBF4gig+42xucKEgB4reT/S4vYsrjWIoua9qgDow=;
        fh=xt2Zh4rt2I0I1gZgAPMIKbJjVNzQmnPVHWVh9nD7tM8=;
        b=jIaU7tpKUxkHBHuEuqIlYPWq5id9oCzAXJzOD4i+/hPgVy3Vrqjx5yUD8/ywkbZi1U
         6dy59ixVvfHusKMiTKFNWxUOpdKiljjfybDHT8W9GaVqxy773FIC6iemOd6oYG3uVESr
         t+gJMgud31k5pvzrzvTno3spBv3w3GR+JcNtE5Dr0jX7zfkxu02EaFvLTVXRVhO1vY4X
         +MxGWVJrN5toaVGN/ReNgoTIFsussU6PKB7zlkAO4NSrqdF8i1EtiUVXC8+KS5LN6qOx
         XHd8JUmMY6lEIR8bfnO558FbA8+kgWbjMesYCI+79GCPdZQIADGVyHDDkPunMKmt1aOO
         MnUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795624413; x=1796229213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G8pGBF4gig+42xucKEgB4reT/S4vYsrjWIoua9qgDow=;
        b=Rbqg8zfjfvFC59XPp+SButv8F2T9dDxx2RyvwtNx1mAGakIwMBPuepMlgxF4f+vX+W
         sbwmxXnjHYQsObZystSYwo38AQrBj1Kh3s0bGUFEi9zlxfpKlZkDxoYWSEcDr6/UKU0o
         AHlljwa5KJwq4V3vjl50S3JakI8gNqAjHb4LqNXDXR8++IX7C2z3bAdu90NIMcYqN7O7
         pgxS52kiGgsCoOdHxPofoEgtXl4NLBGYvHS//vqZoeoH4EfUlZMSUTN4OqapTIY2EHfb
         aQfxj/U/8rOAtYu24vxfehm4PHBs736cLOlSQCS60eSnJuisfol8zLOMvsKl0upqhy/N
         0fPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624413; x=1796229213;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G8pGBF4gig+42xucKEgB4reT/S4vYsrjWIoua9qgDow=;
        b=UFTcis5EVh9jNF5mCvA5KoSlVcj3l6bUdEThM0dtYKpLibQkiw2MFxM8x0NWJe7Q/7
         PeOtPMtDtezc+uuDQq0eoVBID2yK1pRZrKPtSWdIesDZvBiFaCdKXU5PmSBzN/Deg6HZ
         TfhKgekElDxxYLE94mJJ8JGSGdZyp4hQl8N+QdPTVm5x3/NEL/qTUK9aBJv7Mpqvc87H
         HnIL09It2tAL2Zb/YoSv5ll4rre36VvVc/ACvUtsM/lBhSiY3JDd/pqc0ira0CKYUuS+
         EQ5tntLV3qmdK+f92BOPmReMVYkFJX74EQt+kDw0ZtnDotQmZB+57ieUmUc4bAwR4qqX
         v9LA==
X-Forwarded-Encrypted: i=1; AL+hErHKIxY52PC00EycQ+d3r4dRpUvedPIV+vOTzaiJLR4A+ayhzkx1EAyunP7DJanjA+lGnkw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Wjsdr5WcVbVbVhYY5SdUTvrL/wJDYWLOrZXaGxm2Er8Hz/ILf
	t414tF+Lb4jar6WT0UWHQh0G4Mm8lh4vJqjOWhb/kuIFfe90Ly20C/XTXbxEXrgRBUZAUo2bE4O
	EK46m1p/2DXZ+HFpfCjl9R3fA5eYHjNE=
X-Gm-Gg: AZFdTZdHCGeqcmjlR+wioshh5yFB96/Zy4zM2avAIsuDx+poEdNQoRvsFkC3S1WQLor
	j9GGmfVkduJBpQqhCv0Kdt1fbJH5c2ivwcZ3jDyHH6NLAjbywSsAdw2AOb95PuYQyEMKUlhW3/h
	EQDn0+uDC+r0w7oSXY1GBHWkmNRscRiB5c+wB5mEc8H7YQK44NfgyItGjTGRjiUIAnVpMlbJDaL
	ruWCc+Bti5CmnLbFCPRgjK0lFF/+pqZyGx4wvFqxC7hni20Pc7ZM113a4vAGXx8mx12Va72BFH4
	J4GN2wSnxE8L+R1iTr0APBMAxtesHXevMc287KbF5kIXTGwRG79WIQcGgULG/fHMLAuAHJ3ujGJ
	LgidUJDR4OCJ+C2ws/Yctz31oqfzaO3h8bBpqcZWQPWdrf7ymoZwyS4fqKFkLIj2De/FatTaj7b
	PTdZGhSjlRv/XmOLJNZLiwQpQikaUdjdTuvdkR09gi/MRzXpnAQ7/J54GdPbMjLkXczS5xgRDjQ
	QE=
X-Received: by 2002:a05:600c:3113:b0:4bb:5f45:c97f with SMTP id
 5b1f17b1804b1-4bb88816b2bmr398390865e9.27.1795624413003; Wed, 25 Nov 2026
 08:33:33 -0800 (PST)
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
 <CAKgT0UeWWherBt1MDcPF7R7jxt6E_3peo8VuxrgY3JdseM-0rg@mail.gmail.com>
 <CAG4wq-dizUz-6GB8Aj1wRTQBOzbHbT7pX9gom+AhR=5OWSyjzw@mail.gmail.com>
 <CAKgT0UffmbELMsGi8HRfu62MfC9VRYZ+TMNKFjZMWJyrV4t3jw@mail.gmail.com>
 <CAG4wq-cG1bseTFczZTjashN75J1Jsrv=u1ccuRsY-N1kZ=SXXg@mail.gmail.com>
 <CAKgT0UeNyyXKARjKR4nVVxNe3UB16WuXqxSz0cf4ZvCdb9A4_Q@mail.gmail.com> <20261125090732.69233-1-tianyi@cloudflare.com>
In-Reply-To: <20261125090732.69233-1-tianyi@cloudflare.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 25 Nov 2026 08:32:56 -0800
X-Gm-Features: Aa3M54pUd6pmzCO8UswpNG_p1Cop8RfCo2MjSO4FX8Mgp7n0ftvtp2HqSVfaiy8
Message-ID: <CAKgT0UcFnSvTO6ATw76qVHYxRusTYXpRVi0_GR5QnMhhoXwXsA@mail.gmail.com>
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
	tianyi.gao@linux.dev, Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 1:08=E2=80=AFAM Tianyi Gao <tianyi@cloudflare.com> =
wrote:
>
> On Mon, 2026-11-23 at 16:17 -0800, Alexander Duyck wrote:
> > Any reason why you couldn't just strip the GCS enable flags from the
> > rings when you add the XDP program in ndo_bpf instead of having to add
> > a check for every packet if the XDP program is present? That would be
> > closer to what they did for the Mellanox NIC and wouldn't be adding
> > code to the hot path. Then it is just a matter of also adding an info
> > message that you are disabling this in the log so if somebody does
> > have to figure out a regression it should be more obvious.
>
> Thank you for your valuable comments.
>
> Clearing the flag in ndo_bpf alone is not enough, because
> ice_vsi_alloc_rings() sets it again on a VSI rebuild, for example after
> "ethtool -L" or a PF reset, while the program stays attached.
>
> In v2 I will set ICE_RX_FLAGS_RING_GCS in ice_vsi_cfg_rxq(), which runs
> every time a ring comes up, similar to what mlx5 does when it opens the
> RQ.
>
> v2 also logs an info message when a program is attached on a port
> with GCS. I tested it on E830 with attach, detach and "ethtool -L",
> and I will send it soon.
>
> > Thinking in terms of what the final fix for this might look like,
> > currently the drivers are already starting to carry stuff for frags to
> > determine if they support jumbo frames via frags or not. I suspect we
> > will likely need to do something similar when the time comes
> > indicating if the program can avoid corrupting a checksum or not when
> > it is stripping headers.
> >
> > I am not super thrilled with the idea of this becoming standardized.
> > In theory this would be much better if there was some way to pass the
> > data out that the frame was mangled and what the checksum adjustment
> > is to the total frame.
>
> 100% agree. We should be able to tell whether a frame was modified,
> keep CHECKSUM_COMPLETE for the frames that were not, and give XDP
> programs kfuncs to read and set the checksum status.
>
> Unfortunately, today there is a big gap before we start that:
>
> - [1] lets a program read the checksum status, including the
>   CHECKSUM_COMPLETE value.
> - [2] lets a program set CHECKSUM_NONE or CHECKSUM_UNNECESSARY with
>   csum_level on the skb.
> - Nothing lets a program pass a corrected CHECKSUM_COMPLETE value to
>   the skb. [3] lists this as future work.

Realistically speaking there is an easy solution to this in the
program itself. It would be to look at using something like the
REDIRECT action instead of just stripping the tunnels and passing it
back to the original interface. It would then take the frame and stop
processing the remaining descriptor data. As it stands that would be
the more correct solution as you could then just redirect it to the
tunnel interface I assume you have stacked on top of it and have it
receive the frame instead of having received it at the interface that
just head the header stripped.

It would also match up better with how the stack would actually expect
this to work if you didn't have the XDP program in place.
