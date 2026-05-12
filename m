Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630253B4435
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596410; cv=pass; b=uKTvLzdLy8oIbM7M66fJlT1GCMeZWhTIvfyFDjrFsaUy5g25BizNAfmiTt4Na0Hm0pSBAqYDLuQ1Tgk30Hjedq1LdIubPsYwHzUz5MzLeRpLXstYHULm7KXMR885Ax/4gzt4vPCJ9Ae8TtMKp8yHtW4CDHIcK62dLZV4+FOpPy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596410; c=relaxed/simple;
	bh=tGgX0l6ytIx698dvDPac8KCkKialk7vhswDMJfEF6Io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBH1RbT9lSqt+utVUmaU5LxlMl6+6wjdGMNm4wZ5W3cer7OXINAaUG8mzWyBgf03R7FUV3HP3zi0Un9/cMWfEkcS3iMfd5jOTCXMYHJ99mgbF6WNa/hfObcVs/e7qRj0cbMX60VYbpPIFgWLQB1vWO5RwChQruAQA4DK0aYItb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6m41eCO; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6m41eCO"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a8d1f43432so3218178e87.3
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 07:33:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778596406; cv=none;
        d=google.com; s=arc-20240605;
        b=ebMNpojjGUJCfhTeTnQZeTk7/PepU6GTIlpV1Tv7jWZUVHFb2FhK79eKt5xdut/M59
         XgEC//4g/6AIykiKdaovzqM0kn7Q8On+kwtvOkm2C7MtujqrjE6BNG1Mf4awqebfFq9h
         7nka/tusamkvX7xfEIYcE1GZBr0kvCGZtx6U8bldzUTgQ3tUkK4Y+IxTYKNObvLXHlA2
         I72s4ik4ymviAxFqfz1X1VF1sq84rDlmvkIYgTWsaIiW6ASl+L2fkawp5R0593T+1oQe
         bYuR1ALUggyQJiF333gdLdN0mf+LNlyXXS8+pHww+yawwGg+9S1Wsi3etHXumNTL1HrO
         V+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EXUv7LZ3hil13DS+1vWxEoJG7EI40S6boiJv/fJ2an8=;
        fh=2FQ0f61bmuycnM9x3NKD9by/biaxH76CIExTOFBGMyA=;
        b=Mgd+DH6rTVGIisHbWz6S1ovy4gmHNsrJ/iXPaqpGruSOOswyqJUM26X7y9GSrvSkn9
         vnQDT+VGBX7NmgBg9iDn1WlwPTuis/D+Bo8grXP5/05b5V4MB/JyFvedgXdd8i/DAFzH
         yX0BshHcX9GyJjcPHDu8DBpwqaubEvloIF9T3S9p18VFJmD2eclnp0ZGqaRZqGLaRLkJ
         /9DVXs5KOOh+CYcSro636uyyVpM04dh3/M+tPX1OLLjRTMpGVxStcJ3kut5kEogX94uH
         rzhfxVVsPcUzqfArxXBM8vDSPUWaIpCQLINUPkeNqELzeo4wvhUakkelpr1/8NZRV4DR
         sfEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778596406; x=1779201206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXUv7LZ3hil13DS+1vWxEoJG7EI40S6boiJv/fJ2an8=;
        b=U6m41eCOsygw2T7/afuG1MX35qhXbh8UCAWxWC9H3xdWOiqThEn6NCtS8QACCwZo4D
         ClqFdrEsj8BneboRIF9rqsyZJ6h6aKsIx66dJvg0dNcQfLgCcuu3vG/eBTNACcvPOxgL
         Mqe4AXpgKoHPCb+/Kbqt6QJQMD/EOjbzONU4rm1NgWJbVOh502Dp5W2AIVttdivMmvG6
         4AAEbhxEwuYpkSB2vp1S+iwCRm5+SYGG9qBeMR8VMVHigbRnTT2weQTRjPF1Lu3RQYsh
         uARJPmrjD+AAVzWtrP6WLjTli1SH+8D6LS5b6yYdIPoTPNBdpBkbShB8dcL0cDDm+PPE
         lH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778596406; x=1779201206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EXUv7LZ3hil13DS+1vWxEoJG7EI40S6boiJv/fJ2an8=;
        b=HPiHwgrbpTW7meHK+JRr7lT+kdQSyBXtFsa4cw5SO3d5/BuZj/bi9llwG8dE9wNhhD
         uFVZKhdWzDZBM9K8k2PJYgy16zDUbVo6qj9p/o5wjuUrNk3InEIJf63WOf9WQYeZT+WC
         jHpCICft3F7QifWmBbb2owiueeEuxq72CjaSUzCOHHh8VEegG+FUJzUF293tSZjGm3GK
         pz0Pjwzg2cUoTBbg8HQFpBKKEEMkcXfHs8Eo0jC88Y7O6Edj7zYbpQZwWooEzJvweH9m
         73/59nwZ0RNTk1bCMHVbpRERbCBspleR/XC4qmpcaUdfuhP/+GIPB7kZyv8bVCOeNnHt
         5Ezg==
