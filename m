Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C921D36F8E7
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785529485; cv=none; b=dxuNd6a9NuPrq5TjRJ1ctq1mRJTCA+Q0OspgvkVbCZNJaatmjgrdPeB5kYa4xko9LMxUMNtASiJOYO511pFXJcXu69zIt3TRV6znR0c33d9GLTD+M4qvne7EaxfwLcmyeBA8t2SUkp8m9JVHQmN3invelSPk9XQnbyFMlTAL6+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785529485; c=relaxed/simple;
	bh=LQ4MkgJBtKW0EhB8H1/+eRss4hn9vJEBw+Hb1rqSlJQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uHyenibiOBKoL75/xOe0y1WIqeXdNpr+HRvW7zro4LtNHtV52g/eIFp9M+F2wk4uYAPkIH36ATrUrpnGwLd4xpXwDBMBL/lRXKJ+f5YQnHYV+4WTPOgW85Eb9v0GxZa0Nms+14pCxdVfIiQUwgW5i4uOg+qVFiaS9JU+JUTsLRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVmHFJVH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVmHFJVH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D097E1F00AC4;
	Fri, 31 Jul 2026 20:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785529484;
	bh=0i0BDEuOA/mHx7nii3jbyMYYg/lDwARABjPhLov2G9o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cVmHFJVHG5BIUXdbn9h9/Xt/9yzc62NgZqtgnE18ATJnSs4Jm7PwgtA99SjT3Fi/8
	 MCONUhOStq/fFP6ohUi4gCrSWMBpsyQMRY34mRv7NCv1z0b6COPPqOJPInVYrfHBSV
	 PUgYt9oXaqp+bPd9zm8FwiH7UNFdGzHpO3YdKprogjE1rrwoFWYXpad1EAGTE22AZY
	 0kkyc7F/0fiaDL6tOOd8MehHrc3myCWzlqXLrjsH6UN+YWUZ7mZM/xVSVCddhxX2da
	 eIaMNpZ6JLM7qfkPwC5L8zITGp1zy8kkysfZkfA7PfWWbfIxTJ6ND02hWo4DxK+1uP
	 EnVoR/kN5A7fw==
Content-Type: multipart/mixed; boundary="===============1310453833229460925=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <00c332237fb39899a63235c07cc1d51ab4df2bb5213a6ba93dd186250ccc54df@mail.kernel.org>
In-Reply-To: <20260731-static-zext-v1-1-98a4dc73e94b@gmail.com>
References: <20260731-static-zext-v1-1-98a4dc73e94b@gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: do not print a newline after disassembly in bpf_verbose_insn()
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,iii@linux.ibm.com,gimm78064@gmail.com,qmo@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 31 Jul 2026 20:24:43 +0000 (UTC)

--===============1310453833229460925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
> index 5e7cb8b36fef2..7b33d847d800c 100644
> --- a/tools/bpf/bpftool/xlated_dumper.c
> +++ b/tools/bpf/bpftool/xlated_dumper.c

[ ... ]

> @@ -417,6 +412,7 @@ void dump_xlated_for_graph(struct dump_data *dd, void *buf_start, void *buf_end,
>
>  		printf("%u: ", insn_off);
>  		print_bpf_insn(&cbs, cur, true);
> +		printf("\\l\\\n");
>
>  		if (opcodes) {
>  			printf("\\ \\ \\ \\ ");

This isn't a bug, but now that no disasm.c format string carries a
newline and dump_xlated_for_graph() emits "\\l\\\n" itself, is the
'\n' arm of print_insn_for_graph() still reachable?

Looking at print_insn_for_graph():

static void __printf(2, 3)
print_insn_for_graph(void *private_data, const char *fmt, ...)
{
	...
	p = buf;
	while (*p != '\0') {
		if (*p == '\n') {
			memmove(p + 3, p, strlen(buf) + 1 - (p - buf));
			/* Align each instruction dump row left. */
			*p++ = '\\';
			*p++ = 'l';
			/* Output multiline concatenation. */
			*p++ = '\\';
		} else if (*p == '<' || *p == '>' || *p == '|' || *p == '&') {
	...
}

It looks like the `if (*p == '\n')` arm no longer has any producer,
since this patch drops '\n' from all 34 verbose() format strings in
kernel/bpf/disasm.c and the interpolated values (symbol names parsed
with sscanf "%s") cannot contain whitespace either. Could this arm be
dropped so only the '<'/'>'/'|'/'&' escaping remains?

Note this would also retire the latent `memmove(p + 3, ...)` expansion
that had no headroom check against the 64-byte buf.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30658911996
--===============1310453833229460925==--
