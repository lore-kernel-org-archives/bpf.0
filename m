Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9826F37B002
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 22:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782166248; cv=pass; b=ku8MG/NlwcLlm148J1Jfg+7ygjsv+F5M887z8IJLtWtdwC9WrHL6/Dt93MGid2IMjNP67dm7gZ7O2YmjCTtk84/cpBs4bHjJ4/M15hRKAJmfQPH3tyKYxQHJoK26pcBMCHiu3Qkp8HF4HBsCbMYCsH58BEFQBaiSmjRPU7KcFTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782166248; c=relaxed/simple;
	bh=QqrWApQo7VCDxjiHXQ3hjKNrBnjqHPx3tgxEKUSRHZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWSDyCBYUTTDKXE6LufNEnw5E8yU+Qh93iKMFFe65Pp8+2sXu6Sabehpm5JNeDM9Q4LRzgUI3g77dpnc0+nuEovmdYkouDJwgcyI2hzeweByreRlW0JZMRX8shgwWb5V11tAOQdQRkHxmIWKaU6Ho5thqCpfKdbxn6OrmjH1b0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d5NBv/qT; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d5NBv/qT"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6611689dc10so6002321d50.1
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 15:10:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782166247; cv=none;
        d=google.com; s=arc-20240605;
        b=ahb3XlD6gBC2HmjSiqnr5DLAE1fH13D7pz044jGEWJsvwqrHcRYHxBlpkByFDlG0VI
         GzBQqwN0pKJW8r5DRJeLmUtelrTkTqy9A2axzY1SFs9rSrkuSujjNGw+afPEZfPDGb7y
         OJQYKNciH30U9IsAXCpysd767hP51ur/pDZrn7HtIy6IiTqp24q0fWrkMPwGhAShHS9b
         CBuSs6N8J4WbroL3RpmXKMGrPvrIfNKQj6IWkfeLm1dNL2ozih5CwsOqL9uu8Xkiz5P2
         C9nBWbIlL/NHngU2J2yhSoW1/OAu5Nx8R7trjTDNaqsUUA1jnxDiv0pOsUIHeeArdLau
         58eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QqrWApQo7VCDxjiHXQ3hjKNrBnjqHPx3tgxEKUSRHZs=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=Wn/jqa9zSD7wWbvjMpJOOSa0NMZg5DngCC0Hhp5fcvBambjhw/vqzjAkVGqltQdBbs
         IG92f/sH5UII/HYJHZ6ywZj/+HK8A11TTbrMCkOAxmPW+8wuARuqeOZCs0IxCJ5JfYOO
         +0OSpkFClJBgoXntv4tIpKEN5egB+RI7MNmLPHA3Gob/RYpm+/KgKciv1vjTGwF0mPwn
         dcL4KnX/3TXf0LqGa4TtodSzjl9OiM2CHrI3GIY6bFRTTeBMha2NM4lhA4JAyhpRLueF
         T7iu9RACZsrMhIua6xIqJFR+ayBKxEtWLmblJ0dRe74A4dqDfEt54w28ryGJFwhUqJlA
         0MnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782166247; x=1782771047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QqrWApQo7VCDxjiHXQ3hjKNrBnjqHPx3tgxEKUSRHZs=;
        b=d5NBv/qTqvGyP1AXge/a8jgJcl7siWA2fUvAL4K+wl5S2afg328rnrNpXi1EBr1FyH
         NpclH7ZIZLsGhVw5DF+WnLD/fkEQnnZda5YQtEBDMb+QFKvqgpN/gXLVYWYbjs+o06M6
         CzU1AtVdTUV0QGpsNwwQLvdGhwHpy1I40cTm78ve2ODjoYOaO5de20RcjpO3CRSMQ7Dv
         K1pWFqYxqdi0EDttikk8Krir37K8J14/Gu5xiHMDy3xc+P6rebglXvUPd17JS4+Euu3P
         m1+fuuMvMmAe81tUogD9HNcWQmHWex8jLPmFk9iiS6ZELXvp+2HZyQN8NfKa+it2QsDu
         Z3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782166247; x=1782771047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqrWApQo7VCDxjiHXQ3hjKNrBnjqHPx3tgxEKUSRHZs=;
        b=ObUAnNrn+r4XFLZidGszeeNiyIAHuqyN2m78KdJ8huIsKbKhKYCIaQmvf6c2DnRL/v
         /9ErRo9/fV++5V0+ClCWwYd+UkBzKD2s9GzncnVGEQBRKrQA6zaWNcmS+txP6qDQDUZR
         vCcpHVywCpE7MuNSYhtJB/n4hLd9PBHCoT94VL6mSmyuqe0TqLKCLRkGVTOBwwPl+TTG
         dwa12jCDs728yn/8rEZBof2/hBQNqwHK+7qx3IJ+7QwAvCVYaYwIW/guHRJjvHTUACt3
         f/WU8wpGqelxGev3q9aP9yGLi+DufnalBENRc5kySkhCqNHDVdiVTfI5fTvVF+R3L9EU
         BHbA==
