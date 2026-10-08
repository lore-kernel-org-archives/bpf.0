Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B5E3B3C0F
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791480228; cv=pass; b=cm78OH+4bsp3RsUqz1JfcguSl16g8Km3KvUKtN33OItNsBVM5aML02Lq3uCHYvQlifh6sKOYY7VN/WVwznnvQ1By/xbFYcNh9nRKby/kpKaTc2ul7Wql6tu9piS851FUIkWKaRSLV0Pm4FyDm8o/6LVjq32VaAYap1PCGFRI34U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791480228; c=relaxed/simple;
	bh=BHuqIf1tNL5IFXF1A87VrpQrMhtfq/QBoGyo3k89R/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnFAbwdPpRWjoZx552EUPr3GWlrRLG4+rFaGiL4YsPSeRCyH/Jint79mls8Sb9WXxhOBKr/hjlAX3hF75fJb93BDS+93R9v91lLrqY+RQuss/15c+LfF+PGN4nL5Rc3OVbGAnr3+446DnwE93x0sQ+dOI+yJxznoJUiSd6XI+gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IqAzqNAQ; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IqAzqNAQ"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1419d3416ceso10614238c88.0
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 10:23:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791480226; cv=none;
        d=google.com; s=arc-20260327;
        b=KkPoHcy1JgjJdknEp5LNlsixtcwnxQj7UWeN8VTb4v5W0TvsNsdD7VP/L1dd3UQEBv
         z2mri5fIHeBzMiPFNyGQ7R4oin7MmXkcumEYHTiX4bmjBIGs97N5ayjxoChLPryQN8iG
         GLHI7a6+jQFlgthxdN5V/vAAvhBR3WDIr12DewBaZYwbe/OIp0KV4MoHO/UuiNRzSaXG
         NVE/H8927qKyRaWKERJpmwSL/2g7j2ad5o1iqUcfOEcM5HUXY7hBy5Apqpiq2+2nUrXp
         OJNKBNyuop+a6/pCVpIL+Q7duRsVnGFB7vZTPKR/GJYLBJeDkpb+y5U0BCcMqc24aeHk
         +Lcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BHuqIf1tNL5IFXF1A87VrpQrMhtfq/QBoGyo3k89R/Q=;
        fh=yjE1YCWEOs+OpO0ND8pLi1U1qlyzJ2erdItSZRLKGiA=;
        b=RTQ6uln/M4V/orv3pky2e84XuQjvJoMl0+tk7Kzb09iYcY4K4K7WQ1rPe+61mcIJb8
         FTBRxnf5ugo2piL0uqI3iGPSu8gGb4kzqUPi2isjR5TfzDTuKSeCDvPYGdyWqlCGfmIX
         YV4eBIzuzJOqFThjqMPaCgPUt0VqXc55OPok8yIJf+Io6prBmxBI5AJ4FUViA27zT9LS
         Vzl6S6ocdUp8EdYbxr9PULcNqyG9E7ysu+F8g0IkVT5uzgKa+rjFKsNY0qNkLsFHn9wl
         EwKHuzV/IXvRGK1/gOVTl1EzcpMd4+23aWpeu+zjEOE/hZyLA79Tzfj/NC8DItzHbTib
         3Y7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791480226; x=1792085026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BHuqIf1tNL5IFXF1A87VrpQrMhtfq/QBoGyo3k89R/Q=;
        b=IqAzqNAQnNWI854x7LFCrWtlAzk0S4Q9IAI1wrs/acQcz0+ir6N7uyBxFCZa3m296G
         sBHp0fEvmrtIkHbMhAYIuNJ6ul+xLWI9PHPdAZnQMg602lDCJcwhIKbVStYx3kqWPNFH
         lTSzFKq+Oe3uQwGIvgtye9uclyQeCBERRgMC0HwppYCPM8zeYOOEWicHZK1r4KHk/n1J
         gkptt64FWittcYLHyeJdjZvnNM+oDiWb8p8yISdjjiJiT5PwazwoXVyX/xVwGC3QraCg
         9rEevCsYmulYsDT7golCu75qsi5/JMfzcZsWq3q67e/eXOeesPHrXgajCf4dzLNcmk/c
         X2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791480226; x=1792085026;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BHuqIf1tNL5IFXF1A87VrpQrMhtfq/QBoGyo3k89R/Q=;
        b=OcdDmf9+x6z4/uDrPfiO7VJ9SxA2jl8alM6euVVlOMFXBovyAJagMPw/d3WhqcrSZm
         RhiNzYsreEVNsm5F/61F9y3UVaLDn3+sUiA9jlZmWMc3XiHDXXF5EQIIMPBEaH1H/OQx
         uYn4FJQWhKdAT0KKAbkrSE+yXmiFgxCs1MSJCjPkv3plhQWo1Ol1ymqi2wIQlqtOzzva
         kdKIUT32Na0RYPo/0CdCKVzQE4/q0XxWL5FT2bmtEoQyiUM/jRObzmPKrzDrdJcCNYCl
         RO3rsI17p5k6IiReqUFcqsmRDKWB2gCbqKjcqYqZUT/Z8u64udhXi4ZeaTvFsJ7BdPDb
         FcDg==
