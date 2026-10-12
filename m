Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7101357D0D
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815234; cv=none; b=nUzGGQprjrCSnR6NIUDI1jojxoEx2rtSBy5FMzLfBZd1uWC0P88FXDSbYjphgFBkltdre3hpBl80/ylwztZgiW0w6CF7A8gmEEZLJ+o61xPo+EgPUL/tnz3UwwRG7OZT5dyK5aEqtEcPcboCMfLZ9+5nFzT24ZmgNQnBuMjakQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815234; c=relaxed/simple;
	bh=gqKcNbVEaPOuvsyfkk7nssCCGqv8Oe9PMmlcUSQjPuY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OkHFxCmWt9ibN6JuU6deTickNisWgwgPRtMHag1sPmp7V9bYHa7ps+qkeJJ0FugR0oqsPbspDj6OG+6uZlQrzNfFEx1F/u108JjFpKP336uX8WiBR/aEx5u5UvhsX5M6JE2R91qJsNdDZ3v+cKinTT3ftmRspShddTAWeHE1H6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElMEtJpD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElMEtJpD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46E51F0089B;
	Mon, 12 Oct 2026 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815233;
	bh=avFjHNR9rpRjPn8RXGeZUEHpvRtBOE9hM4sjhrJUf3A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ElMEtJpDolT/Psnt1AElBpeRMQwZKFF6CNZDB8qgpyvADomqymaPfcve3uFjtdJL/
	 Bl3gFXme+bLINFNgrS+bLSGb66oZCocAAxL/CRoKwlD8lsriI/1RXO0TaezsUKa3tT
	 LRQChqllac80yGIDR9kSGjyUPzoqvyCTk9GAWJd+/KkpPJvGYZeCa/XQ/CqB/YHMIJ
	 ZlnMI8p5EJ4M85q26PVfiBs44OJfWpAfXUjQb0/5CvREDXci7RBoDX1HegmY/IxI3W
	 qRwAvnz+fVa3leb5W7AFK6i4RGDHvQJrWqupa0iq5z/ri3SZTdr8gukQrHVxYR07hQ
	 LE0647q4h5jFw==
Content-Type: multipart/mixed; boundary="===============5724937953694991157=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <98cf2e412d106ecf71d0f514bdf7fc32610c555cefec73c2acd2a2414148ddf9@mail.kernel.org>
In-Reply-To: <20261012133711.4030594-8-memxor@gmail.com>
References: <20261012133711.4030594-8-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 07/10] selftests/bpf: Test arena binding by libbpf
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 12 Oct 2026 14:27:11 +0000 (UTC)

--===============5724937953694991157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test arena binding by libbpf

TL;DR: libbpf's arena binding may pass a placeholder memfd in fd_array when
the arena map has autocreate off, so loads could fail with -EINVAL;
verifier_ldsx @unpriv tests look affected but aren't in the changelog.

>     selftests/bpf: Test arena binding by libbpf
>
>     Attach a struct_ops callback with an __arena argument from an object
>     whose programs never refer to the arena and drive it through the kernel,
>     and check that an unrelated program of the object got the arena among
>     its maps as well.
>
>     Two existing programs expected to fail for want of an arena while living
>     next to an arena map, the kfunc argument case in arena_kfunc.c and the
>     scalar access case in verifier_arena_scalar.c. They load now, so move
>     them to an object without an arena map, where the kernel checks still
>     apply.
>
>     Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

The changelog lists two existing programs that stop failing once libbpf binds
the arena to every program.  Is that list complete?

At least one more existing test looks affected: the @unpriv variants in
progs/verifier_ldsx.c.  That object declares an arena map (under
__BPF_FEATURE_ADDR_SPACE_CAST) in the same object as socket programs marked
__success __success_unpriv (ldsx_s8, ldsx_s16, ldsx_s32, ldsx_s16_range,
ldsx_s32_range).

In unprivileged mode, test_loader turns off creation of maps that are not
unpriv-capable, and the arena is one of them:

    bpf_object__for_each_map(map, tobj)
        bpf_map__set_autocreate(map, !unpriv || is_unpriv_capable_map(map));

The arena map still holds the memfd placeholder that libbpf set up at open
time (bpf_object__add_map() does map->fd = create_placeholder_fd()), so
bpf_object__bind_arena() sees map->fd >= 0 and never looks at
map->autocreate:

    map = &obj->maps[obj->arena_map_idx];
    if (map->fd < 0)
        return 0;
    ...
    obj->fd_array[0] = map->fd;
    load_attr->fd_array = obj->fd_array;
    load_attr->fd_array_cnt = obj->fd_array_cnt;

Doesn't this hand the placeholder memfd to the kernel as a continuous
fd_array entry?

The kernel resolves every entry up front in
process_fd_array_continuous() -> add_fd_from_fd_array().  A memfd is neither
a map nor a BTF, so the load would fail with "fd %d is not pointing to valid
bpf_map or btf" (-EINVAL), while these tests expect success.

The selftests config leaves CONFIG_BPF_UNPRIV_DEFAULT_OFF unset, so subtests
such as "verifier_ldsx/LDSX, S8 @unpriv" run and would now fail.

The same applies to real libbpf users.  Any object whose arena map has
bpf_map__set_autocreate(map, false) could no longer load any of its
programs.

Should bpf_object__bind_arena() skip the arena when !map->autocreate, rather
than leaving this to the tests?  Should the changelog's list of affected
tests be extended, or should the libbpf side be fixed before this test
commit?  None of the later patches in the series (b94d4c47e39b,
a34d46a6be25, 00e951183327) appear to touch bpf_object__bind_arena().

A related point: verifier_ldsx.c is also built for __TARGET_ARCH_arm, whose
jit has no arena support.  With clang 18 or newer, its LDSX
socket/xdp/tc programs now get the arena bound in privileged mode too, so
would they fail with "JIT doesn't support arena"?  The same programs would
fail with "JIT is required to use arena" when the jit is disabled.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38258617362
--===============5724937953694991157==--
