Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A292C10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 17:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D81E20693
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 17:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="DVmlB/dD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfDKRWS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:22:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36240 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfDKRWR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 13:22:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so8415251wrd.3
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2019 10:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=75IrDBHz2Eg4TUIshPKuQX4kkcUDWaCjt7/qTQ2bhyY=;
        b=DVmlB/dD4elN40yTOjGrJ3NXH6Pl79Ml0/qEHmFED04fw/zPGKBrAso3dDi3HQ9+hX
         DiGxJcmmTGesnbNMBkFFRvfqyBX4tw59Xlys3qzSZqZc4eQPCR/KvgJUNjSX3jF62+tk
         1jF3JLIYeqSY1QeYiCskdZOA/lU7VuNsmECBihRG/ZIqf+QyBy1S2RoixAze20SM7oOa
         iPOpAze6deyX8tieu5TLibwzzt4pMK346Uirws1s20jH7C+CT0Z3P5veq/wIvD6MNPZB
         5nszdvnytUdGcPsax5l6BYwd812B+vXkrYk9N7IU+kNTWGYTdHxHQtHmA5XaOhxPBTVk
         2I3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=75IrDBHz2Eg4TUIshPKuQX4kkcUDWaCjt7/qTQ2bhyY=;
        b=lP6/FMK9lsUot2FyXBP2YBkvt7kWo1wwp7K8sjRIY5RJUR7oCubBt7/ZestEiEVOmY
         mO3pexNXpjwyfRRH0BGJaG16YDCDJzYbptxJOrwJg773c+njLbCuATppPIeBDsmQEHUI
         S7qqz4W1iLNSxptkiiNvIOYMsvS61nRYAaceZW9+f0tvQKc4qsDq332bFWV0/OmhcVDY
         0WeiHq8Nn/bLiQdW5X3RJImIcWR5UCaN5NK4ZbFKY878l8+E88dn5L6E+FHEvC4Zqj/0
         7nXZM+QFq8TbpSOJJY6RECHY3xX42+0YWKcKZQPVyciL296vWCdZ39lIVGwojM6YVwPh
         /cYQ==
X-Gm-Message-State: APjAAAUQYwQh146XDIYqRUAWipbg+srGJjxzLswbFDTVl6EcxhfQZjYk
        Ol2vKx9Va2GHTj4wE7T+Y8RiPxgeaxU=
X-Google-Smtp-Source: APXvYqyZJEW86fS1AWamQwGnPsYSxpeGQ3zYL9n3ennD50iIvftWjqxoWAMjEH228V275QaptgdgQg==
X-Received: by 2002:adf:e648:: with SMTP id b8mr31604955wrn.132.1555003336384;
        Thu, 11 Apr 2019 10:22:16 -0700 (PDT)
Received: from [192.168.0.23] (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id r30sm124834372wrr.46.2019.04.11.10.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 10:22:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [oss-drivers] Re: [PATCH/RFC v2 bpf-next 05/19] bpf: split read
 liveness into REG_LIVE_READ64 and REG_LIVE_READ32
From:   Jiong Wang <jiong.wang@netronome.com>
In-Reply-To: <20190411094456.1fabc52d@cakuba.netronome.com>
Date:   Thu, 11 Apr 2019 18:22:16 +0100
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <70F0E85E-B8B3-49AB-ACA7-906A9D529240@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
 <1554925833-7333-6-git-send-email-jiong.wang@netronome.com>
 <20190410195218.303d4a6c@cakuba.netronome.com>
 <3A9F4205-577C-4E64-8400-0D476F08459E@netronome.com>
 <20190411094456.1fabc52d@cakuba.netronome.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
X-Mailer: Apple Mail (2.3273)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 11 Apr 2019, at 17:44, Jakub Kicinski =
<jakub.kicinski@netronome.com> wrote:
>=20
> On Thu, 11 Apr 2019 07:13:03 +0100, Jiong Wang wrote:
>>>> @@ -1150,17 +1150,17 @@ static int mark_reg_read(struct =
bpf_verifier_env *env,
>>>> 				parent->var_off.value, parent->off);
>>>> 			return -EFAULT;
>>>> 		}
>>>> -		if (parent->live & REG_LIVE_READ)
>>>> +		if ((parent->live & REG_LIVE_READ) =3D=3D flags)
>>>> 			/* The parentage chain never changes and
>>>> -			 * this parent was already marked as LIVE_READ.
>>>> +			 * this parent was already marked with all read =
bits. =20
>>>=20
>>> Do we have to propagate all read bits?  Read64 is strictly stronger
>>> than read32, as long as read64 is set on the parent we should be =
good? =20
>>=20
>> We should be good, but I doubt there is value to differentiate on =
this in this
>> kind of HOT function.
>=20
> The entire if clause is an optimization.  I'm saying you can maintain =
it
> as more aggressive.
>=20
>>>> @@ -6196,12 +6286,19 @@ static int propagate_liveness_reg(struct =
bpf_verifier_env *env,
>>>> 				  struct bpf_reg_state *reg,
>>>> 				  struct bpf_reg_state *parent_reg)
>>>> {
>>>> +	u8 parent_bits =3D parent_reg->live & REG_LIVE_READ;
>>>> +	u8 bits =3D reg->live & REG_LIVE_READ;
>>>> +	u8 bits_diff =3D parent_bits ^ bits;
>>>> +	u8 bits_prop =3D bits_diff & bits;
>>>> 	int err;
>>>>=20
>>>> -	if (parent_reg->live & REG_LIVE_READ || !(reg->live & =
REG_LIVE_READ))
>>>> +	/* "reg" and "parent_reg" has the same read bits, or the bit =
doesn't
>>>> +	 * belong to "reg".
>>>> +	 */
>>>> +	if (!bits_diff || !bits_prop) =20
>>>=20
>>> bits_prop is a subset of bits_diff, no?  !bits_prop is always true
>>> if !bits_diff is true, no need to check both. =20
>>=20
>> Bits_prop is a subset of bits_diff WHEN it comes from =E2=80=9Creg", =
we don=E2=80=99t want to
>> do the propagation when the diff comes from =E2=80=9Cparent_reg=E2=80=9D=
, so, we need to check
>> both.
>=20
> Not sure what you're saying, in this patch:
>=20
> 	u8 bits_prop =3D bits_diff & bits;
>=20
> Maybe you're talking about some patch down the line..

Ack, indeed, !bits_prop is always true if !bits_diff is true, will =
remove the
redundant check.

Thanks,
Regards,
Jiong

