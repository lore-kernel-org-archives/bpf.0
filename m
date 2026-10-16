Received: from mail-oo2-f4.google.com (mail-oo2-f4.google.com [74.125.231.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DE81FD4
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108858; cv=none; b=bNu5n/inrLGe1olw74ibl13aRxbl/F9LrwgZO/b3XUAVqcS8OuFqub/LawhlqDRHcOJYDrQ4RzCVOOXH38D27/0WYxW03wW90sLVpejYN8V/zisnwCQHZ6HA+O0FZofNR45vtIx/dYiq7U1CI7tZXHifYiO957HUIU4tx/hkyJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108858; c=relaxed/simple;
	bh=rc576oAlRU8uqOgzTL4NdkRr7KJ9NgDT4EJG1ZlLOEU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:
	 References:In-Reply-To; b=jAAkmWiw4W0bq44//K0DPaFDf1oL9NARGN0l9Ef7OGbQEAerzH3AA0sB5ABHY7TVeYlC8ku0GSDKWWTwg5TnOToHHeachMZvuZjPrFjxoyPH1KSivrk2aQx5ijwS/+2CAMYYcY0akzm0C72j+NO3hC0Bpq4azpsNgBISQyYKyEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NN8vcNBP; arc=none smtp.client-ip=74.125.231.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NN8vcNBP"
Received: by mail-oo2-f4.google.com with SMTP id 006d021491bc7-70073621339so416992eaf.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 17:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792108855; x=1792713655; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:to:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9nyLGYOdUaK5cKNK/vnwHJktmENqpWyK5LpMGcAyO1U=;
        b=NN8vcNBPd+J/+agunXR1S5S0Q7TGihtrHTXMmtPIsAbMIF4SbbvdH7fHu5v5nEkooN
         Ld6jVGlC1abh4HsVL223EcRjPbM1lMRV9QWwh2C3mBN0m9caePlv9Y+1T1XMAJLRD7J6
         F4xc/c0aTHpmQhmMn0WZWDm4gvZ6kOVQ5sQvJhKvhloRLyZETUUwKzd1JPGUDyUwL9si
         7uuxwRXkgAmN5S8qZSWczviTD6t45fi+CWKMfVZYUi9Sbjm9TJb1l/xgTV+Y0XGDwcYq
         JIwpo7IjEyQfhKQ6eEHIGjoGxuvpUlL7A52GW7VmKIzA7c3CuH7yJMqtfNf49ab0yR5E
         laaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792108855; x=1792713655;
        h=in-reply-to:references:from:subject:to:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9nyLGYOdUaK5cKNK/vnwHJktmENqpWyK5LpMGcAyO1U=;
        b=ECIu/5JONOcrcoF2PVaCi7jc8Nf3HicRmj3aYhGV7rq7u3G3ejPA1Y12SWa7YDa8pt
         iEqrpwZbHfM7K8sT6omKXjo0+WQznGc6yYjbt8ySLC9dIWVy7AG3GOVAev7lYjjd1LLV
         kosNZNaH3ILbF1SrUlF53BwaycJ10qBxLlxcC+NzSU1853a2gzv//iKqXOzZtAhLtfpI
         Y432k1YcDJQPOwCJAQIvAkomGMI1UITz3M/fWDTkqRl0I5T0CrLlr8kyol8mkjAtNOzZ
         yIsk8BwfoNpyym+5ZhPQZxpnoQ1FNRVE2tlvwY5OSrvHBiJFnbVIh9n5jZhXJdnKJoqI
         81sw==
X-Forwarded-Encrypted: i=1; AKwUvByULs4YSDVS/k678RfnvjL5lCObmi72yH0IzmYj+7mBoxbU9P+X5tRUxxHfGxrsVVQiN+k=@vger.kernel.org
X-Gm-Message-State: AFq9FYIig6oVbbkJXMHkdAjh7qA8D7Qi+5ggGHSAyiznHsI4tg1WWPNq
	zuzsvo5Uo72PrMCbvs0l4DQhPH47XK8KZ57RYQOTyQ7lRSmKQJWJ8cVgTWHdnAjasOI=
X-Gm-Gg: AYBFou1NZ4H/Wm95uVVbR3ezHehL+80k9PXbA9iR6nbAP1T1FE/ZGK0RVcrCqkKOt9C
	lExCmmulHRgY3ksuu8Ie7M+oRjkZRNmZp4u95U+Byuixs3DDuxb7AvYI4FXCoosjkjh8yn1VsrJ
	ad/HI7J8dzJT2idr57X7lfLCph8ZAULiyBVkJD4kGpC0IYEFcXBrbIG84UKyAfJ11gthyKRO0Cr
	53F/f0DnYgSAB5TQMTqAbW3RufnvdyfK3SC2yA9/9BFauY57e34ZZqAN8Rk6WOSOmGhlqp3YlQn
	N+TlmDfoubkSKOv1aH1eTbVZLndaeAAlNp1TawMeBxagd4ZcUmcV+u24I5MHn3Xe07hyKskAHTV
	IohmoiSZSQ5UEI/6mqS3pihmlYomqyaQEa1CJXED6/xaNcp7O9202v7/EFKm6QLWVBfVrxa8wGb
	tPOpaT8hP9pNUcGvwJ5e66FclMFquFn2uxePoL4QQlJoGxFGxoBS66vhfcpygwBEPUADJWCo0H7
	URtOYesQf1lVMUbNX8alrglXzLBxkRdviALAAU6irg5YPyau7L33riar/WXKd74Y18qsPNe63UF
	lkyB
X-Received: by 2002:a05:6820:8119:b0:6b1:afc8:3162 with SMTP id 006d021491bc7-6ef08c78ce4mr16689378eaf.7.1792108853962;
        Thu, 15 Oct 2026 17:00:53 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a4a01ef7sm451312a34.9.2026.10.15.17.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 17:00:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 02:00:51 +0200
Message-Id: <DM5TKGLXLDRJ.1V57U8116L1AX@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 02/15] selftests/bpf: Bind an exclusive map
 through a continuous fd_array
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.22.0
References: <20261015234125.3152346-1-memxor@gmail.com>
 <20261015234125.3152346-3-memxor@gmail.com>
 <sashiko-outbox-173493@kernel.org>
In-Reply-To: <sashiko-outbox-173493@kernel.org>

On Fri Oct 16, 2026 at 1:53 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] selftests/bpf: missing NULL check for skeleton pointer in test=
_map_excl_fd_array()
> --
>
> commit 1bd492fc1fe89d69931d1485e93eef135d1cd6e5
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> selftests/bpf: Bind an exclusive map through a continuous fd_array
>
> Load the exclusive program of map_excl with the map in a continuous
> fd_array rather than through its insns alone, which has to work, and
> the other program the same way, which has to be refused. The two
> programs used to be identical and so shared a digest; give the second
> one a value of its own so that the kernel can tell them apart.
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/map_excl.c b/tools/t=
esting/selftests/bpf/prog_tests/map_excl.c
>> index 3f4422b9ffa69..3592f3ec49490 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/map_excl.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/map_excl.c
>> @@ -161,12 +161,47 @@ static void test_map_excl_create_validation(void)
>>  	ASSERT_EQ(fd, -EINVAL, "reject size with NULL hash pointer");
>>  }
>>
>> +/*
>> + * The exclusive map bound through a continuous fd_array rather than by=
 an
>> + * insn. The kernel resolves the array before it verifies the program, =
so it
>> + * has to have the digest of the program at hand by then.
>> + */
>> +static void test_map_excl_fd_array(void)
>> +{
>> +	struct map_excl *skel =3D map_excl__open();
>> +	LIBBPF_OPTS(bpf_prog_load_opts, opts);
>> +	int err, fd, map_fd;
>> +
>> +	err =3D bpf_map__set_exclusive_program(skel->maps.excl_map, skel->prog=
s.should_have_access);
>
> [Severity: Medium]
> Does this code need to check if skel is NULL before dereferencing it?
>
> If map_excl__open() fails to open the BPF object (for instance, due to
> ENOMEM or a missing object file), it returns a NULL pointer. By passing
> skel->maps.excl_map and skel->progs.should_have_access directly to
> bpf_map__set_exclusive_program(), this will cause a segmentation fault in
> the test runner instead of gracefully reporting a test failure.
>
> Should there be an ASSERT_OK_PTR(skel, "open") check here before proceedi=
ng?
>

Should be ok but will follow up or fix in respin.

>> +	if (!ASSERT_OK(err, "bpf_map__set_exclusive_program"))
>> +		goto out;
>> +
>> +	bpf_program__set_autoload(skel->progs.should_have_access, true);
>> +	bpf_program__set_autoload(skel->progs.should_not_have_access, true);
>> +	err =3D bpf_object__prepare(skel->obj);
>> +	if (!ASSERT_OK(err, "map_excl prepare"))
>> +		goto out;
>
> [ ... ]


