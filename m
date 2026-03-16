Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4CF394798;
	Mon, 16 Mar 2026 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773663053; cv=none; b=RE/DGLl22NGZsbscOdunWzho4HJJNYxWPdf5YqXbVa+/rAsknqrPfzi5QpIeXmc5RtirJo3EnPY0TMTD5sQunJT0+G66EKvAZPWm2fp0Md/iXdtElcpySMxA20HyRoUUHTeMrGRCCbdDn4xED9d+2UwMSA8FfYA+SaiMQbBYs5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773663053; c=relaxed/simple;
	bh=3r93kC60i9nMLoCjyhvzNMHJizojUVHNPVuaMI6kQSg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WBD45Tf0s2/zQTZMm9xN4BBd22D6s3KxTMaSrKXY6lHHrpnkv1+vWKlW1WJODSZnW0JVy3p92tYkm+CzeJdHxy5+fQw4eRxWy+XlXkShx/SnvTgHVDz89U7Do6Iua0ElJoDUbFzbXbG3fH2ScHq8r7w5B+wo0/j56bxZ1QV7uf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTlL48/V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTlL48/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07FDC19421;
	Mon, 16 Mar 2026 12:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773663053;
	bh=3r93kC60i9nMLoCjyhvzNMHJizojUVHNPVuaMI6kQSg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=iTlL48/Vr2NRrw2DnSjiZA8PDpxNTAaj9Xjl2i3ub1cM/GqVO4zi5X6mGm2HE5J2r
	 4wa3PXesM1MprPM/43soN93AQVMi3mH4LyWtDpxWkvlWVcYBHNgy8fsj+fLhMWbh1W
	 yuEP6NN76eQanzE4ZpHEYicz4EZn1RnWeZ7BU8Mo+coBmrtFWz67roZiK5jDpZI5AT
	 UZALNILumdyOWAhf9n4AqUaNTJNpzSmmMsZRrYFurWSC5yqoieEJEGUOd7GRFT9D9F
	 9uQ+bwmPtqxsAFZWuTpXZpcQ4pABJI1Ezggx8zjl5Cexh5ldOcJ0EvScCSkpj1QKAA
	 0OidpNbL1n3iQ==
Content-Type: multipart/mixed; boundary="===============0519777484936541016=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aef1558e6629e0d25cba7f4d95b7b19e47aad8585035bdf6b93483c26856ef69@mail.kernel.org>
In-Reply-To: <20260316112843.78657-4-pilgrimtao@gmail.com>
References: <20260316112843.78657-4-pilgrimtao@gmail.com>
Subject: Re: [PATCH bpf-next v8 3/8] bpf: Introduce the bpf_list_del kfunc.
From: bot+bpf-ci@kernel.org
To: pilgrimtao@gmail.com,martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 16 Mar 2026 12:10:52 +0000 (UTC)

--===============0519777484936541016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index e87b263c5fe6..dac346eb1e2f 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2437,6 +2437,8 @@ static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,
>  	 */
>  	if (unlikely(!h->next))
>  		INIT_LIST_HEAD(h);
> +
> +	/* verifier to guarantee n is a list node rather than the head */
>  	if (list_empty(h))
>  		return NULL;

Is this comment accurate for all callers of __bpf_list_del()?

For bpf_list_pop_front() and bpf_list_pop_back(), n is derived
from h->next or h->prev. When the list is empty, h->next == h,
so n is the head itself:

kernel/bpf/helpers.c:bpf_list_pop_front() {
    struct list_head *h = (void *)head;
    return __bpf_list_del(head, h->next);
                                ^^^^^^^ h when list is empty
}

In that case, the list_empty() check is the runtime defense
against n == h, not the verifier. The verifier type guarantee
only applies to the new bpf_list_del() path where node is a
separate bpf_list_node argument.

Since __bpf_list_del() is shared by all three callers, this
comment could mislead a future reader into thinking the
list_empty() check is redundant, when it is actually essential
for the pop paths.

Would it be better to move this comment into bpf_list_del()
itself, or to qualify it as applying only to the bpf_list_del
path?

[ ... ]

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23141914395
--===============0519777484936541016==--
