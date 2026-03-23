Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364C52AEE4
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774255837; cv=none; b=Dzu1bmI31E1jgY7MBlqCNW6UxZhvCNWyVOSU5KjtVzqy0Dv6tJ2Ma55+yrOufL5w19D/x8GSJGqcD9oToyUuPMHAruKqhOps+sOQHHuRWlLJQc/mH6OgbW6xaCB7wQlD8ojy+Q5DbReUBe3YQ0dBtFzBiqBk+fXZd9lYMyiJ4xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774255837; c=relaxed/simple;
	bh=4CTMzliTTsD5RZdAnRsCFxK3Y8LK3u8NP1uXpkXpzy4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lezLL5IdxsE1XqmcI1+IyhpAYU6UCTnxXKTfIWVhj4FpqFVqTrC0y44YK3VgHlc4MR+kvbMI4Hs+HJi+9VlM5+M18AuXjpn7IU/XQ9xLbveHf2TT3M+uWrNkpueOhRfWCUu5sgd23PrEgO6sfNHKL/caDyfzHh8iK1RfS1zyv1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATjs063s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATjs063s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B730C4CEF7;
	Mon, 23 Mar 2026 08:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774255836;
	bh=4CTMzliTTsD5RZdAnRsCFxK3Y8LK3u8NP1uXpkXpzy4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ATjs063s8RLK3LesGl2dgptaJMoKtEgNIlzcKW6V1UVsX9m/YF97HIiqNhtl99ili
	 PDKoh/E9CP2fF+GB16BewUTkCVxL7xQdnGKe/4kSrFm3MqidQuuxcyYLz2nRYlF1ty
	 TDsO4Nr9ysyR1GRYoS2LkD4n8MGmnVXSKjo0mB6FLg7R8c1iTB2Mtjl1HBkGgf41mZ
	 q+NX0PYwgqrV1CZH3Tiei+s6DFKzUcpDy0W2Rn9RBuN4/3SFdMrpKKFLutJm5YqcxX
	 EAxNgFD8v3CW7hUAMH+XYstBJ+5TTwhD20mQJfqpg9BfaOJOugnbf1d7WNqv2rnjAP
	 /PFppSmAaQcig==
Content-Type: multipart/mixed; boundary="===============8786716234742461791=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <260b014616f8d382083f8b7b93dfe03c1f9a218c0c8dae90f284cb870ab4d6c9@mail.kernel.org>
In-Reply-To: <20260323081748.106603-3-tangyazhou@zju.edu.cn>
References: <20260323081748.106603-3-tangyazhou@zju.edu.cn>
Subject: Re: [PATCH bpf v2 2/3] selftests/bpf: Add test for large offset bpf-to-bpf call
From: bot+bpf-ci@kernel.org
To: tangyazhou@zju.edu.cn,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,tangyazhou518@outlook.com,shenghaoyuan0928@163.com,ziye@zju.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 23 Mar 2026 08:50:36 +0000 (UTC)

--===============8786716234742461791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/call_large_imm.c b/tools/testing/selftests/bpf/prog_tests/call_large_imm.c
> new file mode 100644
> index 000000000000..300d413c23c1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/call_large_imm.c
> @@ -0,0 +1,53 @@

[ ... ]

> +cleanup:
> +	call_large_imm__destroy(skel);

Is the closing brace for test_call_large_imm() missing here? The
function opens with '{' but the file ends after this line without a
matching '}'. The v1 patch on the mailing list included the closing
brace, so it looks like it was accidentally dropped during the v1 to
v2 rework. This will prevent the BPF selftests from compiling.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23427947087
--===============8786716234742461791==--
