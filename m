Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF41E46AEF2
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265748; cv=none; b=jpqKkVTh42rWAIfn6EQC85ujsHtwKDUrMyJ4ACRA6tnDgxvgIaDXhIDXn0VuK022xYHEWgfEX/VmxtpQIjq9MkbOA1xafC6tiI00H6Ax+whYoqoJ0Fe0caperRZ+4dGo1RztLRcWUdZ8/L7GWQdvr3cWsIFUF4ma0MkDf1ibpmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265748; c=relaxed/simple;
	bh=TmImaUDgegmg1778MTFeB/M8Ob6EPE57DwsFTlvYsFw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=E/RK/Au9m6O6Rvc00GtmqcxeNAUayztPezi9pc7nURqsqa++I1DenerXi4aG7qvZ88Fh829BbgeHKQyMQ+1en7smOTdPcALK0RAJbdbb15YhOMCsoA5E2oJKYy4MQ9/71brrIKFXQzIgEN72Q4jo0khGUqXq/CgD/haw18WNQO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lY5wsvb3; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY5wsvb3"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469f204f6so20104b3a.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790265746; x=1790870546; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zv5L+1bkbyPWkA26DWnaWnJTRxw1dDd66TZP/T2+DRw=;
        b=lY5wsvb35/WersXla31RYfeqZXpq3wBuTgwbMG/CmA1VvqN0eQJoDLARyGtDmlZYEm
         oQ5vyuDEkhEtvM6RgQ8oZPlYMrgPhUwvluEi1RNh2PPp519QO5Pt87psY4lfjiZaXIu5
         CYPhrTvkdmmLtWxWn8gVLwafcjhhiowYwGaiMxLfAQUjfsMs1PpesbRDloxumPgVPKvq
         sg/iWwxOifdV/Q2MU9gb1IbbfKS2OgUVmO8cnBqrwu9K7WZZ4CQgpR6vUqGa4ICRBWE2
         BeWFBRNYrEbNw2IQEZ9YzBK8ONaVkM3LL2qCi7iOElzrm+GIcByKD3qpNOm8rjPey5sP
         ZSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790265746; x=1790870546;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zv5L+1bkbyPWkA26DWnaWnJTRxw1dDd66TZP/T2+DRw=;
        b=lDhmI20WaXBbS3cZhuIOTntGNHkH0SagsxgSFbfQQ+tz/ysgGOV7/9W2k0aEYryueS
         XbUb/GUYpDbBszqk9rzYaQxHSFevTvhxxg/q1OJHe9ikc8bNjPJI3Qy1IkLJ9kilG7z8
         29s8vcl/i0E35cGdLkbRIWKIrlTfQ0SvVN/9Pvvt0/oebrJAVtFTfhk+Dcg2Ed5svaxM
         DsbammoWhCpWCuZfvu1PhYXBzpWBVDJTXeJaXRTGXHn5+jrX/AP6ja1wJ8jnA857cQs+
         b5uGlClkQhePQVgg267lI6v3RHNkuRKnW1auV0jl1mnQpWkSMLuqL75l491h23Pd8Vtk
         pc7A==
X-Forwarded-Encrypted: i=1; AKwUvByWMqWm4QWXegjpR9ckShntvvxnPNmYI22PlvXojCghAlzK1XWfDMr+mILBbPtLPS/PW9g=@vger.kernel.org
X-Gm-Message-State: AFuF++mlxJ4rdt4IOHIaxI3dUS9DgAbIupVW153+oObB05+7o4YXY3HR
	01Mf2UclvbaMjk4niOI+fYwOVGIc/f+3jPpPutUeUdTCSt7fKUveIBba
