Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC5A51E42F
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699365; cv=none; b=RyMbXhhq0Nf94TOb7o4DQ2vu3DDkmfwm/j3tXq/i+U9VzdneQ9EoleCu0i2pOhmHy04V7vHEMXYyImBbooBU750gAjGQfUPgKUmkyLyyloqaRck+HOBx3wxqpMKL7PcS2IqQfBAnAArpBXNgZUzlNdFmbbO7i1uQnjvZv+eYlho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699365; c=relaxed/simple;
	bh=NfII3LN3Gw72EP3w7593Da/fsSb/7y6Qp41qe4y8lCI=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=vElgOJpMkZLkORuFCuPSes4PhOiZMIf92v5xlDawfMstix054WmHKQ3LSE32EIvQlVqFE2bPB1frdMOuiJOKBhGgQ8u39KkCeEMm2af4+hTg7CjWxp0TjVzuYQDn9L7xWW9M1t3kIon3awKJEMNIpevcT6hot2sxt2sTqjuN/ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRT8M9Ek; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRT8M9Ek"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7c9c2df74so217474a12.0
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 09:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790699364; x=1791304164; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NfII3LN3Gw72EP3w7593Da/fsSb/7y6Qp41qe4y8lCI=;
        b=bRT8M9EkklfBRftJTRny/k/9gFEGp2zhCJQIdqbRYMDPeCw37Vfn7/3JSV2rrs0EXQ
         imBqBiEkYPGlGeqt4ZtHma52a+8Wz1KYKq48hsgArkxuTMk9z4cXPvL1C713vwGDy/60
         zaAO7nYWgziU4RRAtbvfl9ddwwhTzWh7nLC8mfN+C6GVWa/cMbxgYA3B8bGlULofO+7s
         EA2nptm5SODA5WtiPm1OKe8aN8VXP4KzI0HeMngRezuOgOF1fKN5mmUwUHLZ163IH0Nf
         FI8r0USmdD30SoO4RCUlgDaFIBfN/mLht9w93jAEffddnzqL7n8tMn/io6GvtqpegrlL
         xjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699364; x=1791304164;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NfII3LN3Gw72EP3w7593Da/fsSb/7y6Qp41qe4y8lCI=;
        b=eEoHHd1GQirDC4Thif/8ZDWj5hXTyXfZKniPeH+2QET5tbt8HW1oD1AauSm2KlM8oc
         5qcs0LN0lFD3xCy/0GBQgA1rP2isSqfisyVJmGLzBFkwQRPKPYqGObqaXBj5aKdm0svX
         WfOXcQ0yhxYiHvT7P6oPxYvejKaOXkJF5FDGBqM5yUh/w0mxoj8ZWOfYV+4CS13hEOPY
         PRAKFK++kmCbQRgN+nDdbzvkkS2TRWstOH/1WFIUKpt1fuiZvxsVHJ0PdTGYJasxzRsP
         qAHhVATWQE0BSZZabiEj47YH5FoZN2+Kw6LzBxkTpMdpjAeYM2nVPbLsfbemY/fY6sA/
         eX7g==
X-Forwarded-Encrypted: i=1; AKwUvBzoxCSSvTF2Eq3JxULKOxHH0aqG3PHtHPLywDaIzmy+Zg3IO2OOYAMaNKSBp+XNqQ4HXR0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbBnp2BENaBnyA/ZbK4YnrFnmREr2rONzqF5GFaz457tLjd8rM
	vF7MG61OBGsl8txSG9MbM9O+CqolV9vhsvzxXe+T0rv6Bmdoj4bConZ9
X-Gm-Gg: AYBFou1CU8n+kbqCO6CPoYTtzYd+RGU2OQ/XZ/Y8KwNH7WM1I5qBq3DdgoG5cKmGGEl
	I1MVOA8gn39VHw848SRDQonkQaN66k47DY5LfQ+/OWYNyop33WXmqczAtwGlv4U4utkFDVCk0iN
	IidNRnOqQ9uitWOWTf4QR1eZaXInofCqdXNrKklxwNU2YzsWgq+4QVqfbMzoI2biSbxWpWX6gIY
	XyZ5cWKN5TkY9tVqwoF/VUA27fVgPIczM3NUFrZhL/jOwkmgAMZ5PyE+/IyYfq9RY85Zzz4O01N
	sVq3PkxN/ydB5GQ+/Neo/m9pjPR6IdMx55LBMBY/z3ryA6e899k+Ytf3vnINAbZiFKhgwfq9UwQ
	X3vKCt20knPkc0zPfVkvHD+V8tfvLPB3+LHfgAbWCYzuLAVmA3/GdzMUrzULUqpMyxAi1TE6UUE
	xiKA6Rvk1xp9qCJ+5TAtOeAvjPFMbmuau99o5xSkpqBYdO7J6pq61Zv+4gdzI35ca1OL2wzmYqj
	dIPEEGSdBjQvNps/+RGiQrrmvFc8T9dzjpxhQZjRlBYO9uSAXDL3VPU0e8Ls56/CaX8aU9RV6Us
	Lsg=
X-Received: by 2002:a17:90b:1a8b:b0:39e:3d38:7ef1 with SMTP id 98e67ed59e1d1-3a49c11ae64mr1853108a91.10.1790699363711;
        Tue, 29 Sep 2026 09:29:23 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a497e90180sm7148752a91.2.2026.09.29.09.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 09:29:22 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 16:29:22 +0000
Message-Id: <DLRXY2AQRPYP.1YQ75SL3XHQHN@gmail.com>
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: Use /tmp for temporary file
 in d_path
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
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
In-Reply-To: <20260929083924.1851840-4-pulehui@huaweicloud.com>
References: <20260929083924.1851840-1-pulehui@huaweicloud.com> <20260929083924.1851840-4-pulehui@huaweicloud.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Sep 29, 2026 at 08:39 AM Pu Lehui <pulehui@huaweicloud.com> wrote:
> The failure occurs because the rootfs created by libbpf/ci [0] does not
> mount /dev/shm, causing temporary file creation under /dev/shm to fail.
>
> Let's switch to using /tmp instead to fix this issue.

This will break BPF CI.
The test was using /tmp up to v4 and was moved to /dev/shm in v5,
since /tmp is on 9p in BPF CI and 9p doesn't support fallocate. See
https://lore.kernel.org/all/20251206141210.3148-1-electronlsr@gmail.com/
vmtest's init mounts tmpfs at /dev/shm, /run and /mnt, but not at /tmp.
So fallocate() will return EOPNOTSUPP and d_path/check_mem_access
will fail on x86, arm64 and s390.

Mount tmpfs at /dev/shm in mkrootfs_tweak.sh like you did for /tmp in [1]
and drop this patch.

pw-bot: cr
