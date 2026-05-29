Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC5C376BD1
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073155; cv=none; b=fE5/LuQzaU5hQ4GztvlZjFhDF/Eprx7uML/uRCUwi9LhtCmZMpx2w8qFc20y5NpnSsCzEF4w73PmFWROfAiFC0K1zu0R8DY2SIbO2hkdXoltE+tGafPULTQFua/2MsNZhdWDkqZ8p69cQ0nPH3dasN1WhCOG0pwvGL7qCNz9kEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073155; c=relaxed/simple;
	bh=aCI6e/l7Dth2yzzxP11p44pWFmgqpTitIRCmWKW+Zeo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AFu9fP/h/9PLZDRq3DawmzY3DI0hK4K5isa4p87gFZBVHueCUwrQkL7vjxGwxBIG3r9kmmO86cUH0ak21sODcWpEEdZdnA1QGT2/mAjlgQy7hqvhD5gUCysPpLBrJZvYp0LFKrdPwwHdyuEtOF3uJYJyY7TOwL26kJrJaRqEQD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=U6YU6Qgy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="U6YU6Qgy"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba856db1c0so102330595ad.3
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780073149; x=1780677949; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCI6e/l7Dth2yzzxP11p44pWFmgqpTitIRCmWKW+Zeo=;
        b=U6YU6QgykwPA7soFByIMVg2vbXSf59v0zB9T82Pl5qEorozbfJvZKAlGI0zVP87zEO
         PyB74ETcPxMSukAmfp5cIQ3SdDvbp7bTDloQb2+VY7F/Gr5qHYiePCBvvx1I3ALVJLFd
         WknBmMA/H9QPmkOPAWyKHRRmVMvziPyQXmrXy2Dyk67UX1jBvkwEFAnr1QfXxjap/rtM
         XppvEPHy/pqFcyDgPQksoaM4rXhb/gZIhCryYwYUEJWCT+toO0MH4ex5qA9kBGdtKOGl
         rhFXfu67mnePh6eXQWmuZvM7pberkMaZMtaMtG0GpEsZ3s/rKHX1/RzuuydJqD3CneCh
         RIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073149; x=1780677949;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aCI6e/l7Dth2yzzxP11p44pWFmgqpTitIRCmWKW+Zeo=;
        b=KMHrDyHbJi7kmeuVbuCKUINUVZaNcANHgwyYNGEXGg3ws+G843fNfoKpeqsGwhbJ8v
         OMRJF2GGmSONEM3IPIxS7p1DkyshlQ8TvyD8YRyKM8INWycHOJOfypO/e8C+MGcXenjy
         80K33u0+0c17reV6o6LMeMvA5jkr1DuSphHCrcIux2cb8Dy6BPdm3v6da2JWeBWjM7Mi
         nYu9rMjIoxAZi9krDooAgbHpiDYC6QwnvqHQ8bx2XHSCFAXGASGXow9zigRJxQZPhbRT
         /TyR4C6E8XbJUmh/O4kWmh3Za6hWtLt0CfgheoOnBJZSzAm6j9MKe77nKc3DYGM3uLbw
         EjDw==
X-Forwarded-Encrypted: i=1; AFNElJ9gcECoxRveWSrwn+3dKNboWJbgeAPZTAf9vKn1I89bfdw68elEP+VQWOzBU7PhCbdL8lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTmDeCO5Nq9kzr1NOPzROx0VmqkcUjYS9B9jOho910417MKRd+
	bCFa3vc62uYaZzNEHlfSccj/6LbfASEews71VOe41VEv64/8OxhD2KdITpy3SKXLHcM=
X-Gm-Gg: Acq92OF/1V2BmzID5cpEGSrVGwvoYn/7cHIMY9gXgjndtS2jurcn3roq6U93yN6KlDF
	8JFU5fqbpOrs5hJ7+Id5bMv8sbnxeULZUVUco7XaA3C6jS38yhMjo8tDEieHQODgFofDdITQaPJ
	Mkti7hLiNvikmqOTw8lx91dGP3T132UBSUGSMasCZr3K0CvEe02evuA3x8y8A4k/dCerGI4i5dO
	InEsWCcNv43XZsH5sQ9tpWlabuWReEPkrCSFtZDM0px3B59tqEC4QeS5SY6LZvpSp2qyMwm8lT9
	3cynzTespEm0bkp5+pOYHce+IHL0Dx2D/kLBG2bL0GYekqF3nmtmHnokVWmBKDC0EqVZW4cOl6E
	RilAoNxjQvRcbCyoCmftqshrWT1+jS60ybj9n6Fh1DOGZgHOA1SgaqW0Y2SScBO5zjhF56gR5Ey
	h86/HJIaccnqpmdO/j2GmnHwMT9BHUjM82YPM=
X-Received: by 2002:a17:902:d583:b0:2b4:5931:bc4c with SMTP id d9443c01a7336-2bf367cbf43mr8005005ad.15.1780073148788;
        Fri, 29 May 2026 09:45:48 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c26b3bsm25060415ad.64.2026.05.29.09.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 09:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 12:45:47 -0400
Message-Id: <DIVB9MNT5JG1.SRSKMZRPB4G1@etsalapatis.com>
Cc: <emil@etsalapatis.com>, <martin.lau@linux.dev>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <kees@kernel.org>, <joel.granados@kernel.org>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v2 0/3] bpf: cgroup: fix sysctl new-value handling in
 __cgroup_bpf_run_filter_sysctl
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Dawei Feng" <dawei.feng@seu.edu.cn>, <jiayuan.chen@linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <0f50af7f-03c5-46d5-9d68-553dc6995df0@linux.dev>
 <20260529113752.2863465-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260529113752.2863465-1-dawei.feng@seu.edu.cn>

On Fri May 29, 2026 at 7:37 AM EDT, Dawei Feng wrote:
> On Fri, May 29, 2026 at 12:44 PM, Jiayuan Chen wrote:
>>I think patch 1 and patch 3 should be adjacent in the series.
>>
>>Why is patch 2 placed between them?
>
> Hi Jiayuan,
>
> Thanks for the review.
>
> Patch 1 and Patch 2 are actually parallel to each other. They both addres=
s
> pre-existing issues that would be exposed and triggered once the changes
> in Patch 3 are applied.
>
> In a previous iteration, a test bot and another maintainer pointed out
> that activating the code path without fixing the underlying issues first
> could trigger a kernel panic.
>
> I placed both prerequisite fixes (Patch 1 and Patch 2) before Patch 3.
> This ensures that the fixes are already in place before the code path is
> activated.
>
> If you prefer a different order, please let me know and I will be happy t=
o
> adjust it.
>
>> Change is fine but fixes tag is wrong like the bot said.
>
> Noted. I will correct the Fixes tag in v3.
>
>> I saw a reviewed-by tag given by Emil in previous thread. Pls carry it=
=20
>> when sending new verson.
>
> Thanks for catching this. I will make sure to collect and carry Emil's
> Reviewed-by tag in the upcoming v3.
>

Seconding what Jiayuan said in terms of the Fixes: tag. Also feel free
to add my Reviewed-by: on patch 2/3 that IIRC was not present on v1.

> Best regards,
> Dawei

