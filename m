Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B3D30171A
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158549; cv=pass; b=PUORDwRq9qYDtpNtcwelyBLIywYTZcSGq0naAkXNSu/atMijZ1ON38FqfD5bdi+kDAcsma5E4+wqWZcgpQzF/cHMY5TtlkXD0d1ViYUNCAMBBJdCqDQU2E5dWtbKglwuvsJ+6nWPq4kIA8a2poxxdV7ror2MJBQaE8TWKvEHR6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158549; c=relaxed/simple;
	bh=4X6FHQLnWfxk2g//RhR5g1H/TpYP7f0F2v3qSNZn3ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhJf6I+Q4cCGVG7nvHMyV1QZgOt4ZgH13u1q9CG/DPODP4CAqEN643RdWsKxOugUeSamWViOAwGdRKtwPoIpuTBGpmEBGEZMhsd8PFZtLyPnD7jwBIsbc51yVmGxFNZStiMfx9t7uYbIStez08GEf14Wowia7mHfo6F5urufhIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRoz2nd1; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRoz2nd1"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bf02533706so7494737b3.0
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 05:55:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778158547; cv=none;
        d=google.com; s=arc-20240605;
        b=N9jE1G1UKLAwOUmQcCilBnWSKobDE9yoTh87+M4FQW9zcbCCON+kMGWbUs6V/ZiRPv
         NGlCgWeBKucF+QJXVroeiYAnJiAwlA4ZZjSaTmsgicSpvyr1N9DKyfMPi2CVOZl1OaFE
         gPJNgxmtMvQu/VyZA59Etu2Vi0JmXUI/9aoxXnvTMgyzy+Z4OpHmRAJX3YqCNlXMcMnc
         4QSbMWCxpOo59+uQvnfiyn6+l2L0VCteEO+299LwDGyovYgjgp76gRIXMEKOBA45mm6C
         8YTP3EVLHjCQB9FGlYzUTlytytxOLWAHPRdQXMMuNNkmWvdwcamncJmSfg1PSWrJ0gLo
         hhvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p3xGu5RBGL9IoizFlhBR8QgmO552FaQukua12pxcpWQ=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=CZ1C2A1gV8+v3Ytgo9Uy7LKv/pmyw++iVb6nNtNs8f9lna6xNL2nO7693M91Wh859+
         TON4PE2v3WZwL0dll9xdXVZB9kTWi5zpl7IVCaEPLKKHLwUJJoTxGYQlBLc7KoJcEujv
         T2cTzzsEz9nPuDqTMPYqvGyREM9aHA1CTBImDA1kjVMIr0rbj8oY3PQFOlmmayIF4qYk
         Hb5afT7eLRVYUGEp8xpPfyk4SjacHqwdOkejN2rHi4m9MgePna0sFOlhBVdC3pbXyLTc
         1g3xmZ3qodOOxhfNw+kuMGjyODtVi3NWmISiZyCNSct79QtIZaXqXohr2aYkw5DNxYFo
         g4FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778158547; x=1778763347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3xGu5RBGL9IoizFlhBR8QgmO552FaQukua12pxcpWQ=;
        b=GRoz2nd1IBxfeyrOMtRS8A/8fg4genz7Eudt5NQdPVH0SKv/ybR3PxgirJtwcY9Le2
         30CX/zOhT561ZQH/v94/B3lAaHWcrOb7zWwi2imnTc5BJUtuMHT8QXjU3mAmPmtfmHEJ
         3msW/c52/jos34xPOuMrGz52iSbfh4G8gmhkVdE09urYajW2HGS1Aif2qksIFAD+Db3i
         Sm8jLuVq7OWwdbZF4l9BvBVs5bFlrrqkJQmoBHJIR2D4CJ8sDKD9AynE0ANwlH0Tstei
         pyGvOHHk8GPeKCbawaD14/aQ9daPO/Jpm9a80xHL8eownm1zAfRtaSiR54r9PWxgzsst
         Fxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158547; x=1778763347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p3xGu5RBGL9IoizFlhBR8QgmO552FaQukua12pxcpWQ=;
        b=m4WA6SxnN2wITiLphT3cWMdfdX2+qrKaHQnXybIdn1Mj3yv7W0Sgw5sIpUfoShxBbF
         cAIQQj3s9ucLTPm6evwOXCSEKWaRpiNiPiMM8KEYgS0q9wo8P1r+xF7CM2saS1CEeJHU
         qK02+0DtwsjLLAQz868wBAw5RQa01RW2PA+fuCMk9vKjOwKoqCGpzmtrcpolyWcmdzvC
         9t+SXVjziTFqQpJgeTYE60EQ+nGTMdM8ryvsvsu8Pb8ZxAJ3+2TxZpmg69vuK1PinfMY
         w6n6spkOr1VfLSaQkkeW/7loIFgJC/48AwFGiDEfm0FOMlGamSwtb5CcVfdkt5Uauj87
         Ymag==
