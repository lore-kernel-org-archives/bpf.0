Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BCEC10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 06:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583C820693
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 06:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Wis/ADDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfDKGCs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:02:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39722 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDKGCr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 02:02:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id j9so5593607wrn.6
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 23:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Zg3kUMdyEGkfbUO6z7WZ0PycXeHTLdNbqeAjUhFBweM=;
        b=Wis/ADDV0NgYzvEmaSA9gvGrYNRS57uSogh2FY6ID2zQPW0PCF4Hte4ZBePIByiUvA
         T9255ddjmaXFOBhxBYEPqRiz2uEJFBG3hkj33vqDCj2cQh1rjiRAU+m/rqNVQtT3a8Kh
         +1qroPY2zBSqcPGwU/b7qYTVToC8kr6sq1ZLQ5/6H0mG5Z4JT/8Hd5e6J0SINzqCVpxb
         LNOY5HbB+JE6+pSA1YxEGTH+TxZTZfyq5zV4dHemWkFSx9OMUd+5HilO1owvc1J9iHXR
         18JgRxXh3jVVTkMzZE1gBeDRlpCeuMB7bd2gDJeN1bsRtNYhdpjYv03+Gda6usD/BG61
         iTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Zg3kUMdyEGkfbUO6z7WZ0PycXeHTLdNbqeAjUhFBweM=;
        b=a/v5tlGKyNP5UprbpX774QFeRPZfshiCn6Y1IX7ctG0rS8gAbKqFmJzhyQk2GmkjwQ
         8xWcwohgFs02nTtldC6GejymPzoRm1JaTjRckIr50zc660Vsk/LtX2TzyC9vqMNnHY1D
         lzTcrkCCtB88HInZlbPSW6CQEfwZX0FQzwa+vyRidsZ0NG6CyE0qL3frRDiwCx4kr/8i
         zmvB7js1OKWqR/3eab9owxxfaH4a6sMQXE5PQ3ijBP/iQ4rtpYqNr6sGBOl6rMBKCVu3
         wzvDEemq8+58nD9pDmNBLEZ13TRHRGInG+8Wf3TZ42HI80d9m4hATLwsXZ59tWDTalw+
         H+TA==
X-Gm-Message-State: APjAAAVP9DUvy8BnI3KdJGDqJh3wLNqwCoFHkts3kns+y8GhDvN2UTFU
        HN4EvSVuGtMhTQzBBkCzXYtM3A==
X-Google-Smtp-Source: APXvYqwH3S9CYfsLbzUTIj1U6wDElgQCZp9TL3cWw8zP26eo/rGgIwuglPJe4kBkvVmxlKJCjf0rug==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr26446885wrj.101.1554962566129;
        Wed, 10 Apr 2019 23:02:46 -0700 (PDT)
Received: from [192.168.0.23] (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id j9sm44684397wrr.93.2019.04.10.23.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 23:02:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH/RFC v2 bpf-next 06/19] bpf: mark lo32 writes that should
 be zero extended into hi32
From:   Jiong Wang <jiong.wang@netronome.com>
In-Reply-To: <20190410201302.4e67d48f@cakuba.netronome.com>
Date:   Thu, 11 Apr 2019 07:02:44 +0100
Cc:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8CDB95C6-91FB-4F6D-82E1-61F6132A2DE1@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
 <1554925833-7333-7-git-send-email-jiong.wang@netronome.com>
 <20190410201302.4e67d48f@cakuba.netronome.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
X-Mailer: Apple Mail (2.3273)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 11 Apr 2019, at 04:13, Jakub Kicinski =
<jakub.kicinski@netronome.com> wrote:
>=20
> On Wed, 10 Apr 2019 20:50:20 +0100, Jiong Wang wrote:
>> @@ -2169,6 +2188,12 @@ static int check_mem_access(struct =
bpf_verifier_env *env, int insn_idx, u32 regn
>> 						    value_regno);
>> 				if (reg_type_may_be_null(reg_type))
>> 					regs[value_regno].id =3D =
++env->id_gen;
>> +				/* A load of ctx field could have =
different
>> +				 * actual load size with the one encoded =
in the
>> +				 * insn. When the dst is PTR, it is for =
sure not
>> +				 * a sub-register.
>> +				 */
>> +				regs[value_regno].subreg_def =3D =
DEF_NOT_SUBREG;
>=20
> Can't the rewrite generate a 32bit load?  E.g. reading skb->len will =
be
> LDX | W, we still gotta clear the top bits in that case, no?

No. for 32-bit load, I think the type won=E2=80=99t be ptr type. This =
override is
gated by !SCALAR_VALUE.

Regards,
Jiong

>=20
> I can't find the explanation of this case with a quick scan of the =
code
> and cover letter..
>=20
>> 			}
>> 			regs[value_regno].type =3D reg_type;
>> 		}
>=20

