Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC58A44E67F
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 23:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687100; cv=none; b=owxk9w4ftA+Gdp36C/5yZ8MIBmLTVEBghahRaGvagPcalW+djbo4OlxgNGN8BQ+Mu5FAg0LsrOBdCZM5IMzB08ypw4fowL51rNU9KADqQId+qV6MhPMc5yM8JswEJfEqcR3OlMLvycWUiiKnKwZgWZwkgO9pr7tv8TRNs+sq32I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687100; c=relaxed/simple;
	bh=zkfoNZXC2zGfMZBZkeGRwmVRJrkTZ0sW0g7/ZuTtulw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cSyqUxb2EyejI/zkaPrHYHQd1gAJ+tSZVHVDizbJoQ+maUGJVNErIe6SBh3PUO+BSJkPH0M7JQtc4tXq64yK7eh0dK/nipY3y8q9ddLx5oe6+K9oc2zIQS8s4PgByvyJ9T+GmZJRbOFBHNlDeKzQBrExHQgDm9+Tu5D0LbzYIJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZ19hHW3; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZ19hHW3"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb751so122331a91.2
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789687094; x=1790291894; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EoO0OkN/jslXUgxYTgXk/0EbzapqFPuSyFnW9vyXGbU=;
        b=hZ19hHW3i1FRqSgub8OVqbI1SLU+zsoP+Jjwk3mFI/782BK2J7A5nFnByW9iz8bvL+
         3opfj7PM1F9n4LZQZbWfxGXKlvuv7YfnDBGvDyN6IEzRDwMDGfdIE7r2ESqWV+XvlG4P
         Kv2SPQiKqp0tUEQ/3RYDj6aTPe0VUp7ul+ru7rzZ2vDWBOCU2/Orx2Fko3wA5Lq693DI
         BznVGghSuck9ZMfRrIrtEBZEaiEG4KcMvo2H5UWAr7sAhCVUSWGv63BjRzBMLc/0qr2Y
         dqCzPPV30kg4OnT0NTw9MUfqWlzRoGyZXi28yyBCalq0SL7UKH3c7al2r56QjjfAGhbg
         UuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789687094; x=1790291894;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EoO0OkN/jslXUgxYTgXk/0EbzapqFPuSyFnW9vyXGbU=;
        b=iuKdBiAjeLO0AorjVTT+kpVv0iwnFEPjl3XxFGlM7WMxEzQIVxhj+CGTvAFGVoCCSO
         OkZj6P8+A/axokG2Jvaj4zhC7u3CP522wUsZJvWOFjyr2EbzF3TPJ+0XN/ggSGs6ou/l
         DTWjM7eziGYxWYst25E9+EWs9yMJ00FfYNPAGD6gi/YMaWf2X+upZ6UzK1Y3se7dGyyr
         bovL3pK69nSP6C7F6W6uxnPf6N21FPoyITCbgwmbno7pPho9OGlXZLJPYOnO9INlnmqx
         lsULZoNrRJAu6UTQNm7UPupcf//qm/ZTToILT16C/wKA6WfzZWTj50/EjhUfuEPxlw/O
         z0zg==
X-Gm-Message-State: AFuF++m/xOC/893MIKVFGXaxeoGjKHrTyTRlUOHuLS+BaiKio3Vzeb5j
	t0cVFhxUf5HV3svlQgRkKhXmzSufkcF7kx5wQt2LyRAI7RbBQeeuAw9O
X-Gm-Gg: AYBFou1cv3QYUAHeNqnqATvrv3SlFABPeIMcJ2pbiDvCKBBao0Ea7dwvx+D09cQKwla
	0VNDdqqeiKOuS8RFD0Kz9wmlPFUx9nwQ0v6x2K33w1Hr0nIs391p9C5Nf4FXsBHc1A2J/Md3APQ
	pOm9cBF1/gEGKJZK7nV8upKpWfVhrS7UZ3CBLx7mtu1TupcDyHNJAPJlBzvlysBEhu+wotdQCKs
	fSsz9HXB2HdxTX4lu8/cbtz2ISdZIaU0gpr2llbPOAvYD2DtWQ4REREv+TXSO4XUPWIdcdhuMq3
	fDdAIHycX4672r64UMTlREQU1BaTTBDKDABM0Qk/zmHO0TIPaKqHDAbV58BRdg3UdW1P2QLORh9
	25SH03hWirxL+Pq2tU7IOP2pCIlyx/vezgiggldS4q9q7k8tx+nlr0REcqMCXlQUPuHQnl+mEJR
	8tPUJYrCozPnSB4lfCLiCX6bhOCvYWF1HfVVZicIEKiCLvRUgG5lhjKY98Wufgn0tNa4Uo6bzgw
	WcFTIhNFNrc3IUS8uYy1JVfFhEy3n4bSoihLq3oVYkDuxWT/teRahh1NQ==
