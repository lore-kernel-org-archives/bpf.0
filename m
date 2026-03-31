Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAFC242D84
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 00:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774917231; cv=pass; b=HdS3YYawnCiC4c8gOPbw9SgYZpyQOyiyDfL6MyD/m+GIDD3eJdn5bs8ZI93I4bmKnBsBFhvt91PQqWP0lG4a0PoTGvMJdbJXJ4d493njW0TNsj/Y5/Hyo5oyxnmKyLw7OyPy55RkvtR2CM3r4oS3O7Pl/PDu4+Z2q4g2DX7SQ4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774917231; c=relaxed/simple;
	bh=3r7e3r4k+an8dotsHliX2p8tDzzKOHNuJPjrdQ41iok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHdjksVxy2gjrKkVEUEuXWX1tqf5LfuIvaxvDpi7OEvM6UL2oANcpEDVTUm65K7wSdkT96dsqRvC1F32Yxo0CBR0iZ2UDnBk+KJ/pj2qRbcCxwMctQLxaZJ3zHZa16yljTA92sX2rR2BNjOn6vtVUWyTS840M+jpvB2YVsqvUmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgchNN9A; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgchNN9A"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c76b070f109so164869a12.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 17:33:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774917229; cv=none;
        d=google.com; s=arc-20240605;
        b=G+8zAZ5nhtmTdZGOPwhLyqHVQrrxUMV+rPsFjj1P83WV4hCp18FpgRIyM2cGRRcHOs
         FuzVz/Qvtd8DPM+TjSEJHTUNNyqlU8nqvF8kJUJ4X5khcLBv4ruMyf6A6U2XpFjNO2xH
         TsPEWIMZ4txMi2kM2A91a6xzvX+TAutOd3FW0RPJ1IvvZs+qgzrvcEuhu/FWvDizibBn
         EeQ+LT5rtE6jtGKUSi9SRZ67aMVhPj2InfpJLSyIwRUwUM+0+xuPv4ySXE/I+bSugMRF
         PhI3lOdnYwncM4ADs3ZUKszR4axSNdoL0W+eOYk9BJDllA0QehSt/EonlH3tu+6YJGP7
         ebVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HyPuCoaWM4tfJKswp+j232gRvFvxxGCAqiUvJLgWyNQ=;
        fh=POP0ydDNFUne3HyOYVevlhtaIL75qTZjfSeEOeP+aa0=;
        b=gjwfiZ458mGQfgzEqThCbsI98aXmrEKrN6/BbkmkpyzXYyYT2gMwFdN7LSq+JYzSBP
         2Ik/Kzuf0qIpPJ7DlXIleoQrUw2wb8NUUSmsv0PqMgPRdtJqDAye6dNBqMXTEFLEOYSw
         +ZWg81XNRyEKw7ZVMlpYN8Pbv8A2JUzW8gTxPegRLIFgO9roAhA9A4k8ngVmNwuoot2o
         UPC6u+ZZhgpbTQhX3xGsJH6sRofUoVHEBvTBJGxIpcKCyxQAND+LrEYxoWdZOGC1CoKC
         sUMFOYPqReukfO84tRWieSG7/y/jNF8QNw31gf+wAbp+m+lPLiNCJqCND79aoQQdL5TS
         CTsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774917229; x=1775522029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyPuCoaWM4tfJKswp+j232gRvFvxxGCAqiUvJLgWyNQ=;
        b=hgchNN9AksSDgaK4LBGoUUK+p+LM9dkxtuKxX5krt/VMq/7eoleVoUCMn52Qp65/lG
         Tv8ikdQPi44pxfIHeZi1tX0F8YVNA4M1Ba+yetwQaGsa3NKilv3U0tEIzY++Hn61lwrY
         TZCwnIOxD+sNjB/mxWpP3+NMR5Dy9dvvTBSypBibMn+6Z+hYO1T6L1CoQO1mrUoZ2u1Y
         KyXDUOc6Cv26RX/o915nmgf4EuuB6TAYtr9k61pktq/NtN3LG9LWFbJWJgvh1I/+dpT4
         SSkMHNcYV38fyTRCkezFN4vXDsJiytkadaGrTaqpObaLGh0qEYLWslrYG9H+Lkwej7FU
         /oAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774917229; x=1775522029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HyPuCoaWM4tfJKswp+j232gRvFvxxGCAqiUvJLgWyNQ=;
        b=lfgfDqrvQU6Tnp7KodjlFOkQsgG6kjpNKLS6Rqfw/LDj+Go/ltht5WkzO4fyT+53Oa
         88iYoGlp+qxmKmHJ9gkntv+x3YHdYp/zcIfebGQQyCCBUucOBFgy8ja9IltNBMMTEms5
         tPH2CBQ5YE8ewyQE38bzYikb4iIKakfy0ZBHHCnv5Rv6TX/KaGTfTJlPs0eS4rPKuDj4
         3UF6lNZJQ8eigDr5eAZDvDizjVq2gm+m4xTlASVl82WbiUcQO9hHT82VbgDvt0bh3QZD
         f8nNldFtd+PZhT3vfo6miIE7QbAzibSwIm7XFbpzcpFA3P8oSIJs+1u9q0H78qjmjgz5
         sa4Q==
