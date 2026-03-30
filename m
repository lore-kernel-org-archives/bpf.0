Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34EB3D47D7;
	Mon, 30 Mar 2026 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877968; cv=none; b=QVuttHz3xfyIe8/V5fbckmpfJiuHG0ENbyBAOOzZmKmXXjNBhwHtblKHUBxAcZhwAKcY+r1N1YsogY2Cpz6A3SpCE1L7qvuFOfvMjlkEIqhPhytEmT/32D7ZFbZSbFDCt/mDNfyUAIVstg4jVJyEl/JabMtqU1gTpMCYjPOswAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877968; c=relaxed/simple;
	bh=ceLRnkRsinQcpKB2cy45y5N3yqzsivrxz2l+aI9orws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=frH+fr1yUUl6l9qlWRfgEcW+Aj0XxgyP+ki5ERWr+BqTliLLkYLGSrk3SMpanTg9sYkNmPOgBFrSZMI64W5n6eAMxj+sXlssEbxl8QlTCcs1HBPqYrvseqSzYUuRn19xCUn2CMZ05dn5/uea+08ipJ0N/ZIBiLyqHzLF4QGh1gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqRISqvf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqRISqvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4B2C4CEF7;
	Mon, 30 Mar 2026 13:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774877968;
	bh=ceLRnkRsinQcpKB2cy45y5N3yqzsivrxz2l+aI9orws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MqRISqvf5FDoRAcIrxBgG6lRR6Er3HPAcRYbILkP+RjuczWxfDzzfDC7aVMHxR0aZ
	 B2yYTeNz3j32fFvdkaP+zhmXo15OtiGmONTHja84/niY9886XCucOtJMPFi+ohRntO
	 Qq0bdFMx6YaMAfPtFoStoKhs2sDmCflsVr50vX9oveaS2ylte9JoaLc6izWuoHDW3r
	 iJfcfDlCN+r7m6lYw64IIwZm5oaPuxyCY8Zugodf1UAdEL3uw4Ixo5vUe9Lr17Flzu
	 OhMBflfSNLjH8Bp33ypNTZyTUCVzAAn7/wkGJkIjOiexrpbJXdGukn+OjnKT6zAfZQ
	 eIZgI3DlqvvdQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Eyal Birger <eyal.birger@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, paul.chaignon@gmail.com,
 chen.dylane@linux.dev, kpsingh@kernel.org, a.s.protopopov@gmail.com,
 yatsenko@meta.com, ameryhung@gmail.com, tklauser@distanz.ch,
 shmulik.ladkani@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, Eyal Birger
 <eyal.birger@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: warn against BPF_RB_NO_WAKEUP in
 bpf_ringbuf_discard()
In-Reply-To: <20260330121732.1601352-1-eyal.birger@gmail.com>
References: <20260330121732.1601352-1-eyal.birger@gmail.com>
Date: Mon, 30 Mar 2026 14:39:23 +0100
Message-ID: <m2qzp1zbas.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eyal Birger <eyal.birger@gmail.com> writes:

> Document that BPF_RB_NO_WAKEUP is not recommended for
> bpf_ringbuf_discard().
>
> A discard done with BPF_RB_NO_WAKEUP can suppress a later adaptive
> wakeup from a valid record, leaving an epoll-based userspace consumer
> asleep even though data is available in the ring buffer.
>
> Scenario:
>
> epoll_wait(rb_fd);                     // blocks
>
> rec = bpf_ringbuf_reserve(&rb, ...);
> bpf_ringbuf_discard(rec, BPF_RB_NO_WAKEUP);
>
> rec = bpf_ringbuf_reserve(&rb, ...);
> bpf_ringbuf_submit(rec, 0);           // valid record, but no wakeup
>
> This behavior is surprising in the context of bpf_ringbuf_discard()
> as it seems natural not to want to wake userspace.

It appears that once you do a submit or discard with NO_WAKEUP, you can
never go back to adaptive mode. You will need to do an explicit
BPF_RB_FORCE_WAKEUP to do a wakeup. 

This looks like expected behaviour (by design) but for discard the
programmer might think: "I'm discarding and there's no data, why would I
wake anyone?  Let me pass BPF_RB_NO_WAKEUP to be a good citizen." 

I am not sure if we just want to change the description of the helper or
also fix the code to ignore the BPF_RB_NO_WAKEUP for discard?

Or a better approach would be to add a wakeup_needed flag to struct
bpf_ringbuf. When NO_WAKEUP suppresses a wakeup that would have fired
(cons_pos == rec_pos), it sets the flag. Any subsequent adaptive commit
sees the flag and sends the wakeup, clearing it. FORCE_WAKEUP also
clears it. But this could change how the ringbuf behaves for existing
programs.

I will let others comment on this.

> Reported-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
> ---
>  include/uapi/linux/bpf.h       | 3 ++-
>  tools/include/uapi/linux/bpf.h | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c8d400b7680a..c46b06d45904 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4645,7 +4645,8 @@ union bpf_attr {
>   * 	Description
>   * 		Discard reserved ring buffer sample, pointed to by *data*.
>   * 		If **BPF_RB_NO_WAKEUP** is specified in *flags*, no notification
> - * 		of new data availability is sent.
> + * 		of new data availability is sent, which is not recommended as
> + * 		it can suppress a later adaptive wakeup from a subsequent submit.
>   * 		If **BPF_RB_FORCE_WAKEUP** is specified in *flags*, notification
>   * 		of new data availability is sent unconditionally.
>   * 		If **0** is specified in *flags*, an adaptive notification
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 5e38b4887de6..96de37c3b896 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -4645,7 +4645,8 @@ union bpf_attr {
>   * 	Description
>   * 		Discard reserved ring buffer sample, pointed to by *data*.
>   * 		If **BPF_RB_NO_WAKEUP** is specified in *flags*, no notification
> - * 		of new data availability is sent.
> + * 		of new data availability is sent, which is not recommended as
> + * 		it can suppress a later adaptive wakeup from a subsequent submit.
>   * 		If **BPF_RB_FORCE_WAKEUP** is specified in *flags*, notification
>   * 		of new data availability is sent unconditionally.
>   * 		If **0** is specified in *flags*, an adaptive notification
