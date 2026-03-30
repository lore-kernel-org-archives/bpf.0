Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11292E091B
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881752; cv=pass; b=XHaQXc0ucfz0Yn12JBBvq38/4mthABvnoy2rFNMZuanek7JG6rJ2qXyo+JyqXLKHKH4GWUjPXaYOIQqJ4wOW8/vrComyz5+UGk9GgFp4+8/RMAwTnIHV8We6yBU3HgeQpSMZsYka3RwLDRHe56ELGV8jq2I0u7U7ZzROckv8BIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881752; c=relaxed/simple;
	bh=LUueVqc1XNPWDkNWnVhGYTN0lpCzn3GC6QwS27VjGRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fe7xw+n67oOiomHEhzF4BmRjuSg1AN4bQF9J6Nnoy2WzgPxlvVICLXsSAO4Ik9o5OKdjZirmL/lOnw/kcssqpF5XmdoPYaFDzf7hEvQGtXap8g/MSAozcenP3Aof/CtdujJQ7krC6opCvTBzA/CzmPpt/VaalNMMX4lQPu1oRGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2oCccEc; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2oCccEc"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d01d6b50cso683150f8f.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 07:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774881749; cv=none;
        d=google.com; s=arc-20240605;
        b=K/wu8zZdEDzizXjLonx0bS3ziKIoPlGO3rWOqXZqNURNhqlkSpeqFjMqUc2oxvJ873
         GVf6KyxTUQmUr8hiOFhUi9AAG3SwjPnLtX59jdCcaK8zhmGdJaBQJ6eDsCDMEHg4J3G4
         bUnbFXxQfFjcAmfnJWrwCJ7/Ebo6N1eo4VSWxViqamUfcVC6W6mZpj3NEFY3nsVFhD1z
         4vv7tl9AOE6bahCOBaA+hSp20UUD9p5XIbkwOsQrwRsCySPV6YA9jHioQfxZ0FJ57WxF
         3gEPg/vZAVaghwauPwlkiXMRD33Gcray8h/KEpDGv4y15VhQSNNISeMAsS13y7drMfqk
         EycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LUueVqc1XNPWDkNWnVhGYTN0lpCzn3GC6QwS27VjGRA=;
        fh=OtCRirM/UWoDh45rx8C0wF25K5bNjx3xPCv7CWTkKeg=;
        b=Tzx8ldjB5A52Kzkm3dBg8rSrKJtm0F5h42CdDbzkoi1TqCetxO/k43i+I0au1UdnX5
         6AJfqeC6XSG0C11v0cPOVVLJKWX7n6eEMhddfhbXKY3Ab1q2AHhycopixem0xWtIvlnA
         Gz83qg9f9xacc97e9CkfRjhMZ3lCWd5kVYuke+6gNqbJY2CGMtd8IDZvkQoTYGv7OjqL
         mToFbkCTuh/UcWRK0dr+PwWOZ1TtwASQSi1rG5q2pRSNXi65b1SIqU7E7hc8b6tlNnJ3
         q3hpB6BjOsdrJvM63vg2R2N8TZRLzTtbfJha/HSb+cWRMIiiDhWmLuXgTKpcJkfugfHN
         3D+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774881749; x=1775486549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUueVqc1XNPWDkNWnVhGYTN0lpCzn3GC6QwS27VjGRA=;
        b=M2oCccEcB/sK23OSr+vXMZOIEjk0c0qBuk8lpzH0GG8pCLeJiTXg4nfJRDL1Rp7BmG
         C5kzYDzUdYUfF/WFIdzGkm4PEVPSGsgXbOAwXa6HbXIejbKMi8khPbC1CgB2+eHE5HEL
         jP5jpW/pPaLUVfsGeYMPeO35a6pE1gk/r3xzaXMIkTYajxEW9id/iVO7ZRWQfJ2p49TK
         VDFbO0MtXZtVQKBnVU2f88EIfiTO7rHqrefCxlJ9R1JWjKd1Z4aD1+5QZr1D1m0GCl23
         n20SNgVKWCktqjHP9J0jzOratH1MnL3lT1XSgczUCRkowD+2lvpRqIrbjtrMqjC92Pqy
         s3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774881749; x=1775486549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LUueVqc1XNPWDkNWnVhGYTN0lpCzn3GC6QwS27VjGRA=;
        b=FZPu5h6Zyi+n4rLMaY1U2Ips2hxVCPK/x3ay0bjVAcVttXAISf7Fhm4cJNzczeBR3j
         a6jjMYCEnQEC+F+4UIjEW4qgdnqKBYVMGhkTc+Tghhg3pWXjlbV0rmaGIRGM3IpPtnsh
         2S/bSBUQh6fwo6iD0p3kAVEfcV/fxodJzB6lmmfPGu8GA9jbPhfSKxrQmTpIjHAe+Gkl
         8SZMW1AtlMHpnclCEUNByXOOESun4lIXq4Q/BTcF7Gsenmm7dLCTkJJlFS6Vld6Ko7o4
         AyH5f0DlYuNq3ls4GU6cofLzBi+Ov1Jls7gKTDa1B016BJ1SzdqLFPND+DjeqrijvxLp
         31NA==
