Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BB82BE7B6
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 05:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775194062; cv=none; b=VG3WOmk/SSUbs/9wGwUauKjoD9Pk57zBKM/N5MzgdB7sBqdLpX5RgQ/peCf0yVCbUiTyOJvh9oTsx9deaCeLeM5uxW5q+h1eMwnQpYQJxz/LexYtVgDkwt1ThvEO0OZKj//ulpb8i0CUrFJM4e316h8FOIhZXVBS4DjEnO6Uz3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775194062; c=relaxed/simple;
	bh=EcaVHuxv14wEZae8rzOd9vGO/MiTf4+C6TikfC3khlU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=guURE/sJEyh5gsmA52+42bPFJFhKXKE6lWMKAG4mUzbg+ElW7XGRoY/ieh45PjS3bgjo01ckKS+0bUdq3sMHZbsf9o27Pu3dff2Scyb6EiMSsXnPKekY5hbDRjSDFYk4VWlQUg/jbEnMYv9+31ghdZgRwYxIuV06FZQr42rO9rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amxO7Xlj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amxO7Xlj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01320C4CEF7;
	Fri,  3 Apr 2026 05:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775194062;
	bh=EcaVHuxv14wEZae8rzOd9vGO/MiTf4+C6TikfC3khlU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=amxO7XljQo+HB3hoZQa93JoebQ8j3DaUETfZd+XX5SM0NNmtK6kHQn4rg6t1csDEV
	 MnqE2IROrSFTnW+OR4HQt1yZ4m2a8emGRtu17QOQ5IudzouE4u7W2YLUXamiRoEqoE
	 CyfJ4tRcNd9VU1WVjGE4WWTTX21UBpbXFS3EatRo1hqUMDMeAXMnBzo60yKaCQtZN1
	 IF4AGQdOOdJP4b9PEh7lB+8LdjSjyQtRxkqHg0WpFs3RWD7k0k1tDcPn25WY2vuXS1
	 eQ9tJG1cBXWc1z2DeuEUCSkG3fAcAsnsnMFmuq+AlUH+AichkBRbE5r71Jrg3Ev4Bz
	 IJq8S9u6cZqXQ==
Content-Type: multipart/mixed; boundary="===============6850328440251220864=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <699d0715fb6fd7098a9f5be51b2ae6597bb0c0c802b61bd73ee1726f8cb2fd4c@mail.kernel.org>
In-Reply-To: <20260402221339.1614989-3-vineet.gupta@linux.dev>
References: <20260402221339.1614989-3-vineet.gupta@linux.dev>
Subject: Re: [PATCH v2 2/2] bpf, doc: Improve MOV/MOVSX documentation and add examples
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,bpf@vger.kernel.org
Cc: bpf@gcc.gnu.org,jose.marchesi@oracle.com,ast@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  3 Apr 2026 05:27:41 +0000 (UTC)

--===============6850328440251220864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
> index 96181565906f..c55628448898 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst

[ ... ]

> +``{MOV, X, ALU}`` has zero extension semantics (upper 32 bits are zeroed)::
> +
> +  dst = (u32)src
> +
> +e.g. w5 = w9

Should this be ``w5 = w9`` (with RST inline code markup)?  All the other
examples in this patch use double backticks:

  e.g. ``r1 = r2``
  e.g. ``r1 = -4``
  e.g. ``w1 = -4``
  e.g. ``r1 = (s8)r2``

Without the markup, "w5 = w9" renders as plain text rather than inline
code in the generated documentation.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23924712281
--===============6850328440251220864==--
