Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCD23101A9
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 21:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789076987; cv=none; b=LPE3C6mIupgbE3pYylMnRFU83GQtqlIUhYBeN8LUCgAXRFf2AOn0FkwuwvJaTi1zMYmHdXWTE8HLnl0ilhCtzaxinBS6XBad5H5zE4OkSOHKYzsVSMS/hjUwB/Y/tLNN/bXdawRXRn+XASwY459mBBKlSdEkHzR2C2RQNvXkva8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789076987; c=relaxed/simple;
	bh=VcCpfU+gr5mgq5UoFOwg28wtM6kRA+JD9Sc904H5qVA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uwfRvL7Y6bFhBMmfp8DVOgV+T/hTL6l4fjGA7aerMZfSSq58NZGTzZVFiU+QJpbgDU9Wx5rO9IbsYQ6h7hQvbVF1rTtdc4L7e2y6cOeg1DfTLQUJc1HlYPcfzJj/EOUvWNFEYZXOGz4KdSAMc5qtw36IBIFvQ2uIz3A05an7pFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgcgVPXq; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgcgVPXq"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-39b9a99469fso226859a91.3
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 14:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789076985; x=1789681785; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cTbSlvf8fbaSW1pTt9kouKoPX2DRhtNPjD5pkOj6vjg=;
        b=ZgcgVPXqx32BW21bfu2C+ylVamslb0ft/n4XG7az3SIHeTdsBn+J5+bsACRi5hQVd3
         pnvb8qUHfYX+nvi6Wlyop/pWmemXsPp9L9e97Il6FxGasYqaCh9dtsaDetQKHDyPh3J1
         hORBJUN8FqxfqZngZQd8vw8uXHbhLrL8+EVYT8i3C/gjomYxYF3gKZqfJYHjXjbBJ/PH
         5Iz2H/xr3fo3HzPOU0mXyWYTe4sqSzlnPzfa5dP1WejuGZTZWj2F468eVVe8KUGiFVZU
         ZyUn8Ia+F08hUQpEhjDlYaM5GIGAj40r38bSnRTS3m4nxG97E8tjESb9V2zkr+cQd8KS
         IZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789076985; x=1789681785;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cTbSlvf8fbaSW1pTt9kouKoPX2DRhtNPjD5pkOj6vjg=;
        b=nrRMrN14LMFQuAwLfJPfzUyHFq03WXwq8Vr2jhby0TKuocleylUHX2iThNEuylenrK
         Wfz0o7KD3s9AkxZjS6tQd7B0aYlfEkXeabJVtaPVZdY3SN1Nq5cNUNTr9HReNYTxY/xB
         OCRKmdvlBUIi7+X4TEbENZWg7RGKf0ZY1LI5sXqiV9eRNpwVKi5sLrAV6Gq4+fQFwMHb
         7hzQPjIEfwdFjbh97zPQE09870X1r8Ih9XPEUKsIN2A/EG2s6g3jo6II6InlnPBMZMbI
         Ap1KCvZ68EpzkR+ML8lSvxZv/cQaxmNQ+bSI7Ry4Cp92MIiGkogfP0nKQq52VloMVHCZ
         +o+A==
X-Forwarded-Encrypted: i=1; AKwUvBx57ILS2Q01/RajqH3sIVYFJSjEYOpoapar8DmIB5uRySrdH+uq/ECGKt2Ru7Ot6zihQaI=@vger.kernel.org
X-Gm-Message-State: AFuF++lFK1vm7Rz3v6IMUkIWshBcSFjmaif9BRT/FFlvsds7a/TnRbHA
	AyijWVcUG9cwLybrTJTzRLX4WM2j7T7XS5rSPomRiDJZ+RRXN6BDS3Qw
