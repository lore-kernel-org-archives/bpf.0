Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859713115BC
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 03:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792122498; cv=pass; b=EzuY9ms/DgQJzwY+x+Ygm4lLYuspKJqq5LSYHkzYRlLsRftMSb26bXo3mE1kRZ2Ee37dgGcoV11hgzNNlUUa0QJzi2N5gGuG6JeRMFrXAAWR9wGwI5dqwiyyXxGHbtGIX3KKu85P1fWo+ee1Pt2SefWVoL2BfPX6VZ4n3O6McPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792122498; c=relaxed/simple;
	bh=WDhfqi9KVGdv84+1ic9hTc/O7+GDjdOl7MkC6oMvKIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TedqsumIj49rdTUpKYETKwGb3noHkiXqj3nQF7UEoRCCWt7RJIHoGBl1Oxhreae8xRd1b0QRpeHpgNu3WN9/ImN2Gf5kPKWRpp9yXzy93F2LzTGhfcoewEHKyUo+XI03NuCRfl0q+PQ06Ngx9LUSxW9AB6wyxxB6xJzckdfnj0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MFUnJYMq; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MFUnJYMq"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so3555a12.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 20:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792122496; cv=none;
        d=google.com; s=arc-20260327;
        b=Qd9KiFmrjnY3ufDy8fUUywe44Y9hNk/RO+1iCWvkBQXj5uSblv22QhX8pAiSD51oRX
         +gS6yk+6fNORvRXzHV7cPJGLSmTeBRNSFLfuLW6q2xvLz1zGWYE7yARySuVUKDqhPoa4
         2W0DFipn3WgzBBgqDzfvfwwas0KxhVi8D2c+72sIKbC46Tw5L1Pxanas4UC150eFqWpd
         dHOvBJ5uFM1KcGFuIxr6B/751/H9pdHeOYPZm1RARQmBrhsBMABCf4DgQqxh80i7Qo60
         GXepp4SNmEQb9n86Fpl2XAkHVYyK5o6dO4UimFnLEw8asV5zHM4NQjnncDD2Rhc4S1OI
         WtyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cHwmVcL3Ea2QJiHo6JwLvdH2j4OcK78NhenhdrCZCWk=;
        fh=ynLacPwFkV8n/2mM37JLcI8WoT0r9+JEZ/CPScCjSi8=;
        b=cMWLpYtgDiK6czsb4qv2hUFL1XSJiP6XmTge49SkIQpKnY4SnafcvMztqVFwn7uqBh
         BPkZkaHACO+5A/y70POXIcofyR+FBN/xJan0FVsWXUmuzdN1AEBMVh7L5/NTS3iWrKMp
         u9ijOAsVpv4usr+8pTuQpBR0KOm4ZDdOW795IjrzLGwinr94eXGSe9UCvzxY5WGmuiuD
         WqP+tFUZnCkCE2T4mymACOBEDnnATKQH4FbdFlTpTEVdiWQNeldb7jcApSmZulsTGdTL
         lmjZnUMpnX877/tU37IlSd8WENDTNuXzjOcP3CzqX4Ys449yZ5mennCKWgE7F2sSaD5X
         D2+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792122496; x=1792727296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cHwmVcL3Ea2QJiHo6JwLvdH2j4OcK78NhenhdrCZCWk=;
        b=MFUnJYMqeRN8pn5oS/fx7Cd7aYGZTuAmL2OPtbvk0h3AtusqHufhUy/9R6we1FzGNn
         bBiaEt0IoROvODwpQgTngVSOBgbPr3GOWyKRzCSfikrMcdUKGd0EziFzmIUG00VCAETh
         GcF95UW2KmEWCHa4jPsDafHok/nbbXBUu5l4cFYA73wuuyQl1nvwkiiyQqZngE4O17V9
         ZTY095u1puHUkVdeCxOdqk+UQTLkUeao3SXccnbw6t2YW6/4qw8Yyc5EHtrT4/gFylU1
         9QHOTqyYD5w+XTG1uqls1Fi7QAXNy3HD7iLDB9Nqi0L0HcPN7mWIcD2UnifQm39korJ+
         dJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792122496; x=1792727296;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cHwmVcL3Ea2QJiHo6JwLvdH2j4OcK78NhenhdrCZCWk=;
        b=cFLbPDbkvznMaHWDiTqPxyuIHQ0dwu/fRLbuzuQ7lG0zr5MuEueUhzgAaQ7gHgUblm
         PgyeI0i3Ggo3a41UAocMFX1NrsGFIHfrtwFvwdxZVNAan2LPBqHmpC/o9jb8+HNpd5LF
         i1nN+oq3lgZS2m3I/6Wf+MLwxPBgM516U/3huFfAm22zF3apFP7Y4O3SsmLwBpP0w7oc
         daQ8bj5Rjkmp5l/+VweGzAjdfblRK/Utx1ASkoq2DL8qqcqqeXSAyl36DyAqI8IcZOoy
         mJ1nBBvSAzlBUOY6FaSYElCs/LOunJT1orWm7bTPDGHYaM+DQtAX6u8DGLZUb1d1kdUm
         UIyg==
