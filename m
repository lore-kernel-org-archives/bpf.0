Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794684979;
	b=fAeTDLL3zK8jTmeCvGxM+WC3vA/KP1fW4iH0Y+g9Qo7MBhTe+mEBpjUxoYB1Y9hbKCUb
	 TIYOdWYAUXm5lQeB0IUE21Y1PmPcd2iaEsEh+sX02k/448QLlmXdChPQEunJ+jyWgMFNc
	 fZivXOuquoDo43haxAV+x3ysXEywCj86C+GdfNvenG0Ej/jhPoO2X0Q514w0xVLGf+ELs
	 dSgwICYOtzY0mmGEV0UDJtM+WeZlrkyQk0fzTiSccJ4eyzTdNXRB7BkiG2tvIHNGyDwI6
	 GWscdH+V2kBbBj2PLbrqD1/GTI7tQG+z4P5Z/7sSkns+yh0kfCeNwD4+O2FifvgWn9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794684979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=8zVUItnPHFNIUP4Z+vabblcyhI1ThNWFGye2ryxOmnY=;
	b=QT0MaHJQd0IAjmX8cpZDa8tmlFkIoeQdv/aLvaw6Sw82lG9S/cOTgWLwGuMNp4/5s+Zh
	 /3x7e+0KLUqAqkR1c/pWadN/GTD1NJlXsO2C4z4OJnaQlB+mF/B9OoYRWTiI2vs6B8u4m
	 w5AQEXp7K4K6E2CIyWjIBGFROwInFAJSpEPlUyQbVmkJ8evMCG3y0KPpNbdNJ6gBAfA5T
	 /zWKLQiH1d3RprXfj7vAhuOuJxoopw6jY4ORDRHmjdTJlH7+sZgH08nSCxUJf4ZqBx/eS
	 cLLIRmN2hIeEq6TFd3GMsHIRQzYckPzvoB3uMEPUTnv7aJCBwQVc7zCi4F7KK/0ms1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FZLxnZCh;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AB8606A327
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 19:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06AB8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FZLxnZCh
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so2162009a91.3
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 11:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794684978; x=1795289778; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8zVUItnPHFNIUP4Z+vabblcyhI1ThNWFGye2ryxOmnY=;
        b=FZLxnZChQdyk+y/moM6mcBlLd9ZNuBhzt+gBd6Ols7VyBVMrSNtdAkaKCydZLm4B22
         ICuUw3eK91GGD4OKs5+ktA4ssURexzME56B4NihRNiC1LOxfvZoAYle1rhZIbFivaJu7
         Czn8mFXFNCxYt1mzJWwixcgMfWdYAynr0PqRdRwswhq9LYt4zcgfR8rWJqBBvYL8tK6N
         CxkwQl+3hLLGYadKwqsKLA6/xFDoBWwRD/TPGiSTGPTOQ+dR/UweDP0Nhp+uRTR6gs8K
         prGyDJbJkDZe8EJIFSo/glcotCm4LOHr+cuCkyz3RFMrcBIqVCR/ij8hj3Y8eyH7jOHh
         jETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794684978; x=1795289778;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8zVUItnPHFNIUP4Z+vabblcyhI1ThNWFGye2ryxOmnY=;
        b=bWIt1cJItGpL+eTw9Y9aAcnxPgqXgH3kDbFfQA/BGmfe9tGO7pgRJzSABj+eUoCTuB
         jS+pXJTN8WG/As6X9NxtjvbIwYgAYQnlp5sEkYx8FQUam/xVDuipuqxr9eEwsl8SAyWI
         ChSqqCr5NbidC/rfywQRy3RH7GbISfezBb0G2LoqaUIQlX2pnfI195AusJO3JGwiBSs/
         0FpR3C9mY6hRINBXr+BuKnUTt92llbA6NxI5cuWL5DM6JB3wbXauuMkEaIb/Ux8kpiEl
         DJOy2ybOayo2azQ9z1kHmtLWQnQk1rFvSEzyCNO7vTdOYx44qY7goYgQ7Zz6adAS8Xll
         EWrg==
