Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CCC3375C3;
	Fri, 20 Feb 2026 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771585077; cv=none; b=qUPZvttP9jONvj4iIfG0ZY6ymkK10pWHimu33Ot4sdQFlVfljJAOuohCmNJ09Zx1nqN9TNTGlRj9o7gDiD65h497Wa9Bnpg4rWwiqd+GlWPAJDUukd7g55xBNejcNp1rHANAe8UQM985POq1MB+/LWuBQeMQAJS+aONLuuINTbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771585077; c=relaxed/simple;
	bh=mQCWhR2p9yRVyuxJ9rIrnfWydCasXOnl7QxbruictBo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VzIuo2lGfzsHVxVJCadOTIXRWKT0/BtYZ0dn/LXjrJY1YDOwgMx4o1hDWWa8edmXuPbXCGKK3qPxGzldeBH/6Ne7iTQ95uyI4u6k32p/vDcIXydfJprQ0TneaNb8a/rTje+fA5AtRnmkSxnqKwaJzaDcZvsQPHgCUb95k/aN5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKRQY8Fn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKRQY8Fn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87777C116C6;
	Fri, 20 Feb 2026 10:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771585076;
	bh=mQCWhR2p9yRVyuxJ9rIrnfWydCasXOnl7QxbruictBo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=dKRQY8FnLiwhCeiFd6oUZkpc1Q7ilq2LVUUzhaj2iOCcNkchdb1t8UaA2zpafzszw
	 gxmkAvYd+TtOm8BnkzahHlcYbe5sYgYp6rNTFdc5N9G4zoM6XzK2CH7xh1asMulGu6
	 kZyJK0ev1xAlsdyImuhM9G3rJbapKCDKh+WM+Tymg65WySvWJxT0voLk/agrxjiK/p
	 gkoQSsYy/Af+pRP4ZEZyApxuuhChXXCxRw94C2r8uyBWCp1+S0nlb+LGWJ15qOqcbV
	 IiZnReLseP3c5B9nSbn7lBNDn1zik/c2tQWPKc92Gxd3DRa0dh73QuHu2glLe3z6JM
	 M8zpMjLuynAkg==
Content-Type: multipart/mixed; boundary="===============0546451225129286370=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0520af2c467a82b82aa3014b7e721f95bfde9e91324bb2e183b099e5a37bbc3e@mail.kernel.org>
In-Reply-To: <20260220100649.628307-11-jolsa@kernel.org>
References: <20260220100649.628307-11-jolsa@kernel.org>
Subject: Re: [PATCH bpf-next 10/17] bpf: Add support for tracing_multi link session
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 20 Feb 2026 10:57:56 +0000 (UTC)

--===============0546451225129286370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 5892dca20b7e..1cd6c1457bd3 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3611,6 +3611,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>  		if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
>  		    prog->expected_attach_type != BPF_TRACE_FEXIT &&
>  		    prog->expected_attach_type != BPF_TRACE_FSESSION &&
> +		    prog->expected_attach_type != BPF_TRACE_FSESSION_MULTI &&
>  		    prog->expected_attach_type != BPF_TRACE_FENTRY_MULTI &&
>  		    prog->expected_attach_type != BPF_TRACE_FEXIT_MULTI &&
>  		    prog->expected_attach_type != BPF_MODIFY_RETURN) {

BPF_TRACE_FSESSION_MULTI is now accepted here, which means
a program with this type can enter bpf_tracing_prog_attach()
via BPF_RAW_TRACEPOINT_OPEN:

bpf_raw_tracepoint_open()
  bpf_raw_tp_link_attach()       /* name == NULL */
    bpf_tracing_prog_attach()    /* BPF_TRACE_FSESSION_MULTI */

Further down in bpf_tracing_prog_attach(), the fexit node
initialization only checks for BPF_TRACE_FSESSION:

kernel/bpf/syscall.c:bpf_tracing_prog_attach() {
    ...
    if (prog->expected_attach_type == BPF_TRACE_FSESSION) {
        link->fexit.link = &link->link.link;
        link->fexit.cookie = bpf_cookie;
    }
    ...
}

So for BPF_TRACE_FSESSION_MULTI, link->fexit.link stays NULL
(from kzalloc). When __bpf_trampoline_link_prog() later calls
fsession_exit(), it returns &link->fexit with a NULL link
field. This node gets added to the trampoline FEXIT list, and
bpf_trampoline_get_progs() then dereferences it:

kernel/bpf/trampoline.c:bpf_trampoline_get_progs() {
    ...
    hlist_for_each_entry(node, &tr->progs_hlist[kind], tramp_hlist) {
        *ip_arg |= node->link->prog->call_get_func_ip;
                   ^^^^^^^^^^
    ...
}

Would it make sense to either add BPF_TRACE_FSESSION_MULTI to
the fexit initialization, or reject this type in
bpf_tracing_prog_attach() since it should only be used through
bpf_tracing_multi_attach()?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22220470181

AI-authorship-score: low
AI-authorship-explanation: Code follows established kernel BPF patterns for adding new attach types, written by a well-known BPF maintainer with terse, practical commit message style.
issues-found: 1
issue-severity-score: high
issue-severity-explanation: NULL pointer dereference reachable from BPF_RAW_TRACEPOINT_OPEN syscall when BPF_TRACE_FSESSION_MULTI enters bpf_tracing_prog_attach without fexit initialization, leading to kernel crash.

--===============0546451225129286370==--
