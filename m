Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C42430EF74
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356576; cv=none; b=uzf8LbEB6UrR2lRDwYIvwPmuaBYEcXwLTs0qKpDBmW7JLzUihJEcdtMnoTkA3sCFZDfign0ohKHk9anOrT+yyf3Ke8D9H36ZmoO5KYpKBHx9DYwFEP07Ogacl4Aw48R9lHMFn36vLso8+mTpqegSPr2Xc/a7vFmODLgoADJ5Tlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356576; c=relaxed/simple;
	bh=guB4lS9kyi78JK5do5dUd/XbsnRUSSrOptJveHhaR1s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=M8AYEO5mFiQOVcgxmcDGo+83hRWUB9v9qT0bNg0gFqaub/tvIF8nGBrx0eRu4K1A63qCX4jYagj4rdtciUMNLV/YcwgoWCLEmPCef8HW2cbZdKVATXDLv4In8AfOoWOctWbrX9spmRET8bRmxXO69GJ5AKbehNs4XeRKWieWySM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlcUirVc; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlcUirVc"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-69d60694c9bso955029eaf.2
        for <bpf@vger.kernel.org>; Thu, 21 May 2026 02:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779356574; x=1779961374; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Enrh790BjgIIUBfQlfWGTFeBgm0WSl+DUA/ZN6Netao=;
        b=mlcUirVckoKxnauXA0BdS16rQULzEEuL0HL5/3MeYY8W5wyg+x6E76ct7nSm4mFlrT
         1yjGNPxjDCAtjYx3l4c+P57a8gFqJFTHjfwOIZ4418OHiqBhwsmC0H7f+cY0qMrdVM7L
         KCbmDibCXMVP0WWb3dnLGy5x3AB/8QkSuODlxrqRtzaOE6qoAmrjev2fUoPY+Y7fvi9r
         eXfeZRY+uBGpOIbWcAaiovuonlg1pJ6X4be8tfmQEOidYrhe/tCqzUlnw2uZ7zO9Hgv+
         h01biK2a3mmK90L+sWho0ZHDC1C/DHx0q9EVrQlHB23EpvhCiD/860/23BcJX08bdGaW
         fj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779356574; x=1779961374;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Enrh790BjgIIUBfQlfWGTFeBgm0WSl+DUA/ZN6Netao=;
        b=X51hWVe4aWHyMVfxqQxIwLD2kBPdjBjSO9SZ3uvTKi9HuPyDB4+vZWeKteb5atejMu
         UVKx99CCCZdFqbr9dVTv1ZIV1VedItnjbjXiaCyoDYSqyVmggiRQ6UldLHBTrvwlkKCS
         viG4uv5h7EXZmnFghFgQXTE2QutZG+rWpByguw+f4nXIXx6kq9caVdfDOzXK2NlOtODj
         fw9yKiwh1gRdvzmn1us6W0i8wEIwphyV0LijvI1E3OmAGc9lqbDkKWSyk+qxHAZC5bKQ
         gtn4NsMihNmtMD2SCYgdhIXkKbgYsx1g5qMszr6nacSR4FpAktNqCFwk54foWATuTmXi
         Vl9w==
X-Forwarded-Encrypted: i=1; AFNElJ9c7zm4LTIU14vAXuaqJVf5aLrZElazxKVG/cqoyqzN0paNSCKJlhlgYB4+BAt2yIM1fAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaZCerYIqHdY6V63ChoTvnZdbSfUao/z6nOXSSYo7AhLlZzLxO
	PggtYEOzhfGgxv3IB5PClnlLLY0m47PJJXUzQYM8QiY751p60rq0lZLH
X-Gm-Gg: Acq92OE85TiE5zdVCGUSecZdZR37FH5Za210GFfQcOFqOOP+BNjSv/2PgCMLarBsj2G
	pKnSAPCUC6S/JcAg6hzjZ65KCKGa9OQ3Ch3C4yz+C4k1Tk4pJuRSPmNyy2Lev0VnaOx+zLJ2m4s
	U102WpjpsKGzP/w4XIlkSArhLyipEuXvLaaCddZfcDnSW32mIa2NZuxd5PypNXExcKiH7BZ3pp7
	OLvVfagQGmRxGgCXxbjSNqJsJjLM5bUUAx2lxaqmSLKXH+3GcA66lGqFb8kd0j9QiE7H97m3VEV
	bigDQpBrko/bKE84hcB9we5vNtpvgv9RMxYP428fw9woX4zb1pSt94LAVIqnD9ErG6wE6RtzyX7
	sLCiIToDgaAJ4yR5pIi4Gg06C6iIh+s8APpU6yXQvAWslzNya/zke+7lOWsku4BZQS1Lgw++m/Z
	lPNQ0uGGZPFzPP9vgIv5QZ5OHIof1QDCGyzBoXL7qnuBQSlQZibSRgG/zW8QxxuSK/VEPCOAqni
	BMpGDphBwrQb0ANeA==
X-Received: by 2002:a05:6820:290f:b0:694:6acf:a42d with SMTP id 006d021491bc7-69d6eefa916mr913981eaf.39.1779356574211;
        Thu, 21 May 2026 02:42:54 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:71::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d77385a8esm199938eaf.11.2026.05.21.02.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 02:42:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 May 2026 02:42:50 -0700
Message-Id: <DIO99FYEHNC1.23KFEHRPTRB5N@gmail.com>
Subject: Re: [PATCH 2/8] bpf: Recover arena kernel faults with scratch page
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>,
 "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "David Hildenbrand"
 <david@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <sched-ext@lists.linux.dev>, <bpf@vger.kernel.org>,
 <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc
References: <20260520235052.4180316-1-tj@kernel.org>
 <20260520235052.4180316-3-tj@kernel.org>
In-Reply-To: <20260520235052.4180316-3-tj@kernel.org>

On Wed May 20, 2026 at 4:50 PM PDT, Tejun Heo wrote:
>
> v2: Use ptep_get_and_clear() in apply_range_clear_cb(). (David)
>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: David Hildenbrand <david@kernel.org>
> ---
>  Documentation/bpf/kfuncs.rst |  14 +++
>  arch/arm64/mm/fault.c        |  10 +-
>  arch/x86/mm/fault.c          |  12 ++-
>  include/linux/bpf.h          |   1 +
>  include/linux/bpf_defs.h     |  11 +++
>  kernel/bpf/arena.c           | 177 +++++++++++++++++++++++++++--------
>  kernel/bpf/core.c            |   5 +
>  7 files changed, 183 insertions(+), 47 deletions(-)
>  create mode 100644 include/linux/bpf_defs.h

First 5 patches lgtm. Should we create a stable branch out of them
and pull into bpf-next and sched-ext trees?
I'm preparing a followup for slab-over-arena on top of these changes.
