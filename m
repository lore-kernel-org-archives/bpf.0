Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FCB1BDDB
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 18:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834509; cv=none; b=pIOkddiiyJ2dGmRExkgK3W1htLzHEXt6DSEf07ckVuwtapAich1p3bZ0vIusWgvaiUXK3qLR11PXJcNDJ1nMBCdF/odO4gUncVpVntJBBoyqG8Mqs3NzU7AQFxVHhVcgOCCfUIdyC81XMBSbdBTfsvHnIvZyCDaoDAOmjZEET+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834509; c=relaxed/simple;
	bh=cTKlD4B8xqRtLOIhq21xo7dHhHGY5KhiWOTymc30Mqo=;
	h=Date:From:To:Cc:Message-ID:MIME-Version:Subject:Content-Type; b=Ltr8JxvBJpbud0UqSdDSv4EDP2Wn6u8sF9cUrwHhsF1tysvKSaUnfnltrHX9iYZG3+65m6tCytakzx+Wop1uxcdepJktvCkC2VliNlXb4GcTK8aCbGk1zB0C6lJTFuq4o6P4pe0exfFQ4a9zEXS5qH56AkfLiYUDTn321xF2Sho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=K39JFDcr; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=jFLNdV9d; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="K39JFDcr";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="jFLNdV9d"
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 23B18C18DB95
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 10:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1709834500; bh=cTKlD4B8xqRtLOIhq21xo7dHhHGY5KhiWOTymc30Mqo=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=K39JFDcrlvU0it+ckeL0lkhszjtU/8qjGz28ZOh4XbtSNf4qi5IDGLMJ0G5AfaoHi
	 ejxWELVuHVzB62x6di05OgVFaYSbh61eEEj54KFvN4PMLxECsmDPhkmoM2MID+Cfzq
	 x+WferS51ciWszKyXbJ0y1qEm48mS+h92Y2o4564=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Mar  7 10:01:40 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id DEEA1C151091;
	Thu,  7 Mar 2024 10:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1709834499; bh=cTKlD4B8xqRtLOIhq21xo7dHhHGY5KhiWOTymc30Mqo=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=jFLNdV9dmXlxgfzGUvbpn/daPhGWDYIHAi+smc2a2BE/umqQqRlGEL19bpBaDn6yn
	 +gWFb+XM/MMLRqBq4L+BSxO5mAuMIz/EiOdeogHQOOTnKtHHGkRLQQghCq+BZ+pl3+
	 X3ir5op2QivttHgo6vyNv4BZyZaKwftIRxgVJmJk=
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 415DBC151091;
 Thu,  7 Mar 2024 10:01:38 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.407
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IqiOL_6iU5HS; Thu,  7 Mar 2024 10:01:37 -0800 (PST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 6C35EC14F6F4;
 Thu,  7 Mar 2024 10:01:37 -0800 (PST)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-68f51ba7043so6994736d6.3; 
 Thu, 07 Mar 2024 10:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709834496; x=1710439296;
 h=user-agent:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qdh/6l+0WsIUlkS8DWg4uNUGSTHenYj301WnoWcwq7c=;
 b=W4ONcAANTmaTSnSuOjEt2a8o40xcDvWtv43aAFutK0EM7sBAIDcQ6aRaIa2dHknT6Q
 gP9XC0doVcycCx5SPguVmaFKxKGjPy47KG7WoR2uzDpP/O0Kv7Zbmuxr0TTnUACUNCnV
 DRIa6/oGgpl0GOL8NCOVHD4M/aiaSZDSe298itxRDDqj+e+smDIuZw7waNFTAwHzvSt0
 agCpvi2G5nKhwHq4YKQqio1YeNzaAGdirgXT7L3crY2B4wIXNRjJQJKomXvkeZI6p9qU
 3NOtne3dGIAYz7qmyB551I0cPo8sGiKsoV7eQTTTlG77bNO1rRqSizYUeTm2zMcmSAqR
 xjgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVzAzW7jup+bmoOHH1NS2lLb2j9EXcmMe7OHGBAlhC1upDmENQNzw2Stt/V5hRuju3vBPEuvo7TmocU8Rt8V7m0Qpv
X-Gm-Message-State: AOJu0YzzweG4sQUGoYaZSOTk+dGOm2oQs5B+O66Z6vRAO2M157NA/Czw
 ao5rvzwytSkrhXRRwsfjFAJxSMhQithFIHd+VosYcKkMn4de6MQkSmi9YRAc
X-Google-Smtp-Source: AGHT+IEx1o8KunLYwMP8sbVQdaaiQwH01HapmcR4ow/LSnKoT9I/DedeMQAfNGd+mLloy+9NeEjE3A==
X-Received: by 2002:a0c:bf46:0:b0:690:5dcc:31e7 with SMTP id
 b6-20020a0cbf46000000b006905dcc31e7mr9058872qvj.25.1709834495901; 
 Thu, 07 Mar 2024 10:01:35 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 lx6-20020a0562145f0600b0068f752195b5sm8935431qvb.86.2024.03.07.10.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 10:01:35 -0800 (PST)
Date: Thu, 7 Mar 2024 12:01:33 -0600
From: David Vernet <void@manifault.com>
To: bpf@ietf.org
Cc: bpf@vger.kernel.org, bpf-chairs@ietf.org, suresh.krishnan@gmail.com,
 ek.ietf@gmail.com, alexei.starovoitov@gmail.com, hch@lst.de,
 dthaler1968@gmail.com
Message-ID: <20240307180133.GB63192@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/XQdLgj-imCLDWde8NyOfsqB7q1s>
Subject: [Bpf] BPF WG ISA Document: Last Call
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============8356444143383965135=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
Message-ID: <20240307180133.qzY9tztLTkgY3Ck48nYFWYtk7iOZdkeP6BHD7DcLEsE@z>


--===============8356444143383965135==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HU+4dg1vAbR+g8k1"
Content-Disposition: inline


--HU+4dg1vAbR+g8k1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello everyone,

We're very excited to meet in less than two weeks at IETF 119!

We've made great progress since IETF 118, and we're thrilled to announce that
the Instruction Set Architecture (ISA) document is now in working group last
call. Please review the document at [0], and share any remaining feedback that
you believe needs to be addressed before we send the document to the ADs. As a
reminder, the official working group document is in [0], but any suggestions
for updates should be sent as patches to the instruction-set.rst document in
the Linux kernel tree [1].

[0]: https://datatracker.ietf.org/doc/draft-ietf-bpf-isa/
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/Documentation/bpf/standardization/instruction-set.rst

Because we're so close to IETF 119, the document will remain in last call for
at least two weeks following the conclusion of the conference.

Finally, as a friendly reminder, we're still soliciting agenda items for IETF
119. As mentioned in [2], please email myself and Suresh at bpf-chairs@ietf.org
with any items you'd like to discuss. Note that there are still plenty of
remaining milestones in the working group charter [3]. Any topic related to the
charter or BPF at large are within scope for discussion.

[2]: https://mailarchive.ietf.org/arch/msg/bpf/6pJCj9ujMA5ffb0yKv6DrIOzXOo/
[3]: https://datatracker.ietf.org/wg/bpf/about/

Regards,
David and Suresh

--HU+4dg1vAbR+g8k1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZeoA/QAKCRBZ5LhpZcTz
ZKdaAQC+aJQ+d83b28Tvo23GXzE/AHxrsYAmr2E/5MeBoHT+oQEAvuMRcczBCoiH
MlGiOlmMKf6bi17Eub9viblFAm1Ajgg=
=C/Zl
-----END PGP SIGNATURE-----

--HU+4dg1vAbR+g8k1--


--===============8356444143383965135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============8356444143383965135==--

