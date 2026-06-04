Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668A023507C
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591550; cv=none; b=Zxl0l0Qfkoyuumu9wR3nrAnZTzLjI9l/HY8GW5JkJ3EZaC8QGriEK51bYe8JxvaLKsCJ4VZhwNaDqmvW4s8wNDrv17JI4u+HNWlN2cUVQmAu8q8b8/5OOS+54mtK/IDM1bzPRzBxW74HyikZBKvrfka8RAk7oqdS5UdYabDkClE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591550; c=relaxed/simple;
	bh=WVcEg1hmPtgK/FVBVB6kAQ9XulhBQxfqUH7/BgWEke4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Q7r+/qJmn1H3TSWI/pPIZXyGPq8JugHN685rdtC3ROmQSqMshzAErH17bRqGDTZIUqI2oxmrO1RNs6aguzOk6fPMzvr5fkFDvRDOJYcSvZ6ZsA1sCWye/LfG6PM1Ye+1G2j2sSxDMKd8UaBM/D5WKyV+uDW+PgU8ZXwM7M69mGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=bbV2pzbl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="bbV2pzbl"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf22d29dabso7123675ad.2
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780591549; x=1781196349; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzhnyiI+XwL53rTKaVwNAs2QDvDQlCTJj818tFshheA=;
        b=bbV2pzblH8S6bVdJOn+lzokzIQ7Go3CtKmIQsKQVWSbPXrovH9rApef0SYuAN2eJp2
         Ttfx1cGRRRSihh1uFeJRx5gxN52RDcMdBstHDtuPxe2rmo2mXwiPeaUJorF4B/pXFoVY
         AcTUmAjU1W0ZuHNpdDw/rDW92DsH5Z5wH09a548H4Ppumtugijh3qySy3f2MGFt99FTe
         Rf1DfsrNIzsawwpnY5p4pT9IjiB9/BBqaXPB5L8+cXlZD9EhCC+k3VqZjkYIPFr9LfNC
         89HF+HzStpZWZg0YEzf2ga3rrKZKSO6jjPSzhOkBk8H9wTiD7kOVVW7C94h+aFLsgc52
         1Ogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780591549; x=1781196349;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kzhnyiI+XwL53rTKaVwNAs2QDvDQlCTJj818tFshheA=;
        b=jqXrHZr4/03ospob1fVvKa7VStV53/6rL83P6sggFTzji0NJT2r/qiiF+IP5zIvsuF
         dqDDQxdSlK586GvvwB7H7VAbqTF4t6sOp9CnKJxv11siGqGsIDwjrU3IfNB02yRZyxDa
         XHJVS0fjbDMGH4GTcDsiEkmV9aNgnaAsQMgVf5hyItQu9oUlA4QRQLmY8S7IrmZaVYtG
         zh1SzSAWSooRWjmZvVlmGigxmvlTT8sTw/xLUfpJnr/0msTVaw3tuRBET7cQpPKg7PVi
         EqEz30C+u7UfVSJS1rxTiS772ZrmivYKruKtzWQzYrbC+wpEU9XfoPwhtEjH9WgCCya7
         mlzQ==
X-Forwarded-Encrypted: i=1; AFNElJ+sdDJHBzG5VqxCPiIjrtZf4nL4NO0SdqM44bUrchPM8vYPkfeZ85Op9kZfPsIytqaRHd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylo5OCFe6PBr8zGU9p7b8bQHBw/MSptfxWpAJNTZGjF59gTG+s
	vGiCZ7gGSKNN9BuGGr3B8jpnvEzPnKxWgK6/eyadxa4B+ZOW9pOCXBu3IjP+QXa/sOc=
X-Gm-Gg: Acq92OGo5ltBV22Cb3isoeDC38UQr1h/6AqKc1RhfU1y2j5A3miP9CcUdNiM+IIkBom
	QJuWu9DlxsTshdYX3f6ocWjlKRRaT3aFRfboAoRvabo0HlG4GtNH2Zf/dtFrRbnsn5aJynPf3FR
	HoM+etBOW/4ox2LZ0SxMpexJ/8ojO268pa+dAvEh0mbPk4ijCzVWEpmQ7Ie0Xr7BoECUjK51258
	DqvEkCaimvLUOUzznOd5TsarpmTI3WrE9ccNbShyy0G8WjqufOMlgCpudoomSOQgHWkD0EKG6pI
	mSh0nQUUZ43Llwb0ZHsq27O/gb1f6y92kLRixHZOrf7aAo6uSD93UKnrv7Jb20ATVru2NGsp3nt
	SBN8b9YOxmYknenDBvtWzImpooorCZpMb8DCbDNZWfREsRAEOyRBwJsZkmIl9zwuZE2qThpoMq6
	4IWBrvlXJGujrNOq0No0oQIGcpC6+Js3DcuPM=
