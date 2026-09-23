Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDA34349AA;
	Wed, 23 Sep 2026 22:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202716; cv=none; b=vDR2TIDZY6gNIuzjUVvI/V45fRG5QBwz+kMnvZbvWi5eE5uJ/kcKmeYhLWbhVrklwO+9tPP5HNqLr1vuehbijTjEG37HvMaadmdJ+hU7qtFXtKqoAu0vIY3OCjJTaftJ+HBUcqzUoETFTfPxvjQm/XxDVKqfzueoIy+Vhd8biRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202716; c=relaxed/simple;
	bh=H3GJv+3DFhz81VLkuYSgyKwhd7GC5j3u/93UgZAyMFc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=G0+elKEgSvPRQQ161GibOSYxslMWXjdUCqtuioJR9fGhvylfYOd4z/j792pkVIPROmr6R3jVCmRQEuQU4f5+RclhYQxMNmJKWFpNutNqRC0XKJR3Y+jOaQmFkJ4nUKZe8bdg2FWlgitMzbeveTFvgHawjtLrZM4kJcOsLNjn8Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReED3C0G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReED3C0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91F51F000FF;
	Wed, 23 Sep 2026 22:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790202714;
	bh=8tU92DnBp6kXLuIJEyzVwf8HYCQCUJEyXBiLNcYd3K4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ReED3C0GyQqG85DfBpD03mFST7xeNHlpahUHF767/3JILOCUricjWoDVIMNaRQDuD
	 NbqeLf9k7ZiJftGI00UUlzRN1khVfbueoBrLnZt6VFo0KAnz4k3daifGODcRbtIjKl
	 u9eDseeapuBsjkzFCRnhyU2k5QNb1HuM4wi5+VKY6EDmde2yw4Cp5AtDZB5HW7jpaJ
	 ScacB9I72Fqsnxx7V02v5/6vPzZNVN1Y0mAb2LMRqtkzS+xAiydWmfqkyFr3/hsMXa
	 oUIntCb2V883eNXjvSnrOD1HnsjYyaTVp3Nfw/tXqTRffy5kOuCh8efsQDnf4lgcQx
	 5rQH/Wm7wIQ/g==
Content-Type: multipart/mixed; boundary="===============8495400714061169796=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ae4c892db08f9fb6373ad9ae77f3412b47142a08a5155ab0cb1874ed3ecb9d28@mail.kernel.org>
In-Reply-To: <20260923213719.224838-5-kuniyu@google.com>
References: <20260923213719.224838-5-kuniyu@google.com>
Subject: Re: [PATCH v2 bpf-next 4/8] bpf: tcp: Support bpf_sock_ops_cb_flags_set() for bpf_tcp_ops.
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com
Cc: yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,edumazet@google.com,ncardwell@google.com,willemb@google.com,ukyab@berkeley.edu,cleger@meta.com,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 22:31:51 +0000 (UTC)

--===============8495400714061169796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 3f0877b5867bd..68c7e1ca418c9 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3264,7 +3264,7 @@ union bpf_attr {
>   * 	Return
>   * 		0
>   *
> - * long bpf_sock_ops_cb_flags_set(struct bpf_sock_ops *bpf_sock, int argval)
> + * long bpf_sock_ops_cb_flags_set(void *bpf_sock, int argval)
>   * 	Description
>   * 		Attempt to set the value of the **bpf_sock_ops_cb_flags** field
>   * 		for the full TCP socket associated to *bpf_sock_ops* to
>   * 		*argval*.
>   *
>   * 		The primary use of this field is to determine if there should
>   * 		be calls to eBPF programs of type
>   * 		**BPF_PROG_TYPE_SOCK_OPS** at various points in the TCP
>   * 		code. A program of the same type can change its value, per
>   * 		connection and as necessary, when the connection is
>   * 		established. This field is directly accessible for reading, but
>   * 		this helper must be used for updates in order to return an
>   * 		error if an eBPF program tries to set a callback that is not
>   * 		supported in the current kernel.
>   *
>   * 		*argval* is a flag array which can combine these flags:
>   *
>   * 		* **BPF_SOCK_OPS_RTO_CB_FLAG** (retransmission time out)
>   * 		* **BPF_SOCK_OPS_RETRANS_CB_FLAG** (retransmission)
>   * 		* **BPF_SOCK_OPS_STATE_CB_FLAG** (TCP state change)
>   * 		* **BPF_SOCK_OPS_RTT_CB_FLAG** (every RTT)

Should the documentation be updated to reflect the new dual-context use?

The prototype changed to void *bpf_sock so bpf_tcp_ops programs can pass
their struct sock * argument, but the Description still only mentions
*bpf_sock_ops* and BPF_PROG_TYPE_SOCK_OPS.

Compare bpf_setsockopt() in this file, which documents what *bpf_socket*
should be for each program type: "*bpf_socket* should be one of the
following: struct bpf_sock_ops for BPF_PROG_TYPE_SOCK_OPS ..."

Also, which bpf_tcp_ops operators can call this helper? Looking at
get_func_proto() in net/ipv4/bpf_tcp_ops.c, it returns
bpf_tcp_ops_cb_flags_set_proto only for connect, listen,
active_established, passive_established, enqueue_rcvq, and dequeue_rcvq.

Earlier patches in this series documented similar restrictions. For
example, bpf_load_hdr_opt() says "For the **bpf_tcp_ops** struct_ops,
this helper can be called from the **parse_hdr**\() and
**write_hdr_opt**\() operators."

The commit message mentions clearing BPF_SOCK_OPS_RCVQ_CB_FLAG as the
motivation for this change, but that flag doesn't appear in the *argval*
flag list above. The list only shows RTO_CB, RETRANS_CB, STATE_CB, and
RTT_CB.

Finally, the Return section says the helper returns -EINVAL if the socket
is not a full TCP socket:

>   * 	Return
>   * 		Code **-EINVAL** if the socket is not a full TCP socket;
>   * 		otherwise, a positive number containing the bits that could not
>   * 		be set is returned (which comes down to 0 if all bits were set
>   * 		as required).

But bpf_tcp_ops_cb_flags_set() in net/ipv4/bpf_tcp_ops.c just returns
'argval & ~BPF_SOCK_OPS_ALL_CB_FLAGS' without any -EINVAL path. Should
the Return documentation clarify that -EINVAL only applies to
BPF_PROG_TYPE_SOCK_OPS programs?

> [ ... ]
>
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 3f0877b5867bd..68c7e1ca418c9 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -3264,7 +3264,7 @@ union bpf_attr {
>   * 	Return
>   * 		0
>   *
> - * long bpf_sock_ops_cb_flags_set(struct bpf_sock_ops *bpf_sock, int argval)
> + * long bpf_sock_ops_cb_flags_set(void *bpf_sock, int argval)
>   * 	Description
>   * 		Attempt to set the value of the **bpf_sock_ops_cb_flags** field
>   * 		for the full TCP socket associated to *bpf_sock_ops* to

The same documentation text appears in tools/include/uapi/linux/bpf.h and
would need the same updates.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35924977907
--===============8495400714061169796==--
