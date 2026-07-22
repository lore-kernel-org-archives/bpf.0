Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7C744AB6A
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 05:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784696486; cv=none; b=mwY5759veBa08xokOL7zZ2wOx5qRS4qfbJeI8Y92cL68eS47j4koNk/q9IuWfN8hZUHuHCinhyZonxugDTWT4uY6v2mGHPiww1ccx6NXyn5NbONqzECa0M/95EKlMxKmXn8Hrisb7H35nntC87EcpOffo0MKA7RdBmOw+oZjVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784696486; c=relaxed/simple;
	bh=maXAhlBw0y9uiJDKP79FUMEtYlzYa/MSnJYpoQyMPLw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r8NNj7zq1gctXYsexgRjzTSgsLQFV0af9XLz4Zva4whcIv7IjmjWiWaEJwxOyaG2jAwPYZcjCe/mBtEIilN5N2fPyTqxKafNETph+rfAsheWCmu6Ok1gBEZnO5WPMJWq5uqd+t+p2qSyaPdoqswNRueyGk5GLJL+Ock6vFbjGeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dreH62ij; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dreH62ij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAFD1F000E9;
	Wed, 22 Jul 2026 05:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784696485;
	bh=psANTFA6ke1hNSxeBUxvGPieM7u5PEIAawhPstDcD4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dreH62ijj4HOeHNUNcUe8RPKxFE3o0cKueEdugm7I9kFBENHN78uTwUKCqnJNzA50
	 pDyp3Kr0y1KJ/BHlH7mXNYGJEZ8J/NIN24a06DrmBcpptcrub4QPmTcoGNBwgDtmJx
	 8CT6qzYXNk5HFSOVUsPW16fns9oAndOj5ZoKUsl4E0pYN/vwv1yvUbR/gG5fVzt1up
	 pqNzJ6zCyDhKF5KIS7OaOZ4KWFPohQYV98Q1pwGHQi8f02QrbjcBdiw5AiReXqLD2s
	 /ddIOAMqq30zno+Evv00gGi7ihd2QHH4jBfxyo1ZtImhlYDvDPLgEwQ/gd0LpIcqk+
	 YhAVulODyt57w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Test
 bpf_strcat,bpf_strncat kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rong Tao" <rtoax@foxmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_586BE1E837629801BE504D16D665994AF506@qq.com>
References: <cover.1784695085.git.rtoax@foxmail.com>
 <tencent_586BE1E837629801BE504D16D665994AF506@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 05:01:24 +0000
Message-Id: <20260722050124.ECAFD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] bpf_strcat and bpf_strncat are vulnerable to an out-of-bounds =
write (buffer overflow) via a Time-of-Check to Time-of-Use (TOCTOU) race co=
ndition when concatenating from a concurrently modified source.
- [Critical] Out-of-bounds write (buffer overflow) in `__bpf_strncat` due t=
o mishandling of negative error codes from `bpf_strnlen` when the source st=
ring lacks a null terminator.
- [High] bpf_strcat and bpf_strncat allow reading beyond the bounds of the =
memory object pointed to by src, resulting in an information leak of adjace=
nt kernel memory.
- [High] bpf_strncat unexpectedly truncates the appended string by 1 charac=
ter if the source string length is equal to or exceeds the specified limit.
- [Medium] The selftests for bpf_strcat and bpf_strncat do not verify the b=
ehavior when the source string is too long or lacks a null terminator.
--

--- Patch [2]: [PATCH bpf-next v5 2/2] selftests/bpf: Test bpf_strcat,bpf_s=
trncat kfuncs ---
commit 4c36dbcb540f828a7c99805567e0566a0ff526c6
Author: Rong Tao <rongtao@cestc.cn>

selftests/bpf: Test bpf_strcat,bpf_strncat kfuncs

Add tests for new kfuncs bpf_strcat() and bpf_strncat().

> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c b=
/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> index 412c53b87b182..2dbd1349689ea 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c

[ ... ]

