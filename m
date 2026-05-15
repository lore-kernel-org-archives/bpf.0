Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C1B13AD1C
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804013; cv=none; b=rZ0rDBfeFXsJjbmZzP1iwNinQu3dOUPBJs8IsNrg3JSgv0r9E+KCNDHu9PnmWhtc31Eg2K6ELMTP3jClN/FXbh4UPgyBZct/mrJsyobqrWuVFCU1NGdmVTcSpAnmcBHj6s8O/4hCY1Y97GPzkW1ApbARSF2+grL9jZFVZfUkcJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804013; c=relaxed/simple;
	bh=IzXeTum+O4TLPFtcINPwkOO5AvESEx+8d9gU6iCTsjo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kIHkhY7U6ptSbSqJCpEEBZfgOfnz8gStmWzCh7EBZo6Fe5eI/0PJjq5EtN0gKMVJhAAsntzLXwFqYc+70M+d/dtLUKOmoZ7lh3ZxNDA0LGaK8xfs0TBi3f4iy+sLvd1PGYeToaVkir+A4Tm4IdTDZ17oxJqYza5Kr2uAma4Sbdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JChh01tN; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JChh01tN"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-40946982a78so3130365fac.2
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 17:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778804011; x=1779408811; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omOMqJpsvXh3BmUDWEnNbmI7PTRYsCWUTUM23wsY/BQ=;
        b=JChh01tNF9ESKApsP2eqbv1J0eIQX5vMHGJoc5mGi6O2CcL3JVU33MTqhc1QQjZkw6
         Kyi6HbYn7EVhBWoo5ZPDnxXl3FY39u7957APQ+WU4JRiySG1d30WIkF9ot/iKX3s2Ysx
         nVo7pLDzsj2KFV2kgj3IjVie43ewE8MZRiztFmd0ygsuxPq2Ai3iJ4f0q5sO2JXmPBND
         pBsDEgQZXEigpzGeRotiFZ9Osi3mRQALj54/IrC0ckvLoYuukWXsEWrfsdj7F9K3izN3
         gKapeoa2PpLcGTN3h/rvAcnM5HBmrf4ODdw7HFC/xUeNGEy+fPMb09pXFLoE1Ay/NI3h
         eKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778804011; x=1779408811;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=omOMqJpsvXh3BmUDWEnNbmI7PTRYsCWUTUM23wsY/BQ=;
        b=AiacdFeybAQXcjtZ3pZT0wAVOvIlZgVT46ulVszesOhT8tLRYNdFLtKk/oFuOZfXng
         rJU8F4xNXRC0186bXVhtW10u8k7VK6ydJ8oWp3YWgnbRQhasSubaL8dWlT0uUrSbuLwX
         b/jq/JoJw8dpI6Ww7E5tbcmjthS4qAx5d7nqGJTpFPxKG5yD5EIYUZ2CixYekj53c4+C
         QmuUZqmk88hoxQf2uKq3uN/OszjDpk9waAc2GjpXAA0y9oUz/wsv9ZMNlCoFK/kN82sI
         OzRLu+loOGkjs4CcVkrq4vjwxNxfl+Op76aT3PlZY6O9TWssA3XkkKeV1FgAU+f0WrNW
         pmPg==
X-Forwarded-Encrypted: i=1; AFNElJ9qun8IEy10kF+BUlp2FTsIiuEMio1IZoq8qwgg67DR5nYJibXmHKjstoWtksltLQBAHf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws6A13NkOr9iFtXmSR1VEBhEcQ49mMgcXFjhP1vHzTujunRJQz
	y4nZLimlS56IKMESVqB2KxuQCiBM/MW6DIjZCQXHxbW5IE9muLan46SD