X-Gm-Message-State: AOJu0YzQwEjLdks5jpuXwaBgReGNdrz3Y9x9Y2Hmp5pTN3kcHxyhqt3F
	zwELWw/FKyO4aC3rySECl9maE9AW9u/gIoZlt9Pl+YDKvUL/dBe5auwFE8sbip5s0xLVdfVQAvp
	YFM9K2kSIgb6maE8vcmQYbys4pOwjXkk=
X-Gm-Gg: ATEYQzx2fZ+7r0Q2qGuK1YC5mQ8TBzRXIJ2IymT11vSEDMlrUAyKnmoYNSnYFiugtAQ
	BDWpdNHVTwf8xMW7qwtTRz9Bf6LyVxjpWSZTv/J/o5rWJoMvtCTS4G0o67SEzj61ZtgEDxN9/Qs
	W0ggJLVyH+hArh6i5cJzobyMkZNRahEvei5dun84ABimqf7fyf03QNxtjQriwztqVvIU/vxha6d
	T3c0Yii5zRbwFZNbJHgQtk6wkT3MRF+CYTL8sjZlP57Pa7Ecx3gKv9/kXjoRvsRUxC0FUg6fvkP
	TDr0/snWdp0NbgL0tPDjCQY=
X-Received: by 2002:a05:6a21:33a3:b0:398:e2b9:cce4 with SMTP id
 adf61e73a8af0-39c87b86797mr15708949637.40.1774917229299; Mon, 30 Mar 2026
 17:33:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329124429.689912-1-hoyeon.lee@suse.com> <20260329124429.689912-2-hoyeon.lee@suse.com>
In-Reply-To: <20260329124429.689912-2-hoyeon.lee@suse.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Mar 2026 17:33:37 -0700
X-Gm-Features: AQROBzDYpYxyZo8-lCrMJy65C_XwRIX1WEavlt0Gj1roeUaY2UVT4e9EZxtdDlQ
Message-ID: <CAEf4BzbA=drhPq9tsD1Dj1wt_P0q4LNtuNSM96CWVuAVBrKrvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: allow address-based single kprobe attach
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2026 at 5:44=E2=80=AFAM Hoyeon Lee <hoyeon.lee@suse.com> wr=
ote:
>
> bpf_program__attach_kprobe_opts() currently attaches a single kprobe only
> by func_name, with an optional offset. This covers only the symbol-

have you tried passing NULL for func_name and specifying absolute
address in opts.offset? Looking at the code I don't see why that won't
work, we don't enforce func_name to be non-NULL

This NULL will turn into config1 =3D 0, and offset will be config 2,
which I think is what you want to attach by address, according to
perf_event_open documentation

               union {
                   __u64 bp_addr;          /* breakpoint address */
                   __u64 kprobe_func;      /* for perf_kprobe */
                   __u64 uprobe_path;      /* for perf_uprobe */
                   __u64 config1;          /* extension of config */
               };

               union {
                   __u64 bp_len;           /* breakpoint size */
                   __u64 kprobe_addr;      /* with kprobe_func =3D=3D NULL =
*/
                   __u64 probe_offset;     /* for perf_[k,u]probe */
                   __u64 config2;          /* extension of config1 */
               };

This is the same approach as with uprobes, btw.


> based form, not the raw-address form that the kernel already supports
> for both kprobe PMU events and legacy tracefs/debugfs kprobes. Callers
> that already have a target IP still have to drop down to
> perf_event_open() or direct tracefs writes.
>
> libbpf already exposes address-based attach for kprobe_multi through
> bpf_kprobe_multi_opts.addrs. This commit adds bpf_kprobe_opts.addr so
> that single kprobes can be attached either by func_name + offset or by
> raw address.
>
> Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> ---
>  tools/lib/bpf/libbpf.c | 88 +++++++++++++++++++++++++++++-------------
>  tools/lib/bpf/libbpf.h |  5 ++-
>  2 files changed, 65 insertions(+), 28 deletions(-)
>

[...]
