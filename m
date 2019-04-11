Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94848C10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 16:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599A72133D
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 16:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="k056Z0DP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfDKQxa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:53:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52368 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfDKQx3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 12:53:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id a184so7608611wma.2
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2019 09:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wfDrDROTvjACr08Dm+67uQv3MomG9SwdFcYtNDNZrDc=;
        b=k056Z0DPNUfZFJxrOjQSYcXTK+aWj5psGJQl9GI6rkZi/CUAcRaEwZBfai/A84Ja26
         X/src9T/gEmNRlCvtqzczI7o+OvvwqxHh2olQgqCGH7Q4zthPsHKhdO3ENI66l7a/Oul
         kLzwPt2J0gbIt1dVqw/smVfGTeBc7a1u/TGraketjVbyqMaeXqk/a0F7Ll0QGVDDrTcA
         g7HaNx5sutk9wJxuSAUmFytfGTUlF4hXgGU5EYyX0XGFHjk+E4TsuRn1ZIvpf1GvI1lV
         RbErlxxG2R6Bp/ZX6YKgA/8+T+q+VCUWxVUvh4tMrDZNbkKwnbp0nGtX1diQZxVmd7RY
         O5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wfDrDROTvjACr08Dm+67uQv3MomG9SwdFcYtNDNZrDc=;
        b=YSjXIpUyngnnH1lZ+ccw+CHIQi+DrkB0GvZABSJbTQ7BPcqTyk/2ooNRXD1KFk7fbO
         ANvxD8TJ7t2pfiPaV6OFgxZuQ+xDoD/yudtFzbbEx6LTqJt/JI4UcVa5J7TMgBRHTRd1
         tKManxqAcX6cqaOa/Rr/MGgBk1s3rW6ulKVDarRqhIbRYzXAMXWnEPri0wa2F1PQEn3P
         NJTsukRV1rWnm+SVFsHhrqs2QJds+bKv0BtXzC6U5BswEqBoTRkxR4V/L3dpom23wzQh
         et28JcX4OKtXRZPimrW+IrRRiB12qHvVmE1lB5ipMFBVQ8IncKGM2+SUJndnd9nToxJm
         Eq1A==
X-Gm-Message-State: APjAAAXF7YFj5a7tlFlMrmJGDQATTM6GZHuqkhp67BgGAp4M0L7rpWVZ
        +CKSJV1hUBtsmjLkGHVcT8219g==
X-Google-Smtp-Source: APXvYqyYduBh/47gnohCbEyb/lNAvTzylOIELuFcvk6p7RHTD/RyRt9XSlXNNTx7RGTYSqyPux/jJA==
X-Received: by 2002:a1c:1d49:: with SMTP id d70mr7582025wmd.36.1555001607988;
        Thu, 11 Apr 2019 09:53:27 -0700 (PDT)
Received: from [192.168.0.23] (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id v16sm73201837wro.48.2019.04.11.09.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 09:53:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [oss-drivers] Re: [PATCH/RFC v2 bpf-next 05/19] bpf: split read
 liveness into REG_LIVE_READ64 and REG_LIVE_READ32
From:   Jiong Wang <jiong.wang@netronome.com>
In-Reply-To: <20190411094456.1fabc52d@cakuba.netronome.com>
Date:   Thu, 11 Apr 2019 17:53:27 +0100
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <078E22BB-54CD-4AA2-A240-1FD822189B44@netronome.com>
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

What I mean is I suspect the read width could be quite consistent in =
real program,
the percentage for doing extra check on read64 could actually be mishit =
for
most of the time, if the propagation iterations is big the extra check =
done each
time may overcome the propagation pruned.

I will do some benchmarking on this to see the real gain.

Regards,
Jiong


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

