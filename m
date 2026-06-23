Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCD138887C
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 03:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782184282; cv=pass; b=iwpHhMN+KoheQPq0EUtlOIhY2WxtIoRhWH9AH7+4y5w+nqK2DAUR8Hpp97tk7Ruph/GECnaQUds7y/SblWJlLF5wA4vz5lkGxqQywmCGPOO+vr10Jz6jaOXRDRtmMbzQSogJ30Css1NpFyRyz+xGh/zlyNAXHj4JT+2OsKk55EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782184282; c=relaxed/simple;
	bh=5tsJG8K11FH33t75X0aMZwkwKArLiDR3LlMxbCGTaK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JuMJaDV45yfUBWlvwkqxv9c7/ebBNq9d7XmSOvDyr8chyZIvG4TkrBvjqmtBPMXMEp+ps9eyu5VfTZuvR8tF4R5+UgtoxccbsfdzqRxLahOaCkNi9hw6hy/AOsxLWG76mziwxyR3i75Kv96jRL5CTuB4JlESHnMNM30cTE+I+8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rIvU5v10; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIvU5v10"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c86307c4e6bso1918291a12.0
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 20:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782184277; cv=none;
        d=google.com; s=arc-20240605;
        b=M7CyeD5WiOQFBRxGDYp+816TgrfEUdZOhGVhO3AXtU/iANRyUh9HZ3YY5Dc9PdLeAW
         V3VfNFggHXmQyuf2W21QYQPL+1Rl2PE7YIB4qg5oA0Jk/8+xVC5ustZRhYdT7dfFf4ZB
         Tib3WnR8qZ5r+4QH6O4stWtwuZU9nCNWD9TkFxLTnYHMlxm8PIZLoNYQWvuMIT22rOdi
         5l838GNjalyy3AOdl6/aIZ24h39a6I+FylWdcB+nT2mzBrtrz0tVssYXsSs3SMdzEBc7
         CykEohKUmxX7Kxhxq5d2/sHUO2n/Rx4Tqa5N11KM8pa5JEVQeuSqA3y6Vy/E43uBuio+
         R7yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BjtwR7xlZwTKzwmfKPGdqr9b1raakaR85K+/MxsMuxQ=;
        fh=ApGGcOjPPYnwOpl1ZkMZoYGpXHVmAu0NOAOtt7Wnpgw=;
        b=KvZ+PX5MlB17UwKJppc8kzK1l0wKwo5zShnSMnx/TJlk7bCbOhCql7tQ10L3O3dITQ
         dTtMCnuScfW4QsqNIliPExvoZwNKE6/aZGrqIsKCYCKeQj5s4mj8AJhAwjEMmnAz+KLK
         6MZL2FaVV+pXLXOY10S3KNvsNqfJHyR/hxl99FCyRdxMuinmsiVz25fpBBEKob/z917w
         uoXzv2ZjPVBmeS2kgl+NJoY6MCIhlqUQE/zZ7Hl+SlHJ8EUpRmhc1wIbJ6ZZfB6NuDbI
         xmA+5VylZU702wB9Key7tzCIKzOIHwsfL5Vz7JT7y5/USEaG5kZRwuSJQPiFdgMgIpnz
         zmoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782184277; x=1782789077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjtwR7xlZwTKzwmfKPGdqr9b1raakaR85K+/MxsMuxQ=;
        b=rIvU5v10tYjFohKj2Ab21hSM3Rt0+B/gvpNfbrNGzoFmcE23woP0/R7tRHgqvq0pbu
         fWsy2FYn2yCdppbXd2PHnmvuSfNnszKQ+EY3RvnrPLWXPYNSy9HkHmeGnLYYu8+aofor
         zp8jXP2KEs7UlXnORd5Z2drcxT6t1tGkVsMyaeL50dAQav5rMZSfi+7RIqIibh4CEyek
         dlYHRm+sv86RcPbLWgkEwqcmvd/j89h+IWW7gjI9rF25y/Xsr/wyk61DRf1KtbUofBpT
         h4UcHQceGY+w2tKlRM4K8Ek/BM39XdoG3GAjDTaTZ7r36IdnjgofTTxXpFfI/rBBpxRd
         dxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782184277; x=1782789077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BjtwR7xlZwTKzwmfKPGdqr9b1raakaR85K+/MxsMuxQ=;
        b=RjSBZowk1dI3sstK92P8980mGKo+Ss5C4w4UuGWhKytRiCxLfU2iujjhz9KhI4Siwe
         I/fhdvkYT1rlcAFhvJQxaYIpEWQqPyCF2UZSTcc9OXqraxzsfHBs2nSPGqgp6GTXqjVO
         pf9TH8BiMv7i5jdCkWfMJB9UR7uhUBH9zktargRxD4bkkIZma2qzGzM7U3+afr2+TSDq
         hobb9HCy+Z41+GCupC9D8o8SwAkniXhF0tSsE7b0X+8tCm7moeJN0LjI6bt6dFX0B9Qt
         Us8dcwvM1/+arpil66RtZ/hVMGebnXyDl41cZzbGDOTANyADP4P/BLoPhEFXO8y16LIL
         3ZwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/LDvD2j8oMbyjjiIZg+qVTbNnh5/+6WBkB/WeiGWxpJJcZDvNwJ09sPX+USq6kvdpXN4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNorhMtRk5LlA9/aDI+HY+rFKmpD4yYLD7OdbIuaA7OJ092NNN
	KOx9lcwe6NE+9OW2bB6W9/rIJ1nh6hhwRkcYyc9kRt8puPwKTwHl49JM88b/ctr6ksmcQhfigCs
	1ludzOpARksLqLFJXnWySZlemLFOvYOM=
