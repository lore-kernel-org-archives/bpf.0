Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01A438F635
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793921; cv=none; b=LFjJoCqn7a9xNES+V8IzbU01CjGuU+grQ6agIRp25LzOnPz5udugJd8bhIebNC19xt+uAkRVtCrIXy8sqyFHSnbBUTopg+/uaY3zNr3S/uiDz/MFlAtQxKtrF1lyguUXxPdRfrLCGrH61h3gXnf2dqca/M58dEjUoO7ZVaoA94M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793921; c=relaxed/simple;
	bh=eEc3oQBfJ7RWjGbafdmTdXgXwEtEDwQIhYB0GSigSGw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gd2AfGm9nOQBjzjPUi1XmJGNQy01EoB0K0E/ZErbJnWZbvENetUe3DW0nStiRXn6WBzlMfIZdkaXXj6xiizfghyMw8tFgiozMDsu6F9IWEWh5Vlvnkopa7zeqaM1BjE+1Ee7FlECPl9AHo55Sjd9ODpSll+obZ7weI0G/LvSlRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPP56rRV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPP56rRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2412EC2BCB0;
	Tue, 21 Apr 2026 17:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776793921;
	bh=eEc3oQBfJ7RWjGbafdmTdXgXwEtEDwQIhYB0GSigSGw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=QPP56rRVRj/bB+33KhTLeepAKsdB6X/r1dlVsDecIT3P/ImbfUmYV/95igIZfJasq
	 ycmlm2sUTJUVnP7ncMiwtvBuvz4YlMoAWIpcrGiBUodIBZI4nDi5EoSoltJ8nesHcf
	 KT/DrlkQXMONCyN0XEztOlq1frorBfriXDK3Cjy34CDEpgJqNAsRTH0q/tOnixeu6o
	 NuyvuQ6WhG6IEBZQrscEu8clxZ/Da3TO4sSof4t5O6QTlylWG4Blu+Zm/P9OFps3TA
	 Izb0nX6zKudDtk9SPfiP7x9DXcBhq13p4Tmru997c/S5Pmzs3RZ0ow+n8u35xzFYL5
	 cUlZMWoksYaAg==
Content-Type: multipart/mixed; boundary="===============1955441943998102017=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f6f35b4cb34724773df4e2f2d5014f64048931cd6eeb747875a84f3a9d1db4ed@mail.kernel.org>
In-Reply-To: <20260421165037.4736-7-emil@etsalapatis.com>
References: <20260421165037.4736-7-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v8 6/8] selftests/bpf: Add buddy allocator for libarena
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,song@kernel.org,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 21 Apr 2026 17:52:01 +0000 (UTC)

--===============1955441943998102017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/include/buddy.h b/tools/testing/selftests/bpf/libarena/include/buddy.h
> new file mode 100644
> index 000000000000..00e2437128ef
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/include/buddy.h
> @@ -0,0 +1,92 @@

[ ... ]

> +struct buddy_header {
> +	u32 prev_index;	/* "Pointer" to the previous available allocation of the same size. */
> +	u32 next_index; /* Same for the next allocation. */
> +};

In v4, Alexei Starovoitov asked for a mathematical analysis of the
memory savings from using indices instead of pointers here:

https://lore.kernel.org/bpf/CAADnVQKnHXg0YnuLvzfXjszMaqugpMNWD5=ipffWS4GVNg6rFQ@mail.gmail.com/

The question was: "BUDDY_CHUNK_ITEMS is used like NULL? The header is
u32 + u32. Is it really worth saving 8 bytes? Use two proper pointers?
How many headers are there? ... if everything is a pointer the whole
algorithm would be so much easier to understand. Is it worth it to keep
indices vs pointers? Please do the math and explain the savings."

The rationale provided in the discussion focused on ASAN effectiveness
and memory corruption detection, but didn't include the mathematical
analysis of memory savings that was explicitly requested. Would it be
helpful to document the quantitative analysis in the commit message or
code comments to address the original question?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24736048353
--===============1955441943998102017==--
