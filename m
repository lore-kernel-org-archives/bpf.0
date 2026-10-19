Received: from postout2.mail.lrz.de (postout2.mail.lrz.de [129.187.255.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE8257ED8D
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.187.255.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420221; cv=none; b=Q0wdxAqNtqZUyfhlIskR/wepyS6LENnxOGxssaQ4+IcuuO/rxv0yfmb65XByLOD39IbEWHIffNyo5VDdtlipjEfShJdLb9Q0xE/llTYQ7eXmM8VOmn1Bs5ZEsicX1yBVFHBsB0lMUkE9Xsy7pbQLczDW3pVYrIn11KlPIIQVoNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420221; c=relaxed/simple;
	bh=PM6sE2mUxC9jaGkL/E4YPjW4dSPm2NHORQaOcWnyRbk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=o8QYhUcZGqBRiWwXUuCVRJCcAVYIPJCoLZAmgikMEvdEaqxfogqFXVvPG4vv3AiX6a/qBsYfHY4BF6QwTmHczqVqjykn2DInSzQnAdJv7nvjKMyRCPMIvKk+Np+8u35ucmGi72dUgAXfY9DWm0l1D+7Jr0iNUiSgIGwtP4pGs5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tum.de; spf=pass smtp.mailfrom=tum.de; dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b=VGSqIqW8; arc=none smtp.client-ip=129.187.255.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tum.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b="VGSqIqW8"
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
	by postout2.mail.lrz.de (Postfix) with ESMTP id 4j7d886m0jzyTy
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 16:23:52 +0200 (CEST)
Authentication-Results: postout.lrz.de (amavis); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tum.de; h=
	mime-version:content-transfer-encoding:content-type:content-type
	:content-language:accept-language:message-id:date:date:subject
	:subject:from:from:received:received:received:received; s=
	tu-postout21; t=1792419832; bh=PM6sE2mUxC9jaGkL/E4YPjW4dSPm2NHOR
	QaOcWnyRbk=; b=VGSqIqW81KE2W164oK19HBrvSrx+nlH9XPZbdTQl1IhGq8qqn
	DD8f5vMtGXY1ZV2ZO4MJEWHFfn6cSoxYl2S9Z+q/WWTV2WXTl3kAamZ/5V/va3vK
	MIgFV+WTSXqsg2InQ9Hckfc997KOEOdd2Uj4wA7xwa3hyH2d/6mfBPgfulLUwhdt
	Mr9R0AuztuYNTLHRIn3Fstsh5ZH1zrlTBghhaoIwW6urzGLg58gMyKvNo5nieHre
	qiCIKRAiIpOkwaW9tCzeNSj3BtwzIDEoCJaqpncc1HoaJ0Txjx2fQ83Haeqmj5+0
	AuJhbzzUfc0aaZUDvWDvQgi7/g03/q5Nnk/iw==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.866
X-Spam-Level:
Received: from postout2.mail.lrz.de ([127.0.0.1])
 by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavis, port 20024)
 with LMTP id ZjxQqJFkxTCx for <bpf@vger.kernel.org>;
 Mon, 19 Oct 2026 16:23:52 +0200 (CEST)
Received: from BADWLRZ-SWEX15A.ads.mwn.de (BADWLRZ-SWEX15A.ads.mwn.de [IPv6:2001:4ca0:0:108::165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by postout2.mail.lrz.de (Postfix) with ESMTPS id 4j7d884Vp2zyVs
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 16:23:52 +0200 (CEST)
Received: from BADWLRZ-SWEX15A.ads.mwn.de (2001:4ca0:0:108::165) by
 BADWLRZ-SWEX15A.ads.mwn.de (2001:4ca0:0:108::165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 19 Oct 2026 16:23:52 +0200
Received: from BADWLRZ-SWEX15A.ads.mwn.de ([fe80::873f:5e5:ff19:9a25]) by
 BADWLRZ-SWEX15A.ads.mwn.de ([fe80::873f:5e5:ff19:9a25%13]) with mapi id
 15.02.2562.056; Mon, 19 Oct 2026 16:23:52 +0200
From: Jakub Antoni Gonera <jakub.gonera@tum.de>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [QUESTION] Mismatching UAPI and helper proto definitions
Thread-Topic: [QUESTION] Mismatching UAPI and helper proto definitions
Thread-Index: AQHdX894Nbgo50gSpUWIXGJifuwfXw==
Date: Mon, 19 Oct 2026 14:23:52 +0000
Message-ID: <104932e79f1e4fc1aeab6ff8a381c36c@tum.de>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi all,

When poking around in the verifier I noticed a mismatch between the kernel =
`bpf_func_proto` for the `bpf_tail_call` helper function and the declaratio=
n used by C users generated from `include/uapi/linux/bpf.h`, where UAPI dec=
lares the function returning long and the function proto states that the fu=
nction has a void return type. After looking around there are more mismatch=
es between function protos and UAPI:
- bpf_spin_lock/bpf_spin_unlock: protos state void return vs. UAPI long ret=
urn
- bpf_get_branch_snapshot: proto states 2 arguments vs. UAPI has a third ar=
gument (`u64 flags`) which gets ignored

As this is essentially a documentation mismatch issue it's not a bug in the=
 verifier per se, but this will be confusing for the users writing their eB=
PF programs in C relying on the header for specification. Is this a known i=
ssue?=
