Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792423042;
	b=ZGP4XDs2SPTpd0x439T03T5eP+wX6pKaHrW1+LFLjIo0IZgXUhrmW6juC8N7N0HCnqAZ
	 Xgr5BFJPJcEhSV4OLxuEVa8qM3tYJhAHMUMh3R2DRvKeUgONvUFH+hajcE3VQBFVJntGU
	 6HPCkeyEeR/6r6kF0gstWeH9UuKlqXEnkgHNn3mENKPFhCykQzb/cUUtePeVUxftjj5vK
	 Vq6ZSyPypgcO4YPBPJsytGnq5uNf5ORdNlMClpyCvoeg5qvoq4GqUnjWreL93YDPWLBRn
	 +m7c2ESJQwFeYUiVRGDMt8ZUn4JJwec8e7wE6jv8mjB6lNwGhlj6hZDu4InUuDTtkNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423042;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=g80TJgftAYOuY1eEY8Pj3cKxe/RJlcWG/Y9dI5fdM0I=;
	b=5jCbZGu7PTQZYfhA9nrDLHVS56msLNlbaWMPOV99Fao5PJgeipHBt9aVNI72aQ+edU2X
	 NwMiD1neLZSlCUbdqbDyBHnDYQevSSS5vh6JtHiN082b39kpeFYhn/k0J8g6y84e0Bh0f
	 3sfzDmY5A7dUmI0iOCYVoHR/cIFCwf4z2MlhLjW7CG7E2o6yoB6txyBSNzdhaJ10CLIsv
	 18977Dg9BskJvUABGsye0CkXERupG/fZJP6g/ufn1T+BWjYmgUejkdZTp7KHjcugNxFtn
	 QflfAoaJ4yNFqdJDffYxBiXapEAjJFjxJI7/edq3UwazYYuml2ksBmOZVZAEhmzjn9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ezLXwHIz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A850F60A2603
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 15:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A850F60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ezLXwHIz
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so18010a12.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 08:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792423040; cv=none;
        d=google.com; s=arc-20260327;
        b=lCIDjoHPToy8BkFEHr72/RNFpj9SFH4jjPbxuIzaR4GiYa71HHX3PrMwnRhTLuFvjq
         TpiXCf3ruzXUtXK7yy1x8r8A9GvHeIY/pqa40XsyLiNo2HUnz31J9bx8R4r1hHm5hN9M
         0+eZVw3zWTw9ViU7pP1IMTTRZuY/RSqNsswihX+r+8YE5Jm3eBWv3oCBgCp2/cOYXcZZ
         nNtg9/NUKx5Zd7IanAGRPMV5eeMvEv7KFwocpSYeboafNFDPbZbsQewfQLW7Yl9NXLgT
         kdvDeMI6th/yq7ZaZfmx3Y6Q3gm+eMa5jkXpJqWlsRHvoaMyfB89v50W5tDLkKM3b9dk
         P3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g80TJgftAYOuY1eEY8Pj3cKxe/RJlcWG/Y9dI5fdM0I=;
        fh=DpjytLHDIlwlG34va7woHoDNN7uG3nUqCdt49V190bI=;
        b=H6NSgQoNjJ1BJ3uEEQve5BpKec6fxHoAIRmXrtg/l/Idm7Em2psrJ+PPbau8MW/maC
         q4z6jFICkeru9om520qyzktfwdyz/2wHSzSXw/LlFYO9bqpvj2CvbdqrfFs1aX6e6ywG
         CLfHXqz7PusaUY4XAp4wt+eZKPldG9Xsmz5d9XP1uGrKtNNgoL5gOLzUtCSZqjuQOFn7
         FDoW4Pfg8tqhPDgxixMs7dTC3NNC9Y6ouKvd6ATA1uXGn8joxq+3D595DTXXxfDrvvcK
         3ZF5UQP/TgmuyT1mdGBQWqwDg+SwsDJM5ZA8UlB+JnOsF1WeIqht8uCrp6y1ymQVoYUQ
         NAXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792423040; x=1793027840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g80TJgftAYOuY1eEY8Pj3cKxe/RJlcWG/Y9dI5fdM0I=;
        b=ezLXwHIzPfS4sEb4a/lZXhXGEhuDtOUs1if1P/9Ak+Qq4maPAojdQ/9u0w1JCobLs6
         X2qdgAH/pLcQQVTxacqSHUYx6U1JRUcIZn4tCqNb3LkXxjpcgVHNqa3WoTOGvqyOills
         BiT2SHvEyuzjoiUDwEqrkKaqqIzh6GuaX4ulvYHeJnHQYLR1ElbgGP4U4xx7Lagi2fO0
         Vynf2ZaV+Wzz0LcbAkKRjY0IP9jZkLPwazVoJg22qEttAj4FtBF1o+o2OJakE541fU8u
         FgKrm31Dik2dQYyZFm8ilfQpMr5pGVDf4JR9znCUx7KiyvzqmlL+y1djjhWdf7HTbGCf
         568A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792423040; x=1793027840;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g80TJgftAYOuY1eEY8Pj3cKxe/RJlcWG/Y9dI5fdM0I=;
        b=cYG9CpBWm9iZI/n16O5qQrkiSZNi8AkmP33zR+zoOMBT+KF20MfhS8UjdiVD/yG+mp
         Raj/AVJInTQZQze3WbbOYG2Jvak2hSlj6tJBnMHqvk338q6ke/zuV2/QDbaC3YASI2nP
         g33AW8USn2Zi+HzMLI8Ewfh76wZagTQXT9O4oIsMVbzGFt0s6IQNHy9m500tbM4kMtmK
         g2RBFsg/8NmgL0A9GaBZxOLZMSfNQ+/H2INuU0FNf5lSNl2+I5n+ClGT4rXScNT/OLZ/
         vOCwuytBuAJ/xzo+Fhne5gN9MpPzCpKmFZVx4I+oNgYW4Us4eAg2RmlDLVjA5J3QgZSq
         CITw==
