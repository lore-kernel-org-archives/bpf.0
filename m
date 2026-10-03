Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FBA3783AE
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791028100; cv=none; b=KBmMjrnoXsiWXTGGt5/DGPgHnB+THkV4NND0FOWh9h0pVo2u+WHXB4gxbyrXrXEQSodoyEObCTV/821OETG2NUe5rQpefmNiLjCFKEAiogoSR7o59Qh/SDEz1ZNNTFRxA2YwfBj31Pzco/dQgI1P3+RWhYMg97xXqhTckVu4bpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791028100; c=relaxed/simple;
	bh=zECgbO2OrNsJA1DKBanbJA41mp9Ft2z0GzvH95EX+IU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=mXyYfB5t5gcaqk9yb60drQQX7bPxSks+Sz04llWmr3NKiyo/aRB7FG9V9vU1Tiv0JQgwYE+X04SOktfl/ADupd3ix43uYnmViW4C/MEAsBtm9ebbj/ZOmvSenhp8LEcu9zeyOSQhsBP+EsXMmLbGoKDb8H2xPRxSV5RqCUfHwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al+/sVw2; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al+/sVw2"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-3a4c8262465so301721a91.2
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 04:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791028098; x=1791632898; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xAp/hNN9Qw4nc2pzNGX5wUYzu3DJjKjKdjN7rvAbQLY=;
        b=al+/sVw28gXJMVvG5qy9Hfwrk+z1TfKyN+Fw7CEDMNheDM35ARjrM2u+gemMDmnaPN
         QEcn5Nlfwk1FAr02K7NfwpejxwLEVpeYpzje/FifnbwDQDoJqZdYtNF2UHWj2gXcw+u/
         bUTe260qA567X9aJFrZX2nthjIbacG1lBsqqtfUpNwUT9QjBDh9p87qfNvgfwILZFgva
         N0VK8IvgbYfmT86IBpasUuMNmYFhPkIdJ83t0g0r372CHc58tzDkMkJVvzFPCqqR+jPY
         INEbnMXvGRlcM4j2vOy8ggv7CuxYkjm3MmMVgpYDS/B0BxYISApcanPAG7w2K5XnOlTc
         VNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791028098; x=1791632898;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xAp/hNN9Qw4nc2pzNGX5wUYzu3DJjKjKdjN7rvAbQLY=;
        b=UU0nvjNfG/WFDNuP9FpVd5wC4tWN63wQsjz684o7oskTGANo3Yqn6LhSN4B8TbwIax
         i1ECBkozzaYQpkzfw+ZodxlKWLqqw73fHIjDAE2HsMFUH0b8hSIU9/+FeqnvuHiR6Lyx
         qNxNI6MCS9broDDmBLLLJbltcaMmyXvmBciHH/ll600h1VunPhEe88eGlHWUTIgh9Ban
         9N84yAC8ek2jztRsxPlSq8B6yDwUAp4feG6GlI6vHlKg9gNx08wzFpzq2lNn4axsTs5y
         RbrtaDfvs4XUd9e+05GBgmBpuE96Swrl6tW0aXB0ElZnrHnusKLSTuBh+DqqF2itgMbH
         Khkw==
X-Gm-Message-State: AFq9FYIJG4ICm9qPhNtQUYZ33JipEKyvDkjyOx+WsD0xKsVtkCfdoGDF
	UVPanDQD0Xnke8twU1dz194LsaN6ZRdEOWb487owOF027nREITgojq/XD7zsEE7O
X-Gm-Gg: AYBFou0A5tLjyNLteGML2tJoIfVgGrR+OVF09vkbY1Zd6YWqRFXTraDR5EGcdPh6Nvh
	T87ovAjhATUa7KwGFoyqf1sKfkYvh29sknRtfUBMnpswnWtjPWqT6++o1BW8+tHbRy09i4MYGTE
	zz5A/yBNvp1pbouYdQNYadleH8vUVR74nGTN4KUJrdfGL/EvcW9Y8e/SdUQUWxkBOqNOTMEHzMi
	fbUhGsVhWe7wO8prPxLC+gtlQj1jiHglombFS3WuHHncCAQaHAev29H2LziY9rCh/KQNBHPShb9
	cJuOFxQfFcvWHngB1DcCTFxr3bny6HVGae7G0RfCNIMWUe9m9K4wf9nxsjF3nvIQtgGluJyYyim
	LEb7QVE9/GnQKkKWl0nZvZ+mgj7sAthww5tttbfiLgj+wA8v5RlZsVm8+rds/VKO6X2iVk2V0ht
	GUGpZ++b5eZEZP3j2y85a2GqJt3ayhoueC/vky7Q2MCQps8TbcNQwqUq8rFwv8ZJMZyB41Hiojq
	hneUCXiJBMBt/ohy3nrPl9y5ZWkROdJbyjV08SXMI82awn1SXzpGoeYt6onedu1rHidnJciDYpc
	pbI=
X-Received: by 2002:a17:90b:3912:b0:3a6:f800:4463 with SMTP id 98e67ed59e1d1-3a733d76730mr2210508a91.16.1791028098236;
        Sat, 03 Oct 2026 04:48:18 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e4664ebsm2716574a91.7.2026.10.03.04.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 04:48:17 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 11:48:17 +0000
Message-Id: <DLV6H1CSHK76.14LXBR533VMQJ@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 02/15] selftests/bpf: Add tests for ALU on
 pointers with CAP_PERFMON
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
In-Reply-To: <20261002130803.A0FFA1F000FF@smtp.kernel.org>
References: <20261002124714.180012-1-alexei.starovoitov@gmail.com> <20261002124714.180012-3-alexei.starovoitov@gmail.com> <20261002130803.A0FFA1F000FF@smtp.kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 02, 2026 at 01:08 PM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:

> Additionally, since this program places multiple unprivileged operations
> sequentially, wouldn't the verifier abort at the first failure (r1 &= 1),
> leaving the unprivileged rejection of the subsequent operations (>>=, |=, ^=)
> completely untested?

Not an issue. Nothing changes for unpriv. to_scalar is false without
allow_ptr_leaks.

>> +	r1 = 7;						\
>> +	r1 *= r0;					\
>
> [Severity: Medium]
> Does this actually test the verifier's handling of pointer *= scalar?
>
> The multiplication is applied to a scalar destination (r1) with a pointer
> source (r0). Would it be more accurate to test if applying *= to a pointer
> destination correctly downgrades the pointer to a scalar?

No. The test is "number op= pointer". That's dst_reg != ptr_reg case.
pointer op= number is covered by other tests in this file.
