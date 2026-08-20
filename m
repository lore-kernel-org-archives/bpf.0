Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3E347D444
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240654; cv=none; b=Qd9ROEbovM5v1kzNZmh4ZeiaoRNtSOhgPAYTDw3cPXvsn5O1G3CKPt/Je/trJg3u7NCz8e1WAxObI8lF4Vl06rotLSMhTXydmRaYQMo4A+IMz0RRn09Z+yCMdPiLMheyspsI/T1soKTDTEg3Y/n6bVpmvlygCMvn8StQMyXMjvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240654; c=relaxed/simple;
	bh=+ykhXc2aSoBvHXETc89y1YEGbKgKsH/lOZbjhL8eB2g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I3SvHdzmPq5WxOO4C7Ye8gr8HhUHMQDU/pK/OHUdEzmSpqDZ+/aBBHCQ8C/pHTYBMvZ7ouzqwCEbJHqKkCujbAQVkp0S2SvMn1Ik4Ufdrvw9D/cQqyivzQeHAWDOiVuZxBGK0Eyhe2I9K80lDTrt7e+hKE/hCRQSvM3UM4FoLrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7QS7CRE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7QS7CRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4269F1F00ADF;
	Thu, 20 Aug 2026 15:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787240647;
	bh=4sZSlrcXcWJhC8sqfG8+Gp7wSo6CR7hcsIimlQCDagQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U7QS7CREOeOUTCmntN+NXYnTgBDIhXjwuM3K7C6JScqIX03AUEBnTUt9WXBL7rrw/
	 rhCmBj12VC2qvpQ+tfSt8ByBWeRD08ZSEJiFGv8sB1ZC53s3ZikJCQ/iTltY7BoJp4
	 SCirN/bJdIWLUKjl9goqvEM7IjT03dX2+juv0T+tcjVXHaLNp1wpDlexeru82GdIep
	 fHevbAAAWBYpYR0pYWQfBjvxPFu67dYpOM+fpjBrqjclpSuLyz3+0wS/BnE/dxuNvq
	 FIHuvLImYJQ5t+NA8CD2s0q/qsv8vQES2q7Hhr+JWke7r1GmlneLoC/XV3NB72MJ9K
	 gkNFyZ50wkdQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] bpf: Fix NULL pointer dereference in
 bpf_sock_from_file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Syeda Mahnur Asif" <s.mahnur.a@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260820152532.621639-1-s.mahnur.a@gmail.com>
References: <20260820152532.621639-1-s.mahnur.a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 15:44:06 +0000
Message-Id: <20260820154407.4269F1F00ADF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete validation allows ERR_PTR to cause kernel panic in bpf_=
sock_from_file.
- [High] Missing NULL pointer checks in BPF helpers taking ARG_PTR_TO_BTF_I=
D lead to kernel panics.
--

--- Patch [1]: [PATCH bpf v2] bpf: Fix NULL pointer dereference in bpf_sock=
_from_file ---
commit a54db842fd2086671fb2b904beab51f691e8cc8b
Author: Syeda Mahnur Asif <s.mahnur.a@gmail.com>

bpf: Fix NULL pointer dereference in bpf_sock_from_file

Adds a NULL check to bpf_sock_from_file to prevent kernel panics when
fentry/fexit programs pass a NULL file pointer.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 16845987b2449..7c3caae4bafc3 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12182,7 +12182,10 @@ const struct bpf_func_proto bpf_skc_to_mptcp_soc=
k_proto =3D {
> =20
>  BPF_CALL_1(bpf_sock_from_file, struct file *, file)
>  {
> -	return (unsigned long)sock_from_file(file);
> +	if (file)
> +		return (unsigned long)sock_from_file(file);

[Severity: High]
This isn't a bug introduced by this patch, but does this check adequately
handle error pointers?

If an eBPF fexit program attaches to a kernel function returning a
struct file pointer that fails (e.g., returning ERR_PTR(-ENOENT)), the BPF
verifier treats this as a valid PTR_TO_BTF_ID.

Since an error pointer is not NULL, this condition will pass, and
sock_from_file() will attempt to dereference it, leading to a crash.

Could we use IS_ERR_OR_NULL(file) instead to catch these cases as well?

Also, while not introduced by this patch, are there similar missing NULL
pointer checks in other BPF helpers taking ARG_PTR_TO_BTF_ID?

When fentry/fexit programs pass context arguments, the verifier lacks BTF
nullability annotations for most parameters. This means helpers can receive
and blindly dereference NULL pointers.

For instance, bpf_task_pt_regs() directly dereferences the task without
checking:

kernel/trace/bpf_trace.c:bpf_task_pt_regs() {
	return (unsigned long) task_pt_regs(task);
}

Similarly, __bpf_get_task_stack() calls try_get_task_stack() which will
dereference the task:

kernel/bpf/stackmap.c:__bpf_get_task_stack() {
	if (!try_get_task_stack(task))
		return -EFAULT;
}

And bpf_xdp_get_buff_len() accesses the xdp buffer directly:

net/core/filter.c:bpf_xdp_get_buff_len() {
	return xdp_get_buff_len(xdp);
}

Do these helpers need similar runtime validation to prevent panics in the
same execution context?

> +
> +	return (unsigned long)NULL;
>  }
> =20
>  BTF_ID_LIST(bpf_sock_from_file_btf_ids)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820152532.6216=
39-1-s.mahnur.a@gmail.com?part=3D1
