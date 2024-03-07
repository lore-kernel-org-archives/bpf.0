Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AA01BDDB
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834499; cv=none; b=XkSijIKOPB2+sWdbmGE49k6Dta0/OIZP/NHKiX4lvT0Y8QX/ic/UQQPYiqsAcAddEpFy7BPg5tDLcP0Z/Pts8xwRu7wKDoxJuVNtMofrxA77IBgJD1s4mYmHKFtrALJw4IXa9hljaBpoKXD4I6Se8vYttbmNpNCJFPsfOyOB0G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834499; c=relaxed/simple;
	bh=Qdh/6l+0WsIUlkS8DWg4uNUGSTHenYj301WnoWcwq7c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Yj05E0QtV3IPVW4oaTJu7B/APkVQrTakyVkl3lQjFtJbGkpavbgvfqx/z5W4sgChWJmDSyrnjmneYIzwv7ezCp3MNVxB8Vwc6VUU+IOyjPeCUNRyjhaW44XxNDvkILu2WnJAe7y9o7qBF7g12C2qjDTInM9UHxSGuiS6Lt5tevc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68fcedcf8aaso6758816d6.2
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 10:01:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709834496; x=1710439296;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qdh/6l+0WsIUlkS8DWg4uNUGSTHenYj301WnoWcwq7c=;
        b=mMaf4/gReWefQhavpxCsH4K00Row8wTNqVkBdoCzXY6nTEyzzrHtvqJLwXtPH7LK9l
         xEn0pmVm8caht2ywGp7ryx5zVxcqq56PAr0QymsFRVO2Une5Zy32i9CRq4FPr9IwnzlS
         w7Zar8ZohY51H+OxoRcihXCcyLdpvl/sbEoE9Pk2HvmFA+Q5mugkQTHSNK/ELUpgS/D6
         Epz899NXya0ZOQD0pKiYPdEAwkMbhUR3a6zbJQyWdXd8LOl2xKWcWmJSSDGwt7F+HNli
         pdnL0jwb+SQ8B4HehKZh10M5FdUg36KddmusNVWK4gma2S4irdH29DyPNML8/m+KBfm9
         JDoQ==
X-Gm-Message-State: AOJu0YyjXDpbiGb04593/tWuDcsDQE117LW6qTkoL1OfGDMtfKGeso2F
	UqOjIkgkmfXx+IRwTh/3eMiQPwN+AKoggxvRbQGxYHeFfxvs3nz3YOPCfRSw
X-Google-Smtp-Source: AGHT+IEx1o8KunLYwMP8sbVQdaaiQwH01HapmcR4ow/LSnKoT9I/DedeMQAfNGd+mLloy+9NeEjE3A==
X-Received: by 2002:a0c:bf46:0:b0:690:5dcc:31e7 with SMTP id b6-20020a0cbf46000000b006905dcc31e7mr9058872qvj.25.1709834495901;
        Thu, 07 Mar 2024 10:01:35 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id lx6-20020a0562145f0600b0068f752195b5sm8935431qvb.86.2024.03.07.10.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 10:01:35 -0800 (PST)
Date: Thu, 7 Mar 2024 12:01:33 -0600
From: David Vernet <void@manifault.com>
To: bpf@ietf.org
Cc: bpf@vger.kernel.org, bpf-chairs@ietf.org, suresh.krishnan@gmail.com,
	ek.ietf@gmail.com, alexei.starovoitov@gmail.com, hch@lst.de,
	dthaler1968@gmail.com
Subject: BPF WG ISA Document: Last Call
Message-ID: <20240307180133.GB63192@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HU+4dg1vAbR+g8k1"
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)


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
