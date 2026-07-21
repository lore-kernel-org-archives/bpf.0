Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6F1145B27
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784659217; cv=none; b=S8bRuqU8oEJTZBU3RkLjzQqROhA+y7YoBDf4Q0XcAFLo8PrHq3j+s1JCwXzqKa1v6m1j0gOeQwEHSresgqyeZkFw67iCwVgbuhrMixZAOus8b163vRSxs/ZcmD2BGUhx4A/8Nz1dAe1/Q5y3H1rPeJElviqo7IDoejbBuflDH38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784659217; c=relaxed/simple;
	bh=CEHCZS1G5Y42WECDRP5LrS/sZ+WH6FFxldqOA5Qzf7I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MqoXqdg/5vpVHFGAB0O/RPz5BQSUoU9fclGo+fVJQqjgOeM2vgq/fw+ZQBw/mDHo0tXNzBmN98PRKse2hHEoTWfcIb5vajaWTxFYlOiNsnBd55U/gLbVMRPpsz0pd/cK2qxji1zLdgT6P0kklwjHp3b53b9EBUVQhgoXCdWxK9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Fr64NkhM; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Fr64NkhM"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so7363514a12.2
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 11:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784659215; x=1785264015; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cXucJmocQuo7Hb1xWA0bWNA+TKY00q86yxvGHTwRRPk=;
        b=Fr64NkhMoJMMVvlMYStpTVWCclhBPjmZGPycE5u+wPtY07dNfse1DPw0kwUq9qdSIF
         2intzA52oAh2E71QRXUunVed3p5JLGYsRL4x+nFeyqirW3kiXFNH0hyycViTA6DQ40tL
         QmOr5d2zwY2rBF0DC+MYLN4fGqyoYO9HueAvJOAJ4cTW/gx4aB5Rb6hSqyX/blayTWMU
         FlY3FzZTYKy5C4n71zd9hQEiZzpj1TbKD6sa8steFvSMCoNTKj7Q4dPpHgx/NEabli3+
         TKxa3gyBr68sAHHB46bNh/vowck9HYNTMvQsWVQd6i5b3OP4kDGx4a5fwst/H4DuEeIs
         xWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784659215; x=1785264015;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cXucJmocQuo7Hb1xWA0bWNA+TKY00q86yxvGHTwRRPk=;
        b=AqV0dVJTMcsCHPIxIb5PTMm9sWEVa/rFGGmAlpAXgc98ine5zkrR/SqHGl4ITEA5Nj
         BYR6AFXJE8LAeHGslzWlg1q8jIzJM/Hj8p/8d7WyNLK7K4YiF4OGdk8kJkOXsr9CPYWu
         4RzPyfAzk26d8lI3EJs1pLvptOSbMoYi6dNeBgtLMPll2r/ehD7lAJn8hDgWT6mAmpb6
         SmN8fVRuPjfMMdAZn2aZRetr9KjOXbn6Dfzh9JUDf1I2BW1zETVImU4mc69SWja3fuOA
         Z9uKnHMutt7Ue0qP2K8zchJXF/wYebkgpsFBfjhsG3gzxSD1nhJmXsBbvPpSYwMzC8Ih
         2+xg==
X-Forwarded-Encrypted: i=1; AHgh+RqDUceNDJ3srzjbDGI6vJSFn4s/Fwc4W3GA/nuC1T+L3DtHfmwGEv/QPFoX7lHa30ZYaQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWZFcwPADielfh0/uE68xAqQS01aQgRkiLZhRjdnD57JJu9BSb
	TpzoH+2eXTtOvY70nr5vXG7DfpBPDcg3o0fy6nyxLxCmAFoIPYpNk2SZ9bGa5Wh/5GI=
X-Gm-Gg: AR+sD10bm3xhLPb7zLt5pkwcRyNHvfpCeSDHBDPLZ9SBRVEO6JbcKUWCOE+Yp6uMLx8
	GviR8I26Qce+89EA6Tt+cNI578RIoSU5i6yEegoQ/pxFz0fU0BH3n+0AVwnTUwk3ux70Qjl6jOF
	kyyPh86mmid9qBEaVddnIiNd2Gm7rQtMglFHOrNm5GaLO8YJnDVNG5DWgUEzgf2/Y4VZ87oVYuX
	Cot2nheRIO9AARgsYqXTzE45QR/xjRYHSEzFcX3VFNfXlsN/5cjLYjO4s5Wgks8bGKagX2OiF7p
	S/Ng/5hASst7pbuoLyb1CXKibnEv6qN+mcjuGIWjWSmcUObT1jOO44WyGiPC+gQoRnyWur5F4iW
	dowDKXPrYmw9P8EBt9Ivs9dkZTfd1weDAbJBp0blsumMfQZYtU2mG1LG5E3I=
X-Received: by 2002:a05:6a20:2583:b0:3c3:9595:57ef with SMTP id adf61e73a8af0-3c3ad7781b3mr18749954637.31.1784659215324;
        Tue, 21 Jul 2026 11:40:15 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::4a7b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2a129f3sm39641494c88.7.2026.07.21.11.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 11:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 14:40:13 -0400
