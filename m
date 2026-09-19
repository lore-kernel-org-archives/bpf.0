Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC9738228A
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789843472; cv=none; b=rIlhHLLaIAb36QBwX/rpB5Qs7XZTlp1oAPuIXLrc4iIlbZTod+xE5GRfzMnLglBiEjB0um20PrZCbuvPI9dVDJfKLJNlth6ddDSE95vWaWoPcOenqTGS6w7y4+VhTA6fdX7+rsXzSMWYC+PBnXUrDnKfgl/XR6JOAoFFhk3Q6Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789843472; c=relaxed/simple;
	bh=IyBkkraZdATPmiGJguXHdF/NP3CAv9C1kNuMLv6T2yE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GQ9o+pmsq8+KM/Dxe+PhOoc1MvXrADC/T/6F1oKyHk2pcLupUW/WubflPmfYCYQ8wGVDCuI2aniC1M038Tsrk6avV5lkOmqFNh2J1pWk8lgn1uePemnpWY6IkFqDNdihAmoDxAe/DfsgjXrC6F3302Udd6pmmfhaM+IZYSBi/KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcTPcb1+; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcTPcb1+"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469e25400so1347787b3a.0
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 11:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789843470; x=1790448270; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4UyPHqK3gOaRxzebrYtqKklssDaVX3hqCYZAmOUACfw=;
        b=WcTPcb1+OVPeb+Q9UqjiOI5oD49rcvCbLy00ThbWC7i9E45DHLIAnpfpAREVrviEpA
         ktgx+B6v1VxIBOd8IoqT/KWCj0l2q3E0G1LKNdsVyHkP7fMi6+7Hi9oMZ1dNGDMIdk2J
         mWpavRmAT2gxlPog8y/pT+AaJ2hk0r2P89v5cieWOQLImxr4WvrRFRZnl6ZZNBEPHzJB
         OXf5f9T824+jS/iL3TBODH+a2kPh8K9HRE4NdV67VxlzCj8yvtQrL6gv9RU9nRiZ7yn2
         Qyju4CMARYV3K57IKUylRnGXyasUORwvmQAQgm6s4hZSQ2fXUNM4RIDWqgUJiRUtr01Q
         5lfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789843470; x=1790448270;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4UyPHqK3gOaRxzebrYtqKklssDaVX3hqCYZAmOUACfw=;
        b=Jm8WskrJEFdpKv3ClGD2XRngYl/Y3ynhkoz3lyliSb8YjZld5LR7k3t2G9zg0bUU+G
         9YRXoSCgUGKDuQ57zxUJSY0UsncVwl2eBumUZjZeoH+ij6BacuhbGzi3FFeGwLXO56DE
         HHOeg34hLKcuEb6SryR8sxA7Ndw0xMhL6hHtx+MnLW3bll2HHYey9mF66liaWdk1aaoB
         QPDbQfMi45lsVXKFBIadhBwskzHTRSg8HxLQLLnHhamQZujGc/mPE5FVyicyrC69XGJN
         SQX+wZW2EuXUU1VKNHVJWE9gGB2izwHBQdCE2MoOZ4m035M0wFhMkZ/1vFCgi3ZjXv5t
         XcmA==
X-Forwarded-Encrypted: i=1; AKwUvBzvy9HwwQ/RYbnxDS5l+9H0WM8JpIg5TVpm6zymZceE531zQkbNHXo7vrmP6MADiQlnH8c=@vger.kernel.org
X-Gm-Message-State: AFuF++n8+SjZQcsavn29MFhPNGVumx/TvRWYYPcwoJRvJPseCQuueTNU
	cdyAIhNnqs2pvFOQ26wJ9imOhVR9OQIJguuFSJ44TIQMwW+9jzM0c5ce
X-Gm-Gg: AYBFou0aqybuFXFLxluhmvwjBGvMhl1oUD2JofcVI4te1ZNmJ07MwXSxTAxizneSsdR
	xAEkgbAClZCHwVHU1qAPJwXiK2EEfguoFXfZlq9Z5SHDKx0mQ5ZfpujUd+JlYWTNxMYCqj2wvyQ
	rVnrRN4/+FQiQqwmmPxUz/knWSGg4X/SGp74rk46v9jLSPAg3eryzjiR6RDywTgr2BOdy65UyiI
	tRA/2Ayn8RiU06YRzlhg6azkuE6a+KUPu6x5dfRFq6NLJHQHpYIpPvUJZcaq0q8Rd3RV5qbDfjC
	gzb0KypfglA10/idPwmO+ydFciISID1O8hFN85+vP/+tyft1Vsw8g++yTB3AVCpEdjO6Aftsqgr
	N8f7fQVAiBqhYgRasFyI24+El6o0rme+bTn8cbbtForJHJp1vCZnQBw6iU1zOKBgnNuDJ5eJ2Pr
	7TL+yI9shp66HQFMTK35EN6xuWF3A/ItZgtETv7JtMFrqScKOVs4Y2VCjWyLYHZIMzHSEdqdHM8
	w4kKXD+6tjO65IawxSpYnNWELrLCpL2+Hg4ph/xrcBQXY0GzE53+GuhqQJ7REbFkw2rNmUlCO6H
	mHY=
X-Received: by 2002:a05:6a00:88a:b0:874:705d:f63b with SMTP id d2e1a72fcca58-874dd9f81a5mr8900535b3a.29.1789843470017;
        Sat, 19 Sep 2026 11:44:30 -0700 (PDT)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877aa305dcfsm1255273b3a.52.2026.09.19.11.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 11:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Sep 2026 18:44:29 +0000
Message-Id: <DLJIK2JZ0MTA.1ODUKPKOZKFCK@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2] libbpf: Check for unknown type ID in
 btf__align_of()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Abhinav Madake" <abhinavmadake@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20260919164229.95154-1-abhinavmadake@gmail.com>
 <20260919174532.25407-1-abhinavmadake@gmail.com>
In-Reply-To: <20260919174532.25407-1-abhinavmadake@gmail.com>

On Sat Sep 19, 2026 at 5:45 PM UTC, Abhinav Madake wrote:
> btf__align_of() passes the result of btf__type_by_id() to btf_kind()
> without a NULL check, so an unknown type ID crashes. Parsed BTF cannot
> hit this since btf_sanity_check() rejects dangling references, but BTF
> built with btf__add_*() can, as those only check the ID range.
>
> Return 0 with errno set to EINVAL, like the unsupported-kind case.
>
> Link: https://github.com/libbpf/libbpf/issues/983
> Signed-off-by: Abhinav Madake <abhinavmadake@gmail.com>
> ---
> v2: return 0 with errno instead of -EINVAL, callers test for 0.
>
>  tools/lib/bpf/btf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 908bd3442..6bfbc7a65 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -986,8 +986,12 @@ done:
>  int btf__align_of(const struct btf *btf, __u32 id)
>  {
>  	const struct btf_type *t =3D btf__type_by_id(btf, id);
> -	__u16 kind =3D btf_kind(t);
> +	__u16 kind;
> =20
> +	if (!t)
> +		return errno =3D EINVAL, 0;

We don't do defensive programming in libbpf.
input is trusted.

pw-bot: cr

