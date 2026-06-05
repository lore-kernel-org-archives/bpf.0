Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F212D3BBFD5
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 00:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619921; cv=none; b=sHM0pDyohBuldCQbaWFDs1VGFlvUOlOmpYI9P6YgtiTPY+PBwVktJTtFFGOfPKjmpHmgNYPTbUfsRGCRzx00Ga6kj6oO1TtWbP4st8u3eQW6GjUkfmDl8SrAwBrRCZfhJJhLNlPX8KZgoUT9Ivg3Rt37M4UbfHA8aXy1OoeOUng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619921; c=relaxed/simple;
	bh=/so1Crz0zEyB+W0Bd+JbfSXvg2teGKAtx+pXZXnGJaw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=b5jg4IbF/8ulZOkkjsBWqEpMkwLBgfdsRCsmHnilzhyda5j0ODOtkS0X3N3hP7HE8KoLOQ0H3tw/jAR0iWN/rNP7c/ZQPJW80L8ClN3T/3WA75hwz5CeUWULbcjExQd/XhWk+6VxZJk+Xxk2s4HMPLXqQV9+V/Kky5yzi+fULpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKW9M/BQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKW9M/BQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBC71F00898;
	Fri,  5 Jun 2026 00:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780619919;
	bh=dsGayWvo4L3IyU5zOj6q5B5i6JqQTXMhIvcRaTkPeMw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PKW9M/BQuNM1iSgcPVzpoyGplDrk51v0NbfyJB7A7HuPeKkZBAqIIwuloPVsz6AlE
	 E15ie0pr8MOqYxda13wdyRP/aKWa8QVw5pD90XpSJiKO9bPiFmxJA95vDOK9JoMYsL
	 JQkMJt6D/co3Kh4flgCVJsYGNUAHEND2AQhwvYWJHyvfny+4W8hUbIA5nTPcXZ/HBd
	 iR5M70he0gEH9AZ6qxxp9RvYhbENEO78jd1VEfEaSb+NW9YgrYkLhh6yzcBziCWkMp
	 Y3FFtt72fXMJ7Jc2ojUtOVNK0f+AFVJPUligMpOFAF7Vfkutn/CFmY7dnWCeW69BZp
	 /3ub9cno/i4PA==
Content-Type: multipart/mixed; boundary="===============5846888329804123041=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6f121f4e4a066d109b21dd8771b662840efc77c45770cee70dab08f910d07f5b@mail.kernel.org>
In-Reply-To: <20260604235016.20856-3-emil@etsalapatis.com>
References: <20260604235016.20856-3-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: libarena: Add spmc queue data structure
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 00:38:39 +0000 (UTC)

--===============5846888329804123041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_spmc.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_spmc.bpf.c
> new file mode 100644
> index 000000000000..e458dd330906
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_spmc.bpf.c
> @@ -0,0 +1,194 @@

[ ... ]

> +int test_spmc_remove_many(void)
> +{
> +	u64 val, newval;
> +	int ret, i;
> +	u64 expected;

[ ... ]

> +		expected = 500 - 1 - i;
> +		if (newval != expected) {
> +			arena_stderr("%s:%d expected %lu found %lu\n", __func__, __LINE__, expected, newval);

Both expected and newval are declared as u64 here, but they are printed
with %lu.  Should these be %llu instead, to avoid format string warnings?

This was raised on v3 by the Sashiko AI review but the line looks
unchanged in this version:

  https://lore.kernel.org/bpf/20260604235902.BDD141F00893@smtp.kernel.org

> +			return 1;
> +		}
> +	}

[ ... ]

> +int test_spmc_steal_many(void)
> +{
> +	u64 val, newval;
> +	int ret, i;

[ ... ]

> +		if (newval != i) {
> +			arena_stderr("%s:%d expected %lu found %lu\n", __func__, __LINE__, i, newval);

Here i is an int and newval is a u64, but both are passed to %lu.  Could
this print garbage, and should these be %d and %llu respectively?

This was also raised on v3 by the Sashiko AI review and the line looks
unchanged in this version:

  https://lore.kernel.org/bpf/20260604235902.BDD141F00893@smtp.kernel.org

> +			return 1;
> +		}
> +	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26987200618
--===============5846888329804123041==--
