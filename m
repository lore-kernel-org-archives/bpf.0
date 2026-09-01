Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6B847AF5C
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260359; cv=none; b=ZEi5xODxdNIV5K+IXzTbOuoeNKQx9rzp3ofNlh3s6zxYAj6UlxESyhfGC92XybqEi/OLodcxhfC38B8G2NW0eLWmkn0qRGQx7+cHneDqLOT3B9Rhcx8PULZCccZyizguQgISC+jPPb2z1bqssR4QL4zcJDUZl9SBbsZ0JoezuCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260359; c=relaxed/simple;
	bh=IyJnlYVn0S0vurFvvrru/QhZbRnt45r+O7VG5I6pRgk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hQuwVMRREnDd85GKTb/QvCUqc+R/YaVAeJKIU5ZgRy5dyAkGajn8L8+BOV0lLEi8qo97v9AFse8grMJKAzGrbVasQfvz0T+0VcYOsRM6zCbFg3etvy/A3FwyNnW8nCVhaiFLCdcNIeXKHZpFSWuJqjhUF6EYsysWLJn+v9jYDtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyEKib9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyEKib9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C911F000E9;
	Tue,  1 Sep 2026 10:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788260357;
	bh=OSBtGMQ8NQJfaLRx6h0IduDG/46ndsJqv+VCnbjprRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PyEKib9xeGhQXB93n300ViJmsuIIhfkYFmUOspgzAWfCjG1hoOuhA9YESQwUi9zrX
	 S7nMXxzUMJiX/4XtAskh4YHEBOrm9na4B3RQib2Z9mfJhS0o1V76MfJT5YuwOs4Z1i
	 obXRgUqhDm42BXAbxTGPvj4LN/XC36QFvDs72SzxSLJ0U8FaSdQHdHuC8Xp6ectA0D
	 oMM3l6Q3wKL46Y94DzdYCBk3pYFjTzmetwfQ27XWKKpuNIwaWccJYKeRgXf5nP7rRc
	 W+jlu6pV1cUev465+UV/y6OfJk7MmWlOecB+ueUPX7GWYyFFTJbg5DxxYnNGnXybnk
	 SuYw3bqFM8kTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 5/7] selftests/bpf: Add netdevsim helper
 library
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anton Protopopov" <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831110934.241898-6-a.s.protopopov@gmail.com>
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
 <20260831110934.241898-6-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 10:59:17 +0000
Message-Id: <20260901105917.64C911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Busy loop in `recv_device_ifindex()` when `recv()` returns 0
--

commit a319bb58b65c3ac30499b9e1c997fd27ae962cff
Author: Anton Protopopov <a.s.protopopov@gmail.com>

selftests/bpf: Add netdevsim helper library
   =20
This patch adds a minimal netdevsim helper library for BPF selftests,
handling the creation of netdevsim devices with one port and one queue.

> diff --git a/tools/testing/selftests/bpf/netdevsim_helpers.c b/tools/test=
ing/selftests/bpf/netdevsim_helpers.c
> new file mode 100644
> index 0000000000000..fbed7442b2e8d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/netdevsim_helpers.c
[ ... ]
> +static int recv_device_ifindex(int fd, unsigned int id, unsigned int *if=
index)
> +{
[ ... ]
> +	for (timeout =3D remaining_timeout_ms(&deadline); timeout > 0;
> +	     timeout =3D remaining_timeout_ms(&deadline)) {
> +		ret =3D poll(&pfd, 1, timeout);
> +		if (ret < 0) {
> +			if (errno =3D=3D EINTR)
> +				continue;
> +			return -errno;
> +		}
> +		if (!ret)
> +			return -ETIMEDOUT;
> +		if (!(pfd.revents & POLLIN))
> +			return -EIO;
> +
> +		len =3D recv(fd, buf, sizeof(buf), 0);
> +		if (len < 0)
> +			return -errno;
> +
> +		for (nlh =3D (struct nlmsghdr *)buf; NLMSG_OK(nlh, len);

[Severity: Medium]
What happens when recv() returns 0 (e.g., on EOF)?

It looks like the len < 0 check is bypassed, and NLMSG_OK(nlh, 0) evaluates
to false. This means the code skips the message processing loop entirely.

Since the outer loop is driven by poll() which immediately returns POLLIN on
EOF, will this cause recv() to continually return 0?

Does this result in a tight busy-loop that consumes 100% CPU until the
5-second timeout expires?

> +		     nlh =3D NLMSG_NEXT(nlh, len)) {
> +			struct ifinfomsg *ifm;
> +			struct rtattr *attr;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831110934.2418=
98-1-a.s.protopopov@gmail.com?part=3D5
