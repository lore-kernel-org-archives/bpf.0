Received: from mail-oa2-f10.google.com (mail-oa2-f10.google.com [74.125.231.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179773F1ABB
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883188; cv=none; b=cX9RYjV8sltPFe5G2tyVmJVmI5cOBiN78dHPXYcpmbE82h+UatuUly40BJ7830zidDjqhQrLoXtvfy5lnsimRO9GZViCa3fKfl7ow7f1W23fO3XGLe47p7/qrQfCzPnqutBIcUXybgkK08f2EegElBiKSAG2kgRiQVPBlJ49S9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883188; c=relaxed/simple;
	bh=Ao1XJSnKJho5DdgRHZsQeaaVqUI8DnMbl0dlRhWDmm8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oOQqJiKziHnTwtAroPYw0FDI69U8UMokhX4Bgqs7h9iN2bTwP61gWYvn18qUZyyA3/oZEJb6/cipJmxOJAQyixdZd7oqqSKdZt2x9TcrLDHcgErVsviSaqWA4Ob8/Z0LXi+RY90EU5QpeFbv+ECULcbwNmUQGDhbuRTI1sjllAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wdz2h52q; arc=none smtp.client-ip=74.125.231.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wdz2h52q"
Received: by mail-oa2-f10.google.com with SMTP id 586e51a60fabf-4a245df59d0so1222155fac.0
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 02:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791883186; x=1792487986; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rV8F12K8w7yWqpHlgeH/ydHy/10aeEHq94jocVR1LNw=;
        b=Wdz2h52qWmZ4NtB0DjG7A9QJ1GsAZam4IlIXJDTGPjd9BW2R/pDkzcm3cf7XTkTN0z
         ghtdUJdz9LitU2nMDJWRsmzo72Vh0mIsGYBNIMyThWcb+d6MXwGCvyqXA6olPY0WmydO
         a//fsmbLyN4UknsbEo9oyZ1xfw2h34YPQnbIU3VF4bPChLoHkSGUCONH+bPNvOIEUKho
         4lqAWJCDoVyCb0t38MBq6wSnsU2jyc4MULVyUtp9J5yfO3WxRkIxUXBpo394Vg0Lww8f
         OI+LfhJwVnI1txv4fX6hTD5uf+U25mQ4hMU73mK0dPok4QErX+MGxWD82LFgOlkFEtHH
         BDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791883186; x=1792487986;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rV8F12K8w7yWqpHlgeH/ydHy/10aeEHq94jocVR1LNw=;
        b=ZYshz8I03DqHcoBU3aa3/PnBrbHhAJdrktq7JAXB6E9CmXNIHkb4F0EsR3Io9/jWLe
         TV++DsEHcVh2wjEKzSNrYQ39w8WN/jYncLrHpCWGArV6tvGuwVtTbh7tSnTCJJKLtESr
         O302At1nkvnJQD7m+RkTDK6Wtetuq8P9Wlo7nVajTWGliq7cp5qv1vb5JNCeJ5Uj4/Bu
         eTppW+Vj+++ptdZyS3b1NfPklzmQhYD/5pRCd5ARXIdnRu6gF35AMLQW3LXzjADRWC/J
         7dBvVVWJaSm/zeTHb3Z0J8vpApfSHRCM7lZVLI1iVgX0gz5F13vNCbypbRjkl7uxcIm5
         ndXg==
X-Forwarded-Encrypted: i=1; AKwUvBxD94Xio5NBy+x+0JU5bu0aLt+yyM4dEX1Kcrh/sfII5siEQrbd9CxiCSrTUIIXZtDWegk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjSC3z0sTGlH6vnRfEW4WVs1JNfCox5v71X8BhzZxCp2Xi6pPU
	0kG3vs+ttJcxz+2VtR9GnnTer34yzk2TIcH5Dsb4XWc8PFB1oHKnaluC
X-Gm-Gg: AYBFou0/ryYE0oofgxAGSlncA+NkNY1pnp6hNnIqu/TRLTM9nOSc/2nuZY5gAKnTfOj
	SirBLBkVJFx+92CqHMImER8LXgRXvfoONce415lGygjMbbReu0de+NjA6f8Y9EcDStJolyTfBq/
	KUovcITSNXkVkceWmMf4CVLkTkb/1oLmNHXJhKtEaqdgeK0G67pRhhxElJDVNdOXNZO2oqg8sUT
	F8haZKnVFQnI4wRLB9h5Nlnd4Vxh8uTRRAwPFaCzQg+zW871JlaaGJUYM+uvepdp+F/snmwFmMc
	fVMATgpnEQHx9StMb0qmXTiBZdpJn8Ew82rpxYtIJgQB+g/jYTCcL6+ieLYfA3V7dHYg/hfxAe4
	nn/9ct5uPLJ3zp8lJt34pKs6RlWgxGZwHnKCxx/0oiB2GAm1d+U2cL8vCdp8teAhAqao0rdjRbJ
	m6U8dXiTB3MtOeIpPizHX971wn0ztRV0mEKcgdgw5VDyvVBtRQfgIAr8INhX9sG4RWsyzHCALAP
	+nndWX25T3b7OMniCl0MV1JdcNC2ZVsU6BTHG5zmzE4JI8qJWkJ/4seiYBQ+MdKHCuLcdV1E62E
	mQaM
X-Received: by 2002:a05:6870:80c9:b0:494:b8f4:9a22 with SMTP id 586e51a60fabf-4a2a89ffb98mr10721042fac.28.1791883185758;
        Tue, 13 Oct 2026 02:19:45 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:3::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a860102dsm11783171fac.16.2026.10.13.02.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 02:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 11:19:42 +0200
Message-Id: <DM3LKPQPHXE3.GP6SHET5TH6K@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <tj@kernel.org>, <kkd@meta.com>, <kernel-team@meta.com>,
 <martin.lau@kernel.org>, <yonghong.song@linux.dev>, <mason@kernel.org>
Subject: Re: [PATCH bpf-next v2 07/13] selftests/bpf: Test __arena pointer
 members
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20261013082012.1107446-8-memxor@gmail.com>
 <19d84db7443c99a6256ac4bda3e1eabefb2a052b231f8aa571dc0628ee2ed2ff@mail.kernel.org>
In-Reply-To: <19d84db7443c99a6256ac4bda3e1eabefb2a052b231f8aa571dc0628ee2ed2ff@mail.kernel.org>

On Tue Oct 13, 2026 at 11:14 AM CEST, bot+bpf-ci wrote:
>> selftests/bpf: Test __arena pointer members
>
> TL;DR: Test issue in test_struct_ops_arena.c: if the bpf_testmod BTF lack=
s the
> "arena" type tag, the new arena member tests are silently dropped,
> test__skip() is never called, and the test still reports OK.
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_aren=
a.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
>> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
>
> [ ... ]
>
>> +/*
>> + * The tags on the members of struct bpf_testmod_arena_member_args reac=
h the
>> + * module BTF only from a toolchain with btf_type_tag support.
>> + */
>> +static bool testmod_has_type_tag(const char *tag)
>> +{
>> +	struct btf *vmlinux_btf, *module_btf;
>> +	bool found =3D false;
>> +
>> +	vmlinux_btf =3D btf__load_vmlinux_btf();
>> +	if (!ASSERT_OK_PTR(vmlinux_btf, "vmlinux_btf"))
>> +		return false;
>> +	module_btf =3D btf__load_module_btf("bpf_testmod", vmlinux_btf);
>> +	if (ASSERT_OK_PTR(module_btf, "module_btf"))
>> +		found =3D btf__find_by_name_kind(module_btf, tag, BTF_KIND_TYPE_TAG) =
> 0;
>> +	if (!found)
>> +		printf("%s:SKIP: no %s type tag in the bpf_testmod BTF\n", __func__, =
tag);
>> +	btf__free(module_btf);
>> +	btf__free(vmlinux_btf);
>> +	return found;
>> +}
>
> [ ... ]
>
>> @@ -122,6 +201,18 @@ void serial_test_struct_ops_arena(void)
>>  		arena_arg_fail();
>>  	if (test__start_subtest("arena_arg_attach"))
>>  		arena_arg_attach();
>> +	if (testmod_has_type_tag("arena")) {
>> +		if (test__start_subtest("arena_member"))
>> +			arena_member();
>> +		if (test__start_subtest("arena_member_render"))
>> +			arena_member_render();
>> +		RUN_TESTS(struct_ops_arena_member_fail__union);
>> +		RUN_TESTS(struct_ops_arena_member_fail__load_acq);
>> +		RUN_TESTS(struct_ops_arena_member_fail__mismatch);
>> +		RUN_TESTS(struct_ops_arena_member_fail__mismatch_mem);
>> +		RUN_TESTS(struct_ops_arena_member_fail__write);
>> +		RUN_TESTS(struct_ops_arena_member_fail__no_arena);
>> +	}
>>  #else
>>  	test__skip();
>>  #endif
>
> When the bpf_testmod BTF has no "arena" type tag, testmod_has_type_tag()
> prints a SKIP line but never calls test__skip().  Is the skip reported
> anywhere?
>
> serial_test_struct_ops_arena() then leaves out the arena_member and
> arena_member_render subtests and all six RUN_TESTS() groups, and the pare=
nt
> test still reports OK.  test_progs only prints a test's captured stdout w=
hen
> the test fails or runs verbose (dump_test_log() uses print_test =3D verbo=
se()
> || force_log || test_failed), so in a normal run the message is never sho=
wn
> and the skip is never counted.
>
> That seems realistic for kernels built with a toolchain that lacks
> btf_type_tag support, where this coverage would be silently dropped.
> prog_tests/btf_tag.c does the same check
> (btf__find_by_name_kind(*module_btf, "user", BTF_KIND_TYPE_TAG) <=3D 0) a=
nd
> pairs the printf with test__skip().
>
> Could the arena_member and arena_member_render subtests still be started
> unconditionally, calling test__skip() from inside each one when the tag i=
s
> missing?  That would keep the arena_arg* results intact while making the
> skip visible.
>

It's fine.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/383703=
95582