X-Received: by 2002:a17:90b:2f06:b0:39d:f18c:1ad1 with SMTP id 98e67ed59e1d1-39e54d388e5mr2380826a91.3.1789687093616;
        Thu, 17 Sep 2026 16:18:13 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c47a:decd:950f:5c9d? ([2620:10d:c090:500::7:463c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5af4f0bsm21283025eec.24.2026.09.17.16.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:18:13 -0700 (PDT)
Message-ID: <f52fa67478afad8ead28ff3be59dcd1c2590616a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/4] selftests/bpf: Test btf_dump rendering
 of decl_tags
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: bpf@vger.kernel.org
Date: Thu, 17 Sep 2026 16:18:11 -0700
In-Reply-To: <20260917012037.1396254-4-ihor.solodrai@linux.dev>
References: <20260917012037.1396254-1-ihor.solodrai@linux.dev>
	 <20260917012037.1396254-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-16 at 18:20 -0700, Ihor Solodrai wrote:
> Cover the decl tag rendering the previous patch added. One subtest
> builds a BTF with every shape that renders, plus two that must not:
>=20
>  - a named record with both forms of tag
>  - a typedef'd anonymous record, whose attribute precedes the declarator
>  - a union
>  - a record that also carries the derived packed attribute
>  - an anonymous record inlined at a member
>  - two records whose tags are added in reverse target order, which is
>    what pins the sort: without it the earlier record loses its attribute
>  - attributes on a var and on a func, which btf_dump never declares
>=20
> A second subtest appends types and attributes to a dumper that has
> already run. Its last phase adds an attribute for a record emitted two
> dumps earlier and checks nothing is rendered for it: an attribute is
> part of the type, and btf_dump emits each definition once.
>=20
> A third covers members. A member attribute and a record one share a key
> in the index, so it checks they do not leak into each other's position,
> over a function pointer, an array and a bit-field - declarators the
> attribute has to follow rather than precede.
>=20
> A fourth covers typedefs, including a typedef of an anonymous record
> carrying three groups at once, binding to the member, the record and
> the typedef.
>=20
> Switch test_ctx__dump_and_compare() to compare_text_to_expected()
> while we are here.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  .../selftests/bpf/prog_tests/btf_dump.c       | 343 +++++++++++++++++-
>  1 file changed, 342 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/te=
sting/selftests/bpf/prog_tests/btf_dump.c
> index fe04a955d46c..6c031e83dad3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> @@ -224,7 +224,12 @@ static void test_ctx__dump_and_compare(struct test_c=
tx *t,
>  	fflush(t->dump_buf_file);
>  	t->dump_buf[t->dump_buf_sz] =3D 0; /* some libc implementations don't d=
o this */
> =20
> -	ASSERT_STREQ(t->dump_buf, expected_output, message);
> +	/*
> +	 * The mismatch has already been reported, so this only has to
> +	 * register the failure. ASSERT_OK() would append a stale errno to it.
> +	 */
> +	err =3D compare_text_to_expected(t->dump_buf, expected_output);
> +	ASSERT_EQ(err, 0, message);

Nit: Every caller of the compare_text_to_expected does such ASSERT,
     let's embed the assert in the function and avoid the above comment.

...

> +/*
> + * btf_dump indexes decl attributes incrementally, only walking types ap=
pended
> + * since the last dump. Check that attributes on types added to an exist=
ing
> + * dumper are picked up, and that one added for a record that has alread=
y been
> + * emitted is not - btf_dump emits each definition once.
> + */
> +static void test_btf_dump_decl_tags_incremental(void)

Nit: I'd drop this test or made it a part of an existing one (w/o the s3 pa=
rt).

...
