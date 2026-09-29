Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB82851DDFC
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699348; cv=none; b=e720kcD+yJ9Ck4OyYk+dMJgpXxSJi1D5HmwpvjnPUzZr86SytQ4hVyCDbA22pSijLkguOlm/LuvsW4+EBTxSvs68L4xfbi03vq7kB3C1wz1etW7yQkNICLdHDOowmwo/Se4SNl+722rXvy/5bC7WaFxvLNXjVLvrZvLnhXvVsKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699348; c=relaxed/simple;
	bh=gczGrvEptEHhycke4/gymHjEMbqsLy4UXX26l0bR3OM=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=VPDfWIaZaHf+ATk/cXtl0TEd+YMs9D3m2OC+2Sti+HGGUSPb79rON6k5AMJgvzhMfH6bA1RRqMEOvpKLcEYLMQ+ZK0cbHT4PJEGwQxZjAcpm/rjVhfK0wAeig4QU8eY8YLUpTXMJpyNImUPVFaoJV4Dr7r2giehBNjtorAMrUM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgRxOj1b; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgRxOj1b"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb751so2118821a91.2
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 09:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790699346; x=1791304146; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gczGrvEptEHhycke4/gymHjEMbqsLy4UXX26l0bR3OM=;
        b=AgRxOj1beqZDDRcpCeFm4YCvRZ/D0EyNXpFlbqUQpCcwaEIxnQqD1SwbMJmrwLkoIK
         ascxJrwbKxqb30rhCgn9dj8nIVrqBMQ01+rIe1mp60NvUfll79VEgmvxVAVV3ZXYVd54
         4ZXuKJWBB1DF5DRNnRN9VrqU2CVk+KC5s0y3TkDXc9M48LvFKYCWdScHl9ttjmNY2Whr
         G/dWFh8S8Ia/ln9VhfkBPY8/Uj5NslXeAywlHj49tiKeFKU1f1fLdrlFLMS9zXtXrmFh
         apWsEnAbOdar4pw8DngGJ74Z10V0D68m/WQ4ecy3ByxrnD2ViPwQWLoJNyam0qTBG8Z1
         aFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699346; x=1791304146;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gczGrvEptEHhycke4/gymHjEMbqsLy4UXX26l0bR3OM=;
        b=FbzXmoeXlF4r1bd35VGOCbLXgtpHFxdAxopZsJkxCGXEO0byPPOL4+EpTMQCiTtRPM
         TOoODUABMDXpiVhyft7tWQ7wRaeUcAmDyYlLZbO2oq4Nv8Ujo4S5tv3AicMRjM5/jK3c
         3uAiJfn4JIfLfp27dUjHxYmrly1SJwbQEddWrDUUkCFQpJ4KtpTIIMWPbpweeX4Sg5/X
         loUwtVJOe78Wiy3oILKa8lXmybJCkOk3hfTc60o1HvLNMKEm7tvfFVjzW/0yTPv9ZIYA
         4yHlGU50PZOmMwI8XFrnUwHLc6zrF4GKq/CFNd2RZdjfzHJaaYRPFIrcG5H9TMPBRfBB
         pqdg==
X-Forwarded-Encrypted: i=1; AKwUvByvGo+5S/ZnBn9dMJ+puQmGQ0q0rqVjzEpxSrRiQ9i16Y/7D42/SeSxLJT27NKsv8lYV/I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWjIj575hymiUEO3LF4aSxyDd6Klqr3BxMwpYE/MqdAWqcjM51
	M8wqi/S3qYyG1KdZ6MZ5NJHpsIvPAQS4lQtsGwOvqO1G6m0QiNqEukVH
X-Gm-Gg: AYBFou2VmPWx9i1B9bn4tr0VVsG+uYeROqP+IJ74rrN5WuFfZ3IY6VxkrPXCF5Og8e8
	/U1Hwfeb7Bl+2W7heX3Ch2mvIDCoZ20i7VZqL8MKhRQGxbb0DqTZmZve+9qjhX4ltJbhpFQx9ty
	2qIb/HvCzWrZCJfFxC4kwgWxAshG6zVaE4BcXJwgjiKt9N35xy2ej1jdPsZseuauQO7pwl6k8gv
	DELkARjBZ4xgeltyWLPu796Me8F3RQwy+eqEt3ZCzNJ07w8HXAyr3xp3dCmLU0lf7kK4hrBJ01X
	7G5+Ob/bMEDMRraMnLTji0Wfz62hxrUbQ9k72YHHyHSI8zwTNgZ9FFYgt1TNBbn5+n95zm4OMW7
	AxTmxzNZ/3+r1Zn9nrDcpCtZEQWHVnz+CoO9c6zxo63ND3f57AcPGbVmIEvSAlhKH//lHs0gd3P
	I6SAlH0fdP3/5gEBtrhTnPo0i3/2REjpt9FBGXookqF/LjQ0Zk9l+dWvB/Ki6YVBW5n15fb6WEe
	H2lln7nduJj24kWAhzI6U8U2SyFuUTUdvd6VZkY3QlaX9avu+nrJskvZcKGm9Kbb3LtTuBdoAD5
	waY/
X-Received: by 2002:a17:90b:582c:b0:3a2:b70b:9cd4 with SMTP id 98e67ed59e1d1-3a2b70bb0a5mr3996708a91.12.1790699345913;
        Tue, 29 Sep 2026 09:29:05 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a49803d745sm6413747a91.11.2026.09.29.09.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 09:29:05 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 16:29:04 +0000
Message-Id: <DLRXXU68JZ5F.2FG7G4UY1DX7F@gmail.com>
To: "Pu Lehui" <pulehui@huaweicloud.com>, =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?=
 <bjorn@kernel.org>, <bpf@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Puranjay Mohan" <puranjay@kernel.org>, "Paul
 Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Pu Lehui" <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next 2/5] selftests/bpf: Set CONFIG_HZ_100 for
 riscv64
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20260929083924.1851840-3-pulehui@huaweicloud.com>
References: <20260929083924.1851840-1-pulehui@huaweicloud.com> <20260929083924.1851840-3-pulehui@huaweicloud.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Sep 29, 2026 at 08:39 AM Pu Lehui <pulehui@huaweicloud.com> wrote:
> Let's set CONFIG_HZ_100=y in config.riscv64 to align with other archs
> and fix this issue.

x86 has HZ_1000 and config.ppc64el doesn't set HZ at all.
The test fails with HZ=250 on any arch.
Change 30000 to 40000 in progs/setget_sockopt.c instead ?
It converts without loss with HZ=100, 250 and 1000.
