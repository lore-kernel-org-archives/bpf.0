Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE3F1F03D9
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 00:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778719594; cv=none; b=BW3f6EAMa5FQeIiWtY5PjGwVYUBWneY4LQ7Ths6bcgqfNGdc7VLRjIsItLZeNa6zY1hU8FgjxSTrTtxFtxKada1Y9TvvS9jCgc+Tc0vln8CMce9PIBMhl6ghvkYM4FZb/qu68YoZLIQiZPDC/Z44ItVo29yBb+c/5010e4It6ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778719594; c=relaxed/simple;
	bh=zHb2t8ppCZ7lOfr5L3n58PlQwzEfoWLBGuAncUeRc1c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YG1v8MUVgoeNNv38DBpOm5yQWBkzY/ukc+Yzu94SQjBWRtdPiPcff89VpjTAZLu2n4XjUnyO2WaqCSBQyhhEHHCGrKvCrtIwvhFfWV2vu/xV6sj/rLTthjm1XyOATmLP3mvxWGoM5tjEPDPdOsJ9BmP5cYtLxOMa1lWzRl3dr3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4Qv2Hcg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4Qv2Hcg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA09C19425;
	Thu, 14 May 2026 00:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778719594;
	bh=zHb2t8ppCZ7lOfr5L3n58PlQwzEfoWLBGuAncUeRc1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=a4Qv2HcgJen868Pj55JTQxtNvwATz13BAqdNypkUPxevqnLXuVOn7+IlRIqhuIOiB
	 jmC5w4ZWGfv0XJCKSRWNhyyqUBtfjyl//mohIEZW/GEVkJizxaYBE3a64h3KlbtDV8
	 HPLdHXAj7syXwqfIJwtRkdjlzNtgFF4/qun+ehbF0QMboq+SpVaZboWIcAGdE+uyJR
	 fwUUCS8WD2Ca0EEoMoeCMiz1/9aoJiOurlQiBC+W170ftPKISszgGeY7MdTG0/NFVp
	 WMCrACDUkpjZlCsa9x0SDm4CD0Igt/g6hLVjncpLyXEFny/Sy2yx8pqzO0EKd8JOhk
	 52ovL7zo92AUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v14 6/8] bpf: Add syscall common attributes
 support for map_create
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260512153157.28382-7-leon.hwang@linux.dev>
References: <20260512153157.28382-7-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 00:46:33 +0000
Message-Id: <20260514004634.3DA09C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Race condition causing unrelated file descriptor closure and resou=
rce leakage due to failure after fd_install().
--

commit 37e50113e50fb4d6482363699239289046be6ff2
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Add syscall common attributes support for map_create

This commit adds common syscall log attributes to map_create(). It creates
a verifier log to report map-creation failure reasons back to userspace,
improving debuggability.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 2fa05ba8f1619..6600e126fbfb4 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -1611,6 +1632,31 @@ static int map_create(union bpf_attr *attr, bpfptr=
_t uattr)
>  	return err;
>  }
> =20
> +static int map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_c=
ommon_attr *attr_common,
> +		      bpfptr_t uattr_common, u32 size_common)
> +{
> +	struct bpf_verifier_log *log;
> +	struct bpf_log_attr attr_log;
> +	int err, ret;
> +
> +	log =3D bpf_log_attr_create_vlog(&attr_log, attr_common, uattr_common, =
size_common);
> +	if (IS_ERR(log))
> +		return PTR_ERR(log);
> +
> +	err =3D __map_create(attr, uattr, log);
> +
> +	/* preserve original error even if log finalization is successful */
> +	ret =3D bpf_log_attr_finalize(&attr_log, log);
> +	if (ret) {
> +		if (err >=3D 0)
> +			close_fd(err);

Since __map_create() has already successfully created the map and installed
the file descriptor via fd_install(), the fd is globally visible to the
process at this point.

If bpf_log_attr_finalize() fails (for example, due to an invalid pointer
for log_true_size), we attempt to roll back by calling close_fd(err) and
returning an error.

Could this race with a concurrent thread?

If another thread closes this fd and opens a new file between fd_install()
and this close_fd() call, wouldn't we erroneously close an unrelated file?

Also, if another thread dups the fd before we close it, wouldn't the BPF
map remain alive and accessible to userspace even though the map_create
syscall returned a failure?

> +		err =3D ret;
> +	}
> +
> +	kfree(log);
> +	return err;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512153157.2838=
2-1-leon.hwang@linux.dev?part=3D6
