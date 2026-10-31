Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466188;
	b=LoepdOumBJVeX65d1PbHy+kM1Bs4ELnO5MxUX5LRrZiinH/YPEidtMTVbOY52j8Kxscs
	 gHb2uY2HHJa29SPD1WtbT2GPZ20V4cbYkIM7YcOdWh6W28sqGBAHI0hKFcM0NtAQNpj4+
	 JUHZSnqf+u1KM+bf/z4jG9eDrLJjFaP+X5R5qv+6sjbxyVNV6OjpWAdWs6fYuDUaM5pQP
	 hx9VduDYjLrYvH45j/B3s+RrosmWCpVAms7+lSS72+t/hiz69Zjqn+F8d/znO4lN7bEn5
	 zTlU6N1g1O6R4T1cSrWDYMkdlYx4f4IRB4nzjEP3JNhNDMvuCoi9vmvUEo1qnHkrf9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=gba0XFZ/wiG7mOW6sD/3lIcnTLkNzkhvuJnY/kVtgnw=;
	b=l9l153FhlGBPvgjNdpbmw3kJzgS6WP1efR9t6Deuvrc7b41rPq6Pd5RlICNAaEr327XX
	 KENZvqIklWbEV2aUwWkV+RKq+gH8NpeD2nQ7vjE1/N3p4mna8rlhti56A8PhX0oHspldm
	 vYHc+9zQSiYxcuRVrMbhQdQF+KRTjCS2vDAJrIP+LLZP4RVUCQymwUIapZyxcVwMgQXmp
	 npxilNgQ015JESagtKfd6j3PYShbpkpareAARgD/gUjntaOfhD06JuxY2nruUg6dmWkpM
	 ETD0fw+Fkd3taA/6fmmcEpq1WGhuoh9vSqpJopishDx73wkjUC+p/DaI2NYFio6+2CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i8E3v5cp;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A678A606A31D
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 17:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A678A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i8E3v5cp
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a070755c8cso777952b3a.0
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 10:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793466187; x=1794070987; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gba0XFZ/wiG7mOW6sD/3lIcnTLkNzkhvuJnY/kVtgnw=;
        b=i8E3v5cpMSfAi1mqqro21Q/8Raqh769HEWZJL46CwnM2v9wK2OLVzJsAuCSE9qf3zq
         tQY50fNwQDpf+SJSRQlAgqkCXH0WUUKhP57b7/iP77Uf3WNogA/laZGasAKdFWEz783R
         toarBNdQRNtB75h9qwyX3N4XLDJa/7DPVsqKt+7a6In8nxnIlpSFdU2WiAXEmjKaF5ks
         XnZGp+AauqkTqlVVZmUVXtl4Ag0HgI6GlxH75NYUPYnvp305gsOHdLStmb2NDkg/ihGG
         sRkldpqZ/xsViTVAvbYKqxtnovFp7bSCwKkO/qhbTEhCAOOAoI1dYAM/lSLdEuekL6SG
         SZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793466187; x=1794070987;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gba0XFZ/wiG7mOW6sD/3lIcnTLkNzkhvuJnY/kVtgnw=;
        b=sWbBeKBwT5OjywuNd2OWuY6jvGLRCFXRDtoMVq6xHIUh2VmuvsVijwQssQM30H07KK
         OHak2M6MGyG2wfsKQexOJkV4Dz4a8m1r+ytHD6qZ6oZQZiTV6xnUBwX2AchOWPKLO/JE
         MfTcv48UT1WGWARG0vlvYT1L9SGE43rdmLWHhCVc5aoq6ndH6s2UR18HQ5Cusu2ErKTI
         23v7renSmqfGWJ9kye1vLw1PUCqA33ex1UiM6UkBqVuvS3eb6W8TU4CuO81/ZbPEx2Is
         hqE7PtXa4u4JH4kM+ePIf5Jh+4oXvfsLdy4444sgi8izVrpbebbHMxwIPlcCVulGnyD3
         kAKA==
X-Forwarded-Encrypted: i=1; AKwUvBzLHDpUWR2kRUab1opcnCMT4RhGGexFkUtwxaM3ZhBHLCUtxkTsZbKpNKcmJzAf92Db5qY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8vzwxpC7dRcm8cU2MZEGFvbgDij3HOapZWwDAceprH1jSio/1
	U10NF/C6gLDdqvzierT2DXskQHKMpqXl176CUhnoOrICXBFd1edP3j7b
