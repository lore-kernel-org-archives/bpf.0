Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794885328;
	b=GpMTOMGXCMgo/ckRg/Z46/XQpeXRdwe3bo8X93reo2d0y5dZB2MML9EBSHlJkWpw51sk
	 5LHapZUV+5ZQUZJN1e/GB9/KGoea0KxEzBeGp7aEy9z7J9aaGAe26Z5rCy/OnBaHclz/h
	 MuoU5Jubk2CnxGWJ1sjtxlkuKFM6f0HCmZo2jEc9iOZ0nnFdi/X83GUhFtNETaPTrOGBF
	 OAyCi3a/gJlkz33fr1mZ1rieQmAxgQj3iRSMU1AmZTLzrqex3nGsoVrPi/Ns1RkeZJvLo
	 svx5RC1HLu3Mpdg57d8KaFzbJTZbnPnoctyzWzjGJ7Wg7royxo3Jer4Y7FPe42eelAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794885328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Kkr2HKfNrXjykOWOiy6eWo0NF9gQ7pUiMwlvAPC66AU=;
	b=P/tRO9E9j6Q+tSguas05FBjPn1x5mvDjF7iByoiC7HP4s0/lHS38jcv7d94OSuCsgMeR
	 2x8FqpWcvFRKOsTNCWDi8j0HKBDYpuqqZfH8vneJCO9eB3fSHmkO7aAhIUkt7BbC5+6CW
	 lc8G6VyNvcT+tfvMR0tNkIY+vIZtuZpfvNA6qH56pB+C1xIGcqt08rCLdoYSzWu1CQmdq
	 eQbfAiy5EfNca4o+8wQHQkM6rMOlobJFNZsEoNTsbs9+Ab0+06czLO9BYfdNlHmbYuRB0
	 Dfxc8kv4iTI+IcNgBdakXTrB9GsXJEwWR/6VHzBbj7LhCUlUxEbgD485Ey6ZLJLdKNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UWuE0zna;
	arc=fail smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D65606A32C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 03:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51D65606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UWuE0zna
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c247f6687dcso739290766b.2
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 19:15:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794885327; cv=none;
        d=google.com; s=arc-20260327;
        b=ZfOIruiUVTQljCuj+BZeKjWWnDNaSmStmXD9yr4Ub/JioMmo6rE6Yib2Ij9yULy5eU
         se15LAdY/0XBMJLxdb53G/qZXCEc4dbmDVyFuTnjBFgWWUWC2n9rz4/OOL6zVE/boK+P
         5etoEV6OkH8071JMyp0G8Weo5dVR64PkYJzsPfS3nwGlWP9dxb0D4yXQCvdj7KOmxanX
         cbrqRxLY4nPLi5pP64i7bNi45sF8yIOBkCd6M1pFs81/zAiVLsPsIx/zfKaCaMmZXOfZ
         iQLnYP+ymuv5SeyNwVuFy3trY5sqgJKSffQsHPbXnLQ9Uuhk8NKysWMB6veWs1i1R0yi
         7Mww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kkr2HKfNrXjykOWOiy6eWo0NF9gQ7pUiMwlvAPC66AU=;
        fh=Tau5eWhXWKqSuFoT75yGwYg6nKybTMFUwR41dJDz3lg=;
        b=UrFfadNY+s1YlzDn6TB5EGeYFL/nuDZporcGKcG5fI5UTnq+5Jc40/Vk5zRKNG/YQd
         9LtxSrUcjdHFE3mMkkMWhF2YAscMsdpkN54h0aws6TchXjWwX+fdBo5jI+Dfc5MPu0ht
         GFF5XNKdj7mVH+HJzwy/EXuc+6/9ZHqPOBvmpRQyJRYJatJ0C0mXMVwM5w8CpPsq3lTr
         z/ZAxwvz6DE1umeE8VNHWaVJ5ji3xs6OZGaESE1l1M8LDEJKEyMM37cH/VBk0/ReGoDv
         vo6dbeUmaoOm8DMjow+9bLAGJR4tKICgpbaa8fZRfcEu48oM17wGC+KG2UH8U6z8JNau
         Lz2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794885327; x=1795490127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kkr2HKfNrXjykOWOiy6eWo0NF9gQ7pUiMwlvAPC66AU=;
        b=UWuE0zna/Kej6vRfmnnkBRPiB7MtRAOmWnZDUwfDZnARnTtWa0lZ918fHjZc6mu5UO
         /2+zJyxEYftdneZsscW0DL8Fvl081Y38tQO4Pv5tUIPYfcIIYe6CjwGLqcKBSst9Gk21
         HyjrRa3A/10hlqRod0LbCztyuvg1+0RmyX0gzRFwGRR3oqb5tPu6tQU03asd4m3tC1Ly
         2jBUNoTFraXXJMf5dSQasvoZ/LajiRGFP3fxeQbTALoTqP2ZEYO+PCEtWNT6HsCG/4y2
         Qq35/dZdjfO2Tkf3aMOsAIjY43RWuC/9l+8ADKlIptRxOOPmsxJVEZSYuAL1Y41KbuEX
         BlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794885327; x=1795490127;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kkr2HKfNrXjykOWOiy6eWo0NF9gQ7pUiMwlvAPC66AU=;
        b=h+9Q+EQDPvNc2nAYJDW/+p3sVptP3be9xvflyCSZ7TArGvyCNcm1rl65ZhTMgQbh7h
         8M6joNf/j4nuVwHo+MdTQ52KMsqmmP72T0bL39rjqGLejdY8HS/IL1ur8KsAVwmIypeO
         U/2GOj6kfoQ30wtod7mZJmwKCIyB5avaFp40jSOntAbM1/bTdKBNFg+MdDYAbGLHQZAe
         LVqyO9KAeVeF+3yXPqAHfE3/ODfO0AqRfkFKCQy735QdgzWqv3MwUmGOHJ53+U1bt6LD
         /Sa9R/EIEjFg5NyTfJQFXkk4dXAJ42QWNmtVhT7MnVMW7F+P3O/BcKu5pe0hTw5B2sy9
         kByw==
