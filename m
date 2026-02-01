Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD11826A1A7
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769964208; cv=pass; b=bVdMfgwyUSvyGopA37oJkad2t0cdq1aNZEnQyfdcQwcFOdpKgBCpivYSHEs45z7nq9sUq5l/OA9hAHdrtXbhklDQUVdh2bn17BTxFgmITKa9EY2JUygDujjYVJEnI4fsQ8fpFzVrnkBy4s3WK8ZcQmO5jfO0DFBi2J5z/lyJC/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769964208; c=relaxed/simple;
	bh=vy8irmUiSf/eXcG0W+j1BcyMBQYIq4gz6BF7D2WJiis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oE3VnwQ0PidC3bDwwKUuWz+cBnymQrHrCN5aI0exHJYyJy5ZpNwGCwSCrzE8KSARYnZCKJmY8ske6cbaRc5Xp1DUIkPC5NNArrfov00XWxP9qP4EdR59dlJr87JKsBcLHC3wGvqCjJQf2A4UO00fKRe/tpFNCTumG/VBfExNuus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOalesdV; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOalesdV"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43284ed32a0so1953877f8f.3
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 08:43:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769964205; cv=none;
        d=google.com; s=arc-20240605;
        b=dcJ61Nz0w/YJ2o2tQQteqnt6cxiciyqjA7yrNZ6RQXPxg/CFerX7Fzjdzmxg/fT537
         z9OVun7vV+Z88CXXK+4b/kkmwKI7xBDq7Xmw74fkJYk+DSuXEAgozWHH9MJatQ8xxNK9
         wJI4Jk/vr4R8D7cFlq0LTVIq4hLo8PHUnjkf5nCefFDO5M/HQ0Z+u6eUpphfycJfeDvj
         1VBtFPpd8CjdYDTQgCwPTBiEGt2sifD0I/4g9qlI0mj4Z8veb7F3vlNXxUpxEA/30K/F
         IFYLBnxvxpiBQgA6rluKtHz5RcaFWmKLzBOYxMG714wBu90ylLUeiFNzNyePakJsnMLM
         pOjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nc4emD7dbgLczqSrt1DDlXx/t82B84SIO2BT1dkonPY=;
        fh=nt4w4xIvlhYTfUnoprSuMFd/j+SxZoFxtxehGb0msTc=;
        b=frYfQL0x1IMKatbKi+rjnlFbqbmVXcGu6sVasykFKI0KHU0RTqQ2W1FFC9ICJj0Q1H
         zkhbbGeZ7qejaqUPp5GsIPWlMm26C0b+qGrnp8RY4vkNRpJFMsTFdrbgWlvlJYTJT3pu
         XqnttrLedjXqs2F7K/HKGgI6A3Vo/slFS8aZLmO/6DoYcDolqB53WX9wvxdY3YK+pkhG
         S/274kI/wwl6Fu52BPE2hbw74fJlxpXa6p7X2wH+z0BItStZzdHB878CqVATMhb82si7
         Nao4ovmsHWNKjdgfwRdntPkTPaYeZxwc51ZCieCz6VSOLF43xXQRRUVkMqdgQy+verl9
         wZOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769964205; x=1770569005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nc4emD7dbgLczqSrt1DDlXx/t82B84SIO2BT1dkonPY=;
        b=AOalesdVMVRw8h2fXSrfWuB5pOUwDTO4rKEzX93Mhvlr1GVyl3UcOAXGtCgEQqymyb
         oHdb84rg62VEcOgKFv15XAKjqFbqUNo86lX9gbMmpPreajkV0Uzmv+B2MkQPsPpud5VM
         BI/B6g2YJOIKGhwtQCeAvdkmhvAtOht3khpcn6ABMfd/UJdvKKlaKeW7EDWBN4CqSGrs
         SxAxiFhLY3Wta6lOzr2EZYk7IFXayU526BvB2E9lipA7LPD0+OsnPnvKDNg2I2yX1hoU
         R1b1rjSjxdUZgHfzp4UlksmZAy1gbfd7/qmRgXBbaSODX/7V5KdR4IDCkPdB5RfC2yzw
         EWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769964205; x=1770569005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nc4emD7dbgLczqSrt1DDlXx/t82B84SIO2BT1dkonPY=;
        b=iTikUmJ0/cKD49M2Eafe4LNrkFFGHf2NigFGjhNC8wmTfKkJFeqfWwVPDnXY4OGCvq
         Gh/cJrwXpkMVN1RUTIs/mW8LSKZrrmQ/xor9apUtMfhqI1rdaBG3HtUxOCkdmU66jXDR
         ObEOpwvZ0yC7ZDQ2a54t6ZWbbJDPUs83CMT6nNG3ly24mfO9XDb4GHkSRC4C6xYv1zj9
         enmNrzXMZF92jxeQwoQXtExMQR1i/s/rynjC0NOdSUrBY7J3c8p2mcAoL470yhnO0THn
         rLgidBvW9Ajp7ko0THLKkzivnkt7HrzaNIvHBqdDgUfFNtHeqdhupVdFw6BCalvk5u2C
         aNOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE1RmAQWSKl/+GvzdSWLDK7B/UGzXGBaHXf3Xk6oQ9B4jMuhXA5EIU3TSArYJseUE82qU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGntZaMAJR5ZYfSeLG6A4EnIRNmg5IXn6VHkr9K/0RFLHrPz5q
	6cwDMJ9o39BnlnOAZEt3czFP1sfqmC4m/9GQ/xaiF/2+Nr+sAOmd2JHwF3yG/RbABbDElDYopyN
	uXQNAF2PXNHAZbAV2qxN26qBSlJWSu2KvmA==
