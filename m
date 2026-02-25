Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF1C36AB6E;
	Wed, 25 Feb 2026 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014207; cv=none; b=WWZNiunNjYZ6fblfU/z+TzPpFSccjL+TvW+W7heZzWnZpqJ3MdNm8iZIRuSRlwtyupmsfPzjMfsabt+6xigKiHJQb9cP2a6dYOMHJjEUzZP00Hh+++wmL5/1yUabCtBnLJwqYQRTyMeIsfcM0kE5+9FeyRlcNAEJ+hjxWaBovcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014207; c=relaxed/simple;
	bh=Os7IbsviYI1P0ffllJ0SQYT34TXow4Nf9Ks/ZpiAE3c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=F9kF3Rr4asvCVygwKWnteopEsGzQyVqc412UNIyIlD5bPV5U6ZTHz2a9PrdQV3C/Gyq2+UhCFozJpwt/b7s8AMJpBW2uDmXX0xmnd/Erj0OnJIzMmaQYL5BITuNTP/CKo8sn0xBiFJ57z6ard3rCdBbvz9MxkngeP2ZCT9srOqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qx8xvoyN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qx8xvoyN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C249C116D0;
	Wed, 25 Feb 2026 10:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772014206;
	bh=Os7IbsviYI1P0ffllJ0SQYT34TXow4Nf9Ks/ZpiAE3c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=qx8xvoyNRjsOH8+w08fMn72aOTnE90MkkT6Ld2HmqNIoHUd2qBDowur2iYE4rjIvB
	 jEk2/Am3yPC4yi39gFrBUpSw2SctAZMD2Fw5jEKXVD2fFGb27koBo4eJyCUDKqwkM9
	 n24IkxKUJSkzLYMwWo4mdlqYIaAOLChiy9Nr3BDJKAckS/mlmYClEJAI0aCt8D/zPE
	 8/OkjHTPlnauzp1DlNrgx3Fb65LPPmOHQwKvFrLxt7L7hmDJZnkkGR3fnud8Yfq7fv
	 NkGDXOBKRpf6b9d2252PgkkJAPaXjqykgqoFSArQnMLk9gnya7lcGWxtimrm+9rdHh
	 7RdqctAyNWMIg==
Content-Type: multipart/mixed; boundary="===============1047013306209130621=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b0ad1db5ec3b68c1244e629ba6dce8a2dd9759316b5ffa83cc6fd464891fb7d0@mail.kernel.org>
In-Reply-To: <20260225092651.94689-3-pilgrimtao@gmail.com>
References: <20260225092651.94689-3-pilgrimtao@gmail.com>
Subject: Re: [PATCH v2 2/6] selftests/bpf: Add test cases for bpf_list_del
From: bot+bpf-ci@kernel.org
To: pilgrimtao@gmail.com,martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,leon.hwang@linux.dev,linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 25 Feb 2026 10:10:04 +0000 (UTC)

--===============1047013306209130621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h

[ ... ]

> +/* Description
> + *	Remove 'node' from the BPF linked list with head 'head'.
                                                          ^^^^^^

The comment references a 'head' parameter, but the function signature
only takes 'node':

> + */
> +extern struct bpf_list_node *bpf_list_del(struct bpf_list_node *node) __ksym;

This looks like a leftover from v1 where bpf_list_del() took both
head and node. Alexei asked to drop the head parameter in v1 review:

https://lore.kernel.org/bpf/CAADnVQKjBdfL17d0H6eHdiHYbXOr0Xz6BC=AbwMctQ6860-P5w@mail.gmail.com/

The implementation was updated but the comment still references the
removed parameter. Should this say something like "Remove 'node'
from its BPF linked list" instead?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22391130139

AI-authorship-score: low
AI-authorship-explanation: Follows established BPF selftest patterns with idiomatic kernel C; the stale v1 comment is a typical human oversight when iterating on review feedback.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Stale documentation comment referencing a removed parameter; no runtime impact but incomplete response to maintainer review feedback.

--===============1047013306209130621==--