> @@ -23,5 +24,7 @@ SEC("syscall") int test_strstr_too_long(void *ctx) { re=
turn bpf_strstr(long_str,
>  SEC("syscall") int test_strcasestr_too_long(void *ctx) { return bpf_strc=
asestr(long_str, "hello"); }
>  SEC("syscall") int test_strnstr_too_long(void *ctx) { return bpf_strnstr=
(long_str, "hello", sizeof(long_str)); }
>  SEC("syscall") int test_strncasestr_too_long(void *ctx) { return bpf_str=
ncasestr(long_str, "hello", sizeof(long_str)); }
> +SEC("syscall") int test_strcat_too_long(void *ctx) { return bpf_strcat(l=
ong_str, sizeof(long_str), str); }
> +SEC("syscall") int test_strncat_too_long(void *ctx) { return bpf_strncat=
(long_str, sizeof(long_str), str, 3); }

[Severity: Medium]
Is this test effectively validating the behavior of a malformed source stri=
ng?

By passing long_str as the destination buffer, the kfunc immediately fails
the destination length check (dlen >=3D dsz) and returns -E2BIG.

This bypasses the core string concatenation logic and leaves the handling of
source strings that are too long or lacking a null terminator entirely
untested.

> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/=
tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> index f65b1226a81a3..40583361c655c 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c

[ ... ]

> @@ -59,5 +59,17 @@ __test(-ENOENT) int test_strncasestr_notfound1(void *c=
tx) { return bpf_strncases
>  __test(-ENOENT) int test_strncasestr_notfound2(void *ctx) { return bpf_s=
trncasestr(str, "hello", 4); }
>  __test(-ENOENT) int test_strncasestr_notfound3(void *ctx) { return bpf_s=
trncasestr("", "a", 0); }
>  __test(0) int test_strncasestr_empty(void *ctx) { return bpf_strncasestr=
(str, "", 1); }
> +__test(0) int test_strcat_success(void *ctx)
> +{
> +	char buf[32] =3D "hello";
> +	bpf_strcat(buf, sizeof(buf), str);

[Severity: High]
Could this signature allow an information leak of adjacent kernel memory?

The kfunc signature in kernel/bpf/helpers.c defines the source string
without a size suffix or __str annotation:

__bpf_kfunc int bpf_strcat(char *dst, u32 dst__sz, const char *src)

Because of this, the verifier only guarantees 1 byte of memory safety for
the source buffer. However, __bpf_strncat reads up to dst__sz bytes from it.

If the object the source points to is smaller than dst__sz and adjacent to
other kernel data, couldn't this read past the object's bounds and expose
the adjacent data in the concatenated result?

[Severity: Critical]
Is there a Time-of-Check to Time-of-Use race condition here that can result
in a buffer overflow?

In __bpf_strncat, after checking the length with bpf_strnlen, the copy is
performed using the full input limit sz instead of the remaining space in
the destination buffer:

kernel/bpf/helpers.c:__bpf_strncat() {
    ...
    copied =3D strncpy_from_kernel_nofault(dst + dlen, src, sz);
    ...
}

If the source string is concurrently modified to remove the null terminator
after the length check passes, strncpy_from_kernel_nofault will read up to
sz bytes.

Since it writes to dst + dlen, the total written extent would be
dst + dlen + sz, which overflows dst__sz by dlen bytes.

[Severity: Critical]
How does __bpf_strncat handle negative error codes from bpf_strnlen?

When the source string is not null-terminated within the limit, bpf_strnlen
returns -E2BIG (-7). This negative value is assigned to the signed integer
slen.

The bounds check then evaluates to false:

kernel/bpf/helpers.c:__bpf_strncat() {
    ...
    if (space <=3D slen)
        return -E2BIG;
    ...
}

For example, 65526 <=3D -7 is false. The function then proceeds to call
strncpy_from_kernel_nofault with sz, copying up to sz bytes into
dst + dlen and overflowing the buffer.

> +	return bpf_strcmp(buf, "hellohello world");
> +}
> +__test(0) int test_strncat_success(void *ctx)
> +{
> +	char buf[32] =3D "hello";
> +	bpf_strncat(buf, sizeof(buf), str, 3);
> +	return bpf_strcmp(buf, "hellohe");

[Severity: High]
Does this hardcoded expectation reveal a truncation bug in bpf_strncat?

This test expects bpf_strncat with a limit of 3 to append only 2 characters
("he"). Standard strncat(dst, src, len) appends up to len characters and
then adds a null byte, which would result in 3 characters appended.

Looking at __bpf_strncat, it calls:

kernel/bpf/helpers.c:__bpf_strncat() {
    ...
    copied =3D strncpy_from_kernel_nofault(dst + dlen, src, sz);
    ...
}

If no null byte is found within sz bytes of the source,
strncpy_from_kernel_nofault copies sz bytes but overwrites the last copied
byte with \0. This inherently truncates the result to sz - 1 characters,
diverging from standard strncat semantics.

> +}
> =20
>  char _license[] SEC("license") =3D "GPL";

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784695085.gi=
t.rtoax@foxmail.com?part=3D2