X-Gm-Message-State: AOJu0YwWfECZ8sjVgpl7SZsQ6LGf2F9quI35yzOaNWAYF0E42VwBk21k
	q0OeAb+8JWQ7iOwblygYmkIYCyGyeMnwjXVTd2FzZzzEstOWdw4/M8efEv91zdGnptTVWpsnQnv
	OQxxvKb57QpBiiGNFcBRhumvKByCSwDY=
X-Gm-Gg: Acq92OE1FMIyED+QwN3Abn8eeoQuW5H/HDa3hOKx0+77ssggApAtDM8KD03E6SgLtnI
	wPGeYyNJg93wV2QHD7BMw3AniOcLglXwMsNVYnvNL0upS1/O7CANJkgzdh1FMVugYqIHcuaI7A5
	fMblchXdD2bnLvHU2JollUYcsnebFeWI348Lih7Wxa+zVXN18PIZVaQl55l5wbZgWoJ65cIQ4Yd
	py7X2joPBHJX+w8xvOBQtUQ3rwtDGRG4YCSWKx4BTQevrv4n/+YD/frWEjqQ/o0qPRGzAXa9oL1
	1bsQyvxDdlLsibr/JkY=
X-Received: by 2002:a05:690c:6101:b0:7bd:95d1:ed51 with SMTP id
 00721157ae682-7bdf5e9bf09mr83497147b3.28.1778158547307; Thu, 07 May 2026
 05:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506142709.2298255-8-ameryhung@gmail.com> <20260506224833.71FC4C2BCB0@smtp.kernel.org>
In-Reply-To: <20260506224833.71FC4C2BCB0@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 7 May 2026 14:55:35 +0200
X-Gm-Features: AVHnY4LhQWpxqATck-XP8OifpQI6HAh1GPN_0ZQbGDq937QCrpiD455I4L60OU0
Message-ID: <CAMB2axNQ+W7OUa8vkuedT7hGebn0TS=-aA9FJd+ZvsFCWE1+sQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 07/12] bpf: Unify referenced object tracking
 in verifier
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 11:48=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> >               }
> >               /* Track parent's id if the parent is a referenced object=
 */
> > +             if (ref_obj && ref_obj->ref_obj_id) {
> > +                     if (ref_obj->cnt > 1) {
> > +                             verifier_bug(env, "function expects only =
one referenced object but got %d\n", ref_obj->cnt);
> > +                             return -EFAULT;
> > +                     }
> > +                     parent_id =3D ref_obj->id;
> > +             }
>
> Since ref_obj->cnt is determined by the number of referenced arguments
> provided by the BPF program, is it possible for a user to intentionally
> trigger this verifier_bug() by passing multiple referenced objects?
>
> Since verifier_bug() expands to BPF_WARN_ONCE(), triggering a warning
> via unprivileged or user-controlled input could be problematic if
> panic_on_warn is enabled.
>
> Would it be safer to gracefully reject the program using verbose() and
> returning -EINVAL, similar to how it is handled for release kfuncs earlie=
r
> in this patch?

Ack. Will change to verbsoe().

>
> This same pattern appears in a few other places introduced by this patch:
