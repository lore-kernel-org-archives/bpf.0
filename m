Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26311335564
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783025740; cv=none; b=L1lK6FlACHnWmpV7lckd06DBZE4ZXytOGkOoyzrqsoRSwv1TvQQ1KSu8KH6A+CrOgFgZBq3ateZJqzZiqaexNrMOu68Gb9TmQHbHGpF29JK2c3JYfaNo85JJR9ohRc/7vxL57icIEUcCMAXrJqORS0UsBZxvsJR704KTN6IDmmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783025740; c=relaxed/simple;
	bh=BGQezGtAEhObtCT7zzcr8aPET3DzThoRgRXdFBLHp2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVWpvbK2noALJkf12sR2MAS9IEmrPJ+TrqRq9rk2R5HXgqFoqsWXcLoRvJ98j7hzFF0f8nMI+tTWuAgNTqbIzdihLx2qYAc+8Ih79wLyUyOnk1N7zKBUX4k5w2YCjRRTgnistOOk7741KncNNshnGFTCwzg3PCXggCT05/rEWT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wWVR15nT; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wWVR15nT"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69531108f25so4412722a12.2
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2026 13:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783025737; x=1783630537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l+3jLVZWypF3i0IWmKvq6/0JVUOvsfukC3JPM7pFG8I=;
        b=wWVR15nTlyRcCK+0BqKliXFvSPoxzaocr8fyuE3s1qqp3z7g6ykj0Prn2DuxDce+eC
         aVeNUGi4b2Mwir660+iVxiSKyR0HY/jvSGWnrgs538Z9bmQEzp0aC75Hhpqrav3b20bQ
         ++iyKzVg9xkudwBE84QIS3MqMZes/75xsF3r9NP1KilpuEYdXh+Q4HQUihAhO7eDZ2tj
         cQ5dMZpBSRNpNdZBE64aPGUBMN4gNaZjt6cTcPq11jH7YScMf234u0x8oKArNF9LpgKE
         5Cf9+8/zBa7hLAzoH0DAy6CYIbXtv/SO1P7Zhbg/STbub7k0OHqB+8vRl0wm6NfBqJ9L
         DLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783025737; x=1783630537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+3jLVZWypF3i0IWmKvq6/0JVUOvsfukC3JPM7pFG8I=;
        b=GqsxABn+xQyuZud33ScwC+YhKsaYcFWqmA2qIwpJUFaK3yjd77w483iRl2m/xRxv1v
         6/iJgqd++PCP5/asAiakjDLUGfuB0Rng5kro5Wmc/LFL0c6/e+rSEWrn0BeupHxkx3Oi
         0p6U/nQlZjNPu7TF60cgmB4WcN5u1iyGCMa0tYBrc9TJNOObvnwhkjz/AGLArGE3yNL/
         eUGA0sW2oKwZfaXmlQdkGsx02oP3FpJl8yis9hELS0UWIJ0ZIwRXo+JFZuQbpdFUfKJE
         Ykeaf2jGV2UbSSkgZORzYuXV1Q0545NUnEVqy0RgqcZxEaw5yXx04VUAJ1rNct8hm6BJ
         iPEg==
X-Gm-Message-State: AOJu0YyUBPAgXL0fqj7DVFeMx8mdJTidkJ6YBAF/ej4Mhw0OoEtMAXC8
	ufHGkmGe+dmn2CceM/YDj6FFvkYwtU3jNPI76MDWWvRBcclgkfpGajg8mumppS1PxA==
