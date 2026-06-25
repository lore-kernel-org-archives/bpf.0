Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CE6331A44
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394861; cv=pass; b=ec2rIjEGbDPWygWOf9Zxta5kZtEPu5JJBJY41uMXZIF8oqEHFH0RsQmt70oFFWPP6RtUd+HTc+h0jOjArn/4cmRF1fxWX2U/V5jGxg/AkYKw1uvr6YG6RvWcjSlYLQ9leFQBTSRJRtcWdNq4sTVX7ax2NVL7L006ss4+3Wk5TNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394861; c=relaxed/simple;
	bh=xtW7rMNS6favmC/NX2OBC+xBddY+0MfAd4t+qaOXIHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZ6UnhC8bvU2oLWQGPRNabx1o0qi7attdv8OIhiOhiLvvNYGfnTKGvE3skFWIlUpbrHxSOsgNQRtyCsIHqUqUQkUL78nUTfK4xS+LXxANQXansg/iI22gO2Ed/Jix6pcQfIZmObnvIePvcBW1LHDY+yJrPnjH7pIbW8qaOjia3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtPPUcYM; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtPPUcYM"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5ad5e719157so2423432e87.2
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 06:41:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782394858; cv=none;
        d=google.com; s=arc-20260327;
        b=FhNhsaPGxOudO9lcs9tIVrhbe2FqCZtfdi5ZPL4xPZ2oC+iceT+nQDv6HepiAEwYTK
         9ByQZSdw1KU/9Jv+a5I8Ps5OHKv5nX+iQ/okitmNmzK55LuHK5yJC663kH8U74nyRoue
         nVHEnxwU9dMB5wMjo7DH/fkhyI8xJo57MxqBtEZt50HLpaQD6yRNEDtxBzC5pHaufPRo
         JZ8ah9yOGHlITdFrVAaHDOxC4FaAbvhnIyhxFd/L3n5qmq7Jqx0rz0og7/y9OEZWMtXT
         frHrDTeqDreKmSDmOH6K/G7bCwV7ME/0T5oaQ9CVyMr/HL8FIXc9QqrU+8f1A1UZE9iW
         4Ubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xtW7rMNS6favmC/NX2OBC+xBddY+0MfAd4t+qaOXIHY=;
        fh=iYochAzh3e173Yn7m/d68Q3p9rTI8JeXnZmDAptRaVY=;
        b=kRcXY/idLmAlWNxIUf0CG6FGDGSk0zeBwBAuNyAfJHxvMTpEqn5wOfATzeYSDEK5dP
         ibbRG2xp3UuOHOYqn8JyWJ4QmDbyHzQw+5v725KD54s/yNIdP5KjLuH2rjTOZUAxhddy
         D431BZGCYgRZYKekKjgNmQGQLPXYZO/sUsP8Ab27zLlSb9kRuR6cRL8R2mjlI0th/N9k
         9FTHOfbIBar4Us8uAVY7KIb8k05mZ0tXPRt94psUbJ3zl+LPp5k49S6YRq2AQVqbOwLg
         U7Iq4oUqVFHrgliPzedzmtF0UJZW5h+5C0Ef0+1JycnnSsbIGsszXuHEzV7OGMAmR10G
         zZPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782394858; x=1782999658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtW7rMNS6favmC/NX2OBC+xBddY+0MfAd4t+qaOXIHY=;
        b=TtPPUcYMkgIFrkFeGzRM12qnW79hJ7odO6ZrP8q9g03ch89UGYLCDgp0ae7YCCUKGI
         PJgqU1OLLblp08jO3BhmXvjPWOE/+Gu2G3ZpjuiFQtI0lRTofBiAzX+50fpgLlWZLNBw
         defRHxiDfXbik8JVfXgJpNazqW/vt5yOUzi/mi93mp8yKUYS9pG9z5YXFFbF1iRr406j
         +2xUNNTpv768yLMeEKPY9MWRZxfVIfaDNydLdixwXU9GE/NGuaDJTNNJzoeJPQDnR7ei
         AJ3ZyVTDxJk6Lo6Vr8afIRZB2IB+HNFjrlpt1rKEKMQey4ZBB3S7E409AtW/f+LU9mew
         0z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782394858; x=1782999658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xtW7rMNS6favmC/NX2OBC+xBddY+0MfAd4t+qaOXIHY=;
        b=f+ItkzyUidZIQQzpDhY9Q+l7hin41ScLVUWi8P3hKQlyR0cEmnvTArarxn0HNVGRI4
         oMJDlNQlAXRdSbXX/h/SKX4K/cLRmPOcHXU6iTJomFXZPNPU23SEAedN81va5HQiZeYP
         QXShIJ1OtTvXbTTgU/+QpTmheJhZusyVZydRxFgYpq1+nVWfVDVBVnX08oGLNk0RNaIR
         k4xhu5rgHKG0P5OqpXZ9A5jag3fc8tv+4fsuNUbVZL5z1yycwsPotC5LRfEgjYBZprSj
         CQmCFEZ08OsQG04UuWg0ksmUAUweCgqzlKPFcTr8/HbvE8NogiSQ+cjW38lWLZzB9jax
         q7ZA==
