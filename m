Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626824E1D1
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 18:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710525631; cv=none; b=Rx5ctkB+dOV1l8aOPNsbV4DfVcOwiCmaAkn4UXH342aPZWihCJ3uV+W3KAWTfxoz23q12VbCtEy85kWdMCLKd2mZyOiEW67vlf49Pyni7C/90T33a9yXcHMZ/Bxp1jq1yKzgwU5fUMgwmfDwOXjrrkvm+lpZoE2wgMY3PYG0Ie4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710525631; c=relaxed/simple;
	bh=AoPHM8jEhRxW3FKw2ZQYN2iCQwBU5yEJ2hvEp3sfvl0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rH7gfzDnP5mgcmnsvBcAv0MpbM7XX6m7SRXOmaPlZBkyRQDTKzR924CeCFaSJ8A9oZy8FO+ojGQrpViGSk4xAFYsXQy2k8KN8to51upTyFCQ777noIYgCmOVx7PtfQVk3vjO4EPQoPga9VnOdaeiWf0kkwxUDAvG8EU0ooQ+ygI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWi9hRWD; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWi9hRWD"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1defe73383dso1979295ad.1
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 11:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710525629; x=1711130429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tKUv+AE81x4URKcQ4MdfugtBhLvIVvVQh71kqEkvxsg=;
        b=lWi9hRWDvq4SfR4O+1XT6mByiuF7bQFbh4DO7QyFn1c2tqsLQR6OqfiA9xjSnS9IgP
         0f8Wxh9vRFDbynYq8beFO+USe6tc3jWw/IzvlhYbvhcEh/amNKR1NlDhc9LG9dzd1mrU
         mfoUM9q8mHS2PtfvSqsZab42z4SyH4gnZksV/3L9ekVWDMU8V/7FFRFAsVzhMMmV2HhR
         624LYhvLnVmDUJOkZpetw7X1904Bc1FrBoN4LOQNHwPGEnzb3m7XjZUgCMuUfhKOpPxx
         xchmnmKEyRwbtEPRaPWq7JUW5s/tWz+ma0BLx8j4IEog41JxTE9umHNfZqq2zxY6d9qH
         l/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710525629; x=1711130429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tKUv+AE81x4URKcQ4MdfugtBhLvIVvVQh71kqEkvxsg=;
        b=h9NnouCxMnKtipJD+Szt0Heq4jYr3z1pjjEiZYZ+7KXKT6F8fYt8uyYjYraUI64lKs
         qPj9weHxWALstVf5rmVcJgxs1dsp4eQf3auZFhL5V+1K+EMANPStjbSheCEKfd1IMZI1
         ZoHCO+669iB8q7MdyfjPg13PWPcT9RwU/twzOUmtsWkKDDJrfe3JomFeApAzz4eREZ3t
         qE+xX+MLdFVjNDJ497DvaC57o2v3eObfhOdFizevwtDZnLHd5FWc5u/5CHluUkMeSdV1
         ZjZ5hjS4yOwg3hFFIV0lyqCvSYBuvK26Fhxyj5Th4aGULHAnI4mOTWTrTbBIfIpSeXnC
         nDig==
X-Gm-Message-State: AOJu0YyH/ZDT3AaGr/J1SyL+t84c54S8AlEsoqXZtFkBqO5Z4NloGIe9
	PP0LbIB5WysHnouG4p2FiSRbmYTQZdInfq6wzznBTlwqMaZeyXcZ6YAqYehtTSY8VA==
X-Google-Smtp-Source: AGHT+IG9UYZ8H8CJCAZKl/mjy4YDYGvODo2Ya9xQbf33KJmtJlyfrbcwbf4N4YlqX/8pHAIhL3LGz24=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:be02:b0:29d:dd40:cd92 with SMTP id
 a2-20020a17090abe0200b0029ddd40cd92mr14818pjs.0.1710525629518; Fri, 15 Mar
 2024 11:00:29 -0700 (PDT)
Date: Fri, 15 Mar 2024 11:00:28 -0700
In-Reply-To: <20240315021834.62988-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240315021834.62988-1-alexei.starovoitov@gmail.com>
Message-ID: <ZfSMvGL4NtbBJI_t@google.com>
Subject: Re: [PATCH bpf 0/4] bpf: arena followups.
From: Stanislav Fomichev <sdf@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, eddyz87@gmail.com, kernel-team@fb.com
Content-Type: text/plain; charset="utf-8"

On 03/14, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> A set of follow ups to clean up bpf_arena and adjust to the latest LLVM.
> 
> Alexei Starovoitov (4):
>   bpf: Clarify bpf_arena comments.
>   libbpf, selftests/bpf: Adjust libbpf, bpftool, selftests to match LLVM
>   selftests/bpf: Remove hard coded PAGE_SIZE macro.
>   selftests/bpf: Add arena test case for 4Gbyte corner case
> 
>  kernel/bpf/arena.c                            | 25 +++++--
>  tools/bpf/bpftool/gen.c                       |  2 +-
>  tools/lib/bpf/libbpf.c                        |  2 +-
>  .../testing/selftests/bpf/bpf_arena_common.h  |  2 +-
>  .../selftests/bpf/prog_tests/arena_htab.c     |  8 ++-
>  .../selftests/bpf/prog_tests/arena_list.c     |  7 +-
>  .../selftests/bpf/prog_tests/verifier.c       |  2 +
>  .../testing/selftests/bpf/progs/arena_htab.c  |  2 +-
>  .../testing/selftests/bpf/progs/arena_list.c  | 10 +--
>  .../selftests/bpf/progs/verifier_arena.c      |  4 +-
>  .../bpf/progs/verifier_arena_large.c          | 68 +++++++++++++++++++
>  11 files changed, 109 insertions(+), 23 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_large.c
> 
> -- 
> 2.43.0
> 

Acked-by: Stanislav Fomichev <sdf@google.com>
