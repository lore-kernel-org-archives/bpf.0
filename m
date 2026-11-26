Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795713687;
	b=G7pqAbXfFgNjuur5raeHQbr/w39CQr45yQFxgB8Q3Zb7UEGRQGHiX3Sw5OHzmIMXuMss
	 1RoID0hGZtOYBeUheDtMBVo+p1brghEpW17MIiXmXR1vNGprtpxHhpfIAltLjX8wYSmhP
	 K9rLm2nWlRphxM56GLIgozmn7Ho7dcONLHmTrOZfBYzpWieVt2NJ4US9zpDf3Lf2Dw+QP
	 7BPgRKG0rSdKRwnlcxjaT9OpQhj9sWHyqAmjWlZBnZX8xeoK+5KO5vrO2mgy0zP4tGkdY
	 eHqzR2hXZaRvJObKYeDEQGnyRT4JQ0HZMEAl/YSh9cVCobLRkFSCZK776rPsHbh6iMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713687;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hFMU0WQIu/Khu5nkOekEsJ9G7/wupBV+7k9T9skPX/c=;
	b=DQDCo+ploRGDyu9fysVXco5Cv3kgBVluA6QZXK/MmJU+ML2DW3vi7XBUjfTcHIcyjHQv
	 0elTpexMq6eS7Xs3ipmSxZ1t2IfSxYzsUwGBrW+yTyO3WtuiWrrYG2iQdtqV4GdmlfwaG
	 klW/9h3ZPzuN1Lem7j/do1/gF51I9Z0Xhr48w7vse7jrACJzA9T3pNnhaGCVd9chifYrO
	 EaOmC00Zg7TpScN5kEre0x/rrTWPyp5Wj/k6CG4dtRkQSUPkil+aDnHFUF/yPw1p8Khzm
	 eEu0U7ojNyAK2W4ruTcisrKvLN4XkEznP0FJn5jb1BzLQRRE/MzOJcJeDX4JqDQZ4eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eAUyELCh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F6606A326
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 17:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 944F6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eAUyELCh
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c51d158acc6so39478266b.0
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 09:21:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795713686; cv=none;
        d=google.com; s=arc-20260327;
        b=YLRGSpM5bQVhkc7RmvGCU6vAQW0HWQKNzEw2Lm0kPft9Dk7DUVqNSjqo7ptt2j/3Ym
         7ONLXfygsALXM1sqT7ghwPYC8IwrT32oIrgfHsFw0qdUmBU6Cup7CO9aFShuh+dtCFlb
         4wiS57mIP2XUNXmz6cLifaC3WTEUF49SCzFSbqsFZEh580aqGy/knv84Jpk6BdMuqSBt
         gL760jRGo/9Yxyj717YIWlmuD9Y8i0Dy/JpydehDA45/FvTZ8JUuP071Ts46YJwZjiTE
         174VAva4g1apnK8cnJUM13PreXjkhsyOZBEum0B7i09fko0jzIwWlgN/VjBb2eahLiTg
         Tl1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hFMU0WQIu/Khu5nkOekEsJ9G7/wupBV+7k9T9skPX/c=;
        fh=VWaco7ns76YsloQFB4m7kmrlK0ei+V+uUaqvB+y/iOw=;
        b=aWktFkAl3gldGu08Dso5h7nOIyjLj5xN/T2JXob7JRjUDxTwlyELSP+16Or0l/nLzi
         gTH+u4TIy/n0PFK1MMz+1YXcwkBxWRhqlYotRpKpgzw1EMiODOguRq6dcj6SkWzU80qQ
         WBJuIsFB9fvWSTCPxh3haHzWFrVQCPHM8fWdgCW99pqcy5qd/umglDGsA5ztbSS5osMR
         jmpPmD4HAachsNmZkSR4nv8O0sz7p+32Ac8bwy4zLqc28gQuE1qv3b7+DsSz6tsCOsLS
         qZin2EznV7duA+Fl4Y99M42Klo5s86gStAv2ahWgSpmaEAzsQ4JowiWSanYh8J8oORn+
         ik5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795713686; x=1796318486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hFMU0WQIu/Khu5nkOekEsJ9G7/wupBV+7k9T9skPX/c=;
        b=eAUyELChNxN03tFWhGSn40N0o3gjWO71tl5Ghcmskz8b4PGVkssqVMVbtcP1ufdgYD
         siuET0E8+b/8ouzgAVqs2MIlCaW9vlronDx+CN5r4hENRnHoThYegScR0BXwbEXaFWVv
         vbCqNQk7tkQOJoCj6JvZkgF6A2MrU7JYcLhNOXZ1Xe1EpXiHSTAa8An0988zX+AY8Pep
         2FxXxxd9Yyf1K1seELTv3Pu/d0l8SVkab2alnZfc1y6/i2PE4nJZz1OmTUDwKwoKvPhp
         1ls0QPxv3w/sWpsW686NeXrfa9MjQEe1y8xx6d3P6ciusGwK3AyEX4jEpfF4Bn9DZiMX
         a+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795713686; x=1796318486;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hFMU0WQIu/Khu5nkOekEsJ9G7/wupBV+7k9T9skPX/c=;
        b=xE3rUgLzOODly1Fafk8SaIpbowsJWe3TIFPDDhjYM3M8hOWRWzpuuOexi224kqA6xr
         Hy/M5qike1mvcf1tYsfTfbXNY0f4Wu31cSa6b8j0rHMF5rj+MG0rJ5tGwpw0Hi9vTtnz
         3XLCUXcW9r47h8bNWHkbgCDophMxgiC3XyDZTc49aB/7ZW7N+BxHOlfToPWnH2i84rCB
         mSpqA8DHgCEk6TEdMxrjKEypry4nRzU6Q/xrPU9p2wXhc9XrsX+PP7LkBgxss2nZQ2uw
         3Crs2SyjO3TPJNajaHyJLeNOJk2uKMGNhb3jXpCl7Agr/YyNRXVby48OP6aZkFYcOjgJ
         oFYQ==
