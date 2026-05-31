Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9BE4A35
	for <bpf@vger.kernel.org>; Sun, 31 May 2026 00:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780189173; cv=none; b=tKfFjCu9cK/BfhfKIRL3o7oozR3XVV4QqJhitVtvN1IcEvdJarhbaPNm8ogZDpkEZatxHYmVw1BmVZ5y5Kf86xQWIkKCNr1dLAg0HnEGrt6TYAxvfUim8Nd+BkXdc5oQ9HU2Y/JXiIoZfI/NtanbjbVENyJeOX1z/wXUHfLemiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780189173; c=relaxed/simple;
	bh=0GWWatQvPRQp+TwC5XFF7JbSe00DO/uAwMMOKwzL/Cc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ktryr9uGEVRrCAMQg0F+oTsZBGU+LgMlacvUp7uJ2Odgzf3zzQgvkltxIyuCT6nOc6tXHOcsmVHonOGkf1oqnKMHqvXOBV/VTyYEqyhYFmIxlP5otmNXjNUlNUwcStOUf3UFNQVErzSWpuhP1AgHvR8jVwK5TbQN6MDB8aMn/1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwBrtmsN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwBrtmsN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F201F00893;
	Sun, 31 May 2026 00:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780189172;
	bh=eJiSiggoopalM3ypSY9MQzdsL9E1tn3fqcXjXfMe9bA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kwBrtmsNOAjGp8oJDmkE+/4gKRITadHWqiMvOE/sxfanssZ35SECvLxfj9LDbU43w
	 4PH2KFxi2okEo1aqFJhTjOMVJZG9IpzVfXHxyQmghu+oR6u7rfVGKIY28YIMT6vh49
	 //gT8V6xY4a3V/W9OXQ42KMIPfpZAZuuU1bdjQaRWHFXR5NutlNsqXUvhL/26Eoq2/
	 rAJ8kqZtWkfBVsU0Ww5V5MhVj3BL8ywUWkYaU0XPxnXh5hC8LpR/THwzoNKDR0uNxY
	 XrEbx+7rO3V20D/F9rbiFf+FC6Grksplo1198Sz95R4x4rONVQ6Jhijb24XUAHhbWA
	 XBuXiElQlzB6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: reject BPF_PROG_QUERY with short
 uattr size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuyang Huang" <yuyanghuang@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260531004748.3567875-2-yuyanghuang@google.com>
References: <20260531004748.3567875-2-yuyanghuang@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 00:59:31 +0000
Message-Id: <20260531005931.D4F201F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The patch unconditionally rejects BPF_PROG_QUERY requests with=
 a smaller attribute size, breaking backward compatibility for older usersp=
ace applications.
- [Low] Returning -EFAULT for a structure size mismatch is semantically inc=
orrect.
--

commit 205b70f382d21dfafc18f8275384ff0f06e59f6e
Author: Yuyang Huang <yuyanghuang@google.com>

bpf: reject BPF_PROG_QUERY with short uattr size

This commit modifies bpf_prog_query() to return an error if the user-provid=
ed
attribute size is smaller than the offset of the query.revision field. This
aims to prevent an out-of-bounds write to userspace.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 9e91fb2fb492c..4dbf53e81a38c 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4719,8 +4719,10 @@ static int bpf_prog_detach(const union bpf_attr *a=
ttr)
>  #define BPF_PROG_QUERY_LAST_FIELD query.revision
> =20
>  static int bpf_prog_query(const union bpf_attr *attr,
> -			  union bpf_attr __user *uattr)
> +			  union bpf_attr __user *uattr, u32 uattr_size)
>  {
> +	if (uattr_size < offsetofend(union bpf_attr, query.revision))

[Severity: Critical]
Does this unconditionally reject older userspace applications that pass a
smaller uattr_size? The BPF syscall generally maintains backward
compatibility by allowing older binaries to pass smaller structures.

By rejecting the call entirely at the top-level dispatcher, wouldn't this
break ABI for all attachment types (like BPF_FLOW_DISSECTOR), even if those
specific handlers never attempt to write to query.revision?

Could we instead pass uattr_size down to the lower-level query handlers and
conditionally skip writing the revision field to user space when the provid=
ed
buffer size is insufficient?

> +		return -EFAULT;

[Severity: Low]
Is -EFAULT the correct error code for a structure size mismatch?

Standard practice usually returns -EINVAL (or -E2BIG) for mismatched or
inadequate sizes. -EFAULT typically indicates an invalid memory address
during a copy operation, which might mislead userspace developers trying to
debug their applications.

>  	if (!bpf_net_capable())
>  		return -EPERM;
>  	if (CHECK_ATTR(BPF_PROG_QUERY))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531004748.3567=
875-1-yuyanghuang@google.com?part=3D1
