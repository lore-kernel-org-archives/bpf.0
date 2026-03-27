Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1B236C0B7
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 03:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774583026; cv=pass; b=LODfzlwJ6leXHp/te6BE4+hGwGAk7KewU/m6oCiT3gsffEx7Pam5c5ezYeN4lo6NCj8tSoU4G/xZtVzYDICq298X2TV7xdF+BEgzJWqGB2CMhEuXNCBvNImdAgMvEo04ULEJFDjweXchuHxFBJ18dn7HuhDomICZ8x3SwAdw1N0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774583026; c=relaxed/simple;
	bh=XZ+5Uk/DsKDjljxFTH2gNYDX6n86w4DiW+i7ZwAY4FQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoQk2GzLoA5UrlFVjank9G8Kd4SFFxtaGYMrV23KQ2qA+YbXyOOpnOJS+tcOnQSzctthdAk9Yq+JqWtIrcF9/AqmOBEkVwuCJ7y4ARhzEAalYvZ0K43wnTh9L0kJmaB2p2n+mBGq4CTOuBLUaAHK4g3YB9WKsoFnBCM6Q1NjS6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7Ws/JCZ; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7Ws/JCZ"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50904a8f421so16959001cf.2
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 20:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774583024; cv=none;
        d=google.com; s=arc-20240605;
        b=IXTQyIuOKND2T8oWg4FFh5WsVbEzZIlYxn1mcQSmkarvJTC211AItAhfH8ef4dcfPd
         YaD+vK0Azj3cuD0A2Oqc6dpQFgbx1zLgDRQfvCBlbymHpzNySRBmgwNrlHVT9Dq46CQK
         6GDmf8B1jQVJ110MMFIeHiNerevbBuQWr6XUX470TBEF9PLDNXAtNx8M7/R8HvYd5SYg
         dIXeClWkegOMUplNSRg44N02OW55NkpDL3huHTJoh/HB986ntI+iFPmDJCmENwLDIpaZ
         RfZkfXImyp1jLFfjCq6stQux7gNby7Bpysbghk48/H1TOORleaKzEBElx05S+t6pRSYv
         hANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XZ+5Uk/DsKDjljxFTH2gNYDX6n86w4DiW+i7ZwAY4FQ=;
        fh=Krrx5hd4vvS0U3qz+gyJIJABgRh2yHuhR3imEC2/EbE=;
        b=ODwQd1iu49eZuuNt8Nxw7blobHURXm4NRQJn+cxnoOpbnp5h9i3UEpcR/r4/WK5oLU
         8K7YaCKj99ypv1qvZ54BTh5z3WHZdxMQF7e3+1hF/BJzjvlcQGA5bGtIsYJ7IHNdxrU1
         D/1rP6vPuLYCKcw4mpZfnwLpcm5ZGGi+OXUxNQa9gdzxyWnwz5g8DWsf+/tzX26Mzdg4
         p6KEapkgZu+f8smM7HtsbHLnbVIhJR2nm7PCE53ehsrLuA95KbaNoaY1hS23bRnkD+i4
         Ap8tnXk1kvYSvKICX7eCbmap9YHmfmC8VraRh6u9zwsd10YWp02QWnAE48r9Fr801uTE
         v4bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774583024; x=1775187824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ+5Uk/DsKDjljxFTH2gNYDX6n86w4DiW+i7ZwAY4FQ=;
        b=u7Ws/JCZNimk/pAmatYO3igeRU+sC4Nb/sBDK0vRl6AooNd7ymqtFy5RvKSeP4jHSv
         26mAA0AqrHmzOWvuvi6GU/G/xaTGgRvp2N+6DtttQXSw/JTOG7f6MuK93Yp0bi8osAon
         JyC2HPayj1uNLRxfA07Pbq+xVlrF1tejQ327w6lS55WWdGkJU5jozm7cdawikJ9mtPvn
         F6iZ/X7ob56en+EHu+j9iNmLXIdFCOuJ/T1K4maFljQII5ZYUC7WetRr1LPm8x16bxpE
         Rhb8Fee71nJxyTg+C/O78t/mx6RpPR4F4tpjgtRzIbJH3mox7N+Dj2RNIe9n0OVSwF0Z
         1XPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774583024; x=1775187824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XZ+5Uk/DsKDjljxFTH2gNYDX6n86w4DiW+i7ZwAY4FQ=;
        b=EmL/m82VZ9/YfIYkpT5vZxaZ7tKFIdm4CSwMT8FXvAqij9Uq6Ld4VzHjr1TADkiP2Q
         n+OJGOfAetoCxfitUXeCBfekqJq3EwoU395/DolmYLwW9l135DfeH8pQo/VAUuzrxkqQ
         5BlK+w3v8pfY5GMaSUzNkpPzDcWuSGgoyTYsjmHmdPTFNHKYzFMIXHr3EEHy1Oot8t9Q
         BauT3VW5M6RULT74WD7oYdDsM9xYlzy3vrbhbeJLUNpM6sPp/wgiTmOgK3VNPPjGULps
         63UEDKgzIJSMRPokZiYCRg58N9G5XPSLkB5M7NnMn5X+pEpiVzBarm28O00UJHt/H0QT
         8AFA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ4Se8RL4d8zYqJ9P3fwvRWcebb21D4THP0HeD1lmKjP0b+uuomOi499ksR8JMiH4XaUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyscC0F0wQsIkTRPvHBH5/+NdWDO1mDfSLOkVVvcWCTivsjJS9D
	xd9yHQAKCIppuRC6xvk9909BDDsLADCzOyfQ5Rd9Zm74UFBUkFxR0p23nWR77IElNOY1Q1GtN+E
	qwtSYcaCeGyGp6dBDvb1lo7NShmdbh/GRqB8ukpH0
