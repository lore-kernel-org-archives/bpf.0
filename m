Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F80C136672
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 02:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785031364; cv=none; b=Fsz47TCMnySku2F3OP2GGOlqLi9arKMECSVanC2LY3gv/eAu8uZKT9+eVNxSUe6gZbehq6GnPrMnUhj3jxBcEWZnMnutOqSAkRvStblnOCa+T1eU7mwaZT3bq8sRiKkNIvwFLJw1FFJHaKUSd47MrOdZGksXO1Frdzwv1uBo7gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785031364; c=relaxed/simple;
	bh=8MHiJgXiLwaflmldyw5XZaurOOQUdmH7Ahr8KRIRGhU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ln+EIHUjdeqpiwLtZxzat3pJ7+KKvMN8U85BCCHHCEQp6dzmJcU/YVRS7pAvOM/nclKsvd5HAhBzMI4vnlnSVNW5v0fEwPXf0FEQ8UuiYb19QX1CRK4c1dFc/RgdqhYp9Hg4/MMHo/3zkNePfiVXyna44NswsUstv4VgkkhA8GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cc6gsF5G; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cc6gsF5G"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-47f7f93b3d4so420492f8f.1
        for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 19:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785031362; x=1785636162; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TDTuZ70qXufeETtiXikOewPxsFp3y1jcFjaKcCLz/9k=;
        b=cc6gsF5GWi+1L+YS60KtaFIMqhnvCBJ4W3Xw2C0xwlseIrPPpuPzQWMChevlZdjQL4
         SubLoXQd9/tdSaiLNMAZN1rcuWKn4aUCYgERQ0ZTR62uN97R5Pqvo0q9U2qvMhgPgXHP
         hWfbSf9wKe+am1OdTjHgFHjN5ezqy+8Dw6/ljMLVTGlXH/Le7CVKXZrf0459UvCAhFdg
         HYlZzfWjqK4SceazjOWAjdNtyO47uE4jw9zYkuS3IUKp0CCfSiWHzS3TpD9SlZvGRFcU
         rZnXpH39flZ2BYDIPEDG28Qa3TKtLA/0cnQgYyDTEYOpraX7w9r5v5GciTB2BwZrwybo
         Wa4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785031362; x=1785636162;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TDTuZ70qXufeETtiXikOewPxsFp3y1jcFjaKcCLz/9k=;
        b=e2NCDznCUYsFzPahKx8L3s2c0E6XmIMTLsBz1on6weAcchDnQ4pgvMOX5y3Yydd8sK
         vAAUmLykMfZAqHPmJo/eovjZPiJ6PmCh78uTVpJSrJxXAmuFhbMZXWLwNnXEvb/9m+Xw
         Bln7Fk71Orq602JcdZnjZn24IjmKjHJVkvPh3UHj36iZu0d/Hmmli4ZJX4FulXzflnT4
         6zY0NmwqmNH8/AK6Z3REOB9CETt+nOa9cCgiGm0IfIcQtZvKsu1cl56vfTw1OncZellQ
         F9vkFbLsSaQxV6z/9cwE7MmkCLUtAaN1QLkiPAsUjTmkOrfkcVdtbvdEHHbwFTd8ealR
         qLaA==
X-Gm-Message-State: AOJu0Yxx69HzlUFj9BNhgykSsen5ao5DUP9r7xK0nduekKY/hy3fnhH6
	u1ripmQJ9ewOZQSjb+No/XcGrQFBVdNMVL22wJUudfnUPSNUzeLQ2IAA
X-Gm-Gg: AR+sD13gJR3bDEVcnr8xjE+fPWfDSasmcH+3DRitZw6wvfYT+SM+fX8KqcG2TX9kBEH
	dpOHio3eFp/PC1iMxr58ljukzwFAhazUaENe/2WEkEouecB6BCLPSSYNUyXD/Hvel1KmuuQcT//
	6X6GxNpGwmDG9Kgo4erc54/jragrY8ER84XgfviNmw6s2at5RTYauRS7SbpX74YkXNruj0QIxas
	MWI2gNo68YfZ3e9Vk4Zcumx/ZxyjRX1IOXB3mPlBI7uXLOQ6yt4HJ2nz2FnIrSrd+uqs73RNHK0
	nH+4digDVS0oCkbgscYoD3tYGGipG4rrOBgiH3JMl2jPjIFbPM8rY71mnxEvIVYO+U6+ef95R2y
	ue3geMXQGRjbpC/e5KHgYIGZ2LpNBRg2TAOQ7k6s+q5Gdj+eeX2jCrNTW/vus0NcTJrYHpA99fJ
	l/NDkOAhLgdEhCOxTW/l0gGyO8GJXyN6UdSxJHk+ncWl63h3ZOt/L6+g1dpecnVcCguLSfXJRQt
	R754JNf/m4O7BEopoBAYh5BWH6Y2JkObDsrdRzJxD34
X-Received: by 2002:a5d:6f12:0:b0:47f:9171:bca2 with SMTP id ffacd0b85a97d-47f9fe9251dmr4624238f8f.27.1785031361520;
        Sat, 25 Jul 2026 19:02:41 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb5127sm35291767f8f.10.2026.07.25.19.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 19:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 26 Jul 2026 04:02:40 +0200
Message-Id: <DK84T2IP24QC.2ZOOOKY4B7MWU@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 5/9] selftests/bpf: Add kfunc __arena and
 __arena_nullable argument tests
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <20260726013105.3689867-1-memxor@gmail.com>
 <20260726013105.3689867-6-memxor@gmail.com>
 <20260726014114.A795D1F000E9@smtp.kernel.org>
In-Reply-To: <20260726014114.A795D1F000E9@smtp.kernel.org>

On Sun Jul 26, 2026 at 3:41 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The `arena_arg_stack` failure test is conditionally compiled o=
ut on compilers missing `__BPF_FEATURE_ADDR_SPACE_CAST`, causing a false te=
st suite failure.
> --
>
> --- Patch [5]: [PATCH bpf-next v2 5/9] selftests/bpf: Add kfunc __arena a=
nd __arena_nullable argument tests ---
> commit b7abeb2e41481276f90bb3144448d08e3c6e2c96
> Author: Tejun Heo <tj@kernel.org>
>
> selftests/bpf: Add kfunc __arena and __arena_nullable argument tests
>
> This commit adds kfunc arena argument tests to bpf_testmod to exercise
> argument rebasing, various accepted argument forms, and verifier rejectio=
ns.
>
>> diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/tes=
ting/selftests/bpf/progs/arena_kfunc.c
>> new file mode 100644
>> index 0000000000000..e7250c5197ab4
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
>
> [ ... ]
>
>> +SEC("syscall")
>> +__arch_x86_64
>> +__failure __msg("arena pointer cannot be a stack argument")
>> +int arena_arg_stack(void *ctx)
>> +{
>> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
>> +	bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
>> +	bpf_kfunc_arena_stack_arg_test(1, 2, 3, 4, 5, (u64 *)1);
>> +#endif
>> +	return 0;
>> +}
>
> [Severity: Medium]
> Does this conditional compilation cause the test suite to fail on older
> compilers missing __BPF_FEATURE_ADDR_SPACE_CAST?
>
> Because this test is marked with __failure, the test runner expects the
> verifier to reject it. If the macro is not defined, the program compiles
> to just return 0. The verifier will successfully load the empty program,
> causing the test runner to report a failure because the expected rejectio=
n
> did not occur.

I think the goal is to not fail compilation, this is fine as a tradeoff.
