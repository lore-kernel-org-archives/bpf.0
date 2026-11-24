Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529724;
	b=zcVx7MSD0gX2PpU/+RTcqFrfiPiZs7PK4SV5MtWSMR/VTNsBF7KcFjlpZIgxl6Bwc+0s
	 NoVCL3OFK6H/ywW8+9rPd/lrMtlFtRNTWM5sFkp7EV9BPR22cefo+xkrXQPcXq0WVIuVM
	 QuA0XxFZiQjanXliAs2PhCIBeg3RMlF6c3mGAJPfa3Nf0dqMSsqdR240Xk5mzz88ivoFG
	 7nm54oEtKMZzTCnBpxcjNEIjOIMjbjBlaD0uLAiawpBZtg22uwQdE/5xqRVUwYZqrTotL
	 czpuUYhuMQnFVKI1lWEy3YOdAt22CIoI4fP1muiF0ZJgBsGi2JmwLA9cBFqn84U1N3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QRjj8NCzCfKdlHLYEm9kkv/Rs2Gs/fSn99ZoFjMfvtM=;
	b=Tjac+9tW1yshLkdWF09GHBY8Dyk7xBQ/y6xFNR8XfqP7nkNfSdteLmZ4h5ucW802fKJ9
	 UW4sKAlcj0zEjR6j/al6bQ60gsr50uy1PaFszgmwv9xgVKJsredV0uP7/cy1DbtGYdDvX
	 pL2vX7LYiUwJw2vj8mzpja0aWwfvBxZBmXRPVe1+kIwXjJgiTWaqGpxIwiglCbZJkHGgb
	 07+TCuqxcjKVPq8KEBQ1PC4Jj4uIQf+lez+2QOAAeFkQw/OVlHURQH6I7eHGwY9IZfB5m
	 AijlZJCzTmxFKr5qD3IXw1DtOJ4NTJFv2eWdrkR9AHMmd2KMYvLVlmfD1K4FU4V02hQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Vl3/HRG3";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8589A606A32A
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 14:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8589A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vl3/HRG3
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67db23d8892so4940893d50.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:15:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795529723; cv=none;
        d=google.com; s=arc-20260327;
        b=ZeofyM3WQkeRNdBApDa1ZhfzINbIL7czRD3MKRUKEpFEaCrIZrNhAef7PByK2XUM90
         x9R7rAfO4vzeuZkTldIwJpZ3266ciDs+rrJ9MW+yNn+c/FmSaeo13aw8aO4mMmy3FJVv
         ZiYNvHlxulmQnwUvzWwdJ6qjxHaNCKKBF3HmOZYD8QuHX+mOEOBgaYLelPyQgcdH9Xqu
         38ju50ZYaUNHpgAYlxgjQubtuDPWwqpPCHk1gyP2r7/Xc7OQy37BJBB5FVSjTuU26h0c
         UvRjIZagMUsCqkrmtynYPQbf/+CY33Pfvmc5OY3uby/y0q7yXbZEvSpkICumTVvviBGt
         pR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QRjj8NCzCfKdlHLYEm9kkv/Rs2Gs/fSn99ZoFjMfvtM=;
        fh=Aj++I/VyavLe2dDhHiBtcMYXP/mh1iw17NY0QD1hnAA=;
        b=Hp2jUxxkqfD3D+E1bi0kiCa0/YJN8SJEQn5P8RDUyNRNihis8odu8IMO5unFI98y4k
         e2/UAARnCzeuBRI+tE0BSczvnGTltTOf+OErwKR7Fb4sM9uQdzv1hzF+ZFxpDSNSIy8h
         eRwhcOUbtR0TpqbaHmDjzjAtyP5MTNoPDXRxPtm3IuVpo82Yls+6UjxDTzAS1CZF50SD
         fCFidOs+CAqCJ45GXSB18vpDIv397AKNjVfel2axrfPT4UsH2udysz7czBDmYTS4Lu7S
         Y/5zghMmsX1OYhp1/1juobhT/rmg+BeCHMKJQTByuTW5M2W+KocQovuwcOsEajTqlGtn
         QdzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795529723; x=1796134523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QRjj8NCzCfKdlHLYEm9kkv/Rs2Gs/fSn99ZoFjMfvtM=;
        b=Vl3/HRG3NHEGgUGuvKMPp4b8XFVrzYtpwP8PHayrJCTqTHeZC+u8ZblgpkClSi1Lev
         s84eVJdIvQw9ZFhhDn1qEmicFhVxvw8uuKL2MTlXuaIFgbK+8Iw9Vsp87fZ+q7p9yfLW
         6vP35PvIkmNHHMTqD9qQ3cAjaMfOlQ97JUz/Q9vL/LZdivGvfBF5bgBUwDJ1Ky0CL0Kb
         fJsN58/qRkHKQ2TIdEOExTCm3UmTYU/KuMTfvree+3v4fDUd2xjehxCpZqZr0f1hxLUX
         aQ9pxHwSEQ6UcW+Rrqc2EONVTeAb+FJihIgpFO/hI4FvQyt30SW7bBV5zsmtKPX59X1d
         LoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795529723; x=1796134523;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QRjj8NCzCfKdlHLYEm9kkv/Rs2Gs/fSn99ZoFjMfvtM=;
        b=HSsExxYmzJFIJUSjRUdu8a+adOE5kLM8L4UGejJ+RKzi7rJZrv8GZ+djUPgXQANCqi
         HDtz7Iz2GXvG2wV6aZ8Tee7jK4c0FmfaK30NRhfk69LBkY9R1O7+cRTJC39AEPYgiam6
         yiz+3qbfi222sOdFDUgsQcf7gVXcMWRm4prRF9WbZ7LvTQaThk7VXLEwrW4W7+x5sUwP
         6o6/l8VZh9rQY0QtmZLKTpybK+QqmITciVRpKnVgF7K0kbERm5ItYyN9/sGLCN0Mozqa
         hflNSNlPdE8DYmKuHNYHpv+KsArKihpCPVAwi0/ZCoBQwP0LmmNaBCN46Kca5aQxq9pJ
         eRdw==