X-Gm-Gg: ATEYQzx+CfB/q3Mu8PwcfQrpv6sHviGHIIhRVQ5mLV184a6/JBlDUnLXVHDo54G0vMM
	apPNU7ztNnPwyGn+SugfR/sr7HArcS6tEJPaY+S6bgJDs46JaxoP/Y0jF2sejQHpbGx+FtrkyUd
	eEALCYKwYUerjkA2VRSZBt4bC2h9e6SYkApK875oq6ziWMYy5zuFTLJmAkD7lTswjVu2F+skLV3
	IqIakT6ipVRbNNDZu6C/MZifZ5AhADTJ8P7Dkm6f1PtEgGmDCTzI9sySNQhlVgEjuUWsLEsTm/i
	bkDsxw==
X-Received: by 2002:a05:622a:5a0a:b0:50b:4c64:4730 with SMTP id
 d75a77b69052e-50ba37d3a17mr14739431cf.15.1774583024002; Thu, 26 Mar 2026
 20:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dd3984b3bce9df3591927f927668cb31cc7ecf34.1774460059.git.mst@redhat.com>
 <CACGkMEuL613R8GRUX2hjRuJcvP0LNC_6_D1Y1yEjtTqehy6zJA@mail.gmail.com>
In-Reply-To: <CACGkMEuL613R8GRUX2hjRuJcvP0LNC_6_D1Y1yEjtTqehy6zJA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Mar 2026 20:43:33 -0700
X-Gm-Features: AQROBzBTAZQiZv5gITUpNks5cRGZmqvxfVTU9Y6vZlwD1VKoOLXGxZ_EY6bfseI
Message-ID: <CANn89iKJUMP+7udEPs_j2Z5pPJnc8-Gkn==5OLr63OJQs1a5Mg@mail.gmail.com>
Subject: Re: [PATCH v2 net] ptr_ring: disable KCSAN warnings
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Simon Schippers <simon.schippers@tu-dortmund.de>, willemdebruijn.kernel@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 8:17=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Mar 26, 2026 at 1:36=E2=80=AFAM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!
