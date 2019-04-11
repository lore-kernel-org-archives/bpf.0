Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ADFC10F14
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 06:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E164E20873
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 06:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="VkhJMtxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfDKGNG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:13:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40354 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDKGNG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 02:13:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so5061122wmi.5
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 23:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hDlO42+nLmICYgkS/lSem/0BPeYxj0ZBCVBDO66+h/0=;
        b=VkhJMtxL4fhGaQxvW//fwQo2BHZh53/x0TfWtvQkIPbHlWMRvDtDKPHGp1XibIff+x
         PmylHPXL/Efubf+1hacD9UxGh56OLM7nTes8V01nFCNNSJKSUSOOW6DvLbSB5Egeslpy
         finpvf9Z+H4bS0Ho7jYv96zMpPVho3KtVxv8p5FO8nF+tGsH2AzJMMqoG7ujF3W7LAOP
         LS9JuPrr2b+VFVKPq+z30HxBMEszL9OEA7J+HJj203ZpdVWXbicm0ZnxUOCoOgoTG4IH
         pozzXlriAQdHz7hf+wultuUDOfeyleZaKEnQpVBADEm1xctO3XCexd98Vx6U/k2HHjpw
         LzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hDlO42+nLmICYgkS/lSem/0BPeYxj0ZBCVBDO66+h/0=;
        b=EMx8qd9uiE1xrUeYirh20cc3MS3/lZ0vYKX9mgIZxgc93ZihX4aL6oINSZv70b9ui4
         qTH0XDibWG+wTKDyJgmlmyVoLdNzvjodUik4RggjpmO5htR4vF4j8RPz+yuhixrf3eRJ
         hNoAM1WhmeEXKf8mnZEV+c0/q4WV0qUDwwMzkBiI4iRODkLeOGb/a0oUhwRXhMWSCCi1
         14aiIbP63bebOpb0BokqF5PRNjbLhmIBei3IhkNcTsrcy7/JI+QMalaUkhxXUG2+7C3s
         MO1FlG7naI+0nrmArsteS8i2utCRKspnu4BkzJ2F3fFVtxYVZzfulB49XYzs085JkkQB
         oZpw==
X-Gm-Message-State: APjAAAXt3UjUVicOpVFg6GrbzA71+OURlbwU+TkQfRDkb8svvT6bJADq
        fyqIXAxwHMNob+FgJAA1+Q0Jvg==
X-Google-Smtp-Source: APXvYqyFczMF9JXbCusfH2V2imXDGy2R9fta9AJ6nqEk3ZnKWj6Xq70g1W8s2aG9w4pSfesiduUYkg==
X-Received: by 2002:a7b:c304:: with SMTP id k4mr5525581wmj.22.1554963184188;
        Wed, 10 Apr 2019 23:13:04 -0700 (PDT)
Received: from [192.168.0.23] (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id s10sm5915466wmh.0.2019.04.10.23.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 23:13:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH/RFC v2 bpf-next 05/19] bpf: split read liveness into
 REG_LIVE_READ64 and REG_LIVE_READ32
From:   Jiong Wang <jiong.wang@netronome.com>
In-Reply-To: <20190410195218.303d4a6c@cakuba.netronome.com>
Date:   Thu, 11 Apr 2019 07:13:03 +0100
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <3A9F4205-577C-4E64-8400-0D476F08459E@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
 <1554925833-7333-6-git-send-email-jiong.wang@netronome.com>
 <20190410195218.303d4a6c@cakuba.netronome.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
