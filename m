Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AFB353A64
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 07:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854008; cv=pass; b=C1wRLxjdIzuzCX+IWlHAd0+CVvsr5kfdZg1has0lcRTmXM3e9IbooSeE5kipJaXDskBxgLTXw+Ds2h0kMibYYKikDMHo1FF1rSrB6YHhdUEYp+2X+1M5sJKvJ8RoYrk+b/vnYgVZkcI+j28HjRVrAN8i6PcJLANFrFp3tOSiYtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854008; c=relaxed/simple;
	bh=ShfAywpUEZoRZ1v2EmyNOETVC1aDGZFHIpuGbrjaL7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVPd/yrcKgZXqJqjfx3DyEmUtPGPrkZV8MsDz/fQD8j/cNUhaZmB+erfRFM05pFS0D6chvI+WsQGkwERfGpC8O8LktgRuLT6uZ/5Semut6r1/NtuA/ABjiFOh/7ygkEDws8n5N+IpUOjwslXHBocewrTWPQ4Yuxh7JzIiM6ybC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2Sfcf+5; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2Sfcf+5"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7dbcb505578so40034407b3.3
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 00:53:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788854006; cv=none;
        d=google.com; s=arc-20260327;
        b=Rt9KSWJkkW040Jks3+3myFTT0rWdLfJdKa33Po6WwZMpTOyVNwXr08AJfiQ/5lyid8
         2QB41a+wI4/HP0taSIGDL6bXp3ageG5tvrmApRWkpG9QF9g8+iNax6TqDQ6whfr0IhMf
         Ij9bmTehZJEo11RVqdbKXc4CQhMzr7hdk54J6ldsG2AaMeMThQqf1XP5Bn5iEMcSaG1n
         Lmm+rlamuKQCQK/628z8J3K1FZcuMOW4lQFcLeUq1ZOMsLF/ovmcGRd55XbTtJ1Fd7e8
         JU2g+2qaXdrIr5YtwsW5GkiDR2iWZv88LcCv1WbcXAG6l0XJlJ/2t6az4Fj6BMKTy2pf
         Ptog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rDy5ySt2VKi39jsUV0PwI7yCvNPALu4E9wVX5UyrP4c=;
        fh=0frdoPw1f0fkpjc+16I3Cu8tzy9L9P+vJ17XPnDpKRw=;
        b=i+mlPQ+UzJh+vEuyYl9079ruwt3/Xex72/4RnFM88weF/VwzxkR4oMgzDhK2KjM3Gk
         gwMfnzGQLVosTEyonnOwoaZSyB6Zq1gnspCOHbaUtG/02ryjgksYbJiDpi0Q6FAIl6Ad
         Ql1Ld3wvgDMl/J0+rWezEOll1oaoe2Ld1kRjJeFdmEMp1zwmh/HRf7oHXyWbismiXAZV
         FsUlJAD/Ud33FEzOH8Yri5SwiTlR20Jmit+ulAtQf7NWKyG8hkXZOJi44yIz/RfZd0vA
         eeppwnbKb0Ii8tF3/mBlAqIaF8W7USFY7sm4s4T+0d86OShOVU7qQPfV9dOe3DpXKtzS
         BKnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788854006; x=1789458806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rDy5ySt2VKi39jsUV0PwI7yCvNPALu4E9wVX5UyrP4c=;
        b=G2Sfcf+528ju185GWhS0jDRa32GuytwzeQ87OZqCfcpeCYaaQcvJW8LgDa7i+uW+cJ
         u1ynDYlW2fEdYxzzO/CVKdVhyZT1HRG2JT01z0c+F28KIMKvOBr4/f4DTNeDhqEKAbd0
         feo8EOfv+GOy9qaYjuooIutTE9np1DMOactufimtUoOPZaARwxfzTVr930otfl92S0Wf
         BXCJLbzIvVSxmdASIcYXQIZFepMicjVLe3F/xDNVbo4cTDOeHe2QwGutQBnmOLzrAVT2
         D3JfzEIDD/WhUTd4JX79S+1fZDCeJhYolyVUXoJ8Q/qhOw8SvgFvyA6Yqu3dtIPG8Mcd
         DwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788854006; x=1789458806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rDy5ySt2VKi39jsUV0PwI7yCvNPALu4E9wVX5UyrP4c=;
        b=mgJGfesCjtzjLHOF4+yDN0rDmr5+PaMZ6Z1jUwflUvxGFDiC23M+IVnjlPpJVHMNLK
         PEJAXGVvknm9dzoMarsUUmfGvCXsYaDT0eIL0dnts41weEQHtxk0hqYitWw7lZ9Rkmom
         OnCnwriRKqkgLxYdHU9c3xLOLvOubZd10GLy3Z1vlvhBKz+PIMp5CZbsq/UXLd/pZrL7
         Ycb9ppC5H/i0WmK2xuActqbj5lZ6W9KKMI583PBmOaTyUdid6EQbgkQ2Lz7t8VIrWqI9
         h/PGIIgUsWTRc1AT3wzpr1LJAQc0WVjac1+QWqr3oF6/faTvKII1B5W8BxCy7HLjXkh0
         HDRA==