X-Gm-Gg: Acq92OGYZw+PZmSlXGvWcjlEYcIhBJvHiXzbASLVNUnIZs1wkhIbbgcw9+rDnPem44p
	eyI7tvaiaXpkrRstCIDgXNcGJbcpOOu1pmZooC1kCTiFN09Vlul24YA5BYMEPLedR32szmOZ5cA
	bbYQtElxSE1+TT/VycLyTCSXV62/ZoTzHv5p2g3ISwT5tR/tvvEtcajYL6XWpjfk4scntSoREhD
	Tye0HoGu0cYkKWSlISw5w7pu+rvuPZaiPoPXXpHyy+Fu/gVwSkZ/CR5ygXXH5k63pDkKcGCIQID
	toy9RLku5uhACRc7VnfEvvRAJIINT1OKaQ26Ul6A0CxaoEAg+NrqoLCWT174hKtf+5SMNKunsmv
	HRbxVqxiqQQa+0ryq57DQU5+xHA3jfDWI74LeAhpslijmTEyFUjpWN8rBQHpnvosLibwcYyg8NT
	VsRoL8ISqx38ly+6FjHp7JfhjpddTLmWjyw8Gt+7l3vUgFw5rMYB6eGKFKT07bg0Nd2jaXYbuiO
	KESax410pnWUi/kb4uIPe8+lTTR
X-Received: by 2002:a05:6820:608:b0:696:1882:dd04 with SMTP id 006d021491bc7-69c9bfd21e7mr1216648eaf.52.1778804011097;
        Thu, 14 May 2026 17:13:31 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc145b70sm3131085fac.4.2026.05.14.17.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 17:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 May 2026 17:13:29 -0700
Message-Id: <DIITE8M75CDS.2BU9SNYAPDV8A@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <song@kernel.org>,
 <mattbobrowski@google.com>
Subject: Re: [RESEND PATCH bpf-next 2/2] selftests/bpf: libarena: Add
 Lev-Chase queue data structure
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260511214100.9487-1-emil@etsalapatis.com>
 <20260511214100.9487-3-emil@etsalapatis.com>
In-Reply-To: <20260511214100.9487-3-emil@etsalapatis.com>

On Mon May 11, 2026 at 2:41 PM PDT, Emil Tsalapatis wrote:
> Expand libarena with a Lev-Chase deque data structure. This is a single
> producer, multiple consumer lockless queue that permits efficient
> work stealing. The structure is lock-free and wait-free to minimize
> overhead.
>
> The data structure exposes three main calls. two of them are available to
> the thread owning the queue and one available to all threads in the progr=
am:
>
> lvqueue_owner_push(): Push an item to the top of the lvqueue.
> lvqueue_owner_pop(): Pop an item from the top of the lvqueue.
> lvqueue_steal(): Steal a thread from the bottom of the lvqueue from
> any thread.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  .../bpf/libarena/include/libarena/lvqueue.h   |  33 +++
>  .../bpf/libarena/selftests/st_lvqueue.bpf.c   | 194 ++++++++++++++
>  .../selftests/bpf/libarena/src/lvqueue.bpf.c  | 241 ++++++++++++++++++
>  3 files changed, 468 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena=
/lvqueue.h
>  create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_lvq=
ueue.bpf.c
>  create mode 100644 tools/testing/selftests/bpf/libarena/src/lvqueue.bpf.=
c
>
> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/lvqueu=
e.h b/tools/testing/selftests/bpf/libarena/include/libarena/lvqueue.h
> new file mode 100644
> index 000000000000..c4091387c7a1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/lvqueue.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause */
> +
> +#pragma once
> +
> +struct lv_arr;
> +
> +#define LV_ARR_BASESZ 128
> +#define LV_ARR_ORDERS 10
> +
> +struct lv_arr {
> +	u64 __arena *data;
> +	u64 order;
> +};
> +
> +typedef volatile struct lv_arr __arena lv_arr_t;
> +
> +struct lv_queue {
> +	lv_arr_t *cur;
> +	volatile u64 top;
> +	volatile u64 bottom;
> +	struct lv_arr arr[LV_ARR_ORDERS];
> +};
> +
> +typedef struct lv_queue __arena lv_queue_t;
> +
> +int lvq_owner_push(lv_queue_t *lvq, u64 val);
> +int lvq_owner_pop(lv_queue_t *lvq, u64 *val);
> +int lvq_steal(lv_queue_t *lvq, u64 *val);

One more thing.
I feel the actual alogrithm name doesn't need to be in the name.
Maybe
spmc_queue_push()
spmc_queue_pop()
?
