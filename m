Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C323164C3
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 22:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780611718; cv=none; b=h0rsWG3FB48LQOhFABlAX9+4krTb65ZMlrnyod3iSyRMFI98nsXVXP2yV0DmO5IGOT2U59tIF6o8+g7H2rRGT2LPyM5avCSaB1UtdmDe7OMCeNkRqQCVfynUOxNlEtROriiLS8Hezv62MHNWPj1IkYLBN2JNJeaUhISf1rxEex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780611718; c=relaxed/simple;
	bh=M92VEL+kD9ZvkphJPUTwCJdAGwgX8oOg22MbXNNQ05w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ty27mcnoWHTzCMGkEmZDI0bb73A0aa/dtVh5vauNcx0Cr88uE1XIzRIQuNVEQ4yfynMD+xsjOIOxCc/4R4NTnjVg/bZq9KYv79lgoueTuj9rLlgaeXQaEDXUgGJi0r39cChrmKinz3KhQhTlV4R8Ql541jFZYm2TcxoFxOZ+UO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEW1NC0z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEW1NC0z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449C21F00898;
	Thu,  4 Jun 2026 22:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780611717;
	bh=fP0V+cFOGZqrPNh9RYwajpk+ZzS3wtExoXmtVt4e/UU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QEW1NC0zQgyKrhVBJez6KOEG1togSsOg7x800QaYi8NYkXXrMo55U0pb+yN0iw/dV
	 BMGl/rQRh+5cZpT6kQrJT7zRc2wv0Sim5/M5/lbyGKGFhKlbKEZXFffZPfxhCPYCra
	 dTL31wUlGBviDoWJx2JnIIQfHuoZy7OYS044MrweudALrBaQvRUdmfzn3uybfyOpCY
	 jO1GVHCidER196L+W3MNvnXgAhv2GIk+pp6mBKbZjaE7h9jDlUjtd0uvhTSDOvrcYH
	 KUxGNNXRpBtlDdHb+UGEqC+x4evS7ntbzmGXT7exTSHUDxCHns0GiFXVPvPx1gb8A7
	 09PFcfBBiAw4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: Use bpf_dynptr_slice()
 to read file dynptr in leak test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260604220904.1032145-4-ameryhung@gmail.com>
References: <20260604220904.1032145-4-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 22:21:56 +0000
Message-Id: <20260604222157.449C21F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The negative selftest uses an uninitialized stack buffer `buf`, =
causing the verifier to reject the program early and bypass the intended re=
ference leak check.
--

commit 2c90a2c3822df01ad7da448a72985505048a4374
Author: Amery Hung <ameryhung@gmail.com>

selftests/bpf: Use bpf_dynptr_slice() to read file dynptr in leak test

This commit updates the use_file_dynptr_slice_after_put_file test to
use bpf_dynptr_slice instead of bpf_dynptr_data, since bpf_dynptr_data
always returns NULL for read-only file dynptrs. The slice is read
rather than written to, while the test is still expected to fail.

> diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools=
/testing/selftests/bpf/progs/file_reader_fail.c
> index d5fae5e4cf9ad..3bb9e2612f8f3 100644
> --- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
> +++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
> @@ -87,7 +87,8 @@ int use_file_dynptr_slice_after_put_file(void *ctx)
>  	struct task_struct *task =3D bpf_get_current_task_btf();
>  	struct file *file =3D bpf_get_task_exe_file(task);
>  	struct bpf_dynptr dynptr;
> -	char *data;
> +	char buf[1];
> +	const char *data;
> =20
>  	if (!file)
>  		return 0;
> @@ -95,15 +96,14 @@ int use_file_dynptr_slice_after_put_file(void *ctx)
>  	if (bpf_dynptr_from_file(file, 0, &dynptr))
>  		goto out;
> =20
> -	data =3D bpf_dynptr_data(&dynptr, 0, 1);
> +	data =3D bpf_dynptr_slice(&dynptr, 0, buf, sizeof(buf));

[Severity: Medium]
Will the BPF verifier reject this program early due to the uninitialized
stack buffer, masking the actual leak test?

The verifier requires memory passed to helpers like bpf_dynptr_slice() to be
initialized. Since buf is uninitialized, the verifier will likely fail with
an invalid read from stack error here, bypassing the intended reference leak
check.

Would initializing the buffer (e.g., char buf[1] =3D {0};) allow the test to
fail for the expected reason?

>  	if (!data)
>  		goto out;
> =20
>  	/* this should fail - file dynptr should be discarded first to prevent =
resource leak */
>  	bpf_put_file(file);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604220904.1032=
145-1-ameryhung@gmail.com?part=3D3