X-Received: by 2002:a17:902:fc87:b0:2bf:1cda:29ce with SMTP id d9443c01a7336-2c163a1d5c1mr95186635ad.6.1780591548606;
        Thu, 04 Jun 2026 09:45:48 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e2e2sm62674235ad.49.2026.06.04.09.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 09:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jun 2026 12:45:47 -0400
Message-Id: <DJ0F0WFEP78A.1VV9Z7T71JJX5@etsalapatis.com>
Cc: <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: add test for arena vma split
 and fork rejection
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Ruslan Valiyev" <linuxoid@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <martin.lau@linux.dev>, <memxor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260603094428.2597058-1-linuxoid@gmail.com>
In-Reply-To: <20260603094428.2597058-1-linuxoid@gmail.com>

On Wed Jun 3, 2026 at 5:44 AM EDT, Ruslan Valiyev wrote:
> Verify that an arena map's mmap()ed VMA cannot be split with a partial
> munmap() or inherited across fork().
>
> Before commit 4fddde2a732d ("bpf: Fix use-after-free in arena_vm_close
> on fork") the arena VMA had no .may_split callback and was not marked
> VM_DONTCOPY, so a splitting munmap() and a fork() both succeeded.  The
> fork() case left the child with a VMA whose vml->vma still pointed at
> the parent, dangling after the parent unmapped and leading to a
> use-after-free if the child freed arena pages.
>
> The test creates an arena map, mmap()s it, and asserts that a splitting
> munmap() fails with -EINVAL and that the child of a fork() does not
> inherit the arena VMA.
>
> Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/arena_fork.c     | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_fork.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_fork.c b/tools/=
testing/selftests/bpf/prog_tests/arena_fork.c
> new file mode 100644
> index 0000000000000..f3d5218c9e071
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_fork.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <errno.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +
> +/* Regression test for commit 4fddde2a732d ("bpf: Fix use-after-free in
> + * arena_vm_close on fork"): an arena VMA must reject a splitting munmap=
()
> + * (.may_split) and must not be inherited across fork() (VM_DONTCOPY). O=
n
> + * an unfixed kernel both operations succeed.
> + */

Remove this comment, we don't frame tests as regression tests for
specific commits. The details about .may_split and VM_DONTCOPY also
don't matter. Something like=20

/* Make sure arena mappings cannot be split or inherited. */

The name is also misleading, this is two tests in one. It's not just the
fork test, you are also checking may_split. I think it's worth splitting
this into two separate tests, one for partial unmaps and one for forks.

> +
> +#define NR_PAGES 3
> +
> +void test_arena_fork(void)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags =3D BPF_F_MMAPABLE);
> +	long ps =3D sysconf(_SC_PAGESIZE);
> +	size_t sz =3D (size_t)NR_PAGES * ps;
> +	int fd, ret, status, err;
> +	void *area;
> +	pid_t pid;
> +
> +	fd =3D bpf_map_create(BPF_MAP_TYPE_ARENA, "arena_fork", 0, 0, NR_PAGES,=
 &opts);
> +	if (!ASSERT_OK_FD(fd, "arena map create"))
> +		return;
> +
> +	area =3D mmap(NULL, sz, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +	if (!ASSERT_NEQ(area, MAP_FAILED, "mmap arena"))
> +		goto close_fd;
> +
> +	/* A split of the arena VMA must be rejected (.may_split). */
> +	ret =3D munmap((char *)area + ps, ps);
> +	err =3D errno;
> +	ASSERT_ERR(ret, "split munmap rejected");
> +	ASSERT_EQ(err, EINVAL, "split munmap errno");
> +
> +	/* The child of a fork() must not inherit the arena VMA (VM_DONTCOPY);
> +	 * mincore() returns ENOMEM for the unmapped range.
> +	 */
> +	pid =3D fork();
> +	if (ASSERT_GE(pid, 0, "fork")) {
> +		if (pid =3D=3D 0) {
> +			unsigned char vec;
> +
> +			_exit(mincore(area, ps, &vec) < 0 && errno =3D=3D ENOMEM ? 0 : 1);

This expression is needlessly dense, unpack it.

> +		}
> +		while ((ret =3D waitpid(pid, &status, 0)) < 0 && errno =3D=3D EINTR)
> +			;
> +		if (ASSERT_EQ(ret, pid, "waitpid"))
> +			ASSERT_TRUE(WIFEXITED(status) && WEXITSTATUS(status) =3D=3D 0,
> +				    "child must not inherit arena vma");
> +	}
> +
> +	munmap(area, sz);
> +close_fd:
> +	close(fd);
> +}
>
> base-commit: 174914ea551314c52a61713b9c4bde9e42d48073

