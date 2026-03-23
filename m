Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAA23DE42D
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774295583; cv=none; b=pn34tBScZfldulzMdFH6+x0wdvFwMcDgfSNvVfWV64lA98imwg0lm62mKW/XJfal/5FPzfIf8BXf913bXuQJFGg9VMimKv2eUg+VamFCpH8F6Jn6lxJws8b3vA9W3HZtnbVujPQrDliP84hfkDIXrrf7C6uo2cY+6l6g2gSaJk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774295583; c=relaxed/simple;
	bh=dD52ZnoIb5u+QDYuvpB5haRjt1oC9cOyonodcY8oZdU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VFZV3E+k5XrCwmhpJF3yXgIpO9zFGajZwNFohelNrUJPgQ59Nw8bWvFtOpIy9Q+0ajCV+N7YSgk124lM1UgE7hvF7RZFNnXWimiziYedV3ncdn3rksSUs3wo9+biQUcW1Pyz4IZ4KVWrZSlOZOh18dgqoU1kAS2B1gtu0kCESrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=it11OSlV; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it11OSlV"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12a747e7b2fso1073606c88.0
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 12:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774295580; x=1774900380; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dD52ZnoIb5u+QDYuvpB5haRjt1oC9cOyonodcY8oZdU=;
        b=it11OSlV67P5gyrR7CqWUFvVk+BSYg5pEL9KP/98IvvDBe33q4quDhnkj6Dq6Pr4jZ
         rLfOSmggZ+F2Pw02/x4jy4r9PD+BGgRgNNT/qZlqDC+pp6tkGryxmUZwYbwRjFvP2Tuj
         ukBz4dYF/Qm6Nn4PxvmeHDU1axRiH+C+sG7qBmYOdwi+OUUWJG22A+XoUqzvGxcqWUF6
         XADx3126gqVgjTjO1FUDeV+PXsT3Im9vO6Xef4LSTaDcBmipL6mtXaKrPq/Icuwu0L+H
         N6wYHWYP/mmtGbQXXqVkt03x8USnwZ8kVhI/az/BCwda8ohc/svvxKEPbkyR9dKoUvdI
         3YZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774295580; x=1774900380;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dD52ZnoIb5u+QDYuvpB5haRjt1oC9cOyonodcY8oZdU=;
        b=AtlBwSJec6MBz8OkYbxsi1i4rBYdyBi3dQynI3L7lfbukufAu3uhZuKZ3hgK3sqVlE
         hf6bzgZPD9AYMpRy2loK23pzc626CkKE/7jvlUmaB2PZabcoz6slgSEY9UdXP9q4uCz6
         cii97+OstXWhTlNReHHVDoGBlYjLSVipWUlWeaYBGpNQCXKcBxWXUq8VGgbhAyWxLw/D
         cNzLwABOzLhnX97+e/KCY/gbT9lIp8PsROSHIlR2WfZ+3ee7zydEHvH1pCUzGhmYThG4
         dA2jTjwTxBtklCxPD5j+I5KOYHWDT9IQAw/B2MWnx6SoGBsBHZMymBLXnmickcfppUjl
         voOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKe7XeDU2HNfInVJkg2TCLbExjrs6t3XpobjWG0eVcNONM+zUFb0Puspd7zrxU0QbthcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YySU/sWTpn34q+OTGIdI1e+GFjvnTQ8x0BG8LJ/4QJsqBTC9cFH
	b23yklEfVpRTzEvPUQ6A3ATXS0dFmUB2lyb7+jjOyBm0U1/uyN/Ih18u
X-Gm-Gg: ATEYQzzPmCJDiFKT1LJKYPXhdr6mCXSrXUzeSur8ZJIupt50pHVSiktnHkaLyU86v4X
	QaFGwe5or8DGzjPRdBcuwfVb1NCJkpEGbwj0lYsSuXYVrRQximv4vX6j2flTufeFv4z4keZmocS
	VOOnejfNPWR/QeFBVdwGUpmskGOlC4jj8QVjMmNrRDhRjwVxvd6vCF1eds6JAZ4UqCXYR6Eo2nY
	AKHfb7aNUXyR+GMH+wMiLTP6xPkVcxMEHCW1/VuJzf7Pr9LsbDv2VzF589ChHD2MOEk2l4hZ8kp
	mDSD6/EUEkQGjsHp8bLtxzx+u8uskncThKrbyN52jaZrSvh2QkKzk8RsC1Ef9SYR9tvdqP94dvo
	WGD12dyqoCOwglAhaZZ/q90E+YlVgYLFAUxXes4cad986ItpFPYlm4ge1Fv5+59eVWCYg9vLW7q
	DJeyLMdgLmqFmvmdH+ZCXZo9G98/XTPiOoPi1LkdKh0CVLnu8Yv06lrSGgmOqc6Rc7WvQFsIgSh
	5Qc+FY=
X-Received: by 2002:a05:7022:226:b0:119:e56c:18ab with SMTP id a92af1059eb24-12a726cb15fmr5251025c88.19.1774295579999;
        Mon, 23 Mar 2026 12:52:59 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:45ca:895c:22d:457a? ([2620:10d:c090:500::2:8b17])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a736b929csm9926005c88.13.2026.03.23.12.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 12:52:59 -0700 (PDT)
Message-ID: <e6146408674366aa33097fa8c21f34ce9c32eb62.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Test 32-bit scalar spill
 pruning in stacksafe()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com
Date: Mon, 23 Mar 2026 12:52:58 -0700
In-Reply-To: <20260323022410.75444-2-alexei.starovoitov@gmail.com>
References: <20260323022410.75444-1-alexei.starovoitov@gmail.com>
	 <20260323022410.75444-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-03-22 at 19:24 -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Add a test verifying that stacksafe() correctly handles 32-bit scalar
> spills when comparing stack states for equivalence during state pruning.
>=20
> A 32-bit scalar spill creates slot[0-3] =3D STACK_INVALID and
> slot[4-7] =3D STACK_SPILL. Without the im=3D4 check in stacksafe(), the
> STACK_SPILL vs STACK_MISC mismatch at byte 4 causes pruning to fail,
> forcing the verifier to re-explore a path that is provably safe.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
