Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4178C43381
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 16:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81AB2075C
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 16:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="J8xBhtdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfC0QoQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:44:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39137 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfC0QoQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Mar 2019 12:44:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id t124so790625wma.4
        for <bpf@vger.kernel.org>; Wed, 27 Mar 2019 09:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ttvMWRHWqGPyoAU2t8qpTsexY1aie3oQ/MODXcb9W/o=;
        b=J8xBhtdvlBlj6VViUjEU2Myma39zIRyJ2r3h52EiidgNegp5nLRud2JxtIpJirVQgR
         kCr4ZxtOWvwPrroGSveT8HqLQyuKYm1ZpPaFKdQV7nDJ00dEIzh2T3MR6/t5tu9VwTji
         Xzkvx+sv5w84MH8/0BIJixTcySo2Zvd3hY46zhN3hxroIQKvDjsvoOtvAm82WcvrAH2A
         /z1gyoj/txOZjd/q4EmcQL167QqWJZfAH/YObjQbIFj2En2JauIWeaD5Vib0E+14/9i7
         yHUncvF6rlOhSO8cBg+SDkgE8bNB7ybuqm5hVejrA0ar5yIdfoiUgDnn1XpElSYolZ5y
         h32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ttvMWRHWqGPyoAU2t8qpTsexY1aie3oQ/MODXcb9W/o=;
        b=EgN1I8bI8FKdxGWF80eQ3uDAtqyNFkye6G/rXrgUMp4duaGxvgKFqVrcs6Crg23iC0
         Sdvj/lgFSb/GTI1MLcRl+CT1tVZXgLF7Vx4rzkFQig0jAMMllaISag6PJ0jqw/OkPdrZ
         P4lWCvEStkt6jbsuEdIcZV4qjlJBdbm7V7PEBf//lgMC9ixYVthEZ51XWGPcOnlC3lxG
         3Bh+ZJ3Jz4J/cpZjU5sL4ZLAgeV4DlIXq5hstgsC5EYTJGkFz7jGL29YEeMC/LaDg13J
         9nHP3BZrlpsxRS/ehr8RS5BGMWwzH/XfXwVobwVTG/67L7P2q2kFnFU1TrRBex69hs6Y
         70Qg==
X-Gm-Message-State: APjAAAXAhpOqCZb+IxDT47f9hfXvXRPJW/MIwyIbO2laZH2M0Y/6D2XL
        GQ3VjfiIPKVCaIrQQg722MPBrw==
X-Google-Smtp-Source: APXvYqxmLGWg6axLjQzGTWUqPALQiQWVgszwrUNyxCKuuem/5EBMidUZj3UVed+bc8c5OCCOJs0FEg==
X-Received: by 2002:a1c:80cd:: with SMTP id b196mr13018564wmd.84.1553705053340;
        Wed, 27 Mar 2019 09:44:13 -0700 (PDT)
Received: from [172.20.1.229] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id a17sm247009wmg.40.2019.03.27.09.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 09:44:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH/RFC bpf-next 02/16] bpf: refactor propagate_live
 implementation
From:   Jiong Wang <jiong.wang@netronome.com>
In-Reply-To: <20190327163504.7ueecpetrwohkbmd@ast-mbp>
Date:   Wed, 27 Mar 2019 16:44:11 +0000
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7316286B-2586-4C96-8148-4E47C7792C1E@netronome.com>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
 <1553623539-15474-3-git-send-email-jiong.wang@netronome.com>
 <20190327163504.7ueecpetrwohkbmd@ast-mbp>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 27 Mar 2019, at 16:35, Alexei Starovoitov =
<alexei.starovoitov@gmail.com> wrote:
>=20
> On Tue, Mar 26, 2019 at 06:05:25PM +0000, Jiong Wang wrote:
>> Some code inside current implementation of "propagate_liveness" is a =
little
>> bit verbose.
>>=20
>> This patch refactor them so the code looks more simple and more =
clear.
>>=20
>> The redundant usage of "vparent->frame[vstate->curframe]" is removed =
as we
>> are here. It is safe to do this because "state_equal" has guaranteed =
that
>> vstate->curframe must be equal with vparent->curframe.
>>=20
>> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
>> ---
>> kernel/bpf/verifier.c | 44 =
++++++++++++++++++++++++++++++--------------
>> 1 file changed, 30 insertions(+), 14 deletions(-)
>>=20
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 6cc8c38..245bb3c 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -6050,6 +6050,22 @@ static bool states_equal(struct =
bpf_verifier_env *env,
>> 	return true;
>> }
>>=20
>> +static int propagate_liveness_reg(struct bpf_verifier_env *env,
>> +				  struct bpf_reg_state *reg,
>> +				  struct bpf_reg_state *parent_reg, u8 =
flag)
>> +{
>> +	int err;
>> +
>> +	if (parent_reg->live & flag || !(reg->live & flag))
>> +		return 0;
>> +
>> +	err =3D mark_reg_read(env, reg, parent_reg);
>> +	if (err)
>> +		return err;
>> +
>> +	return 1;
>> +}
>=20
> what is the difference between 1 and 0 ? it doesn't seem to be used.

