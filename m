Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E361C3C9451
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775829446; cv=none; b=dhIpcXHLboxVR9leeTCM/lnc0zSdLc2+oOndXooewd6lLDgIlWmrZ8MS1db0z8Iyn5XtYQfy81Bdf6xslFWKT2XISkRbrGJnQGMlOEeJ0AkUSd0WeHvM5LF7Kkx7p1eM4n8nfY5llyMFvBSYtUJdT8qInTdUxZDBR29p6r64Z9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775829446; c=relaxed/simple;
	bh=6DM538UFb0Hz6iV1GjcwnX3W49JjywTVV5TAPCOwQE8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=JKaE1O4WCA7DmiRoHDlyczulUBOlVgbL6WS5MeO85OHZg0iyBfZprBNQIwMexFmfMpp29xJnfGEKyLgkZTFzjqgtgFwB2VrWD7SHsXjUAon9FNnwZj3UsiucpMq4MAYknbXKtnX8OeKJVNLQsQbxVk0rbM+iGKFrtgGIQH5o5zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BhVl+1cE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BhVl+1cE"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so26694355e9.2
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 06:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775829442; x=1776434242; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVhDJ31DUrblyIAf15oUrnf9PdWowrxgBH4zol030WU=;
        b=BhVl+1cEdPlstxZC93YRsRf8LGt/3aBMv4dRmS6mGEP0wFGIbPBjgeKeAuaInMBj2R
         ahAFRir/31GPyZ5cX4pTxiID2eSXu8YG3Lhd2PyP6kORmFOvEfT6irjKkot/GPIrO98/
         jbDnLGpsnyRQK1zt6NyyrrlatW4EpUcBBVpJYxgQ4t1v8/Uv6RjG+EJ3qmytPvN11LZD
         lYQTjNVRvOnRdUo1L3lYBSz/ikxOtHqR2RScpi4kP/4q3SO7AgeSdR6Ug3ZjE2L7W5qp
         qmuDlZ4/Nq7bx3sysFQIOr4dfnKE2yAy9JDSBjjJYOgVYcYbvgWC5aROxzYoqH8s6BA+
         Uxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775829442; x=1776434242;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vVhDJ31DUrblyIAf15oUrnf9PdWowrxgBH4zol030WU=;
        b=GP4tP4UmedbaalyIa0afUYIgyROYbYknLt/tQyOr+P6dmCbevtmsc2XnOqxwSCyVVc
         Y8uBiSwqTdgDJtiXlfMh+Du5eCN72ddwNP98cxmRWX0OfaNrRbWsvqmNWFEWA7GbdF6u
         DeU54CImLQOSizqWgxc9W1ybububdtpQsknmVb9i2ELx6SVg7kYJvfINb7COpaqixuuE
         6bP9m0pgxtqXELpZ7otecnJqh+4tM1alnjQjbTf3DveBk/3ODQLzBySlPgjQaQ087uZn
         cps09DsMycJOMTVhmI3Fbh7yHiDgRCncLu1XdigaAPkMli7hJEZktdPaTCgNLfmpo9l1
         Xk7A==
X-Gm-Message-State: AOJu0YwQXarb6vpQhwi33ezfCH/C0T8I95KVFcGNV1He3rTwjTFmV3xT
	PG4e5PlVNtXMeZrsuTKdX6JotA/bkcXj5LfohpKROQDoqyf0gSDIsmeur3RJsWktAeY=
X-Gm-Gg: AeBDieuMwymYBemMWuwnuG8KssenUbu3Xn0Dn84COGGx0vMW1zoeLFx7QhJxcosT7fz
	B2wx66yxaDyS98no71bgYcxK7cxHm3H0mM2am9V+P//zjY9U3rlWqBiSq1W2lPT7t7K1jyPuTPp
	Bl+E0S/TzVToCXzegmhUVvQNSJVZGs/q5UlYMZif+7/5dItZmEEQWesWkJZQYJecSbmfZtANhHw
	LdgjmidGSWMVgomBupoM7sajjPAVqpvKCypMIUBDMwY6D9Pu96Ds+r6hVpYvBOEdh8c7hqBPVOa
	2eWpA7WTc+4Rtf+57Ud7Nwmo/zPhLTp+NP3uA3QVJTskDCi3b8KOBv9avdhDAclvcVLvX/guDaU
	LcPAzSQmitC83JTAAKPTtBKQKoXekL6p7Wp0E+/HUYlmD2fvnxmvDjkQy3Y2CRNR9MLii1Y/IiC
	iFR+T0QOzr9w==
