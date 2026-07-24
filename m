Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADC444C502
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913591; cv=none; b=jqpL9HDRM99zzo2MUTimXGC95rB4x6xEfMzmRINbZFvpCbXLdZDNE2L+ctqYb5QyW0jb1O7ubrtc2pBaDNFOlZ6LwHKB0t75Ub27Jcn4n2YGl3RtZa02VLCHSvKtTU54n/7EOGGTre3vZePG5zfZGXU/n10flsA9SEq2FRdEnfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913591; c=relaxed/simple;
	bh=h43OVubBFOUqhHHcp0LrQGUoL7yyuyHZKEUxyYWHBUE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DrzXl56Iw03SdmdsyDQNWe2mguK0JnN8prQKv0thI79XM8VXW3rNtgVAViE08ZMePYn81TN+9gRbZ/etmzqkUJ6nFjE29pqkM/yaO23n6a+7DpLVbmRL2r833dUF25955in85IBel5qkT+U8yaxd1Gw/0XycwOy2Kj3MuELpSJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYt/tflG; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYt/tflG"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495459712d2so1878355e9.1
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 10:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784913587; x=1785518387; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KowxSJVmc3vRiPdHyROrkjM4WewCaL2j1J/8LxUkYtk=;
        b=JYt/tflGn11muPpBMVHJnVUocFze63t0VswaCJl0UGmUlc/kw9a7mejzVFHaorrKNW
         tej5WEACR3SkJXb2JZiJp4WQxMRbg5gSJR3m6iEKu2TblmMzXwi3wI7kzZrXBu+ticrs
         MQoRTq5mPuLW106CFbXAusqi9d+8okQc++xo+rcwI2oDfqbcPBhobx9qKYjJgo8rIPKY
         jkaHa56KslGmDtEsiUwkw5JV3PbyLUU8assMCFC0l4WJvcnOu/vS2XFUMuNoYzMBrPNM
         ulCmFOT8j7hK7XUX/HDoubNFMo2UOhO0ksVC9KFls2aCtgo6kL4mA4wjLIALmkUrxcoM
         ekDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784913587; x=1785518387;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KowxSJVmc3vRiPdHyROrkjM4WewCaL2j1J/8LxUkYtk=;
        b=aERwyiId5hGhq8L7nxLEOWX8qVjs2GJDQvJ+y2Jzm68E6FE7bEiGzI5CkNsA9/miss
         0I6FOHlaHI5/HmjUHyb5Bhpo6iAd8YzqRxjbiMHgVbwImW1oXbgz7TrVFKkcKb+xo9MZ
         m/wT4E4+YpnWpVxOus9BykPMBOgHIWS/hpy8HLxtq0pfqY6Db9dmcwCW3pvupZF9Vv8x
         x6BAu86Q/75Me5bZD7/d0Cdk/+MAjsEYsFxgU54+blrqMKDAajVohK6g9bRWJU7qqZ7o
         +mIJRN+qlCASJU5+awCDCGDRJY5t2FfcbdvpkLU0OL9n9VjkW6W7gIJ+rEGIUPnIbasj
         yy5A==
X-Forwarded-Encrypted: i=1; AHgh+RpZ/rfgZgfuESEMZ11gcZhKLwg0pFJQSDRbuH3dmkD+aDS0cuLoIoXcxLsJrpLwUuYUhJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgPzP64jK81AH+iVEtrKOkLbQ0pdrfAKHsdntrr1KcBD66jdOY
	Gq2oIhv40Ad0VGUgRfUQnWwWs01n4UVj43UahZJJ5bubk5bcpJfvFsT6
X-Gm-Gg: AR+sD12+hkoFIMCG7eXGffLqgdMopyfsWRSXZbG9GJcZM6DjbzaT9yBBIP9Odw/BNJ8
	3CDfOpfEBNdcj1R/NkdfJCn2G4KE8D10BU+P/fi+s+ecqSaopn18rKPhXnQc51e+iApdXK0MwHH
	bgEksDiJpwvtHvzu/UhcXFVz+ThaI9j+3zOEVKttYA4XyqiFU5XeS/ZLDNZzOdAW03SAmb+ZYS8
	qjKMIG7xM4W0eavCcy7Vx1gCB0RPyxIFPZhqc818Y56utOZJWIMhN/wuxdNssOFF9wJJY+71CO7
	lEoVS78HVqome3TkSsV+01lZOY667jGxYFrszuGzFVMZv//+GctLMW1mipEpPG/amQFS4EcPoFw
	kp8SsMzV9vaKQsPpGAx1pegSDzU0Bw+CqmB2WpQh0Cw+NaeHRgcJaJlKSYID47REKugp17hL8wn
	PSvs4RzwHyMkDXstOPXidX3Z8O9EGUytoen7RvoIFYF0wjV8jcVnLITjtvOLfnZ218rci1HSC9g
	PYg2b1MvABs2XPMo5O2HOr163Hrr0TA2nVDffBVoSjl