0 means no propagation has been done. 1 means propagation has been done.

They are used later in patch 4. If there is propagation, then will =
trigger
insn marking.

Will add comment for this.


>=20
>> +
>> /* A write screens off any subsequent reads; but write marks come =
from the
>>  * straight-line code between a state and its parent.  When we arrive =
at an
>>  * equivalent state (jump target or such) we didn't arrive by the =
straight-line
>> @@ -6061,8 +6077,9 @@ static int propagate_liveness(struct =
bpf_verifier_env *env,
>> 			      const struct bpf_verifier_state *vstate,
>> 			      struct bpf_verifier_state *vparent)
>> {
>> -	int i, frame, err =3D 0;
>> +	struct bpf_reg_state *regs, *parent_regs;
>> 	struct bpf_func_state *state, *parent;
>> +	int i, frame, err =3D 0;
>>=20
>> 	if (vparent->curframe !=3D vstate->curframe) {
>> 		WARN(1, "propagate_live: parent frame %d current frame =
%d\n",
>> @@ -6071,16 +6088,13 @@ static int propagate_liveness(struct =
bpf_verifier_env *env,
>> 	}
>> 	/* Propagate read liveness of registers... */
>> 	BUILD_BUG_ON(BPF_REG_FP + 1 !=3D MAX_BPF_REG);
>> +	parent_regs =3D vparent->frame[vparent->curframe]->regs;
>> +	regs =3D vstate->frame[vstate->curframe]->regs;
>=20
>=20
> may be do:
> frame =3D vstate->curframe;
> if (vparent->curframe !=3D frame) { WARN...
> parent_regs =3D vparent->frame[frame]->regs;
> regs =3D vstate->frame[frame]->regs;
>=20
> ?

Ack, will factor out "vstate->curframe=E2=80=9D into =E2=80=9Cframe=E2=80=9D=
.
=20
And there is a check and warning on the equality already, just several =
lines above:

   if (vparent->curframe !=3D vstate->curframe) {                        =
    =20
     WARN(1, "propagate_live: parent frame %d current frame %d\n",

Regards,
Jiong
=20
>=20
>> 	/* We don't need to worry about FP liveness because it's =
read-only */
>> 	for (i =3D 0; i < BPF_REG_FP; i++) {
>> -		if (vparent->frame[vparent->curframe]->regs[i].live & =
REG_LIVE_READ)
>> -			continue;
>> -		if (vstate->frame[vstate->curframe]->regs[i].live & =
REG_LIVE_READ) {
>> -			err =3D mark_reg_read(env, =
&vstate->frame[vstate->curframe]->regs[i],
>> -					    =
&vparent->frame[vstate->curframe]->regs[i]);
>> -			if (err)
>> -				return err;
>> -		}
>> +		err =3D propagate_liveness_reg(env, &regs[i], =
&parent_regs[i]);
>> +		if (err < 0)
>> +			return err;
>> 	}
>>=20
>> 	/* ... and stack slots */
>> @@ -6089,11 +6103,13 @@ static int propagate_liveness(struct =
bpf_verifier_env *env,
>> 		parent =3D vparent->frame[frame];
>> 		for (i =3D 0; i < state->allocated_stack / BPF_REG_SIZE =
&&
>> 			    i < parent->allocated_stack / BPF_REG_SIZE; =
i++) {
>> -			if (parent->stack[i].spilled_ptr.live & =
REG_LIVE_READ)
>> -				continue;
>> -			if (state->stack[i].spilled_ptr.live & =
REG_LIVE_READ)
>> -				mark_reg_read(env, =
&state->stack[i].spilled_ptr,
>> -					      =
&parent->stack[i].spilled_ptr);
>> +			struct bpf_reg_state *parent_reg, *reg;
>> +
>> +			parent_reg =3D &parent->stack[i].spilled_ptr;
>> +			reg =3D &state->stack[i].spilled_ptr;
>> +			err =3D propagate_liveness_reg(env, reg, =
parent_reg);
>> +			if (err < 0)
>> +				return err;
>> 		}
>> 	}
>> 	return err;
>> --=20
>> 2.7.4
>>=20

