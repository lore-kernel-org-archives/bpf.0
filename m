Received: from mail-ed2-f8.google.com (mail-ed2-f8.google.com [74.125.228.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B352222D0
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787524813; cv=none; b=f/c4Z/uG7Jy9CWA6sESGINl66/KKjGOiF87Yy9sebyZk7jO6LXiA07S4Zb98vsoS7e38vv9252dMuBvIlvIK22qHwtqJW2RSlGfpE2JqKqA0LL//sU7tzqMVpF/7LD6vzGRg0AIaFQ70LqyNvdn/fVAvclaQYxy97Y6vAuWtMSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787524813; c=relaxed/simple;
	bh=pEz9ZSO+xs/hhGJgo+ZI91I+V5+Shv/JSkecAPzFNmA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nAlVkmPV/bi8ITn2mrEBpNakIbIDatNFjo0oPh0d7SHZGybhJ8U4B0vBJAtnkWxDSARLcg7wgiVbgZfxKBClQdfUKdvm5wBb7W67VWDxV0wCS9DxZYAwrqnESa5jpODo2Xcnlokb7QBedZu9lOCze4tC+182fzxiRxDZAxK4+7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0LhtUuE; arc=none smtp.client-ip=74.125.228.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0LhtUuE"
Received: by mail-ed2-f8.google.com with SMTP id 4fb4d7f45d1cf-6a18ef2253bso2111227a12.1
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 15:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787524809; x=1788129609; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SG9rgDtNieYPykAvrJ3FehcRXBgEFFy+2SYvBOFnmm4=;
        b=f0LhtUuEMwoLIHDJ4NnvfUMQXyfAQAcZ3VCrJPC5nD0cdC/lv8sZMoK9uXcih5RTNw
         usOe7d7T2vkZZ/Yp2USXJ2eQCYObalWTTHIzG95za/0VJ3oRvBuuooTUUYD4Vhbs/O1V
         nUeafnmbqQoeZyGANlWkIvCgPlvg4UsVi+SboqPTbFIw9Bex+itI2Kizyym2InEjsAq/
         I+dTKwEM5QXjG2fxVyNVA5z+yadinql/QBnoD2zEwg42nnn4GCOvmgHyTPwpOcVkdUuN
         T0Zaa0yJjGyxg1NpCU+2A+ZavoQ4viUR+8A7OJ3+sA36BLfI+sJBGPBPpAEbltB5K4ot
         5ptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787524809; x=1788129609;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SG9rgDtNieYPykAvrJ3FehcRXBgEFFy+2SYvBOFnmm4=;
        b=iJ+JA7K48IlkrQxmWj2QJUl6+hHtMfFcrUi/MU8XjBF4BGCPUZ3a/nnKGfbDqVPsJ9
         QEZxD7jF/hWLKwY1Xz5jrs12DfSFISM2FGBfCkuZ1M3g44Gmgs7WtssokOtvVtVpxd0h
         fmi2+eiUBqdXkvpGtHpNc4B9+t7mJk/LWiDcGfTNaeRZa3GIBRcKYYEAQaCd6N0jb1Op
         8T3VZSiGvSt4Q6i9zjz1n1ku4vcLnSEN3IEIWM8jXH4M2XFMK7KzjK88NBjL9HLuwr/s
         HWw6FrXImaF3icR+y4FT7nsrkcqPGfTkCow/EKmG5eBCD/2dmNaPuGRXrqFUstYi77PO
         LnkA==
X-Forwarded-Encrypted: i=1; AHgh+RrZAGKuHGIbR/ZrkYsZ/L97Hesy+TeoSGo5Rmn29D5ujgvm7EFeqJuKXnES0f1wtScklp8=@vger.kernel.org
X-Gm-Message-State: AFuF++kS4Cpu70gyQEw0DnzLffQRsFa3NUFSDUvGdCAmPiCkAZV3IJqv
	HNDtth/RNpSFWAY6nK6gXkBcnmnJt+PxQQP3mgQRFIy0F8i5EP/BJmvJ
X-Gm-Gg: AR+sD10zkgy0WbdymvWKoMtFFsfC7tlSj00S62VItZLhrJAdmUqfyJ5E6W9JgeoxupD
	JEFjkFOWxrf1hmdtYfBKhkOGgtiBO9nlE4L5mtRauWzDxasHi2QjXop6uEB5zxUDF4+3N3q9yAp
	NPFR8YjH6HLUYIVjEXa3PZm83YYYi4DZcwbn1O78bUq0miL+WQm8uuM0gxRY+nxsbAjvT23QSr5
	IAla0qXyK3aJCeMluaL6UZLEjI+N558Qw9qYUiEq8rVeUYV0qOT51s3XZWHYOO/RxV8sX07p06R
	rziV38ap3Qn3re+bK3E3x8IjdmNitH2IpPmZXn7YKeb/cRBpRl6h/zmYdAA7waf6TDbd6/0gdyL
	PN3+tuMSgpTTfcdAY3V/jJMAKryYOFFjHXVmN5Aghtb7Dx3RGHGoc4HNDI/X5TyYHzsRLKHWgvM
	vM8b6vxdXhE+Q+w3tgWP2iCNnJPR36q9JKMWF6mUXdqW4mG8Tc1nRvWoWbbvRxFJKMEIYi57reP
	Wivl9vsGv+QmcaaSQKpQcvCQ/vJIXKLnwIMGGQPLNvYUtteYgQsTMc6q56ddBIaUrNyQCZhNz2s
	9fF4VrIyOCSOrLHDRrlmKhgYyEk=
X-Received: by 2002:a17:907:980d:b0:c20:56e8:5457 with SMTP id a640c23a62f3a-c246a359c6fmr2106818166b.6.1787524808751;
        Sun, 23 Aug 2026 15:40:08 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b4f1sm869047766b.3.2026.08.23.15.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 15:40:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 00:40:07 +0200
Message-Id: <DKWONS3UI84A.382GORI5CXC51@gmail.com>
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v7 9/9] selftests/bpf: add tests to validate
 KASAN on JIT programs
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
 <20260822-kasan-v7-9-99afee6ef7fd@bootlin.com>
In-Reply-To: <20260822-kasan-v7-9-99afee6ef7fd@bootlin.com>

On Sat Aug 22, 2026 at 12:39 AM CEST, Alexis Lothor=C3=A9 (eBPF Foundation)=
 wrote:
> Add a basic KASAN test runner that loads and test-run programs that can
> trigger memory management bugs. The test captures kernel logs and ensure
> that the expected KASAN splat is emitted by searching for the
> corresponding first lines in the report, hence validated that the needed
> instrumentation has been inserted by the JIT compiler before the
> relevant memory accesses. To allow each test to trigger the expected
> report, the kernel must run with the kasan_multi_shot configuration.
>
> The runner covers different cases and settings: in the nominal case, it
> validates kasan reports on basic instructions (on all supported accesses
> sizes) but also when report _should not_ be emitted (eg: for accesses on
> program stack). The runner also comes with a few specialized tests that
> are then not executed for all sizes/locations:
> - specific atomic ops
> - test for instructions involving different verifier states, with some
>   states flagging memory as stack, and other states as non-stack memory
> - tests that validate the stack marking shifting when a patch is emitted
>   by the verifier (zext/rnd_hi32, constant blindind).
> Most of those tests are able to trigger kasan reports by altering the
> shadow memory (triggering faulty accesses is otherwise complex, because
> of the verifier). A few tests trigger actual faulty accesses (eg
> out-of-bound accesses)
>
> A few of those tests depends on cpuv4 (load_acquire and store_release).
>
>   # ./test_progs -a kasan
>   #171/1   kasan/st_1_not_on_stack:OK
>   #171/2   kasan/st_1_on_stack:OK
>   #171/3   kasan/st_2_not_on_stack:OK
>   #171/4   kasan/st_2_on_stack:OK
>   #171/5   kasan/st_4_not_on_stack:OK
>   #171/6   kasan/st_4_on_stack:OK
>   #171/7   kasan/st_8_not_on_stack:OK
>   #171/8   kasan/st_8_on_stack:OK
>   #171/9   kasan/stx_1_not_on_stack:OK
>   #171/10  kasan/stx_1_on_stack:OK
>   #171/11  kasan/stx_2_not_on_stack:OK
>   #171/12  kasan/stx_2_on_stack:OK
>   #171/13  kasan/stx_4_not_on_stack:OK
>   #171/14  kasan/stx_4_on_stack:OK
>   #171/15  kasan/stx_8_not_on_stack:OK
>   #171/16  kasan/stx_8_on_stack:OK
>   #171/17  kasan/ldx_1_not_on_stack:OK
>   #171/18  kasan/ldx_1_on_stack:OK
>   #171/19  kasan/ldx_2_not_on_stack:OK
>   #171/20  kasan/ldx_2_on_stack:OK
>   #171/21  kasan/ldx_4_not_on_stack:OK
>   #171/22  kasan/ldx_4_on_stack:OK
>   #171/23  kasan/ldx_8_not_on_stack:OK
>   #171/24  kasan/ldx_8_on_stack:OK
>   #171/25  kasan/simple_atomic_4_not_on_stack:OK
>   #171/26  kasan/simple_atomic_4_on_stack:OK
>   #171/27  kasan/simple_atomic_8_not_on_stack:OK
>   #171/28  kasan/simple_atomic_8_on_stack:OK
>   #171/29  kasan/simple_atomic_fetch:OK
>   #171/30  kasan/simple_atomic_fetch:OK
>   #171/31  kasan/load_acquire_1_not_on_stack:SKIP
>   #171/32  kasan/load_acquire_1_on_stack:SKIP
>   #171/33  kasan/load_acquire_2_not_on_stack:SKIP
>   #171/34  kasan/load_acquire_2_on_stack:SKIP
>   #171/35  kasan/load_acquire_4_not_on_stack:SKIP
>   #171/36  kasan/load_acquire_4_on_stack:SKIP
>   #171/37  kasan/load_acquire_8_not_on_stack:SKIP
>   #171/38  kasan/load_acquire_8_on_stack:SKIP
>   #171/39  kasan/store_release_1_not_on_stack:SKIP
>   #171/40  kasan/store_release_1_on_stack:SKIP
>   #171/41  kasan/store_release_2_not_on_stack:SKIP
>   #171/42  kasan/store_release_2_on_stack:SKIP
>   #171/43  kasan/store_release_4_not_on_stack:SKIP
>   #171/44  kasan/store_release_4_on_stack:SKIP
>   #171/45  kasan/store_release_8_not_on_stack:SKIP
>   #171/46  kasan/store_release_8_on_stack:SKIP
>   #171/47  kasan/ldx_patched:OK
>   #171/48  kasan/ldx_patched:OK
>   #171/49  kasan/verifier_paths_stack_and_non_stack:OK
>   #171/50  kasan/ldx_oob_1_not_on_stack:OK
>   #171/51  kasan/ldx_oob_2_not_on_stack:OK
>   #171/52  kasan/ldx_oob_4_not_on_stack:OK
>   #171/53  kasan/ldx_oob_8_not_on_stack:OK
>   #171/54  kasan/st_blinded:OK
>   #171     kasan:OK (SKIP: 16/54)
>   Summary: 1/38 PASSED, 16 SKIPPED, 0 FAILED
>
> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boot=
lin.com>
> ---

1. Should this test be made serial to make sure bpf_jit_harden sysctl chang=
e
doesn't affect other tests?
2. Clang currently collapses the intended ST/STX distinction for *_on_stack
tests: default/v3 emits STX for both pairs, cpuv4 emits ST for both, and th=
e
default st_blinded object is already STX and therefore is not blinded. Plea=
se
check and assert that xlated insns are correct in the test itself if possib=
le.
It might be necessary to use asm volatile assembly blocks in case you canno=
t
work around the compiler in C.
