Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3CD33B6FB
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562233; cv=pass; b=dLSqFX/qBEyXzfcaj2oSBKzBIeZFsJPp41+sRF7oYEsDLjxh1snIlOlQaRnx+qQGtpKyu0qAFMA8GUxQqpDpCYi/vnxWGmz/QE6VvxX0lkWYHo5rf3KViNydlx2VKBMDo0Df+6tpd3vPZWrsRSKAbl3ntaMHrepWocVxLbZ/XYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562233; c=relaxed/simple;
	bh=l/2NvT8wAaZjhTPr/ZhLk8DKnV44dtAlDJhAZmm/nMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6iUU1S5jFvnCJ5TyXNHo66o1BTUIs9LVe0l/kKTR9pgXhMxzMeV9JMiB1TzgJPuEPsHacmBq0xcoNZSL+foZkHJUpSY0xr/7aWLrZYP81d5W92sE34MkQu/0gg6zONXTbWMfh27RUu2r06v+WPkx0D66F8LKlpqqSmtieFSOaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rnnKx1YM; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rnnKx1YM"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6aae147ef9dso13107a12.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 09:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791562231; cv=none;
        d=google.com; s=arc-20260327;
        b=V74vgvuPZzeNtJM6jQzoYElpOTGox+8uYsiBxZHbMcPhr4j4lVIEX1SoSiTMTZMmt6
         yU4xh04enqKXnQmLvRfYiPi/Py1yDpeRb/Sf7G0m7uALwXJq/LgKBhykcvBOs4nka1Pn
         m5T/in8Xhg4J+mJV9z1yi9iajJkShWWV9/B3zeX2yo0t0WpLoXi6cwb0/Y/0njlZHNky
         uvxGuTdiIs43aO6bUzX5KSvpqmHuDIzpSmRsoL8uSm2ug0i4+dcaTkKofnuQY8DAhZYP
         rnvbbVoZ/V/66zofm0FmMQImvPdq9jW3GZxc+kPOd74JwsLbT+bro//Cc/NKW6iyRv0S
         YOAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Shr7ewCDcxmR41j8pJezsmsxST+IY4eGTxrK4PfmAFg=;
        fh=J19r0BP5XvfEW6CeUVs7C7OWBV2h/VlT2wF8WET/Ggw=;
        b=VVvS6tT0wPTOcQkxAZObFdWDCzRZQVNoKXn5rBSMTvlRcDbpHEnDzf/NEWJRX80/aJ
         mHzNjfAp9eRbhQvk6aL2/M0yweAi/2LlfCnX94K3kEgKGjwrxk1rrIaL4iH8Innj03Eq
         +NP744MNysCialfg867Q7PuQtCrCwt5KQ/gX/g057GZxPQ7Kz97h+YL6yBxlfTEQvWOw
         ospyYTZoUFO98yZq7Zs+QQXRhMzCaViQ7LNEjFuc0uAVc1UoeEm3v2IXgoJ/qnM2Io5C
         gyEvPymptqarK2QREn00m3jhSSNzyL+AUTJwdr9CTGM0Aw3jF6D7z80OiIP6yX2xTFjO
         gyzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791562231; x=1792167031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Shr7ewCDcxmR41j8pJezsmsxST+IY4eGTxrK4PfmAFg=;
        b=rnnKx1YMGVv6LcMJI3ni0RBJ05j7UP7eLxF05QYbTCPY68PYu3RkbGwhfVwUP+tUvT
         J4ENfjUQ+uk/qDOkoVAJRD8pZE2r8wnE6egJBWtXyph5GL0iP8hfeePVnoFehAnNRdB0
         83CR/klE+scGAMTSJlNxV/ChReMXOFomQoKlcsYhypiSR+BxJkNYpJokIhlvnF8sKqzT
         W1bJIvvgQwgYo0pL82adLeuASsykp1cSogmisXOR0bmlzYhI7hi0X4jzXflkmGCCz8VK
         Ox+0lh3rObmzoGPJ+0S745nRmAvA+cGeEHIj3FGU0ayWU4H11nyBan1Boky+fZf6/s0/
         ReXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791562231; x=1792167031;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Shr7ewCDcxmR41j8pJezsmsxST+IY4eGTxrK4PfmAFg=;
        b=ijp73qEsYoi/3ATiEUEopm8OZywXSbiTLDy2scD+SvcRG0RfPuG/5ZeEzeJoIDJtNs
         Bi2mmAYsEjhGfrtniTmffEh06r0APNECiQfYStN46PwnUnTcNunui5WGVHrk2ModIjLw
         egWVDHd1NArtr1xrJaZylumuo0PHQORIX+kPCvWBjgVPiF3XK1MS2rJsGK7Wz+QrJ1H9
         LNmB+MkZGgz/GG65APe1Aek4be5C5m+2ABmmTWxzg6Q5llWLI2FRpi+PWmOtPwWdlz8c
         7y0dWA6b1QQm3pZq1Yuo0h1XneYKgA691bunw41LQWApktGJXOjD83j0HXLPGY7AjPKf
         QcOA==
