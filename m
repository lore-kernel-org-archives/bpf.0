Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F5639C626;
	Tue,  3 Feb 2026 10:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113637; cv=none; b=mduVs0gONvB0bGVPpOM+WKGolaj445Rx9+U7v/G6n+ZNoaM4Efb7nyBqJOlCQbh5t4TXaznoQ8zR3NbrStjkwP6PCo80fYMksGHVmXS+9nEPOJmgDChjye65sI8iMYui38IWGuJx52TJozXa5T/C5yOP69ukC1YDHmbaVGbE+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113637; c=relaxed/simple;
	bh=7RY45F3AtE0pFYSZOeevgIoEdFw5H5YrhT+uYA2BmKo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EfSNJxw29ZdkY3LN0kXVb7i8qjZo93pNA3vAif421B9dgxDXvJ0aiHXR66AvqAkcJAo+Ey/MPqaapI0K4TcBIRDcfsfpI89JhKXcCFlXLPZmVgHfce4LeLKbppbCiFnJDDPDkbdSDsM2jWi8kOgv86c62VzEZoqXmqJ7j6BOcKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTHABszr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTHABszr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188B1C116D0;
	Tue,  3 Feb 2026 10:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770113637;
	bh=7RY45F3AtE0pFYSZOeevgIoEdFw5H5YrhT+uYA2BmKo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=nTHABszrwb9BAAk5F1gqXo0Ydp60EJtUag6DBhtRbwu8+b/tRfRmd1HdSOGjycELt
	 ag4PCN8ostsXX6ihtNG3YXqtRKE128EyOtbaK+gR9OlU6itCXkij9bvgXgV4t27tV0
	 1MsMNXL1T1MuYG6JTbYGeyz0PlsEgGdAEEuu6cI4omxPJsd4ofBnoc0yhjgA9IjpU6
	 aj6CoQYSeSZZfsSnS39jbnM+SKp+UU8sAmUOOABWdlkI313AEyaWDqF3W/jmx7QYD2
	 Kt0Mw/pfgj8kt/3Pnx63xOGucGfVRvWetzvxzaNbg/U4+bge28yZNQKBIODU4WH+AB
	 /zwzjqZm84Xzg==
Content-Type: multipart/mixed; boundary="===============4134041393424372776=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9de646e4e4d2fda0d4f0543b422439f7c1fcc121d4db2e38a28bf3a454b96d98@mail.kernel.org>
In-Reply-To: <20260203093819.2105105-13-jolsa@kernel.org>
References: <20260203093819.2105105-13-jolsa@kernel.org>
Subject: Re: [RFC bpf-next 12/12] selftests/bpf: Add tracing multi benchmark test
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  3 Feb 2026 10:13:57 +0000 (UTC)

--===============4134041393424372776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> index 3ccf0d4ed..575454e31 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> @@ -6,6 +6,9 @@
>  #include <bpf/btf.h>
>  #include <linux/btf.h>
>  #include <search.h>
> +#include <bpf/btf.h>
> +#include <linux/btf.h>
> +#include <search.h>

These three includes are duplicates of the lines immediately above them.
Were they added by mistake?

[ ... ]

> +	t = btf__type_by_id(btf, proto->type);
> +        while (t && btf_type_is_modifier(t))
> +		t = btf__type_by_id(btf, t->type);

The while line uses spaces for indentation instead of a tab.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21625440628

AI-authorship-score: low
AI-authorship-explanation: The commit shows characteristics typical of human-written code including copy-paste errors (duplicate includes), inconsistent whitespace, informal commit message language, and practical iterative testing with real measured results.
issues-found: 2
issue-severity-score: low
issue-severity-explanation: Both issues are minor code quality problems in test code: duplicate header includes and inconsistent whitespace (spaces vs tabs).

--===============4134041393424372776==--