X-Gm-Message-State: AOJu0Yx0jnr5lqYl3ABXduhv3+lcA7IUCdast6WJev/7KC2twp94Af2B
	gmwI3o8bsvGMKqa2MuNSmuCyrpQSX9qhhqUg2m7kgIAKBzLbKBaYEMNiGYwPIuhJi7HE0lAbDks
	CqsKl5Tx2bXLrGd1PxiBsVFRjT+0tYNoP6ZbQYRQDPQcR3QfUNRvLq8pN0UKu5Q==
X-Gm-Gg: AfdE7ck2G771mOz4ehHQCc/7JlucItoEd2z6/858UBaR4cWhvd/s5kQbv0y4FazMUVo
	+5jF2oDmkwJOdZnTPSyPM3uHtA8IwuJAGpIWg0p3V+a8i1peLLryCuU2+EcTGpj+kOV02Pes520
	swyYpaQAdiHKaduPyvMfdmY1UJeGNugNeU6n3NTYe2SGsnMZ4gBMwjQ16t1BxgeC/fq3JS9YVMW
	iz9MmAwexSeJCTn0jWv+gtf1ICg3nRv5/ixNH7R0NKPYJGiX+tFlk5NSPa270U+gFtm48kDPz03
	c8SOZtrV
X-Received: by 2002:a05:690e:190b:b0:660:4369:8cb1 with SMTP id
 956f58d0204a3-66359ebca4emr351633d50.24.1782166245989; Mon, 22 Jun 2026
 15:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622-bpf-lskel-fixes-v1-1-7c09a1585ba4@google.com> <20260622211734.EC3831F000E9@smtp.kernel.org>
In-Reply-To: <20260622211734.EC3831F000E9@smtp.kernel.org>
From: Sid Nayyar <sidnayyar@google.com>
Date: Mon, 22 Jun 2026 23:10:34 +0100
X-Gm-Features: AVVi8CfOEhcUrrhYZvwlyH5EtaTPbHavELWd43PARr_UqLG6dqs-v5jbd-vm4_E
Message-ID: <CA+OvW8atZ63+=Rgsoaaufj3DUEsPKGUJ9gYURVkNa9UReyuxZg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: fix weak kfunc name suffix resolution for light skeletons
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> [Severity: High]
> By resolving weak kfuncs to their essential names instead of their suffixed
> names here in RELO_EXTERN_CALL and RELO_EXTERN_LD64 above, does this break
> backward compatibility fallbacks in light skeletons?
>
> If a BPF program uses bpf_ksym_exists() to fall back to an older prototype
> (e.g., calling func___v1 which takes 1 argument) but the kernel provides a
> newer prototype without the suffix (taking 2 arguments), this would resolve
> successfully because prototype validation against the suffix is bypassed.
>
> Would the BPF verifier then accept a program calling the kfunc with only
> R1 set, causing the kernel to execute the function with uninitialized or
> garbage data in R2? Alternatively, if the verifier rejects the incompatible
> register state, wouldn't this entirely break the intended backward
> compatibility logic?

Self-NACK. Please ignore this patch. Bypassing prototype validation
and unconditionally resolving to the essential name completely breaks
the fundamental logic of backward and forward compatibility in BPF
programs using light skeletons. This patch should be discarded.

Regards,
Siddharth Nayyar