X-Forwarded-Encrypted: i=1; AKwUvBwRDNwh/xfdpbF1EF+v5jEnBIhiYirKMhyy1SIRm9X+JNGkm1hB83UVgxIpa55NLqUNLz4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/RUeuhINrfCXoRTYOURB7M2RqNtYP8dSGXzJEw9C8sDL6x1A/
	BS6CSOMF2zDp6jwbLl1R/FKgBUSYGjtl6u8dsOyDND8E9iRcfpSARDfOBRTa9HmIYvfGD5Hdzh7
	ebKoR2Zaipqe1k1n1Zmm8Ks0XF5yYO3aCyYqDemqG
X-Gm-Gg: AYBFou1F5/W0mWeA1KAHyReZCfahEqnJbJHR1BsDQx60mSW0K9jEoRi2GRIUQdOSuht
	0cZzFBOQS99ussUrnEwH5nT/LUBR/C2OQ+GaYqmfmsVS1Dpkuud+B1EKbJZZCeg3izJvrK19SiC
	sDOkjzaqMIA25FPdbEIWcw7veSVh7LX8bvyomcYXgSN2yfKMYMjB59Ux3UjSuGd34ZyUCCaLW7A
	iR75wPCTIQPq7cb0iZzCy+QkPTPD9lDstawN8QbNYmKydLPUxH1EkB02bxTfBlRZJe1sbKENx3c
	u3EwOerhB7ZnPFBR/ggUFK4eJKbq5GDVflm1/W3CbmLK1t+QaJOH3w==
X-Received: by 2002:a05:6402:a6c6:20b0:6b1:aa31:a627 with SMTP id
 4fb4d7f45d1cf-6b38ba0dfd0mr16268a12.4.1792122495231; Thu, 15 Oct 2026
 20:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014173945.373295-4-almasrymina@google.com> <179209666051.434549.2929683677785392178@kernel.org>
In-Reply-To: <179209666051.434549.2929683677785392178@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 15 Oct 2026 20:48:03 -0700
X-Gm-Features: AclHuK82vYjG9iaKBiwqWzObGCIoi3MxPyudlxUnlS3qJQCEAcDwsenVdF71kak
Message-ID: <CAHS8izPxoA6fU10fSNzKkZHFrWingOgduWOoD7ywii2058GABQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/6] net: skbuff: replace skb_page_unref() and
 __skb_frag_unref() with skb_netmem_unref()
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, ayush.sawal@chelsio.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, tariqt@nvidia.com, horms@kernel.org, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	ncardwell@google.com, kuniyu@google.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, ebiggers@kernel.org, kees@kernel.org, 
	aleksandr.loktionov@intel.com, petrm@nvidia.com, u.kleine-koenig@baylibre.com, 
	j.raczynski@samsung.com, wang.zhan@smartx.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:37=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] This commit fixes a real refcount imbalance in
>   mlx4_en_complete_rx_desc()=E2=80=A6
> - [Low] The commit message describes the mlx4 RX error-path bug as
>   "underflowing the page refcount".
> - [Low] At this commit, the new kernel-doc in include/linux/skbuff_ref.h
>   names ref-side counterparts that do not match the code.
>

If it's OK with folks I'll just ignore low comments. Even if I
reworded the commit messages, the bot will find some other complaint
about how the commit message is worded I think.

--=20
Thanks,
Mina