X-Gm-Gg: AfdE7ckqbrPzLDS/snb6MybwrxQVQxZp6W3s7FqZsZCYYG1FhAUoIZW2n2Y5iddkXjY
	ljyg4nqspNdu9tcwkqfExfiW3fY/79vT3Z3BEk6UfFTEwBY00X8t9rtObFLz6JPOAeWb/oulzFX
	H0sd6ghlax2KhsM5Ng535NATqIuPvidykdYNaEo+CLwLfmaUJh2+13BjQLWgYHG1MNNef1JeTm1
	DWOqkniTZW8nBvS6zD8pe7QZDabiYIl45islixS3pA5iKI76V9gvCNMlf17Knf5UC3QZZapv8EG
	bcmaZEjnCiPfln0Vhjde2wLhxXNoQJDXuMORGvcn7Kl4PaMNtIYdO12LBYu+5LYu6Gm6a6LDLm9
	8utn0qdhU/Y4SxA==
X-Received: by 2002:a05:6a21:6915:b0:3b4:5c70:ca3e with SMTP id
 adf61e73a8af0-3bc531af581mr15488925637.25.1782184276701; Mon, 22 Jun 2026
 20:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619130305.27779-1-include@grrlz.net>
In-Reply-To: <20260619130305.27779-1-include@grrlz.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Jun 2026 20:11:04 -0700
X-Gm-Features: AVVi8Cf1oIzvdtEGICckV061Q81IswIClpWIZQWhYHurLRYhBKU5VvvDzlC6Veg
Message-ID: <CAADnVQJ4rpEMdj3jq9d0AFNcZterObQpJQiQ8VLwcYUph_M+sg@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: lsm: disable xfrm_decode_session hook attachment
To: include@grrlz.net
Cc: LSM List <linux-security-module@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Florent Revest <revest@google.com>, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 6:03=E2=80=AFAM Bradley Morgan <include@grrlz.net> =
wrote:
>
> BPF LSM programs can currently attach to xfrm_decode_session(). That
> hook may return an error, but security_skb_classify_flow() calls it
> from a void path and triggers BUG_ON() if an error is returned.
>
> Disable BPF attachment to the hook to prevent a BPF LSM program from
> turning packet classification into a full panic.
>
> Fixes: 9e4e01dfd325 ("bpf: lsm: Implement attach, detach and execution")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bradley Morgan <include@grrlz.net>
> ---
>  kernel/bpf/bpf_lsm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 564071a92d7d..1433809bb166 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -51,6 +51,9 @@ BTF_ID(func, bpf_lsm_key_getsecurity)
>  #ifdef CONFIG_AUDIT
>  BTF_ID(func, bpf_lsm_audit_rule_match)
>  #endif
> +#ifdef CONFIG_SECURITY_NETWORK_XFRM
> +BTF_ID(func, bpf_lsm_xfrm_decode_session)
> +#endif

Applied this fix to bpf tree.