X-Received: by 2002:a05:600c:5942:b0:495:6397:14b1 with SMTP id 5b1f17b1804b1-49573cf0ec2mr67839245e9.34.1784913586592;
        Fri, 24 Jul 2026 10:19:46 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f5665f0sm49342725e9.0.2026.07.24.10.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 10:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jul 2026 19:19:45 +0200
Message-Id: <DK6Z25AV02BM.3KXO0EMCMP2W9@gmail.com>
Cc: "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Nathan Chancellor" <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin KaFai
 Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Peter Zijlstra"
 <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>, "Mark Rutland"
 <mark.rutland@arm.com>, "Alexander Shishkin"
 <alexander.shishkin@linux.intel.com>, "Ian Rogers" <irogers@google.com>,
 "Adrian Hunter" <adrian.hunter@intel.com>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
 <bpf@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 0/4] tools/build: Allow versioning of all LLVM tools
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Namhyung Kim" <namhyung@kernel.org>, "James Clark"
 <james.clark@linaro.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260715-james-perf-llvm-version-v4-0-6dfdf984b435@linaro.org>
 <algbxQAAmurxms8X@google.com>
In-Reply-To: <algbxQAAmurxms8X@google.com>

On Thu Jul 16, 2026 at 1:46 AM CEST, Namhyung Kim wrote:
> Hello BPF folks,
>
> On Wed, Jul 15, 2026 at 03:53:47PM +0100, James Clark wrote:
>> I ran into the build issue mentioned in the first commit, because using
>> an option like LLVM=3D-15 is a documented way to build [1], but only
>> some of the LLVM tools defined in tools/ support this.
>>
>> After fixing that, a lot of other tidyups fell out. I didn't go too far,
>> for example some selftests include tools/testing/selftests/lib.mk which
>> reimplements some of the LLVM_SUFFIX stuff, but other selftests include
>> tools/scripts/Makefile.include and I stopped before touching the former.
>> Some other non build scripts hard code toolchains and I didn't touch
>> those either, this change is only focused on things that already
>> include Makefile.include.
>>
>> [1]: Documentation/kbuild/llvm.rst
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>> Changes in v4:
>> - Drop "tools/build: selftests: Allow versioning LLVM lld", clang
>>   already picks the correct sibling lld version. (Sashiko)
>> - Link to v3: https://lore.kernel.org/r/20260715-james-perf-llvm-version=
-v3-0-8854bfe5af7e@linaro.org
>>
>> Changes in v3:
>> - Add warning for empty $USE_LD
>> - Use $HOSTREADELF in bpf Makefile
>> - Rebase on v7.2-rc3
>> - Link to v2: https://lore.kernel.org/r/20260518-james-perf-llvm-version=
-v2-0-f12cc4f031d8@linaro.org
>>
>> Changes in v2:
>> - Fix selftests/bpf build. LLD needs to take the full path to be used
>>   with -fuse-ld=3D
>> - Link to v1: https://lore.kernel.org/r/20260514-james-perf-llvm-version=
-v1-0-6cac1a9a4c8d@linaro.org
>>
>> ---
>> James Clark (4):
>>       tools/build: Allow versioning of all LLVM tools defined in Makefil=
e.include
>>       tools/build: Indent if else blocks
>>       tools/build: Allow versioning LLVM readelf
>>       tools/build: selftests: Remove some duplicate toolchain definition=
s
>>
>>  tools/bpf/resolve_btfids/Makefile    |  3 --
>>  tools/lib/api/Makefile               |  4 --
>>  tools/lib/bpf/Makefile               |  8 ++--
>>  tools/lib/subcmd/Makefile            |  4 --
>>  tools/lib/symbol/Makefile            |  4 --
>>  tools/perf/Makefile.perf             |  7 ----
>>  tools/scripts/Makefile.include       | 77 ++++++++++++++++++++---------=
-------
>>  tools/testing/selftests/bpf/Makefile |  1 -
>>  8 files changed, 46 insertions(+), 62 deletions(-)
>
> Are you ok with this change and going through perf tree?
>

Sorry for the delay, yes, feel free to take it through your tree.

> Thanks,
> Namhyung
>
>> ---
>> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
>> change-id: 20260511-james-perf-llvm-version-43ab1cb5bc7d
>>
>> Best regards,
>> --
>> James Clark <james.clark@linaro.org>
>>

