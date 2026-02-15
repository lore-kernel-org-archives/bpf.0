Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1646746BF
	for <bpf@vger.kernel.org>; Sun, 15 Feb 2026 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771115481; cv=none; b=nENJY6KwKSVeqn470tWdOQz2/H2ZepRRebFAGMRb0rL7ET1CT5Z7PKjIvExuBehbkeRjr5jgw9VlfXnfgXZ+Aa2i07nHyweydQhn70G7ZlUSz9z3PGTqaTntgcEUKgJHJk9B4KFdVP77itr1AkHWuRrB+g8K0g/MgTKEz2KTCoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771115481; c=relaxed/simple;
	bh=SWOtZ3ol6k8PQf0te8cFqQvItux02acmX2TC9slec54=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YGGFquk88cwxi+TfjLMEfyrzCBTmK7Hy4aGRcq2IT30rU8795eS3dVki9qDmE/s18Ow01e7TiPPq1PEMm2mJEMW1+FQc3btrpR5jpjF2a7NILiQX3Loo3BaA52n8oPRMsb5Awej/h1dfeV6HOapeEYZVUct3HNbwEeR4zwTQHug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZ0JVrjy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZ0JVrjy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB40C16AAE;
	Sun, 15 Feb 2026 00:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771115480;
	bh=SWOtZ3ol6k8PQf0te8cFqQvItux02acmX2TC9slec54=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=OZ0JVrjyqD8AAbdGGxm458E+JAojOxiumzAyemhf2tw+2TwtAizAJU7Cdfh/dDp/g
	 KFLYYoOl+Af6gVa/bBGpmeuIcnjNWXPsFyN9DyJY771u7CFh+AQG0y+zcmzokt5A72
	 ZLIVZgO5BCuxrzD817Hvcou+z1jlbseHUAjxDhqTCR68tISI6lVShYNLhUGoEoNnh8
	 0dITdJu9rBYeck4IscprgqcM32rBnTxDUqxrHtYMuVyqLKuq7EPN8ShuSwd/ey6p3N
	 rJSQZMdi8NpooWqnZFcImLSShwCsRI0GOkRJ7XWb50rtEUp7KYv1QeJzgalQ5ssshU
	 6roQLf09sAMzw==
Content-Type: multipart/mixed; boundary="===============6939892216984945243=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <168c16302a7b96d74765124015cceba81a2eee255de3a32d8ed131de38df7c09@mail.kernel.org>
In-Reply-To: <20260215000656.323486-1-kuba@kernel.org>
References: <20260215000656.323486-1-kuba@kernel.org>
Subject: Re: [PATCH bpf v2] tools: bpftool: fix truncated netlink dumps
From: bot+bpf-ci@kernel.org
To: kuba@kernel.org,bpf@vger.kernel.org
Cc: kuba@kernel.org,qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 15 Feb 2026 00:31:20 +0000 (UTC)

--===============6939892216984945243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
> --- a/tools/lib/bpf/netlink.c
> +++ b/tools/lib/bpf/netlink.c

[ ... ]

> @@ -212,6 +212,8 @@ struct msghdr mhdr = {
> 				}
> 			}
> 		}
> +		if (len)
> +			pr_warn("Invalid message or trailing data in Netlink response: %d bytes left", len);

Should this have a trailing \n in the format string?  The bpftool
version uses p_err() which appends a newline automatically, but
libbpf's pr_warn() passes the format string through as-is.  Every
other pr_warn() call in this file includes \n, for example:

tools/lib/bpf/netlink.c:netlink_open() {
    ...
    pr_warn("Netlink error reporting not supported\n");
    ...
}

Without it the next libbpf log message will be concatenated onto the
same line as this warning.

> 	}
> 	ret = 0;
> done:

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22026600932

AI-authorship-score: low
AI-authorship-explanation: The patch shows human review interaction patterns across two versions with natural review feedback incorporation, and the missing newline is a typical human oversight during code adaptation.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Missing trailing newline in pr_warn() format string causes garbled log output but does not affect functionality or system stability.

--===============6939892216984945243==--