X-Forwarded-Encrypted: i=1; AKwUvBx7hdJFIsafo1ew5LbW0+FyWzXdv+Y6ro3omLlSGn07HzAsjF0bE3y8nBK8zRqraxEQG/4=@vger.kernel.org
X-Gm-Message-State: AFuF++kuDxrUroW2fRAFAzYkQ3FyrI/YUV9IQmKL7mtXLvjgfQo1tWPC
	8qF/j1E57zll9YWXF5YuNlV8UvpEkiwI8F9PxZanVLsRvHahzPYgEycNGuGkXII0yDM1E8Inbu9
	L6YVA+x6sLZ098vA/w5XHH+7D7Uh05pGtAREKVFzc
X-Gm-Gg: AYBFou1Ota6FyBSu4HVtgSqKdHKvihb80+5+2TmklwJ3GzM1j8AjP2ZDF/3Q8jC35QV
	cg+wtElnYVVT2m5sbp0hSPMFdyY/0/S42MU/0OMvQZp8aRtf+tUyWkEomucKKbkgTahgNrulp3Z
	PL0tvcU0b3LFAeeSCQBEpvVhflUA90fHuHBGMqlgV14UdZRzEUEFF4izzexEpS2s80n1qYDyees
	KAwSwAouH8Bk2gnUKWr3CvynUAyKQdUq1kZR4W7rdLRTBkHvIMOPVld6HnsNM6ETNriOGSLswss
	kVs/hOwFgVGHfK33gbbyNlcmdIhj96SoMOktLT3gAsmtZf1U/9RTTrRti/kHl05P931Tfe+xqJA
	8RRilI2rdzvggERWEFNYWUrq60kp0dt5bhiIJFK0qL7vVIh9NotQU20QIv1jhwfnLATeaFrf9IO
	Q9s0FtymPmRau2msn0QJzZXvRJ
X-Received: by 2002:a05:701b:290e:b0:166:4b25:8bbc with SMTP id
 a92af1059eb24-1664b258cabmr2798079c88.32.1791480224884; Thu, 08 Oct 2026
 10:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008-selftests-sockmap_listen-cleanup-v1-1-f6d1a4ff540d@rbox.co>
In-Reply-To: <20261008-selftests-sockmap_listen-cleanup-v1-1-f6d1a4ff540d@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 8 Oct 2026 10:23:33 -0700
X-Gm-Features: AclHuK_ZHezGCVBzzMpcKC3XD4J4SlpbuSoU0hDuFFatZm_8hkKxjtuQCg6wZOk
Message-ID: <CAAVpQUAaNR_vJq00dG67uxe=Yp18V_RG3Vxr7KL2u=dF7fBfKw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Clean up sa_family_t-stringifier
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 10:12=E2=80=AFAM Michal Luczaj <mhal@rbox.co> wrote:
>
> Following commit f3de1cf621f7 ("selftests/bpf: sockmap_listen cleanup: Dr=
op
> af_unix redir tests") and commit 9266e49d608c ("selftests/bpf:
> sockmap_listen cleanup: Drop af_vsock redir tests"), sockmap_listen.c:
> family_str() becomes functionally identical to select_reuseport.c:
> family_str(). Move the logic to socket_helpers.h.
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Link: https://msgid.link/CAAVpQUDULzZh58oKkRaYqgM9bRToGb7wHrzT+cZNpRmAtM1=
2Ow@mail.gmail.com
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
