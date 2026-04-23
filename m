Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8752E3A5E9F
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961015; cv=none; b=G6EQ4P4g7TNsvFd+wch1t03pjv5q/4Qw80wAl2igISID7zbuyYnIS2eb3DUhrdL/AbWwmLVrV2PsNBlAM6QXePZltqxG8OActBNXtBb5TvZTWvxliiOkUtx0IsnQxk86lmRBDXpfaJriFS5QjAhd9colQm9/EUr00GHlwVTtG6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961015; c=relaxed/simple;
	bh=88/HKxe5n2sk+e6u/XPQ5msZDmz/z5JJvEKI5BhwyrE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=L5tUy65XdYtKvsYdASogjbqlD7GTz63LRsOGTMB0gCtAVipp/P6TcgCIouPj3Rn3HJnl3evlQR5XfLGGn40K3xRXucjBWCXYc5P7nMGiDORYHIlGOoowC6CdcA/cun9kOxEExSmbBvsqK8EtgCC7FYf3YiLJW4bxodxTnp3tW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3cwZkmh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3cwZkmh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE8DC2BCAF;
	Thu, 23 Apr 2026 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776961015;
	bh=88/HKxe5n2sk+e6u/XPQ5msZDmz/z5JJvEKI5BhwyrE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=A3cwZkmhaZTDPa9yRJzZ5rr1v6+skk2b8QR4wHQJ8ADezf7NT2pftFJujgbn0x9Me
	 ZkaXJr+dikzOxH7ynb+8cyWgU/lOA87S7iXoYBtIdQd8U71K9orujw/L2mkFUIpAJX
	 UiyFOqDrjVghSfR0ni6Ou5rItjHaFglAteMx9EINJCWccp+IM2M1xM1RExqtIyNsNL
	 SDQ3Owd6bBBLaI1lJi7VCBklOggccua9c1Vb3WMdjeHgkruYlqRZVWWqNzqb5OHpb7
	 Xos0EaqX65OpHB1EPy7T+pVr3Geoj+7JWAtToQw3LEpvdyiyCbzXd5pOFWWohmPzIj
	 zYvoM0BBzMHSA==
Content-Type: multipart/mixed; boundary="===============5377167032193769205=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0f38092aac45453cb84f7e822a09057bfd3b5b0a2d3aae3c2f7bd20214a3e4aa@mail.kernel.org>
In-Reply-To: <20260423152239.4140627-2-utilityemal77@gmail.com>
References: <20260423152239.4140627-2-utilityemal77@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Implement dtor for struct file BTF ID
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,bpf@vger.kernel.org,mic@digikod.net,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 23 Apr 2026 16:16:54 +0000 (UTC)

--===============5377167032193769205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index baa12b24bb64..4739e2bf0f31 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -2752,6 +2753,13 @@ __bpf_kfunc void bpf_task_release_dtor(void *p)
>  }
>  CFI_NOSEAL(bpf_task_release_dtor);
>
> +__bpf_kfunc void bpf_file_release_dtor(void *file)
> +{
> +	fput((struct file *)file);
> +}
> +
> +CFI_NOSEAL(bpf_file_release_dtor);
> +

Is bpf_file_release_dtor() safe to call from NMI context? BPF programs
can delete map elements from NMI context (for example, in
BPF_PROG_TYPE_PERF_EVENT programs), which will synchronously invoke this
destructor.

When fput() is called in an interrupt context, it adds the file to the
delayed_fput_list and calls schedule_delayed_work():

kernel/bpf/helpers.c:bpf_file_release_dtor() {
    fput((struct file *)file);
}

fs/file_table.c:fput() {
    ...
    if (!atomic_long_dec_and_test(&file->f_count))
        return;
    ...
    if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
        ...
    } else {
        fput_many(file, 1);
    }
}

fs/file_table.c:fput_many() {
    ...
    if (llist_add_batch(&head, &tail, &delayed_fput_list))
        schedule_delayed_work(&delayed_fput_work, 1);
}

However, schedule_delayed_work() is not NMI-safe, as it attempts to
acquire spinlocks such as the workqueue pool lock and timer_base->lock.
If the NMI interrupted a context that already held one of these locks,
won't this result in a hard deadlock?

Would it be better to defer releasing the struct file using an NMI-safe
mechanism, similar to how other BPF destructors handle this?

This issue was raised by sashiko-bot in v1:
https://lore.kernel.org/bpf/20260421010536.17FB1C19425@smtp.kernel.org/

The author acknowledged this as a real bug with a reproducible deadlock,
but v2 still uses the same fput() call without any NMI-safe deferral
mechanism.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24844511587
--===============5377167032193769205==--