Message-Id: <DK4GW4BH8RPS.32N0A91SQGMOH@etsalapatis.com>
Cc: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v5 2/4] bpf: Fix UAF due to missing link type check
 in mprog
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, "Pu Lehui" <pulehui@huaweicloud.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260721041048.1394085-1-pulehui@huaweicloud.com>
 <20260721041048.1394085-3-pulehui@huaweicloud.com>
 <20260721042151.E6F941F000E9@smtp.kernel.org>
 <723495f2-f4a0-4723-90a8-d4774e6dce05@huaweicloud.com>
 <CAMB2axMocV3+cC8O5LEu-0bPcGvchwjASbjM_afx=Stc_8AvKw@mail.gmail.com>
In-Reply-To: <CAMB2axMocV3+cC8O5LEu-0bPcGvchwjASbjM_afx=Stc_8AvKw@mail.gmail.com>

On Tue Jul 21, 2026 at 1:40 PM EDT, Amery Hung wrote:
> On Tue, Jul 21, 2026 at 2:18=E2=80=AFAM Pu Lehui <pulehui@huaweicloud.com=
> wrote:
>>
>>
>> On 2026/7/21 12:21, sashiko-bot@kernel.org wrote:
>> > Thank you for your contribution! Sashiko AI review found 1 potential i=
ssue(s) to consider:
>> > - [Medium] Anchor link type validation is bypassed when attaching or d=
etaching bare BPF programs, leading to wildcard insertions/deletions and da=
ta races.
>> > --
>> >
>> > --- Patch [2]: [PATCH bpf v5 2/4] bpf: Fix UAF due to missing link typ=
e check in mprog ---
>> > commit 830a4e62ebb8e98cc45b0ce829c6686aacafabc4
>> > Author: Pu Lehui <pulehui@huawei.com>
>> > Subject: bpf: Fix UAF due to missing link type check in mprog
>> >
>> > This commit adds a link type validation in bpf_mprog_link() to prevent=
 a
>> > use-after-free when dereferencing link->prog for foreign anchors. It a=
lso
>> > adjusts bpf_mprog_attach() and bpf_mprog_detach() to pass down the exp=
ected
>> > link type.
>> >
>> >> diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
>> >> index 1394168062e85..37ce91e0bcd21 100644
>> >> --- a/kernel/bpf/mprog.c
>> >> +++ b/kernel/bpf/mprog.c
>> >> @@ -17,7 +17,7 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
>> >>              link =3D bpf_link_get_from_fd(id_or_fd);
>> >>      if (IS_ERR(link))
>> >>              return PTR_ERR(link);
>> >> -    if (type && link->prog->type !=3D type) {
>> >> +    if (type && link->type !=3D type) {
>> >>              bpf_link_put(link);
>> >>              return -EINVAL;
>> >>      }
>> >
>> > [ ... ]
>> >
>> >> @@ -243,6 +244,7 @@ int bpf_mprog_attach(struct bpf_mprog_entry *entr=
y,
>> >>              return -EEXIST;
>> >>      ret =3D bpf_mprog_tuple_relative(&rtuple, id_or_fd,
>> >>                                     flags & ~BPF_F_REPLACE,
>> >> +                                   link ? link->type : BPF_LINK_TYPE=
_UNSPEC,
>> >>                                     prog_new->type);
>> >>      if (ret)
>> >
>> > [Severity: Medium]
>> > When attaching a bare BPF program, link is NULL. This passes
>> > BPF_LINK_TYPE_UNSPEC (0) to bpf_mprog_tuple_relative() as the expected
>> > anchor link type.
>>
>> Ah, so when attaching a bare prog with a relative link, having the
>> BPF_F_LINK flag set means the relative id_or_fd is a link, not the
>> object being attached. Sorry, that definitely confused me.
>>
>> >
>> > In bpf_mprog_link() above, the validation check is:
>> >
>> >      if (type && link->type !=3D type) {
>> >
>> > Because type is 0, the validation is bypassed entirely.
>> >
>> > If a user passes a foreign link with a NULL prog (like struct_ops) as =
an
>> > anchor via id_or_fd, the positioning logic treats tuple->prog =3D=3D N=
ULL as
>> > 'no anchor provided' instead of rejecting the invalid anchor with -EIN=
VAL.
>> >
>> > Does this allow wildcard insertions or deletions, and leave a benign d=
ata
>> > race when reading link->prog locklessly? Should the expected link type=
 be
>> > explicitly provided when attaching bare programs?
>
> I also overlooked this. Make sense to pass the expected link type from
> callers of bpf_mprog_attach().

+1 on this, and can we add a comment that ptype =3D=3D UNSPEC is because
detach() uses this as a wildcard? UNSPEC is only valid in very few
places in the subsystem.

>
>> >
>> > [ ... ]
>> >
>> >> @@ -343,6 +345,7 @@ int bpf_mprog_detach(struct bpf_mprog_entry *entr=
y,
>> >>      if (!bpf_mprog_total(entry))
>> >>              return -ENOENT;
>> >>      ret =3D bpf_mprog_tuple_relative(&rtuple, id_or_fd, flags,
>> >> +                                   link ? link->type : BPF_LINK_TYPE=
_UNSPEC,
>> >>                                     prog ? prog->type :
>> >>                                     BPF_PROG_TYPE_UNSPEC);
>> >>      if (ret)
>> >
>> > [Severity: Medium]
>> > Similarly, when detaching a bare BPF program, link is NULL. This also
>> > passes BPF_LINK_TYPE_UNSPEC as the expected link type.
>> >
>> > Does this bypass the new validation and allow wildcard deletions when =
using
>> > foreign anchors?
>> >
>>
>>