X-Forwarded-Encrypted: i=1; AL+hErG/3k/uI1cB4hY4JN2FK0JNu5g4hhbeV3MsXltSS3uEBtmf5wpRfHvrjp3vtfnUYPvyDv4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+x4jNm/q0O2+8u99nP/UFfM5sOktHCVojI0z4oab1mJp2PAJCr
	Phc3sno8VMJjr3snn86ZTm2DHPEzRA7S85e2vym9XYTvAvik07Efhuyy/SzByXIuZaSdMv+HoiF
	zXvMJ3hboYYhi+MaGKDNKLI4/M5JcTbQ=
X-Gm-Gg: AZFdTZfO141KYlqUXD0dBxCI0wU7z1Tl6vjCG6PxyxkPn9WWGa4axQrWcuuL16Qq366
	I1NQrvvur9IZJo0GJMOpxVijIfN1xR/kwEjDF/j0Acsh3RXTTep/r36Q9Ygk02Sbi/kDCoDVJUY
	VKfl9Um7rhCPR9zoTlkD0Tysyju3UlqDHmVk0nvF9qscSPd7UZ/pI4srteafmGNvM9TYW5bDxCP
	DIebsllRC32Hpd9PKFV4MTszl7Dl3EG3h5BuZGbQme18Ax3u4OzuDGiJNFNxHzBzym5b5pcl/SL
	QXsSNMHUbvLiQGaQTaeHm8xwGvwA4mKTvX/BqZnYnvjC5jedlJtEKVPWAvER0ftU8n3m6YClEVd
	IVYD7ivmeMKKB+AYHT2ZRWuYSkj+fJisJHFpqWEJic8wG0/I+2aJoFUu3VylqgEDU0RP2cP7/iL
	arkWucOfd1dSQV
X-Received: by 2002:a05:690e:4085:b0:67d:ad36:d42c with SMTP id
 956f58d0204a3-67df42b39eamr7694584d50.15.1795529723374; Tue, 24 Nov 2026
 06:15:23 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120-jf-bpf-lsm-retval-range-v1-1-d712e4090907@linux.dev> <DN30L7T6638S.3GDFKZBDTI1CN@gmail.com>
In-Reply-To: <DN30L7T6638S.3GDFKZBDTI1CN@gmail.com>
From: Anton Protopopov <a.s.protopopov@gmail.com>
Date: Tue, 24 Nov 2026 15:15:10 +0100
X-Gm-Features: Aa3M54qQpPHtmwP1192ygb7LAa7vvc6YBSww__BPrR7PuVVlSLuQfaNxD6zMhRs
Message-ID: <CAGn_itxav5uLkQXCzgkqzgff+ZsFZrhO6rofZJJSqk7K7JPGWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, lsm: Make bpf_lsm_get_retval_range() return void
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <matt@bobrowski.net>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 1:28=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 19, 2026 at 08:28 PM Jose Fernandez (Anthropic) <jose.fernand=
ez@linux.dev> wrote:
> > and make the function return void, so resolve_btfids no longer tags
> > it and no fmod_ret program can attach to it.
>
> Applied, but that closes one function. By the rules in fmodret.c the veri=
fier,
> helpers and kfuncs get tags too. A skip is worse there:
>
>   target                 error    after the skip
>   ---------------------  -------  ---------------------------------------=
-
>   bpf_find_subprog()     -ENOENT  jit_subprogs(): func[-2]->bpf_func
>   bpf_iter_task_new()    -EINVAL  no kit->pos =3D NULL. bpf_iter_task_nex=
t()
>                                   derefs what the prog left on its stack
>   bpf_dynptr_from_mem()  -EINVAL  no bpf_dynptr_set_null(). The prog pick=
s
>                                   dst->data for bpf_dynptr_write()
>
> We cannot make them all void.
> Should we teach resolve_btfid to filter out all code in kernel/bpf/verifi=
er.o
> and/or funcs with "bpf_" prefix? and/or funcs that take 'bpf_*' types ?
> btf_*() looks ok to stay as fmodretable.

I think that this makes sense to not list helpers, kfuncs, and
verifier (and jits), they're building blocks for BPF programs
themselves. I've checked that most of external functions called by
verifier (~20 files) are not in the tagged list, five are, but look
legitimate or "harmless" (security_bpf_prog_load,
get_callchain_buffers, copy_from_kernel_nofault,
bpf_set_dentry_xattr_locked, bpf_remove_dentry_xattr_locked).
Blacklisting these removes about 200 hooks. (Blacklisting all
kernel/bpf/* removes around 600 hooks. I wonder, maybe this make sense
to do this, after all?)

(Just in case, I am preparing patch for "fmodret -> functions
returning pointers", so numbers can be a bit different later.)