X-Forwarded-Encrypted: i=1; AKwUvBzyy33a4sEAobq9PyXC9gIOMth/B+RaDm3l7eWYaCKlTG566INN+qplYqhAZpLpvUYl5iU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNkxTvtcEU3wgTZZm08vwGbtv8qLtTBI40fjO3p8Wr98BHqm7e
	FWyr6J+DzbY5gTBJQjo6ELevaURneQzAVlzlnl0f3Yj5L/0RGTqJ2WB9TrnuP1cVSpDnErTve2T
	s4uORJPySGgOzea8ZDGiszaOrKj+TLlOo6wiTEnht
X-Gm-Gg: AYBFou3IKUL2tSuesxgPUpO19tb7Rm9mkNJz3DgvO4HzBzRsbb5ZH6HyavwG31+SySw
	Cna91y12lTF42ssfvxZ8FbrelhEsK+OKTN/KkomMBNjLVTjJ4BYEFW3nMvEQg9k4aX0sOLSeg3h
	3IdlXH2H/p7N5jHVv9/PtjbMQo3pQGI5+M4GSNQ8JfzfieEk4knz2R7UAu6d0lNToYjgAThv1MT
	t38rUfU+qUJZ2jZQ9MIT58DrhSodcLj/WfZT3yuFhfucIhMc6rQcu5NApgW2Jpjn33wsDKSFJXV
	gY1nBM4UwZNG7DQo6DnASTlDK9IgOYzyYyjmejt0suj51SBT/lgY0Q==
X-Received: by 2002:aa7:d743:0:b0:6a6:7dff:61ab with SMTP id
 4fb4d7f45d1cf-6b17b963117mr42270a12.15.1791562230138; Fri, 09 Oct 2026
 09:10:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com> <20261006-b4-skbuff-bug-on-v1-3-1b4434c5357c@toxicpanda.com>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-3-1b4434c5357c@toxicpanda.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 9 Oct 2026 09:10:18 -0700
X-Gm-Features: AclHuK--6z6-8oIyC9Y_LYzNmkmzq3sx298S05qv9PBQ53pFLOBymcY5H1fz2x8
Message-ID: <CAHS8izMK_RDcYBZq3AZEDcxnRHWRt3ctOkPMvoA40XUmCs7swQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/9] net: skbuff: don't BUG() on a bad frag_list
 layout in skb_segment()
To: Josef Bacik <josef@toxicpanda.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 10:10=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> skb_segment()'s frag_list walk assumes the GRO-shaped layout it expects
> and BUG()s when the layout doesn't match.  Anybody who can get a
> malformed GSO skb to a segmentation point gets to crash the box.  Most
> recently commit d5dc1e69fd72 ("inet: frags: strip GSO state from
> fragments before reassembly") fixed one that an unprivileged user could
> trigger with two writes to a tap device in their own user namespace.
> commit 3382a1ed7f77 ("net: fix udp gso skb_segment after pull from
> frag_list") fixed another.
>
> skb_segment() already has an error path for a bad layout: the
> too-many-frags check sets -EINVAL and frees the partial segment list.
> Warn once and take that path for the four layout checks.  The packet
> gets dropped, which is what should happen to a packet we can't segment.
>
> The one check that runs after skb_clone() and before the clone is
> linked into the segment list frees the clone itself.
>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>