X-Forwarded-Encrypted: i=1; AHgh+RoaD+S6otcLwCYCYJ9NneiX9QWMMvQh9mFAUMaH67LX1Z1zLgZEgm4SxoZdzQ8jNKG4aSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1pyPaumGQTg9iSR52Xs9fuudSpP9MOtgbg2Oy0ETlhdP1PdBA
	sXY6o23MDq95abga3EI3XhoU1Ry+7xJJj8ucysnBb77H2LUXtBIQIh/UDrrmu2BKgwG3mY+dzwk
	69aLOdu4lQz2klc1HAl7Gdtdw5eX3H5U=
X-Gm-Gg: AfdE7cnOtYKhMvlEXeZESLFzSOCUc/G+FeK7vflPOXoLd7I+v6JwDbTzQ8RbGWt+vnR
	V4LYs3LXCL7kxS8JxKcH/Ur7yPl7+2wv+FJGEaui7dsvZCfJAoncL5jG4xRTdIQeqEydk5erFt1
	kTaAb+DmXjcbFGKzzgPPBmqbMfa7OClhOMJPkBVvQTLIQN11rmmO3G8UIaBEZU8tui2EY32O+K5
	9zDOw4FbUXsVloNwKQ7QOmQr2RpdtUyu7LFR4Bom0CzbVgRawmGRvzPTroSmelWvLv1vh9VdUK9
	MpIrhfLGvaRAWnRvldzf63mQAjDAtjJFMwQMSz40H1ufejLrlYCipTetZMrLN+HGEJR7D4PQh4d
	17veBSHfHKg==
X-Received: by 2002:a05:6512:6093:b0:5ae:a4a0:721d with SMTP id
 2adb3069b0e04-5aea4a0741dmr400155e87.31.1782394858196; Thu, 25 Jun 2026
 06:40:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625115215.1101928-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260625115215.1101928-1-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 25 Jun 2026 21:40:20 +0800
X-Gm-Features: AVVi8CfDcn_mtY7ztHvI5zRHxmjaEiDfgNbZB4FX4ThmzS7jnZieZ31ASCK2EZM
Message-ID: <CAL+tcoBgur5sAoUWyGsd2rhpC7Gcx3peh=sRKmkiN=9myNRMYQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] selftests/xsk: Preserve UMEM view in
 BIDIRECTIONAL test
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	tushar.vyavahare@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 7:52=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> The UMEM state refactor made __send_pkts() use xsk->umem for Tx
> address generation. At the same time, the shared-UMEM Tx setup copies the
> Rx UMEM state into a Tx-local state object and resets base_addr and
> next_buffer before configuring the Tx socket.
>
> Passing that Tx-local object to xsk_configure() makes xsk->umem point to
> the zero-based Tx allocator state. This breaks the BIDIRECTIONAL test onc=
e
> the roles are switched: the same socket is then used for Rx validation, b=
ut
> received descriptors from the other logical UMEM half are checked against
> base_addr =3D=3D 0. With the new UMEM bounds check, a valid address such =
as
> base_addr + XDP_PACKET_HEADROOM is rejected as being outside the UMEM
> window.
>
> Keep xsk->umem as the shared/Rx UMEM view used for socket configuration
> and Rx validation. Use the ifobject-local UMEM copy only for Tx descripto=
r
> address generation, preserving the BIDIRECTIONAL test's intent of using
> the proper logical UMEM half after the direction switch.
>
> Fixes: b17631032769 ("selftests/xsk: Move UMEM state from ifobject to xsk=
_socket_info")
> Reviewed-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> Tested-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Oh, you've already pushed a v2 patch, so again:

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!
