Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8293D3B52E4
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772114173; cv=none; b=NHiVtOXSD4JWwEkw6qFoUpkvje8dwHn7W51AkIW0B2sVmhnTOGGI+q0WFRX4Qfuzsi1qr2vDSEOeC75MSydtc1V/l9KMEQ3y/ARlyr0ocZNzwzjtDLWAp3Tc2X6thxDZIz5pxa8KQyFBagy32ofCewisiyDB+yNtVi3LX8TqNbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772114173; c=relaxed/simple;
	bh=UUcAd78FdfnNtXk7w9bo1as7kYNpCTSlM9CG+qEXLYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLvUCRGc+B/h10t8XdDoIqPGx9P0ffeGQwrRY7iEwIx7GWmmg1E2oiLL8RnU/yShUXPHBlgZya1MKit+lfqXK2nw9AaQ4wq2Z39qlsPHkrMhC+c/l2lhX45OkMDeYPofYGyBT5ExJZFcnf6gQO75Z6TzzNJM7Pyo+Abebu8/AC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net; spf=pass smtp.mailfrom=qmon.net; dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b=pna+HERR; arc=none smtp.client-ip=185.233.34.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qmon.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b="pna+HERR"
Received: from smtp.soverin.net (unknown [10.10.4.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4fMCS94Xq8z6X;
	Thu, 26 Feb 2026 13:47:05 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.100]) by soverin.net (Postfix) with ESMTPSA id 4fMCS9002hzFX;
	Thu, 26 Feb 2026 13:47:04 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=qmon.net header.i=@qmon.net header.a=rsa-sha256 header.s=soverin1 header.b=pna+HERR;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qmon.net; s=soverin1;
	t=1772113625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQY+OKOIoFJT1pdG/pJXZAXkrJLU+kKO4wf2/kuET9w=;
	b=pna+HERRTFI55T0gSik+QlV7s+vfev7PlOL5dIK+E2OxJ8+RafSknMa1nURAFK4vYqpioB
	/qA+M4P3eY+M1Bgeh7c7A0oiNgan9tWQUUHcLrADPI7yTgu/LM3G6AsL3yILgJSTTC/Lbl
	/JcLfsuaJ9gsgUY6PjNxaYnzhSbxhNQirxMwgQY4zZ/UKOOPWf1/jZ2ty6tGiiy1TpOFLN
	VZtLh20jK8XresQc8zHqqU9lF6sl5as+NbgtqFSvfk+yxk7A+nWzSlJ45lAcwtztfmBvoW
	hifJzT7gr59wNjzZ3LjYIOYoH5iVUbK5F7eJbyM0YX77PqbboKDb6hUZRaRsnQ==
X-CM-Envelope: MS4xfO1aKM2H00s3sWivT9PtnosR6KV5C7Zi8BVP0n7Q1L1vkZGyNH9mSlQ39SO2S0JfBh2SlKkddcXmlEeoKaeeclCDqCX5FwyIfZZ5HyO0W3qHsAB18Uzp G1iuC9QmE6S6En3X+cf05Ux3zwlc+SCEWPk5hPhpxpzHR7f0aaS7F1TC4Jbs1DdtioHTDfTsy+ajx9Iin8uh6/OV0ywK43M+aCK8xtuHGPVpf7/B3PYw7Wne LF2FnrKd3tuLwsXWUG3YEKW6md1LIUA6/6/fofZpJBjCSi4R8YGrJOrVyozyO230gREGc2EU5bBvCrHAQxK0YbQhLFUKfJgf6OqM44/ZTKZHXdvTBvMq20ak Z9+rpw1bRsXzXf+78vQTZNM96s+JqSzUbEIRfTGl1qIeqXY7fa2NpeqjAz+Jop/zwFQ1loMMoUwnPk5zsHLgFDNQdqfdJsi4Ii0l8cE1R1lvexSvdYHhIVru mNbRPUrMPl08fy4U9CBAKAkiHAxrcL5dOK+57N0wum6EfamKAw2A9R366Pufg09Z6V0a372Fj//sEuuY/QVyBXq2AyNf/L5fHM+odw==
X-Soverin-Id: 019c9a33-ffa8-7575-a7e6-a7e869607cf8
Message-ID: <a8f149ea-2b96-43b8-8cc4-8a3e58c230d9@qmon.net>
Date: Thu, 26 Feb 2026 13:47:04 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 2/3] bpftool: support merging multiple module BTFs in
 btf dump
To: josef@toxicpanda.com, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
References: <ebce5bbcffe226e4ca1894c4970d094fadd711f7.1771950922.git.josef@toxicpanda.com>
 <b3fd82fe09eb200599e8ac8e24ca4f9b8b995f0902f2d4343585a6b8291e6229@mail.kernel.org>
From: Quentin Monnet <qmo@qmon.net>
Content-Language: en-GB
In-Reply-To: <b3fd82fe09eb200599e8ac8e24ca4f9b8b995f0902f2d4343585a6b8291e6229@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spampanel-Class: ham

2026-02-24 17:18 UTC+0000 ~ bot+bpf-ci@kernel.org
>> Auto-detection of vmlinux as the base BTF from sysfs paths works as
>> before. If vmlinux itself appears in the file list it is skipped with
>> a warning since its types are already provided by the base.
> 
> The commit message says vmlinux is "skipped with a warning" but the
> code filters vmlinux entries silently.  In do_dump(), the first file
> is filtered with:
> 
>     if (strcmp(*argv, sysfs_vmlinux) != 0)
>         files[nr_files++] = *argv;
> 
> and subsequent files with:
> 
>     if (strcmp(*argv, sysfs_vmlinux) == 0) {
>         NEXT_ARG();
>         continue;
>     }
> 
> Neither path emits a p_info() or any other diagnostic.  The v4 version
> of this patch had a p_info("skipping %s (already loaded as base)")
> call which was dropped during restructuring for v5.  Should the warning
> be restored, or should the commit message be updated to match the
> actual behavior?
> 
>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>> --- a/tools/bpf/bpftool/btf.c
>> +++ b/tools/bpf/bpftool/btf.c
> 
> [ ... ]
> 
>> +		while (argc && strcmp(*argv, "file") == 0) {
>> +			NEXT_ARG();
>> +			if (!REQ_ARGS(1)) {
>> +				err = -EINVAL;
>> +				goto done;
>> +			}
> 
> Quentin Monnet asked in v4 review why strcmp() is used here instead of
> is_prefix(), which is the standard pattern throughout bpftool for
> keyword matching:


And the question still stands :)
The rest of the bpftool patch looks good to me, thank you for the changes.


> https://lore.kernel.org/bpf/4ccb0ad0-3e50-4548-b8d6-e2d7e93b3dad@qmon.net/
> 
> The initial "file" keyword is matched via is_prefix(src, "file") at
> the top of do_dump(), so abbreviated forms work for the first file
> argument but not for subsequent ones.  Was this intentional?
> 
>> +			/* Filter out any sysfs vmlinux entries. */
>> +			if (strcmp(*argv, sysfs_vmlinux) == 0) {
>> +				NEXT_ARG();
>> +				continue;
>> +			}
> 
> [ ... ]