X-Forwarded-Encrypted: i=1; AFNElJ+UV/urcUnLftDGrRxU0jmXYY8CHAfQ6LKl9EYj8tZ+uWjwJ0v1mrqEjQP/ssnc2hnGWJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR4iI4+ioOTsfp1y7Ca/RxdJPmC6DlwzrwwtxEN8MkAhxdYvWo
	OANRqpqUdvjQ3uNBDv8LZ1dtElvFg/HF4lKMdwo7iIRRJqn4sH1TUkywyxzSxdMHwwkSaxhoh/V
	gsLGyxFSW7ibWtxfl3d5Wjb/v0ND7yck=
X-Gm-Gg: Acq92OEKCgoyYu3p2FRmP5+LD+AU45QdpbSan6HqhDODSAieGwe7cKxEkCAkHvAsn1R
	t0zDQL+u1uLmANxQ1sNtXuNGqCZEdGbCf+ho0mu/8OR2Vvv5lk3mBNyKr1SrUYbzjjY7MXKy2K/
	rcyxZVZloHRziM7V0hUOeAwwnrjTSg/eIC78HaOhYepW4P9b4z7HxLCS4xIkRCixeXGd0KST1Ui
	hSr3iVehq2lxyfp83p/Cap3UysDkIX81PRQUQBy9MigMGzTiu49DqTbecxLCI59ktx7aDYtusgr
	5qJQX5u5ReAM/528nWt3kUZJ8XC72ZDJ8k1A5qw=
X-Received: by 2002:a05:6512:a8b:b0:5a8:6d09:483c with SMTP id
 2adb3069b0e04-5a887cde8b0mr9177414e87.22.1778596406090; Tue, 12 May 2026
 07:33:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-2-kerneljasonxing@gmail.com> <agHurBlnAgjVNq-u@devvm7509.cco0.facebook.com>
In-Reply-To: <agHurBlnAgjVNq-u@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 12 May 2026 22:32:48 +0800
X-Gm-Features: AVHnY4LzRy-kEe49ipIAtXqtdtfngArZKEyPOI6lhrhr2J7k4GL9DmZHDRGpq_s
Message-ID: <CAL+tcoDrjJ8iHzSGz_Orf7iH-1WJ2H_LZd6BMKTnDS3MVN8daA@mail.gmail.com>
Subject: Re: [PATCH net 1/4] xsk: cache csum_start/csum_offset to fix TOCTOU
 in xsk_skb_metadata()
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 11:03=E2=80=AFPM Stanislav Fomichev
<sdf.kernel@gmail.com> wrote:
>
> On 05/10, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > The TX metadata area resides in the UMEM buffer which is memory-mapped
> > and concurrently writable by userspace. In xsk_skb_metadata(),
> > csum_start and csum_offset are read from shared memory for bounds
> > validation, then read again for skb assignment. A malicious userspace
> > application can race to overwrite these values between the two reads,
> > bypassing the bounds check and causing out-of-bounds memory access
> > during checksum computation in the transmit path.
> >
> > Fix this by reading csum_start and csum_offset into local variables
> > once, then using the local copies for both validation and assignment.
> >
> > Note that other metadata fields (flags, launch_time) and the cached
> > csum fields may be mutually inconsistent due to concurrent userspace
> > writes, but this is benign: the only security-critical invariant is
> > that each field's validated value is the same one used, which local
> > caching guarantees.
> >
> > Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp.ker=
nel.org/
> > Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload sup=
port")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/xdp/xsk.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 6bcd77068e52..cd039e397018 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -722,6 +722,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, vo=
id *buffer,
> >                           u32 hr)
> >  {
> >       struct xsk_tx_metadata *meta =3D NULL;
> > +     u16 csum_start, csum_offset;
> >
> >       if (unlikely(pool->tx_metadata_len =3D=3D 0))
> >               return -EINVAL;
> > @@ -731,13 +732,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, =
void *buffer,
> >               return -EINVAL;
> >
> >       if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
> > -             if (unlikely(meta->request.csum_start +
> > -                          meta->request.csum_offset +
> > +             csum_start =3D meta->request.csum_start;
> > +             csum_offset =3D meta->request.csum_offset;
>
> Wondering if it's better to READ_ONCE(x) these?

I still chose not to use it after reading the suggestion from local
AI. The reason is there is no WRITE_ONCE pair to make sure everything
is no data-race. I also checked some existing implementations around
the shared buffer (between userspace and kernel) and didn't manage to
see the usage of XXXX_ONCE(). Does it make any sense to you :) ?

Thanks,
Jason
