Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE28247291
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785794783; cv=none; b=QSYF/Z2ha3VAVmDwCnRIor1tiyFhw05cbF7DxXZr/su85nKeHerz16Pm0l9TJvD/Oe0Oiqzx0eqmleHJBBPxVvWyuE21AJXeOjgDdWCS7gwrfA36yZw0m3MLWqwIdNMcI6Yi6D5FEtWNAobownuyJPxxoMclvVHtkh7PyQJ4ZiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785794783; c=relaxed/simple;
	bh=an0OrCmEvTWRpAw8OOt/8vepS430WdEjS8DSjBjzgXA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qvFJLhAE1PxR7QqrBVxd98nhIVI7yGa1Cf2hTk54fyzG3jatPzkw47qq+nK/eE11c/y8JQI1s57mJcHbZCyjPEh3ZYhCVQu1bMzh9bXLm85FcT+Iuho3ksv5s2DYAL5UwIn427NMJsxR88Exb1I8IBnUuwYriSbyVpY6h25d1cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQ1qK6LR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQ1qK6LR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7785F1F00A3A;
	Mon,  3 Aug 2026 22:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785794782;
	bh=BwFQDT2UojUztKvV4vJQWCfr0/rnNw2ejNDJG4/80Kc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WQ1qK6LRBzJfq8depz2NkR2UG1i6S2TGPJxdr0IpUH/q0TDss/0ijRSv6mPHVyseA
	 Be4NaGWZ6b9CbFkFyM18lD3uGt1GO+fYtJCk0DD5sbaGoUOc37zHGJjFkrkyVLhSER
	 2jVe2ZQHQM56hlqplobevTStjdWBFbTvgeo2o6oUj7NZ1JY+txvxPQIaWtD/D8YKLr
	 wXRjl7PrxaUvEdLKY5saqnpvnfgg3IV42OxIPx5Ev4/Z1qudbmP+wlojiJev7LUNjj
	 F9Au5PmTnKLfp7fLwRXkKrPfl55K+l1UfwsS8nARgcUA100U77D4l/ttfiSwFaAYLV
	 MMyemFt7w9N/g==
Content-Type: multipart/mixed; boundary="===============1103112330644507693=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <55dbe83f00c89646b6abd5b3fa35783a8601cbc6b380fb856bf53490e35faf49@mail.kernel.org>
In-Reply-To: <20260803210149.296496-13-jolsa@kernel.org>
References: <20260803210149.296496-13-jolsa@kernel.org>
Subject: Re: [PATCHv3 bpf-next 12/12] bpf: Avoid changing callchain in bpf_get_stackid_pe
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,qmo@kernel.org,chen.dylane@linux.dev,info@starlabs.sg,contact@arnaud-lcm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  3 Aug 2026 22:06:21 +0000 (UTC)

--===============1103112330644507693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: Avoid changing callchain in bpf_get_stackid_pe
>
>     There's no need to modify the trace object bpf_get_stackid_pe, we just
>     need to pass the needed callchain length in separate argument.

This isn't a bug, but should the first sentence read "modify the trace
object in bpf_get_stackid_pe"? As written, "the trace object
bpf_get_stackid_pe" parses as if the function name is the name of the
trace object itself.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30854471987
--===============1103112330644507693==--