X-Gm-Gg: AYBFou0Ym9CP8MYd9RiBzhc7Rw0CoH1xT09EVJmO0fcJN6xHax5eVZ1aWthMMjbU1Oa
	JeRZRdInwWTDR2aluW8R1XAXxv5haAsZ05Plet0B5Dmy5J59a97CU6NGyr1HaO26+izGQU+eBEa
	m0FnYQBOU6KgyzFLynRGCQOVZmkS2bxoc3NLt4JKPXBrmzKcio/NHtV9wmBsQtN/Ziw2EtUlw+/
	LNrexyR5lHj7BjEzJAmTRtWQu93f1F4mcAS1e9Lnv923Xa0025R1KwNkGeO5pR6ayPBTMV26NVT
	z00vcbTLf4BBZ4mnB+sERgsPvT86kPN7rabKqqLTPKRcdelF80Csi5a36LQKSWb/oOEiPK5tsKk
	7UgznkrtoEpWHeBOYP3x3wBC1JaJLvHLvvbS9tpZy1QSrDdo/tIz5/cSWRRf1VS2aCmzMuu2MXb
	4YgaFURTaC+LELVyQu/c+cwg8JZmDOIceCs4nOZeB08RAyFhn9xOE9LkMltqgU1bEa8VBpdm4NF
	n0vLYnAdQ/DTqvakdOcmhih9usNEG4hatK/nje6nVEYyi1clIMS4HE3qCT++LTueQu4SLQ8G9w4
	VJk=
X-Received: by 2002:a05:6a00:1da3:b0:84e:4d6:78fe with SMTP id d2e1a72fcca58-87e98996dbcmr2554884b3a.3.1790265745682;
        Thu, 24 Sep 2026 09:02:25 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1dad44c6sm3287740b3a.42.2026.09.24.09.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 09:02:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 16:02:24 +0000
Message-Id: <DLNO8P8BZIFT.1XSPD32OMO5GI@gmail.com>
Cc: <jolsa@kernel.org>, <daniel@iogearbox.net>, <ihor.solodrai@linux.dev>,
 <yonghong.song@linux.dev>, <song@kernel.org>, <martin.lau@linux.dev>,
 <memxor@gmail.com>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <nsc@kernel.org>, <puranjay@kernel.org>, <yatsenko@meta.com>
Subject: Re: [PATCH v4 bpf-next 09/11] bpftool: Add ability to dump
 LOC_PARAM, LOC_PROTO and LOCSEC
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <qmo@kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260924111428.75957-1-alan.maguire@oracle.com>
 <20260924111428.75957-10-alan.maguire@oracle.com>
 <DLNN9DAADBPQ.18FN1VMU78XSH@gmail.com>
 <3dc200bd-1e24-40ec-be53-2d94c0feeb14@oracle.com>
In-Reply-To: <3dc200bd-1e24-40ec-be53-2d94c0feeb14@oracle.com>

On Thu Sep 24, 2026 at 3:33 PM UTC, Alan Maguire wrote:
> On 24/09/2026 16:16, Alexei Starovoitov wrote:
>> On Thu, Sep 24, 2026 at 12:14 PM Alan Maguire <alan.maguire@oracle.com> =
wrote:
>>> +				printf("\n\tname=3D'%s' func_type_id=3D%u loc_proto_type_id=3D%u o=
ffset=3D%u",
>>> +				       name, locs->func, locs->loc_proto, locs->offset);
>>=20
>> My earlier feedback must have been lost:
>> Pls print argument names and where they are held here as well.
>> FUNC_PROTO has the names. LOC_PROTO has the locations.
>> Something like:
>>   foo(arg1 reg1, arg2 *(reg2 + 0x10)) offset=3D64
>>=20
>> Or is it planned for follow up?
>>=20
>
> Ah, I missed that, sorry. I added display of LOC_PARAMs for LOC_PROTO; di=
dn't add
> the signature for each LOCSEC entry.
>
> I can respin with this and the vlen/flag checking for patch 1, along with=
 anything else=20
> the bots dig up.

Already applied. Just send a follow up. We need to move fast.