X-Gm-Gg: AZuq6aKBFetzAHeytdZAva09HrlypbXBsi/yR/GD+JXFnBOsW2Y8gUKM5rCmbueahXD
	0Cot7H/0faVNptMNC3rGFW9ehC9n3MJLNbDK33uQp8ZA3l7yEFlr8DufI1BjCYboxBIEPQBFTKq
	zWgDYMqJxEOPghYJ++Lt7E324ODwQBoRo7xw24mjv69GxYTVm99ziVz4SzrKHwrf/f6Sj7McDuf
	NDSFHNjUg4j3iz84rqL1vnFpYpZfHufzJqSozNI9xsI4z4CC6G/SReduqhdNRniS+PF1KTU1Tte
	psIlgD8JM0/g0xSpWMJFatm0J+L7fwzLmz0/GqF1vTeUtoLnWzfGQw1Q4Z5E5LyiPUTjzYOvcKO
	3OrHa40X39jPeEQ==
X-Received: by 2002:a05:600c:3e1b:b0:477:7af8:c88b with SMTP id
 5b1f17b1804b1-482db45129bmr117686265e9.11.1769964205034; Sun, 01 Feb 2026
 08:43:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130091245.3824029-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260130091245.3824029-1-sun.jian.kdev@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 1 Feb 2026 08:43:14 -0800
X-Gm-Features: AZwV_QhtfWodM26fUs_CN8HXo_1GbDHM_04TebfkG18a66-Lo1RgLS0c7sd7eH0
Message-ID: <CAADnVQL-Gf9SAAhfu3zfPvNPQ11UQmMmF-7wZNYaNOvA=-Bmbg@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: skip deny_namespace when bpf LSM is not enabled
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 1:12=E2=80=AFAM Sun Jian <sun.jian.kdev@gmail.com> =
wrote:
>
> @@ -88,6 +119,13 @@ void test_deny_namespace(void)
>         if (!ASSERT_OK_PTR(skel, "skel load"))
>                 goto close_prog;
>
> +       if (!bpf_lsm_enabled()) {
> +               printf("%s:SKIP:bpf LSM not enabled (boot with lsm=3D...,=
bpf)\n",
> +                      __func__);
> +               test__skip();
> +               goto close_prog;
> +       }

There are lots of bpf-lsm selftests.
You're trying to skip one. What's the point?
Pls use test_progs -d or -b to skip the tests in your step.

pw-bot: cr
