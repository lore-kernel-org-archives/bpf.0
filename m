Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795473683;
	b=PdK3EgiO5a39etAzPrwjRiy/Y5WxOFWxdDRK5PZGnwJVt3Zalq4sM5RHwkKAsgaZPE5L
	 oqg8IfM3kRGU5e9dJ0hbWlByQGF4f+xiJJ2ICb8kvSh4TaRNhxFBVNjBXIqyVnj5HxwqM
	 uHpa9SkIiUqVROMDRaiRYUm5m1x21cq95t0G255XZYCjdnc/HYKMVj8nZuq5NRJaW8siA
	 nyuae02ap8seD5JhMxjebdX9CzaRKf+1PUK4C3lZH+CJ1vZStN341NYbPeDKT5zXVHhtt
	 pLGtTHzfrX1oH66ZmxswVoqi87FqipKJtTI6fuQ4ItMadl3IfUjEAhliXHQXtJg2hzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795473683;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jXpBuoAhrMkELQ+CqwNri9fVlaMeAZNuffJNBcM/tGM=;
	b=pRatZH33bv+a8QV2pdjSkwO8qeHPKXyBo1G4VsIiqtFqaqA8Ks87wedzYf/VVu3gopfd
	 vrW2m+frR7Ur1KQwa11+9mvCCuhX0OCyfVlQck/iJl0xAqt8yaNlDfr2GGzdXdXRSJZEq
	 5BXeAYTtiPNc7sW/YFZ/sNR0/rbIVBu+0ncpf0eIQhcfkzrcI0L18Zu3Fn5fP6TcH/Cwv
	 U29OlANEFRzOxMusKMMY8hBshjSruXFgxJEhoR47/x+OL5CEY+CPBI1E0zRX1nYo/9QyE
	 F/oF3vp0MAZm0q6doIIssqjr7JyO3BiQYtKLeyhRAQzY6797T5WVG5yFloHPB5OqN8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YSatK+oC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E8A606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YSatK+oC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367A81F000C4;
	Mon, 23 Nov 2026 22:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795473683;
	bh=jXpBuoAhrMkELQ+CqwNri9fVlaMeAZNuffJNBcM/tGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YSatK+oCy3Uw5oDHh+UZfd0FfIF+qNllbnRntf07yzf2YyI3z6SvVNri5/hv9K779
	 QNUhnvzb5ZrUFD0+oekDLYh3i6Z2S21lVUlii90jbBl9yeByRFNichuJfSw+eOEjvD
	 K9kIsvDEelFWj+g+0ywAl0I1izwXv8bbdqnTDt4RV2kEhcAhCgEDQo7bUhKVvOw0FG
	 ootuAN65VDx4+H/mNe3tJ69YvH54vUSM+WNG1HZbxmKZOvP/9aRXoZLXzideYZ3Sd5
	 lA5G8l1dsBd5yDydnZdbETs/QxJBxs7dr261hfHfSwHhnxOQyEIBpiSAUilktGS86+
	 oPywpTrcUr8bA==
Message-ID: <sashiko-outbox-230155@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 4/7] selftests/bpf: Test CO-RE relocation of
 BPF LSM program arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <almagui@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261123223227.745345-5-almagui@kernel.org>
References: <20261123223227.745345-1-almagui@kernel.org>
 <20261123223227.745345-5-almagui@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 22:41:22 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests/bpf: non-standard multi-line comment style in
  func_args_core tests
--

commit d8c54394186071b26020206d3532b117ff6287ba
Author: Alan Maguire <almagui@kernel.org>

selftests/bpf: Test CO-RE relocation of BPF LSM program arguments

This commit adds BPF selftests covering CO-RE relocation of function
argument structs and BPF_PROG_CORE() macros for BPF_LSM and BPF_LSM_CGROUP
programs using both standard and light skeletons.

> diff --git a/tools/testing/selftests/bpf/prog_tests/func_args_core.c b/to=
ols/testing/selftests/bpf/prog_tests/func_args_core.c
> index 1516ad13eaa26..f4cc859f20cdc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/func_args_core.c
> +++ b/tools/testing/selftests/bpf/prog_tests/func_args_core.c
[ ... ]
> @@ -110,6 +118,179 @@ static void test_lskel(void)
>  	func_args_core_lskel__destroy(skel);
>  }
> =20
> +/* An ioctl command that no file implements: the call fails after the
> + * file_ioctl hook ran, so whatever the programs return has no effect on=
 the
> + * process (unlike, e.g., an mprotect() that they allow). Its top bit is=
 set
> + * to check that the unsigned int argument isn't sign-extended.
> + */
> +#define LSM_IOCTL_CMD	0xb1f0c0deU
> +#define LSM_IOCTL_ARG	0x0123456789abcdefULL
> +
> +/* Run file_ioctl(file, cmd, arg) for an ioctl() on a memfd, only monito=
ring
> + * that call; returns the memfd's inode number, or 0 on failure.
> + */
> +static __u64 lsm_ioctl(int *monitored_pid)

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/func_args_core_lsm.c b/too=
ls/testing/selftests/bpf/progs/func_args_core_lsm.c
> new file mode 100644
> index 0000000000000..f4b9e68e45786
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/func_args_core_lsm.c
> @@ -0,0 +1,152 @@
[ ... ]
> +/* A hypothetical future kernel in which file_ioctl()'s file parameter
> + * points to a renamed struct: both variants are described with flavors,
> + * and only one of them can match in a given kernel.
> + */
> +struct vfs_file {
[ ... ]
> +/* The reverse: a program written for the hypothetical kernel, describing
> + * file with the new type and the current one with a flavor, so that only
> + * the flavored member matches.
> + */
> +struct file_ioctl_old_variant_args {

[Severity: Low]
This isn't a bug, but BPF coding style requires multi-line comments to
place the opening "/*" on its own line with the comment text starting on
the next line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123223227.7453=
45-1-almagui@kernel.org?part=3D4