X-Forwarded-Encrypted: i=1; AL+hErEpv6N0dJRtKSbfGtPxuIpvJuvoEqUtAVqVd9wUJKDSi9sHiXhgNnngvW8b5rI0nvhIPhI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dnH6p/IcjglVEKw6i6bKjPlyHqIrd+eFuV3I9wz5deEqgqj7+
	mLmm9MmG3FXjuQxqkD4WaAH5V3w0RJlMkAQNx8n6VUn1PnelCYJ+3FZly5RgMhlqktjm+5mV7Wt
	fhgkCjSTV2n/nkgre61amJaUA8jiZazt8i7+haz9N
X-Gm-Gg: AYBFou2XXVBnAJXySjc05Fm8P3q7zLfbVneErCuitLE1q1HMC432JaIGp8Q6K/NLlPW
	KxkChWsxulpX95YGiCCDCzFwfd/GVtJTsYu1kIuUL3GDxTXjGudzgU12s7r7xeRK1lCglGMu/Gv
	V0/gGpEylpbn+yGM/Z9Pvx4VZYidqVbxW3LJcaEFRoBT4LU2WeVPejJ6/Y9rvZ4BwlrhdQXsZg4
	t2pFU0EwdXzYvnF02DlqrtIiHBjC2dyFrIAj1iluabhtj5GvjuEJGAhZ51knJ9AZNYlWGoSZwC0
	/jaOrkgNPopHM2iQFCtxGglPZrAmqW2eBASJT+f4+0P3Na6IpBRgptl5QfmBKluXut9dLqF9RyS
	/5D6fxDVr9nUQOqMA0tTY7v6q/TJlU2IV7BY+BKz2+N1MNyAXYFxAc56KwOC5ftC2/o7BtdA=
X-Received: by 2002:a17:907:60d3:b0:c31:8441:35ff with SMTP id
 a640c23a62f3a-c50968355eemr1101863766b.48.1794885326369; Mon, 16 Nov 2026
 19:15:26 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com> <20261115142431.1587690a@pumpkin>
In-Reply-To: <20261115142431.1587690a@pumpkin>
From: Samuel Wu <wusamuel@google.com>
Date: Mon, 16 Nov 2026 19:15:11 -0800
X-Gm-Features: AclHuK-iBEn00_VVuz6qjGQnwYZ5FRJ6bny3VEMRskBOJf02b9BDmwbxXueDduo
Message-ID: <CAG2KctpP7QH=tdSB=op703rA=CtjQKAXqOen8JEHg1ygy9sgyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/9] kallsyms: Add KALLSYMS_QUERY_BY_NAME and
 KALLSYMS_QUERY_BY_ADDR ioctls
To: David Laight <david.laight.linux@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 6:24=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri, 13 Nov 2026 14:12:45 -0800
> Samuel Wu <wusamuel@google.com> wrote:
>
> > /proc/kallsyms is the primary interface for userspace to query the kern=
el
> > symbol table. However, resolving even a handful of symbols or addresses
> > requires reading and parsing the entire text file, which is often sever=
al
> > megabytes and takes thousands of read() syscalls.
>
> Separate from this, I've wondered about separating out the /proc/kallsyms
> code from the code that actually handles the symbol table itself.
> The two parts are pretty much separate.
> IIRC it uses a static function to get the symbol type (which does most
> of the work of getting the name - which it also wants) so it isn't
> completely trivial.
>
> I'm pretty sure all (well almost all) the changes will be lower down
> the file than my changes and won't cause (hard) conflicts.
>
> I've been compiling kernel/kallsyms.c and kernel_kallsyms_selftests.c
> in userspace for testing both, but had to cut the bottom off kallsyms.c
> to get it to compile with a sane number of definitions.
>
> David

You mean separating the core symbol code (top of file) from the procfs
interface (bottom of file) into two separate files, right? If so,
seems reasonable to me, especially since the file is approaching 1000
lines even before our changes.

And agree, even with both our patches, most functions can remain
static in their new homes.