X-Gm-Gg: AYBFou1ittADMV3ttW9Y77TP+Zqaom+VsxuoNkgj/HnPB+TUzdZhd2eHAOUVkwcWWja
	7A2immkn8HbDrg2T5QjNt9gDTgFt3KaJ2f1xavirtVJRHHWthhTUUXJu28AhIYOAWht/VtNWhyx
	6J0dFdTs05jbdI2IszxzgVMsLXcknzyy86jUNg/b2+NU/yEW59ckHJb7u+pLrroUD7qzYzIoDW4
	YTUmRqhYSA7xFTfep1vscQAKGY9KbEHQt4Xag9FvtanMHJuddkm90gj6lKfWvpy2oAVg70PWMhY
	ePp1yyvaq9z/jI/J6rtqZxneiXC4Ba9r0mCXhjCX6p7lr8gZO31b9zRuKUkaCzJ1S5iPqYwJN55
	PGjbZG/IS9+lNFWXGtoY9j3yH+pXUYdDT7VVcf00J6X2i7J7IC5UZ+N8BTLW1BzWbzEuihor5al
	MlJJBh/s46zXfJsmnk4ioRqpCY48d1tqOqiMZwdbzlPktsZATDQjSEXAT08VzQMr0VDbUI6VmKO
	AG2qgoxfE9bsHQGQeyTbcdZhv6FN7+ZhEgf6nRTMaeZ6Ocnmih24zVEa9opdX9/8XHR3uzcWdaF
	qyrDp8uuHyxOxQG8rdQvhSRdjMj4YwO9tFWxZt9LgFhUahn+BT+Sjqwu58Y3iT6hXMudRJSJe0l
	UKink20+DfVyronjQ9o84xKb2yYnWQic7rEg5qc7w+08XK7n0nXdphek=
X-Received: by 2002:a05:6a21:b91:b0:3e8:e974:e45a with SMTP id adf61e73a8af0-3e928e26581mr4547143637.63.1793466186813;
        Sat, 31 Oct 2026 10:03:06 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aadad94a8esm817264b3a.55.2026.10.31.10.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 10:03:05 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 17:03:04 +0000
Message-Id: <DMJ6PAVGV9ND.29T5161F064JL@gmail.com>
Cc: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alan Maguire"
 <almagui@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>,
 <linux-kbuild@vger.kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
 <linux-arch@vger.kernel.org>, <x86@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Hazem Mohamed
 Abuelfotoh" <abuehaze@amazon.com>, "Bjoern Doebel" <doebel@amazon.de>,
 "Martin Pohlack" <mpohlack@amazon.de>, <jay.wang.upstream@gmail.com>
Subject: Re: [PATCH bpf-next 03/13] bpf: check CAP_SYS_ADMIN before looking
 up bpffs delegation names
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jay Wang" <wanjay@amazon.com>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
In-Reply-To: <20261031130959.23472-4-wanjay@amazon.com>
References: <20261031130959.23472-1-wanjay@amazon.com> <20261031130959.23472-4-wanjay@amazon.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, Oct 31, 2026 at 06:09 AM Jay Wang <wanjay@amazon.com> wrote:
> That is free today because the vmlinux BTF is parsed at boot.  Once it
> is parsed on first use (CONFIG_DEBUG_INFO_BTF_LAZY, later in this
> series), it would let any user make the kernel parse it and keep it
> parsed until reboot, which is what the option is meant to avoid on
> systems that do not use BTF.

Any user can do that without this mount.
/sys/kernel/btf/vmlinux is 0444. With patch 9 one read() decompresses
5.5 MB into vmalloc_user() memory that is never freed.
The parse is the other 2 MB.
After the first use the kernel has what every BTF=y kernel has today.
There is nothing to guard.

> Check the capability first.  An unprivileged caller could only ever set
> an empty mask; such a no-op delegate option, and a malformed value,
> now fail with EPERM as well instead of being accepted or failing with
> EINVAL.  Privileged callers are not affected.

That changes what user space sees, with or without the option.
Drop this patch.