X-Gm-Message-State: AOJu0Yy2cZg98eEVvELZzuU8aD39koJ+2kPBYNmNdisfTi7Mls9Wcnhj
	6VlPE/2dz07tNMbAwN2642vWAsyiBp1hEEVi5WBYkBJ/Oa1ZPYH5hLudFijgiWgG9aFolREPdQM
	OVze8ei1ApF38ECDs3QUt7r/5r9JuFlU=
X-Gm-Gg: ATEYQzy7mW9UdockwEPk0FP1QIff5spSRj7Xo+1ICnXso1VFONQT/JdOuqhkl3bjIO4
	SMQegNbnHuvNGRaKpKVjuW4dO2PYagBIrjaZb9fpb+RBLXBngpOXR9SfYC1rr718nUH4I4vcZz0
	nHcioFdsEH2tOn+vdsZ7shxVZG7YGrWZCOUzAdRZDjHvcnish2eiJApG++PAtb6aNpWfAJvr2Ci
	CTogM4PQHJ+F3hstspggrQmXAdJ+A76nzYViCX+/LDAu5WbH9mccyWte3/lpXJu0sKAXHKtpCum
	O+93X6Wfgg2FDrMMQXMWD3w+AKTQgOrBOnIx4WTmWrzfCuuGRPvt4HY8whRY417W2LUqhOV4Eig
	xp5ziA5VGS8xB/SczcV6+yDJFuoU9XCZ70VJj
X-Received: by 2002:a5d:5f87:0:b0:43b:9c02:50ca with SMTP id
 ffacd0b85a97d-43b9e9d93a5mr21312656f8f.4.1774881749067; Mon, 30 Mar 2026
 07:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6ebc74b5-3dd8-4bb5-adac-fa32bf71eacd@linux.ibm.com>
In-Reply-To: <6ebc74b5-3dd8-4bb5-adac-fa32bf71eacd@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Mar 2026 07:42:18 -0700
X-Gm-Features: AQROBzDL-pnxfdvA2tBq-378itq46Y1BKJw7oTNQ5UMgzUsztn5JMGhOcCOZj1E
Message-ID: <CAADnVQ+KpCZqjAhMBzDZqm14yaORK-PG2VHRnub1Q0gYTHKG=Q@mail.gmail.com>
Subject: Re: [linux-next-20260327]resolve_btfids warnings for unresolved
 bpf_lsm_bdev_* symbols
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Christian Brauner <brauner@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Saket Kumar Bhaskar <skb99@linux.ibm.com>, 
	Abhishek Dubey <adubey@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 6:45=E2=80=AFAM Venkat Rao Bagalkote
<venkat88@linux.ibm.com> wrote:
>
> Hi,
>
>
> While testing linux-next, I=E2=80=99m seeing the following warnings durin=
g the
> build:
>
>
> WARN: resolve_btfids: unresolved symbol bpf_lsm_bdev_free
>
> WARN: resolve_btfids: unresolved symbol bpf_lsm_bdev_alloc
>

Christian,

looks like those two need some #ifdef
