Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B3535B633
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 08:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512917; cv=none; b=hkSiAED2eyVIUrmKQVKwPXRcK0yAH9w7VkqYB2R0iOpHyTgg++zdO0mel/9EWZc1hR4kKJElFA42Fv/ezhJtB7r9e2wEWuCYo41Kz+vsPOCsRazAobN+VEdBpbUKcg5Zu7unrEtQBvyBfey/b5D012av1jJqwk77ncmyfyKXq4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512917; c=relaxed/simple;
	bh=odoMs+6u/VJgd9gpFfUtbUcAs6DFQjZj2OJHAc8Md5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NvHcgWzkwPnxoJu4CwZ4v36khs8pgCgC8w6C6WraL5mFve7YIReswFcKH9D5Xn9dK/eIHqJsd1juk3hgKL+8rLRNVBjoHHKGezF2Vi8Tlfet6s7/kIcEm9ZI7TTCsko+dm1g33ofnyQ+8YWlk0ocAAmh1gOPmevtLB5f228kmjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVl/ZXlp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVl/ZXlp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECDA1F000E9;
	Mon, 15 Jun 2026 08:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781512915;
	bh=odoMs+6u/VJgd9gpFfUtbUcAs6DFQjZj2OJHAc8Md5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HVl/ZXlpEN+Xg7rj0LB0BOzv2dC1McCQPDhFcYkFdI9WLfhAkT4w8YpX7WReB9ND8
	 2KxAYPhisNRSU2L7LraBYC77giuI1ci6T5gUrJ9el4hRYaIIcRFypzfZuW5zTUODfk
	 7RFqVOJ6GgW4RoGzj+DNCP0YSg1PeOWonAQonnzt13SqSBlvQ3ZVO1k4H4Qa1wdDus
	 E5iZkf35Vto/6y5FaaEyaomH/mU3RTQoC3hap7UdzcIc3gJg4qM7x9uebavtPP6huI
	 CPPCIIogBZyXRxe0DE7F6m0INzz6onnhCNYTzv7ytIkloVGxlPXprLvZQDGopuY8wa
	 V/V0EJtS0E7Ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Cover dynptr probe-read kfunc
 capability gate
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260615-f01-07-dynptr-probe-read-cap-v1-2-e626cd61a381@mails.tsinghua.edu.cn>
References: <20260615-f01-07-dynptr-probe-read-cap-v1-2-e626cd61a381@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 08:41:55 +0000
Message-Id: <20260615084155.8ECDA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message claims to declare explicit kfunc prototypes l=
ocally in `dynptr_success.c`, but the patch fails to include these declarat=
ions.
--

commit d3deda1bfd50e0af66e0dced005423edd99c0d03
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

selftests/bpf: Cover dynptr probe-read kfunc capability gate

This commit adds selftest programs to verify that the nofault probe-read
dynptr kfuncs fail with -EACCES when called without CAP_PERFMON and
CAP_SYS_ADMIN. It tests the policy boundary for these kfuncs using
capabilities.

> Add focused dynptr selftest programs that load socket-filter programs usi=
ng
> bpf_dynptr_from_mem() followed by each nofault probe-read dynptr kfunc:
> bpf_probe_read_user_dynptr(), bpf_probe_read_kernel_dynptr(),
> bpf_probe_read_user_str_dynptr(), and bpf_probe_read_kernel_str_dynptr().
> Declare the dynptr kfuncs used by this BPF object locally in
> dynptr_success.c so the dynptr BPF object builds with explicit prototypes.

[Severity: Medium]
Is this description accurate for the included changes?

The commit message mentions adding explicit local declarations for the dynp=
tr
kfuncs in dynptr_success.c, but these declarations do not appear to be
included in the code. Were they accidentally omitted from this patch, or
is the commit message outdated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-f01-07-dyn=
ptr-probe-read-cap-v1-0-e626cd61a381@mails.tsinghua.edu.cn?part=3D2
