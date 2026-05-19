Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EE13B38BD;
	Tue, 19 May 2026 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225480; cv=none; b=DYQJ44vF9Oh+uBv5N45qpEu61R51u6YHrQLfmAjbimKZjxCSZOH3QSqNB3usN2j65T9xUBOAY/ZGQC5xjyQu1WBSEc/J829ldfgs6GJ96k1mtOq2kCQnpDY/H6rmbKQY41zprPRaG8wXPZD2MmUtwwX7AQa4TKM1lXcOf/PQPyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225480; c=relaxed/simple;
	bh=Su9tDBtM7VvIXb/HQqt7+6Jdi3+kRTrweS0dIhPzv2E=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=I/IAhFE/2idV9FeV4a6hSM3gHaroDrBbfAnrioD/4/GjodTxIn80jgp3YZ6Xoqjg6Rb4CxH+iT5ToaYswK0HtNRpVQoLpPLt2Y35XEdk0UV76LP8RJ051sNQOVIc7ZmL+wae7Cs1Pj7Wz+YcfdXHZ/mggK1I2PyspgU/rTj6wmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuOX5g6K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuOX5g6K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01AB1F000E9;
	Tue, 19 May 2026 21:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779225479;
	bh=NJnlMXPdjO6enWCpK12jdb1+fEkASNR2tfktv5lvRyI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FuOX5g6K3UrIRFeDg/dqRz7WwM0mrq+rrPr/EkG7myuLt1gaZNHq2NXoRy1YJOobU
	 AAG7PyXm9s5bp6fz6fWV45shBCXI243NWCNXDd5Z1jmlZRsBS8vwnE5LkcCCz3ajAe
	 zSsHLx1BQNZ4nUZHOFZE7VpflXXCXwhs8tl2cTOHDaln7UmYXXYx8buuV5dm1Rlr8n
	 HJuNyEr4kSuguSh1hTG2cxWRIegR+aG47dBs+rap8PaJVGYQjeq2btpo44nPsSShF0
	 7vr7dCsmGYImvIioPQCuQ4nevOI/f06AjNmtGR+QHGM99SLwnkWVEbC4jGps72aF78
	 WX1uy0DriP59A==
Content-Type: multipart/mixed; boundary="===============8270464743473171992=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9b0cf751b92976f9b7939086fb073612dde691543274b3588136e7b7566cb6e3@mail.kernel.org>
In-Reply-To: <20260519203858.1342507-1-arnd@kernel.org>
References: <20260519203858.1342507-1-arnd@kernel.org>
Subject: Re: [PATCH] bpf: avoid padding in struct bpf_common_attr
From: bot+bpf-ci@kernel.org
To: arnd@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,leon.hwang@linux.dev
Cc: arnd@arndb.de,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,kpsingh@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 19 May 2026 21:17:58 +0000 (UTC)

--===============8270464743473171992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index aec171ccb6ef..bec33bd807dd 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1506,6 +1506,7 @@ struct bpf_common_attr {
>  	__u32 log_size;
>  	__u32 log_level;
>  	__u32 log_true_size;
> +	__u32 __pad;
>  };

Song Liu raised an alternative approach in his review: could we use
'__attribute__((aligned(8)))' on the struct instead of adding an
explicit padding field?

https://lore.kernel.org/bpf/CAPhsuW60EONo84VkYbYsLHdAPzpfZ+ig8z=+M6NEhiNj_--qtQ@mail.gmail.com/

This design question hasn't been addressed in the discussion. Was this
alternative considered, and if so, what made the explicit padding approach
preferable?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26124721051
--===============8270464743473171992==--
