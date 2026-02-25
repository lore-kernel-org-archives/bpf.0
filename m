Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1042222590;
	Wed, 25 Feb 2026 22:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772057001; cv=none; b=ehvdr/lRbXymXQ4nbS7NM1nWJEn0BGUeLeytwpdfPktSk3WF/FBhVTG6A+Kmu54QhL++7UsLHtkao6W0w8qee5DLukAoCubgVaYr4bkjdEWYNfY7gOv8hQ27c1XSh2bFxIaoLYFK87w55HuTev/smu+T93Dwaoa/N6gs7DMTzBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772057001; c=relaxed/simple;
	bh=/U7ShKSWPDF2v3z+5V3cMDbR1yeyB3pvxejkJDSj6lM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WR42Snhx7WOtXRFQV5SmgqT/JdLylpBaH7VqemDhgKp9dE4P3Z2EuXXTaruQ172H8dPWaKIYEx2VofXmen+5vftlKkg0hUddws5DvB3oESPlREjDBIpGIF8OsFdBhXbDqKFnokoUmHMDdguuhYDnlYkC1qgRn+0FLYopqUuEInk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCvvb7zA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCvvb7zA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D192EC116D0;
	Wed, 25 Feb 2026 22:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772057000;
	bh=/U7ShKSWPDF2v3z+5V3cMDbR1yeyB3pvxejkJDSj6lM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=dCvvb7zAydzm4xYhfBnKClngUPdK8Ug6YsI2k/LvdJ4OaSWlY6pYy/xu0S7jnHQtd
	 i7lk2LTT6N+dkgYCrR+x8n+FhU/u32qFwHuzv6eBSii7aVSAxUfkhLUCnnPAMcSR1/
	 IEuV5tnmXGSWS1dTNwSSooDcfUVF6Wp3LJ5R74mhMEMbpBr4vVEDhnbqHXAs4As7ui
	 An15nMpgKOcrfpbJwYe7q84bMPvHmAXyRqF5qmQAplI9jvBeKsUbxr4Bu7fUPS4yNF
	 D2/gFJziM7GW0sE3X/r1PYkvbrjn0m4bxWbeWKz8gjE7JU6vbx9FbNBVRkbEetqWyc
	 KYk2EpJQ6BU0A==
Content-Type: multipart/mixed; boundary="===============4038024577889962429=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <757bc1b31d0a6aa67c687c05fea88d97a7568fad0a3c2a880c28b931906fe315@mail.kernel.org>
In-Reply-To: <20260225210820.177674-2-wusamuel@google.com>
References: <20260225210820.177674-2-wusamuel@google.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Add wakeup_source iterator
From: bot+bpf-ci@kernel.org
To: wusamuel@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org
Cc: wusamuel@google.com,kernel-team@android.com,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 25 Feb 2026 22:03:18 +0000 (UTC)

--===============4038024577889962429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/wakeup_source_iter.c b/kernel/bpf/wakeup_source_iter.c
> --- /dev/null
> +++ b/kernel/bpf/wakeup_source_iter.c

[ ... ]

> +static void wakeup_source_iter_seq_stop(struct seq_file *seq, void *v)
> +{
> +	int *srcuidx = seq->private;
> +
> +	if (*srcuidx >= 0)
> +		wakeup_sources_read_unlock(*srcuidx);
> +	*srcuidx = -1;
> +}

Should wakeup_source_iter_seq_stop() call
__wakeup_source_seq_show(seq, v, true) when v is NULL, before
releasing the SRCU lock?

bpf_seq_read() in kernel/bpf/bpf_iter.c has this at the stop
label:

    /* bpf program called if !p */
    seq->op->stop(seq, p);

The other BPF iterators follow this contract:

    bpf_map_seq_stop():
        if (!v)
            (void)__bpf_map_seq_show(seq, v, true);

    task_seq_stop():
        if (!v)
            (void)__task_seq_show(seq, v, true);

The same pattern appears in bpf_prog_seq_stop(),
bpf_link_seq_stop(), task_file_seq_stop(), and
task_vma_seq_stop().

Without the in_stop callback, BPF programs attached to this
iterator cannot detect when iteration has finished, which
prevents finalization such as outputting aggregated results.

The __wakeup_source_seq_show() function already accepts the
in_stop parameter but is never called with true:

> +static int __wakeup_source_seq_show(struct seq_file *seq, void *v, bool in_stop)
> +{

[ ... ]

> +	struct bpf_prog *prog = bpf_iter_get_info(&meta, in_stop);

[ ... ]

> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22416722500

AI-authorship-score: low
AI-authorship-explanation: The code follows standard kernel BPF iterator patterns with no unusual characteristics suggesting AI generation.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Missing end-of-iteration callback is an API consistency issue that prevents BPF programs from detecting iteration completion, but does not cause crashes or data corruption.

--===============4038024577889962429==--
