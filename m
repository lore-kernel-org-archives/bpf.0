Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C4D3BE154
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 06:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791612931; cv=none; b=eoHd1wiEyKCQ+qiJOARs2bffGQOuz/Xw8YaRa497NwVefwIxfIMo48Pz6G8xfZiBdKXxO7AJyzodegBxeoaRjSzVZZ+IhS2zcdNp2+0A6fk/G87li/7ETmgvJHKnMZ5XfKOAJvmP74Jy1hw2WAfNJ35zgfB1Xjl623Fr6hJB2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791612931; c=relaxed/simple;
	bh=TwIv1NPnf52ZhmM9XXPm7/XDI2xCes9eFdq058g6a0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rFr/4qotF8WoZKH069IzL5U35jWEf4VmjcUYh2xRUCTrWc1wZS2ZgoI/r2+hOOS4aBAziD1ayjP4Qu8jyTdjrYMXAu/BVGodRMa7HJShEY5y908TvnrrExJXcfn9ZPBGoe6SAJcCvEtMQWhtCD+o7BuPqnFLkLXS4AidJWwotZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReOM6zCU; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReOM6zCU"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1438d9363fbso203103c88.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 23:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791612929; x=1792217729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TwIv1NPnf52ZhmM9XXPm7/XDI2xCes9eFdq058g6a0c=;
        b=ReOM6zCUr1d/uLU0JtgRsmO4/DWvuivI6csPKx0XZl+y0MTlYovYnyNA3+heFaopnf
         /u+ggKhLuKr8qNdLfhN/xeebnnRtXPcFIOfvlgBTU8/fsIgLYB8/KMZB8FDXBn1HTYPw
         SOI6hG35a5aQJr4q1tIlpo9QM7flZ+49+NoWmy1OjCRuAy7JRn2RIWENbHzI0S20nLTn
         RwIL81H+XoteWNXiBdcnpc9GhkDZ0mnpYq4XVo0aUQOs0w7ntZJoVwFFThKA2tzQ8W2k
         BmClaZRPWDnfNEZa/Tf/cH4TzeEGn1lpQBxAkX1UyjwJA0XozOs9EJ7D9RfofETW/fvl
         IV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791612929; x=1792217729;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TwIv1NPnf52ZhmM9XXPm7/XDI2xCes9eFdq058g6a0c=;
        b=CETNtpEl/PG3O2QkRAnR/WA95QGPc5msq1uee60DntwSyjI7ZyCExg1kgSCLetbliy
         UBjY+YsndQ2B1P1Uh3vZnB/VHR4EK5b0LDkFZfWq1//h+Pyv2qEdHomYdC0hjtGRtuyH
         1a/4Qr2YT6bH246xuswtWKvrxS0CgpTSOHGiL2VenNtm3K8BB9etxqbJGKFBqa27vTtR
         STgG3lig6o0s9DNQRTF5VbdJuu4RuKbG2wSMBLcUDavqnN1AxBcZOK4+34zv5b8CSwvi
         qHtyvGBTT+lMCKyYyInIA9AKTe6hRK9t2CzsqzsHGw8Tzic/4arN6Yx/J40TcsrGkpy1
         DO6g==
X-Forwarded-Encrypted: i=1; AKwUvBySyP20wtMlXy8ajtmhjxNJihDVq+WvTDt86FsY57wN99J6JB76YjdberIstc074mrEXUY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKC4/c74NDDz9F64dHrPTx88o03ALMNwaxAMzBLuJDYSnRXaFiG
	mrEhruc/yVT6CAgRDuXeSft11QFa5LHsGfOLGfkVfw/E5hJI+zDqhfIv
X-Gm-Gg: AYBFou2/p3fNVqFCjFN1+XTdI3P7juUU5NVFRzGwjs0uL5PfwACObIgBjJWvufJ/LHA
	HLfE+HOhdii4XAN7q9HTQkmaS9V5ZoLwjX65L8iMA8c8YF/Nx8zq0z5h66XgmTk1F/rT3woYl37
	py3T+aakL8lu52LsBL8ae19zbbMpF7cdNKIMyoidD5nhH8fQAi+UBhX7a5cpchXTOee+UOpmhOs
	5MEQHaCIBho2RNxnuw6uwNr+EH8Opl9jfEQBSU8gyTtxvXs81ilmArNwn1LyLo1If6KS9K/Mwgf
	WgqYsmNu4v5vQNxDhcvBQR1UuqLACUBplwz9SSsdLFP/q4XeIJT26PCUToPUgemvrBsH7PXlrrg
	L3wr/ymffx1qKribkPZ3BfKyLB1NNevRUmntGAJP5afuPS8JWNCpx8wdLmwcs/gTrrv/u+DMKfV
	hN15YkEARxuqnt2XzjminwUwoymTOz2HitzsANCKqv281+QWoQfYwAPlVNBUf6HQ==
X-Received: by 2002:a05:701b:2405:b0:155:734:9cc9 with SMTP id a92af1059eb24-16a131cf188mr4972254c88.16.1791612929280;
        Fri, 09 Oct 2026 23:15:29 -0700 (PDT)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb5e9sm12663786eec.20.2026.10.09.23.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 23:15:28 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: bot+bpf-ci@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: martin.lau@kernel.org,
	mason@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Wait for the struct_ops map to be freed in assoc_in_timer
Date: Sat, 10 Oct 2026 14:15:21 +0800
Message-ID: <20261010061521.390089-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <7c1af496987bd30766e332358e26b3e1256fb0cdc72e2f0412ef0e116b0c5223@mail.kernel.org>
References: <20261009-selftests-bpf-struct-ops-assoc-timer-v1-1-9a97a9b3d1db@gmail.com> <7c1af496987bd30766e332358e26b3e1256fb0cdc72e2f0412ef0e116b0c5223@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Oct 9, 2026 at 02:36 AM bot+bpf-ci@kernel.org wrote:
> Should the late dissociation be fixed in bpf_struct_ops_map_free() instead
> of only making the test wait longer, for example with a grace period after
> bpf_struct_ops_map_dissoc_progs() or by dissociating before the call_rcu()?
>
> If the flakiness started with 5db69b0fbdc8, is the Fixes: tag pointing at
> the right commit?

Yes to both. With the window widened, a timer callback of the struct_ops
prog returns into the freed trampoline and the kernel hits an int3 Oops,
on the first run.

v2 [1] frees the map after a grace period that follows clearing the
association, since dissociating before the call_rcu() would take a mutex
where bpf_map_put() may run in softirq. It adds a test that catches the
map being freed under a running .test_1, and keeps the test fix of v1
with Fixes pointing at 5db69b0fbdc8.

[1] https://lore.kernel.org/r/20261010-selftests-bpf-struct-ops-assoc-timer-v2-0-d7a43896dbf1@gmail.com

Thanks,
Qiliang