X-Forwarded-Encrypted: i=1; AL+hErE3Gu5GuD7pUs+f9/ixdZKVL7qjbhzLLBqdi0eycafLjR27M7w0eSZFraQ76XBj0talA0E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Tu4ND3eErcxDQL0ByHVsER0EVeXKiLYceEurnjtIGYpds/J7Y
	VphnYKAv2Kne6dxFMPDG1P4+3AkYgl+1Kg3GHc/uWMMQtM1uzKlYnH9B
X-Gm-Gg: AYBFou0+X9v/N5/FuTRXCsv+qDFYK56UPAnhYwgpqtyan1WyCRBF3SVQVdC9Ljp6lc5
	DY2OJlmAGMHUb8bvSIbg2+aB6KtCLE67tabLaSr2fcHADCm1UHgd+11lMwQmzugkWX0m+9U2EtW
	EEHkOnCb7Buy7d7AEl+8+x5c6jtsalTFj9kuXaaptcd8sTdH8EtKwgKyNSsIwMfemf1Re8rOzeL
	Cm0KKN22sCar0h8p04Cst5aMhg4/rfFHcTB+PnhO8j8mOLbVRLItzpyqQeHyWP6EVMFyKb2WsaW
	DgKeeWvqNakXUpVpAD56+91aNeWpMT5xmvts21TdKLzZxeQUUtNAtM73MECT2CFrPxoQaPiN7bn
	kdOXFCqQX6+rLPfOsO/8jhhwVubVKbt9PSGW2M3qSu02M1hYrJyD3ug2Vyv0YXhMitCxBSftaoP
	h6TpAh0zqYwD67YjKTQh0U9l4Nsm1uVAvMm7HHdujVNs3xu/1rTyzZFQ4+gwRW/5O1AOlQ+vfqb
	BZW0g9QXr99F6FkUYJ1uZ8HxWpOD/XbZEjrHZ5aCag0Fz2a1PSnYJmGHmzzhLbF0NmIl3iRhfG4
	Lz9tFYJBcKuXdBPMpwvJZv5mizAm9nbvQc1ktMVu887uV7qVC/TdDoLNg3EaDSL469Wgmenycat
	JS1PukR60K7IKzu+Dh/JAfnV0g/XxY3VKX37tuajygmMeT++2oLMq8Tc=
X-Received: by 2002:a17:90b:4ccc:b0:3ac:a203:e0a5 with SMTP id 98e67ed59e1d1-3b1b0b6676fmr5703275a91.11.1794684978409;
        Sat, 14 Nov 2026 11:36:18 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb179fasm9924002a91.4.2026.11.14.11.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 11:36:17 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Nov 2026 19:36:17 +0000
Message-Id: <DMV6Q8SFLQ72.2AIN7VRB1JJOW@gmail.com>
Cc: "Kees Cook" <kees@kernel.org>, "Kees Cook" <kees+treewide@kernel.org>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, "Linux Next
 Mailing List" <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the origin
 tree
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mark Brown" <broonie@kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Eduard Zingerman" <eddyz87@gmail.com>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "bpf" <bpf@vger.kernel.org>,
 "Networking" <netdev@vger.kernel.org>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <avNO8cuAdnwv9D_5@sirena.org.uk>
In-Reply-To: <avNO8cuAdnwv9D_5@sirena.org.uk>

On Tue Nov 10, 2026 at 5:05 PM UTC, Mark Brown wrote:
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   kernel/bpf/cfg.c
>
> between commit:
>
>   0af298e62e5cf ("treewide: refresh kmalloc_obj() conversions")
>
> from the origin tree and commit:
>
>   6771f70a47332 ("bpf: Remove is_state_visited(), bpf_compute_scc() and i=
ter.depth")
>
> from the bpf-next tree.

Thanks. It's resolved now.

