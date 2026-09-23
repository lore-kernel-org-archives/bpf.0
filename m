Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB65543A7F7
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 05:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142010; cv=none; b=Qmo0GZqOG7yf+gw3lvl/s9VBf/R9dxQD6rOp0xH2Xyo5mY+GXn9Yd0Fw2w2xTtGQILqnYMmPgdtj619WLUEl53ye35RBIH3pVDX1It+oVnHQEToyffVwVHcWNGyPec/fVEOwbaefybJB248OINifcdIfAh1fbLWTOfc7jNa4U0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142010; c=relaxed/simple;
	bh=8xrTUaZJt4ehBDlyYRiu4bOJdsjjKmv1LL8g6AQeLiw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LJ4qCqmFI5FQcBnSqg6gtnca83WWyXgt5RrL01QjtSBRyuvlgSk624De0CCU3VlfztERYUEd1sdO2aamhzQ4tmQj+hP5XXfCvOZGstGCa0J6LVsv8uuDP+QM4BpFH1320iCjVhbScj1MyMVGDFsBYX8nZC0O0jsDaG2tZO0aDPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIkO0c/+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIkO0c/+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347961F000FF;
	Wed, 23 Sep 2026 05:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790142008;
	bh=8xrTUaZJt4ehBDlyYRiu4bOJdsjjKmv1LL8g6AQeLiw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OIkO0c/+IGutzN357lHIurdcFvi2Ut0exLRnmYGjn5pEMNetbAOquMEOv8fH8/PAf
	 IabEnlCjp2XGErIGLezVSKJioLA+dC+75qjgxD5oRRJw+l+X19p6RvVLI2Uj3dppes
	 MPjZbE1fNMFsIEPHPgBePvoXKzuqNB0CvIACjdF2d7+254hoDPHGQme8BRuQTRIJ9V
	 /zBM5GH+VerptiRln9b8ALkYnDHb8IIvmK6Ngu+gd3GF9QLMuhrNW5y/ARIQtoRclU
	 WJdk+t+lz5fO+l8BG3CLKBKxaX920wDBW/xRhlizF7/wtvswhu9B6RlRMjbLyXiYij
	 hZE37GdzQSpRg==
Content-Type: multipart/mixed; boundary="===============0004086667076322313=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <96d65d46ed2177c746de398cfe0f6a453724bfec68fe564908dae1db42537b89@mail.kernel.org>
In-Reply-To: <20260923050018.2426756-1-yonghong.song@linux.dev>
References: <20260923050018.2426756-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 18/21] libbpf: Let the static linker carry .bpf_cleanup relocations
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 05:40:07 +0000 (UTC)

--===============0004086667076322313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Taking them is keyed on the relocation type rather than on the section
> name, so any non-executable section could reach the new arm, and what it
> replaces is an unconditional refusal. Check what the refusal used to make
> unnecessary: a relocated section may be SHT_NOBITS, which extend_sec()
> leaves with no raw_data, and r_offset is checked for alignment only where
> the section holds instructions. Refuse those rather than write through
> them.

This isn't a bug, but could this paragraph state what the code does rather
than walking through the review reasoning?

The paragraph opens with an imperative ("Check what...") and describes the
thought process that led to the bounds check. The facts it conveys are
correct: an SHT_NOBITS target has no raw_data, and r_offset alignment is
only checked for executable sections. Would it read more like neighbouring
changelogs if it stated the conclusion directly, something like: "the
unconditional refusal also covered two cases the new arm must handle
itself: an SHT_NOBITS target has no raw_data, and r_offset is only
alignment-checked for executable sections, so both are now rejected
explicitly"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35821138073
--===============0004086667076322313==--
