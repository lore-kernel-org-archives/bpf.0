Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F42175A7C
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 20:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074621; cv=none; b=hLBpTur+dEvL7SqAtbm04fdPQqYP2rL7ud0xWLHrPgEeeW/d57CIa5UgrFzK/3IedvPq2BsRXoIqCwiiQ+aiIhaju0AetlcRecWuDmUDNqeIXCnjqOOo63RHzFufudQ1IQhtE4NTGvcdnIsZHAFbzVkVOTeZD2cvV5fhZaiTJl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074621; c=relaxed/simple;
	bh=poyWPfpVFkHik/7LQxRzVsHnGJTp06MVc9m3rj0ZwQI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KzMF3S4A6UP61isfmv3gjan6EgMJIAhxnySzoMOGaFhJI9LTL7Yusq6GNMA1TqpDXquigemkaJ8rQ9MciXdwW2sTgXrA0q4cak0RjtSbxoaENbPBP/rXMupUQqppU8wt34Gh2d6wcRAZCXpMgBrj1S2vaovWf7+TPdbJtONsnyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5wYEaa2; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5wYEaa2"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c88992d77dso729325eec.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 13:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775074619; x=1775679419; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=poyWPfpVFkHik/7LQxRzVsHnGJTp06MVc9m3rj0ZwQI=;
        b=R5wYEaa2RurBq0xYC9EEMcN4FCOGyrkSxlAkIoqPwAQJtg25SOG2uV/86QULk4xlUn
         ESWavDIZxNUMxpsblUO9eLNMt8u4rLAPpWp1bxn+z2b0Z3yp3nNylOqk2xEbrTo96Lgx
         F0rewRYhN1CR6aNZxSy2NPpyA0vcEJQCcWGY/pdloD6og6QlvpuLAtENeNGJZC/thDrq
         fkdxHqVYG1HZwvAvkZuHRJPDPnQ4qS5D/jG39mlJIrdE+pxmDsrFt2LSBYFRv8wdQGxk
         NPR6TBRzXde7q6KKITsmmiGbNYEtcFRUOG2mASaWkKtEFNFIgR+fN0M47hClHfu/zxVV
         sWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775074619; x=1775679419;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=poyWPfpVFkHik/7LQxRzVsHnGJTp06MVc9m3rj0ZwQI=;
        b=MWWal0/vPWJPndCUGH2SNuemnjSfX6fhKLPLP0gENLeG5qip/H8kNPMmIIPRSf0HHC
         Jqe3rAz4Uae1SXtmGX5R0kNOqBzRwcgiPz57vy7wD9GiSzFDApw2BRdOThbK8KVXkqqi
         cdp4x3qvv7NSYIkyyok0tEaSZHRbK91VTUTO8VAZ41gei8keR/jK3X8zwk8N5llYZ/zs
         E3yRr4wSV6A7+G6Nna3l7mfj9VbyBKin+ll7NtkqtOL0Nn3wwN1iDK2ZpYZeCpsBS20Q
         5TABse4YWItQfNR9pjqUItmHi5pr5rKlyJ7EXeoYGEb6j2N0ixm+XKgEDiopF0+WGgwi
         787A==
X-Forwarded-Encrypted: i=1; AJvYcCX3eOsocXCRw+qfWVxAbYT1ReaBcjQX7Up6DdjbsOYS35enr/IxSYDoFpFW7jAcIAwUBVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmYY8V+a5OkTWWhPcsEAt1j7k0D6QFBYSaWscgTANb9d1VMSkA
	M4u5rv8u2k9ITV1CHM3bafEa0he4LXFlBUQnNESA3kCRI7vgp/iABFwg
X-Gm-Gg: ATEYQzwb5Z3BjuF8P42ujtPCyF2DVMozxl25F8B1VZqw+9wlkvEYQj6dGnPz447ZcrF
	v4TKewB5v3PW0FUhAHhyzpuKG0Un/qJ4kd/Y3gaUsThfjasxdZZkkiM3WA8WZCTPoqEe/eCu9tD
	+jVDhyATh9j83fvDrZVT1VUHr1CN/UV68IZycE8F6DGOYZe0fZfYGbwjANtIIv3mZUijrE3oTBT
	1921nhOEy0dLKrq0ZVhIJfOq1zcEdQXHoAcP0B5S6qHhq1aYSm56HrllgjRiP4K8gzYEiivdu5I
	7sAj0vMANfVPAX71iqusXaekKOYyg8VWdIcFPkJJvfVEAs2eq/5SchJEGDy9Da96zOd153l0fKX
	+DufuPW1Dqnxri+1PRiYGBMO43FLceHy2zNaTegsqeZas5atkmpBhjcI07J3gR4b/ll4dyViTFR
	Hl5mzX7HIDuzw//4wJOpFXkZ6kNVQxhyMSEeqwFCnxcZCsY528BqgXMwsMEe8wfLY2nSa7lwZYc
	JwMUB5z
X-Received: by 2002:a05:7301:1695:b0:2c6:67b6:3acc with SMTP id 5a478bee46e88-2c7bcf6d89emr4314488eec.15.1775074619024;
        Wed, 01 Apr 2026 13:16:59 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:7aba:8184:a91b:bf1f? ([2620:10d:c090:500::3:f883])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df3b84sm641075eec.5.2026.04.01.13.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 13:16:58 -0700 (PDT)
Message-ID: <ca4340d7205491169ad633efcd5c5fada90f4a28.camel@gmail.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: Move verifier helpers to header
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com
Date: Wed, 01 Apr 2026 13:16:57 -0700
In-Reply-To: <20260401021635.34636-6-alexei.starovoitov@gmail.com>
References: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
	 <20260401021635.34636-6-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-31 at 19:16 -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Move several helpers to header as preparation for
> the subsequent stack liveness patches.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
