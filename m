Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7620335836B
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080031; cv=none; b=bgNpyAvWriyCDuCSdFtP4eyp4BpSVBeMvjC4DIr6R6FhIAGHL7SVf7fc9MJE137yqsJe8EuqZ4YoVI4A0UcJKoylEvpx5B60wL/VzTshmoIkMPf7tya6+ohcZ7+RWuqMqrIkGKQFUJ1ZT48xdPrvs1bmJt6zslrgxJ1Xz6/Yc7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080031; c=relaxed/simple;
	bh=Xb7cnqXHv7keX1+Z9JUuZcxBtzndpxL2WFJTZHV35y8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FLAlrCCACa9M0T75x1sTR1CiOxoRi88NtIc0zxjHEMjaV8lq9/lNdwr+Gpvr68Jo8lwrTZ+4iH1hV2ssECAZZ6WGEV0PTEImjbTkecYl5LYFbhvU4hhcvHnGCQvEOWPUqYS7zP7CoP0pkn7okH0wMKAlJZPoLC5A9UybC5BKj80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBLqmrKY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBLqmrKY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C2D1F000E9;
	Fri,  3 Jul 2026 12:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783080029;
	bh=gyLHlnvzkpAB6o9K0yF1oLnBsF3FXFQsPfSZnxqAW94=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FBLqmrKYzkjmof1KKKProLUmPQLkyUXVOhETl22mWJTsdKVQlVIqSJC9N7Q39AcR5
	 KQYxonfwvyi7+AJv5FIfzjtgzC4lMKY6oBFF19dpInf8KOFaWPe1Ehja9jIOgCrefd
	 +y25SA4t1MHqRvoIS0oIcnhJTQOrmRx8DXrR6nAeUrHqqm7jLq9DViZzQ6IYjjlN1L
	 7/Dx0L83GQ9kQyfSq4a+4lma6V6iiJE8DTOJGvL1HPL2b/V/XUwBGreweR0Ufj9tlU
	 xuEMTqrkdHGrviG6mqXEeq6/VCs+YwH5Vd+5HMGfrxJSihavRsyIU3O5QZ2UWKrnhL
	 8g+DL5NDN1XOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv6 06/13] libbpf: Change has_nop_combo to work on top of
 nop10
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260703114917.238144-7-jolsa@kernel.org>
References: <20260703114917.238144-1-jolsa@kernel.org>
 <20260703114917.238144-7-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:00:28 +0000
Message-Id: <20260703120028.E0C2D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Dropping support for the `nop5` combo in `has_nop_combo()` break=
s the BPF USDT selftests.
--

commit dc8c1772a19cbe96786096f839e442eb211041bc
Author: Jiri Olsa <jolsa@kernel.org>

libbpf: Change has_nop_combo to work on top of nop10

This patch modifies the USDT has_nop_combo() function to exclusively check
for an 11-byte nop,nop10 sequence, replacing the previous 6-byte nop,nop5
check. This aligns the detection logic with newer kernel support for faster
uprobe handling using nop10.

> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index 57fb82bb81b58..d2ecd3daab961 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c

[ ... ]

> @@ -604,14 +604,14 @@ static int parse_usdt_spec(struct usdt_spec *spec, =
const struct usdt_note *note,
>  #if defined(__x86_64__)
>  static bool has_nop_combo(int fd, long off)
>  {
> -	unsigned char nop_combo[6] =3D {
> -		0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
> +	unsigned char nop_combo[11] =3D {
> +		0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
>  	};
> -	unsigned char buf[6];
> +	unsigned char buf[11];
> =20
> -	if (pread(fd, buf, 6, off) !=3D 6)
> +	if (pread(fd, buf, 11, off) !=3D 11)
>  		return false;
> -	return memcmp(buf, nop_combo, 6) =3D=3D 0;
> +	return memcmp(buf, nop_combo, 11) =3D=3D 0;
>  }

[Severity: Medium]
Will dropping support for the nop5 combo here break the BPF USDT selftests?

The selftest in tools/testing/selftests/bpf/prog_tests/usdt.c still generat=
es
and expects the nop,nop5 combination for usdt_2. Because this function now
returns false for nop5, collect_usdt_targets() skips the usdt_abs_ip++
optimization.

This causes the uprobe to be placed directly at addr_2, overwriting the nop
with an int3 (0xcc) breakpoint, which makes the test assertion fail:

tools/testing/selftests/bpf/prog_tests/usdt.c:subtest_optimized_attach() {
    ...
    /* usdt_2 USDT probe has nop,nop5 instructions combo */
    addr_2 =3D find_instr(usdt_2, nop1_nop5_combo, 6);
    if (!ASSERT_OK_PTR(addr_2, "usdt_2_find_nop1_nop5_combo"))
        return;
    ...
    /* nop stays on addr_2 address */
    ASSERT_EQ(*addr_2, 0x90, "nop");
}

Does the test suite also need to be updated to generate and expect nop,nop1=
0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703114917.2381=
44-7-jolsa@kernel.org?part=3D1