X-Forwarded-Encrypted: i=1; AKwUvBzigdFxh42u9wr+uBSRrvdHoZkrj/c1qp51MsKemK75Cc5uly3fEz9cUI4Queg2WKXIwoQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5fMSJzrD51nBpEECabBX99h0B/YCUvc41BO78VUJktwNSy2yu
	3SF+DRFrTw3r6bvzJpAOpUIQGFPuSOqHlXiJyZaI+8BSlCKZvWz9Oo1XRjbo+yugLLZW+y2PRFI
	RqvP+ODCchfn3akwkyMXGrQI7DIa/03XzokGdrOtW
X-Gm-Gg: AYBFou1XfZLnINR1yUjPq1mxfCl+wg9kiDLVMR0ob9cLtB9vt8RkC3M2N/PRi+9Xi19
	Z8jACMlJkMEfioq4pixiDmydTaBvMfvfKGSpiBqDJXpf0hTwI5DWXgMbOHIe8btHN6mbL8Dvd0S
	VweNvRhZhEEjQbRXu4EoIojYqAQ4tj6E3x0ol0ub62Y7Hn1j/QN2kKUQA79GQ+pvwicuOQMA52n
	5FgULv6haAjXTFcWj4eoE1Uppbp+r7HlGuZgIXGWJW1tIdRsRSu5y2O9JB3WsnPbUZ644NQYJY7
	MzR7VadyLG1slI/b6RtwNnOtjiKeYoGY4rAffQur9kJrakkNnLp5+fcgweJxkYk4vnpKvaNxCSA
	/pPqfMh7XKg==
X-Received: by 2002:a05:6402:24ca:10b0:6b1:cee4:8d8e with SMTP id
 4fb4d7f45d1cf-6b3c73e2b3amr54877a12.14.1792423039402; Mon, 19 Oct 2026
 08:17:19 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014173945.373295-5-almasrymina@google.com> <179209666252.434549.1850964039919625643@kernel.org>
In-Reply-To: <179209666252.434549.1850964039919625643@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 19 Oct 2026 08:17:07 -0700
X-Gm-Features: AclHuK-S5bmzvfsy_xN2FySxs-CZRN_0ke8ew0HfEdZQ0PJrgt9ujVcZv4HD-hY
Message-ID: <CAHS8izPkWy4mMj+mDyHq8rKfthzj3n7dj7=Phzq2sut79JydkA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/6] net: skbuff: replace __skb_frag_ref()
 with symmetric skb_netmem_ref()
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, ayush.sawal@chelsio.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, tariqt@nvidia.com, horms@kernel.org, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	ncardwell@google.com, kuniyu@google.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, ebiggers@kernel.org, kees@kernel.org, 
	aleksandr.loktionov@intel.com, petrm@nvidia.com, u.kleine-koenig@baylibre.com, 
	j.raczynski@samsung.com, wang.zhan@smartx.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:37=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The commit fixes reachable page_pool refcount imbalances but
>   has no Fixes: tag, so the fix will not be picked up for stable.

Yes, this series completely cleans up the skb frag refcounting IMO and
makes it all make sense and touches a lot of the skb frag refcounting
call sites. It's a bit too drastic to mark this refactor to net. I'm
suggesting just fixnig this forward for net-next.

--=20
Thanks,
Mina
