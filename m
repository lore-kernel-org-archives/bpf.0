Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1A83F23CF
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654330; cv=none; b=hu90JtnEMSWQGT92FHdR0M7oTx2DdHDgw+V3NxYc9HCjCk72Y3XqHP5UweioeHdHO9r5DJ70gTzrhDt4xLRlMnYA0emyW/J15bAKpcM+VPx4KzuXDXB/iQvl03M/Lq+qNrDtoSKu7wHyXAB8nb36xhytA+ez1S4gr5m6hZIxqZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654330; c=relaxed/simple;
	bh=SVAscbbUTlQDPIKgSykvsVIZF7g/kr/SbnGvXdtS8GE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GnOoHA+CEMTyEzB8I34EGytXClYxdRq9OmTX8ICILvedUtj18VA1I4o8qLOCuxZOV2F8ksunUsDi0JjpS4gptz7OtYA3VebquqKy1u0E8J8IvrTwRjssV0OFV9kxlHnJ686bkzcPm+PWIWd8YK90RfaXC1ewhe0QOsBFTrUErz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0Ll1HWh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0Ll1HWh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DA2C2BCB4;
	Fri,  1 May 2026 16:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777654329;
	bh=SVAscbbUTlQDPIKgSykvsVIZF7g/kr/SbnGvXdtS8GE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=n0Ll1HWhGjU57EQMwEEJ4I6Z9u8BYrmafEDz26e0TRL7FbMviJxmuuvaFRZjeLexG
	 ng5Ie1vXBnpgGHSjg+TrBIC76pXYZZGjEoWcLKNjnKi7DqNwj+Ys4Niob5QknVusNg
	 p/KXHdWAHHq30iSYoPTxCQJZ/+EtrpNYsrKPFF96eihBqfWAg2t7AFUPTLkdPNnjMz
	 kvWVdBLe7bxpyPiVBCw5eODaymKtXo2N3qQS9jbwhCN07f7QAPMCRUZrvvtLC8dq+p
	 RG8XwSQwDLExFjM3t+5lMwj649Y72kOAUszz27vVGLRTg4a5N1pfxhfemDxNc6qLei
	 MNPWNrDXIMLug==
Content-Type: multipart/mixed; boundary="===============1900006424108060304=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8fb1d29329bd9fb7cecedb57ff25e5a484930a993c72f09f4a23cb316604636c@mail.kernel.org>
In-Reply-To: <20260501160901.224134-2-dev@der-flo.net>
References: <20260501160901.224134-2-dev@der-flo.net>
Subject: Re: [PATCH bpf-next 1/2 v3] bpf: Add LINK_DETACH support for perf link
From: bot+bpf-ci@kernel.org
To: dev@der-flo.net,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,sdf@fomichev.me,sun.jian.kdev@gmail.com,dev@der-flo.net,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  1 May 2026 16:52:06 +0000 (UTC)

--===============1900006424108060304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 3b1f0ba02f61..efd759970e10 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3880,13 +3880,35 @@ struct bpf_perf_link {
>  	struct file *perf_file;
>  };
>
> +/* Serializes bpf_perf_link_release() against bpf_perf_link_fill_link_info()
> + * and bpf_perf_link_show_fdinfo() to prevent a use-after-free on perf_file
> + * when BPF_LINK_DETACH races with BPF_OBJ_GET_INFO_BY_FD or /proc fdinfo.
> + */
> +static DEFINE_MUTEX(bpf_perf_link_mutex);

Should this commit include a Fixes tag? The use-after-free race condition
being fixed appears to have been introduced in commit 1b715e1b0ec5
("bpf: Support ->fill_link_info for perf_event"), which added
bpf_perf_link_fill_link_info() and bpf_perf_link_show_fdinfo() that
access perf_link->perf_file without synchronization, creating a race
with bpf_perf_link_release().

Suggested: Fixes: 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event")

>
>  static void bpf_perf_link_release(struct bpf_link *link)
>  {
>  	struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
> -	struct perf_event *event = perf_link->perf_file->private_data;
> +	struct perf_event *event;
> +	struct file *perf_file;
> +
> +	mutex_lock(&bpf_perf_link_mutex);
> +	perf_file = perf_link->perf_file;
> +	perf_link->perf_file = NULL;
> +	mutex_unlock(&bpf_perf_link_mutex);
>
> +	if (!perf_file)
> +		return;
> +
> +	event = perf_file->private_data;
>  	perf_event_free_bpf_prog(event);
> -	fput(perf_link->perf_file);
> +	fput(perf_file);
> +}
> +
> +static int bpf_perf_link_detach(struct bpf_link *link)
> +{
> +	bpf_perf_link_release(link);
> +	return 0;
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25222566755
--===============1900006424108060304==--
