Received: from mail-ej2-f10.google.com (mail-ej2-f10.google.com [74.125.228.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D07364044
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 22:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787525615; cv=none; b=bRUAgAId1MQiaAyQbFDqoi2N3MFTMzirqdE9i/yOBSVR/PtMp0aFR3fdRKXaPecGsGKAKzDnC2FIIhrJ8WODWXMd2QTXH5/gNq1wf5JoskX5qK3Jkk+MTrxwqCH82/0E+pNLHu6s6o7lSJJc/fAP13+Mid5CJPw6JfHSZnvw8hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787525615; c=relaxed/simple;
	bh=kSc2iWBq6NNFWCVJsOq0qcpmoH/0G7aeMHl9SbJuoQQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tFCGSFErOqJL0tnKz3qhxIap8wQOu9E+PeYfR2o0tJBUxUN+Ia5QV1mZPZQrIvvNb5rZGzkYtnSEso5NmBwfy7Zkef1kWthyHOKsidBG+PRvWEaVMgjd4SoyMl8/EQS8A50JIbNnPFD0qCFmsiA3gZSG/udNz9g/CNsYyAK7FWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiKOSA36; arc=none smtp.client-ip=74.125.228.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiKOSA36"
Received: by mail-ej2-f10.google.com with SMTP id a640c23a62f3a-c219353e5bbso192570866b.0
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 15:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787525612; x=1788130412; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=shh+4G7Ad2A5MDdLtMta4NRTKb/yZL2mSIcG26UgKdw=;
        b=BiKOSA36uHmTwTIK0QLJqh1jdsaqB1O8oPw4fKuggUp2t1eWQB7+ZmVO3Jf+cLvWuU
         hFAKGdLHvrYMmwQLR905S1xZceCuzO4CxJGFHeOdbLgGSpOd0IW72YhYyT1dyA8qDUOX
         OdaVvvZcnCA505MeQyUvqUq08l33q0b09xak+7NnRs3RDH3uiXyzJsHzDPdVFS2hHK1z
         LpdRXlwjN3IcV1nmVhY436PzneD5f+VS8Fmzr4oR3NUCE04eI8w2YggXKatsrADFT0eA
         OL+dWWN/farVIEFy7nLljIy0yuH2cfRipHKhxcTSOcLuFu1vAOHPh0YgIgMJg71QF/yQ
         p1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787525612; x=1788130412;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=shh+4G7Ad2A5MDdLtMta4NRTKb/yZL2mSIcG26UgKdw=;
        b=Yg22a3I3YnMAxHv3I4530bqNeZB7Ct9XCv7kK67DpX1dKa0Jc/n0U+CWb8dBfcti58
         cgjLj2/Ft4LmGwzMN7eC0ChjZi7O398umRVsHec/NvvAWxv2Ni5QdeTFiXBg+pmNre0Y
         JRQ692oUGE3XKoQLI4zz2AIrT0IMxDoDsp+/hGnBcjdvZj6eYvnHqy9fRHh1Dx3iIrRj
         wMn/YMF7v3GXIpMVCcwXj7ajgwXPAr7zlP1YktybcNG7hhgz3BFTr5L68DrZbNBt74P5
         DwIwBEzf0Yd7fh5G+UlFIZ9pm5Q4twJz32mz/Kpr5DR62SSNqVnCVt5wGvQg9jcVRF73
         5EQg==
X-Forwarded-Encrypted: i=1; AHgh+RpV8vpG18GfWThW7L1/IfmbDBGoOhGxmc6BinhIL7xa6WfOdcqRj52aNwQuI6UbpY525jw=@vger.kernel.org
X-Gm-Message-State: AFuF++k2d1QTtyPJzD4J88zHDLNo8P/hxUeZluAzj4bpqZqPV7Xf5d0e
	wYQ+WXRfGrrHfbxuu5Ex7qmDlpW805Rf/dA3MFUd3UiguO0ovnvrbFUg
X-Gm-Gg: AR+sD11UISW1q37dLQVc/sft+wk0hvZT1wDXGHT6ToSuekN/eyCmfY9j4FEjm2BsHxA
	4C/ZayrG4rxa0Cr7kZbYcY1H7OiBeXXrJEt61C8sYLWy5P/flQZ2XgrLafVENnAVPj4PfW4za/w
	iQ3QMF+JFp1F9NuEdqeYrKU10jUFVeH4EW3kjS3WhY3aC0zT+wX0gGK1WV7NkQBftxJtMBR9jr5
	oajctnF247/7DgeMy/2+9uKDcLrYkPACgzjJVhR3i3+uhxsjD3hR/8fWRzx7uLUQE4vqQzU2Eru
	4bBQKDmx7QZz73ToySCiepYbS8huRmL6o1yel95uKQpl24BHqu36Oq7ZSH8E41m14fOWkgHA9vC
	gROglKaNJHto2io5kQyFjZ2YfH2bP43Dic1cWznlaT5OSL/kpeZAT6/PQ6c55I61y+8G9Vmty1j
	LCQK+oA2/s8tW/Q7a5+vZc6qWyTK7XZmCyiX284lNjEQ21eltIjjotwiQdP3mR74VfJfRoEc+kG
	Mw15rdEp3JDBfy5uXCAzy2xq5oAYpsQWwh6TvvDo4VG0YY92opr5bHx+GsROcCyHZmCTBUiT1Pr
	PZCQX6bW5ogRLf82HaZBxu+cS1o=
X-Received: by 2002:a05:6402:24a1:b0:69c:76c6:9bef with SMTP id 4fb4d7f45d1cf-6a582b6278emr15539422a12.10.1787525611877;
        Sun, 23 Aug 2026 15:53:31 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e19a05bsm7223288a12.17.2026.08.23.15.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 15:53:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 00:53:30 +0200
Message-Id: <DKWOY12R4ZJJ.A8KDS1DU1PHS@gmail.com>
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v7 0/9] bpf: add support for KASAN checks in
 JITed programs
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Jiri Olsa" <jolsa@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Shuah Khan" <shuah@kernel.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Andrey Konovalov" <andreyknvl@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Yafang Shao" <laoar.shao@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260822-kasan-v7-0-99afee6ef7fd@bootlin.com>
In-Reply-To: <20260822-kasan-v7-0-99afee6ef7fd@bootlin.com>

On Sat Aug 22, 2026 at 12:39 AM CEST, Alexis Lothor=C3=A9 (eBPF Foundation)=
 wrote:
> Hello,
> this is v7 of the series aiming to bring basic support for KASAN checks
> to BPF JITed programs. This new revision just makes the series rebased
> on top of current bpf-next_base.
>
> Please note that with the recent kernel splat detector introduced in
> kernel-patches/vmtest through commit 8109e5928cd0 ("ci: own the kernel
> splat matching (#509)"), CI runs on this series will fail with the
> following error.
>
>    Error: kernel splat detected: [  100.689549] BUG: KASAN: \
>    slab-use-after-free in \
>    bpf_prog_eba69524d1d949b1_st_not_on_stack+0x12f/0x17a \
>
> which is pretty normal, as the new selftests introduced by this series
> are expected to trigger KASAN splats (the test_progs part will pass,
> only the kernel_splats part will trigger errors). The right fix may be
> to just put a list of regex matching all the kasan subtests progs in the
> relevant SPLAT_ALLOWLIST file; something like:
>
> BUG: KASAN: slab-(out-of-bounds|use-after-free) in bpf_prog_([a-f0-9]){16=
}_(st|ld)(x)?(_not)?_on_stack\+
> BUG: KASAN: slab-(out-of-bounds|use-after-free) in bpf_prog_([a-f0-9]){16=
}_simple_atomic(_fetch)?(_not)_on_stack\+
> BUG: KASAN: slab-(out-of-bounds|use-after-free) in bpf_prog_([a-f0-9]){16=
}_ldx_patched(_not)?_on_stack\+
> BUG: KASAN: slab-(out-of-bounds|use-after-free) in bpf_prog_([a-f0-9]){16=
}_verifier_paths_stack_and_non_stack\+
> BUG: KASAN: slab-(out-of-bounds|use-after-free) in bpf_prog_([a-f0-9]){16=
}_ldx_oob\+
> BUG: KASAN: slab-(out-of-bounds|use-after-free) in bpf_prog_([a-f0-9]){16=
}_st_blinded\+
> BUG: KASAN: slab-(out-of-bounds|use-after-free) in bpf_prog_([a-f0-9]){16=
}_(load_acquire|store_release)(_not)?_on_stack\+
>
> I can take care of opening the relevant PR in kernel-patches/vmtest with
> this if it ends up being the correct solution, but it will make sense to
> do so only once the selftests list is validated (but before merging the
> series).

We need to resolve this before landing the set. To me it looks inevitable, =
esp.
if we exercise the support and produce such warnings. That said I'll let Ih=
or
respond and provide guidance for this. We should probably land the vmtest P=
R
before v8 is posted, so that v8 can go through CI and be processed without
failures.

> [...]