X-Mailer: Apple Mail (2.3273)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 11 Apr 2019, at 03:52, Jakub Kicinski =
<jakub.kicinski@netronome.com> wrote:
>=20
> On Wed, 10 Apr 2019 20:50:19 +0100, Jiong Wang wrote:
>> Register liveness infrastructure doesn't track register read width at =
the
>> moment, while the width information will be needed for the later =
32-bit
>> safety analysis pass.
>>=20
>> This patch take the first step to split read liveness into =
REG_LIVE_READ64
>> and REG_LIVE_READ32.
>>=20
>> Liveness propagation code are updated accordingly. They are taught to
>> understand how to propagate REG_LIVE_READ64 and REG_LIVE_READ32 at =
the same
>> propagation iteration. For example, "mark_reg_read" now propagate =
"flags"
>> which could be multiple read bits instead of the single =
REG_LIVE_READ64.
>>=20
>> A write still screen off all width of reads.
>>=20
>> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
>> ---
>> include/linux/bpf_verifier.h |   8 +--
>> kernel/bpf/verifier.c        | 119 =
+++++++++++++++++++++++++++++++++++++++----
>> 2 files changed, 113 insertions(+), 14 deletions(-)
>>=20
>> diff --git a/include/linux/bpf_verifier.h =
b/include/linux/bpf_verifier.h
>> index b3ab61f..fba0ebb 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -36,9 +36,11 @@
>>  */
>> enum bpf_reg_liveness {
>> 	REG_LIVE_NONE =3D 0, /* reg hasn't been read or written this =
branch */
>> -	REG_LIVE_READ, /* reg was read, so we're sensitive to initial =
value */
>> -	REG_LIVE_WRITTEN, /* reg was written first, screening off later =
reads */
>> -	REG_LIVE_DONE =3D 4, /* liveness won't be updating this register =
anymore */
>> +	REG_LIVE_READ32 =3D 0x1, /* reg was read, so we're sensitive to =
initial value */
>> +	REG_LIVE_READ64 =3D 0x2, /* likewise, but full 64-bit content =
matters */
>> +	REG_LIVE_READ =3D REG_LIVE_READ32 | REG_LIVE_READ64,
>> +	REG_LIVE_WRITTEN =3D 0x4, /* reg was written first, screening =
off later reads */
>> +	REG_LIVE_DONE =3D 0x8, /* liveness won't be updating this =
register anymore */
>> };
>>=20
>> struct bpf_reg_state {
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index bd30a65..44e4278 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -1135,7 +1135,7 @@ static int check_subprogs(struct =
bpf_verifier_env *env)
>>  */
>> static int mark_reg_read(struct bpf_verifier_env *env,
>> 			 const struct bpf_reg_state *state,
>> -			 struct bpf_reg_state *parent)
>> +			 struct bpf_reg_state *parent, u8 flags)
>> {
>> 	bool writes =3D parent =3D=3D state->parent; /* Observe write =
marks */
>> 	int cnt =3D 0;
>> @@ -1150,17 +1150,17 @@ static int mark_reg_read(struct =
bpf_verifier_env *env,
>> 				parent->var_off.value, parent->off);
>> 			return -EFAULT;
>> 		}
>> -		if (parent->live & REG_LIVE_READ)
>> +		if ((parent->live & REG_LIVE_READ) =3D=3D flags)
>> 			/* The parentage chain never changes and
>> -			 * this parent was already marked as LIVE_READ.
>> +			 * this parent was already marked with all read =
bits.
>=20
> Do we have to propagate all read bits?  Read64 is strictly stronger
> than read32, as long as read64 is set on the parent we should be good?

We should be good, but I doubt there is value to differentiate on this =
in this
kind of HOT function.
=20
>=20
>> 			 * There is no need to keep walking the chain =
again and
>> -			 * keep re-marking all parents as LIVE_READ.
>> +			 * keep re-marking all parents with reads bits =
in flags.
>> 			 * This case happens when the same register is =
read
>> 			 * multiple times without writes into it =
in-between.
>> 			 */
>> 			break;
>> 		/* ... then we depend on parent's value */
>> -		parent->live |=3D REG_LIVE_READ;
>> +		parent->live |=3D flags;
>> 		state =3D parent;
>> 		parent =3D state->parent;
>> 		writes =3D true;
>=20
>> @@ -6196,12 +6286,19 @@ static int propagate_liveness_reg(struct =
bpf_verifier_env *env,
>> 				  struct bpf_reg_state *reg,
>> 				  struct bpf_reg_state *parent_reg)
>> {
>> +	u8 parent_bits =3D parent_reg->live & REG_LIVE_READ;
>> +	u8 bits =3D reg->live & REG_LIVE_READ;
>> +	u8 bits_diff =3D parent_bits ^ bits;
>> +	u8 bits_prop =3D bits_diff & bits;
>> 	int err;
>>=20
>> -	if (parent_reg->live & REG_LIVE_READ || !(reg->live & =
REG_LIVE_READ))
>> +	/* "reg" and "parent_reg" has the same read bits, or the bit =
doesn't
>> +	 * belong to "reg".
>> +	 */
>> +	if (!bits_diff || !bits_prop)
>=20
> bits_prop is a subset of bits_diff, no?  !bits_prop is always true
> if !bits_diff is true, no need to check both.

Bits_prop is a subset of bits_diff WHEN it comes from =E2=80=9Creg", we =
don=E2=80=99t want to
do the propagation when the diff comes from =E2=80=9Cparent_reg=E2=80=9D, =
so, we need to check
both.

Regards,
Jiong
=20
>=20
>> 		return 0;
>>=20
>> -	err =3D mark_reg_read(env, reg, parent_reg);
>> +	err =3D mark_reg_read(env, reg, parent_reg, bits_prop);
>> 	if (err)
>> 		return err;

