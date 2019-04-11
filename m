Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC33C10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 16:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC84E2146F
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 16:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="IGdWoW/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfDKQpC (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:45:02 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41912 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfDKQpC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 12:45:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id w30so7853932qta.8
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2019 09:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=4UjJun+a+NZxqa8UtqlK6IZcbfBoBGh/TNXzCJubV5A=;
        b=IGdWoW/SgwbMZAN9Svh1rKzs33jvHD65EMUrDgrwJklu33muL0nN84QOLyVc/MOFys
         yt5lZ5I5tTa+xtNIyta6BbQYujWw9ITvs7HA5oqp8AuHhAEZnCAOlBm4/KirEJFBF3ND
         ZLaFn0qqKnfbBlj+AqWqBbZvUTHs67i9VpXVbbVo1mEqOciLckqr7J4AI3+YE9rIaKXF
         rKq0vC4Cd7Jv2x7f/Cnof8V+AsJrSBsWUw6SZL3q4Z/M1Wpxn7dvgq1ehY4SsysyWBGJ
         ILWkzGWLx1UHcpcDHhtXRI1+sK6aXHp34vCHnMuqxplzz7kJ0AgDOA1vLyHRv1+EPqXL
         tBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=4UjJun+a+NZxqa8UtqlK6IZcbfBoBGh/TNXzCJubV5A=;
        b=QDS0PBiFI5Gcohlh+3C/rq0XuQFPr2IVeV65OP14wOjZjNCzw1RgRpGmVAdu9/cLQv
         KB7OfNLU1Sc6FMnVeKTHzfrmEewK/mkiuL9/Q9B2YsBBtb5wUWAg22FP6sDwYy5A4ayi
         UgeYG+VeOPqP4tHNSJKI3Eahr95ghDO/+J3y8L6fuI6E7wj7QkctySJcyfyuZp8yJ6rN
         fGgWWIAABRuIDEqvhseuBFSiULvU+nqlxEQZyBiE4HIJw/i/px8VHy1OQZyrM4ZmKq40
         Rse9IxXmeXyeGgcaQ7oWDdtcd9gJdV36LiNNRSK3nMN4kCdObR/YWfAYjIW+lPlY5JiV
         LE6g==
X-Gm-Message-State: APjAAAVHCGDm7R50dZb8g/cqGS1Wb956rv3z/GyYTm+ljUAyB5xIMv0v
        xZ+LCoYuu9XTUeyIzG0EwqXkHw==
X-Google-Smtp-Source: APXvYqyUG96ld9Y8B7/kwrmhUDuSyb3Epmazh7BdluXeSDR3JNQrZ1gSa18NZQgmKxZv7BVLjaH8lA==
X-Received: by 2002:ac8:278a:: with SMTP id w10mr45436071qtw.231.1555001100930;
        Thu, 11 Apr 2019 09:45:00 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 56sm26533267qto.57.2019.04.11.09.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 09:45:00 -0700 (PDT)
Date:   Thu, 11 Apr 2019 09:44:56 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [oss-drivers] Re: [PATCH/RFC v2 bpf-next 05/19] bpf: split read
 liveness into REG_LIVE_READ64 and REG_LIVE_READ32
Message-ID: <20190411094456.1fabc52d@cakuba.netronome.com>
In-Reply-To: <3A9F4205-577C-4E64-8400-0D476F08459E@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
        <1554925833-7333-6-git-send-email-jiong.wang@netronome.com>
        <20190410195218.303d4a6c@cakuba.netronome.com>
        <3A9F4205-577C-4E64-8400-0D476F08459E@netronome.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 11 Apr 2019 07:13:03 +0100, Jiong Wang wrote:
> >> @@ -1150,17 +1150,17 @@ static int mark_reg_read(struct bpf_verifier_e=
nv *env,
> >> 				parent->var_off.value, parent->off);
> >> 			return -EFAULT;
> >> 		}
> >> -		if (parent->live & REG_LIVE_READ)
> >> +		if ((parent->live & REG_LIVE_READ) =3D=3D flags)
> >> 			/* The parentage chain never changes and
> >> -			 * this parent was already marked as LIVE_READ.
> >> +			 * this parent was already marked with all read bits. =20
> >=20
> > Do we have to propagate all read bits?  Read64 is strictly stronger
> > than read32, as long as read64 is set on the parent we should be good? =
=20
>=20
> We should be good, but I doubt there is value to differentiate on this in=
 this
> kind of HOT function.

The entire if clause is an optimization.  I'm saying you can maintain it
as more aggressive.

> >> @@ -6196,12 +6286,19 @@ static int propagate_liveness_reg(struct bpf_v=
erifier_env *env,
> >> 				  struct bpf_reg_state *reg,
> >> 				  struct bpf_reg_state *parent_reg)
> >> {
> >> +	u8 parent_bits =3D parent_reg->live & REG_LIVE_READ;
> >> +	u8 bits =3D reg->live & REG_LIVE_READ;
> >> +	u8 bits_diff =3D parent_bits ^ bits;
> >> +	u8 bits_prop =3D bits_diff & bits;
> >> 	int err;
> >>=20
> >> -	if (parent_reg->live & REG_LIVE_READ || !(reg->live & REG_LIVE_READ))
> >> +	/* "reg" and "parent_reg" has the same read bits, or the bit doesn't
> >> +	 * belong to "reg".
> >> +	 */
> >> +	if (!bits_diff || !bits_prop) =20
> >=20
> > bits_prop is a subset of bits_diff, no?  !bits_prop is always true
> > if !bits_diff is true, no need to check both. =20
>=20
> Bits_prop is a subset of bits_diff WHEN it comes from =E2=80=9Creg", we d=
on=E2=80=99t want to
> do the propagation when the diff comes from =E2=80=9Cparent_reg=E2=80=9D,=
 so, we need to check
> both.

Not sure what you're saying, in this patch:

	u8 bits_prop =3D bits_diff & bits;

Maybe you're talking about some patch down the line..