X-Gm-Message-State: AFuF++kCkCPxmWgESXyQo2Ks9UtjuHPxJTCJUYHHnex0GRDg3MnHrHWQ
	5UdtTCt/qf9qNy8L/A84XtzrFssvNWwBJ1ekv2Ftw7BgkUVFIshvjFQGuHBSOb0hB4LG7nrTJ5G
	hAFp0Hsk3stnYfckBBuX5KRJID27+U/A=
X-Gm-Gg: AYBFou3SbECWa/P7Lz0N37su137kfD8fDA6Y+sbspcoFcewvkyp00hg/lnC9QQIbXaF
	rjySDbM+Q5tGf1dmo5XWt8X6dgaqUaJvWjSl3PBoA7+LOHLKeYH/6odsiCw6JpadFQ5PcT7CLaD
	WLS6inRDKhYFCpZT/inII4/EWamPrhbItaCE6boiZpqVpwO1CmOOwDc8Tn2ZFYUiO7iYqEtcz/z
	rRY881m1edv2SZ1zNOMknosvzsTspLbgBuFYcTTaPU6g1KcohkrUGmrqBryabU7HwF4gFPLxMTd
	7g9bAEsF0pewhDidXztmTE3ecMLcpuiuQBRggH2+7gB7lQ==
X-Received: by 2002:a05:690c:6801:b0:861:804f:32ff with SMTP id
 00721157ae682-8712800de8dmr93501437b3.27.1788854005933; Tue, 08 Sep 2026
 00:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ33NAX8=B6zwXDfjTvyoAOV_=1NZADCzCjCk4xtoPLE==yiPQ@mail.gmail.com>
In-Reply-To: <CAJ33NAX8=B6zwXDfjTvyoAOV_=1NZADCzCjCk4xtoPLE==yiPQ@mail.gmail.com>
From: Anton Protopopov <aspsk2@gmail.com>
Date: Tue, 8 Sep 2026 09:53:14 +0200
X-Gm-Features: AcwNN1XXpiERcBCKuUGZvd9s6SxHvMjAfvtrIDm6NWiN9h70a0l5bzhtFibW1c0
Message-ID: <CAGn_itwxDRqpTgxfBV2rusBAQaKmyMAt4NQckt=nRnbEm+2Y6w@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix dangling jump table entries for verified
 indirect jump targets
To: Sandipan Roy <saroy@redhat.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, jolsa@kernel.org, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 6:55=E2=80=AFPM Sandipan Roy <saroy@redhat.com> wrot=
e:
>
> Resending with the correct Signed-off-by.  (My earlier send carried a
>    placeholder sign-off from a local test setup; please disregard it.)

Please resend the e-mail with the patch embedded, not attached, such
that robots can process it and people can comment on it.

Also, please add corresponding selftests.

> [...]