X-Received: by 2002:a05:600c:871a:b0:488:a2ac:a34a with SMTP id 5b1f17b1804b1-488d67f4299mr43425365e9.10.1775829442178;
        Fri, 10 Apr 2026 06:57:22 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:285:ece1:da61:637f:91ff])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-954bf0c1b8fsm1691232241.6.2026.04.10.06.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 06:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Apr 2026 10:57:17 -0300
Message-Id: <DHPIZX3045PN.2QCSGKPP43W3I@suse.com>
Subject: Re: [PATCH v4 00/10] selftests/bpf: Tolerate partial builds across
 kernel configs
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
To: "Alan Maguire" <alan.maguire@oracle.com>,
 =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nick
 Desaulniers" <nick.desaulniers+lkml@gmail.com>, "Bill Wendling"
 <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
X-Mailer: aerc 0.21.0-120-g22b95d38161f
References: <20260406-selftests-bpf_misconfig-v4-0-9914f50efdf7@suse.com>
 <00e95867-edbc-4e74-8696-16a8f61223b7@oracle.com>
In-Reply-To: <00e95867-edbc-4e74-8696-16a8f61223b7@oracle.com>

Hi Alan,

On Fri Apr 10, 2026 at 7:06 AM -03, Alan Maguire wrote:
> On 06/04/2026 19:22, Ricardo B. Marli=C3=A8re wrote:
>> Currently the BPF selftests can only be built by using the minimum kerne=
l
>> configuration defined in tools/testing/selftests/bpf/config*. This poses=
 a
>> problem in distribution kernels that may have some of the flags disabled=
 or
>> set as module. For example, we have been running the tests regularly in
>> openSUSE Tumbleweed [1] [2] but to work around this fact we created a
>> special package [3] that build the tests against an auxiliary vmlinux wi=
th
>> the BPF Kconfig. We keep a list of known issues that may happen due to,
>> amongst other things, configuration mismatches [4] [5].
>>=20
>> The maintenance of this package is far from ideal, especially for
>> enterprise kernels. The goal of this series is to enable the common usec=
ase
>> of running the following in any system:
>>=20
>> ```sh
>> make -C tools/testing/selftests install \
>>         SKIP_TARGETS=3D \
>>         TARGETS=3Dbpf \
>>         O=3D/lib/modules/$(uname -r)/build
>> ```
>>=20
>> As an example, the following script targeting a minimal config can be us=
ed
>> for testing:
>>=20
>> ```sh
>> make defconfig
>> scripts/config --file .config \
>>                --enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
>>                --enable DEBUG_INFO_BTF \
>>                --enable BPF_SYSCALL \
>>                --enable BPF_JIT
>> make olddefconfig
>> make -j$(nproc)
>> make -j$(nproc) -C tools/testing/selftests SKIP_TARGETS=3D TARGETS=3Dbpf=
 install
>> ```
>>=20
>> This produces a test_progs binary with 579 subtests, against the total o=
f
>> 708. Many of them will still fail or be skipped at runtime due to lack o=
f
>> symbols, but at least there will be a clear way of building the tests.
>>
>
> hi Ricardo, I've been looking at this series and one concern I had was if
> tolerating failures to build with incomplete config would create problems
> in detecting failures when the config is complete, i.e. in BPF CI. So for
> example if say a BPF skeleton didn't compile when it really should due to=
=20
> an introduced bug, we wouldn't want to drive on in all cases.

Agreed.

>
> However, from what I can see, CI held up well with these changes in place=
 [1].
>
> That said it might be nice to preserve a "strict" mode which fails when
> we hit compilation issues etc, failing as we do today; I couldn't find an=
y existing=20
> general kselftest concept that fits with that but it would be valuable I =
think
> if possible. Perhaps we could default to non-strict mode when a make -C i=
s initiated
> or something like that, and continue to operate strictly when building di=
rectly
> in tools/testing/selftests/bpf?
>
> I ran the changes through the usual workflow I use - build bpf selftests =
at
> tools/testing/selftests/bpf level and run ./test_progs ; no regressions w=
ere
> observed, so feel free to add for the series
>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>

Thanks for testing!

>
> There are some comments on sashiko.dev [2] that would be worth looking th=
rough
> too, in particular the concern about O=3D and M=3D mentioned for patch 1.

I will send v5 with those addressed and possibly a strict-mode switch.