X-Gm-Gg: AfdE7ckzuKEvpsG1h2Z/WJ7ueKq1zqxyit8Cg7MgsBl86/WOHZ4dhU7zboPkv3EwuVx
	uw6YbzQSTCWaHBIMleHbrfchOUCUmQdOQ5E8yeRC7POsXvJoTm6YLwe9LUKeg/0CuHhkk0kAdod
	A7jhP4Kl8nh05EJxKaySKmL3VHENw4wv/5tAre4aEbGdpCK15xPJPpDBRccdBc6a2OiSxHlNGPh
	VI+Eca4HJhF4V4WeOw86/w3ZS5v4P6EU8NoH06gYQZyOs28niwxYy31h6AACaVFX7CuU6IyNrWV
	n2R+P3P/C9cRo+KSTrLu2u6sPgdoS28M9ImPhdGGY/iO9tEHZn+0VYJKDUcjpypN8tZrp28mNp0
	UwqDYdOtTtbSYKX6OELuyAw3VX5doRZG7+Kt9IAxpfGRPpglfgOZC0lpAfnC7DDtBqmF7QWutEq
	F+qlnkDeyKH13y0R6Hyfd+9iulqRyw1Yo/HUYsJhxv5JVGJPHuUDdcwRzQuQ==
X-Received: by 2002:a17:906:c086:b0:c12:a5fb:ff22 with SMTP id a640c23a62f3a-c12aa33d14fmr302689966b.50.1783025736895;
        Thu, 02 Jul 2026 13:55:36 -0700 (PDT)
Received: from google.com (136.183.91.34.bc.googleusercontent.com. [34.91.183.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62c53c1sm181439566b.45.2026.07.02.13.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 13:55:35 -0700 (PDT)
Date: Thu, 2 Jul 2026 20:55:32 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, oxsignal <awo@kakao.com>
Subject: Re: [PATCH bpf-next] bpf: reject BPF_MAP_TYPE_INODE_STORAGE creation
 if BPF LSM is uninitialized
Message-ID: <akbQRG_Kp6ms7pTr@google.com>
References: <20260628201103.3624525-1-mattbobrowski@google.com>
 <e3c95beb-8b74-4037-8520-9f3c18a35606@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3c95beb-8b74-4037-8520-9f3c18a35606@iogearbox.net>

On Tue, Jun 30, 2026 at 05:31:13PM +0200, Daniel Borkmann wrote:
> On 6/28/26 10:11 PM, Matt Bobrowski wrote:
> > When CONFIG_BPF_LSM=y is set, BPF inode storage maps
> > (BPF_MAP_TYPE_INODE_STORAGE) are compiled into the kernel. However,
> > if the BPF LSM is not explicitly enabled at boot time (e.g. omitted
> > from the "lsm=" boot parameter), lsm_prepare() is never executed for
> > the BPF LSM.
> > 
> > Consequently, the BPF inode security blob offset
> > (bpf_lsm_blob_sizes.lbs_inode) is never initialized and remains at its
> > default compiled size of 8 bytes instead of being updated to a valid
> > offset past the reserved struct rcu_head (typically 16 bytes or more).
> > 
> > When a privileged user creates and updates a
> > BPF_MAP_TYPE_INODE_STORAGE map, bpf_inode() evaluates
> > inode->i_security + 8. This erroneously aliases the struct
> > rcu_head.func callback pointer at the beginning of the
> > inode->i_security blob. During subsequent map element cleanup or inode
> > destruction, writing NULL to owner_storage clears the queued RCU
> > callback pointer. When rcu_do_batch() later executes the queued
> > callback, it attempts an instruction fetch at address 0x0, triggering
> > an immediate kernel panic.
> > 
> > Fix this by introducing a global bpf_lsm_initialized boolean flag
> > marked with __ro_after_init. Set this flag to true inside
> > bpf_lsm_init() when the LSM framework successfully registers the BPF
> > LSM. Gate map allocation in inode_storage_map_alloc() on this flag,
> > returning -EOPNOTSUPP if the BPF LSM is in turn uninitialized.
> > 
> > This fail-fast approach prevents userspace from allocating inode
> > storage maps when the supporting BPF LSM infrastructure is absent,
> > avoiding zombie map states.
> > 
> > Fixes: 8ea636848aca ("bpf: Implement bpf_local_storage for inodes")
> > Reported-by: oxsignal <awo@kakao.com>
> > Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> 
> (Looks like pwbot is asleep; applied to bpf.)

Thank you Daniel!
