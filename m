Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794194053;
	b=VMSC9en9ei48zExfBj6OO+bFFBplzxuTB2RnxHfDrmAUZ4s2oDqDN1mc6RnS3dNTVClT
	 C+aK+SfM4RgCq7PhEUn5FYHcJNwNcxEJfoWB2bge6xMD6iqpDfdhZ0j1ACtiFZOjFZtxI
	 8WfE2240nAQZlb96tAMT20S0o9pGfRCV1rXMkwdRH5o6RBTE97tcDQV8a3DdnG0wtHZTb
	 reWjzc+HiDftN5So9onn+yCP2TobUwJG3nR53796CaleHS5WRHbKiM3azmmVG5XVyzp7T
	 6WOPSAQ8qi/8oNnb86DkpNqpl2Le16mui4cfZXWav9zxCMz0JFf15pgvaeap9QgmEPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194053;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3omd8EXgJPQAHEBwysqvnRrlkJX4hNo0IuRH7wLs2Q4=;
	b=Ahjqf0DsUprfodGEhSXJ5HBdcMV5AhuzahtvRoD8gbLmT/eTmu0w1H+D8l+8Jhx9skHu
	 w47wWeTNDUOhGjrm0Ace+K2Q/vNacjwkxR6CanTDkv+LVZGpiqQrXMUx0n7XllYUpQXLe
	 WkEuGTo2KMm9i0rrbx46FmNlUyYEFL6kQ50l4Y7IAe73k7yB3F3qpknyAQM5TL2vsx1tA
	 G6wlah+xS4vZSbb3iLFVqhkaW+99oKE5bZ8fHR6IwtLWONeFccNKx63vqzbYjK5kAK/lC
	 hkTrtX4wTrBl8DFk3Hajv4wb1z8teb9/IMQVAmrBeAg6PBEj7/8BQtDJdIGD/VpWSIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OPCttz8Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C14606A326
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 03:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OPCttz8Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B1A1F008A6;
	Mon,  9 Nov 2026 03:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794194052;
	bh=3omd8EXgJPQAHEBwysqvnRrlkJX4hNo0IuRH7wLs2Q4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=OPCttz8Y/qOXt2ORq9w2mOkyBRKUOc8HTRJaebDQ/uLqz4bTQYmrt6b/pXsqXRNmX
	 u4la5acHDnkIWHuTAL1OjVHr+lHbV0Jm4oekpHrzIDKFv/6SR0eQJLJBgn/3/qnXMY
	 v7hKNwgu5GsmMGPI9zfLZAgAYM/OuzvsoKgW6sMnva20cwvKvJW8DBjVIUpze10RPi
	 VwzfL+b3vfqV80lrWqfrNMVljdv9uARVeBmFq045tpwNx6eEQRFm3OYQtAKzUP4fkK
	 6IKmL5k5AfQsM7xWRGvkSlJ16fs/5LDOrx5qjKJF7t97eKctAwJpP93HvXaESW/A/M
	 Zn0IT77o2Ii4g==
Message-ID: <sashiko-outbox-204363@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Test user ringbuf backlog larger
 than ring size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ren Wei" <weir@nebusec.ai>, bpf@vger.kernel.org
In-Reply-To: <080cf00ad740b4cd9af71bfc6c9e9a57a6aef693.1793951856.git.rakukuip@gmail.com>
References: <cover.1793951856.git.rakukuip@gmail.com>
 <080cf00ad740b4cd9af71bfc6c9e9a57a6aef693.1793951856.git.rakukuip@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 03:14:11 +0000
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
- [Medium] selftests/bpf: backlog check breaks
  test_user_ringbuf_post_larger_than_ringbuf_sz()
--

commit 23d3f0e29a2def29eb8db69c2a11a7b7fed0b563
Author: Luxiao Xu <rakukuip@gmail.com>

selftests/bpf: Test user ringbuf backlog larger than ring size

This commit adds a selftest verifying that bpf_user_ringbuf_drain() returns
-EINVAL and drains no samples when producer_pos exceeds consumer_pos by more
than the ring buffer size.

> diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tool=
s/testing/selftests/bpf/prog_tests/user_ringbuf.c
> index 9fd3ae9873210..b455e35d616b5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
> @@ -280,6 +280,22 @@ static void test_user_ringbuf_post_larger_than_ringb=
uf_sz(void)
>  	user_ringbuf_success__destroy(skel);
>  }
> =20
> +static void test_user_ringbuf_post_backlog_larger_than_ringbuf_sz(void)
> +{
> +	struct user_ringbuf_success *skel;
> +	struct user_ring_buffer *ringbuf;
> +	int err;
> +	__u32 size =3D sizeof(struct sample);
> +
> +	err =3D load_skel_create_user_ringbuf(&skel, &ringbuf);
> +	if (!ASSERT_OK(err, "oversized_backlog_skel"))
> +		return;
> +
> +	manually_write_test_invalid_sample(skel, size, c_ringbuf_size * 2, -EIN=
VAL);
> +	user_ring_buffer__free(ringbuf);
> +	user_ringbuf_success__destroy(skel);
> +}

[Severity: Medium]
Does the backlog check tested here break the preceding
test_user_ringbuf_post_larger_than_ringbuf_sz() test?

test_user_ringbuf_post_larger_than_ringbuf_sz() passes size =3D c_ringbuf_s=
ize
to manually_write_test_invalid_sample(), which sets producer_pos to
c_ringbuf_size + BPF_RINGBUF_HDR_SZ and expects bpf_user_ringbuf_drain() to
return -E2BIG:

tools/testing/selftests/bpf/prog_tests/user_ringbuf.c:test_user_ringbuf_pos=
t_larger_than_ringbuf_sz() {
	...
	__u32 size =3D c_ringbuf_size;
	...
	manually_write_test_invalid_sample(skel, size, size, -E2BIG);
	...
}

With commit "bpf: Reject user ringbuf backlogs larger than total ring size",
__bpf_user_ringbuf_peek() rejects prod_pos - cons_pos >
ringbuf_total_data_sz(rb) with -EINVAL before reading the sample header:

kernel/bpf/ringbuf.c:__bpf_user_ringbuf_peek() {
	...
	if (prod_pos - cons_pos > ringbuf_total_data_sz(rb))
		return -EINVAL;
	...
	if (total_len > prod_pos - cons_pos)
		return -EINVAL;

	/* The sample must fit within the data region of the ring buffer. */
	if (total_len > ringbuf_total_data_sz(rb))
		return -E2BIG;
	...
}

Because prod_pos - cons_pos <=3D ringbuf_total_data_sz(rb) and total_len <=
=3D
prod_pos - cons_pos are both enforced first, the total_len >
ringbuf_total_data_sz(rb) check returning -E2BIG is now unreachable, and
test_user_ringbuf_post_larger_than_ringbuf_sz() fails with -EINVAL instead =
of
-E2BIG.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793951856.gi=
t.rakukuip@gmail.com?part=3D2
