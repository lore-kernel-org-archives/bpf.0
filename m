Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4F04A33F3
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217455; cv=none; b=TtKOIU2n/njKNLPQlovG8of3qpR3JwHF4OEv06GzjaIb3q5b6aAm/ar+rslMuLMtOS1CohHa4PPowkZi8J5ogQckAU1TCEL9bb3MAXVZGTm+SNBtAWNdCH/Ya/XU0I7I//xwLD23t+3OXluPMDggH7HYYOgNg7beOwQBfppbffI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217455; c=relaxed/simple;
	bh=NNw4t0j62so4mIbfyTN6wpYTjiTvWXyAzoYaDuTnz1Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fzWT4ASKHZk8bA4SJotK9Isr5z1BwDbjxshgua23s03g4IYOa3EY7/GlaMALEQkLfKbI+i/IgQ5Tgieq3G610CTE3fOb+x0zqc/EPenEVZaUB3Sv9+1Awzu+ySrGvH2wK7Pg0cPqXFL55caU7oJdnsD2wfL2SGqSioLmpYg+7Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=wmJzcvGu; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="wmJzcvGu"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30807ba471bso1085036eec.1
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 15:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781217453; x=1781822253; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnD5r63ZF+Pg+uk4FYDqNnxK759W7VUsLPGv0soR/74=;
        b=wmJzcvGunUtX7SQ1Q1LctiYZeDhsu/dT7wLFAYk4yC0YbuafrqvBXH8EmT+QNQr+Qy
         q+B/MNEwGMiHe7nwVPJRGk70vVdjugMLFBgD2PZJWLIkv2th962QcYOsNN8NKeLE/uI/
         VNj5SFLHlS08ddw/YTPsU3eWqfkqR5O4CKODd8tx6C/I2zmxfMXTBunqgTjxrHxNYtau
         x6Li7vlZw7kCTqlkQgIyqgnz0gm7hP9deULsJ8HDQHBVyS23sTi5uRa/5kZ4gqYT2DIL
         utfjJ5OjJx5JK0Q7hnJA+UNfXc4LURUP0mzn8zsIedL0EesohyCGr7IyIzkC6SgHFFJb
         wveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781217453; x=1781822253;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TnD5r63ZF+Pg+uk4FYDqNnxK759W7VUsLPGv0soR/74=;
        b=N41M6wzrb/BHaV5JofMTkQAcTDzfqQmLPNaqH5H3TZsKjUkhE6FjRug5YO6pVZ4IBc
         wQuIs7qcgXYnmtNK0b6pYZSsUVLshARdpoKJ2C1oglwS02Xnh0D5HpGQiPHISlWJr2gd
         grm94YEH1ahDc6r10skio5eDvnhP9yuq43wfX4C/nlF+/X88J6+gyIHubDxJRL5QIuAh
         ebn9siTe9YtegyPoqE8+Dl0BGUeDIqFfQtgMarlByajWqSfZ0n9cTYABh5aQrJNuNGGC
         kzPGtdUIFX6J6Kz3Xnc1KkC3ZtZvhTt8CTFSiCX5Rki+feepexBIae7nc7ACtLZvi+hh
         2n1A==
X-Forwarded-Encrypted: i=1; AFNElJ+/ZAbgimXAq/MFO7VRXObxqpjj2pDFkpX01h9pCvd/sxegY+DpzixXUGB8crtqzcPlL/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmTNIg7t08FqcOLd6z6j9+qMJDODFJI0uQOfZt0TjufaLdBtpA
	YJdSIzI2LAMPxwOaELT4BVrlZrSkNZ3lsWvqTV89Mv+4rjKlUIId57pnBaoQPUkO+bw=
X-Gm-Gg: Acq92OG+hYb89DKARjErl1j+PrOhUBGeleUWIfF3oNfjV+vUwtqchyLDdfTnyu3OQIN
	9Fa4lP6Pi9KYwetGBxJRD3XGATULoFbK7L/YKHR0KNiHeNLOAON4MAFbT0n0QTp9gmkrFL2MIEq
	dPpxbC1FC3v9PZR+ZfaB3XY2za/YCIbixRgTdeWKWZ0kbAPCLSEzFUzBTjXkkkROolhnWY8LMnE
	edxVbokbYRXxNRAIHzGEnBGdccFXEXQ6qjodag0yofpTuLEZa8cvA71ZPh0AkindZN3OeAn1Pgd
	0jPi1902/vyvfLZtyqVOqDQY5IBMQpyVSwiDLkfPGxC58rCvSXQcZHs6fWEePHTL+WSVcYye9mf
	kvjWzlTLVROuHy61G1lNsvqdJKvc/m6hYhEghjOnjy3/b0z6KIisWX15MlmzcARwyNDzFpGBNyy
	iP3fil
X-Received: by 2002:a05:7301:2290:b0:304:997c:d43b with SMTP id 5a478bee46e88-308201e666bmr172700eec.34.1781217453228;
        Thu, 11 Jun 2026 15:37:33 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::3c95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5fefecsm696102eec.13.2026.06.11.15.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 15:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 18:37:30 -0400
Message-Id: <DJ6KW05ZSOIS.1K4K4A5CMRI8W@etsalapatis.com>
Cc: <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/bpf: Add test for sleepable lsm_cgroup
 rejection
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "David Windsor" <dwindsor@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <shuah@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260611143549.703914-1-dwindsor@gmail.com>
In-Reply-To: <20260611143549.703914-1-dwindsor@gmail.com>

On Thu Jun 11, 2026 at 10:35 AM EDT, David Windsor wrote:
> Confirm the verifier rejects loading a sleepable BPF_LSM_CGROUP program,
> as introduced in commit 5b038319be44 ("bpf: Reject sleepable
> BPF_LSM_CGROUP programs at load time").
>
> Signed-off-by: David Windsor <dwindsor@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/testing/selftests/bpf/progs/verifier_lsm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_lsm.c b/tools/tes=
ting/selftests/bpf/progs/verifier_lsm.c
> index 38e8e9176862..2f8103bfa14e 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_lsm.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_lsm.c
> @@ -188,4 +188,13 @@ int BPF_PROG(null_check, struct file *file)
>  	return 0;
>  }
> =20
> +SEC("lsm_cgroup/file_open")
> +__description("sleepable lsm_cgroup program is rejected")
> +__failure __msg("Program of this type cannot be sleepable")
> +__flag(BPF_F_SLEEPABLE)
> +int BPF_PROG(sleepable_lsm_cgroup)
> +{
> +	return 0;
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
>
> base-commit: 30dee2c176e7954f63d1fa3e52d172f30beb9bfb