>
> [1] https://github.com/kernel-patches/bpf/actions/runs/24168181680
> [2] https://sashiko.dev/#/patchset/20260406-selftests-bpf_misconfig-v4-0-=
9914f50efdf7%40suse.com
>  > [1]: https://openqa.opensuse.org/tests/5811715
>> [2]: https://openqa.opensuse.org/tests/5811730
>> [3]: https://src.opensuse.org/rmarliere/kselftests
>> [4]: https://github.com/openSUSE/kernel-qe/blob/main/kselftests_known_is=
sues.yaml
>> [5]: https://openqa.opensuse.org/tests/5811730/logfile?filename=3Drun_ks=
elftests-config_mismatches.txt
>>=20
>> Assisted-by: {codex,claude}
>> Signed-off-by: Ricardo B. Marli=C3=A8re <rbm@suse.com>
>> ---
>> Changes in v4:
>> - Drop the test_kmods kselftest module flow patch: lib.mk gen_mods_dir
>>   invokes $(MAKE) -C $(TEST_GEN_MODS_DIR) without forwarding
>>   RESOLVE_BTFIDS, breaking ASAN and GCC BPF CI builds (Makefile.modfinal
>>   cannot find resolve_btfids in the kbuild output tree)
>> - Link to v3:
>>   https://patch.msgid.link/20260406-selftests-bpf_misconfig-v3-0-587a111=
4263c@suse.com
>>=20
>> Changes in v3:
>> - Split test_kmods patch into two: fix KDIR handling (O=3D passthrough,
>>   EXTRA_CFLAGS/EXTRA_LDFLAGS clearing) and wire into lib.mk via
>>   TEST_GEN_MODS_DIR
>> - Pass O=3D through to the kernel module build so artifacts land in the
>>   output tree, not the source tree
>> - Clear EXTRA_CFLAGS and EXTRA_LDFLAGS when invoking the kernel build to
>>   prevent host flags (e.g. -static) leaking into module compilation
>> - Replace the bespoke test_kmods pattern rule with lib.mk module
>>   infrastructure (TEST_GEN_MODS_DIR); lib.mk now drives build and clean
>>   lifecycle
>> - Make the .ko copy step resilient: emit SKIP instead of failing when a
>>   module is absent
>> - Expand the uprobe weak stub comment in bpf_cookie.c to explain why
>>   noinline is required
>> - Link to v2:
>>   https://patch.msgid.link/20260403-selftests-bpf_misconfig-v2-0-f067003=
80a9d@suse.com
>>=20
>> Changes in v2:
>> - Skip test_kmods build/clean when KDIR directory does not exist
>> - Use `Module.symvers` instead of `.config` for in-tree detection
>> - Fix skeleton order-only prereqs commit message
>> - Guard BTFIDS step when .test.o is absent
>> - Add `__weak stack_mprotect()` stubs in `bpf_cookie.c` and `iters.c`
>> - Link to v1:
>>   https://patch.msgid.link/20260401-selftests-bpf_misconfig-v1-0-3ae42c0=
af76f@suse.com
>>=20
>> ---
>> Ricardo B. Marli=C3=A8re (10):
>>       selftests/bpf: Fix test_kmods KDIR to honor O=3D and distro kernel=
s
>>       selftests/bpf: Tolerate BPF and skeleton generation failures
>>       selftests/bpf: Avoid rebuilds when running emit_tests
>>       selftests/bpf: Make skeleton headers order-only prerequisites of .=
test.d
>>       selftests/bpf: Tolerate test file compilation failures
>>       selftests/bpf: Allow test_progs to link with a partial object set
>>       selftests/bpf: Tolerate benchmark build failures
>>       selftests/bpf: Provide weak definitions for cross-test functions
>>       selftests/bpf: Skip tests whose objects were not built
>>       selftests/bpf: Tolerate missing files during install
>>=20
>>  tools/testing/selftests/bpf/Makefile               | 113 ++++++++++++++=
-------
>>  .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |  24 ++++-
>>  tools/testing/selftests/bpf/prog_tests/iters.c     |  10 +-
>>  tools/testing/selftests/bpf/test_kmods/Makefile    |  15 ++-
>>  tools/testing/selftests/bpf/test_progs.c           |   7 +-
>>  5 files changed, 120 insertions(+), 49 deletions(-)
>> ---
>> base-commit: a1aa9ef47c299c5bbc30594d3c2f0589edf908e6
>> change-id: 20260401-selftests-bpf_misconfig-4c33ef5c56da
>>=20
>> Best regards,
>> -- =20
>> Ricardo B. Marli=C3=A8re <rbm@suse.com>
>>=20
>>=20

