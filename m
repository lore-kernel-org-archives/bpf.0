Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C272D2D8DBB
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779732487; cv=none; b=bnELhE5YBI12kSxGefjQV2eSt/8LTa0rBWLVHodGVGRaIYs2OUksWjbWt93zNdKqVkOnuCTBZrh+ueQiXT5i5bp3gDJR3lfFNkVFsU5AuzuBOr/wmF3HzdkGt9S/+V3dkUffw8z+RJDBod3nmOWTiyooCUw9jxvroZjRWzicqh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779732487; c=relaxed/simple;
	bh=PSciALuNvGrWs88r7F4K049CO3zBnkyID+QEXAs1Qgo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Gal3FsM7y3502GRx6OfvF/VM1hSif41fIwyy0QbY91R2+gm078YZxwzbnEQQ5Jgzb5/rGbkSE7uGUiRsXDR0ZasWI7Ev5GmpyqwzDQ+NyIvy8IMouTpBfy1GETpBcfWXzbHt2htFyoCJdKdpfmqUI5B9hVdSRRbIoFAUFuAOSc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=01R8lJiz; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="01R8lJiz"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-135e88b8e55so256998c88.0
        for <bpf@vger.kernel.org>; Mon, 25 May 2026 11:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779732484; x=1780337284; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeKtJyL4qopbQdbdTa3wEz99vvwL45rCmc0Q/Ksb1lY=;
        b=01R8lJizKbHvKQ976TXzWmLaV3TwR1GwAVcuQs9ai0eXLu/cnnCt+1zcRkalsOABBt
         JHelCE6yT4GTQoQalUkkeKl6CfPQEWk50aBiVrQ3NLTqZiI7gkLqRbEj6zXMV7fooQk4
         MI7dQYGfgUDwbpL1vszBVRLqly14Z3ZcbDw0tSPGF1erHN5aJxaz3URH2xTMLDu3HbJ7
         bPZ0uB/F9XSmsV4/NJgm77bVbFv1Add/czaASebMLjvxtquyE3GSc6JaZojaqT9X1/Nk
         hq/wliTAKoptCPfSzdhDLQ53WHjdwjQjlYwjNtnU9kWclC8Nq29/MaRz64vPVjqyfqQe
         du4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779732484; x=1780337284;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XeKtJyL4qopbQdbdTa3wEz99vvwL45rCmc0Q/Ksb1lY=;
        b=Gfm7pWTXbaafsSejeqU7rl+0ijwO+xB77Hjcs2xumhbAPffVMJsN1GOSllSf3PurkF
         0d8WWQx2t+5gIP5CEDtVwP4FZMoc7pOBNTcl+UZnAvYxgzAKIppuBm17RonSU4mlRbIt
         7F4rfqsSfQXZDfAr9qoz8dDH/REbZAEs81OgXpNWOVip8dNoHPiD34PfxU8Irs39be4z
         AILPKcdE7OQJz0BzKE7Nk2lcQ6QEJHbGJytYsdsd0y+1tZwy/5Btma4lkICbS1x0rW1p
         PMgeeCXR/Q8ghBteQGyv/JZP/ArLbZrrmEo7Pk26fLjmyLit6PinQCtQK9fyZIFU/0vN
         LfIw==
X-Forwarded-Encrypted: i=1; AFNElJ/xPQ7P+2PUKXVDs+Ls6fz10Wl14hkeqCAPDbh2mtDujLSuTB1CfdNC4uRo/GvOTZ9hlno=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwsE3FB53ZGQ1AaPXNz3EfHJvRwIkvWLrr5bplhg36pgDCYiDd
	LswVov82r/vwuLlzDL3nvd4iVrIhdjEatoL4WfNlECxIACz/RidJMk/98ASdXa2cmr8=
X-Gm-Gg: Acq92OEbRQGfIFZZW1k5o4ttnckpewc6QwtQpHwG8rwNNPKcS3CEjXlNoqYH6RsCyn6
	wZY0JLpx9GF8utB8DnYk1XILdI8D0Pk/DlDyzkKJT3ZcEMy4wPt9+fZjdSQM/4fYFqq5zSgKhf3
	Mmm/tFFThIFaZLbbGKeZZNDuaI0QfdRS2WDLseyfHtaxh8xKwiGS83fxnBv7NfRJrrU09eIQdaJ
	/9jOsmymsD8zGPd3l0PVGehl+2oHeDhC29+osFf/13wZTenQj6nX8KdNqDe0i+3AFJpnr32WnBE
	kdVwyh1+ANBZeZMQ6ojvuyJEBzcAw4nzc8ecaT3A9SWFLTmFm5PWAQmxRWw+Fa99b1jqhDWDfwh
	ifLR1qJlF+HSfYOK6Lf7pU9EF/HT+6dxjaR7Jrv6XiAmCyIvr7GboyzOi7cKij445XNj0nzrpk/
	sOB+ANbJMRyJZNAw==
X-Received: by 2002:a05:7022:781:b0:136:fabf:2ffe with SMTP id a92af1059eb24-136fabf7b8cmr1074469c88.22.1779732483712;
        Mon, 25 May 2026 11:08:03 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::cc2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a2e672asm8079161c88.3.2026.05.25.11.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 11:08:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 14:08:00 -0400
Message-Id: <DIRYIEOYQ7TB.2PJ67IVMPH1WI@etsalapatis.com>
Subject: Re: [PATCH] bpf: replace pop/push emptiness check with
 bpf_list_empty()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Suchit Karunakaran" <suchitkarunakaran@gmail.com>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <martin.lau@linux.dev>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <shuah@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260523183422.124105-1-suchitkarunakaran@gmail.com>
In-Reply-To: <20260523183422.124105-1-suchitkarunakaran@gmail.com>

On Sat May 23, 2026 at 2:34 PM EDT, Suchit Karunakaran wrote:
> Simplify fq_flows_is_empty() by replacing the pop/push based emptiness
> check with a direct call to bpf_list_empty().
> This avoids unnecessary list mutation and simplifies the code while
> preserving correctness.
>
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>

Imo the new code is way nicer, so even if this is a selftest the change
is worth it. After addressing the AI feedback feel free to add:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c b/tools/tes=
ting/selftests/bpf/progs/bpf_qdisc_fq.c
> index 1a3233a275c7..3b05ac1d7c77 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
> @@ -197,17 +197,13 @@ static bool
>  fq_flows_is_empty(struct bpf_list_head *head, struct bpf_spin_lock *lock=
)
>  {
>  	struct bpf_list_node *node;
> +	bool empty;
> =20
>  	bpf_spin_lock(lock);
> -	node =3D bpf_list_pop_front(head);
> -	if (node) {
> -		bpf_list_push_front(head, node);
> -		bpf_spin_unlock(lock);
> -		return false;
> -	}
> +	empty =3D bpf_list_empty(head);
>  	bpf_spin_unlock(lock);
> =20
> -	return true;
> +	return empty;
>  }
> =20
>  /* flow->age is used to denote the state of the flow (not-detached, deta=
ched, throttled)