X-Forwarded-Encrypted: i=1; AL+hErF0gdB49dpRkqB31NZhuNlSdLiB06dgDK9hMN8k/wbsnjsT8wkyojUXA3rCiX3kiSTUuBQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8C46ooWdFY8jclOjrsad0+VN6upylLmKQgv3OYGhn2Zt/nJcw3
	jcX5L0j9BMLzGU727/oTUZTQvPqWy+8KHhhdDsVprT1ttb82N8JML0m5ZW71r8iV0WmHSOGRFsE
	WRlXPbZAE3lY83fiHSoFU8GNmRDcEoKoiKlpzh5ab
X-Gm-Gg: AZFdTZdx4RbTwZwDS9UCCJmCP9xKcCwJvHbd03ZwD6be9kCvZjLRsj0+sQuZyg1LIv/
	R6az274rmRieTvyry0rJvcJTnReaaR97Q6H77g8Jnybi+EP+v1sbLjoKNhMyW3bdeAuXJTWm0lQ
	GN5VkA1vBlzg7rGQvs5AfqtwLhG9hCNkY50QwGmjmXHqYvx75CLH7/DU+nv23/QYc4J6VkSOEtW
	zLBwDevc2p4xElXSnvp1zv9Mmj2JBuRxXSSZ5WWdwiPaqUVhuIpUO8bs0tjNsEA47TY+M73bQuW
	524zb2SGFufhPPjsXwG1b/e6gF1oBLFVO+BngWyR0s+GnCJcGr3OzRxzy6udXEInwjI6tLryb74
	lRGzKSaqXePUa1qtUgb6FYURLk9QSzEg+HFHWajQMDd4OvDCLyXoOPkVrGb/jM+/0mtxpRA==
X-Received: by 2002:a17:907:9612:b0:c2e:2baa:a642 with SMTP id
 a640c23a62f3a-c513a8845femr1932673766b.30.1795713685324; Thu, 26 Nov 2026
 09:21:25 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
 <20261113221248.3535369-14-wusamuel@google.com> <a40ad738-cb7b-469e-b67b-353b64622dbd@suse.com>
In-Reply-To: <a40ad738-cb7b-469e-b67b-353b64622dbd@suse.com>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 26 Nov 2026 09:21:13 -0800
X-Gm-Features: Aa3M54rqUPDLnBBM9ls6-9-k9q7s0wsA5-hr6KgHVGGraAEFEEYG4syBhxuXwjw
Message-ID: <CAG2Kctq7Mb=pb-SFU88eRA1cp2Qt_HJ0nADY5fET7Es-_CcCOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/9] kallsyms: Add KALLSYMS_QUERY_BY_NAME
 ioctl to /proc/kallsyms
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 2:45=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 11/13/26 11:12 PM, Samuel Wu wrote:
> > To find a few kernel symbols, users such as libbpf parse all of
> > /proc/kallsyms, which is several MB and text based.
> >
> > Add the KALLSYMS_QUERY_BY_NAME ioctl. It finds a symbol by exact name o=
r
> > by prefix in the entries of /proc/kallsyms, with vmlinux matches first,
> > and optionally in a single module with module_filter, or all modules by
> > default. Each call returns one match and its position; pos + 1 continue=
s
> > the search, until -ENOENT. The output returns the address, the size, an=
d
> > optional name and module buffers. A buffer that is too small gives
> > -ENAMETOOLONG and the required size.
>
> The kallsyms data in the kernel can change between two
> KALLSYMS_QUERY_BY_NAME calls, for instance, when a new module is loaded.
> Should the mechanism provide a way to detect such changes, likely by
> tracking and exposing some kind of generation number, or is it
> unnecessary?
>
> --
> Thanks,
> Petr

I'd like to keep scope of this series simpler, and I feel it's
unnecessary for now because:
- today's multiple read() of /proc/kallsyms have the same race
- vmlinux symbols are immutable (I imagine most queries come here)
- ioctl is size versioned, so a generation number can be added in
future as needed

I've documented the non-atomic behavior in the UAPI comments, so users
should know what to expect.

Thanks!
Sam
