Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CDA2D8DDF
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903495; cv=none; b=mCHGecmJF3f8ptGdTps2ZGPRyf2CEq3Dv3h++NW/Fmzz5jZ+gCr+y9oiDVhB0PtsXc6o5PxNyvd/Y4Pi0dw1r/oKGfrRjYPqXm8HY5sg2bOJUPEs1oH7J8DEFKX+c0t1SB61odYRdsuzVu4hYjNoLbCl+nlUIoxi/4wr6YY1V3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903495; c=relaxed/simple;
	bh=e5A7TNuClHv+JZ1tGkRV2KbMiHhdOQnVozYbGaniwbU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=PAwLJnJf764oYxINU7ton3RnDupgyMEBkX2UaBrTSS0Z++BiEHceLVLz3zQcgAumkdtEPC97v2gxkPsETVFOHrMk0/qGUp49AID2WszAFoZ/VjZo5WqC4FMrtV5Pi1rnsXzUd1/3CxZ5cUvBF8mj/jsH6f7nIu6Ke1V0zOa5qUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WbbKTAUQ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WbbKTAUQ"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38e97e73234so40122881fa.1
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 07:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777903492; x=1778508292; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83bjCd7DYBvN7wEuphGjy3Mtk7MEDyYzlTQwjp3YiJg=;
        b=WbbKTAUQ9USNtqanwRn8zlXZWAC1E642zXaRd+GmuR4BD4jqjRzmFuxGG1SfSUXCN5
         0vZ4tJAxw+etLx1VzM92/JXOYrq9BSLkE2Quaxltjo/bIgiq1H0MsxHTwUGnjLT4QunE
         CrcSze1JxRCbFhAgo3E2BKMLIJNDasLcHGzqbWVzSVdhvGpoOmPix6JoUdQmezVWLJTR
         9m2pLVJXcEUtS10F2d7EWZRRhJSBaGStbPzy5hAvAVv0uLhzAaKVG5xP3oj3b/ggJw8N
         PWnKPs/McPUaQK8zZ2P3hIqpydWWIMegULuR7SmqiNT8A4uv5/Ci7BYviahhykgWWFRA
         CG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903492; x=1778508292;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=83bjCd7DYBvN7wEuphGjy3Mtk7MEDyYzlTQwjp3YiJg=;
        b=Sn115RTwMFsHWfpvSnN29bNVz0uzY3X2KXuHYCg3NIf3jS4ODA31HwcIuWy2gxEarN
         aGedQF+dAXE9qR3sY6cvmMlKPlyilvK6O4X9KG4DxKu0zbDYRqGUTcvHb16Yw9Dg72rG
         7e+6/g7nNgcE6tA7Unff//D4N4u5WcJQb2yfTpfryeZq/VXC07uUTply9vElNoc98sCh
         FDn0j+i8yrTNC8xNewr5cHM19oViCenSZI9EnXE27Yy6VsxmduN7gJb00376cs10AWPZ
         B1kQQHfOH4kim762hPV7vnjXN+9lsIT70udGlOlM0Nh+khwtdbbgoVlIEGbpVyP/qLV/
         OpVw==
X-Gm-Message-State: AOJu0YyJoeGKy+UB1pGBKHEgNNBLCP6VpZkSWFHedyhEmJ/OKlgqGcLR
	+DB+V0X+4fxI/I5QBb6C4YpRqiEKy/5rFDx6ir6cUL4U07e7+ZSPEoDnR943qUAfzzE=
X-Gm-Gg: AeBDies3BOvWfhQMOlgd4E7UFWmB9EAXtcb8SPtXn+Tc6CPaBrfwlrBqGuBtaTTMFFS
	PsOzhQ8bYVORRL6gYpt7gJCSy2KYFgLte3oxNdlDwt+JnqZf/lQCLMdg+W7JV9+rlPJoNG5F88n
	tAOu+5cE1GxLhNJKUSStKNk9TxVsdABxYmhO64bXPDR8LE8d/8NpDOe6PhNqaNgSgimVfYqZj36
	J2qNSMLQFek6N9npWc0XTQXspwCm+XObBaf61JbL3yzRj9KtHV2i4cBY8DkJOyOC6QyWDeJWTA4
	5HAZ61S7v8cyeCbyqGyI/20rn1BBcKRzCzU74YDnLLTJMK7NLMHFpm7NdvYPxB6p7uauregt+2e
	WYEzvp/sKQ2j4ZaJqeCWxtCfZUprY/+Vabq/IAaEBQ5Qwm/ARFM6jp7dQNMLcBk3NlcYYGvJqA6
	eLaJHu2zCRSnGIQuBV9w9YVg==
X-Received: by 2002:a05:651c:3242:b0:393:9579:2683 with SMTP id 38308e7fff4ca-39395792925mr16892061fa.5.1777903491730;
        Mon, 04 May 2026 07:04:51 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:1294:2ecf:67ff:fe81:9da0])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-62bfd8b5886sm5727147137.8.2026.05.04.07.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:04:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 May 2026 11:04:48 -0300
Message-Id: <DI9Y6R84C029.16EELKNHG5NEL@suse.com>
Cc: <bpf@vger.kernel.org>
To: <sashiko@lists.linux.dev>, =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?=
 <rbm@suse.com>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Subject: Re: [PATCH bpf-next v11 09/11] selftests/bpf: Tolerate benchmark
 build failures
X-Mailer: aerc 0.21.0-120-g22b95d38161f
References: <20260430-selftests-bpf_misconfig-v11-9-e11f7a8c4fdc@suse.com>
 <20260430163852.E33CCC2BCB3@smtp.kernel.org>
In-Reply-To: <20260430163852.E33CCC2BCB3@smtp.kernel.org>

On Thu Apr 30, 2026 at 1:38 PM -03, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Skipping the 'bench' binary compilation will cause 'make insta=
ll' to abort.
> --
>
> commit 17b45ab67f584992f6ac2a400e83d514968d8c98
> Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>
>
> selftests/bpf: Tolerate benchmark build failures
>
> This commit allows benchmark object compilation and final bench linking t=
o
> be non-fatal when PERMISSIVE is set. It emits a skip message and removes
> the failed outputs so stale binaries are not reused by incremental builds=
.
>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selfte=
sts/bpf/Makefile
>> index 04634e6e0661e..a460f2ad3cffa 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>
> [ ... ]
>
>> @@ -988,7 +989,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
>>  		 $(OUTPUT)/usdt_2.o \
>>  		 #
>>  	$(call msg,BINARY,,$@)
>> -	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
>> +	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@ $(=
if $(PERMISSIVE),|| \
>> +		($(RM) $@; printf '  %-12s %s\n' 'SKIP-LINK' '$(notdir $@) (some benc=
hmarks may have been skipped)' 1>&2))
>
> Will removing the target via $(RM) $@ here cause make install to abort?

This is a non issue for the default BPF_STRICT_BUILD=3D1 case.

>
> The bench binary is registered in the TEST_GEN_PROGS_EXTENDED variable in=
 the
> BPF Makefile. The selftests framework (via tools/testing/selftests/lib.mk=
)
> unconditionally attempts to install all files in this list using rsync.
>
> Because lib.mk does not use the --ignore-missing-args flag for this targe=
t,
> rsync will fail to find the bench binary if it was skipped (and thus
> removed) during a permissive build. This non-zero exit status from rsync
> would break the make install step.
>
> I note this is addressed later in the series by commit 99f5f021f0516
> (selftests/bpf: Tolerate missing files during install).

Yes.