X-Gm-Gg: AYBFou3GN+M09pD7MGWWZRX2Mxn+0aKg4KLiTJvwxjINXFUznkjS7SiwloCXQdRX6XX
	hZpkVAu8WeA1d5zVnXGoeefRsRpkOHLP5mdzQsg5uQsaf3AlTmBxvbrQ4Fr9TTOstlYO2IcjyqI
	lUTFFTPlapwuHVP8CU4OIGaJZV6r4tGixqKdAw+q92RSYGzxLgSdZpxNYhbtdLfcoqU91Nac0ot
	aEPP5NndA1E+61qyD/uBc5Vla/0Sq0YXDUfB9fmp/SsnN3WamJMdcelIstur94Exb6XwszV0n8Z
	JhZ56RlXWogBR5V9nCzttK9X7Un44u2cEWEUhEMINl1vKphOh0JIpJmr2CzMo23okYVGZEiDeXG
	1MuX42evL6rZEnsMkt4zbM0ff+BVFKex6Uq5TQAnQUFtJFnPmX1CwxPPsUl0alsgHnQ1lKvVX9c
	gLpUDaTjMdxdFEcVFRDMBif6Dk6B1ivhDqVK3LZPtS2O9TWTnGEMzsQYvjiDKMHfteO5MDvVZfN
	0vIM7qS+KEC/7SwvwGfiE4HRNqu27tGhNJR0f3py3UZnymA3Jh2bsm+tQ==
X-Received: by 2002:a17:90b:5790:b0:396:4c63:7193 with SMTP id 98e67ed59e1d1-39d9bda7ba2mr1320522a91.11.1789076985602;
        Thu, 10 Sep 2026 14:49:45 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a3ce:533a:7492:3ff3? ([2620:10d:c090:500::4:d279])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9d8cd962sm102522a91.2.2026.09.10.14.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 14:49:45 -0700 (PDT)
Message-ID: <87c1060d5233c9b7a73fcaf1b6d96bc1a700c49e.camel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix divide-by-zero in btf_struct_walk()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan
	 <shuah@kernel.org>, Amery Hung <ameryhung@gmail.com>, Tejun Heo
 <tj@kernel.org>,  Matt Bobrowski <mattbobrowski@google.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Thu, 10 Sep 2026 14:49:42 -0700
In-Reply-To: <20260910122316.186384-1-jiayuan.chen@linux.dev>
References: <20260910122316.186384-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-10 at 20:22 +0800, Jiayuan Chen wrote:
> When an access goes past the struct and the last member is a flexible
> array, btf_struct_walk() folds the offset back into a single element with
> (off - moff) % t->size, but never checks that the element type has a size=
.
>=20
> BTF takes an empty struct, so this in program BTF
>=20
> 	/* event could be empty */
> 	struct event {
>  #ifdef HAVE_TIMESTAMP
> 		__u64 ts;
>  #endif
> 	};
>=20
> 	struct batch {
> 		int nr;
> 		struct event events[];
> 	};
>=20
> divides by zero at prog load time. Getting there needs a PTR_TO_BTF_ID th=
at
> is not MEM_ALLOC, e.g. a plain read of a local kptr stashed in a map from=
 a
> sleepable program.
>=20
> Oops: divide error: 0000 [#1] SMP KASAN PTI
> RIP: 0010:btf_struct_walk+0x53f/0x1570
> Call Trace:
>  <TASK>
>  btf_struct_access+0x42a/0xcd0
>  check_ptr_to_btf_access+0x4dc/0x1160
>  check_mem_access+0x3a45/0x8740
>  check_load_mem+0x36a/0xd10
>  do_check_common+0x3ef0/0xb210
>  bpf_check+0x6d3b/0x8580
>  bpf_prog_load+0xf7c/0x2720
>  __sys_bpf+0xa83/0x3690
>  __x64_sys_bpf+0xc7/0x150
>  x64_sys_call+0x1f3f/0x27e0
>  do_syscall_64+0xe5/0x610
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  </TASK>
>=20
> Reject a zero-sized element type. The fixed array path in the same functi=
on
> already bails out on the same thing:
>=20
> 	btf_struct_walk()
> 	...
> 		/* skip empty array */
> 		if (moff =3D=3D mtrue_end)
> 			continue;
>=20
> 		msize /=3D total_nelems;
>=20
> Fixes: 9c5f8a1008a1 ("bpf: Support variable length array in tracing progr=
ams")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
